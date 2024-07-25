<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Session</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Fredoka One', cursive;
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

            .card {
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                border: none;
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
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header">
                            <h2>Add Session</h2>
                        </div>
                        <div class="card-body">
                            <form action="add-sessions" method="POST">
                                <div class="form-group">
                                    <label for="sname">Course Name</label>
                                    <input type="text" class="form-control" id="sname" name="sname" required>
                                </div>
                                <div class="form-group">
                                    <label for="totalSession">Total Number of Lessons</label>
                                    <input type="number" class="form-control" id="totalSession" name="totalSession" required>
                                </div>
                                <div class="form-group">
                                    <label for="age">Age group</label>
                                    <select class="form-control" id="class" name="ageid" required>
                                        <option>Select Age Group</option>
                                        <c:forEach items="${requestScope.list}" var="age">
                                            <option value="${age.ageid}">${age.aname}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                    <button type="button" class="btn btn-info" onclick="window.location.href = 'session'">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
