<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Parent Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }

        h2 {
            margin-bottom: 20px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .modal-header {
            background-color: #007bff;
            color: white;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .form-group label {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Parent Management</h2>

    <div class="row mt-3">
        <div class="col-sm-6">
            <form class="form-inline" action="search-parent" method="post">
                <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search parent..." required>
                <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        <div class="col-sm-6 text-right">
            <button class="btn btn-primary mr-2" id="addNewParentBtn" data-toggle="modal" data-target="#parentModal">Add New Parent</button>
        </div>
    </div>

    <table class="table table-bordered mt-3">
        <thead>
        <tr>
            <th>Parent ID</th>
            <th>Parent Name</th>
            <th>Gender</th>
            <th>DOB</th>
            <th>Phone Number</th>
            <th>ID Card</th>
            <th>Address</th>
            <th>Email</th>
            <th>Nickname</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty searchparent}">
                <c:forEach var="parent" items="${searchparent}">
                    <tr>
                        <td>${parent.pid}</td>
                        <td>${parent.pname}</td>
                        <td>${parent.gender ? 'Male' : 'Female'}</td>
                        <td>${parent.dob}</td>
                        <td>${parent.phoneNumber}</td>
                        <td>${parent.IDcard}</td>
                        <td>${parent.address}</td>
                        <td>${parent.email}</td>
                        <td>${parent.nickname}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach var="parent" items="${parentList}">
                    <tr>
                        <td>${parent.pid}</td>
                        <td>${parent.pname}</td>
                        <td>${parent.gender ? 'Male' : 'Female'}</td>
                        <td>${parent.dob}</td>
                        <td>${parent.phoneNumber}</td>
                        <td>${parent.IDcard}</td>
                        <td>${parent.address}</td>
                        <td>${parent.email}</td>
                        <td>${parent.nickname}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>

    <!-- Modal for adding new parent -->
    <form id="parentForm" action="add-new-parent" method="post">
        <div class="modal fade" id="parentModal" tabindex="-1" aria-labelledby="parentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="parentModalLabel">Add Parent Information</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Parent information -->
                        <div class="form-group">
                            <label for="pname">Parent Name</label>
                            <input type="text" class="form-control" id="pname" name="pname" required>
                        </div>
                        <div class="form-group">
                            <label for="pgender">Gender</label>
                            <select class="form-control" id="pgender" name="gender" required>
                                <option value="true">Male</option>
                                <option value="false">Female</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pdob">Date of Birth</label>
                            <input type="date" class="form-control" id="pdob" name="dob" required>
                            <% if (request.getAttribute("dobError") != null) { %>
                            <%= request.getAttribute("dobError") %>
                            <% } %>
                            </span> 
                        </div>
                        <div class="form-group">
                            <label for="pphone">Phone Number</label>
                            <input type="text" class="form-control" id="pphone" name="phoneNumber" required>
                        </div>
                        <div class="form-group">
                            <label for="pidCard">ID Card</label>
                            <input type="text" class="form-control" id="pidCard" name="IDcard" required>
                        </div>
                        <div class="form-group">
                            <label for="pemail">Email</label>
                            <input type="email" class="form-control" id="pemail" name="email" required>
                            <span id="emailError" class="text-danger">
                                <% if (request.getAttribute("emailError") != null) { %>
                                <%= request.getAttribute("emailError") %>
                                <% } %>
                            </span>
                        </div>
                        <div class="form-group">
                            <label for="paddress">Address</label>
                            <input type="text" class="form-control" id="paddress" name="address" required>
                        </div>
                        <div class="form-group">
                            <label for="nickname">Nickname</label>
                            <input type="text" class="form-control" id="nickname" name="nickname" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>
