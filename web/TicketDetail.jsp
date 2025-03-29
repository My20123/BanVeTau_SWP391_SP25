<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Tickets"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Vé</title>

    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <!-- ✅ Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            max-width: 600px;
            margin: auto;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card shadow-lg p-4">
        <h2 class="text-center text-primary mb-4"><i class="fas fa-ticket-alt"></i> Chi Tiết Vé</h2>

        <%
            Tickets ticket = (Tickets) request.getAttribute("ticketDetail");
            if (ticket != null) {
        %>
        <!-- ✅ Bảng Thông Tin Chi Tiết -->
        <table class="table table-bordered table-striped">
            <tr>
                <th class="bg-primary text-white">ID</th>
                <td><strong><%= ticket.getId() %></strong></td>
            </tr>
            <tr>
                <th class="bg-light">Ga đi</th>
                <td><%= ticket.getFrom_station() %></td>
            </tr>
            <tr>
                <th class="bg-light">Ga đến</th>
                <td><%= ticket.getTo_station() %></td>
            </tr>
            <tr>
                <th class="bg-light">Ngày đi</th>
                <td><%= ticket.getFrom_time() %></td>
            </tr>
            <tr>
                <th class="bg-light">Ngày đến</th>
                <td><%= ticket.getTo_time() %></td>
            </tr>
        </table>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/ticketController?action=list" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>

        <%
            } else {
        %>
        <!-- ✅ Nếu không tìm thấy vé -->
        <div class="alert alert-danger text-center">
            <i class="fas fa-exclamation-triangle"></i> Không tìm thấy thông tin vé!
        </div>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/ticketController?action=list" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay Lại
            </a>
        </div>

        <%
            }
        %>

    </div>
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>
