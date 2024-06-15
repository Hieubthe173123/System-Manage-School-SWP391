<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Promote Students</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <style>
            .btn-campus {
                background-color: #39BACD;
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
                background-color: #39BACD;
            }

            .custom-link:active {
                font-weight: bold;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
            }

            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body class="container mt-5">
        <div class="content-wrapper">
            <div class="mb-3">
                <button class="btn btn-campus" onclick="window.location.href = 'classController'">Back To List</button>
            </div>
        </div>
        <h1>Promote Students ( <c:out value="${selectedYear[0].dateStart} - ${selectedYear[0].dateEnd}"/> )</h1>
        <form action="promote" method="GET" class="form-inline mb-3">
            <label for="yearSelect" class="mr-2">Select Year:</label>
            <select name="yid" id="yearSelect" class="form-control" onchange="this.form.submit()">
                <option value="">Select a year</option>
                <c:forEach var="year" items="${listYear}">
                    <option value="${year.yid}" <c:if test="${param.yid == year.yid}">selected</c:if>>
                        ${year.dateStart} - ${year.dateEnd}
                    </option>
                </c:forEach>
            </select>
        </form>

        <c:if test="${not empty param.yid}">
            <form action="promote" method="POST">
                <input type="hidden" name="yid" value="${param.yid}"/>
                <label for="classSelect" class="mr-2">Select New Class:</label>
                <select name="newCsid" id="classSelect" class="form-control" onchange="this.form.submit()">
                    <option value="">Select a class</option>
                    <c:forEach var="cl" items="${listClassSession}">
                        <option value="${cl.csid}" <c:if test="${param.newCsid == cl.csid}">selected</c:if>>
                            ${cl.classID.clname}
                        </option>
                    </c:forEach>
                </select>
            </form>
        </c:if>

        <c:if test="${not empty param.newCsid}">
            <c:set var="previousYearPrinted" value="false"/>

            <c:forEach var="student" items="${studentClassSessionOldYear}">
                <c:if test="${previousYearPrinted == 'false'}">
                    <h3>Select Students to Promote in Previous Year ( ${student.csid.yid.dateStart} - ${student.csid.yid.dateEnd} )</h3>
                    <c:set var="previousYearPrinted" value="true"/>
                </c:if>
            </c:forEach>

            <!-- Form và bảng hiển thị danh sách học sinh -->
            <form action="promote" method="POST">
                <input type="hidden" name="yid" value="${param.yid}"/>
                <input type="hidden" name="newCsid" value="${param.newCsid}"/>

                <!-- Ô tìm kiếm -->
                <div class="form-group">
                    <label for="searchInput" class="mr-2">Search:</label>
                    <input type="text" id="searchInput" class="form-control" placeholder="Enter class name to search">
                </div>

                <div class="form-check mb-3">
                    <input type="checkbox" id="selectAllCheckbox" class="form-check-input">
                    <label for="selectAllCheckbox" class="form-check-label">Select All</label>
                </div>

                <!-- Bảng danh sách học sinh -->
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Select</th>
                            <th>No.</th>
                            <th>Student ID</th>
                            <th>Student Name</th>
                            <th>Gender</th>
                            <th>Date Of Birth</th>
                            <th>Age</th>
                            <th>Class</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty studentClassSessionOldYear}">
                            <c:forEach var="s" items="${studentClassSessionOldYear}" varStatus="idex">
                                <c:if test="${s.csid.sid.sid != '5'}">
                                    <tr>
                                        <td>
                                            <input type="checkbox" name="selectedStudents" value="${s.stuid.stuid}"
                                                   <c:if test="${fn:contains(assignedStudents, s.stuid.stuid)}">disabled</c:if>/>
                                            </td>
                                            <td>${idex.index + 1}</td>
                                        <td>${s.stuid.stuid}</td>
                                        <td>${s.stuid.sname}</td>
                                        <td>${s.stuid.gender ? 'Nam' : 'Nữ'}</td>
                                        <td>${s.stuid.dob}</td>
                                        <td>${s.csid.sid.sid} tuổi</td>
                                        <td>${s.csid.classID.clname}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </tbody>
                </table>
                <button type="submit" id="dialog" class="btn btn-primary">Promote Selected Students</button>
            </form>
        </c:if>

        <script>

            // Xử lý sự kiện khi nhấn nút "Select All"
            document.getElementById("selectAllCheckbox").addEventListener("change", function () {
                var checkboxes = document.querySelectorAll('tbody tr:not([style*="display: none"]) input[name="selectedStudents"]');
                checkboxes.forEach(function (checkbox) {
                    checkbox.checked = this.checked;
                }, this);
            });

            // Xử lý sự kiện khi nhập liệu vào ô tìm kiếm
            document.getElementById("searchInput").addEventListener("input", function () {
                var searchQuery = this.value.toLowerCase().trim();
                var rows = document.querySelectorAll("tbody tr");
                rows.forEach(function (row) {
                    var className = row.cells[7].textContent.toLowerCase();
                    //            var sessionId = row.cells[6].textContent.toLowerCase();
                    if (className.includes(searchQuery)) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            });

            // Xử lý sự kiện click cho nút "Promote Selected Students"
            document.getElementById("dialog").addEventListener('click', function (event) {
                // Hiển thị thông báo khi click nút
                Swal.fire({
                    title: "Add Successful",
                    text: "That thing is still around?",
                    icon: "success"
                });
                // Xử lý sự kiện click cho nút "Promote Selected Students"
                handlePromoteButtonClick(event);
            });

            // Xử lý sự kiện click cho nút "Promote Selected Students"
            function handlePromoteButtonClick(event) {
                // Lấy danh sách các checkbox
                var checkboxes = document.querySelectorAll('input[name="selectedStudents"]');
                var checked = false;
                checkboxes.forEach(function (checkbox) {
                    if (checkbox.checked) {
                        checked = true;
                    }
                });
                // Kiểm tra nếu không có học sinh nào được chọn
                if (!checked) {
                    event.preventDefault(); // Ngăn chặn sự kiện submit form
                    Swal.fire({
                        title: "Error",
                        text: "Please select at least one student.",
                        icon: "error"
                    });
                }
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
