<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
            margin-bottom: 15px;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .passenger-info:hover {
            background-color: #e9ecef;
        }
        .passenger-info input {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }
        .passenger-info input:focus {
            border-color: #06A3DA;
            box-shadow: 0 0 0 0.2rem rgba(6, 163, 218, 0.25);
            outline: none;
        }
        .passenger-info input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }
        .passenger-info label {
            margin-bottom: 0;
            min-width: 180px;
            font-weight: 500;
            color: #495057;
        }
        .passenger-info i {
            width: 20px;
            color: #06A3DA;
        }
        .ticket-table .passenger-info {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 8px;
            padding: 4px;
            background-color: transparent;
        }
        .ticket-table .passenger-info:hover {
            background-color: transparent;
        }
        .ticket-table .passenger-info input {
            flex: 1;
            padding: 4px 8px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 0.85rem;
            height: 32px;
        }
        .ticket-table .passenger-info input:focus {
            border-color: #06A3DA;
            box-shadow: 0 0 0 0.1rem rgba(6, 163, 218, 0.15);
            outline: none;
        }
        .ticket-table .passenger-info label {
            margin-bottom: 0;
            min-width: 60px;
            font-weight: 500;
            color: #495057;
            font-size: 0.85rem;
        }
        .ticket-table td {
            vertical-align: middle;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.85rem;
            margin-top: 5px;
            display: none;
        }
        .passenger-info input.invalid {
            border-color: #dc3545;
        }
        .passenger-info input.valid {
            border-color: #28a745;
        }
    </style>
