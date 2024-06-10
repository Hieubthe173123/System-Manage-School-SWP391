<%-- Session.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sessions List</title>
        <style>
            /* styles.css */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
            }
            .container {
                max-width: 900px;
                margin: 50px auto;
                background: #fff;
                padding: 20px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }
            .sessions-list {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
            }
            .session-link {
                display: block;
                background: #007bff;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                transition: background 0.3s;
            }
            .session-link:hover {
                background: #0056b3;
            }
            .session-details {
                margin-top: 20px;
                border-top: 1px solid #ccc;
                padding-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .session-activity {
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
                width: 100%;
            }
            .total-session {
                font-size: 20px;
                font-weight: bold;
            }
            .activity-link {
                text-decoration: none;
                color: #007bff;
                transition: color 0.3s;
                font-size: 18px;
                font-weight: bold;
            }
            .activity-link:hover {
                color: #0056b3;
            }
            .activity-controls {
                display: flex;
                align-items: center; /* Căn chỉnh các phần tử theo chiều dọc */
            }

            .add-session-button {
                margin-right: 10px; /* Khoảng cách giữa nút và liên kết */
                background-color: #28a745; /* Màu nền */
                color: #fff; /* Màu chữ */
                border: none; /* Loại bỏ viền */
                border-radius: 5px; /* Bo tròn các góc */
                padding: 8px 15px; /* Kích thước lề */
                font-size: 16px; /* Kích thước chữ */
                cursor: pointer; /* Biểu tượng con trỏ khi rê chuột */
                transition: background-color 0.3s; /* Hiệu ứng chuyển đổi màu nền */
            }

            .add-session-button:hover {
                background-color: #218838; /* Màu nền khi di chuột vào */
            }

            .activity-link {
                text-decoration: none;
                color: #007bff; /* Màu chữ */
                transition: color 0.3s; /* Hiệu ứng chuyển đổi màu chữ */
                font-size: 16px; /* Kích thước chữ */
                font-weight: bold; /* Đậm */
            }

            .activity-link:hover {
                color: #0056b3; /* Màu chữ khi di chuột vào */
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h1>Available Sessions</h1>
            <div class="sessions-list">
                <c:forEach var="session" items="${requestScope.list}">
                    <a href="session-detail?sid=${session.sid}" class="session-link">${session.sname}</a>
                </c:forEach>
            </div>
            <div class="session-details">
                <div class="session-activity">
                    <span class="total-session">Tổng số buổi học: ${requestScope.list1[0].sid.totalSession}</span>
                    <div class="activity-controls">
                        <a href="curriculum?sid=${param.sid}" class="activity-link">Hoạt động của khóa học</a>
                    </div>
                </div>
            </div>

            <div class="session-details">
                <c:forEach var="sessionDetail" items="${requestScope.list1}">
                    <a href="activity-day?sid=${param.sid}&sdid=${sessionDetail.sdid}" class="activity-link">Buổi ${sessionDetail.sessionNumber}</a>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
