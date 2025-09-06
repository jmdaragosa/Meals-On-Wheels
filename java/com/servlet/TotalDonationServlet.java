package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/get-total-donation")
public class TotalDonationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("application/json");
        double total = 0.0;

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT SUM(donation_amount) AS total FROM donation");
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) total = rs.getDouble("total");

        } catch (Exception e) {
            e.printStackTrace();  // still return 0 if error
        }

        PrintWriter out = res.getWriter();
        out.print("{\"total\":" + total + "}");
        out.flush();
    }
}
