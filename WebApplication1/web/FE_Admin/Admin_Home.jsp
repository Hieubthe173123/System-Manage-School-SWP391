<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>


        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                display: flex;
            }

            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: white;
                height: 100vh;
                padding: 10px;
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

            nav ul {
                list-style-type: none;
                padding: 0;
            }

            nav ul li {
                margin: 15px 0;
            }

            .content {
                flex: 1;
                padding: 20px;
                transition: margin-left 0.3s ease;
                margin-left: 250px;
                width: calc(100% - 250px);
                margin-left: 250px;
                transition: margin-left 0.3s ease, width 0.3s ease;
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
                background-color: #ecf0f1;
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
            }

            .card {
                width: 200px;
                padding: 20px;
                border-radius: 10px;
                color: white;
                margin: 10px;
                cursor: pointer;
            }

            .card.blue {
                background-color: #3498db;
            }

            .card.green {
                background-color: #2ecc71;
            }

            .card.yellow {
                background-color: #f1c40f;
            }

            .card.red {
                background-color: #e74c3c;
            }

        </style>

    </head>
    <body>
        <div class="sidebar" id="sidebar">
            <div class="profile">
                <img src="path_to_profile_image" alt="Profile Image">
                <span></span>
            </div>
            <nav>
                <ul>
                    <li>Trang chủ</li>
                    <a href="#">Quản lý tài khoản</a><br>
                    <a href="#">Quản lý Giáo Viên</a><br>
                    <a href="#">Quản lý Học Sinh</a><br>
                    <a href="#">Quản lý Lớp Học</a><br>
                    <a href="#">Quản Lí Năm Học</a><br>
                    <a href="#">Quản lý Lịch Học</a><br>
                    <a href="#">Quản lý Thực Đơn</a><br>
                    <a href="#">Quản lý Chương Trình Học</a><br>
                    <a href="#">Lịch Sử Năm Học</a><br>                 
                </ul>
            </nav>
        </div>
        <div class="content" id="content">
            <header>
                <button id="toggleButton">=</button>
                <span class="user-info"></span>
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