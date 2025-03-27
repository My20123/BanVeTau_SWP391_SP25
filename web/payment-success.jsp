<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công - VietTrains</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #005F7A;
            --success-color: #28a745;
        }

        body {
            background-color: #f8f9fa;
        }

        .success-page {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }

        .success-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .success-icon {
            width: 90px;
            height: 90px;
            background-color: var(--success-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            animation: scale-up 0.5s ease;
        }

        .success-icon i {
            font-size: 45px;
            color: white;
        }

        @keyframes scale-up {
            0% {
                transform: scale(0);
            }
            70% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        .success-title {
            color: var(--success-color);
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .success-message {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .ticket-container {
            background: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            position: relative;
            margin-bottom: 2rem;
        }

        .ticket-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
        }

        .ticket-info {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .info-item {
            text-align: center;
        }

        .info-label {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #212529;
        }

        .journey-details {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .station-info {
            flex: 1;
        }

        .station-name {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .station-time {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .action-buttons {
            text-align: center;
        }

        .btn-action {
            padding: 0.75rem 2rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: translateY(-2px);
        }

        .payment-info {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .payment-info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .payment-info-label {
            color: #6c757d;
        }

        .payment-info-value {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="success-page">
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1 class="success-title">Thanh toán thành công!</h1>
            <p class="success-message">Cảm ơn bạn đã đặt vé. Thông tin chi tiết vé của bạn được hiển thị bên dưới.</p>
        </div>

        <div class="ticket-container">
            <div class="ticket-header">
                <div>
                    <h5 class="mb-0 text-primary">Thông tin vé tàu</h5>
                    <small class="text-muted">Mã đặt vé: #${param.vnp_TxnRef}</small>
                </div>
            </div>

            <div class="payment-info">
                <div class="payment-info-item">
                    <span class="payment-info-label">Số tiền:</span>
                    <span class="payment-info-value"><fmt:formatNumber value="${param.vnp_Amount/100}" pattern="#,##0"/> VNĐ</span>
                </div>
                <div class="payment-info-item">
                    <span class="payment-info-label">Ngân hàng:</span>
                    <span class="payment-info-value">${param.vnp_BankCode}</span>
                </div>
                <div class="payment-info-item">
                    <span class="payment-info-label">Mã giao dịch:</span>
                    <span class="payment-info-value">${param.vnp_TransactionNo}</span>
                </div>
                <div class="payment-info-item">
                    <span class="payment-info-label">Thời gian:</span>
                    <span class="payment-info-value">
                        <fmt:parseDate value="${param.vnp_PayDate}" pattern="yyyyMMddHHmmss" var="payDate"/>
                        <fmt:formatDate value="${payDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </span>
                </div>
                <div class="payment-info-item">
                    <span class="payment-info-label">Loại thẻ:</span>
                    <span class="payment-info-value">${param.vnp_CardType}</span>
                </div>
            </div>
                    <c:forEach var="seat" items="${selectedSeats}">
            <div class="ticket-info">
                <div class="info-item">
                    <div class="info-label">Ghế</div>
                    <div class="info-value">${seat.seatNumber}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Khoang</div>
                    <div class="info-value">${seat.selectedCabinId}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Ngày</div>
                    <div class="info-value">${departureDate}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Hạng</div>
                    <div class="info-value">${seat.seatType}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Loại tàu</div>
                    <div class="info-value">TÀU THƯỜNG</div>
                </div>
            </div>

            <div class="text-primary fw-semibold fs-5 mb-3">Tàu ${seat.seatType}</div>

            <div class="journey-details">
                <div class="station-info">
                    <div class="station-name">${fromStation}</div>
                    <div class="station-time">
                        <div>Khởi hành: ${departureTime}</div>
                        <div>Ga đi: ${fromStation}</div>
                    </div>
                </div>
                <div class="station-info text-end">
                    <div class="station-name">${toStation}</div>
                    <div class="station-time">
                        <div>Đến nơi: ${arrivalTime}</div>
                    </div>
                </div>
            </div>
</c:forEach>
            <div class="border-top pt-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="text-muted">Tổng tiền</div>
                    <div class="h4 mb-0"><fmt:formatNumber value="${param.vnp_Amount/100}" pattern="#,##0"/> VNĐ</div>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <a href="order-history" class="btn btn-primary btn-action">
                <i class="fas fa-history me-2"></i>Xem lịch sử đặt vé
            </a>
            <a href="home" class="btn btn-outline-primary btn-action">
                <i class="fas fa-home me-2"></i>Về trang chủ
            </a>
        </div>
    </div>
</body>
</html> 