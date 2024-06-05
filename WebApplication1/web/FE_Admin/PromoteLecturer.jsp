<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Lecturers Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background-color: #b3d9ff;
        }
        .form-group label {
            font-weight: bold;
            color: #333;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #f0f9ff;
            padding: 1rem;
            border-radius: 10px 10px 0 0;
        }
        .card-body {
            padding: 2rem;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
    <div class="container mt-3">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h2>Add Lecturers To Class</h2>
                    </div>
                    <div class="card-body">
                        <form action="promote-lecturer" method="POST">
                            <div class="form-group">
                                <label for="lname">Họ và tên</label>
                              <select class="form-control" id="lecturer" name="lid" required>
                                    <option>Chọn Giáo Viên</option>
                                    <c:forEach items="${requestScope.lec}" var="lec">
                                        <option value="${lec.lid}">${lec.lname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="class">Tên Lớp</label>
                                 <select class="form-control" id="class" name="classID" required>
                                    <option>Chọn lớp học</option>
                                    <c:forEach items="${requestScope.listA}" var="cla">
                                        <option value="${cla.classid}">${cla.clname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
