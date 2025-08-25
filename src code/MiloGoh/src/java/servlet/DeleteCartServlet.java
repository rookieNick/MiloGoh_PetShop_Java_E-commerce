package servlet;

import control.MaintainCartControl;
import domain.Account;
import domain.Cart;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteCartServlet extends HttpServlet {

    MaintainCartControl cartControl;

    public DeleteCartServlet() throws Exception {
        this.cartControl = new MaintainCartControl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int productId = Integer.parseInt(request.getParameter("id"));
        try {
            if (account.getAccountID() > 0) {
                Cart cart = cartControl.getCartByAccountIdAndProductId(account.getAccountID(), productId);
                if (cart != null) {
                    cartControl.removeCart(cart.getCartID());
                }
            } else {
                ArrayList<Cart> guestCart = (ArrayList<Cart>) session.getAttribute("guestCart");
                int index=0;
                for (Cart c : guestCart) {
                    if (c.getProductID() == productId) {
                        index = guestCart.indexOf(c);
                    }
                }
                guestCart.remove(index);
                BufferedWriter writer = new BufferedWriter(new FileWriter("guest_cart.txt", false));
                if (!guestCart.isEmpty()) {
                    for (Cart c : guestCart) {
                        writer.write(c.getProductID() + "," + c.getProductQty() + "\n");
                    }
                }else{
                    writer.write("");
                }
                writer.close();
                session.setAttribute("guestCart", guestCart);
            }
        } catch (Exception ex) {

        } finally {
            response.sendRedirect("jsp/cart.jsp");
        }
    }
}
