<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Account" %>
    <%@ page import="control.MaintainAccountControl" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%
        //get current login account info
        Account account = (Account) session.getAttribute("registerAccount");
        Account staffAccount = (Account) session.getAttribute("staffAccount");

        String firstName = "";
        String lastName = "";
        String gmail = "";
        String phoneNumber = "";
        String gender = "";
        String address = "";
        String ic = "";
        String birthday = "";
        String username = "";

        //for customer login to get customer login account info
        if (account != null) {
            firstName = account.getFirstName();
            lastName = account.getLastName();
            gmail = account.getGmail();
            phoneNumber = account.getPhoneNumber();
            gender = account.getGender();
            address = account.getAddress();
            ic = account.getIc();
            birthday = account.getBirthday();
            username = account.getUsername();

            // Clear account data from session
            session.removeAttribute("registerAccount");
        }

    %>

    <%        String success = (String) request.getParameter("success");
        String errorMsgProfile = (String) session.getAttribute("errorMsgProfile");

        session.removeAttribute("errorMsgProfile");
    %>
    <head>
        <meta charset="utf-8">


        <title>${companyName} | Add Customer</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
        
        <link href="../../css/staffStyle.css" rel="stylesheet">
        <link href="../../css/addCustomer.css" rel="stylesheet">

    </head>
    <body>
    <%@include file="managerNavBar.jsp" %>
    <div id="addCusForm">
        <form action="../../AddCustomerServlet" method="post" id="addCustForm">
            <input type="hidden" name="createBy" value="<%= staffAccount.getUsername() %>">
            <div class="container" id="addCustContainer">
                <div class="row gutters">
                    <div class="card-body" id="addCustCardBody">
                        <div class="row gutters">
                            <%
                                if (errorMsgProfile != null && !errorMsgProfile.equals("")) {
                                    // Split error messages by newline character and create line breaks
                                    String[] errorMessages = errorMsgProfile.split("\n");
                            %>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h5 class="mb-2" style="color:red">Error! Please follow format below before proceed to any of the functions</h5>
                                <%
                                    int index = 1;
                                    for (String message : errorMessages) {
                                %>
                                <h6 class="mb-2 " style="color:red"><%=index++%>. <%= message%></h6>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                }
                                session.removeAttribute("errorMsgProfile");
                            %>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h6 class="mb-2 text-primary">Personal Details</h6>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="ic">IC (Identity Card)</label>
                                    <input type="text" class="form-control" id="ic" name="ic" required value="<%=ic%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required value="<%=firstName%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required value="<%=lastName%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="gmail">Gmail</label>
                                    <input type="email" class="form-control" id="gmail" name="gmail" required value="<%=gmail%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="Male" <%= gender.equals("Male") ? "selected" : ""%>>Male</option>
                                        <option value="Female" <%= gender.equals("Female") ? "selected" : ""%>>Female</option>
                                        <option value="Other" <%= gender.equals("Other") ? "selected" : ""%>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" required value="<%=address%>">
                                </div>
                            </div>
                        </div>
                        <div class="row gutters">

                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="phone">Phone Number</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required value="<%=phoneNumber%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required value="<%=username%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="birthday">Birthday</label>
                                    <input type="date" class="form-control" id="birthday" name="birthday" value="<%=birthday%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="text" class="form-control" id="password" name="password" required>
                                </div>
                            </div>

                        </div>
                        <% if (success != null && success.equals("1")) { %>
                        <div class="form-link">
                            <span style="color:greenyellow">Account added successfully!</span>
                        </div>
                        <% }%>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">
                                    <input type="submit" id="addBtn" name="addBtn" class="btn btn-primary" value="Add"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>                  
        <!-- back to manage customer -->
<!--        <section class="content" id="manageCustomer">
            <div class="manageHead">
                <a href="manageCustomer.jsp" class="nav-link">
                    <i class="bx bx-chevron-left icon"></i>
                    <span class="link">Back</span>
                </a>
            </div>
        </section>-->
          <script src="../../js/adminDarkMode.js"></script>
<!--        <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>-->
        <script type="text/javascript">

        </script>
        
    </body>
</html>