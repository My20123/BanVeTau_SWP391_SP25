<%-- 
    Document   : Home
    Created on : Jan 19, 2025, 10:48:04 PM
    Author     : tra my
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>VietTrains</title>
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
        <link href="css/trainshow.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
        <style>
            .cart-section .card {
                border: 1px solid black;
                border-radius: 5px;
                background-color: white;
            }

            .cart-section .card-header {
                background-color: white;
                border-bottom: 1px solid rgba(0,0,0,0.125);
            }

            .cart-section .card-footer {
                background-color: white;
                border-top: 1px solid rgba(0,0,0,0.125);
            }

            .cart-section .text-primary {
                color: #005F7A !important;
            }

            .cart-section .btn-primary {
                background-color: #00a3ee   ;
                border-color: #00a3ee ;
            }

            .cart-section .btn-primary:hover {
                background-color: #33b5f7  ;
                border-color: #33b5f7  ;
            }

            .cart-item {
                padding: 10px;
                margin: 5px 0;
                background-color: #f9f9f9;
                border-radius: 3px;
                font-size:10px;
            }

            .selected-seat {
                background-color: #e3f2fd;
                border: 2px solid #2196f3;
            }

            .et-car-nm-64-sit {
                cursor: pointer;
            }

            .et-car-nm-64-sit:hover {
                background-color: #f5f5f5;
            }

            .caIcon.et-car-icon.et-car-icon-selected {
                background-color: #a6b727 !important;
            }

            .et-car-block .caIcon.et-car-icon.et-car-icon-selected {
                background-color: #a6b727 !important;
            }

            .et-car-block .caIcon.et-car-icon {
                cursor: pointer;
            }
        </style>

    </head>
    <body >
        <!--                 Spinner Start -->
                 <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div> 
        <!--                 Spinner End -->
        <jsp:include page="Header.jsp"></jsp:include>
            <!-- Navbar & Hero Start -->
            <div class="container-fluid position-relative p-0">
                <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
                    <a href="Home.jsp" class="navbar-brand p-0">
                        <img src="logo/train_logo.png" alt="Logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto py-0">
                            <a href="home" class="nav-item nav-link active">Trang chủ</a>
                            <a href="about.html" class="nav-item nav-link ">Thông tin đặt chỗ</a>
                            <a href="ScheduleDetailSearch.jsp" class="nav-item nav-link">Giờ tàu-Giá vé</a>                            
                            <a href="routesview" class="nav-item nav-link">Các tuyến đường</a>
                            <a href="TicketVerifi.jsp" class="nav-item nav-link">Kiểm tra vé</a>
                            <a href="package.html" class="nav-item nav-link">Quy định</a>
                            <a href="contact.html" class="nav-item nav-link">Liên hệ</a>
                        </div>
                    </div>
                </nav>
                <div class=" container-fluid pt-5 pb-5" style="background-color: #005F7A; height: 70px;">
                </div>
                <div >
                    <div class="container py-5" style="width: 100%;margin-left: auto;box-sizing: border-box;margin-right: auto;display: block;padding-left: 16px;padding-right: 16px;height: 80px;margin: auto;background: #ffffff;border-radius: 10px;position: absolute; left: 0;right: 0;top: 90px;padding: 8px;box-shadow: 0px 5px 20px 0px #0000001A;display: -webkit-box;display: -webkit-flex;display: -ms-flexbox; display: flex; -webkit-align-items: center;-webkit-box-align: center;-ms-flex-align: center; align-items: center;">
                        <form action="searchtrain" method="post" id="ticket-form" onsubmit="return validateForm()">
                            <div class="train-search__data">
                                <div class="date-picker">
                                    <div class="SingleDatePickerInput SingleDatePickerInput_1" >
                                        <div class="DateInput DateInput_1" style="display: flex;justify-content: normal;width: auto;margin: 0 auto;">
                                            <p>Thời gian đi <input type="date" id="datepicker" name="depart_date" value="${from_date}"></p>
                                        <div class="search-stations__divider"></div>
                                        <p style="margin-left: 5px;">Thời gian về <input type="date" id="return_datepicker" name="return_date" value="${return_date}"></p>
                                    </div>
                                </div>
                            </div>
                            <div class="search-stations">
                                <div class="station-select">
                                    <div class=" css-aakg73-container">
                                        <span id="react-select-2-live-region" class="css-7pg0cj-a11yText"></span>
                                        <span aria-live="polite" aria-atomic="false" aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
                                        <div class="react-select__control css-cv0q10">
                                            <div class="react-select__value-container css-76smiy">
                                                <div class="react-select__placeholder css-1jqq78o-placeholder" id="react-select-2-placeholder" style="margin-left: 25px;">Ga đi</div>
                                                <div class="search-station-input-wrapper">
                                                    <div class="react-select__input-container css-19bb58m" data-value="">
                                                        <input class="react-select__input" list="stations"  id="from_station"  value="${depart}" style="color: inherit; background: 0px center; opacity: 1;  width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px;margin-left:40px; outline: 0px; padding: 0px;">
                                                        <datalist id="stations">
                                                            <c:forEach items="${listS}" var="station">
                                                                <option value="${station}">${station}</option>
                                                            </c:forEach>
                                                        </datalist>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="search-stations__divider">
                                    <button class="search-stations__switcher" type="button" onclick="swapData()">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none">
                                        <path fill="#989898" d="M21.925 11.62a.999.999 0 0 0-.21-.33l-4.002-3.996a1.004 1.004 0 0 0-1.42 1.418l2.3 2.288H5.407l2.3-2.288a1.003 1.003 0 1 0-1.42-1.418L2.285 11.29a1 1 0 0 0-.21.33c-.1.243-.1.516 0 .759a.998.998 0 0 0 .21.33l4.002 3.996a1 1 0 0 0 1.42 0 1 1 0 0 0 0-1.419l-2.3-2.288h13.186l-2.3 2.288a.999.999 0 0 0 .325 1.637 1.002 1.002 0 0 0 1.095-.218l4.002-3.996a.998.998 0 0 0 .21-.33c.1-.243.1-.516 0-.76Z"></path>
                                        </svg>
                                    </button>
                                </div>
                                <div class="station-select">
                                    <div class=" css-aakg73-container">
                                        <span id="react-select-3-live-region" class="css-7pg0cj-a11yText"></span>
                                        <span aria-live="polite" aria-atomic="false" aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
                                        <div class="react-select__control css-cv0q10">
                                            <div class="react-select__value-container css-76smiy">
                                                <div class="react-select__placeholder css-1jqq78o-placeholder" id="react-select-3-placeholder" style="margin-left: 25px;">Ga đến</div>
                                                <div class="search-station-input-wrapper">
                                                    <div class="react-select__input-container css-19bb58m" data-value="">
                                                        <input class="react-select__input" list="stations" id="to_station" value="${desti}" style="color: inherit; background: 0px center; opacity: 1; width: 250px; grid-area: 1 / 2; font: inherit; min-width: 2px; border: 0px; margin: 0px; margin-left:40px ;outline: 0px; padding: 0px;">
                                                        <datalist id="stations">
                                                            <c:forEach items="${listS}" var="station">
                                                                <option value="${station}">${station}</option>
                                                            </c:forEach>
                                                        </datalist>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="train-search__submit-btn" type="submit">Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Nav end -->

            <div  class="container-fluid py-lg-5" style="background-color: #fafafa;margin-top: 6rem;">
                <div class="container py-5">
                    <div class="row" style="top:3rem;">
                        <div class="col-xs-12 col-sm-8 et-col-md-9" style="border: 1px solid black;background-color: white;border-radius: 5px;">
                            <div class="row et-page-header">
                                <span class="et-main-label ng-binding"> 
                                    <i class="fas fa-train me-2"></i><strong class="ng-binding">Chiều đi:</strong> ngày ${from_date} từ ${depart} đến ${desti} <i class="fas fa-long-arrow-alt-right mx-2"></i></span>
                            </div>
                            <div class="row et-train-list">
                                <div class="previous-train et-col-md-1 text-center">
                                    <div class="et-pre-train ng-scope et-arrow-disabled" ng-class="{'et-arrow-disabled': !canShiftBack}" ng-click="chuyenTruoc(true)" tooltip="Tàu trước">
                                        <div class="et-arrow-left"></div>
                                    </div>
                                </div>                            
                                <div class="train-group"> 
                                    <c:forEach items="${departSchedules}" var="schedule">
                                        <div class="col-xs-4 col-sm-3 et-col-md-2 et-train-block ng-scope"  analytics-on="click" analytics-event="SelectTrain">
                                            <div class="et-train-head"  data-train-id="${schedule.getTrid()}">
                                                <div class="row center-block" style="width: 40%; margin-bottom: 3px">
                                                    <div class="et-train-lamp text-center ng-binding" style="color:#bf8c01;">${schedule.getTrid()}</div> 
                                                </div> 
                                                <div class="et-train-head-info">
                                                    <div class="row et-no-margin">
                                                        <span class="pull-left et-bold ng-binding">TG đi</span> 
                                                        <span class="pull-right"></span> 
                                                        <span class="pull-right ng-binding">${schedule.getFromTime()}</span>
                                                    </div>
                                                    <div class="row et-no-margin">
                                                        <span class="pull-left et-bold ng-binding">TG đến</span> 
                                                        <span class="pull-right"></span> 
                                                        <span class="pull-right ng-binding">${schedule.getToTime()}</span></div>
                                                    <div class="row et-no-margin">
                                                        <div class="et-col-50 text-center">
                                                            <div class="et-text-sm ng-binding">SL chỗ trống</div>
                                                            <div class="et-text-large et-bold pull-right ng-binding" style="margin-right: 5px">${dao.searchAvailSeatsOfTrainWithScheduleID(schedule.getId())}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row et-no-margin">
                                                    <div class="et-col-50">
                                                        <span class="et-train-lamp-bellow-left"></span>
                                                    </div>
                                                    <div class="et-col-50">
                                                        <span class="et-train-lamp-bellow-right"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="et-train-base"></div>
                                            <div class="et-train-base-2"></div>
                                            <div class="et-train-base-3"></div>
                                            <div class="et-train-base-4"></div>
                                            <div class="et-train-base-5"></div>
                                        </div>   
                                    </c:forEach>     
                                </div>

                                <div class="next-train col-md-1 text-center pull-right">
                                    <div class="et-next-train ng-scope" ng-class="{'et-arrow-disabled': !canShiftForward}" ng-click="chuyenSau(true)" tooltip="Tàu sau">
                                        <div class="et-arrow-right"></div>
                                    </div>
                                </div>
                            </div>                    
                            <div class="row" style="margin-left:-10PX">
                                <!-- Cabin List -->
                                <c:forEach items="${departSchedules}" var="schedule" varStatus="status">
                                    <div id="cabin-container-${schedule.getTrid()}" class="col-md-12 et-no-margin" style="display:none;">
                                        <div class="et-car-block">
                                            <div class="et-car-icon">
                                                <img src="img/train2.png">
                                            </div>
                                            <div class="text-center text-info et-car-label ng-binding">${schedule.getTrid()}</div>
                                        </div>
                                        <c:forEach items="${dao.searchCabinsWithTrainID(schedule.getTrid())}" var="cabin"> 
                                            <div class="et-car-block ng-scope">
                                                <div data-cabin-type="${cabin.getCtype()}" data-cabin-id="${cabin.getId()}" data-schedule-id="${schedule.getId()}"
                                                     class="caIcon et-car-icon ${cabin.getStatus() == 1 && !cabin.isSelected() ? 'et-car-icon-avaiable' : ''}
                                                     ${cabin.getStatus() == 0 && !cabin.isSelected() ? 'et-car-icon-full' : ''}
                                                     ${cabin.getStatus() == 2 && !cabin.isSelected() ? 'et-car-icon-sold-out' : ''}
                                                     ${cabin.isChonChoTuDong() && !cabin.isSelected() ? 'et-car-icon-other' : ''}"
                                                     style="<c:out value='display: block;' escapeXml='false'/>">
                                                    <img src="img/trainCar2.png" ng-show="!toa.IsChonChoTuDong">
                                                    <img src="img/trainCarAuto.png" ng-show="toa.IsChonChoTuDong" class="ng-hide">
                                                </div>
                                                <c:set var="cabinNumber" value="${fn:split(cabin.getId(), '/')[1]}" />

                                                <div class="text-center text-info et-car-label ng-binding">${cabinNumber}</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="showCabin"></div>
