<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>History Selection</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- FontAwesome for Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #FFFAF0;
                font-family: 'Roboto', sans-serif;
            }
            .container {
                margin-top: 50px;
                max-width: 1200px;
            }
            h1 {
                margin-bottom: 30px;
                color: #03ADD5;
                text-align: center;
                font-weight: bold;
            }
            select {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ced4da;
                margin-bottom: 20px;
                background-color: #e9f7fd;
                color: #007bff;
            }
            .lecture {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
                margin-bottom: 20px;
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .lecture:hover {
                transform: translateY(-10px);
                box-shadow: 0 0 20px rgba(0, 123, 255, 0.3);
            }
            .lecture h2 {
                font-size: 20px;
                margin-bottom: 10px;
                color: #007bff;
            }
            .lecture p {
                margin: 0;
                color: #343a40;
            }
            .lecture p.default {
                color: #6c757d;
            }
            .lecture-icon {
                font-size: 40px;
                color: #007bff;
                margin-bottom: 15px;
            }
            .btn-custom {
                background-color: #03ADD5;
                color: white;
                border-radius: 5px;
                padding: 10px 20px;
                margin-bottom: 20px;
                display: inline-block;
                transition: background-color 0.3s;
            }
            .btn-custom:hover {
                background-color: #0288D1;
                text-decoration: none;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>History Management</h1>
            <div class="text-center">
                <a href="lecturers" class="btn btn-custom">Back to Lecturer</a>
            </div>
            <select class="form-control" id="year-select">
                <option value="">Select a period</option>
                <c:forEach var="year" items="${requestScope.year}">
                    <option value="${year.yid}" <c:if test="${param.yid == year.yid}">selected</c:if>>${year.dateStart} - ${year.dateEnd}</option>
                </c:forEach>
            </select>

            <div class="row" id="lectures">
                <c:forEach var="lec" items="${requestScope.lec}" varStatus="status">
                    <div class="col-md-3 col-sm-6 mb-4">
                        <div class="lecture">
                            <i class="lecture-icon fas fa-chalkboard-teacher"></i>
                            <h2>${lec.lid.lname}</h2>
                            <p><a href="history-detail?lid=${lec.lid.lid}">Lecture Details</a></p>
                            <p><a href="history-update-lecturers?yid=${param.yid}&lid=${lec.lid.lid}"><strong>Class:</strong> 
                                    <c:choose>
                                        <c:when test="${empty lec.csid.classID.clname}">Không dạy lớp nào</c:when>
                                        <c:otherwise>${lec.csid.classID.clname}</c:otherwise>
                                    </c:choose>
                                </a></p>
                            <p><strong>Lecture ID:</strong> ${lec.lid.lid}</p>
                            <p><strong>Status:</strong> 
                                <c:choose>
                                    <c:when test="${empty lec.lid.status}">Inactive</c:when>
                                    <c:otherwise>${lec.lid.status}</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    <c:if test="${status.index % 4 == 3}">
                    </div><div class="row">
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
            document.getElementById('year-select').addEventListener('change', function () {
                var yid = this.value;
                if (yid) {
                    window.location.href = 'history?yid=' + yid;
                }
            });
        </script>
    </body>
</html>
