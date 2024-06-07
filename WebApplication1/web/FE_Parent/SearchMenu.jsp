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
            .table-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px; /* Adjust the gap as needed */
                justify-content: center; /* Center the tables horizontally */
                padding: 20px; /* Optional: Add padding to the container */
            }

            .table-container table {
                display: inline-block;
                margin-bottom: 20px; /* Adjust the margin as needed */
                border-collapse: collapse;
            }

            .table-container th, .table-container td {
                padding: 8px;
                text-align: left;
            }

            /* Optional: Style for the container holding each table and heading */
            .table-wrapper {
                text-align: center; /* Center align the heading */
            }
            .table-container-wrapper {
                display: flex;
                justify-content: center;
                padding: 20px;
            }

            .table-container th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h2 style="text-align: center"> Bữa ăn ngày ${requestScope.date_raw} của các bé</h2>
        <button><a href="menu" style="text-decoration: none">Quay lại</a></button>
        <c:if test="${requestScope.listMenu != null}">
                <div class="table-container">
                    <c:forEach items="${requestScope.listAgeCategory}" var="age">
                    <div>
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
        </c:if>
        
    </body>
</html>
