<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train list</title>
    <link rel="stylesheet" href="css/train.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="js/filter.js"></script>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="search-bar">
                <input type="text" id="search" placeholder="Search..." onkeyup="Train()">
                <select id="filterTrain" onchange="Train()">
                    <option value="all">All</option>
                    <option value="id">Train ID</option>
                    <option value="status">Train Status</option>
                    <option value="seats">Total Seats</option>
                    <option value="cabins">Total Cabins</option>
                </select>
            </div>
            <a href="AddTrain.jsp" class="add-order-btn">+ Add New Train</a>
        </div>
        <div class="table-container">
            <table id="trainTable">
                <thead>
                    <tr>
                        <th>Train ID</th>
                        <th>Train status</th>
                        <th>Total seats</th>
                        <th>Total cabins</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${tlist}" var="t">
                    <tr>
                        <td>${t.tid}</td>
                        <td>
                            <c:choose>
                                <c:when test="${t.status == 1}">Available</c:when>
                                <c:otherwise>Maintenance</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${t.number_seats}</td>
                        <td>${t.number_cabins}</td>
                        <td>
                            <a href="editT?id=${t.tid}"><i class="fas fa-edit"></i></a>
                            <a href="deleteT?id=${t.tid}" onclick="return confirm('Are you sure you want to delete this train?');"><i class="fas fa-trash-alt"></i></a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="pagination">
            <p>Showing 1 to 10 of 12 entries</p>
            <div>
                <button>&lt;</button>
                <button class="active">1</button>
                <button>2</button>
                <button>&gt;</button>
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
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="home" class="nav-item nav-link active" style="color: #ffa500;">Trang chủ</a>
                            <a href="manageschedule" class="nav-item nav-link" style="color: white;">Quản lí lịch trình</a>

                            <a href="viewT" class="nav-item nav-link" style="color: white;">Quản lí tàu</a> 
                            <a href="viewC" class="nav-item nav-link" style="color: white;">Quản lí cabin</a> 
                             <a href="ManageSeat" class="nav-item nav-link" style="color: white;">Quản lí ghế</a> 
                            <a href="" class="nav-item nav-link" style="color: white;">Quản lí vé tàu</a>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
            
            <div class="container">
                <div class="header">
                    <div class="search-bar">
                        <input type="text" id="search" placeholder="Search..." onkeyup="Train()">
                        <select id="filterTrain" onchange="Train()">
                            <option value="all">All</option>
                            <option value="id">Train ID</option>
                            <option value="status">Train Status</option>
                            <option value="seats">Total Seats</option>
                            <option value="cabins">Total Cabins</option>
                        </select>
                    </div>
                    <a href="AddTrain.jsp" class="add-order-btn">+ Add New Train</a>
                </div>
                <div class="table-container">
                    <table id="trainTable">
                        <thead>
                            <tr>
                                <th>Train ID</th>
                                <th>Train type</th>   
                                <th>Train status</th>
                                <th>Total seats</th>
                                <th>Total cabins</th>
                                <th>Seats available</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${tlist}" var="t">
                            <tr>
                                <td>${t.tid}</td>
                                <td>${t.train_type}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${t.status == 1}">Available</c:when>
                                        <c:otherwise>Maintenance</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${t.total_seats}</td>
                                <td>${t.number_cabins}</td>
                                <td>${t.available_seats}</td>
                                <td>
                                    <a href="editT?id=${t.tid}"><i class="fas fa-edit"></i></a>                                  
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <p>Showing 1 to 10 of 12 entries</p>
                <div>
                    <button>&lt;</button>
                    <button class="active">1</button>
                    <button>2</button>
                    <button>&gt;</button>
                </div>
            </div>
        </div>
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