</head>
<body>
     <fmt:setLocale value="vi_VN"/>
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
                            <a href="home" class="nav-item nav-link ">Trang chủ</a>
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
                <form action="pay" method="get" id="paymentForm">
                <c:if test="${order}">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="info-section">
                                <h5 class="mb-4"><i class="fas fa-user me-2"></i>Thông Tin Đặt Vé</h5>
                                <div class="passenger-info">
                                    <label><i class="fas fa-user-circle"></i> Họ và Tên Người Đặt:</label>
                                    <input type="text" name="name" id="name" value="${account.uname}" oninput="validateName(this)">
                                    <div class="error-message" id="nameError"></div>
                                </div>
                                <div class="passenger-info">
                                    <label><i class="fas fa-id-card"></i> CCCD:</label>
                                    <input type="text" name="cccd" id="cccd" value="${account.cccd}" oninput="validateCCCD(this)">
                                    <div class="error-message" id="cccdError"></div>
                                </div>
                                <div class="passenger-info">
                                    <label><i class="far fa-envelope"></i> Email:</label>
                                    <input type="email" name="email" id="email" value="${account.umail}" oninput="validateEmail(this)">
                                    <div class="error-message" id="emailError"></div>
                                </div>
                                <div class="passenger-info">
                                    <label><i class="fas fa-phone"></i> SĐT:</label>
                                    <input type="tel" name="phone" id="phone" value="${account.uphone}" oninput="validatePhone(this)">
                                    <div class="error-message" id="phoneError"></div>
                                </div>
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
                                                    <input type="text" name="passengerName[]" class="passenger-name" oninput="validatePassengerName(this)">
                                                    <div class="error-message"></div>
                                                </div>
                                                <div class="passenger-info">
                                                    <label>CCCD:</label>
                                                    <input type="text" name="passengerCCCD[]" class="passenger-cccd" oninput="validatePassengerCCCD(this)">
                                                    <div class="error-message"></div>
                                                </div>
                                            </td>
                                            <td>
                                                <strong>Ghế: </strong>${seat["seatNumber"]} ${seat["seatType"]}<br>
                                                <strong>Tàu: </strong> ${seat["selectedTrainId"]}<br>
                                                <strong>Cabin: </strong>${seat["selectedCabinId"]}<br>
                                                <strong>Khởi hành:</strong>${seat["fromTime"]}
                                            </td>
                                            <td>
                                                <c:set var="total" value="${total + seat.price}" />
                                                <fmt:formatNumber value="${seat.price}" type="number" groupingUsed="true" />
                                            </td>
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
                        <h5 class="total-amount">Tổng Tiền: <fmt:formatNumber value="${total}"/> VNĐ</h5>
                    </div>
                    
                    <div class="action-buttons">
                        <input type="hidden" name="amount" value="${totalPrice.toString().replace(',', '')}">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-credit-card me-2"></i>Tiến Hành Thanh Toán
                        </button>
                        <a href="home" class="btn btn-outline-secondary">
                            <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                        </a>
                    </div>
                </c:if>
                
                <c:if test="${!order}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Không tìm thấy thông tin đơn hàng.
                    </div>
                    <a href="home" class="btn btn-outline-secondary">
                        <i class="fas fa-home me-2"></i>Quay Về Trang Chủ
                    </a>
                </c:if>
                </form>
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
                const priceText = row.querySelector('td:nth-child(3)').textContent;
                const price = parseInt(priceText.replace(/[^\d]/g, ''));
                console.log("Price:", price);
                
                // Cập nhật tổng tiền trước khi xóa
                const totalPriceElement = document.querySelector('.total-amount');
                const currentTotal = parseInt(totalPriceElement.textContent.replace(/[^\d]/g, ''));
                const newTotal = currentTotal - price;
                totalPriceElement.textContent = `Tổng Tiền: ` +newTotal.toLocaleString('vi-VN')+ ` VNĐ`;
                console.log("Total price:", newTotal);
                // Cập nhật giá trị amount trong form
                const amountInput = document.querySelector('input[name="amount"]');
                if (amountInput) {
                    amountInput.value = newTotal;
                }
                
                // Xóa hàng
                row.remove();
                
                // Kiểm tra lại trùng lặp sau khi xóa
                const allNames = document.querySelectorAll('.passenger-name');
                const allCCCDs = document.querySelectorAll('.passenger-cccd');
                
                allNames.forEach(name => validatePassengerName(name));
                allCCCDs.forEach(cccd => validatePassengerCCCD(cccd));
                
                // Kiểm tra nếu không còn vé nào
                const remainingRows = document.querySelectorAll('tbody tr');
                if (remainingRows.length === 0) {
                    document.querySelector('.action-buttons').style.display = 'none';
                }
            }
        }
    </script>
    
    <script>
    function validateName(input) {
        const name = input.value.trim();
        const errorDiv = document.getElementById('nameError');
        
        if (name.length < 2) {
            errorDiv.textContent = "Họ và Tên phải có ít nhất 2 ký tự!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        const regex = /^[\p{L}\s]+$/u;
        if (!regex.test(name)) {
            errorDiv.textContent = "Họ và Tên chỉ được chứa chữ cái và khoảng trắng!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        if (/\s{2,}/.test(name)) {
            errorDiv.textContent = "Họ và Tên không được chứa nhiều khoảng trắng liên tiếp!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        errorDiv.style.display = "none";
        input.classList.remove('invalid');
        input.classList.add('valid');
        return true;
    }

    function validateCCCD(input) {
        const cccd = input.value.trim();
        const errorDiv = document.getElementById('cccdError');
        
        const regex = /^\d{12}$/;
        if (!regex.test(cccd)) {
            errorDiv.textContent = "CCCD phải có 12 chữ số!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        errorDiv.style.display = "none";
        input.classList.remove('invalid');
        input.classList.add('valid');
        return true;
    }

    function validateEmail(input) {
        const email = input.value.trim();
        const errorDiv = document.getElementById('emailError');
        
        const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!regex.test(email)) {
            errorDiv.textContent = "Email không hợp lệ!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        errorDiv.style.display = "none";
        input.classList.remove('invalid');
        input.classList.add('valid');
        return true;
    }

    function validatePhone(input) {
        const phone = input.value.trim();
        const errorDiv = document.getElementById('phoneError');
        
        const regex = /^(0)\d{9}$/;
        if (!regex.test(phone)) {
            errorDiv.textContent = "Số điện thoại phải có 10 chữ số và bắt đầu bằng 0!";
            errorDiv.style.display = "block";
            input.classList.add('invalid');
            input.classList.remove('valid');
            return false;
        }
        
        errorDiv.style.display = "none";
        input.classList.remove('invalid');
        input.classList.add('valid');
        return true;
    }

    // Thêm validation khi form submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const nameValid = validateName(document.getElementById('name'));
        const cccdValid = validateCCCD(document.getElementById('cccd'));
        const emailValid = validateEmail(document.getElementById('email'));
        const phoneValid = validatePhone(document.getElementById('phone'));
        
        if (!nameValid || !cccdValid || !emailValid || !phoneValid) {
            e.preventDefault();
            alert('Vui lòng kiểm tra và sửa các thông tin không hợp lệ!');
        }
    });
    </script>

    <script>
        // Thêm các hàm validation cho thông tin hành khách
        function validatePassengerName(input) {
            const name = input.value.trim();
            const errorDiv = input.nextElementSibling;
            
            if (name.length < 2) {
                errorDiv.textContent = "Họ và Tên phải có ít nhất 2 ký tự!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }
            
            const regex = /^[\p{L}\s]+$/u;
            if (!regex.test(name)) {
                errorDiv.textContent = "Họ và Tên chỉ được chứa chữ cái và khoảng trắng!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }
            
            if (/\s{2,}/.test(name)) {
                errorDiv.textContent = "Họ và Tên không được chứa nhiều khoảng trắng liên tiếp!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }

            // Kiểm tra trùng lặp họ tên
            const allNames = document.querySelectorAll('.passenger-name');
            let isDuplicate = false;
            allNames.forEach(otherInput => {
                if (otherInput !== input && otherInput.value.trim().toLowerCase() === name.toLowerCase()) {
                    isDuplicate = true;
                }
            });
            
            if (isDuplicate) {
                errorDiv.textContent = "Họ và Tên này đã được sử dụng cho vé khác!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }
            
            errorDiv.style.display = "none";
            input.classList.remove('invalid');
            input.classList.add('valid');
            return true;
        }

        function validatePassengerCCCD(input) {
            const cccd = input.value.trim();
            const errorDiv = input.nextElementSibling;
            
            const regex = /^\d{12}$/;
            if (!regex.test(cccd)) {
                errorDiv.textContent = "CCCD phải có 12 chữ số!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }

            // Kiểm tra trùng lặp CCCD
            const allCCCDs = document.querySelectorAll('.passenger-cccd');
            let isDuplicate = false;
            allCCCDs.forEach(otherInput => {
                if (otherInput !== input && otherInput.value.trim() === cccd) {
                    isDuplicate = true;
                }
            });
            
            if (isDuplicate) {
                errorDiv.textContent = "CCCD này đã được sử dụng cho vé khác!";
                errorDiv.style.display = "block";
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }
            
            errorDiv.style.display = "none";
            input.classList.remove('invalid');
            input.classList.add('valid');
            return true;
        }

        // Cập nhật validation khi submit form
        document.querySelector('form').addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate thông tin người đặt
            isValid = validateName(document.getElementById('name')) && isValid;
            isValid = validateCCCD(document.getElementById('cccd')) && isValid;
            isValid = validateEmail(document.getElementById('email')) && isValid;
            isValid = validatePhone(document.getElementById('phone')) && isValid;
            
            // Validate thông tin hành khách
            const passengerNames = document.querySelectorAll('.passenger-name');
            const passengerCCCDs = document.querySelectorAll('.passenger-cccd');
            
            // Kiểm tra trùng lặp giữa người đặt và hành khách
            const bookerName = document.getElementById('name').value.trim().toLowerCase();
            const bookerCCCD = document.getElementById('cccd').value.trim();
            
            passengerNames.forEach((name, index) => {
                const passengerName = name.value.trim().toLowerCase();
                const passengerCCCD = passengerCCCDs[index].value.trim();
                
                if (passengerName === bookerName) {
                    // Nếu họ tên trùng, kiểm tra CCCD
                    if (passengerCCCD !== bookerCCCD) {
                        const errorDiv = name.nextElementSibling;
                        errorDiv.textContent = "Nếu là người đặt vé, CCCD phải trùng khớp!";
                        errorDiv.style.display = "block";
                        name.classList.add('invalid');
                        name.classList.remove('valid');
                        isValid = false;
                    }
                }
                isValid = validatePassengerName(name) && isValid;
            });
            
            passengerCCCDs.forEach(cccd => {
                isValid = validatePassengerCCCD(cccd) && isValid;
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Vui lòng kiểm tra và sửa các thông tin không hợp lệ!');
            }
        });
        </script>


</body>
</html>