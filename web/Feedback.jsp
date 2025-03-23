<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đánh Giá - VietTrains</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
        }
        .rating input {
            display: none;
        }
        .rating label {
            cursor: pointer;
            font-size: 30px;
            color: #ddd;
            padding: 5px;
        }
        .rating label:before {
            content: '★';
        }
        .rating input:checked ~ label,
        .rating label:hover,
        .rating label:hover ~ label {
            color: #ffc107;
        }
        .feedback-form {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(134, 184, 23, 0.1);
            border: 1px solid #e9ecef;
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
        .form-label {
            color: #2c3e50;
            font-weight: 500;
        }
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #86B817;
            box-shadow: 0 0 0 0.2rem rgba(134, 184, 23, 0.25);
        }
        .btn-primary {
            background-color: #86B817;
            border-color: #86B817;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #739a14;
            border-color: #6b8f13;
            transform: translateY(-1px);
        }
        .btn-secondary {
            background-color: #86B817;
            border-color: #86B817;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #739a14;
            border-color: #6b8f13;
            transform: translateY(-1px);
        }
        .alert-warning {
            background-color: #fff3cd;
            border-color: #ffeeba;
            color: #856404;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
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
        <h1 class="page-title">
            <c:choose>
                <c:when test="${param.edit == 'true'}">Sửa Đánh Giá</c:when>
                <c:otherwise>Thêm Đánh Giá Mới</c:otherwise>
            </c:choose>
        </h1>

        <c:if test="${sessionScope.acc == null}">
            <div class="alert alert-warning">
                Vui lòng <a href="Login.jsp">đăng nhập</a> để thêm đánh giá.
            </div>
        </c:if>

        <c:if test="${sessionScope.acc != null}">
            <div class="feedback-form">
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger">
                        ${param.error}
                    </div>
                </c:if>

                <form action="${param.edit == 'true' ? 'updatefeedback' : 'addfeedback'}" method="post">
                    <c:if test="${param.edit == 'true'}">
                        <input type="hidden" name="feedbackId" value="${param.feedbackId}">
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">Đánh giá của bạn</label>
                        <div class="rating">
                            <input type="radio" name="rate" value="5" id="star5" ${param.rate == '5' ? 'checked' : ''} required>
                            <label for="star5"></label>
                            <input type="radio" name="rate" value="4" id="star4" ${param.rate == '4' ? 'checked' : ''}>
                            <label for="star4"></label>
                            <input type="radio" name="rate" value="3" id="star3" ${param.rate == '3' ? 'checked' : ''}>
                            <label for="star3"></label>
                            <input type="radio" name="rate" value="2" id="star2" ${param.rate == '2' ? 'checked' : ''}>
                            <label for="star2"></label>
                            <input type="radio" name="rate" value="1" id="star1" ${param.rate == '1' ? 'checked' : ''}>
                            <label for="star1"></label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="comment" class="form-label">Bình luận</label>
                        <textarea class="form-control" id="comment" name="comment" rows="4" required>${fn:replace(param.comment, '%20', ' ')}</textarea>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="viewfeedback" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Xem đánh giá
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${param.edit == 'true'}">
                                    <i class="fas fa-save"></i> Cập nhật
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-paper-plane"></i> Gửi đánh giá
                                </c:otherwise>
                            </c:choose>
                        </button>
                    </div>
                </form>
            </div>
        </c:if>
    </div>

    <jsp:include page="Footer.jsp"></jsp:include>
</body>
</html> 