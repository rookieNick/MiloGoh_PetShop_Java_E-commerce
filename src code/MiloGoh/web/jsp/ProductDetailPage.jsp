<%-- 
    Document   : ProductPage
    Created on : Apr 11, 2024, 10:40:12 AM
    Author     : terra
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="control.MaintainAccountControl"%>
<%@page import="domain.Account"%>
<%@page import="domain.Review"%>
<%@page import="control.MaintainReviewControl"%>
<%@page import="java.util.Base64"%>
<%@page import="domain.Image"%>
<%@page import="control.MaintainImageControl"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product"%>
<%@page import="control.MaintainProductControl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

//    Account account = (Account) session.getAttribute("account");
    // Create an instance of MaintainProductControl
    MaintainProductControl productControl = new MaintainProductControl();

    Product product = null;
    // Call the method to retrieve all product records
    if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
        product = productControl.selectProductById(Integer.parseInt(request.getParameter("id")));
    } else {
        product = new Product();
    }
%>
<%
    String base64Image = "";
    if (product != null) {
        int imageId = product.getImage().getId();
        MaintainImageControl imageControl = new MaintainImageControl();
        Image image = imageControl.selectImageById(imageId);

        byte[] imageData = image.getImage1(); // Assuming the image data is stored in the getImage1() method
        // Convert the byte array to a Base64-encoded string
        base64Image = Base64.getEncoder().encodeToString(imageData);
    }
%>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kumbh+Sans:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Boxicons CSS -->
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/ProductDetailPage.css">
    <title>${companyName} | Product Detail</title>
    <%@ include file="header.jsp" %>
</head



