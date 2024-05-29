<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../CSS/AdminHome.css">
    <script src="../Javascript/scripts.js" defer></script>
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
                <li>Quản lý tài khoản</li>
                <li>Quản lý danh mục</li>
                <li>Quản lý sản phẩm</li>
                <li>Quản lý nhà sản xuất</li>
                <li>Quản lý đơn hàng</li>
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
                    
                    <h2>100</h2>
                    <p>Tài khoản trong hệ thống</p>
                </div>
                <div class="card green">
                    <h2>100</h2>
                    <p>Số lượng Học Sinh</p>
                </div>
                <div class="card yellow">
                    <h2>10</h2>
                    <p>Số lượng Giáo Viên</p>
                </div>
                <div class="card red">
                    <h2>65</h2>
                    <p>Số lượng đánh giá</p>
                </div>          
            </div>
        </main>
    </div>
</body>
</html>
