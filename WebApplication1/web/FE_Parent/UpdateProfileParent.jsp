<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Parent Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Fredoka One', cursive;
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

            .img-account-profile {
                height: 10rem;
            }

            .rounded-circle {
                border-radius: 50% !important;
            }

            .card {
                box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
            }

            .card .card-header {
                font-weight: 500;
            }

            .card-header:first-child {
                border-radius: 0.35rem 0.35rem 0 0;
            }

            .card-header {
                padding: 1rem 1.35rem;
                margin-bottom: 0;
                background-color: rgba(33, 40, 50, 0.03);
                border-bottom: 1px solid rgba(33, 40, 50, 0.125);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Parent Profile</h2>

            <form action="update-profile" method="post">
                <!-- Parent details form -->
                <div class="card mb-4">
                    <div class="card-header">Parent Details</div>
                    <div class="card-body">
                        <input type="hidden" id="editParentId" name="pid" value="${pa.pid}">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="nickname">Nickname</label>
                                    <input type="text" class="form-control" id="nickname" name="nickname" value="${pa.nickname}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="pname">Full Name</label>
                                    <input type="text" class="form-control" id="pname" name="pname" value="${pa.pname}" required>
                                </div>
                            </div>
                        </div>

                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="true" ${pa.gender ? 'selected' : ''}>Male</option>
                                        <option value="false" ${!pa.gender ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="${pa.dob}" required>
                                </div>
                            </div>
                        </div>

                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${pa.address}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="phoneNumber">Phone Number</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${pa.phoneNumber}" required>
                                </div>
                            </div>
                        </div>

                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${pa.email}" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="IDcard">ID Card</label>
                                    <input type="text" class="form-control" id="IDcard" name="IDcard" value="${pa.IDcard}" required>
                                </div>
                            </div>
                        </div>

                        <% String Error = (String) request.getAttribute("Error"); %>
                        <% if (Error != null) { %>
                        <p class="error-message">${Error}</p>
                        <% } %>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                            <button type="submit" class="btn btn-danger">Update</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
