<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Curriculum</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Open Sans', cursive;
                font-weight: bold;
                padding-top: 40px; /* for Bootstrap navbar */
            }

            .container {
                max-width: 1000px;
                margin: auto;
                background-color: #FFFFFF;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
                padding: 20px;
            }

            h2 {
                color: #03ADD5;
                text-align: center;
                margin-bottom: 20px;
                font-size: 1.5rem;
            }

            .text-center {
                width: 100%;
                text-align: center;
                margin-bottom: 20px;
            }

            .alert {
                margin-bottom: 20px;
            }

            .form-group label {
                color: #03ADD5;
            }

            .form-group input, .form-group select {
                border: 2px solid #03ADD5;
                border-radius: 10px;
                padding: 5px;
                font-size: 0.9rem;
                background-color: #FFF7E0;
            }

            .btn-primary, .btn-info {
                background-color: #41E0B3;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
            }

            .btn-primary:hover, .btn-info:hover {
                background-color: #FF9800;
            }

            .form-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .form-container .card {
                flex: 1;
                margin: 10px;
                min-width: 45%; /* Adjusted to fit two columns */
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #f0f9ff;
                padding: 1rem;
                border-radius: 10px 10px 0 0;
            }

            .card-body {
                padding: 2rem;
            }
        </style>
    </head>
    <body>
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h2>Add Activity</h2>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty sessionScope.message}">
                                <div class="alert alert-${sessionScope.messageType == 'success' ? 'success' : 'danger'}">
                                    ${sessionScope.message}
                                </div>
                                <c:remove var="message" scope="session"/>
                                <c:remove var="messageType" scope="session"/>
                            </c:if>
                            <form action="add-curiculum" method="POST">
                                <c:if test="${not empty param.sid}">
                                    <input type="hidden" name="sid" value="${param.sid}">
                                </c:if>
                                <c:if test="${not empty param.sdid}">
                                    <input type="hidden" name="sdid" value="${param.sdid}">
                                </c:if>
                                <div class="form-group">
                                    <label for="nameAct">Activity Name</label>
                                    <input type="text" class="form-control" id="nameAct" name="nameAct" required>
                                </div>
                                <div class="form-group">
                                    <label for="isFix">Type of Activity</label>
                                    <select class="form-control" id="isFix" name="isFix" required>
                                        <option value="true">Hard operation</option>
                                        <option value="false">Operating normally</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="timeSlot">Class Time Frame</label>
                                    <select class="form-control" id="timeSlot" name="timeSlot" required>
                                        <option value="07:30-09:00">07:30 - 09:00</option>
                                        <option value="09:00-11:00">09:00 - 11:00</option>
                                        <option value="11:00-13:00">11:00 - 13:00</option>
                                        <option value="13:00-15:00">13:00 - 15:00</option>
                                        <option value="15:00-16:30">15:00 - 16:30</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Add</button>
                                <button type="button" class="btn btn-danger" onclick="window.location.href = 'session-detail?sid=${param.sid}&sdid=${param.sdid}'">Cancel</button>
                            </form>
                            <table class="table table-bordered mt-4">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Activity</th>
                                        <th>Start Time</th>
                                        <th>End Time</th>
                                        <th>Type</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="activity" items="${requestScope.list}">
                                        <tr>
                                            <td>${activity.nameAct}</td>
                                            <td>${activity.timeStart}</td>
                                            <td>${activity.timeEnd}</td>
                                            <td><c:out value="${activity.isFix ? 'Fixed Activity' : 'Normal Activity'}" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>