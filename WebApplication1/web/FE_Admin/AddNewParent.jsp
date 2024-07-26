<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Parent and Student</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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
        <div class="container">
            <h2 class="text-center">Add New Parent and Student</h2>
            <form id="parentStudentForm" action="add-parent" method="post">
                <div class="form-container">
                    <div class="card">
                        <div class="card-header">
                            <h5>Parent Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="pname">Parent Name</label>
                                <input type="text" class="form-control" id="pname" name="pname" value="${not empty param.pname ? param.pname : ''}" required>
                            </div>
                            <% String Error = (String) request.getAttribute("Error");
                            if (Error != null) { %>
                            <p class="text-danger" id="message">${Error}</p>
                            <% } %>
                            <div class="form-group">
                                <label for="pgender">Gender</label>
                                <select class="form-control" id="pgender" name="gender" required>
                                    <option value="true" ${param.gender == 'true' ? 'selected' : ''}>Male</option>
                                    <option value="false" ${param.gender == 'false' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="pdob">Date of Birth</label>
                                <input type="date" class="form-control" id="pdob" name="dob" value="${not empty param.dob ? param.dob : ''}" required>
                                <% if (request.getAttribute("dobError") != null) { %>
                                <span class="text-danger"><%= request.getAttribute("dobError") %></span>
                                <% } %>
                            </div>
                            <% String ErrorPhone = (String) request.getAttribute("ErrorPhone");
                            if (ErrorPhone != null) { %>
                            <p class="text-danger" id="message">${ErrorPhone}</p>
                            <% } %>
                            <div class="form-group">
                                <label for="pphone">Phone Number</label>
                                <input type="number" class="form-control" id="pphone" name="phoneNumber" value="${not empty param.phoneNumber ? param.phoneNumber : ''}" required>
                            </div>
                            <% String ErrorIdCard = (String) request.getAttribute("ErrorIdCard");
                            if (ErrorIdCard != null) { %>
                            <p class="text-danger" id="message">${ErrorIdCard}</p>
                            <% } %>
                            <div class="form-group">
                                <label for="pidCard">ID Card</label>
                                <input type="number" class="form-control" id="pidCard" name="IDcard" value="${not empty param.IDcard ? param.IDcard : ''}" required>
                            </div>
                            <% String ErrorEmail = (String) request.getAttribute("ErrorEmail");
                            if (ErrorEmail != null) { %>
                            <p class="text-danger" id="message">${ErrorEmail}</p>
                            <% } %>
                            <div class="form-group">
                                <label for="pemail">Email</label>
                                <input type="email" class="form-control" id="pemail" name="email" value="${not empty param.email ? param.email : ''}" required>
                                <% if (request.getAttribute("emailError") != null) { %>
                                <span id="emailError" class="text-danger"><%= request.getAttribute("emailError") %></span>
                                <% } %>
                            </div>
                            <div class="form-group">
                                <label for="paddress">Address</label>
                                <input type="text" class="form-control" id="paddress" name="address" value="${not empty param.address ? param.address : ''}" required>
                            </div>
                            <div class="form-group">
                                <label for="nickname">Nickname</label>
                                <input type="text" class="form-control" id="nickname" name="nickname" value="${not empty param.nickname ? param.nickname : ''}" required>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h5>Student Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="form-group">
                                <label for="sName">Student Name</label>
                                <input type="text" class="form-control" id="sName" name="sName" value="${not empty param.sName ? param.sName : ''}" required>
                            </div>
                              <% String ErrorNameStu = (String) request.getAttribute("ErrorNameStu");
                            if (ErrorNameStu != null) { %>
                            <p class="text-danger" id="message">${ErrorNameStu}</p>
                            <% } %>
                            <div class="form-group">
                                <label for="sDob">Date of Birth</label>
                                <input type="date" class="form-control" id="sDob" name="sDob" value="${not empty param.sDob ? param.sDob : ''}" required>
                            </div>
                            <div class="form-group">
                                <label for="sGender">Gender</label>
                                <select class="form-control" id="sGender" name="sGender" required>
                                    <option value="true" ${param.sGender == 'true' ? 'selected' : ''}>Male</option>
                                    <option value="false" ${param.sGender == 'false' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="sAddress">Address</label>
                                <input type="text" class="form-control" id="sAddress" name="sAddress" value="${not empty param.sAddress ? param.sAddress : ''}" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="classId">Class ID</label>
                                <select class="form-control" id="classId" name="classId" required>
                                    <option value="">Select Class</option>
                                    <c:forEach var="classSession" items="${classIDs}">
                                        <option value="${classSession.classID.classid}" ${param.classId == classSession.classID.classid ? 'selected' : ''}>
                                            ${classSession.classID.clname}
                                        </option>
                                    </c:forEach>
                                </select>
                                <% String ErrorClass = (String) request.getAttribute("ErrorClass");
                            if (ErrorClass != null) { %>
                            <p class="text-danger" id="message">${ErrorClass}</p>
                            <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                    <button type="submit" class="btn-primary">Add Parent and Student</button>
                </div>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
