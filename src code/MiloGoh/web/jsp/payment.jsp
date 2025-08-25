<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="domain.*" %>
<%@page import="control.*" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    Account account = (Account) session.getAttribute("account");

    int accountID = 0;
    double wallet = 0.0;

    if (account != null) {
        accountID = account.getAccountID();
        wallet = account.getWallet();
    }

    String orderIDString = request.getParameter("orderID");

    double subtotal = 0.0;
    double shippingFee = 25.00;
    double totalAmount = 0.0;
    double sstRate = 0.06; // SST rate (6%)
    double sstAmount = 0.0; // Calculate SST amount

    String enoughMoney = "";
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${companyName} | Payment</title>
        <!-- Preconnects -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <!-- Sweet Alert -->
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Styles -->
        <link rel="stylesheet" href="../css/payment.css" />
        <!-- JavaScript -->
        <script src="alive.js" charset="utf-8" type="module"></script>
        <!-- Favicon -->
        <link rel="shortcut icon" href="checkout-page-master/devchallenges.png" type="image/x-icon">
        <!-- Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%
            if (account.getPosition().equals("Guest")) {
                response.sendRedirect("onlyCustomer.jsp");
                return;
            }
        %>
        <main id="main">
            <h1 style="width:100%; display: flex; justify-content: center">Payment</h1>
            <!-- Merchandise -->
            <aside class="ware">
                <%           Promotion promotion = (Promotion) session.getAttribute("promotion");
                    if (orderIDString != null && !orderIDString.isEmpty()) {
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
                                if (promotion.getPromotionid() > 0) {
                                    subtotal += order.getProductQty() * product.getUnitPrice() * (100 - promotion.getDiscount()) / 100;
                                } else {
                                    subtotal += order.getProductQty() * product.getUnitPrice();
                                }
                                if (subtotal > 200) {
                                    shippingFee = 0;
                                }
                %>
                <div class="ware__item" style="display:flex; justify-content: center">
                    <div class="item_pic" style="width: 50%">
                        <img src="data:image/jpeg;base64, <%= base64Image%>" class="item__img" alt="<%=product.getName()%>" >

                    </div>
                    <div class="empty_gap" style="width:10%">

                    </div>
                    <div class="item_details" style="width: 40%">
                        <figcaption class="item__figure__figcaption"><%=product.getName()%></figcaption><br/>
                            <% if (promotion.getPromotionid() > 0) {%>
                        <p class="item__figure__price"><span class="figure__price--off">RM <%=product.getUnitPrice()%></span></p><br/><br/><br/>
                        <% } else {%>
                        <p class="item__figure__price"><span class="figure__price--off">RM <%=product.getUnitPrice()%></span></p><br/><br/><br/>
                        <% }%>
                        <div class="item__cont__btns">
                            Quantity: <input type="number" name="backbag-qty" id="backbag-qty" class="ware__input ware__input--item-1" min="1" value="<%=order.getProductQty()%>" />
                        </div>
                    </div>

                </div>
                <%
                            }
                        }
                    }
                %> 
                <!--                <div class="ware__item">
                                    <figure class="item__figure">
                                        <img class="item__img" src="checkout-page-master/photo1.png" alt="Vintage Bag" />
                                        <figcaption class="item__figure__figcaption">Vintage Bag</figcaption>
                                        <p class="item__figure__price"><span class="figure__price--off">$54.99</span> <span class="figure__price--crossed">$94.99</span></p>
                                        <div class="item__cont__btns">
                                            <button class="item__btn item__btn--minus" type="button"><i class="material-icons">remove</i></button>
                                            <label class="ware__hide-label" for="backbag-qty">Choose the quantity of vintage bags you want to buy</label>
                                            <input type="number" name="backbag-qty" id="backbag-qty" class="ware__input ware__input--item-1" min="1" value="1" />
                                            <button class="item__btn item__btn--plus" type="button"><i class="material-icons">add</i></button>
                                        </div>
                                    </figure>
                                </div>-->
                <%
                    //round up to 2 digits using math round * 100.0 and / 100.0
                    sstAmount = Math.round((subtotal * sstRate) * 100.0) / 100.0;
                    // Calculate total amount including shipping fee
                    totalAmount = Math.round((subtotal + shippingFee + sstAmount) * 100.0) / 100.0;

                    if (wallet < totalAmount) {
                        enoughMoney = "no";
                    }
                %>
                <p class="global__price global__price--shipping"><span>Shipping</span> <span>RM <%= shippingFee%></span></p>
                <p class="global__price global__price--tax"><span>Sales Tax (SST 6%)</span> <span>RM <%= sstAmount%></span></p>
                <p class="global__price"><span>Total</span> <span class="quantity__total">RM <%=totalAmount%></span></p>
            </aside>
            <!-- Form -->
            <form class="form" method="post" action="../PaymentServlet" onsubmit="return validateForm()" style="width:300px;">
                <input type="hidden" name="accountID" id="accountID" value="<%=accountID%>"/>
                <input type="hidden" name="orderID" id="orderID" value="<%=orderIDString%>"/>
                <input type="hidden" name="totalAmount" id="totalAmount" value="<%=totalAmount%>"/>
                <!-- Contact Information -->
                <fieldset class="fieldset fieldset--contact">
                    <legend class="legend">Contact Information</legend>
                    <label class="label" for="e-mail">Email</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">email</i>
                        <input type="email" name="e-mail" id="e-mail" class="input input--text" placeholder="Enter your email..." readonly value="<%=account.getGmail()%>" />
                    </p>
                    <label class="label" for="phone-num">Phone</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">phone</i>
                        <input type="tel" name="phone-number" id="phone-num" class="input input--text" placeholder="Enter your phone..." value="<%=account.getPhoneNumber()%>" maxlength="14" pattern="\(\w{3}\) \w{3}[ -]\w{4}" title="A valid phone number has the first three numbers in parentheses followed by a space, three numbers followed by a space or hyphen, and the last four numbers. Also, avoid putting your country code." readonly />
                    </p>
                </fieldset>

                <!-- Shipping Address -->
                <fieldset class="fieldset fieldset--shipping" style="margin-bottom: 2.5rem;">
                    <legend class="legend">Shipping Address</legend>
                    <label class="label" for="f-name">Full Name</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">account_circle</i>
                        <input type="text" name="full-name" id="f-name" class="input input--text" placeholder="Your full name..." readonly value="<%=account.getFirstName() + " " + account.getLastName()%>" readonly/>
                    </p>

                    <label class="label" for="address">Address</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">home</i>
                        <input type="text" name="address" id="address" class="input input--text" placeholder="Your address..." value="<%=account.getAddress()%>" required />
                    </p>
                </fieldset>

                <fieldset class="fieldset">
                    <legend class="legend">Payment Method</legend>
                    <label class="label" for="payment-method">Choose Payment Method</label>
                    <p class="field">
                        <i class="material-icons form__icons">payment</i>
                        <select name="payment-method" id="payment-method" class="input select__payment" required onchange="togglePaymentFields()">
                            <option value="" selected>Select payment method...</option>
                            <option value="wallet">Wallet</option>
                            <option value="debit-card">Debit Card</option>
                            <option value="credit-card">Credit Card</option>
                            <option value="e-wallet">E-Wallet</option>
                        </select>
                    </p>
                </fieldset>

                <!-- Cash Input Field -->
                <fieldset class="fieldset fieldset--wallet" id="walletFields">
                    <div class="container__form__btn">
                        <% if (enoughMoney.equals("no")) { %>
                        <input type="submit" class="form__btn" value="Not enough money" disabled>
                        <% } else { %>
                        <input type="submit" class="form__btn" name="PayWallet" value="PayWallet">
                        <% }%>
                    </div>
                </fieldset>

                <!-- Debit Card Input Field -->
                <fieldset class="fieldset fieldset--debit" id="debitCardFields">
                    <legend class="legend">Debit Card</legend>
                    <label class="label" for="debit-card-type">Debit Card Type</label>
                    <p class="field">
                        <i class="material-icons form__icons">account_balance</i>
                        <select name="debit-card-type" id="debit-card-type" class="input select__debit-card" >
                            <option value="" selected>Select bank...</option>
                            <option value="Maybank">Maybank</option>
                            <option value="CIMB">CIMB</option>
                            <option value="Public Bank">Public Bank</option>
                            <option value="RHB">RHB</option>
                        </select>
                    </p>
                    <label class="label" for="debit-card-number">Debit Card Number</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">credit_card</i>
                        <input type="number" name="debit-card-number" id="debit-card-number" class="input input--text" placeholder="Enter debit card number..."  />
                    </p>
                    <label class="label" for="debit-card-expiry">Expiration Date</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">event</i>
                        <input type="date" name="debit-card-expiry" id="debit-card-expiry" class="input input--text" placeholder="Expiration Date..."  />
                    </p>
                    <label class="label" for="debit-card-cvv">CVV</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">lock</i>
                        <input type="number" name="debit-card-cvv" id="debit-card-cvv" class="input input--text" placeholder="Enter CVV..." maxlength="3"  />
                    </p>
                    <div class="container__form__btn">
                        <input type="submit" class="form__btn" value="Pay">
                    </div>
                </fieldset>

                <!-- Credit Card Input Field -->
                <fieldset class="fieldset fieldset--credit" id="creditCardFields">
                    <legend class="legend">Credit Card</legend>
                    <label class="label" for="credit-card-type">Credit Card Type</label>
                    <p class="field">
                        <i class="material-icons form__icons">account_balance</i>
                        <select name="credit-card-type" id="credit-card-type" class="input select__debit-card" >
                            <option value="" selected>Select card...</option>
                            <option value="Visa">Visa</option>
                            <option value="Mastercard">Mastercard</option>
                            <option value="American Express">American Express</option>
                        </select>
                    </p>
                    <label class="label" for="credit-card-number">Credit Card Number</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">credit_card</i>
                        <input type="number" name="credit-card-number" id="credit-card-number" class="input input--text" placeholder="Enter credit card number..."  />
                    </p>
                    <label class="label" for="credit-card-expiry">Expiration Date</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">event</i>
                        <input type="date" name="credit-card-expiry" id="credit-card-expiry" class="input input--text" placeholder="Expiration Date..."  />
                    </p>
                    <label class="label" for="credit-card-cvv">CVV</label>
                    <p class="field field--text">
                        <i class="material-icons form__icons">lock</i>
                        <input type="number" name="credit-card-cvv" id="credit-card-cvv" class="input input--text" placeholder="Enter CVV..." maxlength="3"  />
                    </p>
                    <div class="container__form__btn">
                        <input type="submit" class="form__btn" value="Pay">
                    </div>
                </fieldset>

                <!-- E-wallet Input Field -->
                <fieldset class="fieldset fieldset--ewallet" id="eWalletFields">
                    <legend class="legend">E-Wallet</legend>
                    <label class="label" for="ewallet-type">Select E-Wallet</label>
                    <p class="field">
                        <i class="material-icons form__icons">payment</i>
                        <select name="ewallet-type" id="ewallet-type" class="input select__ewallet" >
                            <option value="" selected>Select e-wallet...</option>
                            <option value="paypal">PayPal</option>
                            <option value="venmo">Venmo</option>
                            <option value="apple-pay">Apple Pay</option>
                            <!-- Add more e-wallet options as needed -->
                        </select>
                    </p>
                    <div class="container__form__btn">
                        <input type="submit" class="form__btn" value="Pay">
                    </div>
                </fieldset>

                <!-- Submit Button -->
                <!--                <div class="container__form__btn">
                                    <button type="submit" class="form__btn">Continue</button>
                                </div>-->
            </form>
        </main>
    </body>
