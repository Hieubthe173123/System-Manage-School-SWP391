<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Parent Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                background-color: #b3d9ff;
                font-family: 'Poppins', sans-serif;
            }
            .info-group {
                margin-bottom: 1.5rem;
            }
            .info-group label {
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: #333;
            }
            .info-group p {
                margin-bottom: 0;
                color: #666;
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
            .sidebar {
                background-color: #a8aeb4;
                padding: 1rem;
                border-radius: 10px;
                height: 100%;
                position: fixed;
                width: 20%;
                top: 0;
                left: 0;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }
            .sidebar img {
                display: block;
                margin: 0 auto 1rem;
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }
            .sidebar .username {
                text-align: center;
                font-weight: bold;
                margin-bottom: 2rem;
                font-size: 1.2rem;
            }
            .sidebar a {
                display: block;
                color: #333;
                font-size: 1rem;
                text-decoration: none;
                margin-bottom: 1rem;
                text-align: center;
            }
            .container {
                margin-left: 22%;
                padding-top: 20px;
            }
            .logout {
                position: absolute;
                top: 10px;
                right: 20px;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <img src="icons8-user-48 1.png" alt="User">
            <div class="username">${pa.nickname}</div>
            <a href="change">Change password</a>
            <a href="update-profile">Update profile</a>
            <a href="FE_Parent/Login.jsp">Logout</a>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card mb-3">
                        <div class="card-header">
                            <h2>Thông tin cá nhân của phụ huynh</h2>
                        </div>
                        <div class="card-body">
                            <div class="info-group">
                                <label>Họ và tên</label>
                                <p>${pa.pname}</p>
                            </div>
                            <div class="info-group">
                                <label>Giới tính</label>
                                <p>
                                    <c:if test="${pa.gender == true}">Nam</c:if>
                                    <c:if test="${pa.gender == false}">Nữ</c:if>
                                    </p>
                                </div>
                                <div class="info-group">
                                    <label>Ngày sinh</label>
                                    <p>${pa.dob}</p>
                            </div>
                            <div class="info-group">
                                <label>Địa chỉ</label>
                                <p>${pa.address}</p>
                            </div>
                            <div class="info-group">
                                <label>Số điện thoại</label>
                                <p>${pa.phoneNumber}</p>
                            </div>
                            <div class="info-group">
                                <label>Email</label>
                                <p>${pa.email}</p>
                            </div>
                            <div class="info-group">
                                <label>Căn cước công dân</label>
                                <p>${pa.IDcard}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <c:forEach var="student" items="${stu}">
                        <div class="card mb-3">
                            <div class="card-header">
                                <h3>Thông tin cá nhân của bé</h3>
                            </div>
                            <div class="card-body">
                                <div class="info-group">
                                    <label>Họ và tên</label>
                                    <p>${student.sname}</p>
                                </div>
                                <div class="info-group">
                                    <label>Giới tính</label>
                                    <p>
                                        <c:if test="${student.gender == true}">Nam</c:if>
                                        <c:if test="${student.gender == false}">Nữ</c:if>
                                        </p>
                                    </div>
                                    <div class="info-group">
                                        <label>Tuổi</label>
                                        <p>${student.age}</p>
                                </div>
                                <div class="info-group">
                                    <label>Ngày sinh</label>
                                    <p>${student.dob}</p>
                                </div>
                                <div class="info-group">
                                    <label>Địa chỉ</label>
                                    <p>${student.address}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </body>
</html>
