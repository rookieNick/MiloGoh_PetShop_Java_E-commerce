<%-- 
    Document   : AddReview.jsp
    Created on : Apr 30, 2024, 11:22:40 PM
    Author     : terra
--%>

<%@page import="control.MaintainAccountControl"%>
<%@page import="domain.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
 Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="CodeHim">
        <title>${companyName} | Rate it !</title>
        <!-- Style CSS -->
        <link rel="stylesheet" href="../css/AddReview.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
    </head>
    <body>
        <%
            if (account.getPosition().equals("Guest")) {
                response.sendRedirect("onlyCustomer.jsp");
                return;
            }
        %>

        <main class="cd__main">
            <!-- Start DEMO HTML (Use the following code into your project)-->
            <div class="wrapper"> 
                <div class="title">Rate your experience</div>
                <div class="content">We highly value your feedback! Kindly take a moment to rate your experience and provide us with your valuable feedback.</div>
                <!-- Form for submitting the review to a servlet -->
                <form action="../SubmitReviewServlet" method="post">
                    <!-- Input field for the account ID -->
                    <input type="hidden" name="accountId" value="<%=account.getAccountID()%>">
                    <!-- Input field for the product ID -->
                    <input type="hidden" name="productId" value="<%=Integer.parseInt(request.getParameter("id"))%>">
                    <div class="rate-box">
                        <input type="radio" name="rate" id="star0" value="5"/>
                        <label class="star" for="star0"></label>
                        <input type="radio" name="rate" id="star1" value="4"/>
                        <label class="star" for="star1"></label>
                        <input type="radio" name="rate" id="star2" checked="checked" value="3"/>
                        <label class="star" for="star2"></label>
                        <input type="radio" name="rate" id="star3" value="2"/>
                        <label class="star" for="star3"></label>
                        <input type="radio" name="rate" id="star4" value="1"/>
                        <label class="star" for="star4"></label>
                    </div>
                    <textarea name="content" name="review" cols="30" rows="6" placeholder="Tell us about your experience!"></textarea>
                    <button type="submit" class="submit-btn">Send</button>
                </form>
                <!-- END FORM -->
            </div>
            <!-- END EDMO HTML (Happy Coding!)-->
        </main>

        <!-- Script JS -->
        <script src="./js/script.js"></script>
        <!--$%analytics%$-->
    </body>
</html>