<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Feedback Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
            <form action="liststudent" method="GET">
                <input type="hidden" value="${sessionScope.lid}" name="lid"/>
                <a onclick="window.location.href='liststudent?lid=${sessionScope.lid}'">Back to List Student</a>
            </form>    
            <h1 class="name">Feedback Management</h1>
        </header>

        <div class="main">
            <!-- Display error message if present -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Student Name</th>
                        <th>Feedback Title</th>
                        <th>Feedback Content</th>
                        <th>Feedback Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedback}">
                        <tr>
                            <td>${feedback.stuid.sname}</td>
                            <td>${feedback.ftitle}</td>
                            <td>${feedback.fcontent}</td>
                            <td>${feedback.dateFeedback}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="editFeedback('${feedback.fid}', '${feedback.stuid.stuid}', '${feedback.stuid.sname}', '${feedback.ftitle}', '${feedback.fcontent}', '${feedback.dateFeedback}')">Update</button>
                                &nbsp
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteFeedback('${feedback.fid}')">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Update Feedback Modal -->
        <div class="modal fade" id="updateFeedbackModal" tabindex="-1" aria-labelledby="updateFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateFeedbackModalLabel">Update Feedback</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body"> 
                        <form id="updateFeedbackForm" action="update-feedback" method="POST">
                            <input type="hidden" id="lid" name="lid" value="${lec.lid}">
                            <div class="form-group">
                                <label for="updateFeedbackId">Feedback ID</label>
                                <input type="text" class="form-control" name="fid" id="updateFeedbackId" readonly>
                            </div>
                            <div class="form-group">
                                <label for="updateStudentId">Student ID</label>
                                <input type="text" class="form-control" name="stuid" id="updateStudentId" readonly>
                            </div>
                            <div class="form-group">
                                <label for="updateStudentName">Student Name</label>
                                <input type="text" class="form-control" name="sname" id="updateStudentName" readonly>
                            </div>
                            <div class="form-group">
                                <label for="updateFeedbackTitle">Feedback Title</label>
                                <input type="text" class="form-control" name="ftitle" id="updateFeedbackTitle" required>
                            </div>
                            <div class="form-group">
                                <label for="updateFeedbackContent">Feedback Content</label>
                                <textarea class="form-control" name="fcontent" id="updateFeedbackContent" rows="3" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="updateFeedbackDate">Feedback Date</label>
                                <input type="date" class="form-control" name="dateFeedback" id="updateFeedbackDate" value="${currentDate}" readonly>
                            </div>         
                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Feedback Modal -->
        <div class="modal fade" id="deleteFeedbackModal" tabindex="-1" aria-labelledby="deleteFeedbackModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteFeedbackModalLabel">Delete Feedback</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this feedback item?</p>
                        <form id="deleteFeedbackForm" action="delete-feedback" method="post">
                            <input type="hidden" name="fid" id="deleteFeedbackId">
                            <input type="hidden" id="lid" name="lid" value="${lec.lid}">
                            <input type="hidden" name="dateFeedback" value="<%= request.getParameter("dateFeedback") %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
                                    function deleteFeedback(feedbackId) {
                                        document.getElementById('deleteFeedbackId').value = feedbackId;
                                        $('#deleteFeedbackModal').modal('show');
                                    }

                                    function editFeedback(fid, stuid, sname, ftitle, fcontent, currentDate) {
                                        document.getElementById('updateFeedbackId').value = fid;
                                        document.getElementById('updateStudentId').value = stuid;
                                        document.getElementById('updateStudentName').value = sname;
                                        document.getElementById('updateFeedbackTitle').value = ftitle;
                                        document.getElementById('updateFeedbackContent').value = fcontent;
                                        document.getElementById('updateFeedbackDate').value = currentDate;
                                        $('#updateFeedbackModal').modal('show');
                                    }
        </script>
    </body>
</html>
