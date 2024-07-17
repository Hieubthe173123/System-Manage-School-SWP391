<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Student</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .container {
                margin-top: 50px;
                max-width: 600px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .modal-footer {
                margin-top: 20px;
                text-align: right;
            }
            .btn-cancel {
                margin-right: 10px;
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
                <p style="color: red" id="message">${error}</p>
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
