<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Account" %>
    <%@ page import="control.MaintainAccountControl" %>
    <%@ page import="javax.servlet.http.HttpSession" %>


    <%
        String success = (String) request.getParameter("success");
        String errorMsgProfile = (String) session.getAttribute("errorMsgProfile");
    %>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Edit Profile</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/adminAddAccBackground.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="staffEditProfilePage">
        <%@include file="managerNavBar.jsp" %>
        <%
            //get current login account info
            Account account = (Account) session.getAttribute("account");
            Account Staffacc = (Account) session.getAttribute("staffAccount");
            Account returnedAcc = (Account) session.getAttribute("accountReturn");

            int accountID = 0;
            String firstName = "";
            String lastName = "";
            String gmail = "";
            String phoneNumber = "";
            String gender = "";
            String ic = "";
            String birthday = "";
            String username = "";
            String password = "";
            String created_date = "";
            String updated_date = "";
            String position = "";
            String status = "";
            double wallet = 0.0;

            String created_by = "";
            String updated_by = "";

            if (returnedAcc != null) {    //for edit error then edit again
                accountID = returnedAcc.getAccountID();
                firstName = returnedAcc.getFirstName();
                lastName = returnedAcc.getLastName();
                gmail = returnedAcc.getGmail();
                phoneNumber = returnedAcc.getPhoneNumber();
                gender = returnedAcc.getGender();
                ic = returnedAcc.getIc();
                birthday = returnedAcc.getBirthday();
                username = returnedAcc.getUsername();
                password = returnedAcc.getPassword();
                created_date = returnedAcc.getCreated_date();
                updated_date = returnedAcc.getUpdated_date();
                status = returnedAcc.getStatus();
                wallet = returnedAcc.getWallet();
                position = returnedAcc.getPosition();

                created_by = returnedAcc.getCreated_by();
                updated_by = returnedAcc.getUpdated_by();
            } else if (Staffacc.getStatus() != null && Staffacc.getStatus().equals("Unset")) { //for new staff first login
                accountID = account.getAccountID();
                firstName = "";
                lastName = "";
                gmail = account.getGmail();
                phoneNumber = "";
                gender = "";
                ic = "";
                birthday = "";
                username = "";
                password = account.getPassword();
                created_date = account.getCreated_date();
                updated_date = account.getUpdated_date();
                status = account.getStatus();
                wallet = 0.0;
                position = account.getPosition();

                created_by = account.getCreated_by();
                updated_by = account.getUpdated_by();
            } //for staff / manager edit their profile themself
            else if (Staffacc.getPosition().equals("Manager") || Staffacc.getPosition().equals("Staff")) {
                accountID = Staffacc.getAccountID();
                firstName = Staffacc.getFirstName();
                lastName = Staffacc.getLastName();
                gmail = Staffacc.getGmail();
                phoneNumber = Staffacc.getPhoneNumber();
                gender = Staffacc.getGender();
                ic = Staffacc.getIc();
                birthday = Staffacc.getBirthday();
                username = Staffacc.getUsername();
                password = Staffacc.getPassword();
                created_date = Staffacc.getCreated_date();
                updated_date = Staffacc.getUpdated_date();
                status = Staffacc.getStatus();
                wallet = Staffacc.getWallet();
                position = Staffacc.getPosition();

                created_by = Staffacc.getCreated_by();
                updated_by = Staffacc.getUpdated_by();
            }

        %>
        <div class="body-content">

            <!-- create staff -->
            <section class="content" id="createStaff">

                <% if (errorMsgProfile != null && !errorMsgProfile.equals("")) { %>
                <div class="side-content">
                    <div class="error-messages">
                        <h6 class="error-heading">Error! Please follow the format below before proceeding to any of the functions</h6>
                        <%
                            String[] errorMessages = errorMsgProfile.split("\n");
                            for (int i = 0; i < errorMessages.length; i++) {
                        %>
                        <h6 class="error-message"><%= (i + 1) + ". " + errorMessages[i]%></h6>
                        <% }
                            session.removeAttribute("errorMsgProfile"); %>
                    </div>
                </div>
                <% } %>
                <% if (success != null && success.equals("1")) { %>
                <div class="side-content">
                    <div class="success-message">
                        <h5>Edited successfully!</h5>
                    </div>
                </div>
                <% }%>

                <div class="form signup editStaff" id="editStaffForm">
                    <div class="form-content">
                        <header>Edit Profile</header>

                        <form action="../../StaffProfileServlet" method="post">
                            <input type="hidden" name="updated_by" value="<%= Staffacc.getUsername()%>">
                            <input type="hidden" name="created_by" value="<%= created_by%>">
                            <input type="hidden" name="position" value="<%= position%>">
                            <input type="hidden" name="created_date" value="<%= created_date%>">
                            <div class="form-section">
                                <div class="left-form-section">
                                    Staff ID
                                    <div class="field input-field">
                                        <input type="text" placeholder="Staff Id" class="input form-control" name="accountID" id="accountID" readonly required value="<%=accountID%>">
                                    </div>
                                    First Name
                                    <div class="field input-field">
                                        <input type="text" placeholder="First Name" class="input form-control" name="firstName" id="firstName" required value="<%=firstName%>">
                                    </div>
                                    Last Name
                                    <div class="field input-field">
                                        <input type="text" placeholder="Last Name" class="input form-control" name="lastName" id="lastName" required value="<%=lastName%>">
                                    </div>
                                    Username
                                    <div class="field input-field">
                                        <input type="text" placeholder="Username" class="input form-control" name="username" id="username" required value="<%=username%>">
                                    </div>
                                    Email
                                    <div class="field input-field">
                                        <input type="email" placeholder="Email" class="input form-control" name="gmail" id="gmail" required value="<%=gmail%>">
                                    </div>
                                    Phone Number
                                    <div class="field input-field">
                                        <input type="tel" placeholder="Phone Number" class="input form-control" name="phoneNumber" id="phoneNumber" required value="<%=phoneNumber%>">
                                    </div>
                                </div>

                                <div class="right-form-section">
                                    Gender
                                    <select name="gender" id="gender" class="field input-field" required>
                                        <option value="Male" <%= gender.equals("Male") ? "selected" : ""%>>Male</option>
                                        <option value="Female" <%= gender.equals("Female") ? "selected" : ""%>>Female</option>
                                        <option value="Other" <%= gender.equals("Other") ? "selected" : ""%>>Other</option>
                                    </select>
                                    IC
                                    <div class="field input-field">
                                        <input type="text" placeholder="IC Number" class="input form-control" name="ic" id="ic" required value="<%=ic%>">
                                    </div>
                                    Birthday
                                    <div class="field input-field">
                                        <% if (birthday.equals("") || birthday == null) {%>
                                        <input type="date" placeholder="Birthday" class="input form-control" name="birthday" id="birthday" value="<%=birthday%>">
                                        <% } else {%>
                                        <input type="date" class="input form-control" value="<%=birthday%>" readonly>
                                        <input type="hidden" placeholder="Birthday" class="input form-control" name="birthday" id="birthday" value="<%=birthday%>">
                                        <% }%>
                                            <!--<input type="date" placeholder="Birthday" class="input form-control" name="birthday" id="birthday" value="<%=birthday%>">-->
                                    </div>
                                    Password 
                                    <div class="field input-field">
                                        <input type="password" placeholder="Password" class="password form-control" name="password" id="password" required value="<%=password%>">
                                    </div>
                                    Confirm password
                                    <div class="field input-field">
                                        <input type="password" placeholder="Confirm password" class="password form-control" name="confirmPassword" id="confirmPassword" required value="<%=password%>">
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
                                <input type="submit" id="updateBtn" name="updateBtn" class="btn btn-primary" value="UPDATE"/>
                            </div>
                        </form>
                    </div>
                </div>
            </section>

        </div>


        <script src="../../js/adminDarkMode.js"></script>
        <script src="../../js/addStaff.js"></script>
    </body>
</html>

