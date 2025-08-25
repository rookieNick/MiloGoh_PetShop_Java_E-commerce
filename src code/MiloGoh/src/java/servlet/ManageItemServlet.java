/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.*;
import domain.*;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50)   // 50 MB
@WebServlet("/ManageItemServlet")
public class ManageItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve form data
        int productID = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String type = request.getParameter("type");
        String category = request.getParameter("category");
        int stockQty = Integer.parseInt(request.getParameter("stockQty"));

        String updateBtn = request.getParameter("updateBtn");
        String activateBtn = request.getParameter("activateBtn");
        String deactivateBtn = request.getParameter("deactivateBtn");

        //validation start---------------------------------
        Boolean isInvalid = false;
        String errorMsgProduct = "";

        //CHECK DUPLICATE IN DATABASE (ic,username,email,phone)
        MaintainProductControl productControl = new MaintainProductControl();
        ArrayList<Product> prodList = productControl.getAllProducts("","","");
        for (Product prod : prodList) {
            if (prod.getName().equals(name) && !prod.getName().equals(name)) {
                isInvalid = true;
                errorMsgProduct += "Product name already exists\n";
            }

            if (prod.getDescription().equals(description) && !prod.getDescription().equals(description)) {
                isInvalid = true;
                errorMsgProduct += "Product description already exists\n";
            }

        }
        //validation end---------------------------

        Product product = productControl.selectProductById(productID);
        product.setName(name);
        product.setDescription(description);
        product.setUnitPrice(unitPrice);
        product.setType(type);
        product.setCategory(category);
        product.setStockQty(stockQty);

//        MaintainImageControl imageControl = new MaintainImageControl();
//        Image image = imageControl.selectImageById(product.getImage().getId());
        if (isInvalid == false) {

            if ("Update".equals(updateBtn)) {
                // Call the addRecord method in MaintainProductControl to add the new product
                productControl = new MaintainProductControl();
                productControl.editProduct(product);

//                // UPLOAD FILE START--------------------------------
//                // Retrieve and process image files
//                ArrayList<byte[]> imageBytesList = new ArrayList<>();
//                Collection<Part> fileParts = request.getParts();
//                for (Part filePart : fileParts) {
//                    if (filePart.getName().equals("image") && filePart.getSize() > 0) {
//                        InputStream inputStream = filePart.getInputStream();
//                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//                        byte[] buffer = new byte[1024];
//                        int length;
//                        while ((length = inputStream.read(buffer)) != -1) {
//                            outputStream.write(buffer, 0, length);
//                        }
//                        byte[] imageBytes = outputStream.toByteArray();
//                        outputStream.close();
//                        inputStream.close();
//                        imageBytesList.add(imageBytes);
//                    }
//                }
//
//                // Create an Image object with the byte array
//                int noOfFile = imageBytesList.size();
//                if (noOfFile >= 1) {
//                    image.setImage1(imageBytesList.get(0));
//                }
//                if (noOfFile >= 2) {
//                    image.setImage2(imageBytesList.get(1));
//                }
//                if (noOfFile >= 3) {
//                    image.setImage3(imageBytesList.get(2));
//                }
//                if (noOfFile >= 4) {
//                    image.setImage4(imageBytesList.get(3));
//                }
//                if (noOfFile >= 5) {
//                    image.setImage5(imageBytesList.get(4));
//                }
//                if (noOfFile >= 6) {
//                    image.setImage6(imageBytesList.get(5));
//                }
//                if (noOfFile >= 7) {
//                    image.setImage7(imageBytesList.get(6));
//                }
//                if (noOfFile >= 8) {
//                    image.setImage8(imageBytesList.get(7));
//                }
//                if (noOfFile >= 9) {
//                    image.setImage9(imageBytesList.get(8));
//                }
//                if (noOfFile >= 10) {
//                    image.setImage10(imageBytesList.get(9));
//                }
//
//                // Use MaintainImageControl to add the image to the database
//                imageControl = new MaintainImageControl();
//                imageControl.editImage(image);
//
//                //UPLOAD FILE END------------------------------------
                // Redirect to a success page
            } else if ("Activate".equals(activateBtn)) {
                product.setActive(true);

                productControl = new MaintainProductControl();
                productControl.editProduct(product);

            } else if ("Deactivate".equals(deactivateBtn)) {
                product.setActive(false);

                productControl = new MaintainProductControl();
                productControl.editProduct(product);

            }
            request.getSession().setAttribute("product", product);
            response.sendRedirect("jsp/Manager/productProfile.jsp?success=1");

        } else {
            // Set product object and error message as request attributes
            request.getSession().setAttribute("product", product);
            request.getSession().setAttribute("errorMsgProduct", errorMsgProduct);

            // Redirect to the add item page with error flag
            response.sendRedirect("jsp/Manager/productProfile.jsp?error=1");
        }

    }
}