<c:if test="${trip_type == 'roundTrip'}">
   
    <div class="row et-page-header">
        <span class="et-main-label ng-binding" style="margin-top: :30px"> 
                                    <i class="fas fa-train me-2"></i><strong class="ng-binding">Chiều về:</strong> ngày ${return_date} từ ${desti} đến ${depart} <i class="fas fa-long-arrow-alt-right mx-2"></i></span>
                            </div>
                            <div class="row et-train-list">
                                <div class="previous-train et-col-md-1 text-center">
                                    <div class="et-pre-train ng-scope et-arrow-disabled" ng-class="{'et-arrow-disabled': !canShiftBack}" ng-click="chuyenTruoc(true)" tooltip="Tàu trước">
                                        <div class="et-arrow-left"></div>
                                    </div>
                                </div>                            
                                <div class="train-group"> 
                                    <c:forEach items="${return_schedules}" var="schedule">
                                        <div class="col-xs-4 col-sm-3 et-col-md-2 et-train-block ng-scope"  analytics-on="click" analytics-event="SelectTrain">
                                            <div class="et-train-head"  data-train-id="${schedule.getTrid()}">
                                                <div class="row center-block" style="width: 40%; margin-bottom: 3px">
                                                    <div class="et-train-lamp text-center ng-binding" style="color:#bf8c01;">${schedule.getTrid()}</div> 
                                                </div> 
                                                <div class="et-train-head-info">
                                                    <div class="row et-no-margin">
                                                        <span class="pull-left et-bold ng-binding">TG đi</span> 
                                                        <span class="pull-right"></span> 
                                                        <span class="pull-right ng-binding">${schedule.getFromTime()}</span>
                                                    </div>
                                                    <div class="row et-no-margin">
                                                        <span class="pull-left et-bold ng-binding">TG đến</span> 
                                                        <span class="pull-right"></span> 
                                                        <span class="pull-right ng-binding">${schedule.getToTime()}</span></div>
                                                    <div class="row et-no-margin">
                                                        <div class="et-col-50 text-center">
                                                            <div class="et-text-sm ng-binding">SL chỗ trống</div>
                                                            <div class="et-text-large et-bold pull-right ng-binding" style="margin-right: 5px">${dao.searchAvailSeatsOfTrainWithScheduleID(schedule.getId())}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row et-no-margin">
                                                    <div class="et-col-50">
                                                        <span class="et-train-lamp-bellow-left"></span>
                                                    </div>
                                                    <div class="et-col-50">
                                                        <span class="et-train-lamp-bellow-right"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="et-train-base"></div>
                                            <div class="et-train-base-2"></div>
                                            <div class="et-train-base-3"></div>
                                            <div class="et-train-base-4"></div>
                                            <div class="et-train-base-5"></div>
                                        </div>   
                                    </c:forEach>     
                                </div>

                                <div class="next-train col-md-1 text-center pull-right">
                                    <div class="et-next-train ng-scope" ng-class="{'et-arrow-disabled': !canShiftForward}" ng-click="chuyenSau(true)" tooltip="Tàu sau">
                                        <div class="et-arrow-right"></div>
                                    </div>
                                </div>
                            </div>                    
                            <div class="row" style="margin-left:-10PX">
                                <!-- Cabin List -->
                                <c:forEach items="${return_schedules}" var="schedule" varStatus="status">
                                    <div id="cabin-container-${schedule.getTrid()}" class="col-md-12 et-no-margin" style="display:none;">
                                        <div class="et-car-block">
                                            <div class="et-car-icon">
                                                <img src="img/train2.png">
                                            </div>
                                            <div class="text-center text-info et-car-label ng-binding">${schedule.getTrid()}</div>
                                        </div>
                                        <c:forEach items="${dao.searchCabinsWithTrainID(schedule.getTrid())}" var="cabin"> 
                                            <div class="et-car-block ng-scope">
                                                <div data-cabin-type="${cabin.getCtype()}" data-cabin-id="${cabin.getId()}" data-schedule-id="${schedule.getId()}"
                                                     class="caIcon et-car-icon ${cabin.getStatus() == 1 && !cabin.isSelected() ? 'et-car-icon-avaiable' : ''}
                                                     ${cabin.getStatus() == 0 && !cabin.isSelected() ? 'et-car-icon-full' : ''}
                                                     ${cabin.getStatus() == 2 && !cabin.isSelected() ? 'et-car-icon-sold-out' : ''}
                                                     ${cabin.isChonChoTuDong() && !cabin.isSelected() ? 'et-car-icon-other' : ''}"
                                                     style="<c:out value='display: block;' escapeXml='false'/>">
                                                    <img src="img/trainCar2.png" ng-show="!toa.IsChonChoTuDong">
                                                    <img src="img/trainCarAuto.png" ng-show="toa.IsChonChoTuDong" class="ng-hide">
                                                </div>
                                                <c:set var="cabinNumber" value="${fn:split(cabin.getId(), '/')[1]}" />

                                                <div class="text-center text-info et-car-label ng-binding">${cabinNumber}</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="showCabin"></div>
