<%-- 
    Document   : SearchMenu
    Created on : Jun 5, 2024, 10:06:30 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Menu</title>
        <style>
            body {
                font-family: 'Comic Sans MS', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #FFFAF0;
                color: #333;
            }

            h2 {
                text-align: center;
                margin-top: 20px;
                font-size: 2em;
            }

            .button-container {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin: 20px 0;
            }

            .button-container button {
                background-color: #03add5;
                border: none;
                border-radius: 20px;
                color: #fff;
                cursor: pointer;
                padding: 10px 20px;
                font-size: 1em;
                transition: background-color 0.3s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .button-container button:hover {
                background-color: #ff4d4d;
            }

            .button-container button a {
                color: #fff;
                text-decoration: none;
            }

            .table-container-wrapper {
                display: flex;
                justify-content: center;
                padding: 20px;
            }

            .table-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: center;
                padding: 20px;
            }

            .table-wrapper {
                background-color: #fff;
                border-radius: 15px;
                overflow: hidden;
                padding: 20px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 300px; /* Adjust the width as needed */
            }

            .table-wrapper h3 {
                font-size: 1.5em;
                color: #03add5;
                margin-bottom: 10px;
            }

            .table-wrapper table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .table-wrapper th, .table-wrapper td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .table-wrapper th {
                background-color: #03add5;
                color: white;
            }

            .table-wrapper td {
                background-color: #f9f9f9;
                color: #333;
            }

            @media (max-width: 768px) {
                .table-container {
                    flex-direction: column;
                    align-items: center;
                }
            }
        </style>
    </head>
    <body>
        <h2>Meals for Children on ${requestScope.date_raw}</h2>
        <div class="button-container">
            <button onclick="window.location.href = 'adminhome'">Back to Home</button>
            <button><a href="menu">Enter Today's Meals for All Ages</a></button>
        </div>

        <c:if test="${requestScope.listMenu != null}">
            <div class="table-container-wrapper">
                <div class="table-container">
                    <c:forEach items="${requestScope.listAgeCategory}" var="age">
                        <div class="table-wrapper">
                            <h3>Meals for ${age.aname}</h3>
                            <table border="0">
                                <thead>
                                    <tr>
                                        <th>Meal</th>
                                        <th>Food Names</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.listMenu}" var="m">
                                        <c:if test="${age.ageid == m.ageid.ageid}">
                                            <tr>
                                                <td>${m.mealID.mealName}</td>
                                                <td>${m.menu}</td>
                                                <td>${m.date}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </body>
</html>
