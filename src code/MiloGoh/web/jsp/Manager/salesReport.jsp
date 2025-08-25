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
        <title>${companyName} | Sales Report</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminTable.css" />

        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body id="salesReportPage">
        <%@include file="managerNavBar.jsp" %>
<%
    // Retrieve the account object from the session
    Account account = (Account) session.getAttribute("account");
    int accountID = account.getAccountID();
%>

        <div class="body-content">

            <section class="content" id="salesReport">
                <%
                    //get orderRecords
                    ArrayList<Order> filterOrderList = (ArrayList<Order>) session.getAttribute("filterOrderList");
                    //session.removeAttribute("filterOrderList");
                    ArrayList<Order> orderRecords = null;
                    String filterOrderBy = (String) session.getAttribute("filterSelection");
                    if(filterOrderList != null){
                        orderRecords = filterOrderList;
                    }
                    else{
                        MaintainOrderControl orderControl = new MaintainOrderControl();

                        orderRecords = orderControl.getOrdersByStatus("Paid");
                    }
                    if (orderRecords != null && !orderRecords.isEmpty()) {
                %>
                <div class="table-container">
                    <div class="table-wrapper">
                        <table>
                            <caption>TOP <b>10</b> of Sales Product</caption>
                            <thead>
                                <tr>
                                    <td>Rank</td>
                                    <td>Product ID</td>
                                    <td>Name</td>
                                    <td>Type</td>
                                    <td>Category</td>
                                    <td>Total Ordered Time</td>
                                    <td>Total Qty</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<Integer> checkedProductIds = new ArrayList<Integer>();
                                    ArrayList<Product> productList = new ArrayList<Product>();
                                    ArrayList<Integer> qtyList = new ArrayList<Integer>();
                                    ArrayList<Integer> orderTimeList = new ArrayList<Integer>();
                                    for (Order order : orderRecords) {
                                        
                                        int productId = order.getProductId();
                                        MaintainProductControl prodControl = new MaintainProductControl();
                                        Product product = prodControl.selectProductById(order.getProductId());
                                        if (!checkedProductIds.contains(productId)) {
                                            int totalQuantity = 0; //initialize total quantity
                                            int totalOrderTime = 0;
                                            for (Order o : orderRecords) {
                                                if (o.getProductId() == productId) {
                                                    totalQuantity += o.getProductQty();
                                                    totalOrderTime++;
                                                }
                                            }
                                            qtyList.add(totalQuantity);
                                            checkedProductIds.add(productId);
                                            productList.add(product);
                                            orderTimeList.add(totalOrderTime);
                                        }
                                    }
                                    //reareange
                                    //filterOrderBy is TotalOrderedTime or TotalQty
                                    
                                    for(int i=0; i<checkedProductIds.size() - 1; i++){
                                        for(int j=i+1; j<checkedProductIds.size(); j++){
                                            int qty1 = 0, qty2 = 0;

                                            if(filterOrderBy == null){
                                                filterOrderBy = "TotalQty";
                                            }
                                            //check is order by what data
                                            if(filterOrderBy.equals("TotalQty")){
                                                qty1 = qtyList.get(i);
                                                qty2 = qtyList.get(j);                                    
                                            }
                                            else if(filterOrderBy.equals("TotalOrderedTime")){
                                                qty1 = orderTimeList.get(i);
                                                qty2 = orderTimeList.get(j);  
                                            }
                                            else{
                                                qty1 = qtyList.get(i);
                                                qty2 = qtyList.get(j);
                                            }
                                        

                                            if(qty1 < qty2){
                                                //reareange productList
                                                Product temp = productList.get(i);
                                                productList.set(i, productList.get(j));
                                                productList.set(j, temp);
                                                //reareange qtyList
                                                int temp2 = qtyList.get(i);
                                                qtyList.set(i, qtyList.get(j));
                                                qtyList.set(j, temp2);
                                                //reareange OrderTimeList
                                                int temp3 = orderTimeList.get(i);
                                                orderTimeList.set(i, orderTimeList.get(j));
                                                orderTimeList.set(j, temp3);
                                            }
                                            else if(qty1 == qty2){
                                                //check the othe column and rearrange
                                                if(filterOrderBy != null){
                                                    if(filterOrderBy.equals("TotalQty")){
                                                        qty1 = orderTimeList.get(i);
                                                        qty2 = orderTimeList.get(j);                                    
                                                    }
                                                    else if(filterOrderBy.equals("TotalOrderedTime")){
                                                        qty1 = qtyList.get(i);
                                                        qty2 = qtyList.get(j);  
                                                    }
                                                }
                                                
                                                if(qty1 < qty2){
                                                    //reareange productList
                                                    Product temp = productList.get(i);
                                                    productList.set(i, productList.get(j));
                                                    productList.set(j, temp);
                                                    //reareange qtyList
                                                    int temp2 = qtyList.get(i);
                                                    qtyList.set(i, qtyList.get(j));
                                                    qtyList.set(j, temp2);
                                                    //reareange OrderTimeList
                                                    int temp3 = orderTimeList.get(i);
                                                    orderTimeList.set(i, orderTimeList.get(j));
                                                    orderTimeList.set(j, temp3);
                                                }
                                                
                                            }
                                        }
                                    }
                                %>
                                
                                <% for(int i = 0; i < productList.size(); i++) { 
                                    Product product = productList.get(i);
                                    int totalQuantity = qtyList.get(i);
                                    int totalOrderTime = orderTimeList.get(i);
                                %>
                                        <tr>
                                            <td><%= i+1 %></td>
                                            <td><%= product.getId() %></td>
                                            <td><%= product.getName()%></td>
                                            <td><%= product.getType()%></td>
                                            <td><%= product.getCategory()%></td>
                                            <td><%= totalOrderTime %></td>
                                            <td><%= totalQuantity %></td>
                                        </tr>   
                                <% if(i == 9){
                                     break;
                                    }
                                    
                                    } %>    
                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                <p>No sales records found.</p>
                <%
                    }
                %>
            </section>
        </div>
        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>
