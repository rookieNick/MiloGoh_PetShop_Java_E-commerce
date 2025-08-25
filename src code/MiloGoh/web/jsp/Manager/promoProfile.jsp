<%@page import="domain.Promotion"%>
<!DOCTYPE html>
<html lang="en">
    <% Promotion promotion = (Promotion) session.getAttribute("promotionDetails"); %>

    <%        String status = "";
        if (promotion.getStatus()) {
            status = "Active";
        } else {
            status = "Inactive";
        }

        String success = (String) request.getParameter("success");
    %>
    <head>
        <meta charset="utf-8">


        <title>${companyName} | Promotion Details</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />

        <link href="../../css/staffStyle.css" rel="stylesheet">
        <link href="../../css/addItem.css" rel="stylesheet">
        

    </head>
    <body>
        <%@include file="managerNavBar.jsp" %>

        <form action="../../managePromotion" method="post" id="itemProfileForm">
        <!--<form action="../../managePromotion?id=<%=promotion.getPromotionid() %>" method="post" enctype="multipart/form-data" id="itemProfileForm">-->
            <div class="container" id="itemProfileContainer">
                <div class="row gutters">
                    <div class="card-body" id="itemProfileCardBody">
                        <div class="row gutters">
                            <div class="col-12">
                                <h6 class="mb-2 text-primary">Edit Promotion</h6>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="id">Promotion ID</label>
                                    <input type="number" class="form-control" id="id" name="id" value="<%=promotion.getPromotionid() %>" readonly>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <input type="text" class="form-control" id="description" name="description" required value="<%=promotion.getDescription() %>">
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="discount">Discount Percentage</label>
                                    <input type="number" step="1" min="1" max="99" class="form-control" id="discount" name="discount" required value="<%=promotion.getDiscount()%>">
                                </div>
                            </div>
                            <div class="col-9">
                                <div class="form-group">
                                    <label for="validdate">Valid Date</label>
                                    <input type="date" class="form-control" id="validdate" name="validdate" required value="<%=promotion.getValiddate() %>">
                                </div>
                            </div>

                        </div>
                        <% if (success != null && success.equals("1")) { %>
                        <div class="form-link">
                            <span style="color:greenyellow">Item updated successfully!</span>
                        </div>
                        <% }%>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">
                                    <input type="submit" id="deleteBtn" name="deleteBtn" class="btn btn-danger" value="Delete"/>
                                    <input type="submit" id="updateBtn" name="updateBtn" class="btn btn-primary" value="Update"/>
                                    <%
                                        if (promotion.getStatus()) {
                                    %>
                                    <input type="submit" id="deactivateBtn" name="deactivateBtn" class="btn btn-danger" value="Deactivate"/>
                                    <%
                                    } else {
                                    %>
                                    <input type="submit" id="activateBtn" name="activateBtn" class="btn btn-success" value="Activate"/>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>