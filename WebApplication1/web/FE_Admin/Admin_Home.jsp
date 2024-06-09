<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                display: flex;
                background-color: #f8f9fa;
            }

            .sidebar {
                width: 250px;
                background-color: #343a40;
                color: white;
                height: 100vh;
                padding: 20px;
                position: fixed;
                top: 0;
                left: 0;
                transition: transform 0.3s ease;
            }

            .sidebar.hidden {
                transform: translateX(-250px);
            }

            .profile {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }

            .profile img {
                border-radius: 50%;
                width: 50px;
                height: 50px;
                margin-right: 10px;
            }

            .profile span {
                font-size: 18px;
            }

            nav ul {
                list-style-type: none;
                padding: 0;
            }

            nav ul li {
                margin: 15px 0;
            }

            nav ul li button {
                width: 100%;
                text-align: left;
                padding: 10px;
                border: none;
                background: none;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            nav ul li button:hover {
                background-color: #495057;
            }

            .content {
                flex: 1;
                padding: 20px;
                transition: margin-left 0.3s ease;
                margin-left: 250px;
                width: calc(100% - 250px);
            }

            .content.full-width {
                margin-left: 0;
                width: 100%;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                background-color: #ffffff;
                border-bottom: 1px solid #dee2e6;
                margin-bottom: 20px;
            }

            .user-info {
                font-size: 18px;
                color: #333;
            }

            main {
                text-align: center;
            }

            .cards {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }

            .card {
                width: 200px;
                padding: 20px;
                border-radius: 10px;
                color: white;
                margin: 10px;
                cursor: pointer;
                transition: transform 0.3s ease;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card:hover {
                transform: scale(1.05);
            }

            .card.blue {
                background-color: #007bff;
            }

            .card.green {
                background-color: #28a745;
            }

            .card.yellow {
                background-color: #ffc107;
            }

            .card.red {
                background-color: #dc3545;
            }

        </style>
    </head>
    <body>
        <div class="sidebar" id="sidebar">
            <div class="profile">
                <img src="../Image/avatar-icon-vector-11835238.jpg" alt="Profile Image">
                <span>Admin</span>
            </div>
            <nav>
                <ul>

                    <li><button onclick="window.location.href = 'home';">Trang chủ</button></li>

                    <li><button onclick="window.location.href = 'account-list';">Quản Lý tài khoản</button></li>

                    <li><button onclick="window.location.href = 'lecturers';">Quản Lý Giáo Viên</button></li>

                    <li><button onclick="window.location.href = 'student';">Quản Lý Học Sinh</button></li>

                    <li><button onclick="window.location.href = 'classController';">Quản Lý Lớp Học</button></li>

                    <li><button onclick="window.location.href = 'newyear';">Quản Lý Năm Học</button></li>

                    <li><button onclick="window.location.href = 'schedules?yid=${sessionScope.yidSchedules}&csid=${sessionScope.csidSchedules}';">Tạo Lịch Học Cho các độ tuổi</button></li>

                    <li><button onclick="window.location.href = 'promote';">Quản Lý Lên Lớp</button></li>

                    <li><button onclick="window.location.href = 'schedule';">Quản Lý Lịch Học</button></li>

                    <li><button onclick="window.location.href = 'menu';">Quản Lý Thực Đơn</button></li>

                    <li><button onclick="window.location.href = 'curriculum';">Quản Lý Chương Trình Học</button></li>

                    <li><button onclick="window.location.href = 'historyschoolyear';">Lịch Sử Học Sinh</button></li>



                </ul>
            </nav>
        </div>
        <div class="content" id="content">
            <header>
                <button id="toggleButton" class="btn btn-light">&#9776;</button>
                <span class="user-info">Welcome, Admin</span>
            </header>
            <main>
                <h1>Home</h1>
                <div class="cards">
                    <div class="card blue">
                        <h2>${totalAccounts}</h2>
                        <p>Tài khoản trong hệ thống</p>
                    </div>
                    <div class="card green">
                        <h2>${totalStudents}</h2>
                        <p>Số lượng Học Sinh</p>
                    </div>
                    <div class="card yellow">
                        <h2>${totalTeachers}</h2>
                        <p>Số lượng Giáo Viên</p>
                    </div>
                </div>
            </main>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toggleButton = document.getElementById('toggleButton');
                const sidebar = document.getElementById('sidebar');
                const content = document.getElementById('content');

                toggleButton.addEventListener('click', function () {
                    sidebar.classList.toggle('hidden');
                    content.classList.toggle('full-width');
                });
            });
        </script>
    </body>
</html>