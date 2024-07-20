<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Table</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                font-family: 'Fredoka One', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
            }

            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #f1f1f1;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                position: relative;
                top: 20px;
            }

            h1, h2 {
                color: #333;
            }

            .section {
                margin-bottom: 30px;
            }

            table {
                width: 100%;
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
            }

            tbody tr:nth-child(even), .meal-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tbody tr:hover, .meal-table tr:hover {
                background-color: #f1f1f1;
            }

            nav {
                background: #03ADD5;
                color: #fff;
                text-align: center;
                padding: 10px;
                border-radius: 10px;
                width: 6%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
                display: flex;
                align-items: flex-end;
                margin-bottom: 20px;
                margin-left: 1200px;
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

            select {
                padding: 0.5rem;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                margin-right: 10px;
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
                margin-left: 10px;
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

            .meal-table th {
                background-color: #03ADD5;
                color: white;
                text-align: center;
            }

            .meal-table td {
                border-right: 1px solid #ddd;
                font-size: 16px;
            }

            .row {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .col {
                flex: 1;
                margin: 0 10px;
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
                .row {
                    flex-direction: column;
                }
                .col {
                    margin: 10px 0;
                }
            }

            .feedback-box {
                background-color: #ffffff;
                border: 2px solid #03ADD5;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin: 20px auto;
                max-width: 800px;
                text-align: left;
            }

            .feedback-box h2 {
                color: #6A83BD;
                margin-top: 0;
            }

            .feedback-box p {
                color: #333;
                font-size: 18px;
                line-height: 1.6;
            }

        </style>
    </head>
    <body>
        <c:if test="${requestScope.role == 1}">
            <div class="container">
                <nav>
                    <a href="parent-profile">Profile</a>
                </nav>
                <h2>Child's Activities and Meals Information for ${requestScope.student.sname}</h2>
                <form action="timetable" method="post">
                    <select name="stuid" onchange="this.form.submit()">
                        <c:forEach items="${requestScope.list}" var="s">
                            <option value="${s.stuid}" ${s.stuid == requestScope.student.stuid ? 'selected' : ''}>${s.sname}</option>
                        </c:forEach>
                    </select>
                </form>
                <div style="display: flex; justify-content: end; margin-bottom: 20px;">
                    <form action="timetable" method="post">
                        <input type="hidden" name="stuid" value="${sessionScope.studenId}"/>
                        <select name="yidHistoty" onchange="this.form.submit()">
                            <option>Select Academic Year</option>
                            <c:forEach items="${requestScope.listYidInHistory}" var="s">
                                <option value="${s.csid.yid.yid}" ${s.csid.yid.yid == requestScope.yidH ? 'selected' : ''}>${s.csid.yid.dateStart} - ${s.csid.yid.dateEnd}</option>
                            </c:forEach>
                        </select>
                        <select name="schedulesID">
                            <option value="0">Select Date</option>
                            <c:forEach items="${requestScope.listSch}" var="s">
                                <option value="${s.scheID}">${s.date}</option>
                            </c:forEach>
                        </select>
                        <button type="submit">Search</button>
                    </form>
                </div>
                <div class="row">
                    <div class="col">
                        <table border="2" class="activity-table">
                            <thead>
                                <tr>
                                    <th>Time Slot</th>
                                    <th>Activity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.curiculum}" var="c">
                                    <tr>
                                        <td>${c.timeStart} - ${c.timeEnd}</td>
                                        <td>${c.nameAct}</td>
                                    </tr>            
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col">
                        <h2>Today's Meals for ${requestScope.student.sname}</h2>
                        <table border="2" class="meal-table">
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
                    </div>
                </div>
                <div class="feedback-box">
                    <h2>Teacher's Feedback on the Class</h2>
                    <p>${requestScope.feedback.fcontent}</p>
                </div>
            </div>
        </c:if>
    </body>
</html>