</c:if>


                            <div class="et-col-md-12 table-bordered list-ticket-deskhop" ng-show="(searchData.toaDi & amp; & amp; !searchData.toaDi.IsChonChoTuDong) || (searchData.toaVe & amp; & amp; !searchData.toaVe.IsChonChoTuDong)" style="margin-top: 20px; padding: 5px"><div class="et-col-md-12"><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-avaiable"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa còn vé</span></div></div><div class="et-col-md-12 text-center et-no-padding ng-binding" style="margin-top: -20px;display:none">Toa còn vé</div></div></div><div class="et-col-md-3 et-no-padding" style="display:none"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-full"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa chưa bán</span></div></div><div class="et-col-md-12 et-no-padding text-center ng-binding" style="margin-top: -20px;display:none">Toa chưa bán</div></div></div><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-selected"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa đang chọn</span></div></div><div class="et-col-md-12 et-no-padding text-center ng-binding" style="margin-top: -20px;display:none">Toa đang chọn</div></div></div><div class="et-col-md-4 et-no-padding"><div class="et-col-md-12"><div class="et-col-md-12" style="padding:0px"><div class="et-col-md-12" style="padding:6px 0px 0px 0px;"><div class="et-car-block" style="height:36px"><div class="et-car-icon et-car-icon-sold-out"><img src="img/trainCar2.png"></div></div><span style="padding-left:6px" class="ng-binding">Toa hết vé</span></div></div><div class="et-col-md-12 text-center et-no-padding ng-binding" style="margin-top: -20px;display:none">Toa hết vé</div></div></div></div><div class="et-col-md-12 table-bordered"></div><div class="et-col-md-12 et-legend" style="padding:0px"><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ trống</div></div></div><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-longer"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center et-sit-longer"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ chưa cắt chặng</div></div></div><div class="et-col-md-4" style="padding: 0px"><div class="et-col-md-4" style="padding: 0px"><div class="row"><div class="et-car-nm-64-sit et-col-md-6" style="padding-right:0px"><div class="et-col-16 et-sit-side"></div><div class="et-col-64 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-blocked"></div></div></div><div class="et-bed-left et-col-md-3 et-no-padding" style="width:30%"><div class="et-bed-outer"><div class="et-bed text-center et-sit-blocked"></div><div class="et-bed-illu"></div></div></div></div></div><div class="et-col-md-8" style="padding: 0px"><div class="et-legend-label ng-binding" style="margin-left:-6px">Chỗ đã bán, không bán</div></div></div></div></div>
                        </div>
                        <div class="col-3 cart-section" style="position: sticky; top: 20px;">
                            <div class="card">
                                <div class="et-main-label" style="margin-top:10px;">
                                    <span class="et-main-label ng-binding"> 
                                        <i class="fas fa-shopping-cart me-2"></i><strong >Giỏ vé:</strong>
                                    </span>
                                </div>
                                <form action="processOrder" method="POST" id="bookingForm" >
                                    <div id="cartItems" class="card-body" style="max-height: 400px; overflow-y: auto;"></div>
                                    <div class="card-footer" id="card-footer" style="display:none;">
                                        <input type="hidden" name="selectedSeats" id="selectedSeatsInput">
                                        <input type="hidden" name="from_station" value="${depart}">
                                        <input type="hidden" name="to_station" value="${desti}">
                                        <input type="hidden" name="from_date" value="${from_date}">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-ticket-alt me-2"></i>Đặt vé
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                                        
                </div>

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
        <script>
