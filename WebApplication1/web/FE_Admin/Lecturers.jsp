<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lecturers Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                text-align: center;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }
            header {
                background: #03ADD5;
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
                border-radius: 20px;
                background: #32CD32;
                transition: background-color 0.3s ease;
            }
            header a:hover {
                background-color: #228B22;
            }
            .name {
                color: white;
                font-size: 1.8em;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
            }
            .btn-group {
                margin-bottom: 20px;
            }
            .btn-custom {
                background-color: #03ADD5;
                border-color: #03ADD5;
                color: white;
                margin: 5px;
                transition: background-color 0.3s ease;
            }
            .btn-custom:hover {
                background-color: #0288D1;
                border-color: #0288D1;
            }
            .dashboard-box {
                text-align: center;
                padding: 20px;
                border-radius: 10px;
                margin: 10px;
                color: white;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .dashboard-box.blue {
                background-color: #03ADD5;
            }
            .dashboard-box.green {
                background-color: #32CD32;
            }
            .dashboard-box.yellow {
                background-color: #FFD54F;
                color: #000;
            }
            .form-inline .form-control {
                width: auto;
            }
            .form-inline button {
                margin-left: 10px;
            }
            .modal-header {
                background-color: #03ADD5;
                color: white;
                border-radius: 10px 10px 0 0;
            }
            .btn-primary {
                background-color: #32CD32;
                border-color: #32CD32;
            }
            .btn-primary:hover {
                background-color: #228B22;
                border-color: #1C6D1F;
            }
            .btn-secondary {
                background-color: #9E9E9E;
                border-color: #9E9E9E;
            }
            .form-group label {
                font-weight: bold;
            }
            table {
                width: 90%;
                margin: 0 auto;
                border-collapse: collapse;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background: #fff;
                border-radius: 20px;
                overflow: hidden;
                border: 5px solid #03ADD5;
            }
            th, td {
                padding: 1rem;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #03ADD5;
                color: white;
            }
            tbody tr:last-child td {
                border-bottom: none;
            }
            tbody td:last-child {
                border-right: none;
            }
            @media (max-width: 768px) {
                body {
                    font-size: 14px;
                }
                table {
                    width: 100%;
                }
            }

            /* Custom styles for header buttons */
            .header-buttons .btn {
                padding: 10px 20px;
                font-size: 1rem;
                border-radius: 25px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }
            .header-buttons .btn-search {
                background-color: #FFD700;
                color: #333;
                border: 2px solid #FFD700;
                margin-left: 20px;
            }
            .header-buttons .btn-search:hover {
                background-color: #FFC107;
                border: 2px solid #FFC107;
                color: #fff;
            }
            .header-buttons .btn-add {
                background-color: #28A745;
                color: #fff;
                border: 2px solid #28A745;
            }
            .header-buttons .btn-add:hover {
                background-color: #218838;
                border: 2px solid #218838;
            }
            .header-buttons .btn-history {
                background-color: #17A2B8;
                color: #fff;
                border: 2px solid #17A2B8;
            }
            .header-buttons .btn-history:hover {
                background-color: #138496;
                border: 2px solid #138496;
            }
        </style>
        <script>
            function confirmDelete(lid) {
                Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Yes, delete it!"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'delete-lecturer?lid=' + lid;
                    }
                });
            }
        </script>
    </head>
    <body>
        <header class="d-flex justify-content-between align-items-center">
            <div>
                <button class="btn btn-light" onclick="window.location.href = 'adminhome'">Back to home</button>
            </div>
            <div class="date-range">
                <span id="dateStart">${sc.dateStart}</span> - <span id="dateEnd">${sc.dateEnd}</span>
            </div>
            <div class="header-buttons d-flex align-items-center">
                <form action="lecturers" method="get" class="d-flex align-items-center">
                    <input type="text" name="nameLec" class="form-control" placeholder="Search">
                    <button class="btn btn-search ml-2" type="submit">Search</button>
                </form>
                <button class="btn btn-add mx-2" onclick="window.location.href = 'lecturers'">Show All Lecturers</button>
                <button class="btn btn-add mx-2" onclick="window.location.href = 'add-lecturer'">Add</button>
                <button class="btn btn-history" onclick="window.location.href = 'history?yid=${sc.yid}'">History</button>
            </div>
        </header>
        <main class="main">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>DOB</th>
                        <th>Phone Number</th>
                        <th>ID Card</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Class Name</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${!empty requestScope.list1}">
                            <c:forEach var="lcs" items="${requestScope.list1}">
                                <tr>
                                    <td>${lcs.lid.lid}</td>
                                    <td>${lcs.lid.lname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${lcs.lid.gender}">
                                                Male
                                            </c:when>
                                            <c:otherwise>
                                                Female
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${lcs.lid.dob}</td>
                                    <td>${lcs.lid.phoneNumber}</td>
                                    <td>${lcs.lid.IDcard}</td>
                                    <td>${lcs.lid.address}</td>
                                    <td>${lcs.lid.email}</td>
                                    <td>${lcs.csid.classID.clname}</td>
                                    <td class="actions text-center">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-sm btn-warning" onclick="window.location.href = 'update-lecturers?lid=${lcs.lid.lid}'">Update</button>
                                            &nbsp&nbsp&nbsp&nbsp
                                            <button class="btn btn-sm btn-danger" onclick="confirmDelete('${lcs.lid.lid}')">Delete</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="lcs" items="${requestScope.list}">
                                <tr>
                                    <td>${lcs.lid.lid}</td>
                                    <td>${lcs.lid.lname}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${lcs.lid.gender}">
                                                Male
                                            </c:when>
                                            <c:otherwise>
                                                Female
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${lcs.lid.dob}</td>
                                    <td>${lcs.lid.phoneNumber}</td>
                                    <td>${lcs.lid.IDcard}</td>
                                    <td>${lcs.lid.address}</td>
                                    <td>${lcs.lid.email}</td>
                                    <td>${lcs.csid.classID.clname}</td>
                                    <td class="actions text-center">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-sm btn-warning" onclick="window.location.href = 'update-lecturers?lid=${lcs.lid.lid}'">Update</button>
                                            &nbsp&nbsp&nbsp&nbsp
                                            <button class="btn btn-sm btn-danger" onclick="confirmDelete('${lcs.lid.lid}')">Delete</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </main>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
