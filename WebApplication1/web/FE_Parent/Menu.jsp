<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Today</title>
    </head>
    <body>
        <h1>Nhà bếp hôm nay có gì</h1>
        <form action="menu" method="POST">
            <label for="date">Nhập ngày:</label>
            <input type="text" id="datetext" name="date" placeholder="'2024-01-01'"/>
            <br/>
            <button type="submit">Submit</button>
        </form>
        <form action="menu" method="POST">
            <label for="date">Chọn ngày:</label>
            <input type="date" id="date" name="date"/>
            <br/>
            <button type="submit">Submit</button>
        </form>
        <h1>Bữa ăn hôm nay</h1>
        <h3 style="color: red">${sessionScope.Mess}</h3>
        <h3 style="color: red">${sessionScope.Err}</h3>
        <h3 style="color: red">${sessionScope.warn}</h3>
        <form action="menu" method="Post">
            <select name="ageid" onchange="this.form.submit()">
                <option value="0">Chọn lứa tuổi</option>
                <c:forEach items="${requestScope.listAgeCategory}" var="a">
                    <option value="${a.ageid}" ${a.ageid eq sessionScope.ageid ? 'selected' : ''}>${a.aname}</option>
                </c:forEach>
            </select>
        </form>

        <c:if test="${fn:length(sessionScope.listMenuDateText) > 0}">
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

                        <tr>

                            <td>${m.mealID.mealName}</td>
                            <td>
                                ${m.menu}
                            </td>
                            <td>
                                ${m.date}
                            </td>
                        </tr>

                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${fn:length(sessionScope.listMenuDateText) <= 0}">
            <c:if test="${fn:length(requestScope.listMenu) > 0 }">
                
            </c:if>
            <table border="1">
                <thead>
                    <tr>
                        <th>Bữa ăn</th>
                        <th>Tên các món ăn</th>
                        <th>Chọn món ăn</th>
                        <th>Lưu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.listMeal}" var="m">
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
    </c:if>


</body>
</html>
