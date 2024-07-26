<%-- 
    Document   : HomePage
    Created on : May 16, 2024, 9:51:33 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sakura Preschool</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #e0f7fa;
            }
            .header {
                background: url('../Image/1488535058_nha-tre.jpg') no-repeat center center;
                background-size: cover;
                color: black;
                padding: 200px 0;
            }
            .header h1 {
                font-size: 3.5rem;
                font-weight: bold;
            }
            .header p {
                font-size: 1.5rem;
            }
            .content-section {
                padding: 60px 0;
            }
            .footer {
                background-color: #343a40;
                color: white;
                padding: 20px 0;
            }
            .navbar {
                background-color: #0c9abc;
            }
            .navbar-brand, .nav-link {
                color: white !important;
            }
            .nav-link:hover {
                color: #ffeb3b !important;
            }
            .registration-section {
                background-color: #ffffff;
                padding: 60px 0;
                border-top: 2px solid #0c9abc;
                border-bottom: 2px solid #0c9abc;
            }
            .registration-section h2 {
                margin-bottom: 30px;
                font-size: 2.5rem;
                color: #0c9abc;
            }
            .registration-section p {
                margin-bottom: 40px;
                font-size: 1.2rem;
                color: #555;
            }
            .form-control {
                border-radius: 5px;
                border: 1px solid #ddd;
                padding: 10px;
                font-size: 1rem;
                transition: all 0.3s ease-in-out;
            }
            .form-control:focus {
                border-color: #0c9abc;
                box-shadow: 0 0 8px rgba(12, 154, 188, 0.2);
            }
            .btn-primary {
                background-color: #0c9abc;
                border-color: #0c9abc;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 1.2rem;
                transition: all 0.3s ease-in-out;
            }
            .btn-primary:hover {
                background-color: #0a7e8a;
                border-color: #0a7e8a;
                box-shadow: 0 0 10px rgba(10, 126, 138, 0.4);
            }
            .form-group {
                margin-bottom: 1.5rem;
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Sakura Preschool</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Home Page</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#section_1">About Us</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#section_2">Contact</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <header class="header text-center">
            <div class="container">
                <h1 data-aos="fade-down">Welcome to Sakura Preschool</h1>
                <p data-aos="fade-up" data-aos-delay="300">Where Future Talents are Nurtured</p>
            </div>
        </header>

        <section class="content-section bg-light" id="section_1">
            <div class="container">
                <div class="row">
                    <div class="col-md-6" data-aos="fade-right">
                        <h2>About Us</h2>
                        <p>Sakura Preschool was established with the mission of providing a friendly, creative, and comprehensive learning environment for young children.</p>
                    </div>
                    <div class="col-md-6" data-aos="fade-left">
                        <img src="../Image/8-1.jpg" alt="About Us" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>

        <section class="content-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 order-md-2" data-aos="fade-left">
                        <h2>Curriculum</h2>
                        <p>Our curriculum is designed using advanced educational methods to help children develop comprehensively in both physical and mental aspects.</p>
                    </div>
                    <div class="col-md-6 order-md-1" data-aos="fade-right">
                        <img src="../Image/aHR0cHM6Ly93d3cuaXNzcC5lZHUudm4vZmlsZXMvY2h1b25nLXRyaW5oLWVhbC5qcGc_Tmw0WnV4Q1RGUkR5cGk3S2FfWXFXcFBrTzZFUVhTak8.webp" alt="Curriculum" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>

        <section class="content-section bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-md-6" data-aos="fade-right">
                        <h2>Extracurricular Activities</h2>
                        <p>We organize a variety of extracurricular activities, from sports and arts to science, helping children explore and develop their personal interests.</p>
                    </div>
                    <div class="col-md-6" data-aos="fade-left">
                        <img src="../Image/hoat-dong-ngoai-khoa-4.jpg" alt="Activities" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>

        <section class="content-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 order-md-2" data-aos="zoom-in">
                        <h2>Teaching Staff</h2>
                        <p>Our teaching staff are highly qualified professionals who are passionate about their work and dedicated to each student.</p>
                    </div>
                    <div class="col-md-6 order-md-1" data-aos="zoom-in">
                        <img src="../Image/vlzgnx5mdmmusf6bgshp.jpg" alt="Teachers" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>

        <section class="content-section bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-md-6" data-aos="flip-left">
                        <h2>Facilities</h2>
                        <p>Sakura Preschool is equipped with modern facilities that meet all the needs for learning and play for children.</p>
                    </div>
                    <div class="col-md-6" data-aos="flip-right">
                        <img src="../Image/kham-pha-he-thong-co-so-vat-chat-giup-smisers-phat-trien-toan-dien-tai-sakura-duong-kinh-7.jpg" alt="Facilities" class="img-fluid">
                    </div>
                </div>
            </div>
        </section>

        <section class="registration-section text-center" id="section_2">
            <div class="container" data-aos="fade-up">
                <h2>Register for Admission</h2>
                <p>Please fill out the form below to register your child for admission.</p>
                <form>
                    <div class="form-group row">
                        <label for="parentName" class="col-sm-2 col-form-label">Parent's Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="parentName" placeholder="Parent's Name">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="studentName" class="col-sm-2 col-form-label">Student's Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="studentName" placeholder="Student's Name">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="email" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email" placeholder="Email">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="phone" class="col-sm-2 col-form-label">Phone Number</label>
                        <div class="col-sm-10">
                            <input type="tel" class="form-control" id="phone" placeholder="Phone Number">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="message" class="col-sm-2 col-form-label">Message</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="message" rows="4" placeholder="Message"></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Registration</button>
                </form>
            </div>
        </section>

        <footer class="footer text-center">
            <div class="container">
                <p>&copy; 2024 Sakura Preschool. All rights reserved.</p>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
        <script>
            AOS.init({
                duration: 1000,
                easing: 'ease-in-out',
                once: true
            });
        </script>
    </body>
</html>
