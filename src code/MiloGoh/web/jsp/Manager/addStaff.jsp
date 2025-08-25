<%@page import="domain.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve the account object from the session
    Account accounts = (Account) session.getAttribute("account");
    
    String errorMsg = (String) session.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${companyName} | Add Staff</title>
  <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Boxicons CSS -->
  <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    <!-- CSS -->
  <link rel="stylesheet" href="../../css/staffStyle.css" />
  <link rel="stylesheet" href="../../css/adminAddAccBackground.css" />
  <style>

    </style>
</head>
<body id="addStaffPage">
  <%@include file="managerNavBar.jsp" %>

    <div class="body-content">
        
        <!-- create staff -->
        <section class="content" id="createStaff">
            <div class="form signup" id="addStaffForm">
                <div class="form-content">
                    <header>Create Staff Account</header>
                    <form action="../../AddStaffServlet" method="post">
                        <input type="hidden" name="createBy" value="<%= accounts.getUsername() %>">
                            <%
                            if (errorMsg != null && !errorMsg.equals("")) {
                                // Split error messages by newline character and create line breaks
                                String[] errorMessages = errorMsg.split("\n");
                            %>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h6 class="mb-2" style="color:red">Error! Please follow the format below:</h6>
                                <%
                                int index = 1;
                                for (String message : errorMessages) {
                                %>
                                <div class="mb-2" style="color:red"><%=index++%>. <%= message%></div>
                                <%
                                }
                                %>
                            </div>
                            <%
                            }
                            session.removeAttribute("errorMsg");
                            %>

                        <div class="form-section">
                            <div class="center-form-section">
                                Email
                                <div class="field input-field">
                                    <input type="email" placeholder="Email" class="input" name="gmail" id="gmail" required>
                                </div>
                                Password 
                                <div class="field input-field">
                                    <input type="password" placeholder="Password" class="password" name="password" id="password" required>
                                    <i class='bx bx-refresh refresh-icon' onclick="generateRandomPassword('password')"></i>
                                </div>
                                Confirm Password
                                <div class="field input-field">
                                    <input type="password" placeholder="Confirm Password" class="confirmPassword" name="confirmPassword" id="confirmPassword" required>
                                </div>
                                <div>
                                     <input type="checkbox" id="showPassword" onchange="togglePasswordVisibility(this)">
                                     <label for="showPassword">Show Password</label>
                                </div>
                                <div style="padding-top:15px">
                                    <label>
                                        <input type="radio" name="correctRadioButton" value="true" required>
                                        Yes, the entered information is correct
                                    </label>
                                </div>
                            </div>
                        </div>
                        <small style="color: red">Password length must be more than 6 and include at least 1 lower, upper, special, number character</small>
                        <div class="field button-field">
                                    <input type="submit" id="createBtn" name="createBtn" class="btn btn-primary" value="CREATE"/>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <!-- back to manage staff -->
<!--        <section class="content" id="manageStaff">
            <div class="manageHead">
                <a href="manageStaff.jsp" class="nav-link">
                    <i class="bx bx-chevron-left icon"></i>
                    <span class="link">Back</span>
                </a>
            </div>
        </section>-->
     
    </div>
    

  <script src="../../js/adminDarkMode.js"></script>
  <script src="../../js/addStaff.js"></script>
</body>
</html>

