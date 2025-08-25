<%@page import="domain.Account"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${companyName} | Top Up</title>
    <link href="../css/topUp.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function validateForm() {
            var name = document.getElementById("name").value;
            var cardNumber = document.getElementById("card_number").value;
            var cardType = document.getElementById("card_type").value;
            var expDate = document.getElementById("exp_date").value;
            var cvv = document.getElementById("cvv").value;
            var amount = document.getElementById("amount").value;

            // Check if all fields are filled
            if (name == "" || cardNumber == "" || cardType == "" || expDate == "" || cvv == "" || amount == "") {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "Please fill in all fields."
                });
                return false;
            }

            // Check card number length
            if (cardNumber.length != 16) {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "Card number must be 16 digits."
                });
                return false;
            }

            // Check CVV length
            if (cvv.length != 3) {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "CVV must be 3 digits."
                });
                return false;
            }

            // Check if expiry date is in the future
            var today = new Date();
            var expDateObj = new Date(expDate);
            if (expDateObj <= today) {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "Expiry date must be in the future."
                });
                return false;
            }

            // Check if amount is a valid number
            if (amount <= 0) {
                Swal.fire({
                    icon: "error",
                    title: "ERROR",
                    text: "Amount must be a valid number."
                });
                return false;
            }

            // If all validations pass, return true to submit the form
            return true;
        }
    </script>
</head>


<%
    Account account = (Account)session.getAttribute("account");
    if (account.getPosition().equals("Guest")) {
        response.sendRedirect("onlyCustomer.jsp");
        return;
    }
%>
<div class="mainscreen">
    <div class="card">
        <div class="leftside">
            <img
                src="../pic/blackcat.jpg"
                class="product"
                alt="cat"
                />
        </div>
        <div class="rightside">
            <form action="../TopUpServlet" method="post" onsubmit="return validateForm()">
                <h1>Top Up</h1>
                <h2>Payment Information</h2>
                <p>Cardholder Name</p>
                <input type="text" class="inputbox" id="name" name="name" required />
                <p>Card Number</p>
                <input type="number" class="inputbox" id="card_number" name="card_number" required />

                <p>Card Type</p>
                <select class="inputbox" id="card_type" name="card_type" required>
                    <option value="">--Select a Card Type--</option>
                    <option value="Visa">Visa</option>
                    <option value="MasterCard">MasterCard</option>
                </select>
                <div class="expcvv">
                    <p class="expcvv_text">Expiry</p>
                    <input type="date" class="inputbox" id="exp_date" name="exp_date" required />

                    <p class="expcvv_text2">CVV</p>
                    <input type="password" class="inputbox" id="cvv" name="cvv" required />
                </div>


                <p>Amount</p>
                <input type="number" class="inputbox" id="amount" name="amount" required />
                <p></p>
                <button type="submit" class="button">Top Up</button>
            </form>
        </div>
    </div>
</div>