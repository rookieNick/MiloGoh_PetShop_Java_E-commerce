package servlet;

import domain.Account;
import control.MaintainCartControl;
import control.MaintainProductControl;
import domain.Cart;
import domain.Product;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProductIncreaseQtyServlet extends HttpServlet {

    MaintainCartControl cartControl;
    MaintainProductControl productControl;

    public ProductIncreaseQtyServlet() throws Exception {
        this.cartControl = new MaintainCartControl();
        this.productControl = new MaintainProductControl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int productId = Integer.parseInt(request.getParameter("id"));
        try {
            if (account.getAccountID() > 0) {
                Product product = productControl.selectProductById(productId);
                Cart cart = cartControl.getCartByAccountIdAndProductId(account.getAccountID(), productId);
                if (cart.getProductQty() + 1 <= product.getStockQty()) {
                    cart.setProductQty(cart.getProductQty() + 1);
                    cartControl.updateCart(cart);
                }
            } else {
                ArrayList<Cart> guestCart = (ArrayList<Cart>) session.getAttribute("guestCart");
                Product product = productControl.selectProductById(productId);
                for (Cart c : guestCart) {
                    if (c.getProductID() == productId && c.getProductQty() + 1 <= product.getStockQty()) {
                        c.setProductQty(c.getProductQty() + 1);
                    }
                }
                BufferedWriter writer = new BufferedWriter(new FileWriter("guest_cart.txt", false));

                for (Cart c : guestCart) {
                    writer.write(c.getProductID() + "," + c.getProductQty() + "\n");
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
