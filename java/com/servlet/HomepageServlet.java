package com.servlet;

import java.io.IOException; 
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/Home")
public class HomepageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = false;

        if (session != null && session.getAttribute("userFirstName") != null) {
            isLoggedIn = true;
            System.out.println("User is logged in: " + session.getAttribute("userFirstName"));
        }

        request.setAttribute("isLoggedIn", isLoggedIn);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Homepage.jsp");
        dispatcher.forward(request, response);
    }
}
