<%-- 
    Document   : Session
    Created on : Jun 8, 2024, 2:53:14 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sessions List</title>
        <style>
            /* styles.css */

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 800px;
                margin: 50px auto;
                background: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            h1 {
                text-align: center;
                color: #333;
            }

            .sessions-list {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .session-link {
                display: block;
                background: #007bff;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                transition: background 0.3s;
            }

            .session-link:hover {
                background: #0056b3;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h1>Available Sessions</h1>
            <div class="sessions-list">
                <c:forEach var="session" items="${requestScope.list}">
                    <a href="session-detail?sid=${session.sid}" class="session-link">${session.sname}</a>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
