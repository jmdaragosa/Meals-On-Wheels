package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"MEMBER".equals(session.getAttribute("accountType"))) {
            response.sendRedirect("Login");
            return;
        }

        int memberId = Integer.parseInt(session.getAttribute("userId").toString());
        String mealIdStr = request.getParameter("mealId");
        if (mealIdStr == null) {
            response.sendRedirect("MemberDashboard");
            return;
        }

        int mealId = Integer.parseInt(mealIdStr);
        LocalDate deliveryDate = LocalDate.now().plusDays(1);
        String deliveryTime = "AFTERNOON";

        try (Connection conn = DatabaseManager.getConnection()) {
            String insertSql = "INSERT INTO delivery (member_id, meal_id, delivery_date, delivery_time, status) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setInt(1, memberId);
                stmt.setInt(2, mealId);
                stmt.setDate(3, java.sql.Date.valueOf(deliveryDate));
                stmt.setString(4, deliveryTime);
                stmt.setString(5, "pending");

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    // forward to confirmation page
                    request.getRequestDispatcher("OrderConfirmation.jsp").forward(request, response);
                    return; // <-- important
                } else {
                    session.setAttribute("orderError", "Failed to place order. Please try again.");
                    response.sendRedirect("MemberDashboard");
                    return; // <-- important
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("orderError", "Error placing order: " + e.getMessage());
            response.sendRedirect("MemberDashboard");
            return; // <-- important
        }
    }
}
