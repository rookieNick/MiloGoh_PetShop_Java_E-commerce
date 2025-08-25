<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product" %>
<%@page import="domain.Image" %>
<%@page import="control.MaintainProductControl" %>
<%@page import="control.MaintainImageControl" %>
<%@page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>${companyName} | Products</title>

        <!-- Site Icon -->
        <link rel="shortcut Icon" type="../images/png" href="../images/favicon.png">

        <!-- Font Awesome Icons -->
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Kanit&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

        <!-- Custom CSS -->
        <link href="../css/ProductList.css" rel="stylesheet">
        <%@ include file="header.jsp" %>

    </head>
    <body id="page-top">
        <%
            // Create an instance of MaintainProductControl
            MaintainProductControl productControl = new MaintainProductControl();

            // Call the method to retrieve all product records
            String searchBy = request.getParameter("search");
            String category = request.getParameter("category");
            ArrayList<Product> productRecords = productControl.getAllProducts(searchBy, category, "");

        %>
        <section class="page-section">
            <div class="container">
                <div class="row">

                    <div class="col-lg-3 blog-form">

                        <h2 class="blog-sidebar-title"><b>Categories</b></h2>
                        <hr />
                        <form id="categoryForm" method="GET" action="ProductList.jsp">
                            <input type="hidden" name="category" id="categoryInput" value="">
                            <p class="blog-sidebar-list" id="dogCategory" onclick="handleCategoryClick('Dog')"><b><span class="list-icon"> > </span>Dog</b></p>
                            <p class="blog-sidebar-list" id="catCategory" onclick="handleCategoryClick('Cat')"><b><span class="list-icon"> > </span>Cat</b></p>
                            <p class="blog-sidebar-list" id="rabbitCategory" onclick="handleCategoryClick('Fish')"><b><span class="list-icon"> > </span>Fish</b></p>
                            <p class="blog-sidebar-list" id="tortoiseCategory" onclick="handleCategoryClick('Tortoise')"><b><span class="list-icon"> > </span>Tortoise</b></p>
                            <input type="submit" style="display: none;">
                        </form>
                        <div>&nbsp;</div>
                        <div>&nbsp;</div>

                        <h2 class="blog-sidebar-title"><b>Filter</b></h2>
                        <hr />
                        <form action="ProductList.jsp" method="GET">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Search" aria-label="Receipient's username" aria-describely="basic-addon2" name="search">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit">Search</button>
                                </div>

                            </div>
                        </form>

                    </div>
                    <!--END  <div class="col-lg-3 blog-form">-->

                    <div class="col-lg-9" style="padding-left: 30px;">
                        <div class="row">
                            <% int count = productRecords.size();%>
                            <div class="col">
                                Showing all <%= count%> results
                            </div>
                            <div class="col">
                                <select id="sortSelection" class="form-control">
                                    <option value="">Default Sorting</option>
                                    <option value="latest">Sorting by latest</option>
                                    <option value="low">Sorting by low</option>
                                    <option value="high">Sorting by high</option>
                                </select>
                            </div>
                        </div>
                        <!-- Sorting by <div class="row"> -->
                        <div>&nbsp;</div>
                        <div>&nbsp;</div>

                        <div class="row product-list-container">

                            <%  //Check search got 
                                // Check if there are any product records
                                if (productRecords != null && !productRecords.isEmpty()) {
                                    for (Product product : productRecords) {

                                        double harga = product.getUnitPrice();

                                        // Get the updated date string from the product object
                                        String updatedDateString = product.getUpdatedDate();

                                        // Parse the date string into a Date object
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                                        Date updatedDate = dateFormat.parse(updatedDateString);

                                        // Format the date using SimpleDateFormat
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                                        String formattedDate = sdf.format(updatedDate);

                                        int imageId = product.getImage().getId();
                                        MaintainImageControl imageControl = new MaintainImageControl();
                                        Image image = imageControl.selectImageById(imageId);

                                        byte[] imageData = image.getImage1(); // Assuming the image data is stored in the getImage1() method
                                        // Convert the byte array to a Base64-encoded string
                                        String base64Image = Base64.getEncoder().encodeToString(imageData);
                            %>
                            <div class="col-lg-4 product-card" data-updatedDate="<%=formattedDate%>" data-unitPrice="<%= product.getUnitPrice()%>">
                                <div class="card-body text-center" >
                                    <img src="data:image/jpeg;base64, <%= base64Image%>" class="product-image" style="width: 200px; height: 200px;">
                                    <h5 class="card-title"><b><%= product.getType()%></b></h5>
                                    <p class="card-name"><%= product.getName()%></p>
                                    <p class="card-text"><%= product.getDescription()%></p>
                                    <p class="price-tag">Price RM <%= product.rmFormat(harga)%></p>
                                    <a href="ProductDetailPage.jsp?id=<%=product.getId()%>" class="btn btn-success button-text"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Add to cart</a>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>

                        </div>
                        <!-- Sorting by <div class="row"> -->
                    </div>
                    <!--END  <div class="col-lg-9">-->

                </div>
            </div>


        </section>


        <div>&nbsp;</div>
        <div>&nbsp;</div>
        <div>&nbsp;</div>

        <!-- Bootstrap JavaScript -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
        <script>
                                function handleCategoryClick(category) {
                                    console.log("Category selected: " + category);
                                    document.getElementById("categoryInput").value = category;
                                    document.getElementById("categoryForm").submit();
                                }
        </script>

        <!--sorting Function-->
        <script>
            document.getElementById("sortSelection").addEventListener("change", function () {
                var sortSelection = this.value;
                var productList = document.querySelectorAll(".product-card");

                // Convert NodeList to Array for easier manipulation
                var productListArray = Array.from(productList);

                if (sortSelection === "latest") {
                    productListArray.sort(function (a, b) {
                        var dateA = new Date(a.getAttribute("data-updatedDate"));
                        var dateB = new Date(b.getAttribute("data-updatedDate"));
                        return dateB.getTime() - dateA.getTime(); // Compare timestamps
                    });
                } else if (sortSelection === "low") {
                    productListArray.sort(function (a, b) {
                        return parseFloat(a.getAttribute("data-unitPrice")) - parseFloat(b.getAttribute("data-unitPrice"));
                    });
                } else if (sortSelection === "high") {
                    productListArray.sort(function (a, b) {
                        return parseFloat(b.getAttribute("data-unitPrice")) - parseFloat(a.getAttribute("data-unitPrice"));
                    });
                }

                // Append the sorted product cards back to the container
                var productListContainer = document.querySelector(".product-list-container");
                productListContainer.innerHTML = "";
                productListArray.forEach(function (productCard) {
                    productListContainer.appendChild(productCard);
                });
            });
            // Add event listener to the default option
            document.getElementById("sortSelection").addEventListener("change", function () {
                if (this.value === "") {
                    // Reload the page to reset to the default sorting
                    window.location.reload();
                }
            });

            // Function to sort products by default
            function sortProductsByDefault() {
                // Get all product cards
                var productList = document.querySelectorAll(".product-card");
                var productListArray = Array.from(productList);

                // Sort the product cards by default criteria
                // For example, you can sort them by product ID, name, or any other default criteria
                // Here, let's assume sorting by product ID
                productListArray.sort(function (a, b) {
                    // Extract product ID from data attribute
                    var idA = parseInt(a.getAttribute("data-product-id"));
                    var idB = parseInt(b.getAttribute("data-product-id"));
                    return idA - idB;
                });

                // Clear the product list container
                var productListContainer = document.querySelector(".product-list-container");
                productListContainer.innerHTML = "";

                // Append sorted product cards back to the container
                productListArray.forEach(function (productCard) {
                    productListContainer.appendChild(productCard);
                });
            }

            // Call the function to sort products by default when the page loads
            window.onload = function () {
                sortProductsByDefault();
            };

        </script>

        <%@ include file="footer.jsp"%>
    </body>
</html>