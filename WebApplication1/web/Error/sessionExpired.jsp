<%-- 
    Document   : sessionExpired
    Created on : Jun 21, 2024, 11:22:05 AM
    Author     : DELL
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Session Expired</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: skyblue; /* Change to skyblue background */
                font-family: 'Comic Sans MS', 'Comic Sans', cursive; /* Fun and playful font */
                color: #d9534f; /* Red color */
                margin: 0;
            }
            .container {
                text-align: center;
                padding: 30px;
                border: 2px dashed #f0ad4e; /* Dashed orange border */
                background-color: #fff3cd; /* Light yellow background */
                border-radius: 15px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                font-size: 28px;
                margin-bottom: 15px;
            }
            p {
                font-size: 20px;
                margin-bottom: 20px;
            }
            a {
                color: #0275d8; /* Blue color */
                text-decoration: none;
                font-weight: bold;
                padding: 10px 20px;
                background-color: #dff0d8; /* Light green background */
                border: 2px solid #5cb85c; /* Green border */
                border-radius: 10px;
                transition: background-color 0.3s;
            }
            a:hover {
                background-color: #c3e6cb; /* Darker green background on hover */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Session Expired</h1>
            <p>Your session has expired. Please log in again to continue.</p>
            <p><a href="${pageContext.request.contextPath}/login">Go to Login Page</a></p>
        </div>
    </body>
</html>
