<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Parent Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                font-family: 'Fredoka One', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                display: flex;
                height: 100vh;
            }

            .sidebar {
                background-color: #00C9D0;
                width: 250px;
                color: #333;
                padding: 1rem;
                display: flex;
                flex-direction: column;
                align-items: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .sidebar img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                border: 5px solid #004085;
                margin-bottom: 1rem;
            }

            .sidebar .nickname {
                font-weight: bold;
                font-size: 1.5rem;
                color: #fff;
                margin-bottom: 1.5rem;
            }

            .sidebar a {
                color: #333;
                text-decoration: none;
                margin-bottom: 1rem;
                text-align: center;
                width: 100%;
                padding: 0.75rem;
                border-radius: 10px;
                background-color: #41E0B3;
                transition: background-color 0.3s, color 0.3s;
            }

            .sidebar a:hover {
                background-color: #FF9800;
                color: white;
            }

            .content {
                flex: 1;
                padding: 2rem;
                overflow-y: auto;
                background-color: #F1F1F1;
            }

            .card {
                margin-bottom: 2rem;
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #FFF;
            }

            .card-header {
                background-color: #03ADD5;
                color: white;
                border-radius: 15px 15px 0 0;
                padding: 1rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .info-group {
                margin-bottom: 1rem;
            }

            .info-group label {
                font-weight: bold;
                margin-bottom: 0.25rem;
                color: #03ADD5;
            }

            .info-group p {
                margin-bottom: 0;
                color: #555;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    box-shadow: none;
                }

                .sidebar img {
                    width: 80px;
                    height: 80px;
                }

                .content {
                    padding: 1rem;
                }
            }

        </style>
    </head>
    <body>
        <div class="sidebar">
            <img src="../Image/icon-256x256.png" alt="User Icon">
            <div class="nickname">${pa.nickname}</div>
            <a href="timetable?stuid=${sessionScope.studenId}">Back to Timetable</a>
            <a href="update-profile">Update Profile</a>
            <a href="change">Change Password</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
        <div class="content">
            <div class="card">
                <div class="card-header">
                    <h2>Thông tin cá nhân của phụ huynh</h2>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Họ và tên</label>
                                <p>${pa.pname}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Giới tính</label>
                                <p>
                                    <c:if test="${pa.gender == true}">Nam</c:if>
                                    <c:if test="${pa.gender == false}">Nữ</c:if>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-group">
                                    <label>Ngày sinh</label>
                                    <p>${pa.dob}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Địa chỉ</label>
                                <p>${pa.address}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Số điện thoại</label>
                                <p>${pa.phoneNumber}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Email</label>
                                <p>${pa.email}</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-group">
                                <label>Căn cước công dân</label>
                                <p>${pa.IDcard}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:forEach var="student" items="${stu}">
                <div class="card">
                    <div class="card-header">
                        <h3>Thông tin cá nhân của bé</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-group">
                                    <label>Họ và tên</label>
                                    <p>${student.sname}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-group">
                                    <label>Giới tính</label>
                                    <p>
                                        <c:if test="${student.gender == true}">Nam</c:if>
                                        <c:if test="${student.gender == false}">Nữ</c:if>
                                        </p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="info-group">
                                        <label>Ngày sinh</label>
                                        <p>${student.dob}</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-group">
                                    <label>Địa chỉ</label>
                                    <p>${student.address}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
