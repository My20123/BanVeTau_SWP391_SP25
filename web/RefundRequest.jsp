<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Refund Requests</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4a90e2;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f1c40f;
            --light-bg: #f8f9fa;
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
            padding: 1rem;
            border: none;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
        }

        .search-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .search-input {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 10px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
        }

        .btn-search {
            background-color: var(--primary-color);
            color: white;
            border-radius: 10px;
            padding: 10px 25px;
            border: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background-color: #357abd;
            transform: translateY(-2px);
        }

        .table th:nth-child(6) {
            min-width: 150px;
        }

        .table td:nth-child(6) {
            min-width: 150px;
        }

        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            min-width: 120px;
            display: inline-block;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .bg-warning {
            background-color: #ffc107 !important;
            color: #fff !important;
        }

        .bg-success {
            background-color: #28a745 !important;
            color: #fff !important;
        }

        .bg-danger {
            background-color: #dc3545 !important;
            color: #fff !important;
        }

        .amount-badge {
            background-color: var(--primary-color);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
        }

        .btn-action {
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 3px;
            min-width: 100px;
        }

        .btn-status {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 3px;
            min-width: 80px;
            text-align: center;
        }

        .btn-action i {
            margin-right: 5px;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
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

        .action-group {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .table-hover tbody tr {
            transition: all 0.3s ease;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(74, 144, 226, 0.05);
        }

        .empty-state {
            padding: 3rem 0;
            text-align: center;
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
    </style>
</head>
<body class="bg-light">
    <div class="page-header">
        <div class="container">
            <h2 class="mb-0"><i class="fas fa-money-bill-transfer me-2"></i>Yêu Cầu Hoàn Tiền</h2>
            <p class="mb-0 mt-2 text-light">Quản lý yêu cầu hoàn tiền của khách hàng</p>
        </div>
    </div>

    <div class="container">
        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                ${error}
            </div>
        </c:if>

        <!-- Search Container -->
        <div class="search-container">
            <form action="RefundServlet" method="GET" class="row g-3 align-items-center">
                <input type="hidden" name="action" value="search">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text bg-transparent border-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" name="searchId" class="search-input" 
                               placeholder="Search by Refund ID or Order ID">
                    </div>
                </div>
                <div class="col-md-3">
                    <select name="status" class="form-select search-input">
                        <option value="">Trạng thái</option>
                        <option value="PENDING">Chờ xử lý</option>
                        <option value="APPROVED">Đã duyệt</option>
                        <option value="REJECTED">Từ chối</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="date" name="date" class="form-control search-input" 
                           placeholder="Select Date">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-search w-100">
                        <i class="fas fa-search me-2"></i>Lọc
                    </button>
                </div>
            </form>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>Mã Hoàn Tiền</th>
                                <th><i class="fas fa-shopping-cart me-2"></i>Mã Đơn Hàng</th>
                                <th><i class="fas fa-user me-2"></i>Tên Người Đặt</th>
                                <th><i class="fas fa-calendar me-2"></i>Ngày Yêu Cầu</th>
                                <th><i class="fas fa-coins me-2"></i>Số Tiền</th>
                                <th><i class="fas fa-info-circle me-2"></i>Trạng Thái</th>
                                <th><i class="fas fa-tasks me-2"></i>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <c:forEach items="${refundRequests}" var="refund">
                                <tr>
                                    <td>${refund.refundId}</td>
                                    <td>${refund.orderId}</td>
                                    <td>${refund.customerName}</td>
                                    <td>${refund.requestDate}</td>
                                    <td><fmt:formatNumber value="${refund.amount}" pattern="#,##0" /> VNĐ</td>
                                    <td>
                                        <span class="status-badge bg-${refund.status == 'PENDING' ? 'warning' : 
                                            refund.status == 'APPROVED' ? 'success' : 'danger'} text-white">
                                            ${refund.status == 'PENDING' ? 'Chờ xử lý' : 
                                             refund.status == 'APPROVED' ? 'Đã duyệt' : 'Từ chối'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-group">
                                            <c:if test="${refund.status == 'PENDING'}">
                                                
                                               
                                                    <input type="hidden" name="refundid" value="${refund.refundId}">
                                                    <button type="button" class="btn btn-success btn-status" data-bs-toggle="modal" data-bs-target="#changeStatusModal${refund.refundId}">
                                                        Đổi trạng thái
                                                    </button>

                                                    
                                            </c:if>
                                            <c:if test="${refund.status == 'REJECTED'}">
                                                <button onclick="viewRefundDetails('${refund.refundId}')" 
                                                    class="btn btn-info btn-action" 
                                                    title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>Chi tiết
                                                </button>
                                            </c:if>
                                            <c:if test="${refund.status == 'APPROVED'}">
                                                <button onclick="viewRefundDetails('${refund.refundId}')" 
                                                    class="btn btn-info btn-action" 
                                                    title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>Chi tiết
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        

        
        
        function rejectRefund(refundId) {
            Swal.fire({
                title: 'Confirm Rejection',
                text: 'Are you sure you want to reject this refund request?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#e74c3c',
                cancelButtonColor: '#95a5a6',
                confirmButtonText: 'Yes, reject it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'RefundServlet?action=reject&refundId=' + refundId;
                }
            });
        }
    </script>
</body>
</html>
