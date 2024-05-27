<%-- 
    Document   : CRUD_Student
    Created on : May 27, 2024, 12:41:24 PM
    Author     : NGUYEN THI KHANH VI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

            .form-group label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Student Management</h2>
            <div class=" row w-100 ">
                 
                <div class="col-sm-6 mb-3 d-flex justify-content-between">
                    <input type="text" class="form-control w-75" id="searchStudent" placeholder="Search student by name...">
                     </div>
                    <div class="col-sm-6 ">

                        <button class="btn btn-primary mr-2" id="addNewParentBtn" data-toggle="modal" data-target="#parentModal">Add New Parent</button>
                        <button class="btn btn-primary" id="addNewStudentBtn" data-toggle="modal" data-target="#studentModal">Add New Student</button>
                    </div>
               
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>DOB</th>
                        <th>Gender</th>
                        <th>Address</th>
                        <th>Parent ID</th>
                        <th>Class ID</th>
                        <th>Active</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                    <!-- Student list will be populated here -->
                    
                </tbody>
            </table>
        </div>
        <div class="container">
            <div class="row">
                <!-- Modal for adding new parent -->
                <div class="modal fade" id="parentModal" tabindex="-1" aria-labelledby="parentModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="parentModalLabel">Add New Parent</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="parentForm">
                                    <div class="form-group">
                                        <label for="parentId">Parent ID</label>
                                        <input type="text" class="form-control" id="parentId" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentName">Parent Name</label>
                                        <input type="text" class="form-control" id="parentName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentDob">Date of Birth</label>
                                        <input type="date" class="form-control" id="parentDob" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentGender">Gender</label>
                                        <select class="form-control" id="parentGender" required>
                                            <option>Male</option>
                                            <option>Female</option>
                                            <option>Other</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentPhone">Phone Number</label>
                                        <input type="text" class="form-control" id="parentPhone" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentIdCard">ID Card</label>
                                        <input type="text" class="form-control" id="parentIdCard" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentEmail">Email</label>
                                        <input type="email" class="form-control" id="parentEmail" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentAddress">Address</label>
                                        <input type="text" class="form-control" id="parentAddress" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary mt-3">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal for adding new student -->
                <div class="modal fade" id="studentModal" tabindex="-1" aria-labelledby="studentModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="studentModalLabel">Add New Student</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="studentForm">
                                    <div class="form-group">
                                        <label for="studentId">Student ID</label>
                                        <input type="text" class="form-control" id="studentId" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="studentName">Student Name</label>
                                        <input type="text" class="form-control" id="studentName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="studentDob">Date of Birth</label>
                                        <input type="date" class="form-control" id="studentDob" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="studentGender">Gender</label>
                                        <select class="form-control" id="studentGender" required>
                                            <option>Male</option>
                                            <option>Female</option>
                                            <option>Other</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="studentAddress">Address</label>
                                        <input type="text" class="form-control" id="studentAddress" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="parentId">Parent ID</label>
                                        <input type="text" class="form-control" id="studentParentId" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="classId">Class ID</label>
                                        <input type="text" class="form-control" id="studentClassId" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary mt-3">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script src="script.js"></script>
    </body>
</html>
