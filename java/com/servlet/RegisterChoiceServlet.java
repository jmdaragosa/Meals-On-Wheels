package com.servlet;

import java.io.IOException; 
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/Register")
public class RegisterChoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if a user is already logged in
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("userFirstName") != null) {
            // Redirect logged-in users to their account page
            response.sendRedirect("Account");
            return;
        }

        // Otherwise, show the registration selection page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterSel.jsp");
        dispatcher.forward(request, response);
    }
}
