<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Class Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FDF5E6;
                font-family: 'Roboto', cursive, sans-serif;
                color: #555;
            }
            .header, .btn-campus, .modal-header {
                background-color: #03ADD5;
                color: #fff;
            }
            .btn-campus {
                border: 2px solid black;
                border-radius: 15px;
            }
            .btn-campus:hover {
                background-color: #FF6347;
            }
            .table thead {
                background-color: #03ADD5;
                color: white;
            }
            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
                border: 2px solid #000;
                border-radius: 10px;
            }
            .modal-content {
                border-radius: 20px;
            }
            .form-group label {
                font-weight: bold;
                color: black;
            }
            .form-control {
                border: 2px solid #2acee8;
                border-radius: 10px;
            }
            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
                background-color: #fff;
                border: 3px solid #25CFC7;
                border-radius: 20px;
            }
            .alert {
                border: 2px solid #FF6347;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="content-wrapper">
            <div class="header text-center py-3 mb-4">
                <h1>Class Management</h1>
            </div>

            <div class="mb-3 text-center">
                <button class="btn btn-campus" onclick="window.location.href = 'adminhome'">Back to Home</button>
                <button class="btn btn-campus" data-toggle="modal" data-target="#createYearModal">Create New School Year</button>
                <button class="btn btn-campus" onclick="checkSchoolYearAndRedirect('classSession-add')">Add/Update Class Session</button>
            </div>

            <c:if test="${not empty err}">
                <div class="alert alert-danger text-center" role="alert">
                    ${err}
                </div>
            </c:if>

            <form action="classController" method="GET" class="form-inline mb-3 justify-content-center">
                <label for="yearSelect" class="mr-2">Select Year:</label>
                <select name="yid" id="yearSelect" class="form-control" onchange="this.form.submit()">
                    <option value="">Select a year</option>
                    <c:forEach var="year" items="${requestScope.listYear}">
                        <option value="${year.yid}" <c:if test="${param.yid == year.yid || fn:contains(requestScope.yid, year.yid)}">selected</c:if>>
                            ${year.dateStart} - ${year.dateEnd}
                        </option>
                    </c:forEach>
                </select>
            </form>

            <c:if test="${not empty selectedYear}">
                <h2 class="text-center mb-4">Class Student In Year: <c:out value="${selectedYear[0].dateStart} - ${selectedYear[0].dateEnd}"/></h2>
            </c:if>

            <div class="row">
                <div class="col-md-2 mb-3">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr><th>List Class</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cl" items="${requestScope.listClassSession}">
                                    <tr>
                                        <td><b><a href="classController?yid=${param.yid}&csid=${cl.csid}" class="text-decoration-none">${cl.classID.clname}</a></b></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Date Of Birth</th>
                                    <th>Age</th>
                                    <th>Room Name</th>
                                    <th>Session Name</th>
                                    <th>Lecturers</th>
                                    <th>Group Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty requestScope.studentClassSessionbyCsid}">
                                    <c:forEach var="s" items="${requestScope.studentClassSessionbyCsid}" varStatus="idex">
                                        <tr>
                                            <td>${idex.index + 1}</td>
                                            <td>${s.stuid.stuid}</td>
                                            <td>${s.stuid.sname}</td>
                                            <td>${s.stuid.dob}</td>
                                            <td>${s.csid.sid.age.ageid} tuổi</td>
                                            <td>${s.csid.rid.rname}</td>
                                            <td>${s.csid.sid.sname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty requestScope.lecClassSessionbyCsid2}">
                                                        <c:forEach var="lec" items="${requestScope.lecClassSessionbyCsid2}" varStatus="status">
                                                            ${lec.lid.lname}<c:if test="${!status.last}">,</c:if><br/>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        N/A
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${s.csid.classID.clname}</td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty requestScope.studentClassSessionbyCsid}">
                                    <tr>
                                        <td colspan="9" class="text-center">No students available for this class session.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal for creating new school year -->
        <div class="modal fade" id="createYearModal" tabindex="-1" role="dialog" aria-labelledby="createYearModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createYearModalLabel">Create New School Year</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="newyear" method="POST">
                        <div class="modal-body">
                            <c:if test="${not empty modalError}">
                                <div class="alert alert-danger" role="alert">
                                    ${modalError}
                                </div>
                            </c:if>
                            <div class="form-group">
                                <label for="dateStart">Start Date:</label>
                                <input type="date" class="form-control" id="dateStart" name="dateStart" required>
                            </div>
                            <div class="form-group">
                                <label for="dateEnd">End Date:</label>
                                <input type="date" class="form-control" id="dateEnd" name="dateEnd" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- SweetAlert2 library -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                    function checkSchoolYearAndRedirect(action) {
                        var selectedYear = document.getElementById('yearSelect').value;
                        if (!selectedYear || selectedYear === "") {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Please create a new school year before using this functionality!'
                            });
                        } else {
                            window.location.href = action;
                        }
                    }

                    $(document).ready(function () {
            <c:if test="${not empty modalOpen}">
                        $('#createYearModal').modal({
                            backdrop: 'static',
                            keyboard: false
                        });
            </c:if>
                    });
        </script>
    </body>
</html>
