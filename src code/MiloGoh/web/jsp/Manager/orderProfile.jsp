<%@page import="domain.Order"%>
<%@page import="control.MaintainOrderControl"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="domain.Image"%>
<%@page import="control.MaintainImageControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.Product"%>
<%@page import="control.MaintainProductControl"%>
<%@page import="control.MaintainAccountControl"%>
<%@page import="domain.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Account account = (Account) session.getAttribute("account");
    //int accountID = account.getAccountID();

    String orderIDString = request.getParameter("orderID");

    double subtotal = 0.0;
    double shippingFee = 25.00;
    double totalAmount = 0.0;
    double sstRate = 0.06; // SST rate (6%)
    double sstAmount = 0.0; // Calculate SST amount
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Manage Customer Order</title>
        <link rel="icon" type="image/png" href="../../pic/logo3.png"/>
        <!-- CSS -->
        <link rel="stylesheet" href="../../css/staffStyle.css" />
        <link rel="stylesheet" href="../../css/orderProfile.css" />

        <!-- Boxicons CSS -->
        <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet" />
    </head>
    <body id="manageCustomerOrderPage">
        <%@include file="managerNavBar.jsp" %>
<div class="center-wrapper">
	<div class="content">
	<div class="bag">
		<p class="bag-head"><span style="text-transform: uppercase">Order ID: </span><%=orderIDString %></p>
	</div>
        <%                    if (orderIDString != null && !orderIDString.isEmpty()) {
                        int orderID = Integer.parseInt(orderIDString);
                        MaintainOrderControl orderControl = new MaintainOrderControl();

                        ArrayList<Order> orderRecords = orderControl.getOrdersByOrderId(orderID);

                        if (orderRecords != null && !orderRecords.isEmpty()) {
                            for (Order order : orderRecords) {

                                MaintainProductControl prodControl = new MaintainProductControl();
                                Product product = prodControl.selectProductById(order.getProductId());

                                int imageId = product.getImage().getId();
                                MaintainImageControl imageControl = new MaintainImageControl();
                                Image image = imageControl.selectImageById(imageId);

                                byte[] imageData = image.getImage1(); // Assuming the image data is stored in the getImage1() method
                                // Convert the byte array to a Base64-encoded string
                                String base64Image = Base64.getEncoder().encodeToString(imageData);

                                //calculate subtotal to determine shipping fee
                                subtotal += order.getProductQty() * product.getUnitPrice();
                                if (subtotal > 200) {
                                    shippingFee = 0;
                                }
                %>
	<div class="bag-product">
		<div class="image">
                    <img src="data:image/jpeg;base64, <%= base64Image%>" class="product-image" alt="<%=product.getName()%>" >
		</div>
		<div class="description">
			<p class="product-code small muted">Product ID: <%=product.getId() %></p>
			<h1><%=product.getName() %></h1>
			<p style="margin-bottom: 0.5rem;"><%=product.getDescription() %></p>
			<h2>RM <%=product.getUnitPrice() %></h2>
			<div class="quantity-wrapper">
				<div>
					<label for="quantity" style="margin-right: 0.5rem;">Quantity: <%=order.getProductQty() %></label>
					
				</div>
			</div>
		</div>
	</div>
        <%
                            }
                        }
                    }
                %> 
        <%
                    //round up to 2 digits using math round * 100.0 and / 100.0
                    sstAmount = Math.round((subtotal * sstRate) * 100.0) / 100.0;
                    // Calculate total amount including shipping fee
                    totalAmount = Math.round((subtotal + shippingFee + sstAmount) * 100.0) / 100.0;

                %>
        
	<div class="bag-total">
		<div class="subtotal">
			<p class="small">Subtotal:</p>
			<p class="small">RM <%= String.format("%.2f", subtotal) %></p>
		</div>
                <div class="sst">
			<p class="small">SST:</p>
			<p class="small">RM <%= String.format("%.2f", sstAmount) %></p>
		</div>
		<div class="delivery">
			<p class="small">Shipping Fee:<br></p>
			<p class="small">RM <%= String.format("%.2f", shippingFee) %></p>
		</div>
		<div class="total">
			<h3>Total:</h3>
			<h3>RM <%=totalAmount%></h3>
		</div>
	</div>
</div>
</div>
<div class="bg"></div>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

      
        <script src="../../js/adminDarkMode.js"></script>
    </body>
</html>
