<html>
<head>
    <meta name="layout" content="respondent"/>
    <title>Survey List</title>
    <style type="text/css">
        .survey-row {
            margin: 1em 0em;
            display: flex;
            display: -webkit-flex;
            display: -moz-flex;
            min-width: 100%;
        }

        .survey-img-box {
            float: left;
            background-color: #EFEFEF;
            padding:0.5em;
            width: 14%;
        }

        .survey-content-box {
            float: left;
            background-color: #dddddd;
            padding:0.5em;
            width: 67%;
            position: relative;
            margin-left: 5px;
            margin-right: 5px;
        }

        .survey-nav-box {
            float: right;
            background-color: #EFEFEF;
            padding:0.5em;
            text-align: center;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        pre {
            margin: 0;
            padding: 0;
            font-family: inherit;
            font-size: inherit;
            color: inherit;
            -webkit-border-radius: 0;
            -moz-border-radius: 0;
            border-radius: 0;

            display: block;
            line-height: inherit;
            word-break: normal;
            word-wrap: normal;
            background-color: inherit;
            border: 0;
            border: 0;
        }
    </style>
</head>
<body>
        <div id="surveyHeader" class="module-header">
            <div class="title">Survey List</div>
        </div>
        <div id="surveyList" class="module-content">
            <g:if test="${surveyList}">
                <g:each in="${surveyList}" var="survey">
                    <div class="row-fluid">
                        <div class="survey-row">
                            <div class="survey-img-box clickable" style="background: #4f4f4f url('../images/skin/survey-default-icon.png') no-repeat center; background-size: 70% 70%;">
                                <g:link action="takeSurvey" params="[surveyId:survey.surveyId]">
                                    <img src="${request.contextPath}/respondent/viewSurveyLogo?surveyId=${survey.surveyId}" style="" width="100%" height="100%">
                                </g:link>
                            </div>
                            <div class="survey-content-box">
                                <div style="font-size:20px; font-weight: bold;">
                                    ${survey.name}
                                </div>
                                <div style="overflow: auto; text-overflow: ellipsis; height: 4.3em; font-size: 12px; line-height: 16px; padding: 0.5em 0 0 0;">
                                    <pre>${survey.title}</pre>
                                </div>
                                <div style="float: left; position: absolute; bottom: 0.5em; width: 97%;">
                                    <div style="position: relative;">
                                        <g:if test="${ticbox.Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)}">
                                            <div style="">
                                                <b>Respondent needed: 0</b>
                                            </div>
                                            <div style="right: 0; top: 0; position: absolute;">
                                                <b>Completion 100%</b>
                                            </div>
                                        </g:if>
                                    </div>
                                </div>
                            </div>
                            <div class="survey-nav-box">
                                <div style="padding: 0.5em; float: left;">
                                    <g:if test="${ticbox.Survey.POINT_TYPE.GOLD.equalsIgnoreCase(survey.pointType)}">
                                        <div class="gold" style="padding: 0 0 5px">earn</div>
                                        <div style="font-size:30px; color: #333333;padding: 0 0 5px;"><b>${survey.point}</b></div>
                                        <div class="gold"><b>${survey.pointType}</b> points</div>
                                    </g:if>
                                    <g:else>
                                        <div class="trust" style="padding: 0 0 5px">earn</div>
                                        <div style="font-size:30px; color: #333333;padding: 0 0 5px;">${survey.point}</div>
                                        <div class="trust"><b>${survey.pointType}</b> points</div>
                                    </g:else>
                                </div>
                                <div style="float:left; text-transform: uppercase; background-color: #BAD33C;padding: 0.5em; font-size: 12px;">
                                    <b><g:link action="takeSurvey" params="[surveyId:survey.surveyId]">Take Survey</g:link></b>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:each>
            </g:if>
            <g:else>
                <div class="module-message">There is no survey at the moment..</div>
            </g:else>
        </div>
</body>
</html>