/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

/**
 *
 * @author limch
 */
import da.OrderDA;
import domain.Order;

import java.util.ArrayList;

public class MaintainOrderControl {
    private OrderDA orderDA;

    public MaintainOrderControl() {
        this.orderDA = new OrderDA();
    }
    

    public ArrayList<Order> getAllOrders() {
        return orderDA.getAllOrders();
    }
    
    public ArrayList<Order> getOrdersByAccountId(int accountId){
        return orderDA.getOrdersByAccountId(accountId);
    }
    
    public ArrayList<Order> getOrdersByOrderId(int orderId){
        return orderDA.getOrdersByOrderId(orderId);
    }
    
    public Order getOrdersByOrderIdAndProductId(int orderId, int productId){
        return orderDA.getOrdersByOrderIdAndProductId(orderId,productId);
    }
    
    public ArrayList<Order> getOrdersByStatus(String status){
        return orderDA.getOrdersByStatus(status);
    }

    public void addOrder(Order order) {
        orderDA.addOrder(order);
    }

    public void updateOrder(Order order) {
        orderDA.updateOrder(order);
    }
    
    public void updateOrderWithDifferentProductId(Order order) {
        orderDA.updateOrderWithDifferentProductId(order);
    }

    public void deleteOrder(int orderId) {
        orderDA.deleteOrder(orderId);
    }
    
    public double orderTotalPrice(ArrayList<Order> order)throws Exception{
        return orderDA.totalPrice(order);
    }
}
