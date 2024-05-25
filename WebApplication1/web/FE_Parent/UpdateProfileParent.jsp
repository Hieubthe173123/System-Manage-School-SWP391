<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Parent Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                background-color: #b3d9ff;
            }
            .form-group label {
                font-weight: bold;
                color: #333;
            }
            .card {
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
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header">
                            <h2>Update Parent Profile</h2>
                        </div>
                        <div class="card-body">
                            <form action="update-profile" method="post">
                                <div class="form-group">
                                    <label for="pname">Họ và tên</label>
                                    <input type="text" class="form-control" id="pname" name="pname" value="${pa.pname}" required>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Giới tính</label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="true" ${pa.gender ? 'selected' : ''}>Nam</option>
                                        <option value="false" ${!pa.gender ? 'selected' : ''}>Nữ</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="dob">Ngày sinh</label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="${pa.dob}" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${pa.address}" required>
                                </div>
                                <div class="form-group">
                                    <label for="phoneNumber">Số điện thoại</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${pa.phoneNumber}" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${pa.email}" required>
                                </div>
                                <div class="form-group">
                                    <label for="IDcard">Căn cước công dân</label>
                                    <input type="text" class="form-control" id="IDcard" name="IDcard" value="${pa.IDcard}" required>
                                </div>
                                <div class="form-group">
                                    <label for="nickname">Nickname</label>
                                    <input type="text" class="form-control" id="nickname" name="nickname" value="${pa.nickname}" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
