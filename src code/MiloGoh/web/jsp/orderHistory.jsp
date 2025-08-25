<%@page import="control.MaintainPaymentControl"%>
<%@page import="domain.Product"%>
<%@page import="control.MaintainProductControl"%>
<%@page import="domain.Order"%>
<%@page import="control.MaintainOrderControl"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${companyName} | Order History</title>
        <link rel="stylesheet" href="../css/orderHistory.css"/>
        <%@ include file="header.jsp" %>
    </head>
    <%
        if (account.getPosition().equals("Guest")) {
            response.sendRedirect("onlyCustomer.jsp");
            return;
        }
    %>
    <section class="h-100 gradient-custom">
        <div class="container py-5">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5>Order History</h5>
                        </div>
                        <div class="card-body">
                            <% MaintainOrderControl orderControl = new MaintainOrderControl(); %>
                            <% MaintainPaymentControl paymentControl = new MaintainPaymentControl(); %>
                            <% ArrayList<Order> orderList = orderControl.getOrdersByAccountId(account.getAccountID()); %>
                            <% ArrayList<Integer> indexListToRemove = new ArrayList<Integer>(); %>
                            <% //int orderId = orderList.get(0).getOrderId(); %>
                            <% //ArrayList<Double> totalPrices = new ArrayList<Double>(); %>
                            <% int index = 0; %>
                            <%
                                Product formatter = new Product();
                                double subtotal = 0.0;
                                int orderId = 0;
                                String status = "";
                            %>
                            <%                                if (orderList != null && !orderList.isEmpty()) {
                                    for (Order order : orderList) {
                                        status = "";
                                        subtotal = 0.0;

                                        status = order.getStatus();
                                        if (order.getOrderId() != orderId) {

                                            orderId = order.getOrderId();

                                            //loop to calculate subtotal
                                            for (Order order2 : orderList) {
                                                if (order2.getOrderId() == orderId) {

                                                    MaintainProductControl prodControl = new MaintainProductControl();
                                                    Product product = prodControl.selectProductById(order2.getProductId());
                                                    subtotal += order2.getProductQty() * product.getUnitPrice();
                                                }
                                            }

                            %>
                            <div class="row my-4 py-3 border">
                                <div class="col-lg-3 align-items-center">
                                    <p>Order ID : <%=orderId%></p>
                                </div>
                                <div class="col-lg-4 align-items-center">
                                    <% if (status.equals("Unpaid")) { %>
                                    <% if (promotion.getPromotionid() > 0) {%>
                                    <p>Total Payment : RM <%=formatter.rmFormat(subtotal * (100 - promotion.getDiscount()) / 100)%></p>
                                    <% } else {%>
                                    <p>Total Payment : RM <%=formatter.rmFormat(subtotal)%></p>
                                    <% } %>
                                    <% } %>
                                    <% if (status.equals("Paid")) {%>
                                    <p>Total Payment : RM <%=paymentControl.getRecordByOrderId(orderId).getTotalPayment()%></p>
                                    <% } %>
                                </div>
                                <div class="col-lg-3 align-items-center d-flex justify-content-center">
                                    <% if (status.equals("Unpaid")) {%>
                                    <button type="button" class="btn btn-danger w-50" disabled><%=status%></button>
                                    <% } else if (status.equals("Paid")) {%>
                                    <button type="button" class="btn btn-success w-50" disabled><%=status%></button>
                                    <% }%>
                                </div>
                                <div class="col-lg-2 align-items-center">
                                    <a class="btn btn-primary" href="orderDetails.jsp?orderId=<%=orderId%>">View Details</a>
                                </div>
                                <div class="col-lg-12 align-items-center">
                                    <p>Shipping Address : <%=order.getShippingAddress()%></p>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            } else { %>
                            <p>No orders found.</p>
                            <% }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="footer.jsp" %>
</html>
