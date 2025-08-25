<%@page import="domain.Order"%>
<%@page import="control.MaintainOrderControl"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="domain.Image"%>
<%@page import="control.MaintainImageControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product"%>
<%@page import="control.MaintainProductControl"%>
<%@page import="control.MaintainAccountControl"%>
<%@page import="domain.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Manage Customer Order</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminTable.css" />

        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="manageCustomerOrderPage">
        <%@include file="managerNavBar.jsp" %>
<%
    // Retrieve the account object from the session
    Account account = (Account) session.getAttribute("account");
    int accountID = account.getAccountID();
%>

        <div class="body-content">

            <section class="content" id="salesReport">
                <%
                    ArrayList<Order> filterOrderList = (ArrayList<Order>) session.getAttribute("filterOrderList");
                    session.removeAttribute("filterOrderList");
                    ArrayList<Order> orderRecords = null;
                    
                    if(filterOrderList != null){
                        orderRecords = filterOrderList;
                    }
                    else{
                        MaintainOrderControl orderControl = new MaintainOrderControl();

                        orderRecords = orderControl.getAllOrders();
                    }
                    if (orderRecords != null && !orderRecords.isEmpty()) {
                %>
                <div class="table-container">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <td>Order ID</td>
                                    <td>Status</td>
                                    <td>Product ID</td>
                                    <td>Qty</td>
                                    <td>Unit Price</td>
                                    <td>Customer ID</td>
                                    <td>Customer name</td>
                                    <td>Order Date</td>
                                    <td>Completion Date</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    //if (orderRecords != null && !orderRecords.isEmpty()) {
                                    for (Order order : orderRecords) {

                                        MaintainProductControl prodControl = new MaintainProductControl();
                                        Product product = prodControl.selectProductById(order.getProductId());

                                        MaintainAccountControl accControl = new MaintainAccountControl();
                                        Account cusAccount = accControl.selectRecord(String.valueOf(order.getAccountId()));
                                %>

                                <tr>
                                    <td><a href="orderProfile.jsp?orderID=<%= order.getOrderId()%>" class="tableHref"><%= order.getOrderId()%></a></td>
                                    <td><%= order.getStatus() %></td>
                                    <td><%= product.getId() %></td>
                                    <td><%= order.getProductQty() %></td>
                                    <td><%= product.getUnitPrice() %></td>
                                    <td><%= cusAccount.getAccountID()%></td>
                                    <td><%= cusAccount.getFirstName() + " " + cusAccount.getLastName() %></td>
                                    <td><%= order.getOrderDate() %></td>
                                    <td><%= order.getCompletionDate() %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                <p>No order records found.</p>
                <%
                    }
                %>
            </section>
        </div>
        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>
