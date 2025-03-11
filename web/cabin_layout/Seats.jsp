<%-- 
    Document   : A64LV
    Created on : Mar 8, 2025, 12:06:53 AM
    Author     : tra my
--%>

<%@page import="model.Seats"%>
<%@page import="dal.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- Cho các toa có dạng ^(A|B)\d{2}L(V)?$-->


<% int cabinNumber = Integer.parseInt(request.getParameter("cabinNumber"));//Số cabin
    String cbid = request.getParameter("cbid");
    int sid = Integer.parseInt(request.getParameter("sid"));
    String ctype = request.getParameter("ctype");
    String depart = (String) request.getAttribute("depart"); // Lấy từ EL ${depart}
    String desti = (String) request.getAttribute("desti"); // Lấy từ EL ${desti}
    int totalSeats = Integer.parseInt(request.getParameter("total")); // Tổng số ghế
    int seatsInRow = Integer.parseInt(request.getParameter("row"));  // Loại cabin A thì số ghế trong 1 hàng là 4, loại cabin B thì số ghế trong 1 hàng là 6
    DAO dao = new DAO();%> 
<div class="col-xs-12 col-sm-12 col-md-12 text-center">
    <h4 >Toa số <span id="cabinNumber"><%=cabinNumber%></span>: Ngồi mềm điều hòa</h4>
</div>
<div class="et-col-5"><div class="et-car-previous-floor text-center" ng-click="previousCar()">&lt;</div></div>

