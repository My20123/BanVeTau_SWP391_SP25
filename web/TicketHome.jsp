<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Tickets"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Vé Tàu</title>

        <!-- ✅ Bootstrap CSS (Kiểm tra link CDN) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
        <!-- ✅ Font Awesome (Dùng icon đẹp hơn) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 <jsp:include page="Header.jsp"></jsp:include>
 
        <style>
            body {
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 30px;
            }
            .search-box {
                max-width: 500px;
                margin: auto;
            }
        </style>
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
     <div class="container-fluid bg-primary py-2 mb-2 ">
        <div class="container py-5">
            <div class="row justify-content-center py-5">
                <div class="col-lg-6 pt-lg-5 mt-lg-5 text-center">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Ticket</h1>
                </div>
            </div>
        </div>
    </div>
    <body>

        <div class="container">
            <div class="card shadow p-4">
                <h2 class="text-center text-primary mb-4"><i class="fas fa-train"></i> Danh Sách Vé Tàu</h2>

                <!-- ✅ Form Tìm Kiếm Vé Theo ID -->
                <form action="${pageContext.request.contextPath}/ticketController" method="GET" class="mb-3 d-flex justify-content-center">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group w-50">
                        <input type="number" name="ticketId" class="form-control" placeholder="Nhập ID vé..." required>
                        <button class="btn btn-primary"><i class="fas fa-search"></i> Tìm kiếm</button>
                    </div>
                    <!-- ✅ Nút Reset -->
                    <a href="${pageContext.request.contextPath}/ticketController" class="btn btn-secondary ms-2"><i class="fas fa-sync"></i> Reset</a>
                </form>

                <!-- ✅ Bảng Hiển Thị Danh Sách Vé -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Ga đi</th>
                                <th>Ga đến</th>
                                <th>Ngày đi</th>
                                <th>Ngày đến</th>
                                <th>Loại vé</th>
                                <th>ID Tàu</th>
                                <th>ID Ghế</th>
                                <th>ID Tuyến</th>
                                <th>ID Cabin</th>
                                <th>Chi Tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Tickets> listT = (List<Tickets>) request.getAttribute("listT");
                                if (listT != null && !listT.isEmpty()) {
                                    for (Tickets t : listT) {
                            %>
                            <tr>
                                <td><strong><%= t.getId() %></strong></td>
                                <td><%= t.getFrom_station() %></td>
                                <td><%= t.getTo_station() %></td>
                                <td><%= t.getFrom_time() %></td>
                                <td><%= t.getTo_time() %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/ticketController" method="GET" class="d-inline">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="ticketId" value="<%= t.getId() %>">
                                        <button type="submit" class="btn <%= (t.getTtype() == 1) ? "btn-success" : "btn-warning" %> btn-sm">
                                            <i class="fas fa-exchange-alt"></i> 
                                            <%= (t.getTtype() == 1) ? "Một chiều" : "Khứ hồi" %>
                                        </button>
                                    </form>
                                </td>
                                <td><%= t.getTrid() %></td>
                                <td><%= t.getSid() %></td>
                                <td><%= t.getRid() %></td>
                                <td><%= t.getCbid() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/ticketController?action=viewDetail&ticketId=<%= t.getId() %>" class="btn btn-info btn-sm">
                                        <i class="fas fa-eye"></i> Xem
                                    </a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="11" class="text-center text-danger fw-bold">Không tìm thấy vé nào!</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <!-- ✅ Phân trang -->
                <nav class="mt-3">
                    <ul class="pagination justify-content-center">
                        <%
                            Integer endPage = (Integer) request.getAttribute("endPage");
                            Integer currentPage = (Integer) request.getAttribute("currentPage");
                            if (endPage != null && currentPage != null) {
                                for (int i = 1; i <= endPage; i++) {
                        %>
                        <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                            <a class="page-link" href="${pageContext.request.contextPath}/ticketController?index=<%= i %>"><%= i %></a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </nav>

            </div>
        </div>

        <!-- ✅ Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
