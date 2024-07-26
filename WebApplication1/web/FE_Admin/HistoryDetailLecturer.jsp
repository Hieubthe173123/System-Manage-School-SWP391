<%-- 
    Document   : HistoryDetailLecturer
    Created on : Jun 25, 2024, 9:36:03 AM
    Author     : admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecturer Information</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f0f8ff;
                font-family: 'Fredoka One', cursive;
                padding-top: 40px; /* for Bootstrap navbar */
            }
            .container {
                margin-top: 50px;
                background: #fff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid skyblue;
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
            }
            .header h1 {
                color: #03ADD5;
                font-weight: bold;
            }
            .info-row {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            .info-row h3 {
                margin: 0;
                color: #343a40;
            }
            .info-label {
                flex: 1;
                font-weight: bold;
                color: #03ADD5;
            }
            .info-value {
                flex: 2;
                padding-left: 10px;
            }
            .info-value.default {
                color: #6c757d;
            }
            .icon {
                font-size: 50px;
                color: #03ADD5;
                margin-right: 20px;
            }
            .btn-back {
                background-color: #41E0B3;
                border: none;
                border-radius: 10px;
                font-size: 0.9rem;
                padding: 8px 16px;
                margin-bottom: 20px;
            }
            .btn-back:hover {
                background-color: #FF9800;
            }
        </style>
        <!-- FontAwesome for Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <div class="text-center">
                <button class="btn btn-back" onclick="window.location.href = 'history?yid=${param.yid}'">Back</button>
            </div>
            <div class="header">
                <i class="icon fas fa-user"></i>
                <h1>Personal Information</h1>
            </div>
            <div class="info-row">
                <div class="info-label"><h3>Lecturer Name:</h3></div>
                <div class="info-value"><h3>${lec.lname}</h3></div>
            </div>
            <div class="info-row">
                <div class="info-label"><h3>Gender:</h3></div>
                <div class="info-value"><h3>
                        <c:choose>
                            <c:when test="${lec.gender == true}">Male</c:when>
                            <c:otherwise>Female</c:otherwise>
                        </c:choose>
                    </h3></div>
            </div>
            <div class="info-row">
                <div class="info-label"><h3>Phone Number:</h3></div>
                <div class="info-value"><h3>${lec.phoneNumber}</h3></div>
            </div>
            <div class="info-row">
                <div class="info-label"><h3>ID Card:</h3></div>
                <div class="info-value"><h3>${lec.IDcard}</h3></div>
            </div>
            <div class="info-row">
                <div class="info-label"><h3>Email:</h3></div>
                <div class="info-value"><h3>${lec.email}</h3></div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
