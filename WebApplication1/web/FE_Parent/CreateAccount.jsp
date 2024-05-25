<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Preschool Create Account</title>
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

            /* Create Account Container */
            .create-account-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
                width: 100%;
            }

            /* Create Account Box */
            .create-account-box {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                padding: 40px 30px;
                text-align: center;
                width: 100%;
                max-width: 400px;
                box-sizing: border-box;
            }

            .create-account-box h1 {
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
        </style>
    </head>
    <body>
        <div class="create-account-container">
            <div class="create-account-box">
                <h1>Create Account</h1>
                <form action="createAccount" method="POST">
                    <div class="input-group">
                        <label for="username">Tài khoản.</label>
                        <input type="text" name="username" required>
                    </div>
                    <div class="input-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" name="password" required>
                    </div>
                    
                    <div class="input-group">
                        <label for="email">Chức năng của tài khoản.</label>
                        <select name="roleS">
                            <option value="1">Parent</option>       
                            <option value="2">Teacher</option>     
                            <option value="3">Admin</option>     
                    </select>
                    </div>
                    <div class="input-group">
                        <label for="password">ID của người sở hữu tài khoản</label>
                        <input type="number" name="idParent" required>
                    </div>
                    <div class="input-group">
                        <input type="submit" value="Create Account">
                    </div>
                </form>
                
                <h3 style="color: red">${requestScope.mess}</h3>
            </div>
        </div>
    </body>
</html>