// Form validation
// Form validation
                                function validateForm() {
                                    const fromStationElem = document.getElementById('from_station');
                                    const toStationElem = document.getElementById('to_station');
                                    const departDateElem = document.getElementById('datepicker');
                                    const returnDateElem = document.getElementById('return_datepicker');
                                    if (!fromStationElem || !toStationElem || !departDateElem) {
                                        alert('Có lỗi xảy ra: Một số trường không tìm thấy trên trang.');
                                        return false;
                                    }

                                    const fromStation = fromStationElem.value.trim();
                                    const toStation = toStationElem.value.trim();
                                    const departDate = departDateElem.value;
                                    const returnDate = returnDateElem ? returnDateElem.value : '';
                                    if (!fromStation || !toStation) {
                                        alert('Vui lòng chọn ga đi và ga đến.');
                                        return false;
                                    }

                                    if (fromStation === toStation) {
                                        alert('Ga đi và ga đến không được trùng nhau.');
                                        return false;
                                    }

                                    const today = new Date();
                                    today.setHours(0, 0, 0, 0);
                                    const depart = new Date(departDate);
                                    if (depart < today) {
                                        alert('Ngày đi không thể là ngày trong quá khứ.');
                                        return false;
                                    }

                                    if (returnDate) {
                                        const returnD = new Date(returnDate);
                                        if (returnD < depart) {
                                            alert('Ngày về phải sau ngày đi.');
                                            return false;
                                        }
                                    }
                                    return true;
                                }
                                ;

