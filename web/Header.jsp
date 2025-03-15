<%-- 
    Document   : Header
    Created on : Jan 19, 2025, 11:11:08 PM
    Author     : tra my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Topbar Start -->
<div class="container-fluid bg-light px-5 d-none d-lg-block">
    <div class="row gx-0">
        <div class="col-lg-8 text-center text-lg-start mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <a href="index_v1.html" class="btn text-dark me-3">Thông báo
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16" style="position: relative;bottom: 2px;">
                    <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>
                    </svg></a>
                <a href="index_v1.html" class="btn text-dark me-3">Hỗ trợ
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-question-circle" viewBox="0 0 16 16" style="position: relative;bottom: 2px;">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                    <path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286m1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94"/>
                    </svg></a>
                <!--                    <small class="btn me-3 text-dark">Thông báo<i class="fa-regular fa-bell me-2"></i></small>
                                    <small class="btn me-3 text-dark">Hỗ trợ<i class="fa-regular fa-circle-question me-2"></i></small>-->
            </div>
        </div>

        <div class="col-lg-4 text-center text-lg-end">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <c:if test="${sessionScope.acc.isAdmin == 1}">
                    <a href="Dashboard.jsp" class="btn btn-primary rounded-pill me-2">Dashboard</a>  
                    <a href="User.jsp" class="btn btn-primary rounded-pill me-2">Manage Account</a>  
                    <a class="btn btn-primary rounded-pill  me-2" href="Logout.jsp">Logout</a>
                    <div class="nav-item dropdown">
                        <a href="User.jsp" class="nav-link dropdown-toggle btn btn-user round-pill me-2" data-bs-toggle="dropdown" style="border: 1px solid #86B817;border-radius: 20px;color: #86B817;">${sessionScope.acc.uname}<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16" style="margin-bottom: 2px;">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                            </svg></a>
                        <div class="dropdown-menu m-0">
                            <a href="User.jsp"  class="dropdown-item">Profile</a>
                            <a href="#" class="dropdown-item">Order History</a>
                            <a href="#" class="dropdown-item">Cart</a>
                            <a href="logout" class="dropdown-item">Logout</a>
                            <a href="404.html" class="dropdown-item">404 Page</a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.acc.isStaff == 1}">
                    
                    <div class="nav-item dropdown">
                        <a href="User.jsp" class="nav-link dropdown-toggle btn btn-user round-pill me-2" data-bs-toggle="dropdown" style="border: 1px solid #86B817;border-radius: 20px;color: #86B817;">${sessionScope.acc.uname}<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16" style="margin-bottom: 2px;">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                            </svg></a>
                        <div class="dropdown-menu m-0">
                            <a href="User.jsp" class="dropdown-item">Profile</a>
                            <a href="#" class="dropdown-item">Order History</a>
                            <a href="#" class="dropdown-item">Cart</a>
                            <a href="logout" class="dropdown-item">Logout</a>
                            <a href="404.html" class="dropdown-item">404 Page</a>
                        </div>
                    </div>
                            
                </c:if>

                <c:if test="${sessionScope.acc != null }"> 
                    <a href="" class="btn btn-primary rounded-pill  me-2">Giỏ vé</a>
                    <div class="nav-item dropdown">
                        <a href="User.jsp" class="nav-link dropdown-toggle btn btn-user round-pill me-2" data-bs-toggle="dropdown" style="border: 1px solid #86B817;border-radius: 20px;color: #86B817;">${sessionScope.acc.uname}<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16" style="margin-bottom: 2px;">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                            </svg></a>
                        <div class="dropdown-menu m-0">
                            <a href="User.jsp" class="dropdown-item">Profile</a>
                            <a href="#" class="dropdown-item">Order History</a>
                            <a href="#" class="dropdown-item">Cart</a>
                            <a href="logout" class="dropdown-item">Logout</a>
                            <a href="404.html" class="dropdown-item">404 Page</a>
                        </div>
                    </div>


                </c:if>
                <c:if test="${sessionScope.acc==null}">
                    <a href="" class="btn btn-primary rounded-pill  me-2">Giỏ vé</a>
                    <a href="Login.jsp" class="btn btn-primary rounded-pill  me-2">Đăng nhập</a>
                     <a href="SignUp.jsp" class="btn btn-primary rounded-pill  me-2">Đăng ký</a>

                </c:if>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->