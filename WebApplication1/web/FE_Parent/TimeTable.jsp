<%-- 
    Document   : TimeTable
    Created on : May 17, 2024, 11:46:21 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Time Table</title>
        <style>
body {
  font-family: Arial, sans-serif;
  background-color: #f5f5f5;
  margin: 0;
  padding: 0;
}

.container {
  width: 80%;
  margin: 0 auto;
  padding: 20px;
  background-color: #b3d9ff;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1, h2 {
  text-align: center;
  color: #333;
}

.section {
  margin-bottom: 30px;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 20px;
}

table, th, td {
  border: 1px solid #ddd;
}

th, td {
  padding: 10px;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}

.activity-table tr:nth-child(even), .meal-table tr:nth-child(even) {
  background-color: #f9f9f9;
}

.activity-table tr:hover, .meal-table tr:hover {
  background-color: #f1f1f1;
}

p {
  font-size: 16px;
  color: #333;
}
        </style>
    </head>
    <body  >
        <div class="container">
            <h2 style="text-align: center">Thông tin hoạt động và bữa ăn của bé ${requestScope.student.sname}</h2>
            <div class="row">
                <div class="col">
                    <table border="2" class="activity-table">
                        <thead>
                        <th>Khung giờ</th>
                        <th>Hoạt động</th>
                        <th>Hoạt động cố định</th>
                        </thead>
                        <c:forEach items="${requestScope.curiculum}" var="c">
                            <tbody>
                                <tr>
                                    <td>${c.atid.timeStart} - ${c.atid.timeEnd}</td>
                                    <td>${c.nameAct}</td>
                                    <c:if test="${c.isFix == true}">
                                        <td>Cố Định</td>
                                    </c:if>
                                </tr>            
                            </tbody>
                        </c:forEach>
                    </table>
                </div>
                <div class="col">
                    <h2>Bữa ăn hôm nay của bé ${requestScope.student.sname}</h2>
                    <table border="2" class="meal-table">
                        <thead>
                            <tr>
                                <th>Bữa ăn</th>
                                <th>Món ăn</th>
                                <th>Calo</th>
                            </tr>
                        </thead>
                        <c:forEach items="${requestScope.menu}" var="m">
                            <tbody>
                                <tr>
                                    <td>${m.mealID.mealName}</td>
                                    <td>${m.foodid.fname}</td>
                                    <td>${m.foodid.calo}</td>
                                </tr>           
                            </tbody>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="section">
                <h2>Đánh giá về buổi học của giáo viên</h2>
                <h4 style="text-align: center">${requestScope.feedback.fcontent}</h4>
            </div>
        </div>
    </body>
</html>
