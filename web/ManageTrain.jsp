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
    </div>
</body>
</html>