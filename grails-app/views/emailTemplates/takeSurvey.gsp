<%--
  Created by IntelliJ IDEA.
  User: arnold
  Date: 7/21/13
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html" %>
<html>
<head>
  <title></title>

</head>
<body>

    <table>
        <thead>
            <tr>
                <th>
                    <div style="width: 100%; height:60px; background-color: #bad33c; color: #ffffff; padding: 10px 20px 5px 2px; vertical-align: middle">
                        <img src="http://ticbox.herokuapp.com/static/images/ticbox/TicBoxLogo.png" width="300px" height="50px" alt="TicBox">
                    </div>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <pre style="font-size: larger;">

Hi ${fullname?:'Respondent'},


We have a new survey for you to participate, '${surveyName}'
Please take the <a href="http://localhost:8080${link}">Survey</a>

                    </pre>
                </td>
            </tr>
        </tbody>
    </table>

</body>
</html>