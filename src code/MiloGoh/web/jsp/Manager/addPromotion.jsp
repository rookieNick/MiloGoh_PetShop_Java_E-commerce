<%@page import="domain.Image"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">


        <title>${companyName} | Add Promotion</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />

        <link href="../../css/staffStyle.css" rel="stylesheet">
        <link href="../../css/addItem.css" rel="stylesheet">

    </head>
    <body>
        <%@include file="managerNavBar.jsp" %>

        <form action="../../AddPromotion" method="post" id="addItemForm">
            <div class="container" id="addItemContainer">
                <div class="row gutters">
                    <div class="card-body" id="addItemCardBody">
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <h6 class="mb-2 text-primary">Add New Promotion</h6>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <input type="text" class="form-control" id="description" name="description" required>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="discount">Discount Percentage</label>
                                    <input type="number" step="1" min="1" max="99" class="form-control" id="discount" name="discount" required>
                                </div>
                            </div>
                            <div class="col-9">
                                <div class="form-group">
                                    <label for="validdate">Valid Date</label>
                                    <input type="date" class="form-control" id="validdate" name="validdate" required>
                                </div>
                            </div>
                        </div>
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">
                                    <input type="submit" id="addBtn" name="addBtn" class="btn btn-primary" value="Add"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <script src="../../js/adminDarkMode.js"></script>



    </body>
</html>