package control;

import da.ProductDA;
import domain.Product;
import java.util.ArrayList;

public class MaintainProductControl {

    private ProductDA productDA;

    public MaintainProductControl() {
        productDA = new ProductDA();
    }

    public Product selectProductById(int productId) {
        return productDA.getProductById(productId);
    }

    public void addProduct(Product product) {
        productDA.addProduct(product);
    }

    public void editProduct(Product product) {
        productDA.updateProduct(product);
    }

    public void deleteProduct(Product product) {
        productDA.deleteProduct(product);
    }

    public ArrayList<Product> getAllProducts(String searchBy, String categ, String active){
        return productDA.getAllProducts(searchBy, categ, active);
    }
    
    public ArrayList<Product> getAllProductsFromIsActive(String isActive){
        return productDA.getAllProductsFromIsActive(isActive);
    }
    
    public int getNewProductId() {
        ArrayList<Product> products = getAllProducts("","","");
        int latestId = 0;
        int newId = 0;
        for (Product product : products) {
            if (product.getId() > latestId) {
                latestId = product.getId();
            }
        }
        if (!products.isEmpty()) {
            newId = latestId + 1;
        } else {
            newId = 1;
        }
         
        return newId;
    }

}
