<%-- 
    Document   : CRUD_Food
    Created on : Jun 5, 2024, 1:36:44 AM
    Author     : hidung
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Product</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .header {
                background-color: orange;
                padding: 10px;
                color: white;
                text-align: center;
            }
            .header a {
                color: white;
                margin: 0 15px;
            }
            .header a:hover {
                text-decoration: none;
            }
            .table img {
                width: 100px;
                height: 100px;
            }
            .btn {
                margin: 0 5px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Food Management</h2>
            <div class="row w-100 mb-3">
                <div class="col-sm-6 mb-3 d-flex justify-content-between">
                    <form class="form-inline" action="search-food" method="GET">
                        <input class="form-control mr-sm-2" type="search" name="searchInput" placeholder="Search" required>
                        <button class="btn btn-success my-2 my-sm-0" type="submit">Search</button>
                    </form>
                </div>
                <div class="col-sm-6">
                    <button class="btn btn-primary" id="addFoodBtn" data-toggle="modal" data-target="#addFoodModal">Add New Food</button>
                </div>
                <table class="table table-bordered">
                    <thead class="thead-light">
                        <tr>
                            <th>FoodID</th>
                            <th>Name</th>
                            <th>Calo</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="food" items="${foodList}">
                            <tr data-foodid="${food.foodid}" data-foodname="${food.fname}" data-calo="${food.calo}">
                                <td>${food.foodid}</td>
                                <td>${food.fname}</td>
                                <td>${food.calo}</td>
                                <td>
                                    <button class="btn btn-warning btn-sm" onclick="editFood('${food.foodid}', '${food.fname}', '${food.calo}')">Update</button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="deleteFood('${food.foodid}')">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Food Modal -->
        <div class="modal fade" id="addFoodModal" tabindex="-1" aria-labelledby="addFoodModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addFoodModalLabel">Add New Food</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="add-food" method="POST">                           
                            <div class="form-group">
                                <label for="foodname">Food Name</label>
                                <input type="text" class="form-control" name="fname" id="fname" required>
                            </div>
                            <div class="form-group">
                                <label for="calo">Calo</label>
                                <input type="number" class="form-control" name="calo" id="calo" required>
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
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="update-food" method="POST">
                            <div class="form-group">
                                <label for="updateFoodId">Food ID</label>
                                <input type="text" class="form-control" name="foodid" id="updateFoodId" required>
                            </div>
                            <div class="form-group">
                                <label for="updateFoodName">Food Name</label>
                                <input type="text" class="form-control" name="fname" id="updateFoodName" required>
                            </div>
                            <div class="form-group">
                                <label for="updateCalo">Calo</label>
                                <input type="number" class="form-control" name="calo" id="updateCalo" required>
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
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
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

                                        function editFood(foodId, foodName, calo) {
                                            document.getElementById('updateFoodId').value = foodId;
                                            document.getElementById('updateFoodName').value = foodName;
                                            document.getElementById('updateCalo').value = calo;

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

