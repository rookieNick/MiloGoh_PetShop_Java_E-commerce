<%@page import="domain.Image"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Product" %>
    <%@ page import="control.*" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%
        Product product = (Product) session.getAttribute("product");

        int id = 0;
        String name = "";
        String description = "";
        double unitPrice = 0.0;
        String type = "";
        String createdDate = "";
        String updatedDate = "";
        String updatedBy = "";
        String createdBy = "";
        boolean isActive = false;
        String category = "";
        Image image = null;
        int stockQty = 0;

        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            String productID = request.getParameter("id");
            MaintainProductControl productControl = new MaintainProductControl();
            product = productControl.selectProductById(Integer.parseInt(productID));

            id = product.getId();
            name = product.getName();
            description = product.getDescription();
            unitPrice = product.getUnitPrice();
            type = product.getType();
            category = product.getCategory();
            isActive = product.isActive();
            image = product.getImage();
            stockQty = product.getStockQty();
            createdDate = product.getCreatedDate();
            updatedDate = product.getUpdatedDate();
            createdBy = product.getCreatedBy();
            updatedBy = product.getUpdatedBy();

        } else if (product != null) {
            id = product.getId();
            name = product.getName();
            description = product.getDescription();
            unitPrice = product.getUnitPrice();
            type = product.getType();
            category = product.getCategory();
            isActive = product.isActive();
            image = product.getImage();
            stockQty = product.getStockQty();
            createdDate = product.getCreatedDate();
            updatedDate = product.getUpdatedDate();
            createdBy = product.getCreatedBy();
            updatedBy = product.getUpdatedBy();

            // Clear product data from session
            session.removeAttribute("product");
        }

    %>

    <%        String status = "";
        if (isActive) {
            status = "Active";
        } else {
            status = "Inactive";
        }

        String success = (String) request.getParameter("success");
        String errorMsgProduct = (String) session.getAttribute("errorMsgProduct");

        session.removeAttribute("errorMsgProduct");
    %>
    <head>
        <meta charset="utf-8">


        <title>${companyName} | Product Details</title>
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

        <form action="../../ManageItemServlet" method="post" enctype="multipart/form-data" id="itemProfileForm">
            <div class="container" id="itemProfileContainer">
                <div class="row gutters">
                    <div class="card-body" id="itemProfileCardBody">
                        <div class="row gutters">
                            <% if (errorMsgProduct != null && !errorMsgProduct.equals("")) { %>
                            <div class="col-12">
                                <h5 class="mb-2" style="color:red">Error! Failed to update item</h5>
                                <% String[] errorMessages = errorMsgProduct.split("\n");
                                    int index = 1;
                                    for (String message : errorMessages) {%>
                                <h6 class="mb-2" style="color:red"><%=index++%>. <%= message%></h6>
                                <% } %>
                            </div>
                            <% }
                                session.removeAttribute("errorMsgProduct");
                            %>
                            <div class="col-xl-12">
                                <h6 class="mb-2 text-primary">Product Details</h6>
                            </div>
                            <div class="col-xl-6">
                                <div class="form-group">
                                    <label for="name">Product ID</label>
                                    <input type="text" class="form-control" id="id" name="id" value="<%=id%>" readonly>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" required value="<%=name%>">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <input type="text" class="form-control" id="description" name="description" required value="<%=description%>">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="unitPrice">Unit Price</label>
                                    <input type="number" step="0.01" min="0.01" class="form-control" id="unitPrice" name="unitPrice" required value="<%=unitPrice%>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="type">Type</label>
                                    <select class="form-control" id="type" name="type" required>
                                        <option value="Food" <%= type.equals("Food") ? "selected" : ""%>>Food</option>
                                        <option value="Accessories" <%= type.equals("Accessories") ? "selected" : ""%>>Accessories</option>
                                        <option value="Bed" <%= type.equals("Bed") ? "selected" : ""%>>Bed</option>
                                        <option value="Other" <%= type.equals("Other") ? "selected" : ""%>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="category">Category</label>
                                    <select class="form-control" id="category" name="category" required>
                                        <option value="Cat" <%= category.equals("Cat") ? "selected" : ""%>>Cat</option>
                                        <option value="Dog" <%= category.equals("Dog") ? "selected" : ""%>>Dog</option>
                                        <option value="Rabbit" <%= category.equals("Rabbit") ? "selected" : ""%>>Rabbit</option>
                                        <option value="Tortoise" <%= category.equals("Tortoise") ? "selected" : ""%>>Tortoise</option>
                                        <option value="Other" <%= category.equals("Other") ? "selected" : ""%>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <!--                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                                            <div class="form-group">
                                                                <label for="image">Upload Image</label>
                                                                <input type="file" class="form-control" id="image" name="image" required multiple accept="image/*" onchange="validateImageCount(this)">
                                                            </div>
                                                        </div>-->
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="stockQty">Stock Quantity</label>
                                    <input type="number" class="form-control" id="stockQty" name="stockQty" required min="0" value="<%=stockQty%>">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <label for="createdDate">Created Date</label>
                                    <input type="text" class="form-control" id="createdDate" name="createdDate" readonly value="<%=createdDate%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="updatedDate">Updated Date</label>
                                    <input type="text" class="form-control" id="updatedDate" name="updatedDate" readonly value="<%=updatedDate%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="createdBy">Created By</label>
                                    <input type="text" class="form-control" id="createdBy" name="createdBy" readonly value="<%=createdBy%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="updatedBy">Updated By</label>
                                    <input type="text" class="form-control" id="updatedBy" name="updatedBy" readonly value="<%=updatedBy%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="isActive">Status</label>
                                    <input type="text" class="form-control" id="isActive" name="isActive" readonly value="<%=status%>">
                                </div>
                            </div>

                        </div>
                        <% if (success != null && success.equals("1")) { %>
                        <div class="form-link">
                            <span class="successGreen">Item updated successfully!</span>
                        </div>
                        <% }%>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">
                                    <input type="submit" id="updateBtn" name="updateBtn" class="btn btn-primary" value="Update"/>
                                    <%
                                        if (isActive) {
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

        <!-- back to manage customer -->
        <section class="content" id="manageCustomer">
            <div class="manageHead">
                <a href="manageItem.jsp" class="nav-link">
                    <i class="bx bx-chevron-left icon"></i>
                    <span class="link">Back</span>
                </a>
            </div>
        </section>
        <script src="../../js/adminDarkMode.js"></script>
        <!--        <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>-->
        <script type="text/javascript">
            function validateImageCount(input) {
                if (input.files.length > 10) {
                    alert("You can upload up to 10 images.");
                    input.value = ''; // Clear the selected files
                }
            }
        </script>



    </body>
</html>