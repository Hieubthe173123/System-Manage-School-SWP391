<%-- 
    Document   : CRUD_Student
    Created on : May 27, 2024, 12:41:24 PM
    Author     : NGUYEN THI KHANH VI
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            <div class="row mt-3">
                <div class="col-sm-6">
                    <form class="form-inline" action="search-student" method="GET">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search student..." required>
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-sm-6 text-right">
                    <button class="btn btn-primary" id="addNewStudentBtn" data-toggle="modal" data-target="#studentModal">Add New Student</button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-auto">
                    <form action="student" method="GET" class="form-inline mb-3">
                        <label for="classSelect" class="mr-2">Select Class:</label>
                        <select name="classId" id="classSelect" class="form-control" onchange="this.form.submit()">
                            <option value="">Select Class</option>
                            <c:forEach var="classObj" items="${classList}">
                                <option value="${classObj.classid}" <c:if test="${param.classId == classObj.classid}">selected</c:if>>
                                    ${classObj.clname}
                                </option>
                            </c:forEach>
                        </select>
                    </form>
                </div>
            </div>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>DOB</th>
                        <th>Gender</th>
                        <th>Address</th>
                        <th>Parent Name</th>
                        <th>Class Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                    <c:forEach var="studentClass" items="${not empty search ? search : not empty allStudent ? allStudent : studentList}">
                        <tr>
                            <td>${studentClass.stuid.stuid}</td>
                            <td>${studentClass.stuid.sname}</td>
                            <td>${studentClass.stuid.dob}</td>
                            <td>${studentClass.stuid.gender ? 'Male' : 'Female'}</td>
                            <td>${studentClass.stuid.address}</td>
                            <td>${studentClass.stuid.pid.pname}</td>
                            <td>${studentClass.csid.classID.clname}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="showEditModal('${studentClass.stuid.stuid}', '${studentClass.stuid.sname}', '${studentClass.stuid.dob}', '${studentClass.stuid.gender}', '${studentClass.stuid.address}', '${studentClass.csid.classID.classid}')">Update</button>
                                <button class="btn btn-danger btn-sm" onclick="showDeactivateModal('${studentClass.stuid.stuid}', '${studentClass.stuid.pid.pid}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>


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
                            <form id="studentForm" action="add-student" method="post">
                                <!-- Student information -->
                                <div class="form-group">
                                    <label for="sName">Student Name</label>
                                    <input type="text" class="form-control" id="sName" name="sName" required>
                                </div>
                                <div class="form-group">
                                    <label for="sDob">Date of Birth</label>
                                    <input type="date" class="form-control" id="sDob" name="sDob" required>
                                </div>
                                <div class="form-group">
                                    <label for="sGender">Gender</label>
                                    <select class="form-control" id="sGender" name="sGender" required>
                                        <option value="true">Male</option>
                                        <option value="false">Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="studentAddress">Address</label>
                                    <input type="text" class="form-control" id="studentAddress" name="sAddress" required>
                                </div>
                                <div class="form-group">
                                    <label for="parentId">Parent ID</label>
                                    <input type="text" class="form-control" id="parentId" name="pid" required>
                                </div>
                                <div class="form-group">
                                    <label for="studentClassId">Class ID</label>
                                    <select class="form-control" id="studentClassId" name="classId" required>
                                        <c:forEach var="classObj" items="${classList}">
                                            <option value="${classObj.classid}" <c:if test="${param.classId == classObj.classid}">selected</c:if>>
                                                ${classObj.clname}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                 <button type="button" class="btn btn-secondary mt-3" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary mt-3">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>



            <!--             Delete Student Modal 
                        <div class="modal fade" id="deleteStudentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Confirm Delete</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure you want to delete this student and parent?
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                        <button type="button" id="confirmDeleteBtn" class="btn btn-danger">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </div>-->

            <!-- Delete Student Modal -->
            <div class="modal fade" id="deleteStudentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Confirm Deactivation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to deactivate this student and parent?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="button" id="confirmDeactivateBtn" class="btn btn-danger">Deactivate</button>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Modal for editing student -->
            <div class="modal fade" id="editStudentModal" tabindex="-1" aria-labelledby="editStudentModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editStudentModalLabel">Update Student</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="editStudentForm">
                                <input type="hidden" id="editStudentId">
                                <div class="form-group">
                                    <label for="editStudentName">Student Name</label>
                                    <input type="text" class="form-control" id="editStudentName" required>
                                </div>
                                <div class="form-group">
                                    <label for="editStudentDob">Date of Birth</label>
                                    <input type="date" class="form-control" id="editStudentDob" required>
                                </div>
                                <div class="form-group">
                                    <label for="editStudentGender">Gender</label>
                                    <select class="form-control" id="editStudentGender" name="gender" required>
                                        <option value="true">Male</option>
                                        <option value="false">Female</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="editStudentAddress">Address</label>
                                    <input type="text" class="form-control" id="editStudentAddress" required>
                                </div>
                                <div class="form-group">
                                    <label for="editStudentClassName">Class</label>
                                    <select class="form-control" id="editStudentClassName" name="className" required>
                                        <c:forEach var="classObj" items="${classList}">
                                            <option value="${classObj.classid}" <c:if test="${param.classId == classObj.classid}">selected</c:if>>
                                                ${classObj.clname}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    <button type="button" id="confirmUpdateBtn" class="btn btn-danger">Update</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- paging -->
            <div class="d-flex justify-content-center Endpage">
                <c:if test="${index > 1}">
                    <button class="page-btn" onclick="window.location.href = 'student?index=${index - 1}'">Previous</button>
                </c:if>
                <c:forEach begin="1" end="${endPage}" var="i">
                    <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'student?index=${i}'">${i}</button>
                </c:forEach>
                <c:if test="${index < endPage}">
                    <button class="page-btn" onclick="window.location.href = 'student?index=${index + 1}'">Next</button>
                </c:if>
            </div>

            <style>
                .Endpage {
                    margin-top: 10px;
                }
                .page-btn {
                    margin: 0 5px;
                    padding: 5px 10px;
                    background-color: #007bff;
                    border: none;
                    color: white;
                    cursor: pointer;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }
                .page-btn:hover {
                    background-color: #0056b3;
                }
                .page-btn.active {
                    background-color: #0056b3;
                    font-weight: bold;
                }
            </style>

            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
            <script src="script.js"></script>
            <script>
                        //Confirm deactivation
                        let deactivateStudentId;
                        let deactivateParentId;

                        function showDeactivateModal(stuid, pid) {
                            deactivateStudentId = stuid;
                            deactivateParentId = pid;
                            $('#deleteStudentModal').modal('show');
                        }

                        document.getElementById('confirmDeactivateBtn').addEventListener('click', function () {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = 'deactivate-student';

                            const stuidInput = document.createElement('input');
                            stuidInput.type = 'hidden';
                            stuidInput.name = 'stuid';
                            stuidInput.value = deactivateStudentId;

                            const pidInput = document.createElement('input');
                            pidInput.type = 'hidden';
                            pidInput.name = 'pid';
                            pidInput.value = deactivateParentId;

                            form.appendChild(stuidInput);
                            form.appendChild(pidInput);
                            document.body.appendChild(form);
                            form.submit();
                        });


                        // Xử lý hiển thị modal chỉnh sửa sinh viên
                        function showEditModal(stuid, sname, dob, gender, address, classId) {
                            document.getElementById('editStudentId').value = stuid;
                            document.getElementById('editStudentName').value = sname;
                            document.getElementById('editStudentDob').value = dob;
                            document.getElementById('editStudentGender').value = gender === 'true' ? 'true' : 'false';
                            document.getElementById('editStudentAddress').value = address;
                            document.getElementById('editStudentClassName').value = classId;

                            // Show the edit modal
                            $('#editStudentModal').modal('show');
                        }


                        // Xử lý khi người dùng xác nhận cập nhật sinh viên
                        document.getElementById('confirmUpdateBtn').addEventListener('click', function () {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = 'update-student';

                            const stuidInput = document.createElement('input');
                            stuidInput.type = 'hidden';
                            stuidInput.name = 'stuid';
                            stuidInput.value = document.getElementById('editStudentId').value;

                            const snameInput = document.createElement('input');
                            snameInput.type = 'hidden';
                            snameInput.name = 'sname';
                            snameInput.value = document.getElementById('editStudentName').value;

                            const dobInput = document.createElement('input');
                            dobInput.type = 'hidden';
                            dobInput.name = 'dob';
                            dobInput.value = document.getElementById('editStudentDob').value;

                            const genderInput = document.createElement('input');
                            genderInput.type = 'hidden';
                            genderInput.name = 'gender';
                            genderInput.value = document.getElementById('editStudentGender').value;

                            const addressInput = document.createElement('input');
                            addressInput.type = 'hidden';
                            addressInput.name = 'address';
                            addressInput.value = document.getElementById('editStudentAddress').value;

                            const classNameInput = document.createElement('input');
                            classNameInput.type = 'hidden';
                            classNameInput.name = 'className';
                            classNameInput.value = document.getElementById('editStudentClassName').value;

                            form.appendChild(stuidInput);
                            form.appendChild(snameInput);
                            form.appendChild(dobInput);
                            form.appendChild(genderInput);
                            form.appendChild(addressInput);
                            form.appendChild(classNameInput);
                            document.body.appendChild(form);
                            form.submit();
                        });
            </script>

    </body>
</html>
