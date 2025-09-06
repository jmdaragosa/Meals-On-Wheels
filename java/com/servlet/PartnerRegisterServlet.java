package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/PartnerRegister")
public class PartnerRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterPartner.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form inputs
        String orgName = request.getParameter("orgname");
        String[] servType = request.getParameterValues("servtype");
        String contName = request.getParameter("contname");
        String dayRange = request.getParameter("dayrange");
        String timeRange = request.getParameter("timerange");
        String email = request.getParameter("email");
        String orgDesc = request.getParameter("orgdesc");
        String address = request.getParameter("address");
        String phoneNum = request.getParameter("number").replaceAll("[^\\d]", "");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("confpassword");

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonServType = servType != null ? objectMapper.writeValueAsString(servType) : "[]";

        // Validate passwords match
        if (!password.equals(rePassword)) {
            request.getSession().setAttribute("error", "Passwords do not match.");
            response.sendRedirect("RegisterPartner");
            return;
        }

        long lngPhoneNum;
        try {
            lngPhoneNum = Long.parseLong(phoneNum);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid phone number.");
            response.sendRedirect("RegisterPartner");
            return;
        }

        String salt = PasswordUtils.generateSalt();
        String hashedPassword = PasswordUtils.hashPassword(password, salt);

        try (Connection conn = DatabaseManager.getConnection()) {

            // Check for duplicate email
            String checkQuery = "SELECT COUNT(*) FROM partneruser WHERE org_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.getSession().setAttribute("error", "Email already registered.");
                        response.sendRedirect("RegisterPartner");
                        return;
                    }
                }
            }

            // Insert new partner
            String insertQuery = """
                INSERT INTO partneruser 
                (org_name, org_rep, org_email, org_address, org_phonenum, org_password, org_salt, org_service, org_dayrange, org_timerange, org_desc) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, orgName);
                stmt.setString(2, contName);
                stmt.setString(3, email);
                stmt.setString(4, address);
                stmt.setLong(5, lngPhoneNum);
                stmt.setString(6, hashedPassword);
                stmt.setString(7, salt);
                stmt.setString(8, jsonServType);
                stmt.setString(9, dayRange);
                stmt.setString(10, timeRange);
                stmt.setString(11, orgDesc);

                int affectedRows = stmt.executeUpdate();

                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int partnerId = generatedKeys.getInt(1);

                            // Set session (auto-login)
                            HttpSession session = request.getSession();
                            session.setAttribute("userId", partnerId);
                            session.setAttribute("name", orgName);
                            session.setAttribute("email", email);
                            session.setAttribute("accountType", "PARTNER");


                            response.sendRedirect("PartnerDashboard");
                            return;
                        }
                    }
                }
            }

            request.getSession().setAttribute("error", "Registration failed. Try again.");
            response.sendRedirect("RegisterPartner");

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect("RegisterPartner");
        }
    }
}
