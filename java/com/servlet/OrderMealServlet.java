package com.servlet;

import com.utils.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/OrderMealServlet")
public class OrderMealServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read meal ID and delivery time from form
        int mealId = Integer.parseInt(request.getParameter("mealId"));
        String deliveryTime = request.getParameter("deliveryTime");

        // Get member ID from session (set during login)
        HttpSession session = request.getSession();
        Integer memberId = (Integer) session.getAttribute("userId");

        if (memberId == null) {
            // Not logged in
            response.sendRedirect("Register");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {

            String sql = "INSERT INTO delivery (delivery_date, delivery_time, meal_id, member_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setDate(1, Date.valueOf(LocalDate.now()));
            stmt.setString(2, deliveryTime);
            stmt.setInt(3, mealId);
            stmt.setInt(4, memberId);

            stmt.executeUpdate();

            // Redirect back to menu with success message
            response.sendRedirect("menu?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("menu?error=true");
        }
    }
}
