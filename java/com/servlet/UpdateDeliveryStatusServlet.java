package com.servlet;

import com.utils.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Set;

@WebServlet("/UpdateDeliveryStatus")
public class UpdateDeliveryStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Define allowed statuses as a constant Set (faster lookup)
    private static final Set<String> ALLOWED_STATUSES = Set.of("PENDING", "DISPATCHED", "DELIVERED", "CANCELLED");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read and trim parameters
        String deliveryIdParam = request.getParameter("deliveryId");
        String newStatus = request.getParameter("status");

        if (deliveryIdParam == null || newStatus == null ||
            deliveryIdParam.isBlank() || newStatus.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing deliveryId or status.");
            return;
        }

        int deliveryId;
        try {
            deliveryId = Integer.parseInt(deliveryIdParam);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid deliveryId.");
            return;
        }

        newStatus = newStatus.trim().toUpperCase();
        if (!ALLOWED_STATUSES.contains(newStatus)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid status value.");
            return;
        }

        // Perform the update
        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "UPDATE delivery SET status = ? WHERE delivery_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newStatus);
                stmt.setInt(2, deliveryId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("success");
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Delivery not found.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Debug log
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error while updating delivery.");
        }
    }
}
