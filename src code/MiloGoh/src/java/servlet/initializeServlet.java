package servlet;

import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author zlsy2
 */
public class initializeServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        System.out.println("init");
        String companyName = "MLG";
        String copyRight = "MLG - Copyright";
        ServletContext context = getServletContext();
        if (context.getInitParameter("companyName") != null) {
            companyName = context.getInitParameter("companyName");
        }
        if (context.getInitParameter("copyRight") != null) {
            copyRight = context.getInitParameter("copyRight");
        }
        context.setAttribute("companyName", companyName);
        context.setAttribute("copyRight", copyRight);
    }
    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
        System.out.println("doGet");
    }
}
