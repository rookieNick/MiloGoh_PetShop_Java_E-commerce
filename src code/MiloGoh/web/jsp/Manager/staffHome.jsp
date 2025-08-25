
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${companyName} | Manager Home Page</title>
  <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
  <!-- CSS -->
  <link rel="stylesheet" href="../../css/staffStyle.css" />
  <!-- Boxicons CSS -->
  <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
</head>
<body id="AdminHomePage">
  <%@include file="managerNavBar.jsp" %>

    
    <div class="body-content">
        <div id="currentTime"></div>
        <!-- manager home page -->
        <section class="content" id="welcomeAdminMsg">
            <h1>Welcome back <%= acc.getUsername() %>!</h1>
        </section>
        <div>
            <div class="suggestTasks">You may need to do the following tasks</div>
            <div class="adminHomeBtnDiv">
                <% if(acc.getPosition().equals("Manager")) { %>
                <div class="shortcutButton"><a href="addStaff.jsp">Add Staff</a></div>
                <div class="shortcutButton"><a href="addItem.jsp">Add Item</a></div>
                <div class="shortcutButton"><a href="salesReport.jsp">Sales Report</a></div>
                <% } else { %>
                <div class="shortcutButton longStfBtn"><a href="addCustomer.jsp">Add Customer</a></div>
                <div class="shortcutButton longStfBtn"><a href="addItem.jsp">Add Item</a></div>
                <div class="shortcutButton longStfBtn"><a href="manageCustomerOrder.jsp">Customer Order</a></div>
                <% } %>
            </div>
        </div>
    </div>
    

          <script src="../../js/adminDarkMode.js"></script>
            <script>
    // Function to update time every second
    function updateTime() {
      var currentTimeElement = document.getElementById("currentTime");
      var currentTime = new Date();
      var hours = currentTime.getHours();
      var minutes = currentTime.getMinutes();
      var seconds = currentTime.getSeconds();
      // Add leading zeros if needed
      hours = (hours < 10 ? "0" : "") + hours;
      minutes = (minutes < 10 ? "0" : "") + minutes;
      seconds = (seconds < 10 ? "0" : "") + seconds;
      // Display the current time
      currentTimeElement.textContent = "Malaysia Time : " + hours + ":" + minutes + ":" + seconds + "";
    }
    // Call updateTime initially to avoid delay
    updateTime();
    // Call updateTime every second
    setInterval(updateTime, 1000);
  </script>
</body>
</html>

