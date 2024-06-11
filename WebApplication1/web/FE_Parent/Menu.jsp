<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Today</title>
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
        <h1>Nhà bếp hôm nay có gì</h1>
        <form action="searchMenu" method="GET">
            <label for="date">Nhập ngày:</label>
            <input type="text" id="datetext" name="date" placeholder="'2024-01-01'"/>
            <br/>
            <button type="submit">Submit</button>
        </form>
        <form action="searchMenu" method="GET">
            <label for="date">Chọn ngày:</label>
            <input type="date" id="date" name="date"/>
            <br/>
            <button type="submit">Submit</button>
        </form>
        <h3 style="color: red">${sessionScope.Noti}</h3>
        <h1>Bữa ăn hôm nay</h1>
        <h3 style="color: red">${sessionScope.Mess}</h3>
        <h3 style="color: red">${sessionScope.Err}</h3>
        <h3 style="color: red">${sessionScope.warn}</h3>
        <form action="menu" method="Post">
            <select name="ageid" onchange="this.form.submit()">
                <option value="0">Chọn lứa tuổi</option>
                <c:forEach items="${sessionScope.listAgeCategory}" var="a">
                    <option value="${a.ageid}" ${a.ageid eq sessionScope.ageid ? 'selected' : ''}>${a.aname}</option>
                </c:forEach>
            </select>
        </form>

        <c:if test="${fn:length(sessionScope.listMenu) > 0 }">
            <div class="table-container">
                <c:forEach items="${sessionScope.listAgeCategory}" var="age">
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
                                <c:forEach items="${sessionScope.listMenu}" var="m">
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
        <h3 style="text-align: center">Nếu bạn có thay đổi hoặc thêm danh sách món ăn thì hãy nhập vào đây</h3>
        <div class="table-container-wrapper">
            <table border="1" >
                <thead>
                    <tr>
                        <th>Bữa ăn</th>
                        <th>Tên các món ăn</th>
                        <th>Chọn món ăn</th>
                        <th>Lưu</th>
                    </tr>
                </thead>
                <tbody >
                    <c:forEach items="${sessionScope.listMeal}" var="m">
                    <form action="menu" method="POST">
                        <tr>
                        <input type="hidden" name="mealID" value="${m.mealID}"/>
                        <td>${m.mealName}</td>
                        <td>
                            <c:forEach items="${sessionScope.listMenuFood}" var="me">
                                <c:if test="${m.mealID == me.mealid}">
                                    ${me.food.fname} <br/>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <select name="foodid" onchange="this.form.submit()">
                                <option value="0">Chọn món ăn</option>
                                <c:forEach items="${requestScope.listFood}" var="f">
                                    <option value="${f.foodid}" ${f.foodid == requestScope.fid ? 'selected' : ''}>${f.fname}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><button type="submit" name="save" value="1">Save</button></td>
                        </tr>
                    </form>
                </c:forEach>
                </tbody>
            </table>
        </div>


        <button><a href="menu" style="text-decoration: none">Nhập bữa ăn hôm nay</a></button>
    </body>
</html>
