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
            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            /* Hides the up and down arrows on input with type="number" for Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }
        </style>
    </head>
    <body>
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header">
                            <h2>Update Lecturers Profile</h2>
                        </div>
                        <div class="card-body">
                            <form action="update-lecturers" method="POST">
                                <input type="hidden" name="lid" value="${lec.lid}">
                                <div class="form-group">
                                    <label for="lname">Họ và tên</label>
                                    <input type="text" class="form-control" id="lname" name="lname" value="${lec.lname}" required>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Giới tính</label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="true" ${lec.gender ? 'selected' : ''}>Nam</option>
                                        <option value="false" ${!lec.gender ? 'selected' : ''}>Nữ</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="dob">Ngày sinh</label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="${lec.dob}" required>
                                </div>
                                <div class="form-group">
                                    <label for="address">Địa chỉ</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${lec.address}" required>
                                </div>
                                <div class="form-group">
                                    <label for="phoneNumber">Số điện thoại</label>
                                    <input type="number" class="form-control" id="phoneNumber" name="phoneNumber" value="${lec.phoneNumber}" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${lec.email}" required>
                                </div>
                                <div class="form-group">
                                    <label for="IDcard">Căn cước công dân</label>
                                    <input type="number" class="form-control" id="IDcard" name="IDcard" value="${lec.IDcard}" required>
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
