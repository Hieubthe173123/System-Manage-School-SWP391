<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account</title>
        <style>
            @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');
            /* Your existing styles */
            * {
                box-sizing: border-box;
            }

            body {
                background: #2BB4D0; /* Light blue background */
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                font-family: 'Montserrat', sans-serif;
                height: 100vh;
                margin: -20px 0 50px;
            }

            h1 {
                font-weight: bold;
                margin: 0;
            }

            h2 {
                text-align: center;
            }

            p {
                font-size: 14px;
                font-weight: 100;
                line-height: 20px;
                letter-spacing: 0.5px;
                margin: 20px 0 30px;
            }

            span {
                font-size: 12px;
            }

            a {
                color: #333;
                font-size: 14px;
                text-decoration: none;
                margin: 15px 0;
            }

            button {
                border-radius: 20px;
                border: 1px solid #FF4B2B;
                background-color: #FF4B2B;
                color: #FFFFFF;
                font-size: 12px;
                font-weight: bold;
                padding: 12px 45px;
                letter-spacing: 1px;
                text-transform: uppercase;
                transition: transform 80ms ease-in;
            }

            button:active {
                transform: scale(0.95);
            }

            button:focus {
                outline: none;
            }

            button.ghost {
                background-color: transparent;
                border-color: #FFFFFF;
            }

            form {
                background-color: #FFFFFF; /* White background for the form */
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 0 50px;
                height: 100%;
                text-align: center;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            input {
                background-color: #eee;
                border: none;
                padding: 12px 15px;
                margin: 8px 0;
                width: 100%;
            }

            .container {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 14px 28px rgba(0,0,0,0.25),
                    0 10px 10px rgba(0,0,0,0.22);
                position: relative;
                overflow: hidden;
                width: 768px;
                max-width: 100%;
                min-height: 480px;
            }

            .form-container {
                position: absolute;
                top: 0;
                height: 100%;
                transition: all 0.6s ease-in-out;
            }

            .sign-in-container {
                left: 0;
                width: 50%;
                z-index: 2;
            }

            .container.right-panel-active .sign-in-container {
                transform: translateX(100%);
            }

            .sign-up-container {
                left: 0;
                width: 50%;
                opacity: 0;
                z-index: 1;
            }

            .container.right-panel-active .sign-up-container {
                transform: translateX(100%);
                opacity: 1;
                z-index: 5;
                animation: show 0.6s;
            }

            @keyframes show {
                0%, 49.99% {
                    opacity: 0;
                    z-index: 1;
                }

                50%, 100% {
                    opacity: 1;
                    z-index: 5;
                }
            }

            .overlay-container {
                position: absolute;
                top: 0;
                left: 50%;
                width: 50%;
                height: 100%;
                overflow: hidden;
                transition: transform 0.6s ease-in-out;
                z-index: 100;
            }

            .container.right-panel-active .overlay-container {
                transform: translateX(-100%);
            }

            .overlay {
                background: #2BB4D0;
                background-repeat: no-repeat;
                background-size: cover;
                background-position: 0 0;
                color: #FFFFFF;
                position: relative;
                left: -100%;
                height: 100%;
                width: 200%;
                transform: translateX(0);
                transition: transform 0.6s ease-in-out;
            }

            .container.right-panel-active .overlay {
                transform: translateX(50%);
            }

            .overlay-panel {
                position: absolute;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 0 40px;
                text-align: center;
                top: 0;
                height: 100%;
                width: 50%;
                transform: translateX(0);
                transition: transform 0.6s ease-in-out;
            }

            .overlay-left {
                transform: translateX(-20%);
            }

            .container.right-panel-active .overlay-left {
                transform: translateX(0);
            }

            .overlay-right {
                right: 0;
                transform: translateX(0);
            }

            .container.right-panel-active .overlay-right {
                transform: translateX(20%);
            }
        </style>
    </head>
    <body>
        <h2></h2>
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form id="signUpForm" action="sign-up" method="POST">
                    <h1>Create Account</h1>
                    <input type="text" placeholder="Username" name="user" required />
                    <input type="password" id="password" placeholder="Password" name="password" required />
                    <input type="password" id="confirm_password" placeholder="Confirm password" name="confirm" required />
                    <span id="error_message" style="color: red;">
                        <c:choose>
                            <c:when test="${not empty errorMessage}">
                                ${errorMessage}
                            </c:when>
                            <c:otherwise>
                                
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <span id="success_message" style="color: green;">
                        <c:choose>
                            <c:when test="${not empty successMessage}">
                                ${successMessage}
                            </c:when>
                            <c:otherwise>
                                
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <button type="submit" onclick="checkSignUp()">Sign Up</button>
                </form>
            </div>
            <div class="form-container sign-in-container">
                <form action="login" method="POST">
                    <h1>Sign in</h1>
                    <input type="text" placeholder="Username" name="username" required />
                    <input type="password" placeholder="Password" name="password" required />
                    <a href="${pageContext.request.contextPath}/forgot">Forgot Password?</a>
                    <button type="submit">Sign In</button>
                    <h3 style="color: red;"><%= request.getAttribute("err") != null ? request.getAttribute("err") : "" %></h3>
                </form>
            </div>
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>To keep connected with us please login with your personal info</p>
                        <button class="ghost" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Sakura Preschool</h1>
                        <p>Enter your personal details and start journey with us</p>
                        <button class="ghost" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            const signUpButton = document.getElementById('signUp');
            const signInButton = document.getElementById('signIn');
            const container = document.getElementById('container');
            const form = document.getElementById('signUpForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirm_password');
            const errorMessage = document.getElementById('error_message');

            signUpButton.addEventListener('click', () => {
                container.classList.add("right-panel-active");
            });

            signInButton.addEventListener('click', () => {
                container.classList.remove("right-panel-active");
            });

            form.addEventListener('submit', (e) => {
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    errorMessage.textContent = 'Passwords do not match';
                }
            });

            function checkSignUp() {
                Swal.fire({
                    icon: 'info',
                    title: 'SweetAlert2 is working!',
                    text: 'This is a test message.',
                });
            }
        </script>
    </body>
</html>




