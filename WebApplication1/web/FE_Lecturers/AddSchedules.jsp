<%-- 
    Document   : AddSchedules
    Created on : Jun 15, 2024, 2:29:27 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Schedules</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f0f0f0;
            }
            h2, h3 {
                color: #333;
                text-align: center;
            }
            form {
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            select, input[type="text"], input[type="submit"] {
                display: block;
                width: 100%;
                margin: 10px 0;
                padding: 10px;
                font-size: 16px;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }
            th {
                background-color: #f4f4f4;
            }
            a {
                display: block;
                text-align: center;
                margin: 20px 0;
                text-decoration: none;
                color: #007BFF;
            }
            a:hover {
                text-decoration: underline;
            }
            .delete-button {
                background-color: #007BFF;
                border: none;
                color: black;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                cursor: pointer;
                border-radius: 5px;
            }

            .delete-button:hover {
                background-color: #0066cc;
            }

            .return-link {
                text-decoration: none;
                color: black;
                font-size: 14px;
                margin-left: 10px; /* Adjust spacing as needed */
            }
        </style>
        <script>
            function confirmDeletion() {
                return confirm("Bạn có chắc chắn muốn xoá lịch học ngày hôm nay không?");
            }
        </script>
    </head>
    <body>
        <h2>Chương trình học của lớp ${sessionScope.className} năm học ${sessionScope.year.dateStart} - ${sessionScope.year.dateEnd}</h2>
        <c:if test="${sessionScope.sche != null}">
    <button class="delete-button">
        <a href="addSchedules?idToDelete=${sessionScope.sche.scheID}&csid=${sessionScope.csid}" 
           onclick="return confirmDeletion()">Xoá Lịch học ngày hôm nay</a>
    </button>
</c:if>
<a href="timeTableLecturer?lid=${sessionScope.lid}" class="return-link">Quay Lại</a>
        <h3>${requestScope.Delete}</h3>
        <h3>${requestScope.mess}</h3>
        <form action="addSchedules" method="GET">
            <select name="sdid">
                <c:forEach items="${sessionScope.listSchedulesUnlearn}" var="s">                  
                    <option value="${s.sdid.sdid}" ${s.sdid.sdid == requestScope.sdid ? 'selected' : ''} > 
                        ${s.sdid.detail}
                    </option>
                </c:forEach>  
            </select>
            <input readonly="" value="${sessionScope.date}" name="date"/>
            <input type="hidden" value="${sessionScope.csid}" name="csid"/>
            <c:if test="${sessionScope.sche != null}">
                <input type="submit" value="Cập nhật"/>
            </c:if>
            <c:if test="${sessionScope.sche == null}">
                <input type="submit" value="Thêm"/>
            </c:if>
        </form>
        <table border="1">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Buổi học</th>
                    <th>Ngày học</th>
                    <th>Lớp</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${sessionScope.listSchedulesLearn}" var="s" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${s.sdid.detail}</td>
                        <td>${s.date}</td>
                        <td>${s.csid.classID.clname}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
