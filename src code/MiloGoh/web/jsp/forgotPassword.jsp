<%@page import="control.MaintainAccountControl"%>
<!DOCTYPE html>
<%@ page import="domain.Account" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    Account account = (Account) session.getAttribute("account");

    String gmail = "";
    if (account != null) {
        gmail = account.getGmail();

        // Clear account data from session
        session.removeAttribute("account");
    }

    String errorMsg = (String) session.getAttribute("errorMsg");

    String success = (String) request.getParameter("success");
    
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${companyName} | Forgot Password</title>

        <!-- CSS -->
        <link rel="stylesheet" href="../css/forgotPassword.css">

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>
        <section class="container forms">
            <div class="form forgot-password">
                <div class="form-content">
                    <header>Forgot Password</header>
                    <form id="forgotPasswordForm" action="../ForgotPasswordServlet" method="post">
                        <% if (success != null && success.equals("1")) { %>
                        <div class="field input-field">
                            <span style="color:greenyellow">Reset password successfully!</span>
                        </div>
                        <% } %>
                        <div class="field input-field">
                            <input type="email" placeholder="Email" class="input" name="gmail" id="gmail" required>
                        </div>

                        <div class="otp">
                            <div class="field input-field">
                                <input type="text" placeholder="Enter OTP" class="input" name="otp" id="otp" required>
                            </div>
                            <div class="field button-field" style="width:100px">
                                <button type="button" onclick="sendOTP()">Send OTP</button>
                            </div>
                        </div>

                        <div class="field input-field">
                            <input type="password" placeholder="New Password" class="password" name="newPassword" id="newPassword" required>
                        </div>
                        <small style="color: red">Password length must be more than 6 and include at least 1 lower, upper, special, number character</small>

                        <div class="field button-field">
                            <button type="button" onclick="validateForm()">Reset Password</button>
                        </div>
                    </form>

                    <div class="form-link">
                        <span>Remember your password? <a href="login.jsp" class="link">Login</a></span>
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

        <script>
            var generatedOTP;

            function sendOTP() {
                var gmailInput = document.getElementById('gmail');
                if (gmailInput.value === '') {
                    alert('Please enter your email.');
                    return;
                }
                // Generate random 6-digit OTP
                generatedOTP = Math.floor(100000 + Math.random() * 900000);

                // Create desktop notification
                if (Notification.permission === "granted") {
                    var notification = new Notification("Password Reset OTP", {
                        body: "Your OTP is: " + generatedOTP,
                    });
                } else if (Notification.permission !== "denied") {
                    Notification.requestPermission().then(function (permission) {
                        if (permission === "granted") {
                            var notification = new Notification("Your OTP", {
                                body: "Your OTP is: " + generatedOTP,
                            });
                        }
                    });
                }
            }

            function validateForm() {
                var otpInput = document.getElementById('otp');
                var newPasswordInput = document.getElementById('newPassword');

                if (otpInput.value === '') {
                    alert('Please enter the OTP.');
                    return;
                }

                if (newPasswordInput.value === '') {
                    alert('Please enter the new password.');
                    return;
                }

                // Compare entered OTP with generated OTP
                if (parseInt(otpInput.value) !== generatedOTP) {
                    alert('Incorrect OTP. Please try again.');
                    return;
                }

                document.getElementById('forgotPasswordForm').submit();
            }
        </script>
    </body>
</html>
