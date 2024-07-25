<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Class Session</title>
        <style>
            body {
                font-family: 'Roboto', cursive, sans-serif;
                background-color: #FFFAF0;
                margin: 0;
                padding: 0;
            }

            h1, h2 {
                color: black;
                text-align: center;
            }

            .btn-campus, .btn-campus1 {
                background-color: #FFA500; /* orange */
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
                background-color: #FF4500; /* orange red */
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
                color: #2acee8;
            }

            select {
                width: 50%;
                padding: 10px;
                border: 2px solid #ced4da;
                border-radius: 10px;
                font-size: 16px;
                color: #495057;
                margin-bottom: 15px;
                border: 2px solid #2acee8;
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
                background-color: #03ADD5;
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
                background-color: #32CD32; /* green */
                color: white;
            }

            .status-inactive {
                background-color: #FF6347; /* tomato red */
                color: white;
            }
        </style>
        <!-- Include SweetAlert2 library -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Check if there's an attempt to update an old school year
            <c:if test="${oldYearUpdateAttempt}">
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'You cannot update this school year as it has already passed!'
                });
            </c:if>

                const roomSelects = document.querySelectorAll('select[name="rid"]');
                const sessionSelects = document.querySelectorAll('select[name="sid"]');
                const statusSelects = document.querySelectorAll('select[name="status"]');

                function updateRoomOptions() {
                    const selectedRooms = new Set(Array.from(roomSelects)
                            .map(select => select.value)
                            .filter(value => value !== ""));

                    roomSelects.forEach(select => {
                        const currentValue = select.value;
                        const options = Array.from(select.options);
                        options.forEach(option => {
                            if (option.value !== "" && selectedRooms.has(option.value) && option.value !== currentValue) {
                                option.style.display = 'none';
                            } else {
                                option.style.display = 'block';
                            }
                        });
                    });
                }

                roomSelects.forEach(select => {
                    select.addEventListener('change', updateRoomOptions);
                });
                updateRoomOptions();

                function updateStatusColor() {
                    statusSelects.forEach(select => {
                        if (select.value === "true") {
                            select.classList.add('status-active');
                            select.classList.remove('status-inactive');
                        } else {
                            select.classList.add('status-inactive');
                            select.classList.remove('status-active');
                        }
                    });
                }

                statusSelects.forEach(select => {
                    select.addEventListener('change', updateStatusColor);
                });

                updateStatusColor();

            <c:if test="${not oldYearUpdateAttempt}">
                document.querySelectorAll('.btn-campus').forEach(button => {
                    button.addEventListener('click', function (event) {
                        event.preventDefault();
                        Swal.fire({
                            title: "Do you want to save the changes?",
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: "Save",
                            denyButtonText: `Don't save`
                        }).then((result) => {
                            if (result.isConfirmed) {
                                Swal.fire("Saved!", "", "success").then(() => {
                                    button.closest('form').submit();
                                });
                            } else if (result.isDenied) {
                                Swal.fire("Changes are not saved", "", "info");
                            }
                        });
                    });
                });
            </c:if>
            });
        </script>
    </head>

    <body>
        <div class="content-wrapper">
            <div class="mb-3" style="text-align: center;">
                <button class="btn btn-campus1" onclick="window.location.href = 'classController'">Back</button>
            </div>
            <h1>Add Class Session</h1>

            <!-- Form to select School Year -->
            <div class="form-group">
                <form action="classSession-add" method="GET">
                    <label for="selectedYid">Select School Year:</label>
                    <select id="selectedYid" name="selectedYid" onchange="this.form.submit()">
                        <option value="">Select a year</option>
                        <c:forEach var="year" items="${years}">
                            <option value="${year.yid}" <c:if test="${year.yid == selectedYid}">selected</c:if>>${year.dateStart} - ${year.dateEnd}</option>
                        </c:forEach>
                    </select>
                </form>
            </div>

            <c:if test="${not empty selectedYid && selectedYid != -1}">
                <c:if test="${not empty classSessions}">
                    <form action="classSession-add" method="POST">
                        <input type="hidden" name="selectedYid" value="${selectedYid}">
                        <input type="hidden" name="action" value="update">
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Class Name</th>
                                        <th>Room Name</th>
                                        <th>Session Name</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="classSession" items="${classSessions}">
                                        <tr>
                                            <td>${classSession.classID.clname}</td>
                                            <td>
                                                <select name="rid">
                                                    <option value="">Select a room</option>
                                                    <c:forEach var="room" items="${rooms}">
                                                        <option value="${room.rid}" <c:if test="${room.rid == classSession.rid.rid}">selected</c:if>>${room.rname}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="sid">
                                                    <option value="">Select a session</option>
                                                    <c:forEach var="session" items="${sessions}">
                                                        <option value="${session.sid}" <c:if test="${session.sid == classSession.sid.sid}">selected</c:if>>${session.sname}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="status">
                                                    <option value="true" <c:if test="${classSession.status}">selected</c:if>>Active</option>
                                                    <option value="false" <c:if test="${!classSession.status}">selected</c:if>>Inactive</option>
                                                    </select>
                                                </td>
                                        <input type="hidden" name="classID" value="${classSession.classID.classid}">
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div style="text-align: center;">
                            <button class="btn-campus" type="submit">Update</button>
                        </div>
                    </form>
                </c:if>

                <c:if test="${empty classSessions}">
                    <form action="classSession-add" method="POST">
                        <input type="hidden" name="selectedYid" value="${selectedYid}">
                        <input type="hidden" name="action" value="save">
                        <p style="text-align: center; font-size: 18px;">Selected School Year: ${selectedYid}</p>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Class Name</th>
                                        <th>Room Name</th>
                                        <th>Session Name</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cls" items="${classes}">
                                        <tr>
                                            <td>${cls.clname}</td>
                                            <td>
                                                <select name="rid">
                                                    <option value="">Select a room</option>
                                                    <c:forEach var="room" items="${rooms}">
                                                        <option value="${room.rid}">${room.rname}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="sid">
                                                    <option value="">Select a session</option>
                                                    <c:forEach var="session" items="${sessions}">
                                                        <option value="${session.sid}">${session.sname}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="status">
                                                    <option value="true">Active</option>
                                                    <option value="false">Inactive</option>
                                                </select>
                                            </td>
                                    <input type="hidden" name="classID" value="${cls.classid}">
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div style="text-align: center;">
                            <button class="btn-campus" type="submit">Save</button>
                        </div>
                    </form>
                </c:if>
            </c:if>
        </div>
    </body>
</html>