// Swap station values
                                function swapData() {
                                    const fromStationElem = document.getElementById('from_station');
                                    const toStationElem = document.getElementById('to_station');
                                    if (fromStationElem && toStationElem) {
                                        [fromStationElem.value, toStationElem.value] = [toStationElem.value, fromStationElem.value];
                                    }
                                }
                                ;

// Set min date for datepickers
                                window.onload = function () {
                                    const today = new Date().toISOString().split('T')[0];
                                    const departPicker = document.getElementById('datepicker');
                                    const returnPicker = document.getElementById('return_datepicker');
                                    if (departPicker)
                                        departPicker.min = today;
                                    if (returnPicker)
                                        returnPicker.min = today;
                                    if (departPicker && returnPicker) {
                                        departPicker.addEventListener('change', function () {
                                            returnPicker.min = this.value;
                                        });
                                    }
                                };
                                let selectedTrainId = null;
                                let selectedCabinId = null;
                                let selectedCabinType = null;
                                let selectedScheduleId = null;
                                let selectedSeats = [];
// Function to select cabin (gọi sau khi đã chọn train)
                                function selectCabin(cid, ctype, carIcon) {
                                    if (!ctype || !carIcon)
                                        return;
                                    selectedCabinId = cid; // Lưu cabinId đã chọn
                                    selectedCabinType = ctype; // Lưu cabinType đã chọn

                                    // Xóa selected class từ tất cả các cabin icons
                                    document.querySelectorAll('.et-car-block .caIcon.et-car-icon').forEach(icon => {
                                        icon.classList.remove('et-car-icon-selected');
                                    });

                                    // Thêm selected class vào cabin được chọn
                                    carIcon.classList.add('et-car-icon-selected');

                                    const totalSeats = ctype.replace(/^(A|B)n?(\d{2})L(V)?$/, "$2");
                                    let seatsInRow; // Khai báo biến trước

                                    if (!ctype.includes("n")) {
                                        seatsInRow = ctype.includes("A") ? 4 : (ctype.includes("B") ? 6 : 0);
                                    }
                                    let berthsInRoom; // Khai báo biến trước

                                    if (ctype.includes("n")) {
                                        berthsInRoom = ctype.includes("A") ? 4 : (ctype.includes("B") ? 6 : 0);
                                    }

                                    const cabinNumber = cid.split("/")[1];
                                    console.log("ctype: "+ctype);

                                    // Xác định layout cần tải dựa vào loại cabin
                                    const regex = /^(A|B)n\d{2}L(V)?$/;
                                    let layoutFile = regex.test(ctype) ? "cabin_layout/Berths.jsp?cbid=" + cid + "&total=" + totalSeats + "&room=" + berthsInRoom + "&cabinNumber=" + cabinNumber + "&ctype=" + ctype + "&sid=" + selectedScheduleId : "cabin_layout/Seats.jsp?cbid=" + cid + "&total=" + totalSeats + "&row=" + seatsInRow + "&cabinNumber=" + cabinNumber + "&ctype=" + ctype + "&sid=" + selectedScheduleId;
                                    console.log("scheduleid: ", selectedScheduleId);
                                    fetch(layoutFile)
                                            .then(response => response.text())
                                            .then(data => {
                                                const showCabinDiv = document.querySelector(".showCabin");
                                                if (showCabinDiv) {
                                                    showCabinDiv.innerHTML = data; // Chèn nội dung từ JSP vào div
                                                } else {
                                                    console.error("Không tìm thấy phần tử div có class 'showCabin'");
                                                }
                                            })
                                            .catch(error => {
                                                console.error(`Lỗi khi fetch ${layoutFile}:`, error);
                                            });
                                }

