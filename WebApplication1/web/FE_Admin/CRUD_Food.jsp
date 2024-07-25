<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Food</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        </style>
    </head>
    <body>
        <header>
            <a href="menu">Back to Menu</a>
            <h1 class="name">Food Management</h1>
        </header>

        <div class="container mt-5">
            <!-- Display error message if present -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <div class="row mb-3">
                <div class="col-sm-6">
                    <form class="form-inline" action="search-food" method="GET">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search" required>
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>                
                <div class="col-sm-6 text-right">
                    <button class="btn btn-custom" id="addFoodBtn" data-toggle="modal" data-target="#addFoodModal">Add New Food</button>
                </div>
            </div>

            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>FoodID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>           
                <tbody>
                    <c:choose>
                        <c:when test="${not empty searchResults}">
                            <c:forEach var="food" items="${searchResults}">
                                <tr data-foodid="${food.foodid}" data-foodname="${food.fname}">
                                    <td>${food.foodid}</td>
                                    <td>${food.fname}</td>
                                    <td>
                                        <button class="btn btn-warning btn-sm" onclick="editFood('${food.foodid}', '${food.fname}')">Update</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteFood('${food.foodid}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="food" items="${foodList}">
                                <tr data-foodid="${food.foodid}" data-foodname="${food.fname}">
                                    <td>${food.foodid}</td>
                                    <td>${food.fname}</td>
                                    <td>
                                        <button class="btn btn-warning btn-sm" onclick="editFood('${food.foodid}', '${food.fname}')">Update</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteFood('${food.foodid}')">Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Add Food Modal -->
        <div class="modal fade" id="addFoodModal" tabindex="-1" aria-labelledby="addFoodModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addFoodModalLabel">Add New Food</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="add-food" method="POST">                           
                            <div class="form-group">
                                <label for="fname">Food Name</label>
                                <input type="text" class="form-control" name="fname" id="fname" required>
                            </div>

                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Food Modal -->
        <div class="modal fade" id="updateFoodModal" tabindex="-1" aria-labelledby="updateFoodModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateFoodModalLabel">Update Food</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="update-food" method="POST">
                            <div class="form-group">
                                <label for="updateFoodId">Food ID</label>
                                <input type="text" class="form-control" name="foodid" id="updateFoodId" readonly>
                            </div>
                            <div class="form-group">
                                <label for="updateFoodName">Food Name</label>
                                <input type="text" class="form-control" name="fname" id="updateFoodName" required>
                            </div>

                            <button type="submit" class="btn btn-primary mt-3">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete Food Modal -->
        <div class="modal fade" id="deleteFoodModal" tabindex="-1" aria-labelledby="deleteFoodModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteFoodModalLabel">Delete Food</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this food item?</p>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
                                            let deleteFoodId;

                                            function deleteFood(foodId) {
                                                deleteFoodId = foodId;
                                                $('#deleteFoodModal').modal('show');
                                            }

                                            function editFood(foodId, foodName) {
                                                document.getElementById('updateFoodId').value = foodId;
                                                document.getElementById('updateFoodName').value = foodName;
                                                $('#updateFoodModal').modal('show');
                                            }

                                            document.getElementById('confirmDeleteBtn').addEventListener('click', function () {
                                                const form = document.createElement('form');
                                                form.method = 'POST';
                                                form.action = 'delete-food';

                                                const input = document.createElement('input');
                                                input.type = 'hidden';
                                                input.name = 'foodid';
                                                input.value = deleteFoodId;

                                                form.appendChild(input);
                                                document.body.appendChild(form);
                                                form.submit();
                                            });
        </script>
    </body>
</html>
