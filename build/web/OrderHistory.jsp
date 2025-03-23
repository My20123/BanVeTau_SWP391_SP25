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
        <title>VietTrains - Lịch sử đặt vé</title>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <!-- Chỉ load các style cần thiết -->
        <!-- Chỉ load các style cần thiết -->
        <style>
            :root {
                --primary-color: #005F7A;
                --secondary-color: #2c3e50;
                --accent-color: #e74c3c;
                --success-color: #2ecc71;
                --warning-color: #f1c40f;
                --danger-color: #e74c3c;
                --light-bg: #f8f9fa;
            }

            .order-header {
                background: var(--primary-color);
                color: white;
                padding: 20px;
                border-radius: 15px 15px 0 0;
                margin-bottom: 20px;
            }

            .order-header h2 {
                font-size: 1.8rem;
                font-weight: 600;
                letter-spacing: 0.5px;
            }

            .order-header p {
                font-size: 1rem;
            }

            .filter-container {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
            }

            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 10px;
                padding: 10px 20px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus, .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(0, 95, 122, 0.2);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 10px;
                padding: 10px 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background-color: #004d63;
                transform: translateY(-2px);
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                border-radius: 10px;
                padding: 10px 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
            }

            .table {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            }

            .table thead th {
                background-color: var(--primary-color);
                color: white;
                font-weight: 500;
                padding: 1rem;
                border: none;
            }

            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e9ecef;
            }

            .table tbody tr:hover {
                background-color: rgba(0, 95, 122, 0.05);
            }

            .status-badge {
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: inline-block;
                min-width: 120px;
                text-align: center;
            }

            .status-pending {
                background-color: var(--warning-color);
                color: white;
            }

            .status-completed {
                background-color: var(--success-color);
                color: white;
            }

            .payment-type {
                padding: 8px 15px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
            }

            .payment-cash {
                background-color: #95a5a6;
                color: white;
            }

            .payment-card {
                background-color: #3498db;
                color: white;
            }

            .pagination {
                margin-top: 2rem;
            }

            .page-link {
                color: var(--primary-color);
                border: none;
                padding: 10px 20px;
                margin: 0 5px;
                border-radius: 10px;
                transition: all 0.3s ease;
            }

            .page-link:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .empty-state {
                text-align: center;
                padding: 3rem 0;
            }

            .empty-state i {
                font-size: 4rem;
                color: var(--primary-color);
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #6c757d;
                font-size: 1.1rem;
            }

            /* Thêm styles mới cho filter form */
            .filter-form {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-top: 20px;
            }

            .search-box, .filter-box {
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .input-group-text {
                border-right: none;
            }

            .form-control, .form-select {
                border-left: none;
            }

            .form-control:focus, .form-select:focus {
                border-color: #ced4da;
                box-shadow: none;
            }

            .btn-info {
                background-color: #17a2b8;
                border-color: #17a2b8;
                color: white;
            }

            .btn-info:hover {
                background-color: #138496;
                border-color: #117a8b;
                color: white;
            }

            .gap-2 {
                gap: 0.5rem;
            }

            .gap-3 {
                gap: 1rem;
            }

            .gap-4 {
                gap: 1.5rem;
            }


            .trigger-btn {
                display: inline-block;
                margin: 100px auto;
            }

            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
            }

            .btn-action:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .btn-action {
                padding: 8px 15px;
                border-radius: 8px;
                font-weight: 500;
                transition: all 0.3s ease;
                margin: 0 3px;
                min-width: 100px;
            }

            /* Thêm style cho các trạng thái mới */
            .status-rejected {
                background-color: var(--danger-color);
                color: white;
            }

            .status-refunded {
                background-color: #6c757d;
                color: white;
            }

            .btn-icon {
                width: 32px;
                height: 32px;
                padding: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid #e9ecef;
                background-color: white;
                transition: all 0.3s ease;
            }

            .btn-icon:hover {
                background-color: #f8f9fa;
                border-color: #dee2e6;
                transform: translateY(-2px);
            }

            .btn-icon i {
                font-size: 14px;
            }

            .modal-content {
                border: none;
                border-radius: 15px;
            }
            
            .modal-header {
                border-radius: 15px 15px 0 0;
                padding: 1.5rem;
            }
            
            .ticket-header {
                border-color: #e9ecef !important;
            }
            
            .journey-icon {
                position: relative;
            }
            
            .journey-icon:before,
            .journey-icon:after {
                content: '';
                position: absolute;
                left: 50%;
                width: 50%;
                height: 2px;
                background: #e9ecef;
            }
            
            .journey-icon:before {
                top: 50%;
                transform: translate(-100%, -50%);
            }
            
            .journey-icon:after {
                top: 50%;
                transform: translate(0, -50%);
            }
            
            .badge {
                padding: 0.5em 1em;
                font-weight: 500;
            }

        </style>

    </head>

    <body>
        <!-- Spinner Start -->
        <!--        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>-->
        <!-- Spinner End -->
        <jsp:include page="Header.jsp"></jsp:include>

            <!-- Hero Header -->
            <!-- Hero Header -->
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
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link">Lịch trình tàu</a>                            
                            <a href="routeview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="Feedback.jsp" class="nav-item nav-link">Đánh giá</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <!--                                                <div class="nav-item dropdown">
                                                                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                                                                                <div class="dropdown-menu m-0">
                                                                                    <a href="destination.html" class="dropdown-item">Destination</a>
                                                                                    <a href="booking.html" class="dropdown-item">Booking</a>
                                                                                    <a href="team.html" class="dropdown-item">Travel Guides</a>
                                                                                    <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                                                                                    <a href="404.html" class="dropdown-item">404 Page</a>
                                                                                </div>
                                                                            </div>-->
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                    </div>
                </nav>
                <div class=" container-fluid pb-5" style="background-color: var(--primary-color); height: 70px;">
                </div>

            </div>
            <!-- Navbar & Hero End -->
            <!-- Order History Table -->
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="filter-container">
                        <div class="order-header">
                            <h2 class="m-0 text-light"><i class="fas fa-history me-2"></i>Lịch Sử Đặt Vé</h2>
                            <p class="mb-0 mt-2 text-light" style="opacity: 0.9;">Xem lại các đơn đặt vé của bạn</p>
                        </div>
                        <form method="get" action="order-history" class="filter-form">
                            <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="search-box">
                                        <label for="from_station" class="form-label">Ga đi</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white border-end-0">
                                                <i class="fas fa-train text-muted"></i>
                                            </span>
                                            <input type="text" class="form-control border-start-0" id="from_station" 
                                                   name="from_station" placeholder="Nhập ga đi" list="stations"
                                                   value="${param.from_station != null ? param.from_station : ''}">
                                        <datalist id="stations">
                                            <c:forEach items="${listS}" var="o">
                                                <option value="${o}">
                                                </c:forEach>                                                                                                     
                                        </datalist>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="search-box">
                                    <label for="to_station" class="form-label">Ga đến</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0">
                                            <i class="fas fa-train text-muted"></i>
                                        </span>
                                        <input type="text" class="form-control border-start-0" id="to_station" 
                                               name="to_station" placeholder="Nhập ga đến" list="stations-to"
                                               value="${param.to_station != null ? param.to_station : ''}">
                                    </div>
                                    <datalist id="stations-to">
                                        <c:forEach items="${listS}" var="o">
                                            <option value="${o}">
                                            </c:forEach>                                                                                                     
                                    </datalist> 
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="search-box">
                                    <label for="departure_date" class="form-label">Ngày đi</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0">
                                            <i class="fas fa-calendar text-muted"></i>
                                        </span>
                                        <input type="date" class="form-control border-start-0" id="departure_date" 
                                               name="departure_date" 
                                               >
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <div class="search-box">
                                    <label for="status" class="form-label">Trạng thái</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white border-end-0">
                                            <i class="fas fa-info-circle text-muted"></i>
                                        </span>
                                        <select name="status" id="status" class="form-select border-start-0">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Bị từ chối</option>
                                            <option value="3" ${param.status == '3' ? 'selected' : ''}>Đã hoàn tiền</option>
                                            <option value="2" ${param.status == '2' ? 'selected' : ''}>Chờ xử lý</option>
                                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Hoàn thành</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 d-flex justify-content-end gap-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-filter me-2"></i>Lọc kết quả
                                </button>
                                <button type="button" class="btn btn-outline-secondary" onclick="resetForm()">
                                    <i class="fas fa-redo me-2"></i>Đặt lại
                                </button>
                            </div>
                        </div>
                    </form>
                </div>


                <div class="table-responsive">
                    <c:if test="${orderList.size() > 0}">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Vé</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Số tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${order.tickets.from_station} - ${order.tickets.to_station}</td>
                                        <td><fmt:formatDate value="${order.payment_date}" pattern="dd/MM/yyyy" /></td>
                                        <td><fmt:formatNumber value="${order.total_price}" pattern="#,##0" /> VNĐ</td>
                                        <td>
                                            <span class="status-badge ${order.status == 2 ? 'status-pending' : 
                                                                       order.status == 1 ? 'status-completed' :
                                                                       order.status == 0 ? 'status-rejected' :
                                                                       'status-refunded'}">
                                                ${order.status == 2 ? 'Chờ xử lý' : 
                                                  order.status == 1 ? 'Hoàn thành' :
                                                  order.status == 0 ? 'Bị từ chối' :
                                                  'Đã hoàn tiền'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <c:if test="${order.status == 1}">
                                                    <button class="btn btn-danger" onclick="openCancelModal(${order.id})">Hủy vé</button>
                                                </c:if>
                                                <button class="btn btn-light btn-icon" onclick="openDetailModal(${order.id})" title="Xem chi tiết">
                                                    <i class="fas fa-eye text-info"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <!-- Bootstrap Modal for Cancel Confirmation -->
                <div class="modal fade" id="cancelModal" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="cancelModalLabel">Xác nhận hủy vé</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc chắn muốn hủy vé này không?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                                <form id="cancel-order" method="POST" action="cancel-order">
                                    <input type="hidden" id="orderId" name="orderId" value="">
                                    <button type="submit" class="btn btn-danger">Có, hủy vé</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Chi Tiết Đơn Hàng -->
                <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="detailModalLabel">Chi Tiết Vé Tàu</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">
                                <div class="ticket-header border-bottom pb-3 mb-3">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="text-muted mb-1">Số vé</h6>
                                            <div class="d-flex align-items-center">
                                                <span id="trainNo" class="h5 mb-0 me-2"></span>
                                                <span class="badge bg-success">E-ticket</span>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <h6 class="text-muted mb-1">Ngày</h6>
                                            <span id="ticketDate" class="h6"></span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="ticket-details">
                                    <div class="row g-3">
                                        <div class="col-6">
                                            <h6 class="text-muted">Người lớn</h6>
                                            <span id="adultCount" class="h6">1</span>
                                        </div>
                                        <div class="col-6">
                                            <h6 class="text-muted">Trẻ em</h6>
                                            <span id="childCount" class="h6">0</span>
                                        </div>
                                        <div class="col-6">
                                            <h6 class="text-muted">Hạng</h6>
                                            <span id="ticketClass" class="h6"></span>
                                        </div>
                                        <div class="col-6">
                                            <h6 class="text-muted">Loại vé</h6>
                                            <span id="ticketQuota" class="h6">GENERAL</span>
                                        </div>
                                    </div>

                                    <div class="journey-details mt-4">
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="station-info flex-grow-1">
                                                <h6 class="text-muted mb-1">Ga đi</h6>
                                                <p id="fromStation" class="h6 mb-0"></p>
                                                <small id="departureTime" class="text-muted"></small>
                                            </div>
                                            <div class="journey-icon px-3">
                                                <i class="fas fa-train text-primary h4"></i>
                                            </div>
                                            <div class="station-info flex-grow-1 text-end">
                                                <h6 class="text-muted mb-1">Ga đến</h6>
                                                <p id="toStation" class="h6 mb-0"></p>
                                                <small id="arrivalTime" class="text-muted"></small>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="price-details mt-4 pt-3 border-top">
                                        <h6 class="text-muted mb-2">Tổng tiền</h6>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span id="totalPrice" class="h4 mb-0"></span>
                                            <small class="text-muted">(Đã bao gồm thuế)</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer bg-light">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Paging Links -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="order-history?page=${currentPage - 1}&status=${param.status}&keyword=${param.keyword}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="order-history?page=${i}&status=${param.status}&keyword=${param.keyword}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="order-history?page=${currentPage + 1}&status=${param.status}&keyword=${param.keyword}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

        <script>
            function resetForm() {
                document.getElementById('from_station').value = '';
                document.getElementById('to_station').value = '';
                document.getElementById('departure_date').value = '';
                document.getElementById('status').value = '';
                window.location.href = 'order-history';
            }
            function openCancelModal(orderId) {
                document.getElementById("orderId").value = orderId;
                var cancelModal = new bootstrap.Modal(document.getElementById("cancelModal"));
                cancelModal.show();
            }
            function openDetailModal(orderId) {
                // Gọi API để lấy thông tin chi tiết đơn hàng
                fetch(`get-order-detail?id=${orderId}`)
                    .then(response => response.json())
                    .then(data => {
                        // Cập nhật thông tin vé
                        document.getElementById('trainNo').textContent = data.trainNo;
                        document.getElementById('ticketDate').textContent = data.departureDate;
                        document.getElementById('fromStation').textContent = data.fromStation;
                        document.getElementById('toStation').textContent = data.toStation;
                        document.getElementById('departureTime').textContent = data.departureTime;
                        document.getElementById('arrivalTime').textContent = data.arrivalTime;
                        document.getElementById('ticketClass').textContent = data.ticketClass;
                        document.getElementById('totalPrice').textContent = new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(data.totalPrice);
                        
                        // Mở modal
                        var detailModal = new bootstrap.Modal(document.getElementById("detailModal"));
                        detailModal.show();
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi tải thông tin chi tiết!');
                    });
            }
        </script>
    </body>
</html>