<div class="et-col-90">
    <!--    <div class="et-full-width et-car-loading ng-hide" ng-show="!seatMap[0].Status">
            <div class="row text-capitalize text-center">
                <img src="/images/loading51.gif" style="width: 20px; height: 20px">
            </div>
            <div class="row text-center">
                <span >Đang tải thông tin toa</span>
            </div>
        </div>-->
    <div class="row et-car-floor"> 
        <%if (totalSeats == 64) {%>
        <div class="et-car-nm-64-half-block">
            <div class="et-full-width" >
                <%for (int j = 1; j <= seatsInRow / 2; j++) {
                        for (int i = 1; i <= totalSeats / 2; i++) {
                            if (i % seatsInRow == j) {
                double seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, 1);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" data-seat-number="<%= i%>" data-seat-price="<%=seatPrice%>">
                    <div class="et-car-seat-left et-seat-h-35">
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center <%=seatClass%>">
                                <div class="et-sit-no ng-scope">
                                    <span><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                        }
                    } %>
                <div class="et-car-way et-full-width"></div>
                <% for (int j = seatsInRow / 2 + 1; j <= seatsInRow; j++) {
                        for (int i = 1; i <= totalSeats / 2; i++) {
                            if (i % seatsInRow == j) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" >
                    <div class="et-car-seat-left et-seat-h-35" analytics-on="click"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                        }
                    }
                    for (int i = 1; i <= totalSeats / 2; i++) {
                        if (i % seatsInRow == 0) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" direct="direct">
                    <div class="et-car-seat-left et-seat-h-35" analytics-on="click"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}
                    }
                %>
            </div>
        </div>
        <div class="et-car-seperator" ng-class="{'et-hidden': !seatMap[0].Status}">
            <div>
            </div>
            <div>
            </div>
        </div>
        <div class="et-car-nm-64-half-block">
            <div class="et-full-width" >
                <% for (int j = 1; j <= seatsInRow / 2; j++) {
                        for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                            if (i % seatsInRow == j) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" data-seat-number="<%= i%>">
                    <div class="et-car-seat-right et-seat-h-35"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span><%= i%></span>
                                    <img src="img/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div>                            
                    </div>                       
                </div>                                            
                <% }
                        }
                    } %>
                <div class="et-car-way et-full-width"></div>
                <% for (int j = seatsInRow / 2 + 1; j <= seatsInRow; j++) {
                        for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                            if (i % seatsInRow == j) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct">
                    <div class="et-car-seat-right et-seat-h-35"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span>
                                    <img src="img/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div>                            
                    </div>                       
                </div>  
                <% }
                        }
                    }
                    for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                        if (i % seatsInRow == 0) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct">
                    <div class="et-car-seat-right et-seat-h-35"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span>
                                    <img src="img/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div>                            
                    </div>                       
                </div>
                <%}
                    }
                %>
            </div>
        </div>   
        <%} else {%>
        <div class="et-car-nm-64-half-block">
            <div class="et-full-width" >
                <%for (int j = 1; j <= seatsInRow / 2; j++) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" style="visibility: hidden"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" ng-click="buyTicket(seat, direct)"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span  ></span> <img src="/images/loading51.gif"  class="ng-hide"></div></div></div></div></div>
                                    <%for (int i = 1; i <= totalSeats / 2; i++) {
                            if (i % seatsInRow == j) {
                                int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, 1);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                    <div class="et-car-seat-left et-seat-h-35">
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center <%=seatClass%>">
                                <div class="et-sit-no ng-scope">
                                    <span><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                        }
                    } %>
                <div class="et-car-way et-full-width"></div>
                <% for (int j = seatsInRow / 2 + 1; j <= seatsInRow; j++) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" style="visibility: hidden"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" ng-click="buyTicket(seat, direct)"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span  ></span> <img src="/images/loading51.gif"  class="ng-hide"></div></div></div></div></div>
                          <%for (int i = 1; i <= totalSeats / 2; i++) {
                            if (i % seatsInRow == j) {
                                int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, 1);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                    <div class="et-car-seat-left et-seat-h-35">
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center <%=seatClass%>">
                                <div class="et-sit-no ng-scope">
                                    <span><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                        }
                    }%>
                <%for (int i = 1; i <= totalSeats / 2; i++) {
                        if (i % seatsInRow == 0) {
                                int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, 1);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                    <div class="et-car-seat-left et-seat-h-35">
                        <div class="et-col-16 et-sit-side"></div>
                        <div class="et-col-84 et-sit-sur-outer">
                            <div class="et-sit-sur text-center <%=seatClass%>">
                                <div class="et-sit-no ng-scope">
                                    <span><%= i%></span> 
                                    <img src="/images/loading51.gif"  class="ng-hide"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}
                    } %>
            </div>
        </div>

        <div class="et-car-seperator">
            <div>
            </div>
            <div>
            </div>
        </div>

        <div class="et-car-nm-64-half-block">
            <div class="et-full-width" >
                <% for (int j = 1; j <= seatsInRow / 2; j++) {
                        for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                            if (i % seatsInRow == j) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct">
                    <div class="et-car-seat-right et-seat-h-35" analytics-on="click" analytics-e                                                                                             vent="SelectTicket" ng-click="buyTicket(seat, direct)" ng-show="seat.Sta                                                                                                 tus">
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span>
                                    <img src="img/loadin                                                                                                      g51.gif"  class="                                                                                                 ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div>                            
                    </div>                       
                </div>                                            
                <% }
                    }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" style="visibility: hidden"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" ng-click="buyTicket(seat, direct)"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span  ></span> <img src="/images/loading51.gif"  class="ng-hide"></div></div></div></div></div>
                                    <% } %>

                <div class="et-car-way et-full-width"></div>

                <% for (int j = seatsInRow / 2 + 1; j <= seatsInRow; j++) {
                        for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                            if (i % seatsInRow == j) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct">
                    <div class="et-car-seat-right et-seat-h-35"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span>
                                    <img src="img/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div>                                                                                                                   
                    </div>                       
                </div>  
                <% }
                        }
                    }%>
                <div class="et-car-nm-64-sit ng-isolate-scope" style="visibility: hidden"><div class="et-car-seat-left et-seat-h-35" analytics-on="click" ng-click="buyTicket(seat, direct)"><div class="et-col-16 et-sit-side"></div><div class="et-col-84 et-sit-sur-outer"><div class="et-sit-sur text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}"><div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope"><span  ></span> <img src="/images/loading51.gif"  class="ng-hide"></div></div></div></div></div>
                                    <%for (int i = totalSeats / 2 + 1; i <= totalSeats; i++) {
                                            if (i % seatsInRow == 0) {%>
                <div class="et-car-nm-64-sit ng-isolate-scope" et-seat-right="" seat="seatMap[31]" direct="direct">
                    <div class="et-car-seat-right et-seat-h-35"  ng-click="buyTicket(seat, direct)" >
                        <div class="et-col-84 et-sit-sur-outer-invert">
                            <div class="et-sit-sur-invert text-center et-sit-bought" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == - 1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != - 1}">
                                <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                    <span  ><%= i%></span>
                                    <img src="img/loading51.gif"  class="ng-hide">
                                </div>
                            </div>
                        </div>
                        <div class="et-col-16 et-sit-side"></div> 
                    </div>                       
                </div>
                <%}
                    }%>
            </div>
        </div>
        <%}%>           
    </div>
</div>
<div class="et-col-5"><div class="et-car-next-floor text-center" ng-click="nextCar()">&gt;</div></div>

