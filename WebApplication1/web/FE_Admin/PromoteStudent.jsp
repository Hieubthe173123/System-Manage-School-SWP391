<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Promote Students</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-5">
        <h1>Promote Students ( <c:out value="${selectedYear[0].dateStart} - ${selectedYear[0].dateEnd}"/> )</h1>
        <form action="promote" method="GET" class="form-inline mb-3">
            <label for="yearSelect" class="mr-2">Select Year:</label>
            <select name="yid" id="yearSelect" class="form-control" onchange="this.form.submit()">
                <option value="">Select a year</option>
                <c:forEach var="year" items="${listYear}">
                    <option value="${year.yid}" <c:if test="${param.yid == year.yid}">selected</c:if>>
                        ${year.dateStart} - ${year.dateEnd}
                    </option>
                </c:forEach>
            </select>
        </form>

        <c:if test="${not empty param.yid}">
            <form action="promote" method="POST">
                <input type="hidden" name="yid" value="${param.yid}"/>
                <label for="classSelect" class="mr-2">Select New Class:</label>
                <select name="newCsid" id="classSelect" class="form-control" onchange="this.form.submit()">
                    <option value="">Select a class</option>
                    <c:forEach var="cl" items="${listClassSession}">
                        <option value="${cl.csid}" <c:if test="${param.newCsid == cl.csid}">selected</c:if>>
                            ${cl.classID.clname}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </c:if>

        <c:if test="${not empty param.newCsid}">
            <c:set var="previousYearPrinted" value="false" scope="page"/>

            <c:forEach var="student" items="${studentClassSessionOldYear}">
                <c:if test="${previousYearPrinted == 'false'}">
                    <h3>Select Students to Promote in Previous Year ( ${student.csid.yid.dateStart} - ${student.csid.yid.dateEnd} )</h3>
                    <c:set var="previousYearPrinted" value="true" scope="page"/>
                </c:if>
            </c:forEach>

            <form action="promote" method="POST">
                <input type="hidden" name="yid" value="${param.yid}"/>
                <input type="hidden" name="newCsid" value="${param.newCsid}"/>
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Select</th>
                            <th>No.</th>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Gender</th>
                            <th>Date Of Birth</th>
                            <th>Age</th>
                            <th>Class</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty studentClassSessionOldYear}">
                            <c:forEach var="s" items="${studentClassSessionOldYear}" varStatus="idex">
                                <tr>
                                    <td>
                                        <input type="checkbox" name="selectedStudents" value="${s.stuid.stuid}"
                                               <c:if test="${fn:contains(assignedStudents, s.stuid.stuid)}">disabled</c:if>/>
                                        </td>
                                        <td>${idex.index + 1}</td>
                                    <td>${s.stuid.stuid}</td>
                                    <td>${s.stuid.sname}</td>
                                    <td>${s.stuid.gender ? 'Nam' : 'Nữ'}</td>
                                    <td>${s.stuid.dob}</td>
                                    <td>${s.csid.sid.sid} tuổi</td>
                                    <td>${s.csid.classID.clname}</td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <button type="submit" id="dialog" class="btn btn-primary">Promote Selected Students</button>
            </form>
        </c:if>

        <script>
            document.getElementById("dialog").addEventListener('click', function () {
                Swal.fire({
                    title: "Add Successfull",
                    text: "That thing is still around?",
                    icon: "success"
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
