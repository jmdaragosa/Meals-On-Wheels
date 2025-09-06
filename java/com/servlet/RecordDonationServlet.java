package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Handles POST /record-donation
 */
@WebServlet("/record-donation")
@MultipartConfig                       // <-- allows multipart/form-data
public class RecordDonationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String amountStr = req.getParameter("donateamount");
        if (amountStr == null || amountStr.trim().isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("Missing donation amount");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql =
              "INSERT INTO donation (" +
              " donor_name, donor_email, donor_phonenum, donor_address, " +
              " donation_amount, donation_frequency, donation_purpose, " +
              " card_number, expiry_date, billing_address" +
              ") VALUES (?,?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, req.getParameter("name")   != null ? req.getParameter("name")   : "PayPal Donor");
                ps.setString(2, req.getParameter("email")  != null ? req.getParameter("email")  : "paypal@example.com");

                long phone = 0L;
                String phoneStr = req.getParameter("number");
                if (phoneStr != null && phoneStr.matches("\\d{6,15}"))
                    phone = Long.parseLong(phoneStr);
                ps.setLong(3, phone);

                ps.setString(4, req.getParameter("address") != null ? req.getParameter("address") : "N/A");
                ps.setBigDecimal(5, new BigDecimal(amountStr));
                ps.setString(6, req.getParameter("frequency") != null ? req.getParameter("frequency") : "ONE-TIME");
                ps.setString(7, req.getParameter("purpose"));

                ps.setString(8,  "0000000000000000");                 // dummy card number
                ps.setDate  (9,  Date.valueOf("2030-12-31"));         // dummy expiry
                ps.setString(10, "PayPal Checkout");                  // dummy billing

                ps.executeUpdate();
            }

            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write("Donation recorded.");

        } catch (NumberFormatException | SQLException ex) {
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("DB error: " + ex.getMessage());
        }
    }
}
