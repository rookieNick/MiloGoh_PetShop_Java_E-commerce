/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import control.MaintainImageControl;
import domain.Image;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author User
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024,    // 1 MB
                 maxFileSize = 1024 * 1024 * 10,      // 10 MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50 MB
public class UploadImageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the file part from request
        Part filePart = request.getPart("image");

        // Get the input stream of the uploaded file
        InputStream inputStream = filePart.getInputStream();

        // Create a byte array output stream to read the input stream
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        // Buffer for reading data from input stream
        byte[] buffer = new byte[1024];
        int length;

        // Read data from input stream and write to byte array output stream
        while ((length = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, length);
        }

        // Convert the byte array output stream to byte array
        byte[] imageBytes = outputStream.toByteArray();

        // Close streams
        outputStream.close();
        inputStream.close();

        // Create an Image object with the byte array
        Image image = new Image();
        image.setImage1(imageBytes);
        

        // Use MaintainImageControl to add the image to the database
        MaintainImageControl imageControl = new MaintainImageControl();
        imageControl.addImage(image);

        // Redirect back to the upload image page after successful upload
        response.sendRedirect("jsp/uploadImage.jsp?success=1");
    }
}
