<%@page import="java.util.ArrayList"%>
<%@page import="domain.Promotion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%--<jsp:useBean id="promo" class="domain.Promotion" scope="session"/>--%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Manage Promotion</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminTable.css" />
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="manageStaffPage">
        <%@include file="managerNavBar.jsp" %>
        <% List<Promotion> promoList = (List) session.getAttribute("promoList"); %>

        <div class="body-content">
            <section class="content">
                <% if (!promoList.isEmpty()) { %>
                <div class="table-container">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <td>Promo ID</td>
                                    <td>Description</td>
                                    <td>Discount</td>
                                    <td>Valid Date</td>
                                    <td>Status</td>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Promotion p : promoList) {%>

                                <tr>
                                    <td><a href="../../viewPromotionDetail?id=<%= p.getPromotionid()%>" class="tableHref"><%= p.getPromotionid()%></a></td>
                                    <td><%=p.getDescription()%></td>
                                    <td><%=p.getDiscount()%></td>
                                    <td><%=p.getValiddate()%></td>
                                    <% if(p.getStatus()){ %>
                                    <!--<td><%=p.getStatus()%></td>-->
                                    <td class="align-items-center"><button type="button" class="btn-primary" disabled>Active</button></td>
                                    <% } else { %>
                                    <td> - </td>
                                    <% } %>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                <p>No promotion records found.</p>
                <%
                    }
                %>
            </section>

        </div>


        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>

