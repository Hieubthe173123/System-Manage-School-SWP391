<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Parent Management</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }

            h2 {
                margin-bottom: 20px;
            }

            .table th, .table td {
                vertical-align: middle;
            }

            .modal-header {
                background-color: #007bff;
                color: white;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }

            .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
            }

            .form-group label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Parent Management</h2>

            <div class="row mt-3">
                <div class="col-sm-6">
                    <form class="form-inline" action="search-parent" method="post">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search parent..." required>
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="add-parent" class="btn btn-primary" id="addNewParentBtn">Add New Parent</a>
                </div>
            </div>

            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                         <th>No</th>
                        <th>Parent ID</th>
                        <th>Parent Name</th>
                        <th>Gender</th>
                        <th>DOB</th>
                        <th>Phone Number</th>
                        <th>ID Card</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Nickname</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty searchparent}">
                            <c:forEach var="parent" items="${searchparent}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1 + (index - 1) * 10}</td>
                                    <td>${parent.pid}</td>
                                    <td>${parent.pname}</td>
                                    <td>${parent.gender ? 'Male' : 'Female'}</td>
                                    <td>${parent.dob}</td>
                                    <td>${parent.phoneNumber}</td>
                                    <td>${parent.IDcard}</td>
                                    <td>${parent.address}</td>
                                    <td>${parent.email}</td>
                                    <td>${parent.nickname}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="parent" items="${parentList}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1 + (index - 1) * 10}</td>
                                    <td>${parent.pid}</td>
                                    <td>${parent.pname}</td>
                                    <td>${parent.gender ? 'Male' : 'Female'}</td>
                                    <td>${parent.dob}</td>
                                    <td>${parent.phoneNumber}</td>
                                    <td>${parent.IDcard}</td>
                                    <td>${parent.address}</td>
                                    <td>${parent.email}</td>
                                    <td>${parent.nickname}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <!-- Paging controls for students of a specific class -->
            <div class="d-flex justify-content-center Endpage">
                <c:if test="${!empty parentList}">
                    <c:if test="${index > 1}">
                        <button class="page-btn" onclick="window.location.href = 'parent?pid=${pid}&index=${index - 1}'">Previous</button>
                    </c:if>
                    <c:forEach begin="1" end="${endPage}" var="i">
                        <button class="page-btn ${i == index ? 'active' : ''}" onclick="window.location.href = 'parent?pid=${pid}&index=${i}'">${i}</button>
                    </c:forEach>
                    <c:if test="${index < endPage}">
                        <button class="page-btn" onclick="window.location.href = 'parent?pid=${pid}&index=${index + 1}'">Next</button>
                    </c:if>
                </c:if>
            </div>
             <style>
                .Endpage {
                    margin-top: 10px;
                }
                .page-btn {
                    margin: 0 5px;
                    padding: 5px 10px;
                    background-color: #007bff;
                    border: none;
                    color: white;
                    cursor: pointer;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }
                .page-btn:hover {
                    background-color: #0056b3;
                }
                .page-btn.active {
                    background-color: #0056b3;
                    font-weight: bold;
                }
            </style>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
