package domain;

import java.text.DecimalFormat;
public class Product {
    private int id;
    private String name;
    private String description;
    private double unitPrice;
    private String type;
    private String createdDate;
    private String updatedDate;
    private String updatedBy;
    private String createdBy;
    private boolean isActive = true;
    private String category;
    private Image image;
    private int stockQty;
    
    public Product() {

    }

    // Constructor
    public Product(int id, String name, String description, double unitPrice, String type, String createdDate, String updatedDate, String updatedBy, String createdBy, boolean isActive, String category, Image image, int stockQty) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.unitPrice = unitPrice;
        this.type = type;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.updatedBy = updatedBy;
        this.createdBy = createdBy;
        this.isActive = isActive;
        this.category = category;
        this.image = image;
        this.stockQty = stockQty;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public double getUnitPrice() {
        return unitPrice;
    }
   public static String rmFormat(double number) {
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        return formatter.format(number);
    }

    public String getType() {
        return type;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public boolean isActive() {
        return isActive;
    }

    public String getCategory() {
        return category;
    }

    public Image getImage() {
        return image;
    }
    
    public int getStockQty() {
        return stockQty;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setImage(Image image) {
        this.image = image;
    }
    
    public void setStockQty(int stockQty) {
        this.stockQty = stockQty;
    }

}
