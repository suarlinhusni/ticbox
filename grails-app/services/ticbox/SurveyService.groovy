package ticbox

import com.mongodb.BasicDBObject
import com.mongodb.DBObject
import org.bson.types.ObjectId
import org.codehaus.groovy.grails.web.util.WebUtils

class SurveyService {

    def surveyorService
    def helperService
    def emailBlasterService
    def servletContext

    def surveyList(){

        return Survey.findAllBySurveyor(surveyorService.getCurrentSurveyor())
    }

    Survey createSurvey(def params){
        SurveyorProfile surveyor = surveyorService.getCurrentSurveyor()

        Survey survey = new Survey(surveyId: UUID.randomUUID().toString(), name: params.surveyName, surveyor: surveyor).save();

        WebUtils.retrieveGrailsWebRequest().session.putAt('current-edited-survey-id', survey?.surveyId)

        return survey
    }

    Survey getCurrentEditedSurvey(){
        //TODO should be fetching from current surveyor's edited survey
        def surveyId = WebUtils.retrieveGrailsWebRequest().session.getAt('current-edited-survey-id')
        Survey survey = surveyId?Survey.findBySurveyId("${surveyId}"):null

        //TODO should be fetching from global conf and keep save per survey for locking
        /*survey[Survey.COMPONENTS.SUMMARY_DETAIL] = com.mongodb.util.JSON.parse(
        """{
            chargePerRespondent : "15000",
                totalRespondent : "200"
        }""")*/

        return survey
    }

    def getSurveyForRespondent(String surveyId) {
        return Survey.findBySurveyId(surveyId)
    }

    def getProfileItemsForRespondentFilter(){
        return ProfileItem.list()?.sort{it.seq}
    }

    def submitRespondentFilter(String filterItemsJSON, String surveyType, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(filterItemsJSON)

            survey[Survey.COMPONENTS.RESPONDENT_FILTER] = dbObject
            survey.type = surveyType

            survey.save()
        }
    }

    def submitSurvey(def params, Survey survey){
        if (survey) {
            DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(params.questionItems)

            survey[Survey.COMPONENTS.QUESTION_ITEMS] = dbObject
            survey.title = params.surveyTitle

            if(params.logoResourceId){
                def userResource = UserResource.findById(new ObjectId(params.logoResourceId))
                if (userResource) {
                    survey[Survey.COMPONENTS.LOGO] = userResource.id
                }
            }

            survey.save()
        }
    }

    def finalizeAndPublishSurvey(def params, Survey survey){

        switch (survey.type){
            case Survey.SURVEY_TYPE.EASY :

                def filteredRespondents = getFilteredRespondents(survey)

                def recipients = []

                if (filteredRespondents){

                    String notifCode = "ps_${survey.id}"

                    //TODO find a way for bulky insert
                    for (RespondentDetail profile : filteredRespondents){
                        new UserNotification(
                            title: "New survey : ${survey.name}",
                            code: notifCode,
                            username: profile['username'],
                            actionLink: "/respondent/takeSurvey?surveyId=${survey.surveyId}"
                        ).save()

                        recipients << [
                            email : profile['email'],
                            fullname : profile['username'] //TODO RespondentProfile should consists full name
                        ]
                    }

                    String link = "${servletContext.contextPath}/userNotification?code=${notifCode}"

                    //TODO should be sending bulk emails personally
                    emailBlasterService.blastEmail(recipients, 'takeSurvey', 'Take a survey', [link:link, surveyName: survey.name])

                }


                break
            case Survey.SURVEY_TYPE.FREE :

                break
        }

        survey.status = Survey.STATUS.IN_PROGRESS
        survey.save()

    }

    def getFilteredRespondents(Survey survey){

        def profiles = RespondentDetail.createCriteria().list {
            survey[Survey.COMPONENTS.RESPONDENT_FILTER]?.each{filter ->

                switch(filter.type){
                    case ProfileItem.TYPES.CHOICE :

                        or {
                            filter.checkItems?.each{item ->
                                like "profileItems.${filter.code}",  "%${item instanceof Map ? item.key : item}%"
                            }
                        }

                        break

                    case ProfileItem.TYPES.DATE :

                        gte "profileItems.${filter.code}", Date.parse(helperService.getProperty('app.date.format.input', 'dd/MM/yyyy'), filter.valFrom).getTime()
                        lte "profileItems.${filter.code}", Date.parse(helperService.getProperty('app.date.format.input', 'dd/MM/yyyy'), filter.valTo).getTime()

                        break

                    case ProfileItem.TYPES.LOOKUP :

                        or {
                            filter.checkItems?.each{item ->
                                like "profileItems.${filter.code}",  "%${item.key}%"
                            }
                        }

                        break

                    case ProfileItem.TYPES.NUMBER :

                        gte "profileItems.${filter.code}", Double.valueOf(filter.valFrom)
                        lte "profileItems.${filter.code}", Double.valueOf(filter.valTo)

                        break

                    case ProfileItem.TYPES.STRING :

                        like "profileItems.${filter.code}", "%${filter.val}%"

                        break

                    default :

                        break

                }

            }
        }

        return profiles
    }

    def saveResponse(String responseJSON, String surveyId, String respondentId){
        SurveyResponse surveyResponse = SurveyResponse.findBySurveyIdAndRespondentId(surveyId, respondentId) ?: new SurveyResponse(surveyId: surveyId, respondentId: respondentId).save()
        DBObject dbObject = (DBObject) com.mongodb.util.JSON.parse(responseJSON)
        surveyResponse["response"] = dbObject
        surveyResponse.save()
    }

}