<body id="productDetailPageBody">
    <div class="wrapper">
        <main class="product" style="display:flex; justify-content: center">
            <div class="product--gallery" style="width: 50%">
                <div class="gallery--hero">
                    <a href="#" class="arrow left-arrow" data-dir="-1">
                        <img src="../pic/productDetailPage/icon-previous.svg" alt="">
                    </a>
                    <a href="#" class="arrow right-arrow" data-dir="1">
                        <img src="../pic/productDetailPage/icon-next.svg" alt="">
                    </a>
                    <div class="image-wrapper">
                        <img src="data:image/jpeg;base64, <%= base64Image%>" class="product-image" alt="product large view">
                    </div>
                </div>

                <div class="gallery-container" style="width:85%">
                    <div class="gallery-icons">
                        <%
                            String base64Image1 = "";
                            if (product != null) {
                                MaintainImageControl imageControl = new MaintainImageControl();
                                ArrayList<byte[]> images = imageControl.getAllImagesById(product.getImage().getId());
                                // Iterate over the list of images and display them
                                for (int i = 0; i < images.size(); i++) {
                                    byte[] imageData = images.get(i);
                                    if (imageData != null) {
                                        // Convert the byte array to a Base64-encoded string
                                        base64Image1 = Base64.getEncoder().encodeToString(imageData);
                        %>
                        <img src="data:image/jpeg;base64, <%= base64Image1%>" alt="product view" class="icon" id="thumbnail<%= i + 1%>">
                        <%
                                    }
                                }
                            }
                        %>
                    </div>
                </div>
            </div>


            <section class="product--details"style="width: 50%; font-size: 60%">
                <div class="product--description">
                    <p class="product--name">${companyName}</p>
                    <h1><%= product.getName()%></h1>
                    <p> <%= product.getDescription()%></p>
                </div>
                <div class="product--pricing">
                    <% if (promotion.getPromotionid() > 0) {

                            double dicountedPrice = product.getUnitPrice() * (100 - promotion.getDiscount()) / 100;
                    %>
                    <ins class="price--discounted">RM<%=dicountedPrice%></ins>
                    <span class="price--discount"><%=promotion.getDiscount()%>%</span>
                    <del class="price--original">RM<%= product.getUnitPrice()%></del>
                    <%} else {%>
                    <ins class="price--discounted">RM<%= product.getUnitPrice()%></del>
                        <%}%>
                </div>

                <form action="../addToCartServlet?productId=<%= product.getId()%>" method="post">
                    <div class="product--cart">
                        <button class="minus" type="button" onclick="decreaseQuantity()">
                            <img src="../pic/productDetailPage/icon-minus.svg" alt="decrease quantity">
                        </button>
                        <input class="number" type="number" name="quantity" id="quantity" min="1" value="1">
                        <button class="plus" type="button" onclick="increaseQuantity()">
                            <img src="../pic/productDetailPage/icon-plus.svg" alt="increase quantity">
                        </button>
                        <button class="cart" type="submit">
                            <img src="../pic/productDetailPage/icon-cart.svg" alt="cart icon"> Add to cart
                        </button>
                    </div>
                </form>
            </section>
        </main>
        <!-- Add a section for submitting comments -->
        <section class="review-form-section">
            <% if (account.getAccountID() > 0) {%>
            <a href="AddReview.jsp?id=<%=product.getId()%>">
                <% } else {%>
                <a href="login.jsp">
                    <% } %>
                    <button type="submit" class="adddComments"> Go to Comments </button>
                </a>

                <div class="cards">
                    <%
                        MaintainReviewControl reviewControl = new MaintainReviewControl();
                        MaintainAccountControl accountControl = new MaintainAccountControl();
                        Account acc = new Account();
                        ArrayList<Review> reviewRecords = reviewControl.getAllReviews(Integer.parseInt(request.getParameter("id")));
                        if (reviewRecords != null && !reviewRecords.isEmpty()) {
                            // Separate reviews for the current user and other users
                            ArrayList<Review> currentUserReviews = new ArrayList<Review>();
                            ArrayList<Review> otherUserReviews = new ArrayList<Review>();

                            // Separate reviews based on whether they belong to the current user or not
                            for (Review review : reviewRecords) {
                                // Check if the review belongs to the current user
                                if (review.getAccountid() == account.getAccountID()) {
                                    currentUserReviews.add(review);
                                } else {
                                    otherUserReviews.add(review);
                                }
                            }
                            // Display other users' reviews sorted by updated time in ascending order
                            Collections.sort(currentUserReviews, new Comparator<Review>() {
                                public int compare(Review r1, Review r2) {
                                    return r2.getUpdatedtime().compareTo(r1.getUpdatedtime());
                                }
                            });
                            for (Review review : currentUserReviews) {
                                acc = accountControl.selectRecord(review.getAccountid() + "");
                                String accName = acc.getFirstName();
                    %>
                    <div class="card">
                        <div class="card-top">
                            <div class="name">
                                <div class="img one" alt="" style="font-size: 25px;font-weight: bold;color: white"><%=accName.charAt(0)%></div>
                                <p><%=accName%></p>
                            </div>
                            <div class="rate">
                                <% for (int i = 0; i < review.getRate(); i++) { %>
                                <i class="fas fa-star"style="color:orange"></i>
                                <% }%>
                            </div>
                        </div>

                        <div class="card-content">
                            <p><%=review.getContent()%></p>
                        </div>

                        <div class="card-action">
                            <div>
                                <span><%=review.getUpdatedtime()%></span>
                            </div>
                            <div class="btn-selection">
                                <div>
                                    <!--Update and Delete buttons for the current user's reviews--> 
                                    <!-- Update form for the current user's review -->
                                    <form action="modifyReview.jsp?id=<%= review.getReviewid()%>" method="post">
                                        <button type="submit" class="btn btn-primary">Update</button>
                                    </form>
                                </div>
                                <div>

                                    <form id="deleteForm" action="../DeleteReviewServlet" method="post">
                                        <input type="hidden" name="reviewId" value="<%= review.getReviewid()%>">
                                        <input type="hidden" name="productId" value="<%= product.getId()%>">
                                        <button type="button" class="btn btn-danger" onclick="confirmDelete()">Delete</button>
                                    </form>

                                </div>
                            </div>
                        </div>

                    </div>
                    <%
                        }
                        // Display other users' reviews sorted by updated time in ascending order
                        Collections.sort(otherUserReviews, new Comparator<Review>() {
                            public int compare(Review r1, Review r2) {
                                return r2.getUpdatedtime().compareTo(r1.getUpdatedtime());
                            }
                        });

                        for (Review review : otherUserReviews) {
                            acc = accountControl.selectRecord(review.getAccountid() + "");
                            String accName = acc.getFirstName();
                    %>
                    <div class="card">
                        <div class="card-top">
                            <div class="name">
                                <div class="img one" alt=""><%=accName%></div>
                                <p><%=accName%></p>
                            </div>
                            <div class="rate">
                                <% for (int i = 0; i < review.getRate(); i++) { %>
                                <i class="fas fa-star" style="color:orange"></i>
                                <%  }%>
                            </div>
                        </div>

                        <div class="card-content">
                            <p><%=review.getContent()%></p>
                        </div>

                        <div class="card-action">
                            <span><%=review.getUpdatedtime()%></span>
                        </div>

                    </div>
                    <%
                            }
                        }
                    %>
                </div>
        </section>
    </div>
    <script>
        function increaseQuantity() {
            var input = document.getElementById('quantity');
            input.value = parseInt(input.value) + 1;
        }

        function decreaseQuantity() {
            var input = document.getElementById('quantity');
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }
    </script>
    <script>
        function confirmDelete() {
            if (confirm("Are you sure you want to delete this review?")) {
                document.getElementById("deleteForm").submit();
            }
        }
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const images = document.querySelectorAll('.gallery-icons .icon'); // Changed from '.gallery--icons .icon'
            const mainImage = document.querySelector('.gallery--hero .product-image');
            let currentIndex = 0;


            // Function to show the image at a specific index
            function showImage(index) {
                if (index < 0) {
                    index = images.length - 1;
                } else if (index >= images.length) {
                    index = 0;
                }
                currentIndex = index;
                mainImage.src = images[index].src;
            }

            // Event listeners for arrow clicks
            document.querySelectorAll('.arrow').forEach(arrow => {
                arrow.addEventListener('click', function (event) {
                    event.preventDefault();
                    const direction = parseInt(this.getAttribute('data-dir'));
                    showImage(currentIndex + direction);
                });
            });

            // Event listener for clicking on thumbnail images
            images.forEach((image, index) => {
                image.addEventListener('click', function () {
                    showImage(index);
                });
            });
        });
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const images = document.querySelectorAll('.gallery-icons img'); // Corrected selector
            const container = document.querySelector('.gallery-icons');
            let scrollPosition = 0;
            let touchStartX = 0;

            // Function to scroll the thumbnail container
            function scrollContainer(direction) {
                const step = 120; // Adjust this value for smoothness
                const newPosition = scrollPosition + (step * direction);
                container.scrollTo({
                    left: newPosition,
                    behavior: 'smooth'
                });
                scrollPosition = newPosition;
            }

            // Event listeners for arrow clicks
            document.querySelectorAll('.arrow').forEach(arrow => {
                arrow.addEventListener('click', function (event) {
                    event.preventDefault();
                    const direction = parseInt(this.getAttribute('data-dir'));
                    scrollContainer(direction);
                });
            });

            // Event listener for clicking on thumbnail images
            images.forEach((image, index) => {
                image.addEventListener('click', function () {
                    // Show full-size image or perform other actions
                    // This section can be expanded to show the clicked thumbnail in the main image area
                });

                // Event listener for touch events
                image.addEventListener('touchstart', function (event) {
                    touchStartX = event.touches[0].clientX;
                });

                image.addEventListener('touchend', function (event) {
                    const touchEndX = event.changedTouches[0].clientX;
                    const deltaX = touchEndX - touchStartX;

                    // Determine swipe direction based on touch end position relative to touch start position
                    if (deltaX > 50) {
                        scrollContainer(-1); // Swipe right
                    } else if (deltaX < -50) {
                        scrollContainer(1); // Swipe left
                    }
                });
            });
        });
    </script>
</body>



