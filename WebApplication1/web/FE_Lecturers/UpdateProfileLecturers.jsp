<%-- 
    Document   : UpdateProfileLecturers
    Created on : Jun 20, 2024, 6:53:32 PM
    Author     : NGUYEN THI KHANH VI
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Lecturer Profile</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
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

            .form-group input, .form-group select {
                background-color: #FFF7E0;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 0.9rem;
            }

            .row {
                margin-bottom: 15px;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Lecturer Profile</h2>

            <form id="updateLecturerForm" action="update-lecturers" method="post">
                <input type="hidden" id="editLecturerId" name="lid" value="${lecturers.lid}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerName">Lecturer Name</label>
                            <input type="text" class="form-control" id="editLecturerName" name="lname" value="${lecturers.lname}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerGender">Gender</label>
                            <select class="form-control" id="editLecturerGender" name="gender" required>
                                <option value="Male" ${lecturers.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${lecturers.gender == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerDob">Date of Birth</label>
                            <input type="date" class="form-control" id="editLecturerDob" name="dob" value="${lecturers.dob}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerPhoneNumber">Phone Number</label>
                            <input type="number" class="form-control" id="editLecturerPhoneNumber" name="phoneNumber" value="${lecturers.phoneNumber}" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerIDCard">ID Card</label>
                            <input type="number" class="form-control" id="editLecturerIDCard" name="IDCard" value="${lecturers.IDcard}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerAddress">Address</label>
                            <input type="text" class="form-control" id="editLecturerAddress" name="address" value="${lecturers.address}" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerEmail">Email</label>
                            <input type="email" class="form-control" id="editLecturerEmail" name="email" value="${lecturers.email}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="editLecturerNickName">Nickname</label>
                            <input type="text" class="form-control" id="editLecturerNickName" name="nickName" value="${lecturers.nickname}" required>
                        </div>
                    </div>
                </div>

                <% String Error = (String) request.getAttribute("Error"); %>
                <% if (Error != null) { %>
                <p class="error-message">${Error}</p>
                <% } %>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                    <button type="submit" id="confirmUpdateBtn" class="btn btn-danger">Update</button>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>