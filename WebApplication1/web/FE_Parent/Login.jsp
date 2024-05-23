<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Preschool Login</title>
        <link rel="stylesheet" href="../CSS/Login.css">
        <style>
            /* General Styles */
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #2BB4D0; /* Light blue background */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            /* Login Container */
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
                width: 100%;
            }

            /* Login Box */
            .login-box {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                padding: 40px 30px;
                text-align: center;
                width: 100%;
                max-width: 400px;
                box-sizing: border-box;
            }

            .login-box h1 {
                margin-bottom: 30px;
                font-size: 24px;
                color: #333;
            }

            /* Input Group */
            .input-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .input-group label {
                display: block;
                font-size: 14px;
                margin-bottom: 5px;
                color: #333;
            }

            .input-group input {
                width: calc(100% - 20px);
                padding: 10px;
                margin-left: auto;
                margin-right: auto;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .input-group input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
                padding: 10px 20px;
                font-size: 16px;
                margin-top: 20px;
            }

            .input-group input[type="submit"]:hover {
                background-color: #45a049;
            }

            /* Forgot Password Link */
            .forgot-link {
                margin-top: 10px;
            }

            .forgot-link a {
                color: #0066cc;
                text-decoration: none;
                font-size: 14px;
                transition: color 0.3s ease;
            }

            .forgot-link a:hover {
                color: #005bb5;
            }

            /* Create Account Link */
            .create-account-link {
                margin-top: 20px;
            }

            .create-account-link a {
                color: #0066cc;
                text-decoration: none;
                font-size: 14px;
                transition: color 0.3s ease;
            }

            .create-account-link a:hover {
                color: #005bb5;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-box">
                <h1>Welcome to Sakura Preschool</h1>
                <form action="login" method="POST">
                    <div class="input-group">
                        <label for="username">Username</label>
                        <input type="text" name="username" required>
                    </div>
                    <div class="input-group">
                        <label for="password">Password</label>
                        <input type="password" name="password" required>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Login">
                        <h3 style="color: red">${requestScope.err}</h3>
                    </div>
                    <div class="forgot-link">
                        <a href="${pageContext.request.contextPath}/forgot">Forgot Password?</a>
                    </div>
                    <div class="create-account-link">
                        <a href="${pageContext.request.contextPath}/createAccount">Create Account</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
