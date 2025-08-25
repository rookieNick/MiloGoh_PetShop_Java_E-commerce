/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import da.StockDA;
import domain.Stock;

/**
 *
 * @author terra
 */
public class MaintainStockControl {
    
        
    private StockDA stockDA;

    public MaintainStockControl() {
        stockDA = new StockDA();
    }

    public Stock selectStock(int id) {
        return stockDA.getStock(id);
    }
    public void addStock(Stock stock){
      stockDA.addStock(stock) ; 
    }
    public void updateStock(Stock stock){
      stockDA.updateStock(stock) ; 
    }
    public void deleteStock(Stock stock){
      stockDA.deleteStock(stock) ; 
    }
}
