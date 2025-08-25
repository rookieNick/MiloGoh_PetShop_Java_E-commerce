
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="domain.Account" %>
<%@ page import="control.MaintainAccountControl" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Manage Staff</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminTable.css" />
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="manageStaffPage">
        <%@include file="managerNavBar.jsp" %>


        <div class="body-content">
            <section class="content">
                <%
                    ArrayList<Account> filterAccountList = (ArrayList<Account>) session.getAttribute("filterAccountList");
                    session.removeAttribute("filterAccountList");
                    ArrayList<Account> staffRecords = null;

                    if (filterAccountList != null) {
                        staffRecords = filterAccountList;
                    } else {
                        // Create an instance of MaintainAccountControl
                        MaintainAccountControl accountControl = new MaintainAccountControl();

                        // Call the method to retrieve all staff records
                        staffRecords = accountControl.getAllCertainRecords("Staff");
                    }

                    // Check if there are any staff records
                    if (staffRecords != null && !staffRecords.isEmpty()) {
                %>


                <div class="table-container">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <td>Staff ID</td>
                                    <td>Name</td>
                                    <td>Email</td>
                                    <td>Phone Number</td>
                                    <td>Gender</td>
                                    <td>IC</td>
                                    <td>Username</td>
                                    <td>Status</td>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Account staff : staffRecords) {%>

                                <tr>
                                    <td><a href="../profile.jsp?id=<%= staff.getAccountID()%>" class="tableHref"><%= staff.getAccountID()%></a></td>
                                        <% if (staff.getPhoneNumber() == null) {%>
                                    <td>unset</td>
                                    <% } else {%>
                                    <td><%= staff.getFirstName()%> <%= staff.getLastName()%></td>
                                    <%}%>

                                    <td><%= staff.getGmail()%></td>

                                    <% if (staff.getPhoneNumber() == null) {%>
                                    <td>unset</td>
                                    <td>unset</td>
                                    <% } else {%>
                                    <td><%= staff.getPhoneNumber()%></td>
                                    <td><%= staff.getGender()%></td>
                                    <%}%>

                                    <%if (staff.getIc() == null) {%>
                                    <td>unset</td>
                                    <% } else {%>
                                    <td><%= staff.getIc()%></td>
                                    <%}%>

                                    <%if (staff.getUsername() == null) {%>
                                    <td>unset</td>
                                    <% } else {%>
                                    <td><%= staff.getUsername()%></td>
                                    <%}%>

                                    <td><%= staff.getStatus()%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                <p>No staff records found.</p>
                <%
                    }
                %>
            </section>

        </div>


        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>

