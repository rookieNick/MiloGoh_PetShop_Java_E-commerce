<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Account" %>
    <%@ page import="control.MaintainAccountControl" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Retrieve the account object from the session
    Account RegisteredStaffacc = (Account) session.getAttribute("registerStaffAccount");
    
    int accountID = 0;
    String gmail = "";
    String password = "";

    String created_by = "";
    String updated_by = "";
    
        if (RegisteredStaffacc != null) {
            accountID = RegisteredStaffacc.getAccountID();
            gmail = RegisteredStaffacc.getGmail();
            password = RegisteredStaffacc.getPassword();

            created_by = RegisteredStaffacc.getCreated_by();
            updated_by = RegisteredStaffacc.getUpdated_by();

        }
%>
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${companyName} | Add Staff</title>
  <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
  <!-- CSS -->
  <link rel="stylesheet" href="../../css/staffStyle.css" />
  <link rel="stylesheet" href="../../css/adminAddAccBackground.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Boxicons CSS -->
  <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
</head>
<body>
  <%@include file="managerNavBar.jsp" %>

    <div class="body-content">
        
        <!-- create staff -->
        <section class="content" id="createStaff">
            <div class="form signup" id="regStaffSuccessBox">
                <div class="form-content">
                    <header style="color:greenyellow">Create Staff Successful</header>
                    <form>

                        <div class="form-section">
                            <div class="center-form-section">
                                Staff Id
                                <div class="field input-field">
                                    <input type="text" placeholder="Staff Id" class="form-control" id="accountID" name="accountID" readonly value="<%= accountID %>">
                                </div>
                                Email
                                <div class="field input-field">
                                    <input type="email" placeholder="Email" class="input form-control" name="gmail" id="gmail" required readonly value="<%= gmail %>">
                                </div>
                                Password 
                                <div class="field input-field">
                                    <input type="text" placeholder="Password" class="password form-control" name="password" id="password" required readonly value="<%= password %>">
                                </div>
                            </div>
                        </div>
                        <small style="color: red">Please remember to share these account details with the new staff member so they can login using STAFF ID and PASSWORD and update their information.</small>
                        <div class="field button-field">
                            <a href="addStaff.jsp"><input type="button" id="completeBtn" name="completeBtn" class="btn btn-primary" value="COMPLETE"/></a>
                        </div>
                    </form>
                </div>
            </div>
        </section>

<!--         back to manage staff 
        <section class="content" id="manageStaff">
            <div class="manageHead">
                <a href="addStaff.jsp" class="nav-link">
                    <i class="bx bx-chevron-left icon"></i>
                    <span class="link">Back</span>
                </a>
            </div>
        </section>-->
     
    </div>
    

  <script src="../../js/adminDarkMode.js"></script>
</body>
</html>

