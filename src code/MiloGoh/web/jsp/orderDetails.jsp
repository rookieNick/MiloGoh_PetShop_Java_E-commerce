<%@page import="domain.*" %>
<%@page import="control.*" %>
<%@page import="java.util.Base64"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${companyName} | Order Details</title>
        <%@ include file="header.jsp" %>

    </head>
    <%
        if (account.getPosition().equals("Guest")) {
            response.sendRedirect("onlyCustomer.jsp");
            return;
        }
    %>
    <% //int orderId = Integer.parseInt(request.getParameter("orderId"));%>
    <% //MaintainOrderControl orderControl = new MaintainOrderControl(); %>
    <% //ArrayList<Order> orderList = orderControl.getOrdersByOrderId(orderId); %>
    <% //double totalPrice = orderControl.orderTotalPrice(orderList);%>
    <%
        Product formatter = new Product();
        String orderIDString = request.getParameter("orderId");

        double productSubtotal = 0.0;
        double subtotal = 0.0;
        double shippingFee = 25.00;
        double totalAmount = 0.0;
        double sstRate = 0.06; // SST rate (6%)
        double sstAmount = 0.0; // Calculate SST amount
        double discount = 0.0;

        String orderDate = "";

        String enoughStock = "";
        String status = "";

        if (orderIDString != null && !orderIDString.isEmpty()) {
            int orderIDForDate = Integer.parseInt(orderIDString);
            MaintainOrderControl orderControlForDate = new MaintainOrderControl();

            ArrayList<Order> orderRecordsForDate = orderControlForDate.getOrdersByOrderId(orderIDForDate);
            if (orderRecordsForDate != null && !orderRecordsForDate.isEmpty()) {
                orderDate = orderRecordsForDate.get(0).getOrderDate();
            }

        }

    %>
    <section class="h-100 gradient-custom">
        <div class="container py-5">
            <div class="row d-flex justify-content-center my-4">
                <div class="col-md-12 card"  style="border-radius: 10px;">
                    <div class="card mb-4" style="margin: 10px;">
                        <div class="card-header py-3">
                            <h5 class="mb-0">Order Details</h5>
                        </div>
                        <div class="row d-flex justify-content-center align-items-center h-100">
                            <div class="card" style="border:none">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <p class="lead fw-normal mb-0" style="color: #a8729a;">Order ID: <%=orderIDString%></p>

                                        <p class="small text-muted mb-0">Order Date : <%=orderDate%></p>
                                    </div>
                                    <%                    if (orderIDString != null && !orderIDString.isEmpty()) {
                                            int orderID = Integer.parseInt(orderIDString);
                                            MaintainOrderControl orderControl = new MaintainOrderControl();

                                            ArrayList<Order> orderRecords = orderControl.getOrdersByOrderId(orderID);

                                            if (orderRecords != null && !orderRecords.isEmpty()) {
                                                for (Order order : orderRecords) {

                                                    MaintainProductControl prodControl = new MaintainProductControl();
                                                    Product product = prodControl.selectProductById(order.getProductId());

                                                    int imageId = product.getImage().getId();
                                                    MaintainImageControl imageControl = new MaintainImageControl();
                                                    Image image = imageControl.selectImageById(imageId);

                                                    byte[] imageData = image.getImage1(); // Assuming the image data is stored in the getImage1() method
                                                    // Convert the byte array to a Base64-encoded string
                                                    String base64Image = Base64.getEncoder().encodeToString(imageData);

                                                    //calculate subtotal to determine shipping fee
                                                    if (promotion.getPromotionid() > 0) {
                                                        productSubtotal = order.getProductQty() * product.getUnitPrice() * (100 - promotion.getDiscount()) / 100;
                                                        subtotal += order.getProductQty() * product.getUnitPrice() * (100 - promotion.getDiscount()) / 100;
                                                    } else {
                                                        productSubtotal = order.getProductQty() * product.getUnitPrice();
                                                        subtotal += order.getProductQty() * product.getUnitPrice();
                                                    }

                                                    if (subtotal > 200) {
                                                        shippingFee = 0;
                                                    }

                                                    if (order.getProductQty() > product.getStockQty()) {
                                                        enoughStock = "no";
                                                    }
                                                    if (order.getStatus().equals("Paid")) {
                                                        status = "Paid";
                                                    }
                                    %>
                                    <div class="card shadow-0 border mb-4">
                                        <div class="card-body">
                                            <div class="row d-flex align-items-center">
                                                <div class="col-md-2">
                                                    <p class="text-muted mb-0 small">Product ID: <%=order.getProductId()%></p>
                                                </div>
                                            </div>            
                                            <hr class="mb-4" style="background-color: #e0e0e0; opacity: 1;">

                                            <div class="row">
                                                <div class="col-md-2">
                                                    <img src="data:image/jpeg;base64, <%= base64Image%>"
                                                         class="img-fluid" alt="<%=product.getName()%>">
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0"><%=product.getName()%></p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small">Qty: <%=order.getProductQty()%></p>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <% if (promotion.getPromotionid() > 0) {%>
                                                    <p class="text-muted mb-0 small">Unit Price: RM <%=formatter.rmFormat(product.getUnitPrice() * (100 - promotion.getDiscount()) / 100)%></p>
                                                    <% } else {%>
                                                    <p class="text-muted mb-0 small">Unit Price: RM <%=formatter.rmFormat(product.getUnitPrice())%></p>
                                                    <% } %>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <% if (promotion.getPromotionid() > 0) {%>
                                                    <p class="text-muted mb-0 small">Discount: RM <%=formatter.rmFormat(productSubtotal * promotion.getDiscount() / 100)%></p>
                                                    <% } else { %>
                                                    <p class="text-muted mb-0 small">Discount: RM 0</p>
                                                    <% }%>
                                                </div>
                                                <div class="col-md-2 text-center d-flex justify-content-center align-items-center">
                                                    <p class="text-muted mb-0 small">Subtotal: RM <%=formatter.rmFormat(productSubtotal)%></p>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                    <%
                                                }
                                            }
                                        }
                                    %> 
                                    <%
                                        //round up to 2 digits using math round * 100.0 and / 100.0
                                        sstAmount = Math.round((subtotal * sstRate) * 100.0) / 100.0;
                                        // Calculate total amount including shipping fee
                                        totalAmount = Math.round((subtotal + shippingFee + sstAmount) * 100.0) / 100.0;

                                    %>


                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="text-muted mb-0">Shipping Fee</p>
                                        <p class="text-muted mb-0"><span class="fw-bold me-4"></span> RM <%= formatter.rmFormat(shippingFee)%></p>
                                    </div>

                                    <div class="d-flex justify-content-between">
                                        <p class="text-muted mb-0">SST 6%</p>
                                        <p class="text-muted mb-0"><span class="fw-bold me-4"></span> RM <%= formatter.rmFormat(sstAmount)%></p>
                                    </div>
                                    <div class="d-flex justify-content-between pt-2">
                                        <p class="fw-bold mb-0">Total</p>
                                        <p class="text-muted mb-0"><span class="fw-bold me-4"></span>RM <%=formatter.rmFormat(totalAmount)%></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form action="your_action_url" method="post" class="d-flex justify-content-end">
                        <% if (status.equals("Paid")) { %>
                        <input type="submit" class="btn btn-primary" value="You have already paid" style="width:200px;" disabled/>
                        <% } else if (enoughStock.equals("no")) { %>
                        <input type="submit" class="btn btn-primary" value="Out of stock" style="width:150px;" disabled/>
                        <% } else {%>
                        <a class="btn btn-primary" href="payment.jsp?orderID=<%=orderIDString%>" style="color: white;">Pay</a>
                        <% }%>
                    </form>
                </div>
                <!--                <div class="col-md-3">
                                </div>-->
            </div>
        </div>
    </section>
    <%@ include file="footer.jsp" %>
</html>
