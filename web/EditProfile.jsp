<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>User Profile</title>
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
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
            <div class="container">
                <h1>User Profile</h1>
                <hr>
                <div class="row">
                    <!-- left column -->
                    <div class="col-md-3">
                        <div class="text-center">
                            <img src="img/DefaultAvt.png" id="preview" class="avatar img-circle" alt="avatar">
                            <h6>Upload a different photo...</h6>
                            <input type="file" id="display" class="form-control" accept="image/*">
                        </div>
                    </div>
                    <!-- edit form column -->
                    <div class="col-md-9 personal-info">
                        <div class="alert alert-info alert-dismissable">
                            <a class="panel-close close" data-dismiss="alert"></a>
                            <i class="fa fa-coffee"></i> Update your profile information </div>
                        <h3>Personal info</h3>
                        <form class="form-horizontal" action="editprofile" method="post">
                            <div class="form-group">
                                <label class="col-lg-3 control-label">ID:</label>
                                <div class="col-lg-8">
                                    <input class="form-control" type="text" name="id" value="${requestScope.users.id}" readonly="">
                            </div>
                        </div>                      
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Phone number:</label>
                            <div class="col-lg-8">
                                <input class="form-control" type="text" name="uphone" value="${requestScope.users.uphone}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">Email:</label>
                            <div class="col-lg-8">
                                <input class="form-control" type="text" name="umail" value="${requestScope.users.umail}">
                            </div>
                        </div>                            
                        <div class="form-group">
                            <label class="col-md-3 control-label">Username:</label>
                            <div class="col-md-8">
                                <input class="form-control" type="text" name="uname" value="${requestScope.users.uname}" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">Role:</label>
                            <div class="col-md-8">
                                <input class="form-control" type="text" value="${requestScope.users.isStaff == 1 ? "Staff" : (requestScope.users.isAdmin == 1 ? "Admin" : "User")}" readonly="">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label">CCCD:</label>
                            <div class="col-md-8">
                                <input class="form-control" type="text" name="cccd" value="${requestScope.users.cccd}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 control-label"></label>
                            <div class="col-md-8">
                                <input type="submit" class="btn btn-primary" value="Save changes">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <hr>
        <a class="btn btn-primary" href='Home.jsp'>Home</a>
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
        <script src="js/avt.js"></script>
    </body>
</html>