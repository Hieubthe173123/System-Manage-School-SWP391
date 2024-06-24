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
                background-color: skyblue;
                font-family: Arial, sans-serif;
                color: #fff;
                margin: 0;
                padding: 0;
            }

            h2 {
                text-align: center;
                margin-top: 20px;
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

            .table-container .table-wrapper {
                background-color: rgba(255, 255, 255, 0.2);
                border-radius: 10px;
                overflow: hidden;
                padding: 10px;
                text-align: center;
                width: 300px; /* Adjust the width as needed */
            }

            .table-container table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            .table-container th, .table-container td {
                padding: 8px;
                text-align: left;
            }

            .table-container th {
                background-color: #f2f2f2;
                color: #333;
            }

            .table-container td {
                background-color: white;
                color: #000;
            }

            button a {
                color: #fff;
                text-decoration: none;
            }

            button {
                background-color: #00b8ec;
                border: none;
                border-radius: 5px;
                color: #fff;
                cursor: pointer;
                display: block;
                margin: 20px auto;
                padding: 10px 20px;
                text-align: center;
            }

            button:hover {
                background-color: #555;
            }
        </style>
    </head>
    <body>
        <h2>Bữa ăn ngày ${requestScope.date_raw} của các bé</h2>
        <button><a href="menu">Quay lại</a></button>
        <c:if test="${requestScope.listMenu != null}">
            <div class="table-container-wrapper">
                <div class="table-container">
                    <c:forEach items="${requestScope.listAgeCategory}" var="age">
                    <div class="table-wrapper">
                        <h3>Bữa ăn của ${age.aname}</h3>
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Bữa ăn</th>
                                    <th>Tên các món ăn</th>
                                    <th>Ngày</th>
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
