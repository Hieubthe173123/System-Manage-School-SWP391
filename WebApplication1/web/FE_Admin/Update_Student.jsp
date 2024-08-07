<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Student</title>
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
                max-width: 600px;
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
                padding: 8px;
                font-size: 0.9rem;
                background-color: #FFF7E0;
            }

            .btn-primary, .btn-secondary, .btn-danger {
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
                border: none;
            }

            .btn-primary {
                background-color: #41E0B3;
            }

            .btn-primary:hover {
                background-color: #33C4A1;
            }

            .btn-secondary {
                background-color: #FFC107;
            }

            .btn-secondary:hover {
                background-color: #FFB300;
            }

            .btn-danger {
                background-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
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

            .card {
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #03ADD5;
                color: #fff;
                font-size: 1.25rem;
                border-bottom: 1px solid #ddd;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                padding: 15px;
            }

            .card-body {
                padding: 15px;
            }

            .card-body .form-group label {
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Information</h2>
            <div class="row">
                <!-- Update Student Form -->
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            Update Student
                        </div>
                        <div class="card-body">
                            <form id="updateStudentForm" action="update-student" method="post">
                                <input type="hidden" id="editStudentId" name="stuid" value="${param.stuid}">

                                <div class="form-group">
                                    <label for="editStudentName">Student Name</label>
                                    <input type="text" class="form-control" id="editStudentName" name="sname" value="${param.sname}" required>
                                </div>
                                <% String nameError = (String) request.getAttribute("nameError");
                                    if (nameError != null) { %>
                                <p class="error-message">${nameError}</p>
                                <% } %>

                                <div class="form-group">
                                    <label for="editStudentDob">Date of Birth</label>
                                    <input type="date" class="form-control" id="editStudentDob" name="dob" value="${param.dob}" required>
                                </div>
                                <% String dobError = (String) request.getAttribute("dobError");
                                    if (dobError != null) { %>
                                <p class="error-message">${dobError}</p>
                                <% } %>

                                <div class="form-group">
                                    <label for="editStudentGender">Gender</label>
                                    <select class="form-control" id="editStudentGender" name="gender" required>
                                        <option value="true" ${param.gender == 'true' ? 'selected' : ''}>Male</option>
                                        <option value="false" ${param.gender == 'false' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="editStudentAddress">Address</label>
                                    <input type="text" class="form-control" id="editStudentAddress" name="address" value="${param.address}" required>
                                </div>
                                <% String addressError = (String) request.getAttribute("addressError");
                                    if (addressError != null) { %>
                                <p class="error-message">${addressError}</p>
                                <% } %>

                                <div class="form-group">
                                    <label for="editStudentStatus">Status</label>
                                    <select class="form-control" id="editStudentStatus" name="status" required>
                                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                                <% String classError = (String) request.getAttribute("classError");
                                    if (classError != null) { %>
                                <p class="error-message">${classError}</p>
                                <% } %>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                                    <button type="submit" id="confirmUpdateBtn" class="btn btn-danger">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
