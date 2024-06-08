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
        </style>
    </head>
    <body>
        <div class="content-wrapper">
            <div class="mb-3">
                <button class="btn btn-campus" onclick="window.location.href = 'account-list'">Back</button>
            </div>
            <h2>Assign Roles to New Accounts</h2>
            <form action="authentication-account" method="POST">
                <input type="hidden" name="action" value="delete">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Account ID</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Role</th>
                                <th>Parent Name</th>
                                <th>Lecturer Name</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="acc" items="${sessionScope.newAccountList}" varStatus="idex">
                                <tr>
                                    <td>${idex.index+1}</td>
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


                                    <td>
                                        <select name="role-${idex.index}" class="form-control" onchange="handleRoleChange(this, ${idex.index})">
                                            <option value="">Select Role</option>
                                            <option value="1" ${acc.role == 1 ? "selected" : ""}>Parent</option>
                                            <option value="2" ${acc.role == 2 ? "selected" : ""}>Lecturers</option>
                                            <option value="3" ${acc.role == 3 ? "selected" : ""}>Admin</option>
                                        </select>
                                    </td>


                                    <td>
                                        <select name="pid-${idex.index}" id="pid-${idex.index}" class="form-control" ${acc.role == 2 || acc.role == 3 ? "disabled" : ""}>
                                            <option value="">Select PID</option>
                                            <c:forEach var="parent" items="${sessionScope.availableParents}">
                                                <option value="${parent.pid}" ${acc.pid != null && parent.pid == acc.pid.pid ? "selected" : ""}>${parent.pname}</option>
                                            </c:forEach>
                                        </select>
                                        ${acc.pid != null ? acc.pid.getPname() : ""}
                                    </td>


                                    <td>
                                        <select name="lid-${idex.index}" id="lid-${idex.index}" class="form-control" ${acc.role == 1 || acc.role == 3 ? "disabled" : ""}>
                                            <option value="">Select LID</option>
                                            <c:forEach var="lecturer" items="${sessionScope.availableLecturers}">
                                                <option value="${lecturer.lid}" ${acc.lid != null && lecturer.lid == acc.lid.lid ? "selected" : ""}>${lecturer.lname}</option>
                                            </c:forEach>
                                        </select>
                                        ${acc.lid != null ? acc.lid.getLname() : ""}
                                    </td>

                                    <td>
                                        <button type="button" class="btn btn-danger" onclick="deleteAccount(${acc.aid})">Delete</button>
                                    </td>


                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <button type="submit" class="btn btn-campus">Save</button>
            </form>
        </div>

        <script>
            //Disable role
            function handleRoleChange(select, index) {
                var role = select.value;
                var pidField = document.getElementById('pid-' + index);
                var lidField = document.getElementById('lid-' + index);

                if (role == '1') {
                    //nếu role 1 (Parent) => disable Lid
                    pidField.disabled = false;
                    lidField.disabled = true;
                    lidField.value = '';
                } else if (role == '2') {
                    //nếu role 2 (Lecturers) => disable Pid
                    pidField.disabled = true;
                    lidField.disabled = false;
                    pidField.value = '';
                } else if (role == '3') {
                    //nếu role 3 (Admin) => disable Lid and Pid
                    pidField.disabled = true;
                    lidField.disabled = true;
                    pidField.value = '';
                    lidField.value = '';
                } else {
                    //Chưa chọn gì disable lid và pid
                    pidField.disabled = true;
                    lidField.disabled = true;
                }
            }

            //Ẩn hiện mật khẩu
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
            
            // Xóa tài khoản
            function deleteAccount(aid) {
                if (confirm("Are you sure you want to delete this account?")) {
                    window.location.href = 'authentication-account?aid=' + aid;
                }
            }
        </script>
    </body>
</html>

