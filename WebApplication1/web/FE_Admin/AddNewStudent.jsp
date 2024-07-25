<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Student</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');
            body {
                background-color: #FFFAF0;
                font-family: 'Roboto', cursive;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                width: 90%;
                max-width: 800px;
                padding: 20px;
                background-color: #FFFFFF;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
            }

            h2 {
                color: #03ADD5;
                text-align: center;
                margin-bottom: 20px;
                font-size: 1.5rem;
            }

            .form-group label {
                color: #03ADD5;
            }

            .form-group input, .form-group select {
                border: 2px solid #03ADD5;
                border-radius: 10px;
                padding: 5px;
                font-size: 0.9rem;
                background-color: #FFF7E0;
            }

            .btn-primary, .btn-secondary, .btn-danger {
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
                border: none;
                transition: background-color 0.3s ease;
            }

            .btn-primary {
                background-color: #41E0B3;
            }

            .btn-primary:hover {
                background-color: #38C9A9;
            }

            .btn-secondary {
                background-color: #FFC107;
            }

            .btn-secondary:hover {
                background-color: #FF9800;
            }

            .btn-danger {
                background-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            .modal-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 0.9rem;
                margin-bottom: 20px;
            }

            .row {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Add New Student</h2>
            <form id="studentForm" action="add-student" method="post">
                <input type="hidden" name="parentId" value="${param.pid}">
                <div class="form-group">
                    <label for="sName">Student Name</label>
                    <input type="text" class="form-control" id="sName" name="sName" value="${param.sName}" required>
                </div>
                <div class="form-group">
                    <label for="sDob">Date of Birth</label>
                    <input type="date" class="form-control" id="sDob" name="sDob" value="${param.sDob}" required>
                </div>
                <div class="form-group">
                    <label for="sGender">Gender</label>
                    <select class="form-control" id="sGender" name="sGender" required>
                        <option value="true" <c:if test="${param.sGender == 'true'}">selected</c:if>>Male</option>
                        <option value="false" <c:if test="${param.sGender == 'false'}">selected</c:if>>Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="sAddress">Address</label>
                        <input type="text" class="form-control" id="sAddress" name="sAddress" value="${param.sAddress}" required>
                </div>
                <div class="form-group">
                    <label for="classId">Class ID</label>
                    <select class="form-control" id="classId" name="classId" required>
                        <option value="">Select Class</option>
                        <c:forEach var="classSession" items="${classIDs}">
                            <option value="${classSession.classID.classid}" <c:if test="${param.classId == classSession.classID.classid}">selected</c:if>>
                                ${classSession.classID.clname}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <% String error = (String) request.getAttribute("error");
                if (error != null) { %>
                <p class="error-message">${error}</p>
                <% } %>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                    <button type="submit" class="btn btn-danger">Add</button>
                </div>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
