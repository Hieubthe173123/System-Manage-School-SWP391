
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecturers Management</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }

            h2 {
                margin-bottom: 20px;
            }

            .table th, .table td {
                vertical-align: middle;
            }

            .modal-header {
                background-color: #007bff;
                color: white;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .form-group label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Lecturers Management</h2>
            <div class="row w-100 mb-3">
                <div class="col-sm-6 mb-3 d-flex justify-content-between">
                    <form class="form-inline">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search">
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary" id="addNewLecturerBtn" data-toggle="modal" data-target="#lecturerModal">Add New Lecturer</button>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>LecturerID</th>
                        <th>Lecturer Name</th>
                        <th>DOB</th>
                        <th>Gender</th>
                        <th>Class Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="lecturerTableBody">
                    <c:forEach var="lecturer" items="${requestScope.list}">
                        <tr>
                            <td>${lecturer.lid}</td>
                            <td>${lecturer.lname}</td>
                            <td>${lecturer.dob}</td>
                            <td>${lecturer.gender ? 'Male' : 'Female'}</td>
                             <td>${lecturer.cl.clname}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="editLecturer(${lecturer.lid})">Update</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteLecturer(${lecturer.lid})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>


                </tbody>
            </table>
        </div>

        <!-- Add Lecturer Modal -->
        <div class="modal fade" id="lecturerModal" tabindex="-1" aria-labelledby="lecturerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lecturerModalLabel">Add New Lecturer</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="lecturerForm">
                            <div class="form-group">
                                <label for="lecturerId">LecturerID</label>
                                <input type="text" class="form-control" id="lecturerId" required>
                            </div>
                            <div class="form-group">
                                <label for="lecturerName">Lecturer Name</label>
                                <input type="text" class="form-control" id="lecturerName" required>
                            </div>
                            <div class="form-group">
                                <label for="lecturerDob">Date of Birth</label>
                                <input type="date" class="form-control" id="lecturerDob" required>
                            </div>
                            <div class="form-group">
                                <label for="lecturerGender">Gender</label>
                                <select class="form-control" id="lecturerGender" required>
                                    <option>Male</option>
                                    <option>Female</option>
                                    <option>Other</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="lecturerClassName">Class Name</label>
                                <input type="text" class="form-control" id="lecturerClassName" required>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Lecturer Modal -->
        <div class="modal fade" id="updateLecturerModal" tabindex="-1" aria-labelledby="updateLecturerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateLecturerModalLabel">Update Lecturer</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="updateLecturerForm">
                            <div class="form-group">
                                <label for="updateLecturerId">LecturerID</label>
                                <input type="text" class="form-control" id="updateLecturerId" required>
                            </div>
                            <div class="form-group">
                                <label for="updateLecturerName">Lecturer Name</label>
                                <input type="text" class="form-control" id="updateLecturerName" required>
                            </div>
                            <div class="form-group">
                                <label for="updateLecturerDob">Date of Birth</label>
                                <input type="date" class="form-control" id="updateLecturerDob" required>
                            </div>
                            <div class="form-group">
                                <label for="updateLecturerGender">Gender</label>
                                <select class="form-control" id="updateLecturerGender" required>
                                    <option>Male</option>
                                    <option>Female</option>
                                    <option>Other</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="updateLecturerClassName">Class Name</label>
                                <input type="text" class="form-control" id="updateLecturerClassName" required>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Lecturer Modal -->
        <div class="modal fade" id="deleteLecturerModal" tabindex="-1" aria-labelledby="deleteLecturerModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteLecturerModalLabel">Delete Lecturer</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this lecturer?</p>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
