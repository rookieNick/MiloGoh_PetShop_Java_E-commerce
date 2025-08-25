
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="domain.Account" %>
<%@ page import="control.MaintainAccountControl" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${companyName} | Manage Customer</title>
    <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
    <!-- CSS -->
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../css/staffStyle.css" />
    <link rel="stylesheet" href="../../css/adminTable.css" />
    <!-- Boxicons CSS -->


</head>
<body id="manageCustomerPage">
    <%@include file="managerNavBar.jsp" %>
    <%@include file="statusFilter.jsp" %>

        <div class="body-content">
<!--            <section class="content" id="manageCustomer">
            <div class="manageHead">
                <a href="addCustomer.jsp" class="nav-link" >
                    <i class="bx bx-plus-circle icon"></i>
                    <span class="link">Add Customer</span>
                </a>
            </div>
            </section>-->

            <section class="content">
                <%
                    ArrayList<Account> filterAccountList = (ArrayList<Account>) session.getAttribute("filterAccountList");
                    session.removeAttribute("filterAccountList");
                    ArrayList<Account> customerRecords = null;
                    
                    if(filterAccountList != null){
                        customerRecords = filterAccountList;
                    }
                    else{
                        // Create an instance of MaintainAccountControl
                        MaintainAccountControl accountControl = new MaintainAccountControl();

                        // Call the method to retrieve all staff records
                        customerRecords = accountControl.getAllCertainRecords("Customer");                    
                    }
                    
                    // Check if there are any customer records
                    if (customerRecords != null && !customerRecords.isEmpty()) {
                %>


                <div class="table-container">
                    <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <td>Customer ID</td>
                                <td>Name</td>
                                <td>Email</td>
                                <td>Phone Number</td>
                                <td>Gender</td>
                                <td>Address</td>
                                <td>IC</td>
                                <td>Username</td>
                                <td>Status</td>
                                <td>Wallet</td>

                            </tr>
                        </thead>
                        <tbody>
                            <% for (Account customer : customerRecords) {
                            
                            //function to format wallet value
                            String formattedWallet = String.format("%.2f", customer.getWallet());
                            //display "0" if wallet value is 0
                            if (customer.getWallet() == 0) {
                                formattedWallet = "0";
                            }
                            %>
                            
                            <tr>
                                <td><a href="../profile.jsp?id=<%= customer.getAccountID()%>" class="tableHref"><%= customer.getAccountID()%></a></td>
                                <td><%= customer.getFirstName()%> <%= customer.getLastName()%></td>
                                <td><%= customer.getGmail()%></td>
                                <td><%= customer.getPhoneNumber()%></td>
                                <td><%= customer.getGender()%></td>
                                <td><%= customer.getAddress()%></td>
                                <td><%= customer.getIc()%></td>
                                <td><%= customer.getUsername()%></td>
                                <td><%= customer.getStatus()%></td>
                                <td>RM <%= formattedWallet%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                </div>
                <%
                } else {
                %>
                <p>No customer records found.</p>
                <%
                    }
                %>
            </section>

        </div>

  <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>

