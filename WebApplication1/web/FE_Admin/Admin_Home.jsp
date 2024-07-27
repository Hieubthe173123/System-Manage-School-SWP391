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
                z-index: 1;
                overflow-y: auto; /* Ensure sidebar scrolls if content exceeds height */
                overflow-x: hidden; /* Hide horizontal scrollbar */
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
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
                margin: 0;
            }

            nav ul li {
                margin-bottom: 10px;
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
                background-color: #ffffff;
                min-height: 100vh;
                box-shadow: -1px 0px 8px rgba(0, 0, 0, 0.1);
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
            }

            .user-info {
                font-size: 18px;
                color: #333;
            }

            main {
                padding: 20px;
            }

            .cards {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                margin-top: 20px;
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

            .btn-toggle {
                background-color: #343a40;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                font-size: 20px;
            }

            .btn-toggle:focus {
                outline: none;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    transform: translateX(-100%);
                    position: fixed;
                    z-index: 1;
                }

                .content {
                    width: 100%;
                    margin-left: 0;
                    padding-left: 0;
                    padding-right: 0;
                }

                .sidebar.hidden {
                    transform: translateX(-100%);
                }
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
                    <li><button onclick="window.location.href = 'adminhome';">Home</button></li>
                    <li><button onclick="window.location.href = 'account-list';">Manage Accounts</button></li>
                    <li><button onclick="window.location.href = 'lecturers';">Manage Teachers</button></li>
                    <li><button onclick="window.location.href = 'student';">Manage Students</button></li>
                    <li><button onclick="window.location.href = 'classController';">Manage SchoolYear/Classes</button></li>
                    <li><button onclick="window.location.href = 'session';">Manage Curriculum</button></li>
                    <li><button onclick="window.location.href = 'promote';">Promote Students</button></li>
                    <li><button onclick="window.location.href = 'searchMenu?date=${sessionScope.dateN}';">Manage Menu</button></li>
                    <li><button onclick="window.location.href = 'historyschoolyear';">School Year History</button></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a></li>
                </ul>
            </nav>
        </div>
        <div class="content" id="content">
            <header>
                <button id="toggleButton" class="btn-toggle">&#9776;</button>
                <span class="user-info">Welcome, Admin</span>
            </header>
            <main>
                <h1>Home</h1>
                <div class="cards">
                    <div onclick="window.location.href = 'account-list';" class="card blue">
                        <h2>${totalAccounts}</h2>
                        <p>Accounts in the System</p>
                    </div>
                        <div onclick="window.location.href = 'parent';" class="card red">
                        <h2>${totalParents}</h2>
                        <p>Number of Parents</p>
                    </div>
                    <div onclick="window.location.href = 'student';" class="card green">
                        <h2>${totalStudents}</h2>
                        <p>Number of Students</p>
                    </div>
                    <div onclick="window.location.href = 'lecturers';" class="card yellow">
                        <h2>${totalTeachers}</h2>
                        <p>Number of Teachers</p>
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
