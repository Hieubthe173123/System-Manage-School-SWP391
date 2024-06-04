<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>History SchoolYear Students</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-5">
        <h1>History SchoolYear Students</h1>
        
        <form id="studentForm" action="historyschoolyear" method="GET">
            <div class="form-group">
                <label for="studentSelect">Select a Student:</label>
                <select id="studentSelect" name="selectedStudent" class="form-control" onchange="this.form.submit()">
                    <option value="">Select a student</option>
                    <c:forEach var="stu" items="${sessionScope.students}">
                        <option value="${stu.stuid}" <c:if test="${stu.stuid == selectedStuid}">selected="selected"</c:if>>${stu.stuid} - ${stu.sname}</option>
                    </c:forEach>
                </select>
            </div>
        </form>

        <c:if test="${not empty history}">
            <h2>History for Student ID: ${sessionScope.selectedStuid}</h2>
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Date Of Birth</th>
                        <th>Age</th>
                        <th>Session Name</th>
                        <th>Class</th>
                        <th>Date Start</th>
                        <th>Date End</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="scs" items="${sessionScope.history}">
                        <tr>
                            <td>${scs.stuid.stuid}</td>
                            <td>${scs.stuid.sname}</td>
                            <td>${scs.stuid.dob}</td>
                            <td>${scs.csid.sid.sid} tuổi</td>
                            <td>${scs.csid.sid.sname}</td>
                            <td>${scs.csid.classID.clname}</td>
                            <td>${scs.csid.yid.dateStart}</td>
                            <td>${scs.csid.yid.dateEnd}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </body>
</html>
