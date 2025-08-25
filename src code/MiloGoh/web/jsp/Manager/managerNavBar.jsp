<%@page import="domain.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve the account object from the session
    Account acc = (Account) session.getAttribute("staffAccount");

    if (acc == null) {
        // Redirect the user to the login page or show an error message
        response.sendRedirect("onlyAdmin.jsp"); // Change "login.jsp" to your actual login page
        return; // Stop further execution of the JSP page
    }

    if (acc.getPosition().equals("Customer")) {
        // Redirect the user to the login page or show an error message
        response.sendRedirect("onlyAdmin.jsp"); // Change "login.jsp" to your actual login page
        return; // Stop further execution of the JSP page
    }
%>
<nav>
    <!-- top nav bar, filter button -->
    <!-- manage Customer -->a
    <% if (request.getRequestURI().endsWith("manageCustomer.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <div class="manageHead">
        <a href="addCustomer.jsp" class="nav-link" >
            <i class="bx bx-plus-circle icon"></i>
            <span class="link">Add Customer</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("addCustomer.jsp")) { %>
    <div class="manageHead">
        <a href="manageCustomer.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <%}%>
    <!-- manage staff -->
    <% if (request.getRequestURI().endsWith("manageStaff.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <div class="manageHead">
        <a href="addStaff.jsp" class="nav-link">
            <i class="bx bx-plus-circle icon"></i>
            <span class="link">Add Staff</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("addStaff.jsp")) { %>
    <div class="manageHead">
        <a href="manageStaff.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <%}%><!-- manage Promotion 6969 -->
    <% if (request.getRequestURI().endsWith("managePromotion.jsp")) { %>
    <div class="manageHead">
        <a href="addPromotion.jsp" class="nav-link">
            <i class="bx bx-plus-circle icon"></i>
            <span class="link">Add Promotion</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("promoProfile.jsp")) {%>
    <div class="manageHead">
        <a href="managePromotion.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("addPromotion.jsp")) {%>
    <div class="manageHead">
        <a href="managePromotion.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <% } %>
    <!-- manage Item -->
    <% if (request.getRequestURI().endsWith("manageItem.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <div class="manageHead">
        <a href="addItem.jsp" class="nav-link">
            <i class="bx bx-plus-circle icon"></i>
            <span class="link">Add Item</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("addItem.jsp")) {%>
    <div class="manageHead">
        <a href="manageItem.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <%}%>

    <!-- salesRecord -->
    <% if (request.getRequestURI().endsWith("salesRecords.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <%}%>
    <!-- manage CustomerOrder -->
    <% if (request.getRequestURI().endsWith("manageCustomerOrder.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <% } else if (request.getRequestURI().endsWith("orderProfile.jsp") && acc.getPosition().equals("Staff")) {%>
    <div class="manageHead">
        <a href="manageCustomerOrder.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <%} else if (request.getRequestURI().endsWith("orderProfile.jsp") && acc.getPosition().equals("Manager")) {%>
    <div class="manageHead">
        <a href="salesRecords.jsp" class="nav-link">
            <i class="bx bx-chevron-left icon"></i>
            <span class="link">Back</span>
        </a>
    </div>
    <% } %>
    <!-- salesReport -->
    <% if (request.getRequestURI().endsWith("salesReport.jsp")) {
    %>
    <%@include file="statusFilter.jsp" %>
    <%}%>

    <!-- left side bar -->
    <div class="sidebar">
        <div class="logo">
            <%if (acc.getPosition().equals("Manager")) {%>
            <span class="logo-name">Manager Page</span>
            <%} else {%>
            <span class="logo-name">Staff Page</span>
            <%}%>
        </div>
        <!--     <small>miloGoh</small>-->
        <div class="sidebar-content">
            <ul class="lists">
                <% if (!acc.getStatus().equals("Unset")) {%>
                <li class="list <% if (request.getRequestURI().endsWith("staffHome.jsp")) {
                        out.print("active");
                    } %>" data-content="AdminHome">
                    <a href="staffHome.jsp" class="nav-link">
                        <i class="bx bx-home-alt icon"></i>
                        <span class="link">Home</span>
                    </a>
                </li>
                <%}%>
                <%if (acc.getPosition().equals("Manager")) {%>
                <li class="list <% if (request.getRequestURI().endsWith("manageStaff.jsp") || request.getRequestURI().endsWith("addStaff.jsp") || request.getRequestURI().endsWith("registerStaffSuccessful.jsp")) {
                        out.print("active");
                    } %>" data-content="manageStaff">
                    <a href="manageStaff.jsp" class="nav-link">
                        <i class="bx bx-group icon"></i>
                        <span class="link">Manage Staff</span>
                    </a>
                </li>
                <%}%>
                <% if (!acc.getStatus().equals("Unset")) {%>
                <li class="list <% if (request.getRequestURI().endsWith("manageCustomer.jsp") || request.getRequestURI().endsWith("addCustomer.jsp")) {
                        out.print("active");
                    } %>" data-content="manageCustomer">
                    <a href="manageCustomer.jsp" class="nav-link">
                        <i class="bx bx-archive icon"></i>
                        <span class="link">Manage Customer</span>
                    </a>
                </li>
                <li class="list <% if (request.getRequestURI().endsWith("manageItem.jsp") || request.getRequestURI().endsWith("addItem.jsp") || request.getRequestURI().endsWith("productProfile.jsp")) {
                        out.print("active");
                    } %>" data-content="manageItem">
                    <a href="manageItem.jsp" class="nav-link">
                        <i class="bx bx-store icon"></i>
                        <span class="link">Manage Item</span>
                    </a>
                </li>
                <%if (acc.getPosition().equals("Staff")) {%>
                <li class="list <% if (request.getRequestURI().endsWith("manageCustomerOrder.jsp") || request.getRequestURI().endsWith("orderProfile.jsp")) {
                        out.print("active");
                    } %>" data-content="manageCustomerOrder">
                    <a href="manageCustomerOrder.jsp" class="nav-link">
                        <i class="bx bx-shopping-bag icon"></i>
                        <span class="link">Customer Order</span>
                    </a>
                </li>
                <% }
                    } %>

                <%if (acc.getPosition().equals("Manager")) {%>
                <li class="list <% if (request.getRequestURI().endsWith("managePromotion.jsp") || request.getRequestURI().endsWith("promoProfile.jsp") || request.getRequestURI().endsWith("addPromotion.jsp")) {
                        out.print("active");
                    } %>" data-content="promotion">
                    <a href="../../viewPromotion" class="nav-link">
                        <i class="bx bx-gift icon"></i>
                        <span class="link">Promotion</span>
                    </a>
                </li>
                <li class="list <% if (request.getRequestURI().endsWith("salesRecords.jsp") || request.getRequestURI().endsWith("orderProfile.jsp")) {
                        out.print("active");
                    } %>" data-content="salesRecords">
                    <a href="salesRecords.jsp" class="nav-link">
                        <i class="bx bx-file icon"></i>
                        <span class="link">Sales Records</span>
                    </a>
                </li>
                <li class="list <% if (request.getRequestURI().endsWith("salesReport.jsp")) {
                        out.print("active");
                    } %>" data-content="salesReport">
                    <a href="salesReport.jsp" class="nav-link">
                        <i class="bx bx-line-chart icon"></i>
                        <span class="link">Sales Report</span>
                    </a>
                </li>
                <%}%>
                <li class="list <% if (request.getRequestURI().endsWith("staffEditProfile.jsp"))
                            out.print("active");%>" data-content="staffEditProfile">
                    <a href="staffEditProfile.jsp" class="nav-link">
                        <i class="bx bx-wrench icon"></i>
                        <span class="link">Edit Profile</span>
                    </a>
                </li>
            </ul>
            <div class="bottom-content">
                <div>
                    <div class="darkBtnHolder">
                        <img src="../../pic/light.png" id="lightIcon" class="dark-icon"><img src="../../pic/moon.png" id="moonIcon" class="dark-icon">

                        <div class="darkButton darkBtn" id="darkSwitch">
                            <div class="darkCircle darkBtn" id="darkCircle"></div>
                        </div>
                    </div>
                </div>
                <li class="list" data-content="logout">
                    <a href="../../LogoutServlet" class="nav-link">
                        <i class="bx bx-log-out icon"></i>
                        <span class="link">Logout</span>
                    </a>
                </li>
            </div>
        </div>
    </div>
</nav>
<script>
    //var adminSettingWindow = null; // Variable to store the reference to the adminSetting window
    const button = document.getElementById('darkSwitch');
    const circle = document.getElementById('darkCircle');
    const body = document.body;
    var darkMode = localStorage.getItem('darkMode');

    if (darkMode === null) {
        darkMode = false;
    } else {
        // Parse the dark mode preference as a boolean
        darkMode = darkMode === 'true';
    }

    // Add an event listener for the DOMContentLoaded event
    document.addEventListener('DOMContentLoaded', function () {
        // Your code here
        var darkMode = localStorage.getItem('darkMode');
        var button = document.getElementById('darkSwitch');
        var circle = document.getElementById('darkCircle');
        var body = document.body;

        if (darkMode !== null) {
            if (darkMode === 'true') {
                circle.style.left = 'calc(100% - 25px)';
                circle.style.background = 'black';
                button.style.background = 'white';
                body.style.background = 'black';
                body.style.color = 'white';
            } else {
                circle.style.left = '5px';
                circle.style.background = 'white';
                button.style.background = 'black';
                body.style.background = '#e3f2fd';
                body.style.color = 'black';
            }
        }
    });


    button.addEventListener('click', () => {
        darkMode = !darkMode;
        if (darkMode) {
            circle.style.left = 'calc(100% - 25px)';
            circle.style.background = 'black';
            button.style.background = 'white';

            body.style.background = 'black';
            body.style.color = 'white';

            // Save the dark mode preference in local storage
            localStorage.setItem('darkMode', true);
            console.log('Dark mode enabled. Value in localStorage:', localStorage.getItem('darkMode'));

            document.body.classList.add('dark-mode');

            var elementsToAddDarkMode = document.querySelectorAll('nav, nav .sidebar, .logo .logo-name, #addCustForm, #addCustCardBody, #addCustContainer, #addStaffForm, #addCustCardBody, #editStaffForm, #regStaffSuccessBox, #addItemForm, #addItemCardBody, #addItemContainer, #itemProfileForm, #itemProfileCardBody, #itemProfileContainer');
            elementsToAddDarkMode.forEach(function (element) {
                element.classList.add('dark-mode');
            });

            var elementToAddWhiteWord = document.querySelectorAll('.nav-link .link, .nav-link .icon');
            elementToAddWhiteWord.forEach(function (element) {
                element.classList.add('white-word');
            });

            //TABLE
            // Add border styles when dark mode is true
            var nav = document.querySelector('nav');
            nav.style.borderBottom = '2px solid darkgray';
            var sidebar = document.querySelector('nav .sidebar');
            sidebar.style.borderRight = '2px solid darkgray';

            // Modify the CSS selector for thead td in dark mode
            var tableHeaderCells = document.querySelectorAll('table, #addStaffPage');
            tableHeaderCells.forEach(function (cell) {
                cell.classList.add('dark-mode');
            });

        } else {
            circle.style.left = '5px';
            circle.style.background = 'white';
            button.style.background = 'black';

            body.style.background = '#e3f2fd';
            body.style.color = 'black';

            // Save the dark mode preference in local storage
            localStorage.setItem('darkMode', false);
            console.log('Dark mode disabled. Value in localStorage:', localStorage.getItem('darkMode'));

            document.body.classList.remove('dark-mode');

            var elementsToAddDarkMode = document.querySelectorAll('nav, nav .sidebar, .logo .logo-name, #addCustForm, #addCustCardBody, #addCustContainer, #addStaffForm, #addCustCardBody, #editStaffForm, #regStaffSuccessBox, #addItemForm, #addItemCardBody, #addItemContainer, #itemProfileForm, #itemProfileCardBody, #itemProfileContainer');
            elementsToAddDarkMode.forEach(function (element) {
                element.classList.remove('dark-mode');
            });

            var elementToAddWhiteWord = document.querySelectorAll('.nav-link .link, .nav-link .icon');
            elementToAddWhiteWord.forEach(function (element) {
                element.classList.remove('white-word');
            });

            //TABLE
            // Remove border styles when dark mode is false
            var nav = document.querySelector('nav');
            nav.style.borderBottom = '';
            var sidebar = document.querySelector('nav .sidebar');
            sidebar.style.borderRight = '';

            // Modify the CSS selector for thead td in dark mode
            var tableHeaderCells = document.querySelectorAll('table, #staffEditProfilePage');
            tableHeaderCells.forEach(function (cell) {
                cell.classList.remove('dark-mode');
            });
        }
    });
</script>