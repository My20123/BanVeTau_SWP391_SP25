<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Management</title>
        <link rel="stylesheet" href="css/manage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <script src="js/manageacc.js"></script>
        <script>
            function changeStatus(userId) {
                if (confirm("Are you sure you want to change the status of this user?")) {
                    const xhr = new XMLHttpRequest();
                    xhr.open("POST", "manageacc", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === 4 && xhr.status === 200) {
                            location.reload();
                        }
                    };
                    xhr.send("action=changeStatus&id=" + userId);
                }
            }
        </script>
    </head>
    <body>
        <div class="header-container">
            <div class="search-container">
                <!-- Ô tìm kiếm -->
                <input type="text" id="search_acc" placeholder="Search..." class="search-input" onkeyup="filterAcc()">
                <!-- Dropdown filter -->
                <select id="filterCriteria" onchange="filterAcc()">
                    <option value="all">All</option>
                    <option value="id">ID</option>
                    <option value="username">Username</option>
                    <option value="email">Email</option>
                    <option value="phone">Phone number</option>
                    <option value="cccd">CCCD</option>
                    <option value="role">Role</option>
                    <option value="status">Status</option>
                </select>
            </div>
            <a href="home" class="add-button">
                <i class="fas fa-home"></i> Home
            </a>
        </div>

        <table id="accountTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Avatar</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Phone number</th>
                    <th>CCCD</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${uAcc}" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td><img src="${u.avatar}" alt="Avatar"></td>
                        <td>${u.uname}</td>
                        <td>${u.umail}</td>
                        <td>${u.uphone}</td>
                        <td>${u.cccd}</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.isAdmin == 1}">Admin</c:when>
                                <c:when test="${u.isStaff == 1}">Staff</c:when>
                                <c:otherwise>User</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="${u.status ? 'Active' : 'Deadactive'}">
                            <c:choose>
                                <c:when test="${u.status}">Active</c:when>
                                <c:otherwise>Deadactive</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="editAcc?id=${u.id}" class="edit-btn">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a class="change-btn" onclick="changeStatus(${u.id})">
                                <i class="fas fa-gear"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="manageacc?page=${currentPage - 1}" class="prev">Previous</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="manageacc?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="manageacc?page=${currentPage + 1}" class="next">Next</a>
            </c:if>
        </div>

    </body>
</html>