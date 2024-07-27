<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Schedules</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #fffae6;
                color: #333;
            }
            h2, h3 {
                color: #333;
                text-align: center;
                margin-top: 20px;
            }
            form {
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            select, input[type="text"], input[type="submit"] {
                display: block;
                width: 100%;
                margin: 10px 0;
                padding: 10px;
                font-size: 16px;
                border: 2px solid #03ADD5;
                border-radius: 10px;
            }
            select {
                background-color: #fffae6;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 20px;
                border: 5px solid #03ADD5;
            }
            th, td {
                padding: 10px;
                border: 2px solid black;
                text-align: center;
            }
            th {
                background-color: #03ADD5;
                color: white;
                font-size: 18px;
            }
            td {
                font-size: 16px;
            }
            a {
                display: block;
                text-align: center;
                margin: 20px 0;
                text-decoration: none;
                color: #007BFF;
            }
            a:hover {
                text-decoration: underline;
            }
            .delete-button, .return-button {
                background-color: #007BFF;
                border: none;
                color: white;
                padding: 8px 16px;
                text-align: center;
                font-size: 16px;
                cursor: pointer;
                border-radius: 10px;
                margin: 10px;
                transition: background-color 0.3s ease;
                text-decoration: none;
            }
            .delete-button {
                background-color: #f44336;
            }
            .delete-button:hover {
                background-color: #e53935;
            }
            .return-button:hover {
                background-color: #0066cc;
            }
            .button-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 1rem;
            }
            .button-container a {
                font-size: 16px;
                text-decoration: none;
                color: white;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 8px 16px;
                border: none;
                cursor: pointer;
                border-radius: 10px;
                margin: 10px;
                transition: background-color 0.3s ease;
                display: inline-block;
                font-size: 16px;
            }
            button a {
                text-decoration: none;
                color: white;
                display: inline-block;
            }
            button:hover {
                background-color: #45a049;
            }
            .delete-button a, .return-button a {
                color: white;
                text-decoration: none;
            }
        </style>
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
        <script>
            function confirmDeletion(event) {
                event.preventDefault(); // Prevent default action of the link
                const link = event.currentTarget.getAttribute('href');
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = link; // Redirect to the delete URL
                    }
                });
            }
        </script>
    </head>
    <body>
        <c:if test="${sessionScope.csid != null && sessionScope.csid != 0}">
            <h2>Class Schedule for ${sessionScope.className} Academic Year ${sessionScope.year.dateStart} - ${sessionScope.year.dateEnd}</h2>
            <div class="button-container">
                <a href="timeTableLecturer?lid=${sessionScope.lid}" class="return-button">Return</a>
                <c:if test="${sessionScope.sche != null}">
                    <a href="addSchedules?idToDelete=${sessionScope.sche.scheID}&csid=${sessionScope.csid}" class="delete-button" onclick="confirmDeletion(event)">Delete Today's Schedule</a>
                </c:if>
            </div>

            <h3>${requestScope.Delete}</h3>
            <h3>${requestScope.mess}</h3>
            <form action="addSchedules" method="GET">
                <select name="sdid" onchange="this.form.submit()">
                    <option value="0">Select Session</option>
                    <c:forEach items="${sessionScope.listSchedulesUnlearn}" var="s">
                        <option value="${s.sdid.sdid}" ${s.sdid.sdid == sessionScope.sdid ? 'selected' : ''}> 
                            Session ${s.sdid.sessionNumber}
                        </option>
                    </c:forEach>
                </select>
                <input type="hidden" value="${sessionScope.csid}" name="csid"/>
                <c:if test="${sessionScope.sche != null}">
                    <input type="submit" value="Update" name="sm"/>
                </c:if>
                <c:if test="${sessionScope.sche == null}">
                    <input type="submit" value="Add" name="sm"/>
                </c:if>
            </form>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Time</th>
                        <th>Activity Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.listCuri}" var="c" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${c.timeStart} - ${c.timeEnd}</td>
                            <td>${c.nameAct}</td>
                        </tr>            
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${sessionScope.csid == null || sessionScope.csid == 0}">
            <div class="button-container">
                <a href="timeTableLecturer?lid=${sessionScope.lid}" class="return-button">Back To TimeTable</a>
            </div>
            <h3>The lecturer has not been assigned a teaching schedule for this academic year.</h3>
        </c:if>
    </body>
</html>
