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
            .page-title-section {
                margin-top: 70px; /* Add spacing after navbar */
                padding-top: 20px; /* Add internal spacing */
            }
        </style>

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
    </head>

    <body>
         <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->
        <jsp:include page="Header.jsp"></jsp:include>
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0" style="background-color: #353e4a;">
                    <a href="" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="navbar-nav ms-auto py-0">
                        <a href="manageschedule" class="nav-item nav-link " style="color: #ffa500;">Quản lí lịch trình</a>
                        <a href="viewT" class="nav-item nav-link " style="color: white;">Quản lí tàu</a> 
                        <a href="viewC" class="nav-item nav-link " style="color: white;">Quản lí cabin</a> 
                        <a href="ManageSeat" class="nav-item nav-link" style="color: white;">Quản lí ghế</a> 
                        <a href="ticketController" class="nav-item nav-link active" style="color: white;">Quản lí vé tàu</a>
                        <a href="viewRefund" class="nav-item nav-link" style="color: white;">Quản lí hoàn tiền</a>
                    </div>
                </nav>
            </div>
            
            <!-- Add spacer div for proper spacing -->
            <div class="clearfix" style="height: 60px;"></div>
            
            <!-- Page title with better spacing -->
            <div class="container page-title-section">
                <h2 class="text-center text-primary mb-4"><i class="fas fa-train"></i> Danh Sách Vé Tàu</h2>
            </div>

            <div class="container">
                <div class="card shadow p-4">
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
        <jsp:include page="Footer.jsp"></jsp:include>
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
    </body>
</html>