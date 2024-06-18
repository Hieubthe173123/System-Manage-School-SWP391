<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sessions List</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>

            body {
                background-color: #f9f9f9;
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .btn-campus {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-campus:hover {
                background-color: #388E3C;
            }

            .custom-link:active {
                font-weight: bold;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
            }

            .session-details .btn-campus {
                margin: 5px;
            }

            .table-bordered {
                border: 2px solid #4CAF50;
                border-radius: 10px;
            }

            .thead-dark {
                background-color: #4CAF50;
                color: white;
            }

            .btn-warning {
                background-color: #FFC107;
                border-color: #FFC107;
            }

            .btn-warning:hover {
                background-color: #FFA000;
                border-color: #FFA000;
            }

            .btn-danger {
                background-color: #DC3545;
                border-color: #DC3545;
            }

            .btn-danger:hover {
                background-color: #C82333;
                border-color: #C82333;
            }

            h1, h2, h3, h4, h5, h6 {
                color: #4CAF50;
            }

            a {
                color: #4CAF50;
            }

            a:hover {
                color: #388E3C;
            }
            .total-session {
                font-size: 18px;
                color: #4CAF50; /* Chọn màu tương tự như các tiêu đề và nút */
                margin-left: 10px; /* Điều chỉnh khoảng cách với tiêu đề Session Details */
            }



        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="content-wrapper">
                <h1 class="text-center mb-4" style="color: #39BACD;">Course Information</h1>

                <div class="mb-3 d-flex justify-content-between align-items-start">
                    <div>
                        <h2 style="color: #39BACD;">Available Sessions</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Session Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="session" items="${requestScope.list}">
                                        <tr>
                                            <td style="width: 20%;"><a href="session-detail?sid=${session.sid}" class="text-decoration-none" style="color: #39BACD;">${session.sname}</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <h2 style="color: #39BACD;">Session Details</h2>
                            <form action="add-session" method="post" style="display:inline;">
                                <input type="hidden" name="sid" value="${param.sid}" />
                                <button type="submit" class="btn btn-primary" id="addNewLecturerBtn">Add Session</button>
                            </form>
                            <span class="total-session">Total Session: ${requestScope.list1[0].sid.totalSession}</span>
                        </div>

                        <div class="session-details d-flex flex-wrap">
                            <c:forEach var="sessionDetail" items="${requestScope.list1}">
                                <a href="session-detail?sid=${param.sid}&sdid=${sessionDetail.sdid}" class="btn btn-campus">${sessionDetail.sessionNumber}</a>
                            </c:forEach>
                        </div>
                    </div>




                </div>

                <div>
                    <h2 style="color: #39BACD;">Activities</h2>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Activity</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Type</th>
                                    <th colspan="2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="activity" items="${requestScope.list2}">
                                    <tr>
                                        <td>${activity.nameAct}</td>
                                        <td>${activity.timeStart}</td>
                                        <td>${activity.timeEnd}</td>
                                        <td>${activity.isFix ? 'Fixed Activity' : 'Normal Activity'}</td>
                                        <td>
                                            <button class="btn btn-danger" onclick="window.location.href = 'delete-curiculum-day?curid=${activity.curID}'">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
