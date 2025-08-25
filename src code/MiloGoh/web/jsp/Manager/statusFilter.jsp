<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form action="../../StatusFilterServlet" method="post" id="statusFilterForm">
    <div id="statusFilterDiv">
        <% String filterSelection = (String) session.getAttribute("filterSelection"); // for all
            String startDateStr = (String) session.getAttribute("startDateStr"); //for report
            String endDateStr = (String) session.getAttribute("endDateStr"); //for report
            String searchItemBy = (String) session.getAttribute("searchItemBy"); //for manage Item
            if (filterSelection == null) {
                filterSelection = "null";
            }
            if (startDateStr == null) {
                startDateStr = "";
            }
            if (endDateStr == null) {
                endDateStr = "";
            }
            if (searchItemBy == null) {
                searchItemBy = "";
            }

        %>
        <% if (request.getRequestURI().endsWith("salesRecords.jsp")) { %>
        <label for="statusFilter" class="filter-label">Type of Records:</label>
        <select id="statusFilterSelection" name="statusFilterSelection" class="filter-select">
            <option value="All" <% if ("All".equals(filterSelection)) { %>selected<% } %> >All</option>
            <option value="Daily" <% if ("Daily".equals(filterSelection)) { %>selected<% } %> >Daily</option>
            <option value="Weekly" <% if ("Weekly".equals(filterSelection)) { %>selected<% } %> >Weekly</option>
            <option value="Monthly" <% if ("Monthly".equals(filterSelection)) { %>selected<% } %> >Monthly</option>
        </select>
        <% } else if (request.getRequestURI().endsWith("salesReport.jsp")) {%>
        <label for="startDate" class="filter-label">Start Date:</label>
        <input type="date" id="startDate" name="startDate" class="filter-select" value="<%= startDateStr%>" required>
        <input type="hidden" id="startDateStr" value="<%= startDateStr%>">

        <label for="endDate" class="filter-label">End Date:</label>
        <input type="date" id="endDate" name="endDate" class="filter-select" value="<%= endDateStr%>" required>
        <input type="hidden" id="endDateStr" value="<%= endDateStr%>">
        <label for="statusFilter" class="filter-label">Order By:</label>
        <select id="statusFilterSelection" name="statusFilterSelection" class="filter-select">
            <option value="TotalQty" <% if ("TotalQty".equals(filterSelection)) { %>selected<% } %> >Total Qty</option>
            <option value="TotalOrderedTime" <% if ("TotalOrderedTime".equals(filterSelection)) { %>selected<% } %> >Total Ordered Time</option>
        </select>

        <% } else if (request.getRequestURI().endsWith("manageCustomerOrder.jsp")) { %>
        <label for="statusFilter" class="filter-label">Filter by Status:</label>
        <select id="statusFilterSelection" name="statusFilterSelection" class="filter-select">
            <option value="All" <% if ("All".equals(filterSelection)) { %>selected<% } %> >All</option>
            <option value="Paid" <% if ("Paid".equals(filterSelection)) { %>selected<% } %> >Paid</option>
            <option value="Unpaid" <% if ("Unpaid".equals(filterSelection)) { %>selected<% } %> >Unpaid</option>
        </select>
        <% } else { %>
        <label for="statusFilter" class="filter-label">Filter by Status:</label>
        <select id="statusFilterSelection" name="statusFilterSelection" class="filter-select">
            <option value="All" <% if ("All".equals(filterSelection)) { %>selected<% } %> >All</option>
            <option value="Active" <% if ("Active".equals(filterSelection)) { %>selected<% } %> >Active</option>
            <% if (request.getRequestURI().endsWith("manageItem.jsp")) { %>
                <option value="Inactive" <% if ("Inactive".equals(filterSelection)) { %>selected<% } %> >Inactive</option>
            </select>
                <label for="SearchBy" class="filter-label">Search By:</label>
                <input type="text" class="form-control" style="height: 30px;" placeholder="Search" aria-label="Receipient's username" aria-describely="basic-addon2" name="searchItemBy" id="searchItemBy" value="<%= searchItemBy%>">

            <% } else if (request.getRequestURI().endsWith("manageCustomer.jsp")) { %> 
            <option value="Deleted" <% if ("Deleted".equals(filterSelection)) { %>selected<% } %> >Deleted</option>
            </select>
            <% } else if (request.getRequestURI().endsWith("manageStaff.jsp")) { %>
            <option value="Unset" <% if ("Unset".equals(filterSelection)) { %>selected<% } %> >Unset</option>
            <option value="Deleted" <% if ("Deleted".equals(filterSelection)) { %>selected<% } %> >Deleted</option>
            </select>
            <% }
        } %>

        <%
                if (request.getRequestURI().endsWith("manageCustomer.jsp")) {%>
        <input type="hidden" name="tableType" value="Customer">
        <% } else if (request.getRequestURI().endsWith("manageStaff.jsp")) { %>
        <input type="hidden" name="tableType" value="Staff">
        <% } else if (request.getRequestURI().endsWith("manageItem.jsp")) { %>
        <input type="hidden" name="tableType" value="Item">
        <% } else if (request.getRequestURI().endsWith("salesRecords.jsp")) { %>
        <input type="hidden" name="tableType" value="salesRecords">
        <% } else if (request.getRequestURI().endsWith("salesReport.jsp")) { %>
        <input type="hidden" name="tableType" value="salesReport">
        <% } else if (request.getRequestURI().endsWith("manageCustomerOrder.jsp")) { %>
        <input type="hidden" name="tableType" value="customerOrder">
        <% }%>
        <button type="submit" class="filter-btn">Filter</button>
    </div>
</form>
<style>
</style>
<script>
    //get current date
    var currentDate = new Date();

    var startDateInput = document.getElementById("startDate");
    var endDateInput = document.getElementById("endDate");

    //retrieve startDateStr from the hidden input field
    var startDateStr = document.getElementById("startDateStr").value;
    var endDateStr = document.getElementById("endDateStr").value;

    //set default date range
    if (!startDateStr.trim()) { //if startDateStr is empty
        var firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 2);
        startDateInput.valueAsDate = firstDayOfMonth;

        var lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 1);
        endDateInput.valueAsDate = lastDayOfMonth;
    }

    // Add event listener to startDate input field
    startDateInput.addEventListener("change", function () {
        var startDate = new Date(startDateInput.value);
        var endDate = new Date(endDateInput.value);
        if (startDate > endDate) {
            dateRangeError();
            // Reset start date value to previous value
            startDateInput.valueAsDate = new Date(startDateStr); //set it back
        }
    });

    // Add event listener to startDate input field
    endDateInput.addEventListener("change", function () {
        var startDate = new Date(startDateInput.value);
        var endDate = new Date(endDateInput.value);
        if (startDate > endDate) {
            dateRangeError();
            // Reset start date value to previous value
            endDateInput.valueAsDate = new Date(endDateStr); //set it back
        }
    });

    function dateRangeError() {
        Swal.fire({
            icon: "error",
            title: "ERROR",
            text: "Start date cannot be greater than end date!",
        });
    }

</script>