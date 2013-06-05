<%@ page import="ticbox.ProfileItem; ticbox.Survey" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="TicBOX"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/jquery-ui-1.10.2/css/smoothness', file: 'jquery-ui-1.10.2.custom.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap.css')}" type="text/css">

    <style type="text/css">

        body {
            padding-top: 65px;
            font-family: helveticaneue-light,tahoma,sans-serif;
            letter-spacing: 0.1em;
            color: #5a5a5a;
        }

        textarea, input[type=text] {
            background-color: #f5f5f5;
        }

        textarea:focus, input[type=text]:focus {
            background-color: #ffffff;
        }

        .clickable {
            cursor: pointer;
        }

        .line {
            clear: both;
            min-height: 1px;
            margin-bottom: 5px;
        }

        .rowLine10 {
            display: inline-block;
            margin-bottom: 10px;
        }

        .rowLine5 {
            display: inline-block;
            margin-bottom: 5px;
        }

        .rowLine2 {
            display: inline-block;
            margin-bottom: 2px;
        }

        .col {
            float: left;
            min-height: 1px;
        }

        .col2 {
            margin-right: 2px;
        }

        .col5 {
            margin-right: 5px;
        }

        .col10 {
            margin-right: 10px;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }

        .navbar-inverse .navbar-text, .navbar-inverse .navbar-link {
            color: #ffffff;
            padding-top: 10px;
        }

        .navbar-inverse .navbar-inner {
            background-color: #BAD33C;
            background-image: -moz-linear-gradient(top, #BAD33C, #7F9B09);
            background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#BAD33C), to(#7F9B09));
            background-image: -webkit-linear-gradient(top, #BAD33C, #7F9B09);
            background-image: -o-linear-gradient(top, #BAD33C, #7F9B09);
            background-image: linear-gradient(to bottom, #BAD33C, #7F9B09);
            border: 0;
            -webkit-box-shadow: 0px 0px 10px #000000;
            box-shadow: 0px 0px 10px #000000;
            -moz-box-shadow: 0px 0px 10px #000000;
            color: #ffffff;
        }

        .navbar-inverse .nav > li > a  {
            color: #ffffff;
            height: 30px;
            padding-top: 20px;
            padding-bottom: 0;
        }

        .navbar .nav > .active > a,
        .navbar .nav > .active > a:hover,
        .navbar .nav > .active > a:focus,
        .navbar .nav > li > a:hover {
            background: transparent;
            -webkit-box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
            -moz-box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 8px rgba(0, 0, 0, 0.125);
        }

        #main-container {
            width: 1024px;
            margin: 5px auto;
        }

        #menuNavPanel {
            width: 300px;
            margin-left: 0;
        }

        #menuNavPanel .side-panel {
            width: 300px;
            -webkit-box-shadow: 0 5px 17px -7px #7F9B09;
            -moz-box-shadow: 0 5px 17px -7px #7F9B09;
            box-shadow: 0 5px 17px -7px #7F9B09;
            margin-bottom: 15px;
            padding-bottom: 7px;
            /*border-right: #7F9B09 solid 1px;*/
        }

        #menuNavPanel .side-panel .line {
            padding-left: 5px;
        }

        #mainContentPanel {
            width: 720px;
            margin-left: 10px;
        }

        .control-label {
            /*text-align: left !important;*/
        }

        .summary-header {
            /*background-color: #565655;*/
            margin-bottom: 10px;
        }

        .summary-body {
            /*background-color: #a0a0a0;*/
        }

        .preview-item-even {
            background-color: #ececec;
        }

        [class*="span"] {
            float: left;
        }

    </style>

    <link rel="stylesheet" href="${resource(dir: 'frameworks/bootstrap/css', file: 'bootstrap-responsive.css')}" type="text/css">

    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-1.9.1.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/jquery-ui-1.10.2/js', file: 'jquery-ui-1.10.2.custom.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'frameworks/bootstrap/js', file: 'bootstrap.js')}"></script>

    <g:layoutHead/>
    <r:layoutResources />

