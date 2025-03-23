<%-- 
    Document   : Home
    Created on : Jan 19, 2025, 10:48:04 PM
    Author     : tra my
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <style>
            .schedule-table {
                margin: 20px auto;
                width: 95%;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                border-collapse: collapse;
            }
            
            .schedule-table th {
                background-color: #f8f9fa;
                padding: 12px;
                border-bottom: 2px solid #dee2e6;
                text-align: center;
            }
            
            .schedule-table td {
                padding: 12px;
                border-bottom: 1px solid #dee2e6;
                text-align: center;
                vertical-align: middle;
            }
            
            .btn-sua {
                background-color: #86B817;
                color: white;
                border: none;
                padding: 4px 8px;
                border-radius: 4px;
                text-decoration: none;
                margin-right: 4px;
                display: inline-block;
                font-size: 0.9em;
            }
            
            .btn-xoa {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 4px 8px;
                border-radius: 4px;
                text-decoration: none;
                display: inline-block;
                font-size: 0.9em;
            }
            
            .time-cell {
                white-space: nowrap;
            }
            
            .time {
                font-weight: bold;
                margin-right: 8px;
                font-size: 1.2em;
                color: #333;
                display: block;
            }
            
            .date {
                color: #666;
                font-size: 0.9em;
            }
            
            .btn-sua:hover, .btn-xoa:hover {
                opacity: 0.9;
                color: white;
                text-decoration: none;
            }

            .action-cell {
                white-space: nowrap;
                width: 120px;
            }

            .btn-sua i, .btn-xoa i {
                margin-right: 2px;
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
                            <a href="home" class="nav-item nav-link" style="color: white;">Trang chủ</a>
                            <a href="manageschedule" class="nav-item nav-link active" style="color: #ffa500;">Quản lí lịch trình</a>
                            <a href="" class="nav-item nav-link" style="color: white;">Quản lí tàu</a>                            
                            <a href="" class="nav-item nav-link" style="color: white;">Quản lí vé tàu</a>
                        </div>
                    </div>
                </nav>
            </div>

            <div class="container-xxl py-5">
                <div class="container">
                    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                        <h6 class="section-title bg-white text-center text-primary px-3">Quản lí</h6>
                        <h1 class="mb-5"></h1>
                    </div>

                    <!-- Nút thêm mới -->
                    <div class="mb-3">
                        <a href="AddSchedule.jsp" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Thêm lịch trình mới
                        </a>
                    </div>

                    <!-- Bảng lịch trình -->
                    <div class="table-responsive">
                        <table class="schedule-table" id="scheduleTable">
                            <thead>
                                <tr>
                                    <th>Mã Tàu</th>
                                    <th>Loại tàu </th>
                                    <th>Ga Đi</th>
                                    <th>Ga Đến</th>
                                    <th>Thời Gian Đi</th>
                                    <th>Thời Gian Đến</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${schedules}" var="s">
                                    <tr>
                                        
                                        <td>${s.trid}</td>
                                        <td>${s.trainType}</td>
                                        <td>${s.fromStation}</td>
                                        <td>${s.toStation}</td>
                                        <td class="time-cell">
                                            <fmt:parseDate value="${s.fromTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedFromTime"/>
                                            <span class="time"><fmt:formatDate value="${parsedFromTime}" pattern="HH:mm"/></span>
                                            <span class="date">
                                                <fmt:formatDate value="${parsedFromTime}" pattern="dd"/> tháng 
                                                <fmt:formatDate value="${parsedFromTime}" pattern="MM"/>
                                            </span>
                                        </td>
                                        <td class="time-cell">
                                            <fmt:parseDate value="${s.toTime}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedToTime"/>
                                            <span class="time"><fmt:formatDate value="${parsedToTime}" pattern="HH:mm"/></span>
                                            <span class="date">
                                                <fmt:formatDate value="${parsedToTime}" pattern="dd"/> tháng 
                                                <fmt:formatDate value="${parsedToTime}" pattern="MM"/>
                                            </span>
                                        </td>
                                        <td class="action-cell">
                                            <a href="EditSchedule?id=${s.id}" class="btn-sua">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                            <a href="#" onclick="confirmDelete(${s.id})" class="btn-xoa">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Thêm script xác nhận xóa -->
                    <script>
                        function confirmDelete(id) {
                            if (confirm('Bạn có chắc chắn muốn xóa lịch trình này không?')) {
                                window.location.href = 'DeleteSchedule?id=' + id;
                            }
                        }
                    </script>

                    <!-- Pagination -->
                    <div class="d-flex justify-content-center mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="manageschedule?page=${currentPage-1}">Trước</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="manageschedule?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="manageschedule?page=${currentPage+1}">Sau</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

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
            <script>
                // Spinner code
                window.addEventListener('load', function () {
                    var spinner = document.getElementById('spinner');
                    spinner.classList.remove('show');
                });
            </script>
    </body>
</html>