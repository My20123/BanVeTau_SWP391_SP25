<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Train list</title>
        <link rel="stylesheet" href="css/train.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="js/cabinfilter.js"></script>
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />


        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0" style="background-color: #353e4a;">
                    <a href="" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="navbar-nav ms-auto py-0">
                         <a href="manageschedule" class="nav-item nav-link " style="color: #ffa500;">Quản lí lịch trình</a>
                            <a href="viewT" class="nav-item nav-link " style="color: white;">Quản lí tàu</a> 
                            <a href="viewC" class="nav-item nav-link active" style="color: white;">Quản lí cabin</a> 
                            <a href="ManageSeat" class="nav-item nav-link" style="color: white;">Quản lí ghế</a> 
                            <a href="" class="nav-item nav-link" style="color: white;">Quản lí vé tàu</a>
                            <a href="viewRefund" class="nav-item nav-link" style="color: white;">Quản lí hoàn tiền</a>
                    </div>
                </nav>
            </div>
     
    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <div class="container">
        <div class="header">
            <div class="search-bar">
                <input type="text" id="search" placeholder="Search..." onkeyup="filterTable()">                       
                <select id="filterCabin" onchange="filterTable()">
                    <option value="all">All</option>
                    <option value="id">Cabin ID</option>
                    <option value="num_seat">Number seat</option>
                    <option value="status">Cabin status</option>
                    <option value="seats">Available_seat</option>
                    <option value="train_id">Train ID</option>
                    <option value="type">Cabin Type</option>
                    <option value="schedule_id">Schedule ID</option>
                </select>

            </div>

            <a href="AddCabin.jsp" class="add-order-btn">+ Add New Cabin</a>
        </div>
        <div class="table-container">
            <table id="trainTable">
                <thead>
                    <tr>
                        <th>Cabin ID</th>
                        <th>Number_seat</th>   
                        <th>Cabin status</th>
                        <th>Available_seat</th>
                        <th>Train_ID</th>
                        <th>Cabin Type</th>
                        <th>Schedule ID</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${clist}" var="c">
                    <tr>
                        <td>${c.id}</td>
                        <td>${c.number_seats}</td>
                        <td>
                            <c:choose>
                                <c:when test="${c.status == 1}">Available</c:when>
                                <c:when test="${c.status == 0}">Unavailable</c:when>
                                <c:otherwise>Sold Out</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${c.avail_seats}</td>
                        <td>${c.trid}</td>
                        <td>${c.ctype}</td>
                        <td>${c.sid}</td>
                        <td>
                            <a href="editC?id=${c.id}"><i class="fas fa-edit"></i></a>                                  
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pagination">
        <p id="pagination-info">Showing 10 results per page</p>
        <div>
            <button onclick="prevPage()">&lt;</button>
            <button class="active" onclick="goToPage(1)">1</button>
            <button onclick="goToPage(2)">2</button>
            <button onclick="nextPage()">&gt;</button>
        </div>
    </div>
</div>
<jsp:include page="Footer.jsp"></jsp:include>
<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/tempusdominus/js/moment.min.js"></script>
<script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
<script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>