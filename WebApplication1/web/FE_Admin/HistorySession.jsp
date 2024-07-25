<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>History Sessions</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #FFFAF0;
                font-family: 'Roboto', sans-serif;
            }

            .container {
                margin-top: 50px;
                max-width: 1200px;
            }

            h1 {
                margin-bottom: 30px;
                color: #03ADD5;
                text-align: center;
                font-weight: bold;
            }

            .btn-custom {
                background-color: #03ADD5;
                color: white;
                border-radius: 5px;
                padding: 10px 20px;
                margin-bottom: 20px;
                display: inline-block;
                transition: background-color 0.3s;
                text-decoration: none;
            }

            .btn-custom:hover {
                background-color: #0288D1;
                text-decoration: none;
                color: white;
            }

            .card {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.2);
                transition: transform 0.3s, box-shadow 0.3s;
                margin-bottom: 20px;
            }

            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 0 20px rgba(0, 123, 255, 0.3);
            }

            .card-header {
                background-color: #03ADD5;
                color: white;
                border-bottom: none;
                border-radius: 10px 10px 0 0;
                padding: 15px;
                font-weight: bold;
            }

            .card-body {
                padding: 20px;
                text-align: center;
            }

            .card-body h2 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #007bff;
            }

            .card-body p {
                margin: 5px 0;
                color: #343a40;
            }

            .card-body p.default {
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>History Sessions</h1>
            <a class="btn-custom" href="session">Back To Session</a>
            <div class="row">
                <c:forEach var="his" items="${requestScope.list}">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                Session ID: ${his.sid}
                            </div>
                            <div class="card-body">
                                <h2><a href="history-curiculum?sid=${his.sid}" style="color: #007bff; text-decoration: none;">${his.sname}</a></h2>
                                <p>Total Sessions: ${his.totalSession}</p>
                                <p class="default">Age: ${his.age.aname}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
