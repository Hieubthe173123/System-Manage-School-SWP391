<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Menu Today</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: skyblue;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
            color: #444;
        }

        h3 {
            text-align: center;
        }

        form {
            display: flex;
            justify-content: center;
            margin: 20px;
        }

        label {
            margin-right: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"],
        select {
            padding: 8px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        .table-container-wrapper {
            display: flex;
            justify-content: center;
            padding: 20px;
        }

        table {
            width: 60%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 2px solid #ccc; /* Add border around the table */
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
             border: 2px solid #ccc; /* Add border around the table */
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
             border: 2px solid #ccc; /* Add border around the table */
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .table-wrapper {
            text-align: center;
            margin: 20px;
        }

        .error-message, .success-message, .warning-message {
            text-align: center;
            font-size: 16px;
            padding: 10px;
            margin: 20px auto;
            width: 80%;
            border-radius: 4px;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .warning-message {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .center {
            text-align: center;
        }

        .select-column {
            width: 250px; /* Adjust this width as needed */
        }
    </style>
</head>
<body>
     <h1>Bữa ăn hôm nay ngày ${requestScope.dateN}</h1>
    <form action="searchMenu" method="GET">
        <label for="date">Chọn ngày:</label>
        <input type="date" id="date" name="date"/>
        <button type="submit">Submit</button>
    </form>

    <div style="text-align: center ; color: green">${sessionScope.Mess}</div>
    <div style="text-align: center ; color: orange">${sessionScope.Err}</div>
    <form action="menu" method="POST" class="center">
        <select name="ageid" onchange="this.form.submit()">
            <option value="0">Chọn lứa tuổi</option>
            <c:forEach items="${sessionScope.listAgeCategory}" var="a">
                <option value="${a.ageid}" ${a.ageid eq sessionScope.ageid ? 'selected' : ''}>${a.aname}</option>
            </c:forEach>
        </select>
    </form>

    <h3>Nếu bạn có thay đổi hoặc thêm danh sách món ăn thì hãy nhập vào đây</h3>

    <div class="table-container-wrapper">
        
        <table>
            <thead>
                <tr>
                    <th class="center">Bữa ăn</th>
                    <th class="center">Tên các món ăn</th>
                    <th class="select-column center">Chọn món ăn</th>           
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
                            <option value="0">Chọn món ăn</option>
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
        <div class="center">
            <button type="submit" name="save" value="1">Save</button>
        </div>
    </form>
    </div>
    
</body>
</html>
