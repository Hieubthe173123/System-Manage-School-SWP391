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
                    <button class="btn btn-primary mr-2" id="addNewParentBtn" data-toggle="modal" data-target="#parentModal">Add New Parent</button>
                    <button class="btn btn-primary" id="addNewStudentBtn" data-toggle="modal" data-target="#studentModal">Add New Student</button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-auto">
                    <select class="form-control" onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value)">
                        <option value="">Select School Year</option>
                        <c:forEach var="SchoolYear" items="${listB}">
                            <option value="student?timeStart=${SchoolYear.dateStart}&timeEnd=${SchoolYear.dateEnd}" 
                                    <c:if test="${param.timeStart == SchoolYear.dateStart && param.timeEnd == SchoolYear.dateEnd}">selected</c:if>>
                                ${SchoolYear.dateStart} - ${SchoolYear.dateEnd}
                            </option>
                        </c:forEach>
                    </select> <br>
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
                        <th>Parent ID</th>
                        <th>Class Name</th>
                        <th>Active</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">

                    <c:forEach var="studentClass" items="${list}">
                        <tr>
                            <td>${studentClass.stuid.getStuid()}</td>
                            <td>${studentClass.stuid.getSname()}</td>
                            <td>${studentClass.stuid.getDob()}</td>
                            <td>${studentClass.stuid.isGender() ? 'Male' : 'Female'}</td>
                            <td>${studentClass.stuid.getAddress()}</td>
                            <td>${studentClass.stuid.pid.getPid()}</td>
                            <td>${studentClass.csid.getClassID().getClname()}</td>
                            <td>
                               <button class="btn btn-warning btn-sm" onclick="editStudent('${studentClass.stuid.getStuid()}')">Edit</button>
                               <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal('${studentClass.stuid.getStuid()}', '${studentClass.stuid.pid.getPid()}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${not empty listC}">
                            <c:forEach var="studentClass" items="${listC}">
                                <tr>
                                    <td>${studentClass.stuid.getStuid()}</td>
                                    <td>${studentClass.stuid.getSname()}</td>
                                    <td>${studentClass.stuid.getDob()}</td>
                                    <td>${studentClass.stuid.isGender() ? 'Male' : 'Female'}</td>
                                    <td>${studentClass.stuid.getAddress()}</td>
                                    <td>${studentClass.stuid.pid.getPid()}</td>
                                    <td>${studentClass.csid.getClassID().getClname()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${studentClass.csid.getclassID() != null}">
                                                ${studentClass.csid.getclassID().getclname()}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                         <button class="btn btn-warning btn-sm" onclick="editStudent('${studentClass.stuid.getStuid()}')">Edit</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal('${studentClass.stuid.getStuid()}', '${studentClass.stuid.pid.getPid()}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="studentClass" items="${listA}">
                                <tr>
                                    <td>${studentClass.stuid.getStuid()}</td>
                                    <td>${studentClass.stuid.getSname()}</td>
                                    <td>${studentClass.stuid.getDob()}</td>
                                    <td>${studentClass.stuid.isGender() ? 'Male' : 'Female'}</td>
                                    <td>${studentClass.stuid.getAddress()}</td>
                                    <td>${studentClass.stuid.pid.getPid()}</td>
                                    <td>${studentClass.csid.getClassID().getClname()}</td>
                                    <td>
                                         <button class="btn btn-warning btn-sm" onclick="editStudent('${studentClass.stuid.getStuid()}')">Edit</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal('${studentClass.stuid.getStuid()}', '${studentClass.stuid.pid.getPid()}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </tbody>
            </table>
        </div>

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


<!-- Delete Student Modal -->
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
</div>








<!-- paging -->
<c:choose>
    <c:when test="${not empty listC}">
        <div class="d-flex justify-content-center Endpage">
            <c:if test="${index > 1}">
                <button class="page-btn" onclick="window.location.href = 'student?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${index - 1}'">Previous</button>
            </c:if>
            <c:forEach begin="1" end="${endPage}" var="i">
                <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'student?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${i}'">${i}</button>
            </c:forEach>
            <c:if test="${index < endPage}">
                <button class="page-btn" onclick="window.location.href = 'student?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${index + 1}'">Next</button>
            </c:if>
        </div>
    </c:when>
    <c:otherwise>
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
    </c:otherwise>
</c:choose>
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
     //Confirm deletion
    let deleteStudentId; //Store student and parent IDs to be deleted.
    let deleteParentId;

    function showDeleteModal(stuid, pid) {
        deleteStudentId = stuid; 
        deleteParentId = pid;
        $('#deleteStudentModal').modal('show'); //hiển thị modal xác nhận xóa
    }

    document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'deleteStudent'; 

        const stuidInput = document.createElement('input');
        stuidInput.type = 'hidden';
        stuidInput.name = 'stuid';
        stuidInput.value = deleteStudentId;

        const pidInput = document.createElement('input');
        pidInput.type = 'hidden';
        pidInput.name = 'pid';
        pidInput.value = deleteParentId;

        form.appendChild(stuidInput);
        form.appendChild(pidInput);
        document.body.appendChild(form);
        form.submit();
    });
</script>

</body>
</html>
