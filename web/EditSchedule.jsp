<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Sửa Lịch Trình</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

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
            color: #2c3e50;
            font-size: 22px;
            font-weight: 600;
            text-align: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .station-select {
            margin-bottom: 20px;
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
            background: #228be6;
            color: white;
            border: none;
        }

        .btn-submit:hover {
            background: #1c7ed6;
        }

        .btn-reset {
            background: #fff;
            color: #495057;
            border: 1px solid #ced4da;
            text-decoration: none;
            display: inline-block;
            text-align: center;
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
    </style>
</head>

<body>
    <div class="container">
        <div class="add-schedule-form">
            <h2 class="form-title">Sửa Lịch Trình</h2>
            
            <c:if test="${param.error != null}">
                <div class="alert alert-danger">
                    ${param.error}
                </div>
            </c:if>
            <c:if test="${param.message != null}">
                <div class="alert alert-success">
                    ${param.message}
                </div>
            </c:if>

            <form action="editschedule" method="POST">
                <input type="hidden" name="id" value="${schedule.id}">
                
                <div class="station-select">
                    <div class="input-container">
                        <label>Ga đi</label>
                        <input class="form-input" 
                               name="fromStation" 
                               list="stationsList" 
                               id="from_station"
                               required
                               value="${schedule.fromStation}"
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
                               value="${schedule.toStation}"
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
                            <option value="Tàu thường" ${schedule.trainType == 'Tàu thường' ? 'selected' : ''}>Tàu thường</option>
                            <option value="Tàu nhanh" ${schedule.trainType == 'Tàu nhanh' ? 'selected' : ''}>Tàu nhanh</option>
                            <option value="Tàu cao cấp" ${schedule.trainType == 'Tàu cao cấp' ? 'selected' : ''}>Tàu cao cấp</option>
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
                               value="${schedule.trid}"
                               placeholder="Nhập mã tàu (VD: SE1, HP1, SP3)">
                    </div>
                </div>

                <div class="time-row">
                    <div class="time-input">
                        <label>Thời gian đi</label>
                        <input class="react-select__input" 
                               type="datetime-local"
                               name="fromTime" 
                               required
                               value="${schedule.fromTime.toString().substring(0, 16)}"
                               id="from_time">
                    </div>

                    <div class="time-input">
                        <label>Thời gian đến</label>
                        <input class="react-select__input" 
                               type="datetime-local"
                               name="toTime" 
                               required
                               value="${schedule.toTime.toString().substring(0, 16)}"
                               id="to_time">
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">Cập nhật</button>
                    <a href="manageschedule" class="btn-reset">Hủy</a>
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
        
        if (fromStation === toStation) {
            alert('Ga đi và ga đến không được trùng nhau!');
            return;
        }
        
        if (new Date(toTime) <= new Date(fromTime)) {
            alert('Thời gian đến phải sau thời gian đi!');
            return;
        }
        
        this.submit();
    });

    document.getElementById('from_time').addEventListener('change', function() {
        document.getElementById('to_time').min = this.value;
    });
    </script>
</body>
</html>
