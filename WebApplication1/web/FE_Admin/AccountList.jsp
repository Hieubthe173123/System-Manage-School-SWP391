<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account List</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <style>
            body {
                background: #FFFAF0;
                font-family: 'Comic Sans MS', cursive, sans-serif;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            h1 {
                text-align: center;
                color: #39BACD;
                font-size: 2.5rem;
                margin-bottom: 20px;
            }

            .btn-campus {
                background-color: #FF6F61;
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
                border-radius: 10px;
            }

            .btn-campus:hover {
                background-color: #FF6F61;
            }

            .custom-link:active {
                font-weight: bold;
            }

            .form-group label {
                color: #333;
                font-weight: bold;
            }

            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
            }

            .table thead th {
                background-color: #24B2D2;
                color: white;
            }

            .table tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .toggle-password {
                cursor: pointer;
            }

            .input-group-append .btn {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }

            .input-group-append .btn i {
                font-size: 1rem;
            }

            .input-group-append .btn:focus {
                box-shadow: none;
            }

            .badge-success {
                background-color: green;
            }

            .badge-warning {
                background-color: yellow;
            }

        </style>
    </head>
    <body>
        <div class="content-wrapper">
            <h1>Account List</h1>

            <form action="account-list" method="GET">
                <div class="form-group">
                    <label for="roleSelect">Select Role:</label>
                    <select class="form-control" id="roleSelect" name="role">
                        <option value="">All Roles</option>
                        <option value="1" ${1 == requestScope.role ? 'selected' : ''}>Parent</option>
                        <option value="2" ${2 == requestScope.role ? 'selected' : ''}>Lecturers</option>
                        <option value="3" ${3 == requestScope.role ? 'selected' : ''}>Admin</option>
                    </select>
                </div>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Search..." name="searchName"
                           value="${param.searchName}">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-campus">Show Accounts</button>
            </form>
            <button class="btn btn-campus" onclick="window.location.href = 'adminhome'">Back to Home</button>

            <div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Account ID</th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Role</th>
                            <th>PID</th>
                            <th>Parent Name</th>
                            <th>LID</th>
                            <th>Lecturer Name</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="acc" items="${sessionScope.accountList}" varStatus="idex">

                            <tr>
                                <td>${idex.index + 1}</td>
                                <td>${acc.aid}</td>
                                <td>${acc.username}</td>
                                <td>
                                    <div class="input-group">
                                        <input type="password" id="password-${idex.index}" value="${acc.password}" class="form-control" readonly>
                                        <div class="input-group-append">
                                            <span class="input-group-text">
                                                <i id="togglePassword-${idex.index}" class="fa fa-eye toggle-password" onclick="togglePassword(${idex.index})"></i>
                                            </span>
                                        </div>
                                    </div>
                                </td>

                                <td>${acc.role}</td>
                                <td>${acc.pid != null ? acc.pid.pid : ''}</td>
                                <td>${acc.pid != null ? acc.pid.pname : ''}</td>
                                <td>${acc.lid != null ? acc.lid.lid : ''}</td>
                                <td>${acc.lid != null ? acc.lid.lname : ''}</td>

                                <td>
                                    <button type="button" class="btn btn-danger" onclick="deleteAccount(${acc.aid}, ${acc.role})">Delete</button>

                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function togglePassword(id) {
                var passwordField = document.getElementById('password-' + id);
                var icon = document.getElementById('togglePassword-' + id);

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }

            function deleteAccount(aid, role) {
                if (role === 3) {
                    Swal.fire({
                        title: "Unable to Delete",
                        text: "You cannot delete an admin account.",
                        icon: "error"
                    });
                } else {
                    Swal.fire({
                        title: "Are you sure?",
                        text: "You won't be able to revert this!",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#3085d6",
                        cancelButtonColor: "#d33",
                        confirmButtonText: "Yes, delete it!"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            Swal.fire({
                                title: "Deleted!",
                                text: "Your Account has been deleted.",
                                icon: "success"
                            }).then(() => {
                                window.location.href = 'account-list?action=delete&aid=' + aid;
                            });
                        }
                    });
                }
            }

        </script>
    </body>
</html>
