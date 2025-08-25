<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="domain.Promotion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,domain.Cart,control.MaintainCartControl"%>
<jsp:useBean id="account" class="domain.Account" scope="session"/>
<jsp:useBean id="promotion" class="domain.Promotion" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/home_nav.css"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="6sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="icon" type="image/png" href="../pic/logo3.png"/>
    </head>
    <body>
        <%
//            if (account.getPosition().equals("Guest")) {
//                response.sendRedirect("onlyCustomer.jsp");
//                return;
//            }
        %>
        <% LocalDate localDate = LocalDate.now();//For reference
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String date = localDate.format(dateFormatter);
            if (account.getAccountID() > 0 && account.getBirthday().equals(date)) {
                Promotion promo = (Promotion) session.getAttribute("promotion");
                promo.setDiscount(50);
                promo.setDescription("HAPPY BIRTHDAY!");
                session.setAttribute("promotion", promo);
            }%>
        <% MaintainCartControl cartControl = new MaintainCartControl(); %>
        <% int cartItemCount = 0;
            if (account.getAccountID() > 0) {
                ArrayList<Cart> cartList = cartControl.getCartByAccountId(account.getAccountID());
                session.setAttribute("cart", cartList);
                if (!cartList.isEmpty()) {
                    cartItemCount = cartList.size();
                }
            } else {
                if (session.isNew()) {
                    ArrayList<Cart> cartList = cartControl.getCartByAccountId(0);
                    session.setAttribute("guestCart", cartList);
                    if (!cartList.isEmpty()) {
                        cartItemCount = cartList.size();
                    }
                } else {
                    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("guestCart");
                    if (!cartList.isEmpty()) {
                        cartItemCount = cartList.size();
                    }
                }
            }%>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-info fixed-top">
                <a class="navbar-brand" href="home.jsp"><img src="../pic/logo.png"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="home.jsp">Home</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="ProductList.jsp">Product</a>
                        </li>
                        <li class="nav-item">
                            <form action="ProductList.jsp" method="GET" class="form-inline">
                                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search">
                                <button class="btn btn-outline-success my-2 my-sm-0 bg-primary text-light" type="submit">Search</button>
                            </form>
                        </li>
                    </ul>
                    <ul class="navbar-nav mr-right">
                        <% if (account.getAccountID() < 1) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Register</a>
                        </li>
                        <% } %>
                        <% if (account.getAccountID() > 0) {%>
                        <li class="nav-item">
                            <a class="nav-link" href="profile.jsp"><%= account.getLastName()%> <%= account.getFirstName()%></a>
                        </li>
                        <li class="nav-item">
                            <form action="../LogoutServlet" method="post">
                                <input type="submit" class="nav-link btn  btn-danger btn-sm" value="Logout">
                            </form>
                        </li>
                        <% }%>
                        <li class="nav-item">
                            <a class="nav-link" href="cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
                                </svg><%= cartItemCount%></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
    </body>
</html>