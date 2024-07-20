<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lecturer Profile</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
        }
        .info-group {
            margin-bottom: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .info-group label {
            font-weight: bold;
            color: #333;
            flex: 1;
        }
        .info-group p {
            color: #666;
            flex: 2;
            margin: 0;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .card-header {
            background-color: #39BACD; /* Blue background */
            color: white;
            padding: 1rem;
            border-radius: 10px 10px 0 0;
        }
        .card-body {
           padding: 2rem;
        }
        .sidebar {
            background-color: #343a40;
            color: white;
            padding: 1rem;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 200px;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
        }
        .sidebar a {
            color: white;
            display: block;
            margin: 30px 0;
            text-decoration: none;
            font-weight: bold;
        }
        .sidebar a:hover {
            text-decoration: none;
            color: #d1ecf1;
        }
        .sidebar .logout {
            margin-top: auto;
            background-color: #dc3545; /* Red background */
            border: none;
            color: white;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .sidebar .logout:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .content {
            margin-left: 220px;
            padding: 20px;
        }
        .btn-info a {
            color: white;
            text-decoration: none;
        }
        .btn-info a:hover {
            color: white;
        }
        .container {
            max-width: 800px;
            margin-left: 90px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Dashboard</h2>
        <a href="update-lecturers?lid=${lecturers.lid}&lname=${lecturers.lname}&dob=${lecturers.dob}&phoneNumber=${lecturers.phoneNumber}&IDcard=${lecturers.IDcard}&address=${lecturers.address}&email=${lecturers.email}&nickname=${lecturers.nickname}">Update Profile</a>
        <a href="changepass">Change Password</a>
        <button class="logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Logout</button>
    </div>
    <div class="content">
        <div class="container mt-1">
            <button class="btn btn-info"><a href="timeTableLecturer?lid=${sessionScope.lid}">Home</a></button>
            <form id="lecturersForm" action="lecturers-profile" method="post">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h2>Lecturers Information</h2>
                            </div>
                            <div class="card-body">
                                <div class="info-group">
                                    <label>ID:</label>
                                    <p>${lecturers.lid}</p>
                                </div>
                                <div class="info-group">
                                    <label>Name:</label>
                                    <p>${lecturers.lname}</p>
                                </div>
                                <div class="info-group">
                                    <label>Gender:</label>
                                    <p>${lecturers.gender}</p>
                                </div>
                                <div class="info-group">
                                    <label>Date of Birth:</label>
                                    <p>${lecturers.dob}</p>
                                </div>
                                <div class="info-group">
                                    <label>Phone Number:</label>
                                    <p>${lecturers.phoneNumber}</p>
                                </div>
                                <div class="info-group">
                                    <label>ID Card:</label>
                                    <p>${lecturers.IDcard}</p>
                                </div>
                                <div class="info-group">
                                    <label>Address:</label>
                                    <p>${lecturers.address}</p>
                                </div>
                                <div class="info-group">
                                    <label>Email:</label>
                                    <p>${lecturers.email}</p>
                                </div>
                                <div class="info-group">
                                    <label>Nickname:</label>
                                    <p>${lecturers.nickname}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
