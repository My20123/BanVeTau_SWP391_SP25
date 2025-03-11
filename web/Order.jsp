<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đơn Hàng - VietTrains</title>
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

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <style>
        .order-card {
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border: none;
        }
        .order-header {
            background: linear-gradient(to right, #06A3DA, #0986c7);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
        }
        .order-body {
            padding: 30px;
        }
        .info-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .ticket-table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .ticket-table thead {
            background-color: #06A3DA;
            color: white;
        }
        .total-amount {
            font-size: 1.5rem;
            color: #06A3DA;
            font-weight: bold;
        }
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
        }
        .action-buttons .btn {
            padding: 10px 25px;
            border-radius: 25px;
            font-weight: 600;
        }
        .delete-btn {
            color: #dc3545;
            cursor: pointer;
            transition: all 0.3s;
            padding: 5px;
            border-radius: 5px;
        }
        .delete-btn:hover {
            background-color: #dc3545;
            color: white;
        }
        .passenger-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
        }
        .passenger-info input {
            padding: 4px 8px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .passenger-info label {
            margin-bottom: 0;
            min-width: 60px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="Header.jsp"></jsp:include>
<div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
                    <a href="Home.jsp" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="home" class="nav-item nav-link active">Trang chủ</a>
                            <a href="about.html" class="nav-item nav-link ">Thông tin đặt chỗ</a>
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link">Giờ tàu-Giá vé</a>                            
                            <a href="routesview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="TicketVerifi.jsp" class="nav-item nav-link">Kiểm tra vé</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                        </div>
                    </div>
                </nav>
                <div class=" container-fluid pt-5 pb-4" style="background-color: #06A3DA; height: 70px;">
                </div>
</div>

    <div class="container" style="margin-top: 120px; margin-bottom: 50px;">
        <div class="card order-card">
            <div class="order-header">
                <h2 class="m-0"><i class="fas fa-ticket-alt me-2"></i>Thông Tin Chi Tiết </h2>
            </div>
            
            <div class="order-body">
                <c:if test="${not empty order}">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="info-section">
                                <h5 class="mb-4"><i class="fas fa-user me-2"></i>Thông Tin Đặt Vé</h5>
                                <p><strong><i class="fas fa-hashtag"></i> Mã Vé:</strong> 522</p>
                                <p><strong><i class="fas fa-user-circle"></i> Tên Khách Hàng:</strong> My</p>
                                <p><strong><i class="fas fa-id-card"></i> CCCD:</strong> 0889</p>
                                <p><strong><i class="far fa-envelope"></i> Email:</strong> email</p>
                                <p><strong><i class="fas fa-phone"></i> Số Điện Thoại:</strong> 09xxx</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-5">
                        <h5 class="mb-4"><i class="fas fa-info-circle me-2"></i>Chi Tiết Vé</h5>
                        <div class="ticket-table">
                            <table class="table table-striped mb-0">
                                <thead>
                                    <tr>
                                        <th>Họ Tên</th>
                                        <th>Thông Tin Chỗ</th>
                                        <th>Giá Vé</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${selectedSeats}" var="seat">
                                        <c:set var="totalPrice" value="${totalPrice + seatMap['price']}" />
                                        <tr>
                                            <td>
                                                <div class="passenger-info">
                                                    <label>Họ tên:</label>
                                                    <input type="text">
                                                </div>
                                                <div class="passenger-info">
                                                    <label>CCCD:</label>
                                                    <input type="text">
                                                </div>
                                            </td>
                                            <td>
                                                <strong>Ghế: </strong>${seat["seatNumber"]} ${seat["seatType"]}<br>
                                                <strong>Tàu: </strong> ${seat["selectedTrainId"]}<br>
                                                <strong>Cabin: </strong>${seat["selectedCabinId"]}<br>
                                                <strong>Khởi hành:</strong>${from_date}
                                            </td>
                                            <td>${seat["price"]} VNĐ</td>
                                            <td>
                                                <a href="javascript:void(0)" onclick="deleteTicket(this)" class="delete-btn">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </td>
                                        </tr>
                                   </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <div class="mt-4 text-end">
                        <h5 class="total-amount">Tổng Tiền: ${totalPrice} VNĐ</h5>
                    </div>
                    
                    <div class="action-buttons">
                        <a href="payment?orderId=${order.id}" class="btn btn-primary">
                            <i class="fas fa-credit-card me-2"></i>Tiến Hành Thanh Toán
                        </a>
                        <a href="home" class="btn btn-outline-secondary">
                            <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                        </a>
                    </div>
                </c:if>
                
                <c:if test="${empty order}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Không tìm thấy thông tin đơn hàng.
                    </div>
                    <a href="home" class="btn btn-outline-secondary">
                        <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                    </a>
                </c:if>
            </div>
        </div>
    </div>

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
        function deleteTicket(element) {
            if (confirm('Bạn có chắc chắn muốn xóa vé này không?')) {
                const row = element.closest('tr');
                row.remove();
                updateTotalPrice();
            }
        }

        function updateTotalPrice() {
            // Implement total price recalculation logic here
            // This is a placeholder - you'll need to implement the actual calculation
            const rows = document.querySelectorAll('tbody tr');
            let total = 0;
            rows.forEach(row => {
                const priceText = row.querySelector('td:nth-child(3)').textContent;
                const price = parseInt(priceText.replace(/[^\d]/g, ''));
                total += price;
            });
            document.querySelector('.total-amount').textContent = `Tổng Tiền: ${total.toLocaleString('vi-VN')} VNĐ`;
        }
    </script>
</body>
</html>
