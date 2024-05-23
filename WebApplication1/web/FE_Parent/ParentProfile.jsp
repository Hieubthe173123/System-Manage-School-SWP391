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
            }
            .info-group {
                margin-bottom: 1rem;
            }
            .info-group label {
                font-weight: bold;
                margin-bottom: 0.25rem;
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
            .component-10-child {
                position: absolute;
                height: 100%;
                width: 79.55%;
                top: 0%;
                right: 20.45%;
                bottom: 0%;
                left: 0%;
                background-color: #a8aeb4;
            }
            .component-10-item {
                position: absolute;
                height: 6.22%;
                width: 79.55%;
                top: 0%;
                right: 20.45%;
                bottom: 93.78%;
                left: 0%;
                background-color: #a8aeb4;
            }
            .icons8-user-48-1 {
                position: absolute;
                height: 3.18%;
                width: 16.56%;
                top: 4.17%;
                right: 49.35%;
                bottom: 92.65%;
                left: 34.09%;
                max-width: 100%;
                overflow: hidden;
                max-height: 100%;
                object-fit: cover;
            }
            .phng-anh-tun {
                position: absolute;
                height: 2%;
                width: 81.49%;
                top: 8.08%;
                left: 18.51%;
                font-size: 16px;
                font-family: var(--font-inter);
                display: inline-block;
                font-weight: bold;
                margin-left: -23px;
            }
            .component-10-inner {
                position: absolute;
                height: 4.96%;
                width: 79.55%;
                top: 22.52%;
                right: 20.45%;
                bottom: 72.52%;
                left: 0%;
                background-color: var(--color-lightcyan);
                border-top: 3px solid var(--color-powderblue);
                border-bottom: 3px solid var(--color-powderblue);
                box-sizing: border-box;
            }
            .change-password {
                position: absolute;
                height: 1.99%;
                width: 61.04%;
                top: 23.97%;
                left: 11.69%;
                display: inline-block;
                font-size: 15px;
                text-decoration: none;
            }
            .rectangle-div {
                position: absolute;
                height: 4.31%;
                width: 79.55%;
                top: 18.41%;
                right: 20.45%;
                bottom: 77.28%;
                left: 0%;
                background-color: var(--color-lightcyan);
                border-top: 3px solid var(--color-powderblue);
                border-bottom: 3px solid var(--color-powderblue);
                box-sizing: border-box;
            }
            .update-profile {
                position: absolute;
                height: 1.99%;
                width: 47.4%;
                top: 19.54%;
                left: 18.51%;
                display: inline-block;
                font-size: 15px;
                text-decoration: none;
            }
            .component-10 {
                width: 100%;
                position: relative;
                height: 1231px;
                text-align: left;
                font-size: var(--font-size-xl);
                color: var(--color-black);
                font-family: var(--font-poppins);
            }
        </style>
    </head>
    <body>
        <div class="row">
            <div class="col-md-2">
                <div class="component-10">
                    <div class="component-10-child"></div>
                    <div class="component-10-item"></div>
                    <img class="icons8-user-48-1" alt="" src="icons8-user-48 1.png">
                    <div class="phng-anh-tun">${pa.nickname}</div>
                    <div class="component-10-inner"></div>
                    <a href="FE_Parent/ChangePassword.jsp" class="change-password">Change password</a>
                    <div class="rectangle-div"></div>
                    <a href="update-profile" class="update-profile">Update profile</a>
                </div>
            </div>
            <div class="container mt-3">
                <div class="row">
                    <div class="col-md-5">
                        <div class="card">
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
                    <div class="col-md-5">
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
        </div>
    </body>
</html>