<%-- 
    Document   : OrderDetail
    Created on : Feb 13, 2025, 10:02:43 AM
    Author     : tra my
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>VietTrains</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <style>
            .gallery-wrap .img-big-wrap img {
                height: 450px;
                width: auto;
                display: inline-block;
                cursor: zoom-in;
            }


            .gallery-wrap .img-small-wrap .item-gallery {
                width: 60px;
                height: 60px;
                border: 1px solid #ddd;
                margin: 7px 2px;
                display: inline-block;
                overflow: hidden;
            }

            .gallery-wrap .img-small-wrap {
                text-align: center;
            }
            .gallery-wrap .img-small-wrap img {
                max-width: 100%;
                max-height: 100%;
                object-fit: cover;
                border-radius: 4px;
                cursor: zoom-in;
            }
            .img-big-wrap img{
                width: 100% !important;
                height: auto !important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>

            <div class="container">
                <div class="row">
                    <div class="col-sm-9">
                        <div class="container">
                            <div class="card">
                                <div class="row">
                                    <aside class="col-sm-5 border-right">
                                        <article class="gallery-wrap"> 
                                            <div class="img-big-wrap">
                                                <div> <a href="#"><img src="${detail.image}"></a></div>
                                        </div> <!-- slider-product.// -->
                                        <div class="img-small-wrap">
                                        </div> <!-- slider-nav.// -->
                                    </article> <!-- gallery-wrap .end// -->
                                </aside>
                                <aside class="col-sm-7">
                                    <article class="card-body p-5">
                                        <form action="check" method="post">
                                            <h3 class="title mb-3">${detail.name}</h3>

                                            <p class="price-detail-wrap"> 
                                                <span class="price h3 text-warning"> 
                                                    <span class="num vnd">${detail.price}</span>
                                                </span> 
                                            </p> <!-- price-detail-wrap .// -->
                                            <dl class="item-property">
                                                <dt>Description</dt>
                                                <dd><p>
                                                        ${detail.description}
                                                    </p></dd>
                                            </dl>

                                            <hr>
                                            <div class="row">
                                                <div class="col-sm-5">
                                                    <dl class="param param-inline">
                                                        <dt>Quantity: </dt>
                                                        <dd>
                                                            <select name="num" class="form-control form-control-sm" style="width:70px;">
                                                                <option value="1"> 1 </option>
                                                                <option value="2"> 2 </option>
                                                                <option value="3"> 3 </option>
                                                                <option value="4"> 4 </option>
                                                                <option value="5"> 5 </option>
                                                            </select>
                                                        </dd>
                                                    </dl>  <!-- item-property .// -->
                                                </div> <!-- col.// -->

                                            </div> <!-- row.// -->
                                            <hr>
                                            <input type="hidden" name="action" value="add-product">
                                            <input type="hidden" name="id" value="${detail.id}">
                                            <input type="submit" value="Mua ngay" class="btn btn-lg btn-primary text-uppercase">
                                            <!--                                        <a href="check?action=add-product" class="btn btn-lg btn-primary text-uppercase"> Buy now </a>-->
                                            

                                        </form>

                                    </article> <!-- card-body.// -->
                                </aside> <!-- col.// -->
                            </div> <!-- row.// -->
                        </div> <!-- card.// -->


                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="Footer.jsp"></jsp:include>
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

