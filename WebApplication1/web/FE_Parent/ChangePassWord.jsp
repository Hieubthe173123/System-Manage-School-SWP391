<%-- 
    Document   : ChangePassword
    Created on : May 16, 2024, 9:56:30 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /*
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/CascadeStyleSheet.css to edit this template
            */
            /* 
                Created on : May 18, 2024, 2:16:33 PM
                Author     : NGUYEN THI KHANH VI
            */
            * 
           
            .container {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background: #fff;
                border-radius: 20px;
                animation: glow 2s infinite linear;
            }

  

            .change-password-form {
              text-align: center;
                margin-top: 40px;
            }

            h1 {
               font-size: 24px;
                color: #333;
            }

            .input-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: #555;
            }

            .input-group input {
                width: calc(100% - 30px);
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                color: #333;
                outline: none;
                transition: border-color 0.3s;
            }

            .input-group input:focus {
                border-color: #00b8ec;
            }

            .save-button {
                width: 100%;
                padding: 12px 0;
                background: #00b8ec;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 600;
                color: #fff;
                cursor: pointer;
                transition: background 0.3s;
            }

            .save-button:hover {
                 background-color: #0af6fa;
            }
            .back-button {
                margin-top: 10px;
                padding: 10px 20px;
                background: #ddd;
                border: none;
                border-radius: 5px;
                font-size: 14px;
                color: #333;
                cursor: pointer;
                transition: background 0.3s;
            }

            .back-button:hover {
                background-color: #ccc;
            }

            #message {
                margin-top: 10px;
                color: red;
            }

        </style>
    </head>
    <body>       

        <div class="container" >
            <div class="change-password-form">
                <h1>Change PassWord</h1>

                <form action="change" method="post">
                    <div class="input-group">

                        <input type="password" id="old-password" name="old-password" placeholder="Enter old password" required>
                        <input type="hidden" name="user" value="${sessionScope.account.username}"> 
                    </div>
                    <div class="input-group">

                        <input type="password" id="new-password" name="new-password" placeholder="Enter new password" required>
                    </div>
                    <div class="input-group">

                        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm new password" required>
                    </div>

                    <button type="submit" class="save-button">Update password</button> 
                    <% String mess = (String) request.getAttribute("mess");
                  if (mess != null) { %>
                    <p style="color: red" id="message">${mess}</p>
                    <% } %>

                    <button class="back-button" onclick="window.history.back()">Back to previous page</button>

                  
                </form>
            </div>
        </div>
                     <script type="text/javascript">
                        function hideMessage() {
                            var messageElement = document.getElementById("message");
                            if (messageElement) {
                                setTimeout(function () {
                                    messageElement.style.display = "none";
                                }, 2000);
                            }
                        }
                        window.onload = hideMessage;
                    </script>     
    </body>
</html>
