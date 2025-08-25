<!DOCTYPE html>
<html lang="en">
    <%
        String error = (String) request.getParameter("error");
        String success = (String) request.getParameter("success");
    %>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${companyName} | Login</title>

        <!-- CSS -->
        <link rel="stylesheet" href="../css/styles.css">
        <link rel="icon" type="image/png" href="../pic/logo3.png"/>

        <!-- Boxicons CSS -->
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>

        <!-- JavaScript -->
        <!--<script src="login_register.js"></script>-->

    </head>
    <body>
        <section class="container forms">
            <div class="form login">
                <div class="form-content">
                    <header>Login</header>
                    <% if (error != null && error.equals("1")) { %>
                    <div class="form-link">
                        <span style="color:red">Login error! Invalid username or password</span>
                    </div>
                    <% } %>
                    <% if (success != null && success.equals("1")) { %>
                    <div class="form-link">
                        <span style="color:greenyellow">Account created successfully!</span>
                    </div>
                    <% } %>
                    <form action="../LoginServlet" method="post">
                        <div class="field input-field">
                            <input type="text" placeholder="Username" class="input" name="username" id="username">
                        </div>

                        <div class="field input-field">
                            <input type="password" placeholder="Password" class="password" name="password" id="password">
                        </div>

                        <div class="form-link">
                            <a href="forgotPassword.jsp" class="forgot-pass">Forgot password?</a>
                            
                        </div>
                        
                        <div class="form-link">
                            <a href="home.jsp" class="back-main">Back to Main Page</a>
                        </div>



                        <div class="field button-field">
                            <button>Login</button>
                        </div>
                    </form>

                    <div class="form-link">
                        <span>Don't have an account? <a href="signup.jsp" class="link signup-link">Signup</a></span>
                    </div>
                    
                </div>
            </div>

        </section>


    </body>
</html>
