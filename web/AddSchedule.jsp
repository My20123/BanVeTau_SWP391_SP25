<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Add Schedule</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .add-schedule-form {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }

        .form-title {
            color: #86B817;
            font-size: 24px;
            font-weight: 600;
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #86B817;
        }

        .station-select {
            margin-bottom: 20px;
        }

        .input-container label {
            display: block;
            margin-bottom: 8px;
            color: #353e4a;
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
            border-color: #86B817;
            box-shadow: 0 0 0 3px rgba(134, 184, 23, 0.1);
        }

        .time-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .time-input {
            flex: 1;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 25px;
        }

        .btn-submit, .btn-reset {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-submit {
            background: #86B817;
            color: white;
            border: none;
        }

        .btn-submit:hover {
            background: #7aa514;
        }

        .btn-reset {
            background: #fff;
            color: #353e4a;
            border: 1px solid #ced4da;
        }

        .btn-reset:hover {
            background: #f8f9fa;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }

        select.form-input {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%23495057' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            padding-right: 35px;
        }

        @media (max-width: 768px) {
            .time-row {
                flex-direction: column;
                gap: 20px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn-submit, .btn-reset {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="add-schedule-form">
            <h2 class="form-title">Thêm Lịch Trình Mới</h2>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            
            <form action="addschedule" method="POST">
                <div class="station-select">
                    <div class="input-container">
                        <label>Ga đi</label>
                        <input class="form-input" 
                               name="fromStation" 
                               list="stationsList" 
                               id="from_station"
                               required
                               autocomplete="off"
                               placeholder="Chọn ga đi">
                    </div>
                </div>

                <div class="station-select">
                    <div class="input-container">
                        <label>Ga đến</label>
                        <input class="form-input" 
                               name="toStation" 
                               list="stationsList" 
                               id="to_station"
                               required
                               autocomplete="off"
                               placeholder="Chọn ga đến">
                    </div>
                </div>

                <div class="station-select">
                    <div class="input-container">
                        <label>Loại tàu</label>
                        <select class="form-input" 
                                name="trainType" 
                                id="train_type"
                                required>
                            <option value="">Chọn loại tàu</option>
                            <option value="Tàu thường">Tàu thường</option>
                            <option value="Tàu nhanh">Tàu nhanh</option>
                            <option value="Tàu cao cấp">Tàu cao cấp</option>
                        </select>
                    </div>
                </div>

                <div class="station-select">
                    <div class="input-container">
                        <label>Mã tàu</label>
                        <input class="form-input" 
                               type="text"
                               name="trid" 
                               id="train_id"
                               required
                               placeholder="Nhập mã tàu (VD: SE1, HP1, SP3)">
                    </div>
                </div>

                <div class="time-row">
                    <div class="time-input">
                        <label>Thời gian đi</label>
                        <input class="form-input" 
                               type="datetime-local"
                               name="fromTime" 
                               required
                               id="from_time">
                    </div>

                    <div class="time-input">
                        <label>Thời gian đến</label>
                        <input class="form-input" 
                               type="datetime-local"
                               name="toTime" 
                               required
                               id="to_time">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">Thêm lịch trình</button>
                    
                </div>
            </form>

            <datalist id="stationsList">
                <c:forEach items="${listS}" var="o">
                    <option value="${o}">
                </c:forEach>
            </datalist>
        </div>
    </div>

    <script>
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const fromStation = document.getElementById('from_station').value;
        const toStation = document.getElementById('to_station').value;
        const fromTime = document.getElementById('from_time').value;
        const toTime = document.getElementById('to_time').value;
        
        // Kiểm tra ga đi và ga đến không được trùng nhau
        if (fromStation === toStation) {
            alert('Ga đi và ga đến không được trùng nhau!');
            return;
        }
        
        // Kiểm tra thời gian đến phải sau thời gian đi
        if (new Date(toTime) <= new Date(fromTime)) {
            alert('Thời gian đến phải sau thời gian đi!');
            return;
        }
        
        // Nếu tất cả hợp lệ, submit form
        this.submit();
    });

    // Set min datetime cho input thời gian
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');

    const minDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;
    document.getElementById('from_time').min = minDateTime;
    document.getElementById('to_time').min = minDateTime;

    // Cập nhật min time của thời gian đến khi thời gian đi thay đổi
    document.getElementById('from_time').addEventListener('change', function() {
        document.getElementById('to_time').min = this.value;
    });
    </script>
</body>
</html>