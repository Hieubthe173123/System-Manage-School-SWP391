<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Class</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                background-color: #FFFAF0;
                font-family: 'Roboto', cursive;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                width: 90%;
                max-width: 600px;
                padding: 20px;
                background-color: #FFFFFF;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
            }

            h2 {
                color: #03ADD5;
                text-align: center;
                margin-bottom: 20px;
                font-size: 1.5rem;
            }

            .form-group label {
                color: #03ADD5;
            }

            .form-group select {
                border: 2px solid #03ADD5;
                border-radius: 10px;
                padding: 5px;
                font-size: 0.9rem;
                background-color: #FFF7E0;
            }

            .btn-primary {
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
                border: none;
                background-color: #41E0B3;
            }

            .btn-primary:hover {
                background-color: #33C4A1;
            }

            .error-message {
                color: red;
                text-align: center;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Class</h2>
            <div class="card">
                <div class="card-header">
                    Update Class
                </div>
                <div class="card-body">
                    <form id="updateClassForm" action="update-student-class" method="post">
                        <input type="hidden" name="stuid" value="${param.stuid}">
                        <div class="form-group">
                            <label for="editStudentClassName">Class</label>
                            <select class="form-control" id="editStudentClassName" name="className" required>
                                <c:forEach var="classSession" items="${classIDs}">
                                    <option value="${classSession.classID.classid}" <c:if test="${param.classid == classSession.classID.classid}">selected</c:if>>
                                        ${classSession.classID.clname}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                        <% String Error = (String) request.getAttribute("Error");
                            if (Error != null) { %>
                        <p class="error-message">${Error}</p>
                        <% } %>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



