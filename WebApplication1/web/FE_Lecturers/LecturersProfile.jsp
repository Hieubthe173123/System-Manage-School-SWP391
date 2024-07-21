<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Lecturer Profile</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap');

            body {
                font-family: 'Roboto', cursive;
                background: #FFFAF0;
                margin: 0;
                padding: 0;
                color: #333;
                display: flex;
                height: 100vh;
            }

            .sidebar {
                background-color: #00C9D0;
                width: 250px;
                color: #333;
                padding: 1rem;
                display: flex;
                flex-direction: column;
                align-items: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .sidebar img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                border: 5px solid #004085;
                margin-bottom: 1rem;
            }

            .sidebar .nickname {
                font-weight: bold;
                font-size: 1.5rem;
                color: #fff;
                margin-bottom: 1.5rem;
            }

            .sidebar a {
                color: #333;
                text-decoration: none;
                margin-bottom: 1rem;
                text-align: center;
                width: 100%;
                padding: 0.75rem;
                border-radius: 10px;
                background-color: #41E0B3;
                transition: background-color 0.3s, color 0.3s;
            }

            .sidebar a:hover {
                background-color: #FF9800;
                color: white;
            }

            .sidebar .logout {
                margin-top: auto;
                background-color: #dc3545;
                border: none;
                color: white;
                text-align: center;
                padding: 10px;
                border-radius: 5px;
                font-weight: bold;
                width: 100%;
            }

            .sidebar .logout:hover {
                background-color: #c82333;
            }

            .content {
                flex: 1;
                padding: 2rem;
                overflow-y: auto;
                background-color: #F1F1F1;
            }

            .card {
                margin-bottom: 1.5rem;
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #FFF;
                max-width: 600px; 
                margin: 0 auto; 
            }

            .card-header {
                background-color: #03ADD5;
                color: white;
                border-radius: 10px 10px 0 0;
                padding: 0.75rem;
            }

            .card-body {
                padding: 1rem;
            }

            .info-group {
                margin-bottom: 0.75rem; 
            }

            .info-group label {
                font-weight: bold;
                margin-bottom: 0.25rem;
                color: #03ADD5;
            }

            .info-group p {
                margin-bottom: 0;
                color: #555;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    box-shadow: none;
                }

                .sidebar img {
                    width: 80px;
                    height: 80px;
                }

                .content {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <img src="../Image/7886962.png" alt="Profile Picture">
            <div class="nickname">${lecturers.nickname}</div>
            <a href="timeTableLecturer?lid=${sessionScope.lid}" text-decoration: none;">Back to Home</a>
            <a href="update-lecturers?lid=${lecturers.lid}&lname=${lecturers.lname}&dob=${lecturers.dob}&phoneNumber=${lecturers.phoneNumber}&IDcard=${lecturers.IDcard}&address=${lecturers.address}&email=${lecturers.email}&nickname=${lecturers.nickname}">Update Profile</a>
            <a href="changepass">Change Password</a>
            <button class="logout" onclick="window.location.href = '${pageContext.request.contextPath}/logout'">Logout</button>
        </div>
        <div class="content">
            <div class="container mt-1">
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
