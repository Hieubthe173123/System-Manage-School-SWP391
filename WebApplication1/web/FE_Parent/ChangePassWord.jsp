<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap">
        <style>
            body {
                background-color: #FFFAF0;
                font-family: 'Roboto', cursive;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                max-width: 700px;
                width: 90%;
                margin: 0 auto;
                padding: 40px;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: 2px solid #00BFFF;
                animation: glow 2s infinite linear;
            }

            @keyframes glow {
                0% {
                    border-color: #00BFFF;
                }
                50% {
                    border-color: #87CEFA;
                }
                100% {
                    border-color: #00BFFF;
                }
            }

            .change-password-form {
                text-align: center;
                margin-top: 20px;
            }

            h1 {
                font-size: 28px;
                color: black;
            }

            .input-group {
                margin-bottom: 20px;
                text-align: left;
                position: relative;
            }

            .input-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: black;
            }

            .input-group input {
                width: calc(100% - 40px); /* Adjusted width to account for larger icon */
                padding: 12px 15px;
                border: 2px solid #00BFFF;
                border-radius: 10px;
                font-size: 16px;
                color: #333;
                outline: none;
                transition: border-color 0.3s;
                background-color: #FFFAF0;
            }

            .input-group input:focus {
                border-color: #87CEFA;
            }

            .toggle-password {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: #00BFFF;
                font-size: 20px; /* Increased font size for larger icon */
            }

            .save-button {
                width: 100%;
                padding: 12px 0;
                background: #00BFFF;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                color: #fff;
                cursor: pointer;
                transition: background 0.3s;
            }

            .save-button:hover {
                background-color: #87CEFA;
            }

            .back-button {
                margin-top: 10px;
                padding: 10px 20px;
                background: #B0E0E6;
                border: none;
                border-radius: 10px;
                font-size: 14px;
                color: #333;
                cursor: pointer;
                transition: background 0.3s;
            }

            .back-button:hover {
                background-color: #ADD8E6;
            }

            #message {
                margin-top: 10px;
                color: red;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="change-password-form">
                <h1>Change Password</h1>
                <form action="change" method="post">
                    <div class="input-group">
                        <label for="old-password">Old Password</label>
                        <input type="password" id="old-password" name="old-password" placeholder="Enter old password" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('old-password')">&#128065;</span>
                    </div>
                    <div class="input-group">
                        <label for="new-password">New Password</label>
                        <input type="password" id="new-password" name="new-password" placeholder="Enter new password" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('new-password')">&#128065;</span>
                    </div>
                    <div class="input-group">
                        <label for="confirm-password">Confirm New Password</label>
                        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm new password" required>
                        <span class="toggle-password" onclick="togglePasswordVisibility('confirm-password')">&#128065;</span>
                    </div>
                    <button type="submit" class="save-button">Update Password</button>
                    <% String mess = (String) request.getAttribute("mess");
                if (mess != null) { %>
                    <p id="message">${mess}</p>
                    <% } %>
                    <button type="button" class="back-button" onclick="window.history.back()">Back to Previous Page</button>
                </form>
            </div>
        </div>
        <script type="text/javascript">
            function hideMessage() {
                var messageElement = document.getElementById("message");
                if (messageElement) {
                    setTimeout(function () {
                        messageElement.style.display = "none";
                    }, 6000);
                }
            }
            window.onload = hideMessage;

            function togglePasswordVisibility(id) {
                var input = document.getElementById(id);
                var icon = event.target;
                if (input.type === "password") {
                    input.type = "text";
                    icon.innerHTML = "&#128064;";  // Change to an "eye with slash" icon
                } else {
                    input.type = "password";
                    icon.innerHTML = "&#128065;";  // Change back to the "eye" icon
                }
            }
        </script>
    </body>
</html>
