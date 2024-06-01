<%-- 
    Document   : NewSchoolYear
    Created on : May 30, 2024, 6:55:04 PM
    Author     : DELL
--%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create New School Year</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Create New School Year</h2>
            <form action="newyear" method="POST">
                <div class="form-group">
                    <label for="dateStart">Start Date:</label>
                    <input type="date" class="form-control" id="dateStart" name="dateStart" required>
                </div>
                <div class="form-group">
                    <label for="dateEnd">End Date:</label>
                    <input type="date" class="form-control" id="dateEnd" name="dateEnd" required>
                </div>
                <button type="submit" class="btn btn-primary">Create</button>
            </form>
        </div>
    </body>
</html>
