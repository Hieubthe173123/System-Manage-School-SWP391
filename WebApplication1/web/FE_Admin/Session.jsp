<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Session Management</title>
        <style>
            body {
                font-family: 'Roboto', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }
            header {
                background: #03ADD5;
                color: white;
                padding: 1rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 1rem;
                position: relative;
            }
            header a {
                position: absolute;
                right: 1rem;
                top: 1rem;
                color: white;
                text-decoration: none;
                font-size: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                background: #32CD32;
                transition: background-color 0.3s ease;
            }
            header a:hover {
                background-color: #228B22;
            }
            .container {
                width: 90%;
                margin: 0 auto;
                padding: 20px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .search-bar {
                margin-bottom: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .search-bar form {
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 600px;
            }
            .search-bar input[type="text"] {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 10px;
                flex-grow: 1;
            }
            .search-bar button {
                background-color: #FFD700;
                color: #333;
                border: 2px solid #FFD700;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 4px;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            .search-bar button:hover {
                background-color: #FFC107;
                border: 2px solid #FFC107;
                color: #fff;
            }
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 20px;
            }
            .action-buttons button {
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 4px;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            .action-buttons .btn-add {
                background-color: #28A745;
                color: #fff;
                border: 2px solid #28A745;
            }
            .action-buttons .btn-add:hover {
                background-color: #218838;
                border: 2px solid #218838;
            }
            .action-buttons .btn-history {
                background-color: #17A2B8;
                color: #fff;
                border: 2px solid #17A2B8;
            }
            .action-buttons .btn-history:hover {
                background-color: #138496;
                border: 2px solid #138496;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background: #fff;
                border-radius: 15px;
                overflow: hidden;
                border: 5px solid #03ADD5;
            }
            th, td {
                padding: 1rem;
                text-align: center;
                border: 1px solid #ddd;
            }
            th {
                background-color: #03ADD5;
                color: white;
            }
            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tbody tr:hover {
                background-color: #f1f1f1;
            }
            .table-actions .update-button {
                background-color: #FFD700;
                color: #333;
                border: 2px solid #FFD700;
                margin: 5px;
                border-radius: 4px;
                padding: 5px 10px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .table-actions .update-button:hover {
                background-color: #FFC107;
                border: 2px solid #FFC107;
                color: #fff;
            }
            .table-actions .delete-button {
                background-color: #DC3545;
                color: #fff;
                border: 2px solid #DC3545;
                margin: 5px;
                border-radius: 4px;
                padding: 5px 10px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .table-actions .delete-button:hover {
                background-color: #C82333;
                border: 2px solid #C82333;
            }
            .session-name-button {
                background-color: #03ADD5;
                color: white;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 4px;
                transition: background-color 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }
            .session-name-button:hover {
                background-color: #0288D1;
            }
        </style>
        <!-- Include SweetAlert CSS and JS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmDelete(sid) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#DC3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'delete-session?sid=' + sid;
                    }
                })
            }
        </script>
    </head>
    <body>
        <header>
            <h1>Session Management</h1>
            <a href="adminhome">Back to Home</a>
        </header>
        <div class="container">
            <div class="search-bar">
                <form action="session" method="get">
                    <input type="text" name="nameAct" placeholder="Search sessions">
                    <button type="submit">Search</button>
                </form>
            </div>
            <div class="action-buttons">
                 <button class="btn btn-secondary" onclick="window.location.href = 'session'">Show All Session</button>
                <button class="btn-add" onclick="window.location.href = 'add-sessions'">Add Session</button>
                <button class="btn-history" onclick="window.location.href = 'history-session'">Session History</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Session ID</th>
                        <th>Session Name</th>
                        <th>Age Group</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${!empty requestScope.list1}">
                            <c:forEach var="ses" items="${requestScope.list1}">
                                <tr>
                                    <td>${ses.sid}</td>
                                    <td><a class="session-name-button" href="session-detail?sid=${ses.sid}">${ses.sname}</a></td>
                                    <td>${ses.age.aname}</td>
                                    <td class="table-actions">
                                        <button class="update-button" onclick="window.location.href = 'update-session?sid=${ses.sid}'">Update</button>
                                        <button class="delete-button" onclick="confirmDelete('${ses.sid}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="ses" items="${requestScope.list}">
                                <tr>
                                    <td>${ses.sid}</td>
                                    <td><a class="session-name-button" href="session-detail?sid=${ses.sid}">${ses.sname}</a></td>
                                    <td>${ses.age.aname}</td>
                                    <td class="table-actions">
                                        <button class="update-button" onclick="window.location.href = 'update-session?sid=${ses.sid}'">Update</button>
                                        <button class="delete-button" onclick="confirmDelete('${ses.sid}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </body>
</html>
