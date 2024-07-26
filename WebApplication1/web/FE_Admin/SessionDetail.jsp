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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <style>
            body {
                font-family: 'Roboto', cursive, sans-serif;
                background-color: #FFFAF0; /* Ivory */
                margin: 0;
                padding: 0;
            }

            header {
                background: #33B7CE;
                color: white;
                padding: 1rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 1rem;
                position: relative;
            }

            header a {
                position: absolute;
                right: 1rem;
                top: 1rem;
                color: white;
                text-decoration: none;
                font-size: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 25px;
                background: #FF4500; /* Orange Red */
                transition: background-color 0.3s ease;
            }

            header a:hover {
                background-color: #FF6347; /* Tomato */
            }

            .btn-campus, .btn-campus1 {
                background-color: #638EBF;
                color: white;
                border: none;
                padding: 12px 25px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 18px;
                margin: 10px 5px;
                cursor: pointer;
                transition: all 0.3s ease;
                border-radius: 25px;
            }

            .btn-campus:hover, .btn-campus1:hover {
                background-color: #63E3AD; /* Orange Red */
            }

            .content-wrapper {
                max-width: 1000px;
                margin: auto;
                padding: 20px;
                background-color: white;
                border-radius: 20px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .form-group {
                margin-bottom: 15px;
                text-align: center;
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
                color: #2acee8; /* Light blue */
            }

            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
                margin-top: 20px;
                border-radius: 15px;
                border: 2px solid #ced4da;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                border-radius: 15px;
                overflow: hidden;
            }

            table, th, td {
                border: 1px solid #dee2e6;
            }

            th, td {
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #03ADD5; /* Light blue */
                color: white;
            }

            td select {
                width: 80%;
                padding: 8px;
                border: 2px solid #ced4da;
                border-radius: 10px;
                font-size: 16px;
                color: #495057;
            }

            .status-active {
                background-color: #32CD32; /* Lime green */
                color: white;
            }

            .status-inactive {
                background-color: #FF6347;
                color: white;
            }

            .btn-primary {
                background-color: #374955;
                border-color: #374955;
            }

            .btn-primary:hover {
                background-color: #228B22;
                border-color: #228B22;
            }

            .btn-session {
                background-color: #17a2b8;
                color: white;
                border: none;
                padding: 10px 20px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                margin: 4px 2px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                border-radius: 25px;
            }

            .btn-session.selected {
                background-color: #63E3AD; /* Màu nổi bật */
                color: white;
            }

            .btn-session:hover {
                background-color: #63E3AD;
            }

        </style>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmDelete(curID) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#DC3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, delete it!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'delete-curiculum-day?curid=' + curID;
                    }
                })
            }

            function handleSessionDetailClick(button, sid, sdid) {
                // Xóa lớp 'selected' khỏi tất cả các nút session detail
                const buttons = document.querySelectorAll('.btn-campus1');
                buttons.forEach(btn => btn.classList.remove('selected'));

                // Thêm lớp 'selected' vào nút session detail được nhấp
                button.classList.add('selected');

                const url = new URL(window.location.href);
                url.searchParams.set('sid', sid);
                url.searchParams.set('sdid', sdid);
                window.location.href = url.toString();
            }

            function handleSessionClick(button) {
                // Xóa lớp 'selected' khỏi tất cả các nút session
                const buttons = document.querySelectorAll('.btn-session');
                buttons.forEach(btn => btn.classList.remove('selected'));

                // Thêm lớp 'selected' vào nút session được nhấp
                button.classList.add('selected');
            }

            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const selectedSdid = urlParams.get('sdid');
                if (selectedSdid) {
                    const buttons = document.querySelectorAll('.btn-campus1');
                    buttons.forEach(btn => {
                        if (btn.getAttribute('data-sdid') === selectedSdid) {
                            btn.classList.add('selected');
                        }
                    });
                }

                // Kiểm tra nếu có session đã được chọn trong URL, thêm lớp 'selected' cho nút đó
                const selectedSid = urlParams.get('sid');
                if (selectedSid) {
                    const selectedButton = document.querySelector(`.btn-session[data-sid="${selectedSid}"]`);
                    if (selectedButton) {
                        selectedButton.classList.add('selected');
                    }
                }
            };
        </script>
    </head>
    <body>
        <header>
            <h1 class="name">Course Information</h1>
            <a href="session" class="btn btn-campus">Back To Session</a>
        </header>
        <div class="container mt-5">
            <div class="content-wrapper">
                <div class="mb-3 d-flex justify-content-between align-items-start">
                    <div>
                        <h2>Available Sessions</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Session Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="session" items="${requestScope.list}">
                                        <tr>
                                            <td>
                                                <form action="session-detail" method="get" style="display: inline;">
                                                    <input type="hidden" name="sid" value="${session.sid}">
                                                    <button type="submit" class="btn btn-session" data-sid="${session.sid}" onclick="handleSessionClick(this)">${session.sname}</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div>
                        <div class="mb-3 d-flex justify-content-between align-items-center">
                            <h2 style="margin-right: 10px">Session Details</h2>
                            <form action="add-session" method="POST" style="display:inline;">
                                <input type="hidden" name="sid" value="${param.sid}" />
                                <button type="submit" class="btn btn-primary">Add Session</button>
                            </form>
                            &nbsp&nbsp
                            <span class="total-session">Total Session: ${requestScope.list1[0].sid.totalSession}</span>
                        </div>
                        <div class="session-details d-flex flex-wrap">
                            <c:forEach var="sessionDetail" items="${requestScope.list1}">
                                <a href="javascript:void(0);" class="btn btn-campus1" data-sdid="${sessionDetail.sdid}" onclick="handleSessionDetailClick(this, '${param.sid}', '${sessionDetail.sdid}')">Session ${sessionDetail.sessionNumber}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div>
                    <h2>Activities</h2>
                    <button class="btn btn-danger" id="addActivityButton">Add Activity</button>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
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
                                        <td colspan="2">
                                            <c:if test="${!activity.isFix}">
                                                <button class="btn btn-danger" onclick="confirmDelete('${activity.curID}')">Delete</button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <script>
                        alert('${sessionScope.errorMessage}');
                    </script>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                        document.getElementById('addActivityButton').onclick = function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            const sdid = urlParams.get('sdid');
                            if (sdid > 0) {
                                window.location.href = `add-curiculum?sid=${param.sid}&sdid=${param.sdid}`;
                            } else {
                                alert('Please select a session detail before adding an activity.');
                            }
                        };

                        window.onload = function () {
                            const urlParams = new URLSearchParams(window.location.search);
                            const errorMessage = urlParams.get('errorMessage');
                            if (errorMessage) {
                                alert(decodeURIComponent(errorMessage));
                            }
                        };
        </script>
    </body>
</html>
