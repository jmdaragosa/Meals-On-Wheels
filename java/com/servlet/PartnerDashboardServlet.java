package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/PartnerDashboard")
public class PartnerDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountType") == null || !"PARTNER".equals(session.getAttribute("accountType"))) {
            response.sendRedirect("Login");
            return;
        }

        int partnerId;
        try {
            partnerId = Integer.parseInt(session.getAttribute("userId").toString());
        } catch (Exception e) {
            response.sendRedirect("Login");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            // Count meals created by this partner
            String mealsQuery = "SELECT COUNT(*) FROM meal WHERE meal_createdby = ?";
            try (PreparedStatement stmt = conn.prepareStatement(mealsQuery)) {
                stmt.setInt(1, partnerId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("totalMeals", rs.getInt(1));
                }
            }

            // Count deliveries linked to meals created by this partner
            String deliveryQuery = "SELECT COUNT(*) FROM delivery d JOIN meal m ON d.meal_id = m.meal_id WHERE m.meal_createdby = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deliveryQuery)) {
                stmt.setInt(1, partnerId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    request.setAttribute("totalDeliveries", rs.getInt(1));
                }
            }

            // Default donation display (even if unused yet)
            request.setAttribute("totalDonations", "0.00");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("PartnerDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
