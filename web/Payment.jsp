<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh Toán - Đặt Vé Tàu</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .payment-container {
                max-width: 800px;
                margin: 30px auto;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .order-summary {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 4px;
                margin-bottom: 20px;
            }
            .qr-container {
                text-align: center;
                margin: 20px 0;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
            }
            .payment-info {
                margin-top: 20px;
                padding: 15px;
                background-color: #fff3cd;
                border: 1px solid #ffeeba;
                border-radius: 4px;
            }
            .countdown {
                font-size: 1.2em;
                color: #dc3545;
                font-weight: bold;
                margin: 10px 0;
            }
            .bank-info {
                background-color: #e9ecef;
                padding: 15px;
                border-radius: 4px;
                margin: 15px 0;
            }
            .copy-button {
                padding: 5px 10px;
                margin-left: 10px;
                border: none;
                background-color: #6c757d;
                color: white;
                border-radius: 4px;
                cursor: pointer;
            }
            .copy-button:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>

        <div class="container payment-container">
            <h2 class="text-center mb-4">Thanh Toán Đặt Vé</h2>
            
            <!-- Thông tin đơn hàng -->
            <div class="order-summary">
                <h4>Chi Tiết Đơn Hàng</h4>
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Tàu:</strong> ${schedule.getTrid()}</p>
                        <p><strong>Từ ga:</strong> ${from_station}</p>
                        <p><strong>Đến ga:</strong> ${to_station}</p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Ngày đi:</strong> ${from_date}</p>
                        <p><strong>Toa:</strong> ${param.cabinId}</p>
                        <p><strong>Số ghế:</strong> ${param.seatNumber}</p>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <h5>Tổng tiền: ${totalAmount}đ</h5>
                    </div>
                </div>
            </div>

            <!-- QR Code và Thông tin thanh toán -->
            <div class="qr-container">
                <h4>Quét mã QR để thanh toán</h4>
                <p>Sử dụng ứng dụng ngân hàng hoặc ví điện tử để quét mã</p>
                
                <!-- QR Code Image -->
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${paymentInfo}" 
                     alt="QR Code" class="img-fluid mb-3">
                
                <div class="countdown">
                    Thời gian còn lại: <span id="timer">15:00</span>
                </div>
            </div>

            <!-- Thông tin chuyển khoản -->
            <div class="payment-info">
                <h5>Thông tin chuyển khoản</h5>
                <div class="bank-info">
                    <p><strong>Ngân hàng:</strong> VIETCOMBANK<button class="copy-button" onclick="copyText('VIETCOMBANK')">Sao chép</button></p>
                    <p><strong>Số tài khoản:</strong> 1234567890<button class="copy-button" onclick="copyText('1234567890')">Sao chép</button></p>
                    <p><strong>Chủ tài khoản:</strong> CÔNG TY ĐƯỜNG SẮT VIỆT NAM</p>
                    <p><strong>Nội dung chuyển khoản:</strong> <span id="transferContent">VEDT${bookingId}</span>
                        <button class="copy-button" onclick="copyText('transferContent')">Sao chép</button></p>
                </div>
                <p class="text-danger">* Vui lòng chuyển khoản đúng số tiền và nội dung để được xác nhận tự động</p>
            </div>

            <div class="text-center mt-4">
                <a href="booking-history" class="btn btn-secondary">Xem lịch sử đặt vé</a>
            </div>
        </div>

        <jsp:include page="Footer.jsp"></jsp:include>

        <!-- JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Countdown Timer
            function startTimer(duration, display) {
                var timer = duration, minutes, seconds;
                var countdown = setInterval(function () {
                    minutes = parseInt(timer / 60, 10);
                    seconds = parseInt(timer % 60, 10);

                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.textContent = minutes + ":" + seconds;

                    if (--timer < 0) {
                        clearInterval(countdown);
                        display.textContent = "Hết thời gian";
                        // Redirect or show message
                        alert("Đã hết thời gian thanh toán. Vui lòng đặt vé lại.");
                        window.location.href = "index.jsp";
                    }
                }, 1000);
            }

            // Copy text function
            function copyText(elementId) {
                var text = document.getElementById(elementId).innerText;
                navigator.clipboard.writeText(text).then(function() {
                    alert('Đã sao chép: ' + text);
                }).catch(function(err) {
                    console.error('Không thể sao chép text: ', err);
                });
            }

            // Start countdown when page loads
            window.onload = function () {
                var fifteenMinutes = 60 * 15,
                    display = document.querySelector('#timer');
                startTimer(fifteenMinutes, display);
            };
        </script>
    </body>
</html>
