<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Today's Menu</title>
        <style>
            body {
                font-family: 'Comic Sans MS', cursive, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
                color: #333;
            }

            header {
                background-color: #33B7CE;
                padding: 20px;
                text-align: center;
                color: white;
                font-size: 2.5em;
                font-weight: bold;
            }

            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .btn {
                display: inline-block;
                padding: 10px 20px;
                border: none;
                border-radius: 25px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                text-decoration: none;
                color: white;
                text-align: center;
                margin: 10px 5px;
            }

            .btn-primary {
                background-color: #33B7CE;
            }

            .btn-primary:hover {
                background-color: #25CFC7;
            }

            .btn-add-food {
                background-color: #33B7CE;
            }

            .btn-add-food:hover {
                background-color: #25CFC7;
            }

            form {
                display: flex;
                justify-content: center;
                align-items: center;
                margin: 20px 0;
                gap: 10px;
            }

            label {
                font-weight: bold;
                color: black;
            }

            input[type="date"],
            select {
                padding: 10px;
                border: 1px solid #33B7CE;
                border-radius: 10px;
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
                border-collapse: separate;
                border-spacing: 0;
                margin-bottom: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                border-radius: 15px;
                overflow: hidden;
                background-color: #fff;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border: 1px solid #dee2e6;
            }

            th {
                background-color: #03a9f4;
                color: white;
                text-align: center;
                font-size: 1.2em;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #e0f7fa;
            }

            td {
                border-radius: 10px;
            }

            th {
                border-radius: 10px 10px 0 0;
            }

            tbody tr:first-child td {
                border-top: none;
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            tbody td:last-child {
                border-right: none;
            }

            .center {
                text-align: center;
            }

            .select-column {
                width: 250px;
            }

            /* Add border-radius to table container */
            .table-container-wrapper {
                border-radius: 15px;
                overflow: hidden;
                border: 1px solid #ddd;
                background-color: #fff;
            }
        </style>

    </head>
    <body>
        <header>Today's Menu on ${requestScope.dateN}</header>

        <div class="container">
            <div class="center">
                <button class="btn btn-primary" onclick="window.location.href = 'searchMenu?date=${sessionScope.dateN}'">Back</button>
                <button class="btn btn-add-food" onclick="window.location.href = 'food'">Add Food</button>
            </div>

            <form action="searchMenu" method="GET">
                <label for="date">Select date:</label>
                <input type="date" id="date" name="date"/>
                <button class="btn btn-primary" type="submit">Submit</button>
            </form>

            <c:if test="${sessionScope.Mess != null || sessionScope.Err != null}">
                <div class="messages">
                    <c:if test="${sessionScope.Mess != null}">
                        <div class="success-message">${sessionScope.Mess}</div>
                    </c:if>
                    <c:if test="${sessionScope.Err != null}">
                        <div class="error-message">${sessionScope.Err}</div>
                    </c:if>
                </div>
            </c:if>

            <form action="menu" method="POST" class="center">
                <label for="date">Select Age:</label>
                <select name="ageid" onchange="this.form.submit()">
                    <option value="0">Select age group</option>
                    <c:forEach items="${sessionScope.listAgeCategory}" var="a">
                        <option value="${a.ageid}" ${a.ageid eq sessionScope.ageid ? 'selected' : ''}>${a.aname}</option>
                    </c:forEach>
                </select>
            </form>

            <h3 class="center">If you have changes or additions to the menu, please enter here</h3>
            <form action="menu" method="POST">
                <div class="center" style="margin-top: 50px">
                    <button class="btn btn-primary" type="submit" name="save" value="1">Save</button>
                </div>
            </form>

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
            </div>
        </div>
    </body>
</html>
