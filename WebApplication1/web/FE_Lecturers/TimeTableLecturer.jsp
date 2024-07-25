<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <title>Lecturer Timetable</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
            body {
                font-family: 'Roboto', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
            }
            header {
                background: #03ADD5;
                color: white;
                padding: 1rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 1rem;
                position: relative;
            }
            header a {
                position: absolute;
                right: 1rem;
                top: 1rem;
                color: white;
                text-decoration: none;
                font-size: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                background: #32CD32;
                transition: background-color 0.3s ease;
            }
            header a:hover {
                background-color: #228B22;
            }
            nav {
                background: #03ADD5;
                color: #fff;
                text-align: center;
                padding: 10px;
                border-radius: 10px;
                margin: 0 auto 1rem auto;
                width: 90%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            nav a {
                color: #fff;
                margin: 0 1rem;
                text-decoration: none;
                transition: color 0.3s ease;
            }
            nav a:hover {
                color: #FFD700;
            }
            form {
                display: inline-block;
                margin: 0.5rem;
            }
            button {
                background-color: #32CD32;
                color: white;
                padding: 0.5rem 1rem;
                border: none;
                cursor: pointer;
                border-radius: 20px;
                transition: background-color 0.3s ease;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 0.5rem;
            }
            button:hover {
                background-color: #228B22;
            }
            hr {
                border: 0;
                border-top: 2px dashed #03ADD5;
            }
            h3 {
                color: #333;
                text-align: center;
                margin-bottom: 1rem;
            }
            table {
                width: 90%;
                margin: 0 auto 1rem auto;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background: #fff;
                border-radius: 20px;
                overflow: hidden;
                border: 5px solid #03ADD5;
            }
            th, td {
                padding: 1rem;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #03ADD5;
                color: white;
                text-align: center;
            }
            tbody tr:last-child td {
                border-bottom: none;
            }
            tbody td:last-child {
                border-right: none;
            }
            .meal-table {
                width: 90%;
                margin: 0 auto 1rem auto;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background: #fff;
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            .meal-table th {
                background-color: #03ADD5;
                color: white;
                text-align: center;
            }
            .meal-table td {
                border-right: 1px solid #ddd;
                font-size: 16px;
            }
            @media (max-width: 768px) {
                body {
                    font-size: 14px;
                }
                nav {
                    text-align: center;
                    width: 100%;
                }
                table, .meal-table {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <h1>Lecturer Timetable</h1>
            <a href="lecturers-profile?lid=${sessionScope.lid}">Profile</a>
        </header>

        <hr/>

        <div style="text-align: center">
            <form action="addSchedules" method="GET">
                <input type="hidden" value="${sessionScope.csid}" name="csid"/>
                <button>Update Schedule</button>
            </form>
            <form action="historyOfLecturer" method="POST">
                <input type="hidden" value="${sessionScope.lid}" name="lid"/>
                <button>View History</button>
            </form>           
            <form action="liststudent" method="GET">
                <input type="hidden" value="${sessionScope.lid}" name="lid"/>
                <button>Evaluate Today's Session</button>
            </form>
        </div>
        <hr/>
        <h3>Today's Schedule on ${requestScope.dateNow}</h3>
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Time</th>
                    <th>Activity Name</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${requestScope.schedulesToDay != null}">
                    <c:set var="sch" value="${requestScope.schedulesToDay}"/>
                    <tr>
                        <td>Session ${sch.sdid.sessionNumber}</td>
                        <td>
                            <c:forEach items="${requestScope.curi}" var="c">
                                <c:if test="${sch.sdid.sdid == c.sdid.sdid}">
                                    ${c.timeStart} - ${c.timeEnd} <br>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach items="${requestScope.curi}" var="c">
                                <c:if test="${sch.sdid.sdid == c.sdid.sdid}">
                                    ${c.nameAct} <br>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${requestScope.schedulesToDay == null}">
                    <tr>
                        <td colspan="3"><h3>The lecturer has not updated the schedule for today.</h3></td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <h3>Today's Meals for Children</h3>
        <table class="meal-table">
            <thead>
                <tr>
                    <th>Meal</th>
                    <th>Dish</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${requestScope.menu}" var="m">
                    <tr>
                        <td>${m.mealID.mealName}</td>
                        <td>${m.menu}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
