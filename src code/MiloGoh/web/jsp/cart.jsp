<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product" %>
<%@page import="domain.Image" %>
<%@page import="domain.Cart" %>
<%@page import="control.MaintainProductControl" %>
<%@page import="control.MaintainImageControl" %>
<%@page import="java.util.Base64"%>
<!DOCTYPE html>
<html>
    <head>
        <title>${companyName} | Cart</title>
        <link rel="stylesheet" href="../css/cart.css"/>
        <%@ include file="header.jsp" %>
    </head>
    <section class="h-100 gradient-custom">
        <div class="container py-5">
            <div class="row d-flex justify-content-center my-4">
                <div class="col-md-9">
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <h5 class="mb-0">Cart - <%= cartItemCount%> items</h5>
                        </div>
                        <div class="card-body">
                            <% Product formatter = new Product(); %>
                            <% MaintainProductControl productControl = new MaintainProductControl(); %>
                            <% MaintainImageControl imageControl = new MaintainImageControl(); %>
                            <% ArrayList<Cart> cartLists = cartControl.getCartByAccountId(0);
                                int[] itemArr = new int[cartItemCount];
                                if (account.getAccountID() > 0) {
                                    cartLists = (ArrayList<Cart>) session.getAttribute("cart");
                                } else {
                                    cartLists = (ArrayList<Cart>) session.getAttribute("guestCart");
                                }
                                for (int i = 0; i < cartItemCount; i++) {
                                    Product product = productControl.selectProductById(cartLists.get(i).getProductID());
                                    int imageId = product.getImage().getId();
                                    Image image = imageControl.selectImageById(imageId);
                                    byte[] imageData = image.getImage1();
                                    String base64Image = Base64.getEncoder().encodeToString(imageData);
                            %>

                            <div class="row">
                                <div class="col-lg-1 mb-4 align-self-center">
                                    <input type="checkbox" class="custom-checkbox" form="to-order" name="<%= "itemArr[" + i + "]"%>"/>
                                </div>
                                <div class="col-lg-4 mb-4 align-self-center">
                                    <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                                        <img src="data:image/jpeg;base64, <%= base64Image%>" class="w-100 border border-primary"/>
                                    </div>
                                </div>

                                <div class="col-lg-4 mb-4 align-self-center">
                                    <p><strong><%= product.getName()%></strong></p>
                                    <p><%= product.getDescription()%></p>
                                    <p>Unit Price       : RM<%= formatter.rmFormat(product.getUnitPrice())%></p>
                                    <p>Product in Stock :<%= product.getStockQty()%></p>
                                </div>

                                <div class="col-lg-3 mb-4">
                                    <p class="text-md-center">
                                        <strong>Total Price<br>RM <%= formatter.rmFormat(product.getUnitPrice() * cartLists.get(i).getProductQty())%></strong>
                                    </p>
                                    <div class="d-flex mb-4" style="max-width: 300px">
                                        <form action="../ProductDecreaseQtyServlet?id=<%= product.getId()%>" method="post">
                                            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary">
                                                <img src="../pic/productDetailPage/icon-minus.svg" alt="decrease quantity">
                                            </button>
                                        </form>

                                        <div data-mdb-input-init class="form-outline mx-3">
                                            <input id="form1" min="1" name="quantity" value="<%= cartLists.get(i).getProductQty()%>" type="number" class="form-control text-center" disabled/>
                                        </div>

                                        <form action="../ProductIncreaseQtyServlet?id=<%= product.getId()%>" method="post">
                                            <button data-mdb-button-init data-mdb-ripple-init class="btn btn-primary">
                                                <img src="../pic/productDetailPage/icon-plus.svg" alt="increase quantity">
                                            </button>
                                        </form>
                                    </div>
                                    <form action="../DeleteCartServlet?id=<%=product.getId()%>" method="post" class="d-flex justify-content-center">
                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-danger btn-sm me-1 mb-2 " data-mdb-tooltip-init title="Remove item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                            <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                            </svg>
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <hr class="my-4" />
                            <% }%>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card mb-4">
                        <div class="card-header py-3">
                            <h5 class="mb-0">Summary</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                                    <% if (account.getAccountID() > 0) { %>
                                    <a class="btn btn-primary btn-lg btn-block" href="orderHistory.jsp">
                                        <% } else { %>
                                        <a class="btn btn-primary btn-lg btn-block" href="login.jsp">
                                            <% } %>
                                            View My Orders
                                        </a>
                                </li>
                                <li class="list-group-item align-items-center border-0 px-0 mt-3">
                                    <form id="to-order" action="../AddOrderServlet" method="post" class="d-flex justify-content-center">
                                        <% if (cartItemCount > 0) { %>
                                        <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block">
                                            <% } else { %>
                                            <button type="submit" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-lg btn-block" disabled>
                                                <% }%>
                                                Confirm item and add to order
                                            </button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="footer.jsp" %>
</html>
