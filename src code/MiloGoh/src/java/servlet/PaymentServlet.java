/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.MaintainAccountControl;
import domain.Account;
import control.MaintainOrderControl;
import domain.Order;
import domain.Payment;
import control.MaintainPaymentControl;
import control.MaintainProductControl;
import domain.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

//@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIDString = request.getParameter("orderID");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        String PayWallet = request.getParameter("PayWallet");

        // Create a Payment object
        Payment payment = new Payment();

        MaintainPaymentControl paymentControl = new MaintainPaymentControl();
        int newPaymentId = paymentControl.getNewPaymentId();

        payment.setPaymentId(newPaymentId);
        payment.setOrderId(Integer.parseInt(orderIDString));
        payment.setTotalPayment(totalAmount);
        payment.setStatus("Paid");

        paymentControl = new MaintainPaymentControl();
        paymentControl.addPayment(payment);

        MaintainOrderControl orderControl = new MaintainOrderControl();
        ArrayList<Order> orderRecords = orderControl.getOrdersByOrderId(Integer.parseInt(orderIDString));
        if (orderRecords != null && !orderRecords.isEmpty()) {

            LocalDateTime currentDateTime = LocalDateTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            String completionDate = currentDateTime.format(formatter);

            for (Order order : orderRecords) {

                order.setStatus("Paid");
                order.setCompletionDate(completionDate);
                orderControl.updateOrderWithDifferentProductId(order);

                //minus stock
                MaintainProductControl prodControl = new MaintainProductControl();
                Product product = prodControl.selectProductById(order.getProductId());

                int stockQty = product.getStockQty() - order.getProductQty();
                product.setStockQty(stockQty);
                prodControl.editProduct(product);

            }

            //minus wallet
            if ("PayWallet".equals(PayWallet)) {
                String accountID = request.getParameter("accountID");
                MaintainAccountControl accControl = new MaintainAccountControl();
                Account account = accControl.selectRecord(accountID);
                double wallet = account.getWallet();
                account.setWallet((double) Math.round((wallet - totalAmount) * 100) / 100);
                accControl.editRecord(account);

                // Retrieve the HttpSession object
                HttpSession session = request.getSession();

                // update the account session
                session.removeAttribute("account");
                session.setAttribute("account", account);
            }

        }

        response.sendRedirect("jsp/paymentsuccess.jsp?orderId=" + orderIDString + "&totalAmount=" + totalAmount);

    }
}
