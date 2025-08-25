<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Account" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%
        Account account = (Account) session.getAttribute("account");

        String firstName = "";
        String lastName = "";
        String gmail = "";
        String phoneNumber = "";
        String gender = "";
        String address = "";
        String ic = "";
        String birthday = "";
        String username = "";
        if (account != null) {
            if (account.getFirstName() != null) {
                firstName = account.getFirstName();

            }
            if (account.getLastName() != null) {
                lastName = account.getLastName();

            }
            if (account.getGmail() != null) {
                gmail = account.getGmail();

            }
            if (account.getPhoneNumber() != null) {
                phoneNumber = account.getPhoneNumber();

            }
            if (account.getGender() != null) {
                gender = account.getGender();

            }
            if (account.getAddress() != null) {
                address = account.getAddress();

            }
            if (account.getIc() != null) {
                ic = account.getIc();

            }
            if (account.getBirthday() != null) {
                birthday = account.getBirthday();

            }
            if (account.getUsername() != null) {
                username = account.getUsername();

            }

            // Clear account data from session
            session.removeAttribute("account");
        }

        if (gender == "" || gender == null) {
            gender = "Male";
        }
        String errorMsg = (String) session.getAttribute("errorMsg");
    %>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${companyName} | Sign Up</title>
        <link rel="icon" type="image/png" href="../pic/logo3.png"/>

        <!-- CSS -->
        <link rel="stylesheet" href="../css/styles.css">

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>

        <!-- JavaScript -->
        <!--<script src="js/script.js"></script>-->

    </head>
    <body>
        <section class="container forms">

            <!-- Signup Form -->

            <div class="form signup">
                <div class="form-content">
                    <header>Signup</header>
                    <form action="../SignupServlet" method="post">

                        <div class="form-section">
                            <div class="left-form-section">
                                First Name
                                <div class="field input-field">
                                    <input type="text" placeholder="First Name" class="input" name="firstName" id="firstName" required value="<%= firstName%>">
                                </div>
                                Last Name
                                <div class="field input-field">
                                    <input type="text" placeholder="Last Name" class="input" name="lastName" id="lastName" required value="<%= lastName%>">
                                </div>
                                Email
                                <div class="field input-field">
                                    <input type="email" placeholder="Email" class="input" name="gmail" id="gmail" required value="<%= gmail%>">
                                </div>
                                Phone Number
                                <div class="field input-field">
                                    <input type="tel" placeholder="Phone Number" class="input" name="phoneNumber" id="phoneNumber" required value="<%= phoneNumber%>">
                                </div>
                                Gender
                                <select name="gender" id="gender" class="field input-field" required>
                                    <option value="Male" <%= gender.equals("Male") ? "selected" : ""%>>Male</option>
                                    <option value="Female" <%= gender.equals("Female") ? "selected" : ""%>>Female</option>
                                    <option value="Other" <%= gender.equals("Other") ? "selected" : ""%>>Other</option>
                                </select>


                                <div style="padding-top:15px">
                                    <label>
                                        <input type="radio" name="correctRadioButton" value="true" required>
                                        Yes, the entered information is correct
                                    </label>
                                </div>
                            </div>

                            <div class="right-form-section">
                                Address
                                <div class="field input-field">
                                    <input type="text" placeholder="Address" class="input" name="address" id="address" required value="<%= address%>">
                                </div>
                                IC
                                <div class="field input-field">
                                    <input type="text" placeholder="IC Number" class="input" name="ic" id="ic" required value="<%= ic%>">
                                </div>
                                Birthday
                                <div class="field input-field">
                                    <input type="date" placeholder="Birthday" class="input" name="birthday" id="birthday" required value="<%= birthday%>">
                                </div>
                                Username
                                <div class="field input-field">
                                    <input type="text" placeholder="Username" class="input" name="username" id="username" required value="<%= username%>">
                                </div>
                                Password 
                                <div class="field input-field">
                                    <input type="password" placeholder="Password" class="password" name="password" id="password" required>
                                </div>
                                Confirm password
                                <div class="field input-field">
                                    <input type="password" placeholder="Confirm password" class="password" name="confirmPassword" id="confirmPassword" required>
                                </div>
                                <div>
                                     <input type="checkbox" id="showPassword" onchange="togglePasswordVisibility(this)">
                                     <label for="showPassword">Show Password</label>
                                </div>

                            </div>
                        </div>
                        <small style="color: red">Password length must be more than 6 and include at least 1 lower, upper, special, number character</small>

                        <div class="field button-field">
                            <button>Signup</button>
                        </div>
                    </form>

                    <div class="form-link">
                        <span>Already have an account? <a href="login.jsp" class="link login-link">Login</a></span>
                    </div>
                </div>

            </div>
            <%
                if (errorMsg != null && !errorMsg.equals("")) {
                    // Split error messages by newline character and create line breaks
                    String[] errorMessages = errorMsg.split("\n");
            %>
            <div class="error-msg-box">
                <header>Error Messages</header>
                    <%
                        int index = 1;
                        for (String message : errorMessages) {
                    %>
                <small style="color:red"><%=index++%>. <%= message%></small><br>
                <%
                    }
                %>
            </div>
            <%
                }
                session.removeAttribute("errorMsg");
            %>
        </section>

        <script src="../../js/addStaff.js"></script>
    </body>
</html>
