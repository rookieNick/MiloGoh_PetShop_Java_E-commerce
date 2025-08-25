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
<%
    // Retrieve the account object from the session
    Account accounts = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Manage Item</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminTable.css" />

        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="manageItemPage">
        <%@include file="managerNavBar.jsp" %>


        <div class="body-content">

            <section class="content" id="salesReport">
                <%
                    ArrayList<Product> filterProductList = (ArrayList<Product>) session.getAttribute("filterProductList");
                    session.removeAttribute("filterProductList");
                    ArrayList<Product> productRecords = null;

                    if (filterProductList != null) {
                        productRecords = filterProductList;
                    } else {
                        // Create an instance of MaintainAccountControl
                        MaintainProductControl productControl = new MaintainProductControl();

                        // Call the method to retrieve all product records
                        productRecords = productControl.getAllProducts("", "", "");
                    }

                    // Check if there are any product records
                    if (productRecords != null && !productRecords.isEmpty()) {
                %>
                <div class="table-container">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <td>Product ID</td>
                                    <td>Name</td>
                                    <td>Description</td>
                                    <td>Type</td>
                                    <td>Categ</td>
                                    <td>Qty</td>
                                    <td>Unit Price</td>
                                    <td>Status</td>
                                    <td>Created Time</td>
                                    <td>Updated Time</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
   //                                     MaintainStockControl stockControl = new MaintainStockControl();
                                    MaintainImageControl imageControl = new MaintainImageControl();
   //                                        Stock stock = new Stock();
                                    Image image = new Image();
                                    for (Product product : productRecords) {
   //                                            stock = stockControl.selectStockByProductId(product.getId());
   //                                            int qty = stock.getQty();

                                        //function to format wallet value
                                        double price = product.getUnitPrice();
                                        String status = "";
                                        if (product.isActive() == true) {
                                        status = "Active";
                                    } else {
                                    status = "Inactive";
                                    }

                                %>

                                <tr>
                                    <td><a href="productProfile.jsp?id=<%= product.getId()%>" class="tableHref"><%= product.getId()%></a></td>
                                    <td><%= product.getName()%></td>
                                    <td><%= product.getDescription()%></td>
                                    <td><%= product.getType()%></td>
                                    <td><%= product.getCategory()%></td>
                                    <td><%= product.getStockQty()%></td>
                                    <td>RM <%=product.rmFormat(price)%></td>
                                    <td><%= status %></td>
                                    <td><%= product.getCreatedDate()%></td>
                                    <td><%= product.getCreatedDate()%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                <p>No product records found.</p>
                <%
                    }
                %>
            </section>
        </div>
        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>
