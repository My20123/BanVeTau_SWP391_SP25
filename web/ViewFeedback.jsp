<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xem Đánh Giá - VietTrains</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .feedback-list {
            margin-top: 20px;
        }

        .feedback-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            padding: 25px;
            margin-bottom: 25px;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }

        .feedback-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: #495057;
            border: 2px solid #e9ecef;
        }

        .user-name {
            font-weight: 600;
            color: #2c3e50;
            font-size: 1.1em;
        }

        .feedback-date {
            color: #6c757d;
            font-size: 0.9em;
        }

        .rating-stars {
            color: #ffc107;
            margin: 15px 0;
            font-size: 1.2em;
        }

        .feedback-content {
            color: #495057;
            line-height: 1.7;
            font-size: 1.05em;
            margin: 15px 0;
        }

        .no-feedback {
            text-align: center;
            padding: 50px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid #e9ecef;
        }

        .no-feedback i {
            font-size: 52px;
            color: #adb5bd;
            margin-bottom: 20px;
        }

        .no-feedback p {
            color: #6c757d;
            margin-bottom: 25px;
            font-size: 1.1em;
        }

        .page-title {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 35px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        .page-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: #86B817;
            border-radius: 2px;
        }

        .feedback-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #86B817;
            border-color: #86B817;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #739a14;
            border-color: #6b8f13;
            transform: translateY(-1px);
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #bb2d3b;
            border-color: #b02a37;
            transform: translateY(-1px);
        }

        .alert-success {
            background-color: #d1e7dd;
            border-color: #badbcc;
            color: #0f5132;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <jsp:include page="Header.jsp"></jsp:include>
    
    <div class="container">
        <h1 class="page-title">Đánh Giá Từ Khách Hàng</h1>

        <c:if test="${param.message != null}">
            <div class="alert alert-success">
                ${param.message}
            </div>
        </c:if>

        <div class="feedback-list">
            <c:forEach items="${feedbacks}" var="feedback">
                <div class="feedback-card">
                    <div class="feedback-header">
                        <div class="user-info">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div>
                                <div class="user-name">${feedback.accountName}</div>
                                <div class="feedback-date">
                                    <fmt:formatDate value="${feedback.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="rating-stars">
                        <c:forEach begin="1" end="5" var="i">
                            <i class="fas fa-star ${i <= feedback.rate ? 'text-warning' : 'text-muted'}"></i>
                        </c:forEach>
                    </div>
                    
                    <div class="feedback-content">
                        ${feedback.comment}
                    </div>
                    
                    <c:if test="${sessionScope.acc != null && sessionScope.acc.id == feedback.accountId}">
                        <div class="feedback-actions mt-3">
                            <a href="Feedback.jsp?edit=true&feedbackId=${feedback.feedbackId}&rate=${feedback.rate}&comment=${fn:replace(feedback.comment, ' ', '%20')}" 
                               class="btn btn-primary btn-sm">
                                <i class="fas fa-edit"></i> Sửa
                            </a>
                            <a href="deletefeedback?feedbackId=${feedback.feedbackId}" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa đánh giá này?')">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:forEach>

            <c:if test="${empty feedbacks}">
                <div class="no-feedback">
                    <i class="fas fa-comments"></i>
                    <p>Chưa có đánh giá nào.</p>
                    <c:if test="${sessionScope.acc != null}">
                        <a href="Feedback.jsp" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Thêm đánh giá
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="Footer.jsp"></jsp:include>
</body>
</html> 