</html>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Select the payment method dropdown
        var paymentMethodSelect = document.getElementById('payment-method');

        // Select the fieldsets for different payment methods
        var walletFieldset = document.getElementById('walletFields');
        var debitCardFieldset = document.getElementById('debitCardFields');
        var creditCardFieldset = document.getElementById('creditCardFields');
        var eWalletFieldset = document.getElementById('eWalletFields');

        // Function to show/hide fieldsets based on the selected payment method
        function togglePaymentFields() {
            var selectedPaymentMethod = paymentMethodSelect.value;

            // Hide all fieldsets initially
            debitCardFieldset.style.display = 'none';
            creditCardFieldset.style.display = 'none';
            eWalletFieldset.style.display = 'none';
            walletFieldset.style.display = 'none';


            // Show the respective fieldset based on the selected payment method
            if (selectedPaymentMethod === 'debit-card') {
                debitCardFieldset.style.display = 'block';
            } else if (selectedPaymentMethod === 'credit-card') {
                creditCardFieldset.style.display = 'block';
            } else if (selectedPaymentMethod === 'e-wallet') {
                eWalletFieldset.style.display = 'block';
            } else if (selectedPaymentMethod === 'wallet') {
                walletFieldset.style.display = 'block';
            }
        }

        // Add event listener to the payment method dropdown
        paymentMethodSelect.addEventListener('change', togglePaymentFields);

        // Call the togglePaymentFields function initially to ensure proper visibility
        togglePaymentFields();
    });


    function validateForm() {
        var selectedPaymentMethod = document.getElementById("payment-method").value;

        if (selectedPaymentMethod === 'debit-card') {
            var cardNumber = document.getElementById("debit-card-number").value;
            var expDate = document.getElementById("debit-card-expiry").value;
            var cvv = document.getElementById("debit-card-cvv").value;

            if (cardNumber.trim() === '' || expDate.trim() === '' || cvv.trim() === '') {
                alert("Please fill out all fields for debit card payment.");
                return false;
            }
            // Check expiration date
            var today = new Date();
            var expDateObj = new Date(expDate);
            if (expDateObj <= today) {
                alert("Expiry date must be later than today.");
                return false;
            }
            // Check card number length
            if (cardNumber.length != 16) {
                alert("Card number must be 16 digits.");
                return false;
            }

            // Check CVV length
            if (cvv.length != 3) {
                alert("CVV must be 3 digits.");
                return false;
            }
        } else if (selectedPaymentMethod === 'credit-card') {
            var cardNumber = document.getElementById("credit-card-number").value;
            var expDate = document.getElementById("credit-card-expiry").value;
            var cvv = document.getElementById("credit-card-cvv").value;

            if (cardNumber.trim() === '' || expDate.trim() === '' || cvv.trim() === '') {
                alert("Please fill out all fields for credit card payment.");
                return false;
            }
            // Check expiration date
            var today = new Date();
            var expDateObj = new Date(expDate);
            if (expDateObj <= today) {
                alert("Expiry date must be later than today.");
                return false;
            }
            // Check card number length
            if (cardNumber.length != 16) {
                alert("Card number must be 16 digits.");
                return false;
            }

            // Check CVV length
            if (cvv.length != 3) {
                alert("CVV must be 3 digits.");
                return false;
            }
        } else if (selectedPaymentMethod === 'e-wallet') {
            var eWalletType = document.getElementById("ewallet-type").value;

            if (eWalletType.trim() === '') {
                alert("Please select an e-wallet.");
                return false;
            }
        } // Add more conditions for other payment methods if needed

        // If all validations pass, return true to submit the form
        return true;
    }

</script>