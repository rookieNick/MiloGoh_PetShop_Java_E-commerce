package control;

import da.CartDA;
import domain.Cart;
import java.util.ArrayList;

public class MaintainCartControl {
    private CartDA cartDA;

    public MaintainCartControl() throws Exception{
        cartDA = new CartDA();
    }

    public void createNewCart(Cart cart) throws Exception{
        cartDA.addRecord(cart);
    }
    
    public Cart getCartById(int cartId)throws Exception{
        return cartDA.getRecord(cartId);
    }
    
    public Cart getCartByAccountIdAndProductId(int accountId,int productId) throws Exception{
        return cartDA.getRecordByAccountIdAndProductId(accountId, productId);
    }
    
    public ArrayList<Cart> getAllCart() throws Exception{
        return cartDA.getAllRecord();
    }

    public ArrayList<Cart> getCartByAccountId(int accountId) throws Exception{
        return cartDA.getRecordByAccountID(accountId);
    }
    
    public void removeCart(int cartId)throws Exception{
        cartDA.deleteRecord(cartId);
    }
    
    public void removeCartByAccountId(int accountId)throws Exception{
        cartDA.deleteRecordByAccountId(accountId);
    }
    
    public void updateCart(Cart cart)throws Exception{
        cartDA.editRecord(cart);
    }
    
    public double calculateTotalPrice(ArrayList<Cart> cart) throws Exception{
        return cartDA.totalPrice(cart);
    }
}
