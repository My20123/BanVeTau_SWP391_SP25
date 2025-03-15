<%-- 
    Document   : OrderHistory
    Created on : Feb 13, 2025, 10:01:30 AM
    Author     : tra my
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>

    <body>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="shopping-cart">
                <div class="px-4 px-lg-0">

                    <div class="pb-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">

                                    <!-- Shopping cart table -->
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="p-2 px-3 text-uppercase">Sản Phẩm</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Đơn Giá</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Số Lượng</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Số Tiền</div>
                                                    </th>
                                                    <th scope="col" class="border-0 bg-light">
                                                        <div class="py-2 text-uppercase">Xóa</div>
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:set var="o" value="${sessionScope.cart}"/>
                                            <c:forEach items="${o.items}" var="i">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="p-2">
                                                            <img src="${i.product.image}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                            <div class="ml-3 d-inline-block align-middle">
                                                                <h5 class="mb-0"> <a href="detail?id=${i.product.id}" class="text-dark d-inline-block">${i.product.name}</a></h5><span class="text-muted font-weight-normal font-italic"></span>
                                                            </div>
                                                        </div>
                                                    </th>

                                                    <td class="align-middle"><strong class="vnd">${i.price}</strong></td>
                                                    <td class="align-middle">
                                                        <a href="process?num=-1&id=${i.product.id}"><button class="btnSub">-</button></a> 
                                                        <strong>${i.quantity}</strong>
                                                        <a href="process?num=1&id=${i.product.id}"><button class="btnAdd">+</button></a>
                                                    </td>
                                                    <td class="align-middle"><strong class="vnd">${i.price*i.quantity}</strong></td>
                                                    <td class="align-middle">
                                                        <form action="process" method="post">
                                                            <input type="hidden" name="id" value="${i.product.id}"/>
                                                            <input type="submit" value="Delete"class="btn btn-danger"/>
                                                        </form>
                                                    </td>
                                                </tr> 
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- End -->
                            </div>
                        </div>

<!--                        <div class="row py-5 p-4 bg-white rounded shadow-sm">-->
                            <form action="check" method="post" class="row py-5 p-4 bg-white rounded shadow-sm">
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                                    <div class="p-4">
                                        <div class="input-group mb-4 border rounded-pill p-2">
                                            <input type="text" placeholder="Nhập Voucher" aria-describedby="button-addon3" class="form-control border-0">
                                            <div class="input-group-append border-0">
                                                <button id="button-addon3" type="button" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Sử dụng</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Ship</div>
                                    <div class="p-4">
                                        <ul class="list-unstyled mb-4">
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Địa chỉ</strong><input type="text" name="delivery_address" value ="" required/> </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tên người nhận</strong><input type="text" name="receiver_name" value ="${sessionScope.acc.user}" required/> </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Số điện thoại </strong><input type="text" name="receiver_phone" value ="" required/> </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Status</strong><input type="text" name="status" value ="" required/> </li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Ghi chú </strong><input type="text" name="note" value ="" /> </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Thành tiền</div>
                                    <div class="p-4">
                                        <ul class="list-unstyled mb-4">
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng tiền hàng</strong><strong class="vnd">
                                                    
                                                    ${sessionScope.total_price} </strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Phí vận chuyển</strong><strong>Free ship</strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">VAT</strong><strong class="vnd">${sessionScope.total_price*0.08} VND</strong></li>
                                            <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Tổng thanh toán</strong>
                                                <h5 class="font-weight-bold vnd">${sessionScope.total_price*1.08} </h5>
                                            </li>
                                        </ul>
                                        <input type="hidden" name="action" value="purchase">
                                        <input type="submit" class="btn btn-dark rounded-pill py-2 btn-block" value="Mua hàng">
                                        <a href="home" class="btn btn-dark rounded-pill py-2 btn-block">Tiếp tục mua sắm</a>
                                    </div>
                                </div>
                            </form>

<!--                        </div>-->

                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>


</html>
 <script>
            function formatNumberToVND(number) {
                return number.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
            }

            function formatVND() {
                // Get all elements with the class name 'vnd'
                const elements = document.getElementsByClassName('vnd');

                // Loop through the elements and format the content
                for (let i = 0; i < elements.length; i++) {
                    const value = parseInt(elements[i].textContent, 10);
                    if (!isNaN(value)) {
                        elements[i].textContent = formatNumberToVND(value);
                    }
                }
            }

            document.addEventListener('DOMContentLoaded', formatVND);
        </script>
