<%-- 
    Document   : ActivityDay
    Created on : Jun 10, 2024, 3:47:15 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ActivityDay Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: #fff;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .action-btn:hover {
            opacity: 0.8;
        }
        .update-btn {
            background-color: #28a745;
            color: #fff;
        }
        .delete-btn {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <th>Activity</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Fixed</th>
            <th colspan="2">Action</th>
        </tr>
        <c:forEach var="cur" items="${requestScope.list}">
            <tr>
                <td>${cur.nameAct}</td>
                <td>${cur.timeStart}</td>
                <td>${cur.timeEnd}</td>
                <td>${cur.isFix ? 'Hoạt động cứng' : 'Hoạt động bình thường'}</td>
                <td><button class="action-btn update-btn">Update</button></td>
                <td><button class="action-btn delete-btn">Delete</button></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
