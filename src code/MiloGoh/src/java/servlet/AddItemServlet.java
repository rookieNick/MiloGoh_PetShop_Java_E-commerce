/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import Exception.InvalidPasswordException;
import Exception.Password;
import control.*;
import domain.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/**
 *
 * @author User
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50)   // 50 MB
@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve form data
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String type = request.getParameter("type");
        String category = request.getParameter("category");
        int stockQty = Integer.parseInt(request.getParameter("stockQty"));

        //validation start---------------------------------
        Boolean isInvalid = false;
        String errorMsgProduct = "";

        //CHECK DUPLICATE IN DATABASE (ic,username,email,phone)
        MaintainProductControl productControl = new MaintainProductControl();
        ArrayList<Product> prodList = productControl.getAllProducts("","","");
        for (Product prod : prodList) {
            if (prod.getName().equals(name)) {
                isInvalid = true;
                errorMsgProduct += "Product name already exists\n";
            }

            if (prod.getDescription().equals(description)) {
                isInvalid = true;
                errorMsgProduct += "Product description already exists\n";
            }

        }
        //validation end---------------------------

        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setUnitPrice(unitPrice);
        product.setType(type);
        product.setCategory(category);
        product.setStockQty(stockQty);

        Image image = new Image();
        int newImageId = productControl.getNewProductId();
        image.setId(newImageId);
        product.setImage(image);

        if (isInvalid == false) {

            // Call the addRecord method in MaintainProductControl to add the new product
            productControl = new MaintainProductControl();
            productControl.addProduct(product);

            // UPLOAD FILE START--------------------------------
            // Retrieve and process image files
            ArrayList<byte[]> imageBytesList = new ArrayList<>();
            Collection<Part> fileParts = request.getParts();
            for (Part filePart : fileParts) {
                if (filePart.getName().equals("image") && filePart.getSize() > 0) {
                    InputStream inputStream = filePart.getInputStream();
                    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, length);
                    }
                    byte[] imageBytes = outputStream.toByteArray();
                    outputStream.close();
                    inputStream.close();
                    imageBytesList.add(imageBytes);
                }
            }

            // Create an Image object with the byte array
            int noOfFile = imageBytesList.size();
            if (noOfFile >= 1) {
                image.setImage1(imageBytesList.get(0));
            }
            if (noOfFile >= 2) {
                image.setImage2(imageBytesList.get(1));
            }
            if (noOfFile >= 3) {
                image.setImage3(imageBytesList.get(2));
            }
            if (noOfFile >= 4) {
                image.setImage4(imageBytesList.get(3));
            }
            if (noOfFile >= 5) {
                image.setImage5(imageBytesList.get(4));
            }
            if (noOfFile >= 6) {
                image.setImage6(imageBytesList.get(5));
            }
            if (noOfFile >= 7) {
                image.setImage7(imageBytesList.get(6));
            }
            if (noOfFile >= 8) {
                image.setImage8(imageBytesList.get(7));
            }
            if (noOfFile >= 9) {
                image.setImage9(imageBytesList.get(8));
            }
            if (noOfFile >= 10) {
                image.setImage10(imageBytesList.get(9));
            }

            // Use MaintainImageControl to add the image to the database
            MaintainImageControl imageControl = new MaintainImageControl();
            imageControl.addImage(image);

            //UPLOAD FILE END------------------------------------
            // Redirect to a success page
            response.sendRedirect("jsp/Manager/addItem.jsp?success=1");

        } else {
            // Set product object and error message as request attributes
            request.getSession().setAttribute("product", product);
            request.getSession().setAttribute("errorMsgProduct", errorMsgProduct);

            // Redirect to the add item page with error flag
            response.sendRedirect("jsp/Manager/addItem.jsp?error=1");
        }

    }
}