</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="${request.contextPath}/">
                <img src="../images/ticbox/TicBoxLogo.png" width="200" height="100">
            </a>
            <div class="nav-collapse collapse">
                <p class="navbar-text pull-right">
                    Logged in as <a href="#" class="navbar-link"><strong>Username</strong></a>
                </p>
                <ul class="nav">
                    <li class="index"><a href="${request.contextPath}/survey/index">Survey Type</a></li>
                    <li class="respondentFilter"><a href="${request.contextPath}/survey/respondentFilter">Respondent Filter</a></li>
                    <li class="surveyGenerator"><a href="${request.contextPath}/survey/surveyGenerator">Create Survey</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="main-container">
    <div class="row" style="margin-left: -10px;">
        <div id="menuNavPanel" class="col" style="position: fixed;">
            %{--menu navigation panel--}%
            <div class="survey-summary line side-panel">
                <div class="line">
                    <legend class="summary-header">Survey Summary : </legend>
                </div>
                <div class="line">
                    Total : Rp. 3,200,000.00,-
                </div>
                <div class="line">
                    Rp. 15,000.00,- x 200 Respondents
                </div>
            </div>

            <div class="line side-panel">
                <div class="line">
                    <legend class="summary-header">Filter Details : </legend>
                </div>
                <div class="filter-details-container line">

                </div>
            </div>

        </div>
        <div id="mainContentPanel" class="col" style="margin-left: 310px;">
            <g:layoutBody/>
        </div>
    </div>

    %{--<footer>
        &copy; TicBOX 2013
    </footer>--}%

</div>

<r:layoutResources />

<script type="text/javascript">

    jQuery(function(){

        jQuery(".nav > li.${actionName}").addClass('active');

        //jQuery('#menuNavPanel .survey-summary').before(jQuery('#menuNavPanelContent'));
        jQuery('#menuNavPanel').append(jQuery('#menuNavPanelContent'));

        jQuery('.datePicker').datepicker({
            showAnim : 'slideDown',
            format : '<g:message code="app.date.format.js" default="dd/mm/yy"/>'
        });

        loadRespondentFilter();

    });

    function loadRespondentFilter(){
        jQuery.getJSON('${request.contextPath}/survey/getRespondentFilter', {}, function(respondentFilter){
            if(respondentFilter){
                jQuery('.filter-details-container').empty();

                jQuery.each(respondentFilter, function(idx, filter){

                    var filterContent = null;

                    switch(filter.type){

                        case '${ProfileItem.TYPES.STRING}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.val);

                            break;

                        case '${ProfileItem.TYPES.NUMBER}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.valFrom + ' - ' + filter.valTo);

                            break;

                        case '${ProfileItem.TYPES.CHOICE}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>');
                            var ul = jQuery('<ul></ul>');

                            jQuery.each(filter.checkItems, function(idx, item){
                                ul.append(jQuery('<li></li>').append(item));
                            });

                            filterContent.append(ul);

                            break;

                        case '${ProfileItem.TYPES.LOOKUP}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>');
                            var ul = jQuery('<ul></ul>');

                            jQuery.each(filter.checkItems, function(idx, item){
                                ul.append(jQuery('<li></li>').append(item));
                            });

                            filterContent.append(ul);

                            break;

                        case '${ProfileItem.TYPES.DATE}' :

                            filterContent = jQuery('<div style="margin-left: 15px"></div>').append(filter.valFrom + ' - ' + filter.valTo);

                            break;

                        default :

                            break;

                    }

                    jQuery('.filter-details-container').append(jQuery('<div class="line"><div>')
                            .append(jQuery('<label></label>').append(filter.label + ' : '))
                            .append(filterContent)
                    );

                });

            }else{
                //TODO no survey fetched
            }

        });
    }

</script>

</body>
</html>
