<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inactive Students</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }

            header {
                background: #03ADD5;
                color: white;
                padding: 1rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 1rem;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            header h1 {
                margin-bottom: 1rem;
            }

            .header-buttons {
                display: flex;
                gap: 15px;
            }

            .header-buttons a {
                background-color: #FF6F61;
                border-color: #FF6F61;
                color: white;
                border-radius: 20px;
                padding: 0.5rem 1rem;
                text-decoration: none;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

            .header-buttons a:hover {
                background-color: #FF4D4D;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .header-buttons .btn-parent {
                background-color: #4CAF50;
                border-color: #4CAF50;
            }

            .header-buttons .btn-parent:hover {
                background-color: #45A049;
            }

            .header-buttons .btn-inactive {
                background-color: #FF9800;
                border-color: #FF9800;
            }

            .header-buttons .btn-inactive:hover {
                background-color: #FB8C00;
            }

            .container {
                margin-top: 2rem;
                padding: 0 1rem;
            }

            h2 {
                margin-bottom: 20px;
                font-size: 2em;
                color: #03ADD5;
            }

            .form-inline .form-control {
                border-radius: 20px;
                margin-right: 0.5rem;
            }

            .btn-custom {
                background-color: #03ADD5;
                border-color: #03ADD5;
                color: white;
                border-radius: 20px;
                transition: background-color 0.3s ease;
            }

            .btn-custom:hover {
                background-color: #0288D1;
                border-color: #0288D1;
            }

            .table {
                width: 100%;
                margin: 0 auto;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background: #fff;
                border-radius: 20px;
                overflow: hidden;
                border: 5px solid #03ADD5;
            }

            th, td {
                padding: 1rem;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #03ADD5;
                color: white;
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            tbody td:last-child {
                border-right: none;
            }

            .pagination-container {
                margin-top: 2rem;
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
            }

            .page-btn {
                margin: 0 5px;
                padding: 5px 10px;
                background-color: #03ADD5;
                border: none;
                color: white;
                cursor: pointer;
                border-radius: 25px;
                transition: background-color 0.3s ease;
            }

            .page-btn:hover {
                background-color: #0288D1;
            }

            .page-btn.active {
                background-color: #0288D1;
                font-weight: bold;
            }

            @media (max-width: 768px) {
                body {
                    font-size: 14px;
                }

                .container {
                    padding: 0;
                }

                .table {
                    width: 100%;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <h1>Student Management System</h1>
        </header>

        <div class="container mt-5">
            <h2 class="text-center">Inactive Students</h2>

            <div class="row mt-3">
                <div class="col-sm-6">
                    <form class="form-inline" action="search-student-inactive" method="GET">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search inactive student..." required>
                        <button class="btn btn-custom my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-sm-6 text-right">
                    <button class="btn btn-custom" onclick="window.location.href = 'student'">Back to Student</button>
                </div>
            </div>

            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>No</th>
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
                <tbody>
                    <c:choose>
                        <c:when test="${not empty inactive}">
                            <c:forEach var="studentClass" items="${inactive}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1 + (index - 1) * 10}</td>
                                    <td>${studentClass.stuid.stuid}</td>
                                    <td>${studentClass.stuid.sname}</td>
                                    <td>${studentClass.stuid.dob}</td>
                                    <td>${studentClass.stuid.gender ? 'Male' : 'Female'}</td>
                                    <td>${studentClass.stuid.address}</td>
                                    <td>${studentClass.stuid.pid.pname}</td>
                                    <td>${studentClass.csid.classID.clname}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-sm" onclick="showUpdateModal('${studentClass.stuid.stuid}')">Update</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="studentClass" items="${search}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${studentClass.stuid.stuid}</td>
                                    <td>${studentClass.stuid.sname}</td>
                                    <td>${studentClass.stuid.dob}</td>
                                    <td>${studentClass.stuid.gender ? 'Male' : 'Female'}</td>
                                    <td>${studentClass.stuid.address}</td>
                                    <td>${studentClass.stuid.pid.pname}</td>
                                    <td>${studentClass.csid.classID.clname}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-sm" onclick="showUpdateModal('${studentClass.stuid.stuid}')">Update</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- Modal Update Parent Status -->
            <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateModalLabel">Update Student Status</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form id="updateStudentForm" action="update-inactive-student" method="post">
                            <div class="modal-body">
                                <input type="hidden" id="stuid" name="stuid">
                                <div class="form-group">
                                    <label for="statusSelect"> Status:</label>
                                    <select class="form-control" id="statusSelect" name="status">
                                        <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                                        <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                                <button type="submit" class="btn btn-danger">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Paging  -->
            <div class="pagination-container">
                <c:if test="${!empty inactive}">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'inactive-student?index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'inactive-student?index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'inactive-student?index=${index + 1}'">Next</button>
                    </c:if>
                </c:if>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script src="script.js"></script>

        <script>
                            let updateStudentId; // store the ID of the student to be updated

                            // Function to display status update modal
                            function showUpdateModal(stuid) {
                                updateStudentId = stuid; // Save student ID
                                $('#stuid').val(stuid); // Set the value of hidden input
                                $('#updateModal').modal('show'); // display modal
                            }
        </script>
    </body>
</html>
