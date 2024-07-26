<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Update Lecturers</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Fredoka One', cursive;
                padding-top: 40px; /* for Bootstrap navbar */
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: auto;
                overflow: hidden;
            }
            header {
                background: #03ADD5;
                color: #ffffff;
                padding-top: 30px;
                min-height: 70px;
                border-bottom: #FF9800 3px solid;
                text-align: center;
            }
            header a, header h1 {
                color: #ffffff;
                text-decoration: none;
                text-align: center;
                margin: 0;
                padding: 0;
                display: block;
            }
            .history-card {
                background: #ffffff;
                margin: 10px 0;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
            }
            .history-card h2 {
                color: #03ADD5;
                margin: 0 0 10px 0;
            }
            .history-card p {
                margin: 0 0 10px 0;
                color: #333333;
            }
            .btn-back {
                background-color: #41E0B3;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
                margin: 20px 0;
                display: block;
                text-align: center;
            }
            .btn-back:hover {
                background-color: #FF9800;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container">
                <h1>History Update Lecturers</h1>
                <button class="btn btn-back" onclick="window.location.href = 'history?yid=${param.yid}'">Back</button>
            </div>
        </header>
        <div class="container">
            <c:forEach items="${requestScope.history}" var="his">
                <div class="history-card">
                    <h2>Lecturer: ${his.lid.lname}</h2>
                    <p>Class: ${his.csid.classID.clname}</p>
                    <p>Status: <c:choose>
                            <c:when test="${his.status != null && !his.status.isEmpty()}">${his.status}</c:when>
                            <c:otherwise>Modified</c:otherwise>
                        </c:choose></p>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
