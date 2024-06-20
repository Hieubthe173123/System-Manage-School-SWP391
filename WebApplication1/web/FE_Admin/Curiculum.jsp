<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Curriculum List</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .container {
                width: 90%;
                max-width: 1200px;
                background: #fff;
                padding: 20px;
                margin: 20px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .actions form {
                display: flex;
                align-items: center;
                flex: 1;
            }
            .actions input[type="text"] {
                flex: 1;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px 0 0 5px;
                margin-right: -1px;
            }
            .actions button {
                padding: 10px 20px;
                border: none;
                border-radius: 0 5px 5px 0;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
                transition: background 0.3s;
            }
            .actions button:hover {
                background-color: #0056b3;
            }
            .actions .add-btn {
                background-color: #28a745;
                margin-left: 10px;
            }
            .actions .add-btn:hover {
                background-color: #218838;
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
                padding: 12px;
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
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-size: 14px;
            }
            .action-btn:hover {
                opacity: 0.9;
            }
            .update-btn {
                background-color: #ffc107;
                color: #fff;
            }
            .update-btn:hover {
                background-color: #e0a800;
            }
            .delete-btn {
                background-color: #dc3545;
                color: #fff;
            }
            .delete-btn:hover {
                background-color: #c82333;
            }
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }
            .page-btn {
                margin: 2px;
                padding: 10px 15px;
                cursor: pointer;
                background-color: #17a2b8;
                color: #fff;
                border: none;
                border-radius: 5px;
                transition: background 0.3s;
            }
            .page-btn.active, .page-btn:hover {
                background-color: #117a8b;
            }
        </style>
    </head>
     <body>
        <div class="container">
            <h1>Curriculum List</h1>
            <div class="actions">
                <form method="get" action="curriculum">
                    <input type="hidden" name="sid" value="${param.sid}" />
                    <input type="text" name="nameAct" placeholder="Search Activity" value="${param.nameAct}" />
                    <button type="submit">Search</button>
                </form>
                <button class="add-btn" onclick="window.location.href = 'add-curiculum'">Add Activity</button>
                <button class="add-btn">Promote Activity</button>
            </div>
            
            <form action="curriculum" method="get">
                <select name="sid" id="sessionSelect" onchange="this.form.submit()">
                    <c:forEach var="ses" items="${requestScope.list}">
                        <option value="${ses.sid}" ${ses.sid == param.sid ? 'selected' : ''}>
                            ${ses.sname}
                        </option>
                    </c:forEach>
                </select>
            </form>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Activity</th>
                        <th>Fixed</th>
                        <th colspan="2">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${!empty requestScope.list2}">
                            <c:forEach var="cur" items="${requestScope.list2}">
                                <tr class="${cur.isFix ? 'fixed-activity' : ''}">
                                    <td>${cur.curID}</td>
                                    <td>${cur.nameAct}</td>
                                    <td>${cur.isFix ? 'Hoạt động cứng' : 'Hoạt động bình thường'}</td>
                                    <td><button class="action-btn update-btn">Update</button></td>
                                    <td><button class="action-btn delete-btn" onclick="window.location.href = 'delete-activity?nameAct=${cur.nameAct}'">Delete</button></td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cur" items="${requestScope.list1}">
                                <tr class="${cur.isFix ? 'fixed-activity' : ''}">
                                    <td>${cur.curID}</td>
                                    <td>${cur.nameAct}</td>
                                    <td>${cur.isFix ? 'Hoạt động cứng' : 'Hoạt động bình thường'}</td>
                                    <td><button class="action-btn update-btn">Update</button></td>
                                    <td><button class="action-btn delete-btn" onclick="window.location.href = 'delete-activity?nameAct=${cur.nameAct}'">Delete</button></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </body>
</html>
