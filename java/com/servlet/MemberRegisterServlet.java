package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/MemberRegister")
public class MemberRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("➡️ GET /MemberRegister called");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterMember.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("➡️ POST /MemberRegister called");

        // Retrieve form data
        String name = request.getParameter("name");
        String role = request.getParameter("userrole");
        String email = request.getParameter("email");
        String[] dietaryreq = request.getParameterValues("dietaryreq");

        // Convert dietaryreq to JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String jsonDietary = "[]";
        if (dietaryreq != null) {
            jsonDietary = objectMapper.writeValueAsString(dietaryreq);
            System.out.println("✅ Dietary requirements mapped into JSON: " + jsonDietary);
        }

        String phoneNum = request.getParameter("phoneNum");
        phoneNum = phoneNum.replaceAll("[^\\d]", "");
        long lngphoneNum = 0;
        try {
            lngphoneNum = Long.parseLong(phoneNum);
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid phone number");
            e.printStackTrace();
        }

        String disDesc = request.getParameter("disDesc");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("confpassword");
        String delTime = request.getParameter("deltime");
        String emerName = request.getParameter("emername");
        String emerPhoneNum = request.getParameter("emernum");

        emerPhoneNum = emerPhoneNum.replaceAll("[^\\d]", "");
        long lngEmerPhoneNum = 0;
        try {
            lngEmerPhoneNum = Long.parseLong(emerPhoneNum);
        } catch (NumberFormatException e) {
            System.out.println("❌ Invalid emergency phone number");
            e.printStackTrace();
        }

        System.out.println("🔒 Checking password match...");
        if (!password.equals(rePassword)) {
            System.out.println("❌ Passwords do not match");
            HttpSession session = request.getSession();
            session.setAttribute("error", "Mismatched Passwords, Try again");
            response.sendRedirect("RegisterMember");
            return;
        }

        System.out.println("🔐 Hashing password...");
        String salt = PasswordUtils.generateSalt();
        String hashedPassword = PasswordUtils.hashPassword(password, salt);

        System.out.println("🔌 Connecting to DB...");
        try (Connection conn = DatabaseManager.getConnection()) {

            System.out.println("🔎 Checking for duplicate email...");
            String checkQuery = "SELECT COUNT(*) AS count FROM memberuser WHERE mem_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                        System.out.println("❌ Email already exists: " + email);
                        HttpSession session = request.getSession();
                        session.setAttribute("error", "Email Already in Use, Please Log in Instead");
                        response.sendRedirect("RegisterMember");
                        return;
                    }
                }
            }

            System.out.println("📥 Inserting into database...");
            String insertQuery = "INSERT INTO memberuser (mem_name, mem_email, mem_phonenum, mem_address, mem_password, mem_salt, mem_role, mem_dietreq, mem_disdesc, mem_deltime, mem_emername, mem_emerphonenum) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setLong(3, lngphoneNum);
                stmt.setString(4, address);
                stmt.setString(5, hashedPassword);
                stmt.setString(6, salt);
                stmt.setString(7, role);
                stmt.setString(8, jsonDietary);
                stmt.setString(9, disDesc);
                stmt.setString(10, delTime);
                stmt.setString(11, emerName);
                stmt.setLong(12, lngEmerPhoneNum);

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("✅ Registration successful for: " + email);
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Registration successful! Please login.");
                    response.sendRedirect("Login");
                } else {
                    System.out.println("❌ Registration failed - No rows inserted");
                    HttpSession session = request.getSession();
                    session.setAttribute("error", "Registration failed. Please try again.");
                    response.sendRedirect("RegisterMember");
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ SQL Exception occurred:");
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect("RegisterMember");
        }
    }
}
