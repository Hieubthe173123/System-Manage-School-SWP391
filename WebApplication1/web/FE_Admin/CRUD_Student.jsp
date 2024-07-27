<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
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
                background: #03ADD5; /* Light blue background for the header */
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
                gap: 15px; /* Increased spacing between buttons */
            }

            .header-buttons a {
                background-color: #FF6F61; /* Coral color for buttons */
                border-color: #FF6F61;
                color: white;
                border-radius: 20px;
                padding: 0.5rem 1rem;
                text-decoration: none;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

            .header-buttons a:hover {
                background-color: #FF4D4D; /* Darker coral color on hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .header-buttons .btn-parent {
                background-color: #4CAF50; /* Green color for Parent Management */
                border-color: #4CAF50;
            }

            .header-buttons .btn-parent:hover {
                background-color: #45A049; /* Darker green on hover */
            }

            .header-buttons .btn-inactive {
                background-color: #FF9800; /* Orange color for Inactive Students */
                border-color: #FF9800;
            }

            .header-buttons .btn-inactive:hover {
                background-color: #FB8C00; /* Darker orange on hover */
            }

            .header-buttons .btn-home {
                border-color: #2196F3;
            }

            .header-buttons .btn-home:hover {
                background-color: #1976D2; /* Darker blue on hover */
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
            <h1>Student Management</h1>
            <div class="header-buttons">
                <a href="parent" class="btn-custom btn-parent">Parent Management</a>
                <a href="inactive-student" class="btn-custom btn-inactive">Inactive Students</a>
                <a href="adminhome" class="btn-custom btn-home">Back to Home</a>
            </div>
        </header>



        <div class="container">
            <div class="row mb-3">
                <div class="col-sm-12 col-md-6">
                    <form class="form-inline" action="search-student" method="GET">
                        <input class="form-control mr-2" type="search" name="searchInput" placeholder="Search student..." required>
                        <button class="btn btn-success my-2 my-sm-0 btn-custom" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-sm-12 col-md-6">
                    <form action="student" method="GET" class="form-inline float-md-right">
                        <label for="classSelect" class="mr-2">Select Class:</label>
                        <select name="classId" id="classSelect" class="form-control" onchange="this.form.submit()">
                            <option value="">Select Class</option>
                            <c:forEach var="classSession" items="${classIDs}">
                                <option value="${classSession.classID.classid}" <c:if test="${param.classId == classSession.classID.classid}">selected</c:if>>
                                    ${classSession.classID.clname}
                                </option>
                            </c:forEach>
                        </select>
                    </form>
                </div>
            </div>

            <table class="table table-bordered">
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
                        <c:when test="${not empty search}">
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
                                        <a class="btn btn-warning btn-sm btn-custom" href="update-student?stuid=${studentClass.stuid.stuid}&sname=${studentClass.stuid.sname}&dob=${studentClass.stuid.dob}&gender=${studentClass.stuid.gender}&address=${studentClass.stuid.address}&classid=${studentClass.csid.classID.classid}">Update</a>
                                        <a class="btn btn-sm btn-custom" style="background-color: #20B2AA; color: white;" href="update-student-class?stuid=${studentClass.stuid.stuid}&classid=${studentClass.csid.classID.classid}">Update Class</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:when test="${not empty allStudent}">
                            <c:forEach var="studentClass" items="${allStudent}" varStatus="status">
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
                                        <a class="btn btn-warning btn-sm btn-custom" href="update-student?stuid=${studentClass.stuid.stuid}&sname=${studentClass.stuid.sname}&dob=${studentClass.stuid.dob}&gender=${studentClass.stuid.gender}&address=${studentClass.stuid.address}&classid=${studentClass.csid.classID.classid}">Update</a>
                                        <a class="btn btn-sm btn-custom" style="background-color:#20B2AA; color: white;" href="update-student-class?stuid=${studentClass.stuid.stuid}&classid=${studentClass.csid.classID.classid}">Update Class</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:when test="${not empty studentList}">
                            <c:forEach var="studentClass" items="${studentList}" varStatus="status">
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
                                        <a class="btn btn-warning btn-sm btn-custom" href="update-student?stuid=${studentClass.stuid.stuid}&sname=${studentClass.stuid.sname}&dob=${studentClass.stuid.dob}&gender=${studentClass.stuid.gender}&address=${studentClass.stuid.address}&classid=${studentClass.csid.classID.classid}">Update</a>
                                         <a class="btn btn-sm btn-custom" style="background-color:#20B2AA; color: white;" href="update-student-class?stuid=${studentClass.stuid.stuid}&classid=${studentClass.csid.classID.classid}">Update Class</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                    </c:choose>
                </tbody>
            </table>

            <div class="pagination-container">
                <c:if test="${!empty allStudent}">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'student?index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'student?index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'student?index=${index + 1}'">Next</button>
                    </c:if>
                </c:if>
            </div>

            <div class="pagination-container">
                <c:if test="${!empty studentList}">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'student?classId=${classId}&index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'student?classId=${classId}&index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'student?classId=${classId}&index=${index + 1}'">Next</button>
                    </c:if>
                </c:if>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>