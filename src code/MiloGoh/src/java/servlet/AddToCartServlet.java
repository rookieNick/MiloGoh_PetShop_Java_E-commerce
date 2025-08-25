package servlet;

import control.MaintainCartControl;
import domain.Account;
import domain.Cart;
import java.io.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

@WebServlet("/addToCartServlet")
public class AddToCartServlet extends HttpServlet {

    MaintainCartControl cartControl;

    public AddToCartServlet() throws Exception {
        this.cartControl = new MaintainCartControl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        try {
            if (account.getAccountID() > 0) {
                List<Cart> cartList = cartControl.getCartByAccountId(account.getAccountID());
                if (!cartList.isEmpty()) {
                    boolean newItem = true;
                    int cartIdToIncQty = 0;
                    for (Cart c : cartList) {
                        if (c.getProductID() == productId) {
                            cartIdToIncQty = c.getCartID();
                            newItem = false;
                        }
                    }
                    if (newItem) {
                        //Add ProductLine with the cart
                        LocalDateTime currentDateTime = LocalDateTime.now();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                        String current_date = currentDateTime.format(formatter);
                        Cart tempCart = new Cart(account.getAccountID(), productId, quantity, current_date);
                        cartControl.createNewCart(tempCart);
                    } else {
                        //Update productLine Quantity
                        LocalDateTime currentDateTime = LocalDateTime.now();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                        String created_date = currentDateTime.format(formatter);
                        Cart tempCart = new Cart(cartIdToIncQty, productId, quantity, account.getAccountID(), account.getAccountID(), created_date, account.getAccountID(), created_date, true, 0, "");
                        cartControl.updateCart(tempCart);
                    }
                } else {//Straight up add new cart with the productline
                    LocalDateTime currentDateTime = LocalDateTime.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                    String current_date = currentDateTime.format(formatter);
                    Cart tempCart = new Cart(account.getAccountID(), productId, quantity, current_date);
                    cartControl.createNewCart(tempCart);
                }

            } else {
                ArrayList<Cart> guestCart = (ArrayList<Cart>) session.getAttribute("guestCart");
                if (!guestCart.isEmpty()) {
                    boolean newItem = true;
                    for (Cart c : guestCart) {
                        if (c.getProductID() == productId) {
                            c.setProductQty(c.getProductQty() + quantity);
                            newItem = false;
                        }
                    }
                    if (newItem) {
                        LocalDateTime currentDateTime = LocalDateTime.now();
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                        String current_date = currentDateTime.format(formatter);
                        Cart cart = new Cart(0, productId, quantity, current_date);
                        guestCart.add(cart);
                    }
                } else {
                    LocalDateTime currentDateTime = LocalDateTime.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                    String current_date = currentDateTime.format(formatter);
                    Cart cart = new Cart(0, productId, quantity, current_date);
                    guestCart.add(cart);
                }
                BufferedWriter writer = new BufferedWriter(new FileWriter("guest_cart.txt", false));

                for (Cart c : guestCart) {
                    writer.write(c.getProductID() + "," + c.getProductQty() + "\n");
                }
                writer.close();
                session.setAttribute("guestCart", guestCart);
            }
        } catch (IOException | ServletException ex) {
            throw ex;
        } catch (Exception ex) {
        } finally {
            response.sendRedirect("jsp/ProductDetailPage.jsp?id="+productId);
        }
    }
}
