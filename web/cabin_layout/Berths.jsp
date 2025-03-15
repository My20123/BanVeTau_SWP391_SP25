<%-- 
    Document   : Bn__LM-Bn__L
    Created on : Mar 8, 2025, 12:49:28 AM
    Author     : tra my
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Cho các toa có dạng ^(A|B)n\d{2}L(V)?$-->



<% int cabinNumber=Integer.parseInt(request.getParameter("cabinNumber"));//Số cabin%> 
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
        <%
            int totalSeats = Integer.parseInt(request.getParameter("total")); // Tổng số ghế
            int berthsInRoom = Integer.parseInt(request.getParameter("room")); // Loại cabin A thì số ghế trong 1 khoang là 4, loại cabin B thì số ghế trong 1 khoang là 6
        %>  
        <div class="et-col-1-18 et-car-floor-full-height" ng-class="{'et-hidden': !seatMap[0].Status}">
            <div class="et-bed-way et-full-width"></div>
            <% for (int i = 1; i <= berthsInRoom / 2; i++) {%> 
            <div class="et-bed-way et-full-width text-center small ng-binding">T<%= i%></div>
            <% }%> 
        </div>
        <div class="et-col-8-9">
            <div class="et-bed-way et-full-width et-text-sm">
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[0].Status}">Khoang 1</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[6].Status}">Khoang 2</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[12].Status}">Khoang 3</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[18].Status}">Khoang 4</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[24].Status}">Khoang 5</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[30].Status}">Khoang 6</div>
                <div class="et-col-1-8 text-center ng-binding" ng-class="{'et-hidden': !seatMap[36].Status}">Khoang 7</div>
                <div class="et-col-1-8 text-center ng-binding et-hidden" ng-class="{'et-hidden': !seatMap[28].Status}">Khoang 8</div>
                <%for (int i = 1; i <= totalSeats; i++) {
                    if (i % berthsInRoom == 0) {%>
                <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-right="" seat="seatMap[5]" direct="direct"><div class="et-bed-right" >
                        <div class="et-bed-outer">
                            <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>
                    </div>
                </div>
            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 1) {%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-left="" seat="seatMap[4]" direct="direct">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
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
               if (i % berthsInRoom == berthsInRoom - 2) {%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-right="" seat="seatMap[5]" direct="direct"><div class="et-bed-right" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>

                    </div>

                </div>

            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 3) {%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-left="" seat="seatMap[4]" direct="direct">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
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
                if (i % berthsInRoom == berthsInRoom - 4) {%>
            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-right="" seat="seatMap[5]" direct="direct"><div class="et-bed-right" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
                                <span  class="ng-binding"><%=i%></span>
                                <img src="/images/loading51.gif"  class="ng-hide">
                            </div>
                        </div>
                        <div class="et-bed-illu"></div>

                    </div>

                </div>

            </div>
            <% }
           if (i % berthsInRoom == berthsInRoom - 5) {%>

            <div class="et-col-1-16 et-seat-h-35 ng-isolate-scope" et-bed-left="" seat="seatMap[4]" direct="direct">
                <div class="et-bed-left" >
                    <div class="et-bed-outer">
                        <div class="et-bed text-center et-sit-bought" analytics-on="click" analytics-event="SelectTicket" ng-click="buyTicket(seat, direct)" ng-class="{'et-sit-booked': seat.Status.Status == 2,'et-sit-bought': seat.Status.Status == 1, 'et-sit-longer': seat.Status.Status == 5, 'can-buy': seat.Status.Status == 5 & amp; & amp; seat.detail.fee > 0, 'et-sit-blocked': seat.Status.Status == 4 & amp; & amp; (!seat.Status.LyDo || seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') == -1), 'et-sit-avaiable': seat.Status.Status == 3, 'et-sit-buying': seat.Status.Status == 6, 'et-sit-distancing': seat.Status.Status == 4 & amp; & amp; seat.Status.LyDo & amp; & amp; seat.Status.LyDo.toLowerCase().indexOf('chỗ giãn cách') != -1}">
                            <div data-popover="Chỗ đã bán" data-popover-title="Chỗ đã bán" data-popover-trigger="mouseenter" data-popover-placement="top" class="et-sit-no ng-scope">
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

