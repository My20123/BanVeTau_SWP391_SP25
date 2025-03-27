<%-- 
    Document   : Bn__LM-Bn__L
    Created on : Mar 8, 2025, 12:49:28 AM
    Author     : tra my
--%>
<%@page import="model.Seats"%>
<%@page import="dal.DAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- Cho các toa có dạng ^(A|B)n\d{2}L(V)?$-->



<% int cabinNumber=Integer.parseInt(request.getParameter("cabinNumber"));//Số cabin
String cbid = request.getParameter("cbid");
    int sid = Integer.parseInt(request.getParameter("sid"));
    String ctype = request.getParameter("ctype");
    String depart =  request.getParameter("depart"); // Lấy từ EL ${depart}
    String desti =  request.getParameter("desti"); // Lấy từ EL ${desti}
    int totalSeats = Integer.parseInt(request.getParameter("total")); // Tổng số ghế
    int berthsInRoom = Integer.parseInt(request.getParameter("room")); // Loại cabin A thì số ghế trong 1 khoang là 4, loại cabin B thì số ghế trong 1 khoang là 6
    DAO dao = new DAO();%> 
<div class="col-xs-12 col-sm-12 col-md-12 text-center">
    <h4 class="ng-binding">Toa số <span id="cabinNumber"><%=cabinNumber%></span>: Giường nằm điều hòa</h4>
</div>

<style>
    .container-wrapper {
        display: flex;
        align-items: center;
        width: 100%;
    }
    .et-col-5 {
        flex: 0 0 auto;
    }
    .row.et-car-floor {
        flex: 1;
    }
</style>

<div class="container-wrapper">
    <div class="et-col-5"><div class="et-car-previous-floor text-center" ng-click="previousCar()">&lt;</div></div>
    <div class="row et-car-floor">
        <div class="et-col-1-18 et-car-floor-full-height">
            <div class="et-bed-way et-full-width"></div>
            <% for (int i = 1; i <= berthsInRoom / 2; i++) {%> 
            <div class="et-bed-way et-full-width text-center small ng-binding">T<%= i%></div>
            <% }%> 
        </div>
        <div class="et-col-8-9">
            <div class="et-bed-way et-full-width et-text-sm">
                <div class="et-col-1-8 text-center ng-binding">Khoang 1</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 2</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 3</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 4</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 5</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 6</div>
                <div class="et-col-1-8 text-center ng-binding">Khoang 7</div>
                <div class="et-col-1-8 text-center ng-binding et-hidden">Khoang 8</div>
                <%for (int i = 1; i <= totalSeats; i++) {
                    if (i % berthsInRoom == 0) {int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
                <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                    <div class="et-bed-right" >
                        <div class="et-bed-outer">
                            <div class="et-bed text-center <%=seatClass%>" >
                            <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>
                    </div>
                </div>
            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 1) {
int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center  <%=seatClass%>" >
                             <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span> 
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>
                    </div>
                </div>
            </div>
            <%}
           }%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" style="visibility: hidden"><div class="et-bed-right"><div class="et-bed-outer"><div class="et-bed text-center et-sit-bought"><div class="et-sit-no ng-scope"><span></span><img src="/images/loading51.gif" class="ng-hide"></div></div><div class="et-bed-illu"></div></div></div></div>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" style="visibility: hidden" ><div class="et-bed-right"><div class="et-bed-outer"><div class="et-bed text-center et-sit-bought"><div class="et-sit-no ng-scope"><span></span><img src="/images/loading51.gif" class="ng-hide"></div></div><div class="et-bed-illu"></div></div></div></div>
                                    <%for (int i = 1; i <= totalSeats; i++) {
               if (i % berthsInRoom == berthsInRoom - 2) {
               int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
               Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                <div class="et-bed-right" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center <%=seatClass%>" >
                             <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>

                    </div>

                </div>

            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 3) {
int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center <%=seatClass%>" >
                             <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span> 
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>
                    </div>
                </div>
            </div>
            <%}
           }%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" style="visibility: hidden"><div class="et-bed-right"><div class="et-bed-outer"><div class="et-bed text-center et-sit-bought"><div class="et-sit-no ng-scope"><span></span><img src="/images/loading51.gif" class="ng-hide"></div></div><div class="et-bed-illu"></div></div></div></div>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" style="visibility: hidden" ><div class="et-bed-right"><div class="et-bed-outer"><div class="et-bed text-center et-sit-bought"><div class="et-sit-no ng-scope"><span></span><img src="/images/loading51.gif" class="ng-hide"></div></div><div class="et-bed-illu"></div></div></div></div>
                                    <%if (berthsInRoom == 6) {%>
                                    <%for (int i = 1; i <= totalSeats; i++) {
                if (i % berthsInRoom == berthsInRoom - 4) {
                int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
                Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                <div class="et-bed-right" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center <%=seatClass%>" >
                             <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>

                    </div>

                </div>

            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 5) {
int seatPrice = dao.updateSeatsPrice(depart, desti, sid, ctype, cbid, i);
Seats seat=dao.get1SeatWithCabinIdNSeatN0(cbid, i);
                String seatClass = "";
            if (seat.getStatus() == 1) {
                seatClass = "et-sit-buying"; // select ghế
            } else if (seat.getStatus() == 0) {
                seatClass = "et-sit-avaiable"; // Ghế trống
            } else if (seat.getStatus() == 2) {
                seatClass = "et-sit-bought"; // Ghế đã bán
            }%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" data-seat-number="<%=i%>" data-seat-price="<%=seatPrice%>">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center <%=seatClass%>" >
                             <div class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span> 
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>
                    </div>
                </div>
            </div>
            <%}
           }%>
            <%}%>
        </div>
        <div class="et-col-1-18 et-car-floor-full-height"></div>

    </div></div>
    <div class="et-col-5"><div class="et-car-next-floor text-center" ng-click="nextCar()">&gt;</div></div>

