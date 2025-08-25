
package servlet;

import control.MaintainAccountControl;
import control.MaintainOrderControl;
import control.MaintainProductControl;
import domain.Account;
import domain.Order;
import domain.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StatusFilterServlet")
public class StatusFilterServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //retrieve data
        String statusFilterSelection = request.getParameter("statusFilterSelection");
        String tableType = request.getParameter("tableType");
        
        if(tableType.equals("Customer") || tableType.equals("Staff")){  //for manage customer and staff
            ArrayList<Account> filterAccountListStatus = null;
            ArrayList<Account> filterAccountListPosition = null;
            ArrayList<Account> filterAccountList = new ArrayList<>();

            MaintainAccountControl accountControl = new MaintainAccountControl();

            //get filter status record
            if (statusFilterSelection.equals("All")) {
                //skip
            }
            else if (statusFilterSelection.equals("Active")) {
                filterAccountListStatus = accountControl.selectAllAccuntFromStatus("Active");
            }
            else if (statusFilterSelection.equals("Unset")) {
                filterAccountListStatus = accountControl.selectAllAccuntFromStatus("Unset");
            }
            else if (statusFilterSelection.equals("Deleted")) {
                filterAccountListStatus = accountControl.selectAllAccuntFromStatus("Deleted");
            }

            //get filter position record
            if (tableType.equals("Customer")) {
                filterAccountListPosition = accountControl.getAllCertainRecords("Customer");
            }
            else if (tableType.equals("Staff")) {
                filterAccountListPosition = accountControl.getAllCertainRecords("Staff");
            }

            //double for loop to compare filterAccountListStatus and filterAccountListPosition
            if (filterAccountListStatus != null && filterAccountListPosition != null) {
                for (Account accountStatus : filterAccountListStatus) {
                    for (Account accountPosition : filterAccountListPosition) {
                        //compare accounts based on their properties
                        if (accountStatus.getPosition().equals(accountPosition.getPosition()) && 
                            accountStatus.getStatus().equals(accountPosition.getStatus())) {
                            //if the accounts match, add them to the filterAccountList
                            filterAccountList.add(accountStatus);
                            break; //break the inner loop once a match is found
                        }
                    }
                }
            }
            else if(filterAccountListStatus == null && filterAccountListPosition != null){  //means status is all
                filterAccountList = filterAccountListPosition;
            }


            request.getSession().setAttribute("filterAccountList", filterAccountList);
        }
        else if(tableType.equals("salesRecords")){  //for sales records
            ArrayList<Order> filterOrderList;

            MaintainOrderControl orderControl = new MaintainOrderControl();
            String startOfDay = "";
            String endOfDay = "";
            //get the current date
            LocalDate currentDate = LocalDate.now();
            //change input parameter to new format for later easy set
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            //calculate start date and end date
            if (statusFilterSelection.equals("Daily")) {
                //convert LocalDate objects to String
                String todayDateString = currentDate.format(dateFormat);

                startOfDay = todayDateString;
                endOfDay = todayDateString;

            }
            else if (statusFilterSelection.equals("Weekly")) {
                int dayOfWeek = currentDate.getDayOfWeek().getValue();

                //calculate the number of days to subtract to get to the start of the week (Monday)
                int daysToSubtract = dayOfWeek - 1;

                //calculate the number of days to add to get to the end of the week (Sunday)
                int daysToAdd = 7 - dayOfWeek;

                //adjust the dates accordingly
                LocalDate startOfWeek = currentDate.minusDays(daysToSubtract);
                LocalDate endOfWeek = currentDate.plusDays(daysToAdd);

                //convert LocalDate objects to String
                String startOfWeekString = startOfWeek.format(dateFormat);
                String endOfWeekString = endOfWeek.format(dateFormat);

                startOfDay = startOfWeekString;
                endOfDay = endOfWeekString;
            }
            else if (statusFilterSelection.equals("Monthly")) {

                LocalDate startDate = currentDate.withDayOfMonth(1);
                LocalDate endDate = currentDate.withDayOfMonth(currentDate.lengthOfMonth());

                //convert LocalDate objects to String
                String startDateString = startDate.format(dateFormat);
                String endDateString = endDate.format(dateFormat);

                startOfDay = startDateString;
                endOfDay = endDateString;
            }
            else{
                //for all
            }
            
            //get filterOrderList
            if (!startOfDay.equals("") && !endOfDay.equals("")) {
                filterOrderList = getOrdersByDate(startOfDay, endOfDay);
                //filterOrderList = orderControl.getPaidOrdersByDate(startOfDay, endOfDay);
            }
            else{
                filterOrderList = getOrdersByDate("", "");
                //filterOrderList = orderControl.getPaidOrdersByDate("", "");
            }
            
            request.getSession().setAttribute("filterOrderList", filterOrderList);
        
        }
        else if(tableType.equals("salesReport")){  //for sales report
            ArrayList<Order> filterOrderList;
            
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            
            //to set the value back to jsp
            request.getSession().setAttribute("startDateStr", startDateStr);
            request.getSession().setAttribute("endDateStr", endDateStr);
            
            filterOrderList = getOrdersByDate(startDateStr, endDateStr);
            
            request.getSession().setAttribute("filterOrderList", filterOrderList);

        }
        else if(tableType.equals("customerOrder")){  //for customer Order
            MaintainOrderControl orderControl = new MaintainOrderControl();

            ArrayList<Order> filterOrderList = null;
            
            if (statusFilterSelection.equals("All")) {
                //skip
            }
            else if (statusFilterSelection.equals("Paid")) {
                filterOrderList = orderControl.getOrdersByStatus("Paid");
            }
            else if (statusFilterSelection.equals("Unpaid")) {
                filterOrderList = orderControl.getOrdersByStatus("Unpaid");
            }
            
            request.getSession().setAttribute("filterOrderList", filterOrderList);
        }
        else{   //for item
            MaintainProductControl productControl = new MaintainProductControl();
            String searchItemBy = request.getParameter("searchItemBy");
            ArrayList<Product> filterProductListStatus = null;
            ArrayList<Product> productFilterSearchRecords = null;
            ArrayList<Product> filterProductFinalList = new ArrayList<>();
            
            if(!searchItemBy.equals("")){
                productFilterSearchRecords = productControl.getAllProducts(searchItemBy, "", "getAll");
            }
            

            if (statusFilterSelection.equals("All")) {
                filterProductListStatus = productControl.getAllProductsFromIsActive("");
            }
            else if (statusFilterSelection.equals("Active")) {
                filterProductListStatus = productControl.getAllProductsFromIsActive("true");
            }
            else if (statusFilterSelection.equals("Inactive")) {
                filterProductListStatus = productControl.getAllProductsFromIsActive("false");
            }
            
            //double for loop to compare filterProductListStatus and productFilterSearchRecords
            if (filterProductListStatus != null && productFilterSearchRecords != null) {
                for (Product productStatus : filterProductListStatus) {
                    for (Product productSearched : productFilterSearchRecords) {
                        //compare product based on their properties
                        if (productStatus.getId() == (productSearched.getId())) {
                            //if the product match, add them to the filterProductFinalList
                            filterProductFinalList.add(productStatus);
                            break; //break the inner loop once a match is found
                        }
                    }
                }
            }
            else if(productFilterSearchRecords == null && filterProductListStatus != null){  //without input search
                filterProductFinalList = filterProductListStatus;
            }
            request.getSession().setAttribute("searchItemBy", searchItemBy);
            request.getSession().setAttribute("filterProductList", filterProductFinalList);
        }
        //return to jsp so can select back the option that user selected
        request.getSession().setAttribute("filterSelection", statusFilterSelection);
        
        //send redirect their page
        if (tableType.equals("Customer")) {
            response.sendRedirect("jsp/Manager/manageCustomer.jsp");
        }
        else if (tableType.equals("Staff")) {
            response.sendRedirect("jsp/Manager/manageStaff.jsp");
        }
        else if (tableType.equals("Item")) {
            response.sendRedirect("jsp/Manager/manageItem.jsp");
        }
        else if (tableType.equals("salesRecords")) {
            response.sendRedirect("jsp/Manager/salesRecords.jsp");
        }
        else if (tableType.equals("salesReport")) {
            response.sendRedirect("jsp/Manager/salesReport.jsp");
        }
        else if (tableType.equals("customerOrder")) {
            response.sendRedirect("jsp/Manager/manageCustomerOrder.jsp");
        }
        
    }

    private ArrayList<Order> getOrdersByDate(String startDateStr, String endDateStr){
        MaintainOrderControl orderControl = new MaintainOrderControl();
        //convert to year first to compare string
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter indateTimeFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        DateTimeFormatter outdateTimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        ArrayList<Order> originalOrdersList = orderControl.getOrdersByStatus("Paid");
        ArrayList<Order> toReturnOrdersList = new ArrayList<>();
        
        if(startDateStr.equals("") && endDateStr.equals("")){
            return originalOrdersList;
        }
        
        //change string to date
        LocalDate startDate = LocalDate.parse(startDateStr);
        LocalDate endDate = LocalDate.parse(endDateStr);
        
        //convert LocalDate objects to String
        String startDateString = startDate.format(dateFormat);
        String endDateString = endDate.format(dateFormat);
        //set h m s for start date and end date 
        String startOfDay = startDateString + " 00:00:00";
        String endOfDay = endDateString + " 23:59:59";
        
        for (Order order : originalOrdersList) {
            String oriDateStr = order.getCompletionDate();
            
            LocalDateTime oriDateTime = LocalDateTime.parse(oriDateStr, indateTimeFormat);
            String orderDateString = oriDateTime.format(outdateTimeFormat);
            
            int result1 = startOfDay.compareTo(orderDateString);
            int result2 = endOfDay.compareTo(orderDateString);
            if(result1 < 0 && result2 > 0){
                //the order date is between the range
                toReturnOrdersList.add(order);
            }            
        }

        return toReturnOrdersList;
    }
}
