<%-- 
    Document   : Register
    Created on : May 16, 2024, 9:52:42 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Forgot Password</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }
            body {
                background-color: #ff99f5;
                background-repeat: no-repeat;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 15rem 0;
            }
            .card {
                backdrop-filter: blur(16px) saturate(180%);
                -webkit-backdrop-filter: blur(16px) saturate(180%);
                background-color: rgba(0, 0, 0, 0.75);
                border-radius: 12px;
                border: 1px solid rgba(255, 255, 255, 0.125);
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 30px 40px;
            }
            .lock-icon {
                font-size: 3rem;
            }
            h2 {
                font-size: 1.5rem;
                margin-top: 10px;
                text-transform: uppercase;
            }
            p {
                font-size: 12px;
            }
            .passInput {
                margin-top: 15px;
                width: 80%;
                background: transparent;
                border: none;
                border-bottom: 2px solid deepskyblue;
                font-size: 15px;
                color: white;
                outline: none;
            }
            button {
                margin-top: 15px;
                width: 80%;
                background-color: deepskyblue;
                color: white;
                padding: 10px;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body>
        <form action="forgot" method="POST">
            <div class="card">
                <p class="lock-icon"><i>SSS </i></p>
                <h2>Quên Mật Khẩu?</h2>
                <p>Bạn có thể thay đổi mật khẩu tại đây</p>
                <input type="text" name="mailForgot" class="passInput" placeholder="Nhập vào email">
                <h3 style="color: red">${requestScope.err}</h3>
                <button>Send Pass</button>
            </div>
        </form>
    </body>
</html>