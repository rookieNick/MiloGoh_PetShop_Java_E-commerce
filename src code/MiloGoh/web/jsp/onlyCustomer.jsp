
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
            <p>Page can only be accessed by customers.</p>
            <p>Please back to home.</p>
            <form action="../LogoutServlet" method="post">
                <button type="submit" class="onlyAdminbtn onlyAdminbtn-primary">CONFIRM</button>
            </form>
        </div>
    </body>
</html>