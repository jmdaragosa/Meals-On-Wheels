package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/VolunteerDashboard")
public class VolunteerDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountType") == null || !"VOLUNTEER".equals(session.getAttribute("accountType"))) {
            response.sendRedirect("Login");
            return;
        }

        int volunteerId;
        try {
            volunteerId = Integer.parseInt(session.getAttribute("userId").toString());
        } catch (Exception e) {
            response.sendRedirect("Login");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            // Upcoming Deliveries
            String upcomingSql = """
                SELECT m.meal_name, d.delivery_date, d.delivery_time, mem.mem_name, mem.mem_address
                FROM delivery d
                JOIN meal m ON d.meal_id = m.meal_id
                JOIN memberuser mem ON d.member_id = mem.mem_userid
                WHERE d.volunteer_id = ? AND d.delivery_date >= CURDATE()
                ORDER BY d.delivery_date ASC
                LIMIT 5
            """;

            try (PreparedStatement stmt = conn.prepareStatement(upcomingSql)) {
                stmt.setInt(1, volunteerId);
                ResultSet rs = stmt.executeQuery();
                List<String[]> upcomingDeliveries = new ArrayList<>();

                while (rs.next()) {
                    upcomingDeliveries.add(new String[] {
                        rs.getString("meal_name"),
                        rs.getString("delivery_date"),
                        rs.getString("delivery_time"),
                        rs.getString("mem_name"),
                        rs.getString("mem_address")
                    });
                }
                request.setAttribute("upcomingDeliveries", upcomingDeliveries);
            }

            // Delivery History
            String historySql = """
                SELECT m.meal_name, d.delivery_date, d.delivery_time, d.status
                FROM delivery d
                JOIN meal m ON d.meal_id = m.meal_id
                WHERE d.volunteer_id = ? AND d.delivery_date < CURDATE()
                ORDER BY d.delivery_date DESC
                LIMIT 5
            """;

            try (PreparedStatement stmt = conn.prepareStatement(historySql)) {
                stmt.setInt(1, volunteerId);
                ResultSet rs = stmt.executeQuery();
                List<String[]> deliveryHistory = new ArrayList<>();

                while (rs.next()) {
                    deliveryHistory.add(new String[] {
                        rs.getString("meal_name"),
                        rs.getString("delivery_date"),
                        rs.getString("delivery_time"),
                        rs.getString("status")
                    });
                }
                request.setAttribute("deliveryHistory", deliveryHistory);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("VolunteerDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
