<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Today's Menu</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
                color: #343a40;
            }

            header {
                background-color: #007bff;
                padding: 10px;
                text-align: center;
                color: white;
                font-size: 2em;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .btn {
                display: inline-block;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
                color: white;
                text-align: center;
            }

            .btn-primary {
                background-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-secondary {
                background-color: #6c757d;
            }

            .btn-secondary:hover {
                background-color: #545b62;
            }

            form {
                display: flex;
                justify-content: center;
                margin: 20px 0;
                gap: 10px;
            }

            label {
                font-weight: bold;
                color: #00796b;
            }

            input[type="date"],
            select {
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 16px;
            }

            .messages {
                text-align: center;
                margin: 20px auto;
                width: 80%;
                padding: 10px;
                border-radius: 5px;
                font-size: 16px;
            }

            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .table-container-wrapper {
                display: flex;
                justify-content: center;
                margin: 20px 0;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 15px;
                text-align: left;
                border: 1px solid #dee2e6;
            }

            th {
                background-color: #007bff;
                color: white;
                text-align: center;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e9ecef;
            }

            .center {
                text-align: center;
            }

            .select-column {
                width: 250px;
            }

            .btn-add-food {
                background-color: #28a745;
            }

            .btn-add-food:hover {
                background-color: #218838;
            }

        </style>
    </head>
    <body>
        <header>Today's Menu on ${requestScope.dateN}</header>

        <div class="container">
            <button class="btn btn-primary" onclick="window.location.href = 'adminhome'">Back</button>

            <form action="searchMenu" method="GET">
                <label for="date">Select date:</label>
                <input type="date" id="date" name="date"/>
                <button class="btn btn-primary" type="submit">Submit</button>
            </form>
            <c:if test="${sessionScope.Mess != null || sessionScope.Err != null}">
            <div class="messages">
                <div class="success-message">${sessionScope.Mess}</div>
                <div class="error-message">${sessionScope.Err}</div>
            </div>
</c:if>
            <button class="btn btn-add-food" onclick="window.location.href = 'food'">Add Food</button>

            <form action="menu" method="POST" class="center">
                <select name="ageid" onchange="this.form.submit()">
                    <option value="0">Select age group</option>
                    <c:forEach items="${sessionScope.listAgeCategory}" var="a">
                        <option value="${a.ageid}" ${a.ageid eq sessionScope.ageid ? 'selected' : ''}>${a.aname}</option>
                    </c:forEach>
                </select>
            </form>

            <h3 class="center">If you have changes or additions to the menu, please enter here</h3>

            <div class="table-container-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th class="center">Meal</th>
                            <th class="center">List Food</th>
                            <th class="select-column center">Select Food</th>           
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.listMeal}" var="m">
                        <form action="menu" method="POST">
                            <tr>
                            <input type="hidden" name="mealID" value="${m.mealID}"/>
                            <td class="select-column" style="text-align: center">${m.mealName}</td>
                            <td class="center">
                                <c:forEach items="${sessionScope.listMenuFood}" var="me">
                                    <c:if test="${m.mealID == me.mealid}">
                                        ${me.food.fname} <br/>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="select-column">
                                <select class="center" style="margin-left: 50px" name="foodid" onchange="this.form.submit()">
                                    <option value="0">Select Food</option>
                                    <c:forEach items="${requestScope.listFood}" var="f">
                                        <option value="${f.foodid}" ${f.foodid == requestScope.fid ? 'selected' : ''}>${f.fname}</option>
                                    </c:forEach>
                                </select>
                            </td>                    
                            </tr>
                        </form>
                    </c:forEach>
                    </tbody>
                </table>
                 <form action="menu" method="POST">
                     <div class="center" style="margin-top: 50px">
                    <button class="btn btn-primary" type="submit" name="save" value="1">Save</button>
                </div>
            </form>
            </div>

        </div>

           
    </body>
</html>
