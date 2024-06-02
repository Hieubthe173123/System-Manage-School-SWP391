<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecturers Management</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
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

            .Endpage {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .Endpage .page-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 5px 10px;
                margin: 0 5px;
                border-radius: 5px;
                cursor: pointer;
            }

            .Endpage .page-btn:hover {
                background-color: #0056b3;
            }

            .Endpage .page-btn.active {
                background-color: #0056b3;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Lecturers Management</h2>
            <div class="row w-100 mb-3">
                <div class="col-sm-6 mb-3 d-flex justify-content-between">


                    <form class="form-inline" action="search-lecturers" method="GET">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search" required>
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                    <select onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value)">
                        <option value="">Select Year School</option>
                        <c:forEach var="SchoolYear" items="${listB}">
                            <option value="lecturers?timeStart=${SchoolYear.dateStart}&timeEnd=${SchoolYear.dateEnd}" 
                                    <c:if test="${param.timeStart == SchoolYear.dateStart && param.timeEnd == SchoolYear.dateEnd}">selected</c:if>>
                                ${SchoolYear.dateStart} - ${SchoolYear.dateEnd}
                            </option>
                        </c:forEach>
                    </select>

                </div>
                <div class="col-md-4">
                    <button class="btn btn-primary" id="addNewLecturerBtn" data-toggle="modal" data-target="#lecturerModal">Add New Lecturer</button>
                </div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <c:choose>
                        <c:when test="${not empty listC}">
                            <tr>
                                <th>LecturerID</th>
                                <th>Lecturer Name</th>
                                <th>Class Name</th>
                                <th>Actions</th>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <th>LecturerID</th>
                                <th>Lecturer Name</th>
                                <th>IDCard</th>
                                <th>DOB</th>
                                <th>Gender</th>
                                <th>Phone Number</th>     
                                <th>Actions</th>
                            </tr>
                        </c:otherwise>
                    </c:choose>

                </thead>
                <tbody>
                    <c:forEach var="lecturer" items="${searchResults}">
                        <tr>
                            <td>${lecturer.lid}</td>
                            <td>${lecturer.lname}</td>
                            <td>${lecturer.IDcard}</td>
                            <td>${lecturer.dob}</td>
                            <td>${lecturer.gender ? 'Male' : 'Female'}</td>
                            <td>${lecturer.phoneNumber}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="editLecturer(${lecturer.lid})">Update</button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal(${lecturer.lid})">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>


                    <c:choose>
                        <c:when test="${not empty listC}">
                            <c:forEach var="lecturer" items="${listC}">
                                <tr>
                                    <td>${lecturer.lid.lid}</td>
                                    <td>${lecturer.lid.lname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${lecturer.csid.classID != null}">
                                                ${lecturer.csid.classID.clname}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-warning btn-sm" onclick="editLecturer(${lecturer.lid.lid})">Update</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal(${lecturer.lid.lid})">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="lecturer" items="${listA}">
                                <tr>
                                    <td>${lecturer.lid}</td>
                                    <td>${lecturer.lname}</td>
                                    <td>${lecturer.IDcard}</td>
                                    <td>${lecturer.dob}</td>
                                    <td>${lecturer.gender ? 'Male' : 'Female'}</td>
                                    <td>${lecturer.phoneNumber}</td>

                                    <td>
                                       <button class="btn btn-warning btn-sm" id="addNewLecturerBtn" data-toggle="modal" 
                                               onclick="window.location.href = 'update-lecturers?lid=${lecturer.lid}'">Update</button>


                                        <button type="button" class="btn btn-danger btn-sm" onclick="showDeleteModal(${lecturer.lid})">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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

        <!-- Pagination -->
        <!-- Pagination -->
        <c:choose>
            <c:when test="${not empty listC}">
                <div class="Endpage">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'lecturers?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'lecturers?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'lecturers?timeStart=${param.timeStart}&timeEnd=${param.timeEnd}&index=${index + 1}'">Next</button>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="Endpage">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'lecturers?index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'lecturers?index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'lecturers?index=${index + 1}'">Next</button>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>



        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
                            let deleteLecturerId;

                            function showDeleteModal(lid) {
                                deleteLecturerId = lid;
                                $('#deleteLecturerModal').modal('show');
                            }

                            document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
                                const form = document.createElement('form');
                                form.method = 'POST';
                                form.action = 'delete-lecturer';

                                const input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = 'lid';
                                input.value = deleteLecturerId;

                                form.appendChild(input);
                                document.body.appendChild(form);
                                form.submit();
                            });


        </script>
    </body>
</html>
