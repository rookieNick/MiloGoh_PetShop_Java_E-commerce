/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

/**
 *
 * @author limch
 */
import da.PaymentDA;
import domain.Payment;

import java.util.ArrayList;


public class MaintainPaymentControl {
    private PaymentDA paymentDA;

    public MaintainPaymentControl() {
        this.paymentDA = new PaymentDA();
    }

    public ArrayList<Payment> getAllPayments() {
        return paymentDA.getAllPayments();
    }

    public Payment getRecord(int paymentId){
        return paymentDA.getRecord(paymentId);
    }
    
    public Payment getRecordByOrderId(int orderId){
        return paymentDA.getRecordByOrderId(orderId);
    }
    
    public ArrayList<Payment> getAllRecordByAccountId(int accountId){
        return paymentDA.getAllRecordByAccountId(accountId);
    }
    
    public void addPayment(Payment payment) {
        paymentDA.addPayment(payment);
    }

    public void updatePayment(Payment payment) {
        paymentDA.updatePayment(payment);
    }

    public void deletePayment(int paymentId) {
        paymentDA.deletePayment(paymentId);
    }

    // Other methods as needed
      public int getNewPaymentId() {
        ArrayList<Payment> payments = getAllPayments();
        int latestId = 0;
        int newId = 0;
        for (Payment payment : payments) {
            if (payment.getPaymentId() > latestId) {
                latestId = payment.getPaymentId();
            }
        }
        if (!payments.isEmpty()) {
            newId = latestId + 1;
        } else {
            newId = 1;
        }
         
        return newId;
    }
}