// 🟢 Function chọn train và cập nhật cabin khả dụng
                                function selectTrain(trainId, trainHead, isInitialLoad = false) {
                                    if (!trainId || !trainHead)
                                        return;
                                    selectedTrainId = trainId; // Lưu trainId đã chọn
                                    console.log(selectedTrainId);
                                    // Cập nhật trạng thái chọn tàu
                                    document.querySelectorAll('.et-train-head').forEach(h => h.classList.remove('et-train-head-selected'));
                                    trainHead.classList.add('et-train-head-selected');

                                    // Ẩn tất cả cabin
                                    document.querySelectorAll('.col-md-12.et-no-margin').forEach(container => {
                                        container.style.display = 'none';
                                    });

                                    // Hiển thị cabin của train được chọn
                                    const selectedCabinContainer = document.getElementById(`cabin-container-` + trainId);

                                    if (selectedCabinContainer) {
                                        selectedCabinContainer.style.display = 'block';
                                    } else {
                                        console.error(`Không tìm thấy cabin-container-${trainId}`);
                                }
                                }
// 🟢 Function chọn ghế
                                function selectSeat(seatElement) {
                                    const seatNumber = seatElement.getAttribute("data-seat-number"); // Lấy số ghế
                                    const price = seatElement.getAttribute("data-seat-price") || "Không có giá"; // Lấy giá ghế
                                    const seatSurElement = seatElement.querySelector(".et-sit-sur"); // Tìm class "et-sit-sur"

                                    const depart = "<%= request.getAttribute("depart")%>";
                                    const desti = "<%= request.getAttribute("desti")%>";
                                    const fromTime = "<%= request.getAttribute("from_date")%>";


                                    if (!seatSurElement) {
                                        console.warn("⚠ Không tìm thấy .et-sit-sur trong seatElement");
                                        return;
                                    }

                                    // 🟢 Xác định loại ghế dựa vào `selectedCabinType`
                                    let seatType = selectedCabinType && selectedCabinType.includes("n") ? "Giường nằm" : "Ngồi mềm";

                                    // 🟢 Tìm giỏ vé
                                    const cart = document.getElementById("cartItems");
                                    const button = document.getElementById("card-footer");
                                    if (!cart) {
                                        console.error("❌ Không tìm thấy phần tử Giỏ vé");
                                        return;
                                    }

                                    // 🟢 Kiểm tra xem ghế đã được chọn chưa
                                    let existingSeat = document.querySelector(`#cartItems div[data-seat-number='` + seatNumber + `']`);
                                    if (existingSeat) {
                                        // Nếu đã chọn, click lại sẽ bỏ chọn ghế
                                        existingSeat.remove();
                                        seatSurElement.classList.remove("et-sit-buying"); // Bỏ hiệu ứng chọn
                                    } else {
                                        // 🟢 Thêm ghế vào giỏ vé
                                        let seatInfo = document.createElement("div");
                                        seatInfo.classList.add("cart-item");
                                        seatInfo.setAttribute("data-seat-number", seatNumber);
                                        seatInfo.innerHTML = `
        <p>` + selectedTrainId + `: ` + depart + ` - ` + desti + `</p> 
            <p> ` + seatType + ` - Toa ` + selectedCabinId + ` - Chỗ ` + seatNumber + ` </p>
            <p> ` + fromTime + ` </p>        
            <p> ` + price + ` VNĐ</p>
        `;
                                        cart.appendChild(seatInfo);
                                        seatSurElement.classList.add("et-sit-buying");
                                        selectedSeats.push({ seatNumber, selectedCabinId,seatType,selectedTrainId, price});
                                         document.getElementById("selectedSeatsInput").value = JSON.stringify(selectedSeats);
                                         console.log("🛒 Ghế đã chọn:", JSON.stringify(selectedSeats));
                                         button.style.display='block';
                                         
                                    }
                                }

