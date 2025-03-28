<%-- 
    Document   : RoutesTable
    Created on : Feb 13, 2025, 2:04:40 PM
    Author     : tra my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.DAO" %>
<%@ page import="java.util.List" %>
<%
    DAO dao = new DAO();
    List<String> listS = dao.getAllStations();
    request.setAttribute("listS", listS);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>VietTrains</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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
        <link href="css/style.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap');

            body {
                font-family: 'Open Sans', sans-serif;
                background-color: #f8f9fa;
            }

            .navbar {
                background-color: #353e4a !important;
            }

            .nav-item.nav-link {
                color: white !important;
            }

            .nav-item.nav-link.active {
                color: #ffa500 !important;
            }

            .station-search-container {
                display: flex;
                align-items: flex-end;
                background: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin: 20px 0;
                gap: 15px;
            }

            .station-select {
                flex: 1;
            }

            .input-container label {
                display: block;
                margin-bottom: 8px;
                color: #495057;
                font-weight: 500;
                font-size: 14px;
            }

            .form-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 6px;
                font-size: 14px;
                transition: all 0.2s ease;
                background: #fff;
            }

            .form-input:focus {
                outline: none;
                border-color: #4dabf7;
                box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
            }

            .station-switcher {
                background: none;
                border: none;
                padding: 0 20px;
                cursor: pointer;
                display: flex;
                align-items: center;
                margin-bottom: 8px;
            }

            .station-switcher svg {
                width: 24px;
                height: 24px;
                fill: #666;
                transition: transform 0.3s;
            }

            .station-switcher:hover svg {
                fill: #333;
            }

            .btn-submit {
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.2s ease;
                background: #228be6;
                color: white;
                border: none;
                height: 38px;
                margin-bottom: 8px;
            }

            .btn-submit:hover {
                background: #1c7ed6;
            }

            @media (max-width: 768px) {
                .station-search-container {
                    flex-direction: column;
                    align-items: stretch;
                }

                .station-switcher {
                    transform: rotate(90deg);
                    margin: 10px 0;
                }
            }
        </style>
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
            <!-- Nav start -->
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0" style="background-color: #353e4a;">
                    <a href="" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                           <a href="home" class="nav-item nav-link ">Trang chủ</a>
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link active">Lịch trình tàu</a>                            
                            <a href="routeview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="Feedback.jsp" class="nav-item nav-link">Đánh giá</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                        </div>
                    </div>
                </nav>
                <div class=" container-fluid py-4 mb-5 " style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
                    <div class="container py-5" style="margin-top: 3rem;">
                        <form action="searchschedule" method="GET" id="searchForm">
                            <div class="station-search-container">
                                <div class="station-select">
                                    <div class="input-container">
                                        <label>Ga đi</label>
                                        <input class="form-input" 
                                               name="from_station" 
                                               list="stationsList" 
                                               id="from_station"
                                               required
                                               autocomplete="off"
                                               placeholder="Chọn ga đi">
                                    </div>
                                </div>

                                <button type="button" class="station-switcher" onclick="swapData()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                                        <path d="M21.925 11.62a.999.999 0 0 0-.21-.33l-4.002-3.996a1.004 1.004 0 0 0-1.42 1.418l2.3 2.288H5.407l2.3-2.288a1.003 1.003 0 1 0-1.42-1.418L2.285 11.29a1 1 0 0 0-.21.33c-.1.243-.1.516 0 .759a.998.998 0 0 0 .21.33l4.002 3.996a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.419l-2.3-2.288h13.186l-2.3 2.288a.999.999 0 0 0 .325 1.637 1.002 1.002 0 0 0 1.095-.218l4.002-3.996a.998.998 0 0 0 .21-.33c.1-.243.1-.516 0-.76Z"/>
                                    </svg>
                                </button>

                                <div class="station-select">
                                    <div class="input-container">
                                        <label>Ga đến</label>
                                        <input class="form-input" 
                                               name="to_station" 
                                               list="stationsList" 
                                               id="to_station"
                                               required
                                               autocomplete="off"
                                               placeholder="Chọn ga đến">
                                    </div>
                                </div>

                                <div class="station-select" style="max-width: 200px;">
                                    <div class="input-container">
                                        <label>Ngày đi</label>
                                        <input type="date" 
                                               name="date" 
                                               id="datepicker" 
                                               class="form-input" 
                                               required>
                                    </div>
                                </div>

                                <button type="submit" class="btn-submit">Tìm kiếm</button>
                            </div>
                        </form>

                        <datalist id="stationsList">
                            <c:forEach items="${listS}" var="o">
                                <option value="${o}">
                            </c:forEach>
                        </datalist>

                        <!-- Kết quả tìm kiếm -->
                        <div class="search-results mt-5">
                            <c:if test="${not empty scheduleList}">
                                <div class="table-responsive">
                                    <table class="table table-hover" style="background: white; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                                        <thead>
                                            <tr>
                                                
                                                
                                                <th>Mã tàu</th>
                                                <th>Loại tàu</th>
                                                <th>Ga đi</th>
                                                <th>Ga đến</th>
                                                <th>Giờ đi</th>
                                                <th>Giờ đến</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${scheduleList}" var="s">
                                                <tr>
                                                    
                                                    
                                                    <td>${s.trid}</td>
                                                    <td>${s.trainType}</td>
                                                    <td>${s.fromStation}</td>
                                                    <td>${s.toStation}</td>
                                                    <td>
                                                        <div style="font-size: 20px; font-weight: bold;">
                                                            <fmt:formatDate value="${s.fromTime}" pattern="HH:mm"/>
                                                        </div>
                                                        <div style="color: #666; font-size: 14px;">
                                                            <fmt:formatDate value="${s.fromTime}" pattern="dd 'tháng' MM"/>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div style="font-size: 20px; font-weight: bold;">
                                                            <fmt:formatDate value="${s.toTime}" pattern="HH:mm"/>
                                                        </div>
                                                        <div style="color: #666; font-size: 14px;">
                                                            <fmt:formatDate value="${s.toTime}" pattern="dd 'tháng' MM"/>
                                                        </div>
                                                    </td>
                                                    
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty scheduleList and not empty param.from_station}">
                                <div class="alert alert-info">
                                    Không tìm thấy lịch trình nào phù hợp.
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Nav end -->

        <jsp:include page="Footer.jsp"></jsp:include>
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
        <script>
            function swapData() {
                var fromStation = document.getElementById('from_station').value;
                var toStation = document.getElementById('to_station').value;
                document.getElementById('from_station').value = toStation;
                document.getElementById('to_station').value = fromStation;
            }
        </script>
    </body>
</html>
