<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<% Date today = new Date(); %>
<% String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(today); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
        <title>Student Management</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap">
        <style>
            body {
                font-family: 'Roboto', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
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
            .main {
                padding: 20px;
            }
            .name {
                color: white;
                font-size: 1.8em;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
            }
            .btn-group {
                margin-bottom: 20px;
            }
            .btn-custom {
                background-color: #03ADD5;
                border-color: #03ADD5;
                color: white;
                margin: 5px;
                transition: background-color 0.3s ease;
            }
            .btn-custom:hover {
                background-color: #0288D1;
                border-color: #0288D1;
            }
            .dashboard-box {
                text-align: center;
                padding: 20px;
                border-radius: 10px;
                margin: 10px;
                color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .dashboard-box.blue {
                background-color: #03ADD5;
            }
            .dashboard-box.green {
                background-color: #32CD32;
            }
            .dashboard-box.yellow {
                background-color: #FFD54F;
                color: #000;
            }
            .form-inline .form-control {
                width: auto;
            }
            .form-inline button {
                margin-left: 10px;
            }
            .modal-header {
                background-color: #03ADD5;
                color: white;
                border-radius: 10px 10px 0 0;
            }
            .btn-primary {
                background-color: #32CD32;
                border-color: #32CD32;
            }
            .btn-primary:hover {
                background-color: #228B22;
                border-color: #1C6D1F;
            }
            .btn-secondary {
                background-color: #9E9E9E;
                border-color: #9E9E9E;
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
            <h1 class="name">${lec.nickname}</h1>
        </header>

        <div class="main" id="mainContent">
            <h2 class="text-center">FeedBack Management</h2> 
            <div class="btn-group">
                <a class="btn btn-custom" href="timeTableLecturer?lid=${sessionScope.lid}">Back to TimeTable</a>
                <a href="javascri1pt:void(0)" id="listFeedbackLink" class="btn btn-custom">List Feedback</a>
            </div>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    ${successMessage}
                </div>
            </c:if>

            <table class="table table-bordered mt-3">
                <thead>
                    <tr>                   
                        <th>Student Name</th>
                        <th>DOB</th>
                        <th>Gender</th>                  
                        <th>Parent Name</th>
                        <th>Parent Phone</th>
                        <th>Feedback</th>                    
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${allStudent}">
                        <tr>
                            <td>${student.sname}</td>
                            <td>${student.dob}</td>
                            <td>${student.gender ? 'Male' : 'Female'}</td>
                            <td>${student.pid.pname}</td>
                            <td>${student.pid.phoneNumber}</td>
                            <td>
                                <button class="btn btn-primary" onclick="openFeedbackModal(${student.stuid})">Feedback</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Feedback Modal -->
        <div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="feedbackModalLabel">Add Feedback</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form action="feedback" method="POST" id="feedbackForm">
                        <div class="modal-body">
                            <input type="hidden" id="studentId" name="studentId" value="">
                            <input type="hidden" id="lid" name="lid" value="${lec.lid}">
                            <div class="form-group">
                                <label for="fid">Feedback ID</label>
                                <input type="text" class="form-control" name="fid" id="fid" readonly>
                            </div>
                            <div class="form-group">
                                <label for="ftitle">Title</label>
                                <input type="text" class="form-control" id="ftitle" name="ftitle" required>
                            </div>
                            <div class="form-group">
                                <label for="fcontent">Content</label>
                                <textarea class="form-control" id="fcontent" name="fcontent" rows="4" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="dateFeedback">Date</label>
                                <input type="date" class="form-control" id="dateFeedback" name="dateFeedback" value="${currentDate}" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" name="action" value="singleStudent">Submit</button>
                            <button type="submit" class="btn btn-primary" name="action" value="allStudents">Submit All Students</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
                                    
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var listFeedbackLink = document.getElementById("listFeedbackLink");
                                        var lecturerId = "${lec.lid}";
                                        var currentDate = new Date().toISOString().split('T')[0];
                                        listFeedbackLink.href = "list-feedback?lecturerId=" + lecturerId + "&dateFeedback=" + currentDate;
                                    });

                                    function openFeedbackModal(studentId) {
                                        document.getElementById('studentId').value = studentId;

                                        // Set default value for dateFeedback to current date
                                        var today = new Date();
                                        var dd = String(today.getDate()).padStart(2, '0');
                                        var mm = String(today.getMonth() + 1).padStart(2, '0');
                                        var yyyy = today.getFullYear();
                                        var currentDate = yyyy + '-' + mm + '-' + dd;

                                        document.getElementById('dateFeedback').value = currentDate;

                                        $('#feedbackModal').modal('show');
                                    }

                                    function setCurrentDate() {
                                        var today = new Date();
                                        var dd = String(today.getDate()).padStart(2, '0');
                                        var mm = String(today.getMonth() + 1).padStart(2, '0');
                                        var yyyy = today.getFullYear();
                                        var currentDate = yyyy + '-' + mm + '-' + dd;

                                        document.getElementById('displayDate').textContent = currentDate;
                                    }

                                    // Call setCurrentDate when the page loads
                                    window.onload = function () {
                                        setCurrentDate();
                                    };
        </script>
    </body>
</html>