// 🟢 Lắng nghe sự kiện click trên trainHead & cập nhật danh sách cabin

                                document.addEventListener('DOMContentLoaded', function () {
                                    // 🟢 Click vào Train Head → Chọn tàu
                                    document.body.addEventListener('click', function (event) {
                                        let trainHead = event.target.closest('.et-train-head');
                                        if (trainHead) {
                                            selectTrain(trainHead.getAttribute('data-train-id'), trainHead);
                                        }
                                    });

                                    // 🟢 Click vào Cabin → Chọn Cabin & Hiển thị ghế
                                    document.body.addEventListener('click', function (event) {
                                        let carIcon = event.target.closest('.et-car-icon');
                                        if (carIcon) {
                                            let cabinType = carIcon.getAttribute("data-cabin-type");
                                            let cabinId = carIcon.getAttribute("data-cabin-id");
                                            let scheduleId = carIcon.getAttribute("data-schedule-id");

                                            if (scheduleId) {
                                                selectedScheduleId = scheduleId;
                                            }
                                            selectCabin(cabinId, cabinType, carIcon);
                                        }
                                    });

                                    // 🟢 Click vào Ghế → Gọi `selectSeat()`
                                    document.body.addEventListener('click', function (event) {
                                        let seat = event.target.closest('.et-car-nm-64-sit, .et-col-1-16.et-seat-h-35');
                                        if (seat) {
                                            let seatNumber = seat.getAttribute("data-seat-number");
                                            if (!seatNumber) {
                                                console.warn("⚠ Không tìm thấy số ghế (data-seat-number)");
                                                return;
                                            }
                                            selectSeat(seat);
                                            console.log("💺 Ghế được chọn:", seatNumber);
                                        }
                                    });
                                });
    </script>



    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</body>

</html>  
