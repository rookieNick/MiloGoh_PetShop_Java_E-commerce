//package control;
//
//import da.ProductLineDA;
//import domain.ProductLine;
//import java.util.ArrayList;
//
//public class MaintainProductLineControl {
//    private ProductLineDA productLineDA;
//    
//    public MaintainProductLineControl() throws Exception{
//        productLineDA = new ProductLineDA();
//    }
//    
//    public ProductLine getProductLineById(int productLineId)throws Exception{
//        return productLineDA.getRecord(productLineId);
//    }
//    
//    public ArrayList<ProductLine> getAllProductLine()throws Exception{
//        return productLineDA.getAllRecord();
//    }
//    
//    public void createProductLine(ProductLine productLine) throws Exception{
//        productLineDA.addRecord(productLine);
//    }
//    
//    public void removeProductLine(int productLineId)throws Exception{
//        productLineDA.deleteRecord(productLineId);
//    }
//    
//    public void updateProductLine(ProductLine productLine)throws Exception{
//        productLineDA.editRecord(productLine);
//    }
//}
