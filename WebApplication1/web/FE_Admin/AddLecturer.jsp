<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Create Lecturers Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
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

            .btn-primary {
                background-color: #41E0B3;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
            }

            .btn-primary:hover {
                background-color: #FF9800;
            }

            .btn-secondary {
                background-color: #FFC107;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
            }

            .btn-secondary:hover {
                background-color: #FF9800;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
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
            }

            .row {
                margin-bottom: 15px;
            }

            .form-row {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .form-group {
                flex: 0 0 48%;
            }
        </style>
    </head>
    <body>
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h2>Add Lecturers Profile</h2>
                        </div>
                        <div class="card-body">
                            <form action="add-lecturer" method="POST">
                                <c:if test="${not empty requestScope.errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        ${requestScope.errorMessage}
                                    </div>
                                </c:if>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="lname">Full Name</label>
                                        <input type="text" class="form-control" id="lname" name="lname" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select class="form-control" id="gender" name="gender" required>
                                            <option value="true">Male</option>
                                            <option value="false">Female</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="dob">Date Of Birth</label>
                                        <input type="date" class="form-control" id="dob" name="dob" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="phoneNumber">Phone Number</label>
                                        <input type="number" class="form-control" id="phoneNumber" name="phoneNumber" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="IDcard">Citizen identification card</label>
                                        <input type="number" class="form-control" id="IDcard" name="IDcard" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="classID">Class Name</label>
                                        <select class="form-control" id="classID" name="classID">
                                            <option value="">Select Class</option>
                                            <c:forEach items="${requestScope.listA}" var="cla">
                                                <option value="${cla.classID.classid}">${cla.classID.clname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                    <button type="button" class="btn btn-danger" onclick="window.location.href = 'lecturers'">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
