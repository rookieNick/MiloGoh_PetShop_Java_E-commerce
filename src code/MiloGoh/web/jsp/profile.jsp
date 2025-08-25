<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page import="domain.Account" %>
    <%@ page import="control.MaintainAccountControl" %>
    <%@ page import="javax.servlet.http.HttpSession" %>
    <%
        //get current login account info
        Account account = (Account) session.getAttribute("account");
        Account Staffacc = (Account) session.getAttribute("staffAccount");

        String userPosition = "";

        int accountID = 0;
        String firstName = "";
        String lastName = "";
        String gmail = "";
        String phoneNumber = "";
        String gender = "";
        String address = "";
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

        //for staff & manager to view customer profile
        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            String customerID = request.getParameter("id");
            MaintainAccountControl accountControl = new MaintainAccountControl();
            account = accountControl.selectRecord(customerID);

            accountID = account.getAccountID();
            firstName = account.getFirstName();
            lastName = account.getLastName();
            gmail = account.getGmail();
            phoneNumber = account.getPhoneNumber();
            gender = account.getGender();
            address = account.getAddress();
            ic = account.getIc();
            birthday = account.getBirthday();
            username = account.getUsername();
            password = account.getPassword();
            created_date = account.getCreated_date();
            updated_date = account.getUpdated_date();
            status = account.getStatus();
            wallet = account.getWallet();
            position = account.getPosition();

            created_by = account.getCreated_by();
            updated_by = account.getUpdated_by();
        } //for customer login to get customer login account info
        else if (account != null) {
            accountID = account.getAccountID();
            firstName = account.getFirstName();
            lastName = account.getLastName();
            gmail = account.getGmail();
            phoneNumber = account.getPhoneNumber();
            gender = account.getGender();
            address = account.getAddress();
            ic = account.getIc();
            birthday = account.getBirthday();
            username = account.getUsername();
            password = account.getPassword();
            created_date = account.getCreated_date();
            updated_date = account.getUpdated_date();
            status = account.getStatus();
            wallet = account.getWallet();
            position = account.getPosition();

            created_by = account.getCreated_by();
            updated_by = account.getUpdated_by();

        }

        if (Staffacc != null) {
            userPosition = Staffacc.getPosition();
        }

        //to set default value for new Register Account                             for deleted unset acc
        if (account.getStatus() != null && account.getStatus().equals("Unset") || account.getUsername() == null) {
            accountID = account.getAccountID();
            firstName = "N/A";
            lastName = "N/A";
            gmail = account.getGmail();
            phoneNumber = "";
            gender = "Male";    //default value
            address = "N/A";
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
            updated_by = "";
        }
        String testGender = account.getGender();
        if (testGender == null) {
            gender = "Male";    //default value
        }

    %>

    <%        String success = (String) request.getParameter("success");
        String errorMsgProfile = (String) session.getAttribute("errorMsgProfile");
    %>
    <head>
        <meta charset="utf-8">


        <title>${companyName} | Profile</title>
        <link rel="icon" type="image/png" href="../pic/logo3.png"/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/profile.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            //to check if it is staff then profile read only
            window.onload = function () {
                var staffPosition = '<%= Staffacc != null ? Staffacc.getPosition() : ""%>';

                if (staffPosition === 'Staff') {
                    var genderField = document.getElementById('gender');
                    if (genderField) {
                        genderField.disabled = true; // Disable the select element
                    }

                    var staffFieldIds = ['#ic', '#password', '#firstName', '#lastName', '#gmail', '#gender', '#address', '#phoneNumber', '#username', '#birthday'];

                    for (var i = 0; i < staffFieldIds.length; i++) {
                        var field = document.querySelector(staffFieldIds[i]);
                        if (field) {
                            field.readOnly = true; // Set the field to readonly
                        }
                    }
                }
            };
        </script>
    </head>
    <body>
        <form id="profileForm" action="../ProfileServlet" method="post">
            <% int accId1 = account.getAccountID();
                int accId2 = Staffacc.getAccountID();
                if (accId1 != accId2) {%> <!-- means is execute using admin acc -->
            <input type="hidden" name="updated_by" value="<%= Staffacc.getUsername()%>">
            <%} else {%> <!-- means is execute using customer acc -->
            <input type="hidden" name="updated_by" value="<%= account.getUsername()%>">
            <% }%>
            <input type="hidden" name="created_by" value="<%= created_by%>">
            <div class="container">
                <div class="row gutters">
                    <div class="card-body">
                        <div class="row gutters">
                            <%
                                if (errorMsgProfile != null && !errorMsgProfile.equals("")) {
                                    // Split error messages by newline character and create line breaks
                                    String[] errorMessages = errorMsgProfile.split("\n");
                            %>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h5 class="mb-2" style="color:red">Error! Please follow format below before proceed to any of the functions</h5>
                                <%
                                    int index = 1;
                                    for (String message : errorMessages) {
                                %>
                                <h6 class="mb-2 " style="color:red"><%=index++%>. <%= message%></h6>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                }
                                session.removeAttribute("errorMsgProfile");
                            %>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h6 class="mb-2 text-primary">Personal Details</h6>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="accountID">Account ID</label>
                                    <input type="text" class="form-control" id="accountID" name="accountID" readonly value="<%=accountID%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="ic">IC (Identity Card)</label>
                                    <input type="text" class="form-control" id="ic" name="ic" required value="<%=ic%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required value="<%=firstName%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required value="<%=lastName%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="gmail">Gmail</label>
                                    <input type="email" class="form-control" id="gmail" name="gmail" required value="<%=gmail%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="form-control" id="gender" name="gender">
                                        <option value="Male" <%= gender.equals("Male") ? "selected" : ""%>>Male</option>
                                        <option value="Female" <%= gender.equals("Female") ? "selected" : ""%>>Female</option>
                                        <option value="Other" <%= gender.equals("Other") ? "selected" : ""%>>Other</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row gutters">
                            <% if (!account.getPosition().equals("Staff")) {%> <!-- staff no address -->
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" required value="<%=address%>">
                                </div>
                            </div>
                            <% }%>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="phoneNumber">Phone Number</label>
                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required value="<%=phoneNumber%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required value="<%=username%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="birthday">Birthday</label>
                                    <% if (birthday.equals("") || birthday == null) {%>
                                    <input type="date" class="form-control" id="birthday" name="birthday" value="<%=birthday%>">
                                    <% } else {%>
                                    <input type="date" class="form-control" value="<%=birthday%>" readonly>
                                    <input type="hidden" class="form-control" id="birthday" name="birthday" value="<%=birthday%>">
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <% if (Staffacc.getPosition().equals("Customer")) {%>
                                    <input type="text" class="form-control" id="password" name="password" required value="<%=password%>">
                                    <% } else if (Staffacc.getPosition().equals("Manager") || Staffacc.getPosition().equals("Staff")) {%>
                                    <input type="text" class="form-control" name="passwordDisplay" value="**********" readonly disabled>
                                    <input type="hidden" name="password" value="<%= password%>">
                                    <% }%>
                                </div>
                            </div>

                        </div>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h6 class="mb-2 text-primary">Account Details</h6>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="created_date">Created Date</label>
                                    <input type="text" class="form-control" id="created_date" name="created_date" readonly value="<%=created_date%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="created_date">Updated Date</label>
                                    <input type="text" class="form-control" id="updated_date" name="updated_date" readonly value="<%=updated_date%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="created_date">Position</label>
                                    <input type="text" class="form-control" id="position" name="position" readonly value="<%=position%>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="created_date">Wallet</label>
                                    <% if (Staffacc.getPosition().equals("Customer")) {%>
                                    <input type="text" class="form-control" id="wallet" name="wallet" readonly value="<%=wallet%>">
                                    <% } else if (Staffacc.getPosition().equals("Manager") || Staffacc.getPosition().equals("Staff")) {%>
                                    <input type="text" class="form-control" name="walletDisplay" value="*******" readonly disabled>
                                    <input type="hidden" name="wallet" value="<%= wallet%>">
                                    <% }%>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="created_date">Status</label>
                                    <input type="text" class="form-control" id="status" name="status" readonly value="<%=status%>">
                                </div>
                            </div>
                        </div>

                        <!-- get current user position to throw to servlet -->
                        <input type="hidden" name="userPosition" value="<%= userPosition%>">

                        <% if (success != null && success.equals("1")) { %>
                        <div class="form-link">
                            <span style="color:greenyellow">Account updated successfully!</span>
                        </div>
                        <% }%>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">

                                    <% if (Staffacc.getPosition().equals("Customer")) {%> <!-- customer manage customer -->
                                    <a href="home.jsp" id="backBtn" name="backBtn" class="btn btn-orange">Back</a>
                                    <input type="submit" id="updateBtn" name="updateBtn" class="btn btn-primary" value="Update"/>
                                    <input type="submit" id="deleteBtn" name="deleteBtn" class="btn btn-danger" value="Delete" onclick="return askConfirmFunction()"/>
                                    <input type="submit" id="topUpBtn" name="topUpBtn" class="btn btn-success" value="TopUp"/>        
                                    <% } else if (Staffacc.getPosition().equals("Manager")) {
                                    if (account.getPosition().equals("Staff")) { %> <!-- manager manage staff -->
                                    <a href="Manager/manageStaff.jsp" id="backBtn" name="backBtn" class="btn btn-orange">Back</a>
                                    <%    } else if (account.getPosition().equals("Customer")) { %> <!-- manager manage customer -->
                                    <a href="Manager/manageCustomer.jsp" id="backBtn" name="backBtn" class="btn btn-orange">Back</a>
                                    <% } %> 
                                    <input type="submit" id="updateBtn" name="updateBtn" class="btn btn-primary" value="Update"/>
                                    <input type="submit" id="deleteBtn" name="deleteBtn" class="btn btn-danger" value="Delete" onclick="return askConfirmFunction()"/>
                                    <% } else { %> <!-- staff view customer -->
                                    <a href="Manager/manageCustomer.jsp" id="backBtn" name="backBtn" class="btn btn-orange">Back</a>
                                    <% }%> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script>
            function askConfirmFunction() {
                var status = "<%= status%>";
                if (status === "Deleted") {
                    deletedError();
                    //alert("This Account already deleted!");
                    return false;
                } else if (confirm("You sure you want to delete?")) {
                    if (status === "Unset") {
                        var birthday = document.getElementById("birthday");
                        var firstName = document.getElementById("firstName");
                        var lastName = document.getElementById("lastName");
                        var phoneNumber = document.getElementById("phoneNumber");
                        var ic = document.getElementById("ic");
                        var userName = new Date(1999, 0, 1);
                        birthday.valueAsDate = birthdayDate;
                        firstName.value = "unset";
                        lastName.value = "unset";
                        phoneNumber.value = "01122223333";
                        ic.value = "990101078888";
                        userName.value = "unset";

                        alert("Deleted successful!");
                        return true;
                    }

                } else {
                    alert("Canceled successful!");
                    return false;
                }
            }

            function deletedError() {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "This Account already deleted!"
                });
            }

            function promptConfirmDelete() {
                Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be able to revert this!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Yes, delete it!"
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            title: "Deleted!",
                            text: "Deleted successful!",
                            icon: "success"
                        });
                        return true;
                    } else {
                        Swal.fire({
                            title: "Canceled!",
                            text: "canceled successful!",
                            icon: "success"
                        });
                        return false;
                    }
                });
            }

        </script>
        <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">

        </script>
    </body>
</html>