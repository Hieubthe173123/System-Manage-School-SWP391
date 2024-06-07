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
        <style>
            /* Additional custom styles */
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
            .custom-link:active {
                font-weight: bold;
            }
            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
            }
            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
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
                        <option value="1" ${"1".equals(request.getParameter("role")) ? "selected" : ""}>Parent</option> 
                        <option value="2" ${"2".equals(request.getParameter("role")) ? "selected" : ""}>Lecturers</option>
                        <option value="3" ${"3".equals(request.getParameter("role")) ? "selected" : ""}>Admin</option>
                    </select>
                </div>

                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="Search..." name="searchName">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn btn-campus">Show Accounts</button>
            </form>

            <div class="mb-3">
                <button class="btn btn-campus" onclick="window.location.href = 'authentication-account'">Assign Permissions to Account</button>
            </div>       

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
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="acc" items="${sessionScope.accountList}" varStatus="idex">
                            <c:if test="${empty param.searchName or fn:containsIgnoreCase(acc.username, param.searchName) or fn:containsIgnoreCase(acc.pid.pname, param.searchName) or fn:containsIgnoreCase(acc.lid.lname, param.searchName)}">
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
                                    <td>${acc.pid.pid}</td>
                                    <td>${acc.pid.pname}</td>
                                    <td>${acc.lid.lid}</td>
                                    <td>${acc.lid.lname}</td>
                                </tr>
                            </c:if>
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
        </script>
    </body>
</html>
