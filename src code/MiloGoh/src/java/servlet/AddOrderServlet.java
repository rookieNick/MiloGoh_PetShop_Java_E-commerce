package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import control.MaintainOrderControl;
import control.MaintainCartControl;
import domain.Account;
import domain.Cart;
import domain.Order;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

/**
 *
 * @author zlsy2
 */
public class AddOrderServlet extends HttpServlet {

    MaintainOrderControl orderControl;
    MaintainCartControl cartControl;

    public AddOrderServlet() throws Exception {
        orderControl = new MaintainOrderControl();
        cartControl = new MaintainCartControl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        ArrayList<Integer> itemArr = new ArrayList<>();
        //CartList to retrieve cart from session
        ArrayList<Cart> cartList = new ArrayList<>();
        try {
            if (account.getAccountID() > 0) {
                cartList = (ArrayList<Cart>) session.getAttribute("cart");
                int addedItemCount = 0;
                for (int k = 0; k < cartList.size(); k++) {
                    if (request.getParameter("itemArr[" + k + "]") != null) {
                        addedItemCount++;
                    }
                }
                if (addedItemCount < 1) {
                    response.sendRedirect("jsp/cart.jsp");
                }
                ArrayList<Order> orderList = orderControl.getAllOrders();
                int newOrderId = 1;
                if (!orderList.isEmpty()) {
                    newOrderId = (orderList.get(orderList.size() - 1).getOrderId()) + 1;
                }
                ArrayList<Integer> idToRemove = new ArrayList<Integer>();
                for (int i = 0; i < cartList.size(); i++) {
                    if (request.getParameter("itemArr[" + i + "]") != null) {
                        LocalDateTime currentDateTime = LocalDateTime.now();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                        String created_date = currentDateTime.format(formatter);
                        Order order = new Order(newOrderId, cartList.get(i).getProductID(), cartList.get(i).getProductQty(), account.getAccountID(), created_date, account.getAddress());
                        orderControl.addOrder(order);
                        idToRemove.add(cartList.get(i).getCartID());
                    }
                }
                if (!idToRemove.isEmpty()) {
                    for (int j = 0; j < idToRemove.size(); j++) {
                        cartControl.removeCart(idToRemove.get(j));
                    }
                }
                response.sendRedirect("jsp/orderDetails.jsp?orderId=" + newOrderId);
            } else {
                response.sendRedirect("jsp/login.jsp");
            }
        } catch (Exception ex) {

        }
    }
}
