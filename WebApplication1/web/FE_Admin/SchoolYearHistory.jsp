<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>History SchoolYear Students</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', cursive;
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
                position: relative;
            }

            header a {
                position: absolute;
                right: 1rem;
                top: 1rem;
                color: white;
                text-decoration: none;
                font-size: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                background: #32CD32;
                transition: background-color 0.3s ease;
            }

            header a:hover {
                background-color: #228B22;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
                flex-grow: 1;
            }

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

            .form-group label {
                font-weight: bold;
            }

            table {
                width: 90%;
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

            @media (max-width: 768px) {
                body {
                    font-size: 14px;
                }

                table {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <h1 class="name">History SchoolYear Students</h1>
            <a class="btn-campus" href="adminhome">Back to Home</a>
        </header>

        <div class="content-wrapper">
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
                <input type="hidden" name="csid" value="${scs.csid}">
                <table class="table table-bordered">
                    <thead class="thead">
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
                                <td>${scs.csid.sid.age.ageid} years</td>
                                <td>${scs.csid.sid.sname}</td>
                                <td>${scs.csid.classID.clname}</td>
                                <td>${scs.csid.yid.dateStart}</td>
                                <td>${scs.csid.yid.dateEnd}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty sessionScope.history}">
                <div class="alert alert-info" role="alert">
                    There is no school year history available for this student.
                </div>
            </c:if>
        </div>
    </body>
</html>
