<%-- 
    Document   : Classes_function
    Created on : May 24, 2024, 7:07:58 PM
    Author     : DELL
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .btn-campus {
                background-color: #39BACD;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .btn-campus:hover {
                background-color: #39BACD;
            }
            .custom-link:active {
                font-weight: bold;
            }
            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
            }
            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body class="container mt-5">
        <div class="content-wrapper">
            <div class="mb-3">
                <button class="btn btn-campus" onclick="window.location.href = 'StudentView.jsp'">Home</button>
            </div>

            <form action="classController" method="GET" class="form-inline mb-3">
                <label for="yearSelect" class="mr-2">Select Year:</label>
                <select name="yid" id="yearSelect" class="form-control" onchange="this.form.submit()">
                    <option value="">Select a year</option>
                    <c:forEach var="year" items="${requestScope.listYear}">
                        <option value="${year.yid}" <c:if test="${param.yid == year.yid}">selected</c:if>>
                            ${year.dateStart} - ${year.dateEnd}
                        </option>
                    </c:forEach>
                </select>
            </form>

            <h2>Class Student In Year: <c:out value="${selectedYear[0].dateStart} - ${selectedYear[0].dateEnd}"/></h2>
            <div class="row">
                <div class="col-md-2 mb-3">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="thead-dark">
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
                    
                        <table class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
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
                                    <c:forEach var="s" items="${requestScope.studentClassSessionbyCsid}">
                                        <c:forEach var="l" items="${requestScope.lecClassSessionbyCsid2}">
                                            <tr>
                                                <td>${s.stuid.stuid}</td>
                                                <td>${s.stuid.sname}</td>
                                                <td>${s.stuid.dob}</td>
                                                <td></td>
                                                <td>${s.csid.rid.rname}</td>
                                                <td>${s.csid.sid.sname}</td>
                                                <td>${l.lid.lname}</td>
                                                <td>${s.csid.classID.clname}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </c:if>
                            </tbody>
                        </table>
                    
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
