<%-- 
    Document   : Dashboard
    Created on : Feb 16, 2025, 10:47:00 PM
    Author     : lenovo
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Admin Dashboard</title>
    <!-- ======= Styles ====== -->
    <link rel="stylesheet" href="css/dashboard.css">
</head>

<body>
    <!-- =============== Navigation ================ -->
    <div class="container">
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="train-outline"></ion-icon>
                        </span>
                        <span class="title">Dashboard</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="pie-chart-outline"></ion-icon>
                        </span>
                        <span class="title">Dashboard</span>
                    </a>
                </li>

                <li>

                    <a href="manageacc">

                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">Manage Account</span>
                    </a>
                </li>
                <li>

                    <a href="viewT">
                        <span class="icon">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                        </span>
                        <span class="title">Manage Train</span>

                    </a>
                </li>
                 <li>
                    <a href="Home.jsp">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Go to home page</span>
                    </a>
                </li>
            </ul>
        </div>
       
    </div>


    <!-- =========== Scripts =========  -->
    <script src="js/dashboard.js"></script>

    <!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>
