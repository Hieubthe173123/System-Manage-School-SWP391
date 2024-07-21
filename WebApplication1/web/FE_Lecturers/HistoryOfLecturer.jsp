<%-- 
    Document   : HistoryOfLecturer
    Created on : Jun 24, 2024, 11:09:53 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                font-family: 'Roboto', cursive;
                margin: 0;
                padding: 0;
                background-color: #fffae6;
                color: #333;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            h1, h3 {
                color: #333;
                text-align: center;
                margin-top: 20px;
            }
            .form-container {
                max-width: 600px;
                width: 100%;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            select, button {
                display: block;
                width: 100%;
                margin: 10px 0;
                padding: 10px;
                font-size: 16px;
                border: 2px solid #03ADD5;
                border-radius: 10px;
                background-color: #fffae6;
            }
            button {
                background-color: #03add5;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #45a049;
            }
            .col {
                max-width: 1000px;
                width: 100%;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            .return-link {
                text-decoration: none;
                color: white;
                font-size: 14px;
            }
            .return-button {
                display: inline-block;
                padding: 5px 10px;
                width: auto;
                background-color: #03add5;
                color: white;
                border: none;
                border-radius: 10px;
                text-align: center;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
                margin: 20px 0;
            }
            .return-button:hover {
                background-color: #45a049;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            th, td {
                padding: 10px;
                border: 2px solid black;
                text-align: center;
            }
            th {
                background-color: #03ADD5;
                color: white;
                font-size: 18px;
            }
            td {
                font-size: 16px;
            }
            .button-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 1rem;
                width: 100%;
            }
            .button-container a {
                font-size: 16px;
                text-decoration: none;
                color: white;
            }
            button a {
                text-decoration: none;
                color: white;
                display: inline-block;
            }
        </style>
    </head>
    <body>
        <h1>Lecturer's History</h1>
        <div class="button-container">
            <button class="return-button">
                <a href="timeTableLecturer?lid=${sessionScope.lid}" class="return-link">Back</a>
            </button>
        </div>
        <div class="form-container">
            <form action="historyOfLecturer" method="POST">
                <input type="hidden" name="lid" value="${requestScope.lid}"/>
                <select name="yidHistoty" onchange="this.form.submit()">
                    <option value="0">Select Academic Year</option>
                    <c:forEach items="${requestScope.listYid}" var="s">
                        <option value="${s.yid.yid}" ${s.yid.yid == requestScope.yidH ? 'selected' : ''}>
                            ${s.yid.dateStart} - ${s.yid.dateEnd}
                        </option>
                    </c:forEach>
                </select>
                <select name="schedulesID">
                    <option value="0">Select Date</option>
                    <c:forEach items="${requestScope.listSche}" var="s">
                        <option value="${s.scheID}" ${s.scheID == requestScope.schID ? 'selected' : ''}>
                            ${s.date}
                        </option>
                    </c:forEach>
                </select>
                <button type="submit">Search</button>
            </form>
        </div>
        <c:if test="${requestScope.yidChoose.dateStart != null && requestScope.yidChoose.dateEnd != null}">
            <h3>Teaching schedule of ${requestScope.className} by ${requestScope.lec.lname} for the year ${requestScope.yidChoose.dateStart} - ${requestScope.yidChoose.dateEnd}</h3>
        </c:if>
        <c:if test="${requestScope.yidChoose.dateStart == null && requestScope.yidChoose.dateEnd == null}">
            <h3>Please select an academic year</h3>
        </c:if>
        <div class="col">
            <table border="2" class="activity-table">
                <thead>
                    <tr>
                        <th>Time Slot</th>
                        <th>Activity</th>
                        <th>Fixed Activity</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.curiculum}" var="c">
                        <tr>
                            <td>${c.timeStart} - ${c.timeEnd}</td>
                            <td>${c.nameAct}</td>
                            <c:if test="${c.isFix eq true}">
                                <td>Fixed</td>
                            </c:if>
                            <c:if test="${c.isFix != true}">
                                <td>Not Fixed</td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
