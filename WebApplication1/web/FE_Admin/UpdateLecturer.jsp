<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Lecturer and Class</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Fredoka One', cursive;
                padding-top: 40px; /* for Bootstrap navbar */
            }

            .container {
                max-width: 1000px;
                margin: auto;
                background-color: #FFFFFF;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
                padding: 20px;
            }

            h2 {
                color: #03ADD5;
                text-align: center;
                margin-bottom: 20px;
                font-size: 1.5rem;
            }

            .text-center {
                width: 100%;
                text-align: center;
                margin-bottom: 20px;
            }

            .alert {
                margin-bottom: 20px;
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

            .btn-primary, .btn-info {
                background-color: #41E0B3;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
            }

            .btn-primary:hover, .btn-info:hover {
                background-color: #FF9800;
            }

            .form-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .form-container .card {
                flex: 1;
                margin: 10px;
                min-width: 45%; /* Adjusted to fit two columns */
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #f0f9ff;
                padding: 1rem;
                border-radius: 10px 10px 0 0;
            }

            .card-body {
                padding: 2rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="text-center">
                <button class="btn btn-info" onclick="window.location.href = 'lecturers'">Back To Lecturers</button>
            </div>

            <div class="form-container">
                <div class="card" id="updateLecturerCard">
                    <div class="card-header">
                        <h2>Update Lecturer</h2>
                    </div>
                    <div class="card-body">
                        
                        <form id="updateLecturerForm" action="update-lecturers" method="POST">
                            <input type="hidden" name="lid" value="${lec.lid.lid}">
                            <div class="form-group">
                                <label for="lname">Full Name</label>
                                <input type="text" class="form-control" id="lname" name="lname" value="${lec.lid.lname}" required>
                            </div>
                            <div class="form-group">
                                <label for="gender">Gender</label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="true" ${lec.lid.gender ? 'selected' : ''}>Male</option>
                                    <option value="false" ${!lec.lid.gender ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="dob">Date of Birth</label>
                                <input type="date" class="form-control" id="dob" name="dob" value="${lec.lid.dob}" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control" id="address" name="address" value="${lec.lid.address}" required>
                            </div>
                            <div class="form-group">
                                <label for="phoneNumber">Phone Number</label>
                                <input type="number" class="form-control" id="phoneNumber" name="phoneNumber" value="${lec.lid.phoneNumber}" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${lec.lid.email}" required>
                            </div>
                            <div class="form-group">
                                <label for="IDcard">ID Card</label>
                                <input type="number" class="form-control" id="IDcard" name="IDcard" value="${lec.lid.IDcard}" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                        </form>
                    </div>
                </div>

                <div class="card" id="updateClassCard">
                    <div class="card-header">
                        <h2>Update Class</h2>
                    </div>
                    <div class="card-body">

                        <form id="updateClassForm" action="update-lecturer-class" method="POST">
                            <input type="hidden" name="lid" value="${param.lid}">
                            <div class="form-group">
                                <label for="class">Class Name</label>
                                <select class="form-control" id="class" name="classid" required>
                                    <option value="${lec.csid.classID}">${lec.csid.classID.clname}</option>
                                    <option value="">No Class</option>
                                    <c:forEach items="${requestScope.list1}" var="cla">
                                        <option value="${cla.classID.classid}">${cla.classID.clname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Show Update Lecturer form by default
                showForm('updateLecturerCard');
            });

            function showForm(formId) {
                // Hide all cards
                document.querySelectorAll('.card').forEach(card => card.classList.remove('active'));

                // Show the selected form
                document.getElementById(formId).classList.add('active');
            }

            document.addEventListener("DOMContentLoaded", function () {
                // Show Update Lecturer form by default
                showForm('updateLecturerCard');

                // Show success or error messages if available
            <c:if test="${not empty successMessage}">
                swal("Success!", "${successMessage}", "success");
            </c:if>
            <c:if test="${not empty errorMessage}">
                swal("Error!", "${errorMessage}", "error");
            </c:if>
            });

            function showForm(formId) {
                // Hide all cards
                document.querySelectorAll('.card').forEach(card => card.classList.remove('active'));

                // Show the selected form
                document.getElementById(formId).classList.add('active');
            }
        </script>

    </body>
</html>
