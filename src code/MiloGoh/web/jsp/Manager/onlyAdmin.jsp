
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../../css/onlyAdmin.css" />
        <title>${companyName} | Access Denied</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
    </head>
    <body>
        <div class="access-denied-message">
            <h1>Access Denied</h1>
            <p>This page can only be accessed by administrators.</p>
            <p>Please login to access.</p>
            <form action="../login.jsp">
                <button type="submit" class="onlyAdminbtn onlyAdminbtn-primary" onclick="redirectToLogin()">CONFIRM</button>
            </form>
        </div>
    </body>
</html>
<script>
    function redirectToLogin() {
        window.location.href = "../login.jsp";
    }
</script>