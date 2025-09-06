package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

/**
 * Simple forward to the JSP so you can visit /admin-dashboard
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	System.out.println("Servlet called successfully!");
        RequestDispatcher rd = req.getRequestDispatcher("/admindashboard.jsp");
        rd.forward(req, resp);
    }
}
