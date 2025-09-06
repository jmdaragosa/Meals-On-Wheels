package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import java.io.IOException; 
import java.sql.*;	
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;


@WebServlet("/VolunteerRegister")
public class VolunteerRegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/RegisterVolunteer.jsp");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String dayRange = request.getParameter("dayrange");
        String timeRange = request.getParameter("timerange");
        String birthDate = request.getParameter("birthdate");
        Date sqlDate = Date.valueOf(birthDate);
        
        String prefDelArea = request.getParameter("prefdelarea");
        String email = request.getParameter("email");
        String emerName = request.getParameter("emername");
        String phoneNum = request.getParameter("number");
        
        phoneNum = phoneNum.replaceAll("[^\\d]", "");
        long lngPhoneNum = 0;
        try {
        	lngPhoneNum = Long.parseLong(phoneNum);
        } catch (NumberFormatException e) {
            // Handle invalid number (e.g., show error message or log the issue)
            e.printStackTrace();
        }
        
        String emerNum = request.getParameter("emernum");
        
        emerNum = emerNum.replaceAll("[^\\d]", "");
        long lngEmerPhoneNum = 0;
        try {
        	lngEmerPhoneNum = Long.parseLong(emerNum);
        } catch (NumberFormatException e) {
            // Handle invalid number (e.g., show error message or log the issue)
            e.printStackTrace();
        }
        String password = request.getParameter("password");
        String priorExp = request.getParameter("priorexp");
        String rePassword = request.getParameter("confpassword");
        String volunteerReason = request.getParameter("volunteerreason");
        
        // Validate input (check if passwords match)
        if (!password.equals(rePassword)) {
        	HttpSession session = request.getSession();
        	session.setAttribute("error", "Mismatched Passwords, Try again");
        	request.getRequestDispatcher("/RegisterVolunteer.jsp").forward(request, response); 
            return;
        }

        // Hash with salt
	    String salt = PasswordUtils.generateSalt();
	    String hashedPassword = PasswordUtils.hashPassword(password, salt);
        
        try (Connection conn = DatabaseManager.getConnection()) {
            
            // Check if the email is already in use
            String checkQuery = "SELECT COUNT(*) AS count FROM volunteeruser WHERE vol_email = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt("count") > 0) {
                    	HttpSession session = request.getSession();
                    	session.setAttribute("error", "Email Already in Use, Please Log in Instead");
                    	request.getRequestDispatcher("/RegisterVolunteer.jsp").forward(request, response); 
                        return;
                    }
                }
            }
            
            // Proceed with insertion if email is not used
            String insertQuery = "INSERT INTO volunteeruser (vol_name, vol_bdate, vol_email, vol_phonenum, vol_password, vol_salt, vol_dayrange, vol_timerange, vol_prefdelarea, vol_emername, vol_emerphonenum, vol_priorexp, vol_reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, name);
                stmt.setDate(2, sqlDate);
                stmt.setString(3, email);
                stmt.setLong(4, lngPhoneNum);
                stmt.setString(5, hashedPassword);
                stmt.setString(6, salt);
                stmt.setString(7, dayRange);
                stmt.setString(8, timeRange);
                stmt.setString(9, prefDelArea);
                stmt.setString(10, emerName);
                stmt.setLong(11, lngEmerPhoneNum);
                stmt.setString(12, priorExp);
                stmt.setString(13, volunteerReason);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                	HttpSession session = request.getSession();
                	session.setAttribute("message", "Registration successful! Please login.");
                	response.sendRedirect("Login");
                } else {
                	HttpSession session = request.getSession();
                	session.setAttribute("error", "Registration failed. Please try again.");
                	request.getRequestDispatcher("/RegisterVolunteer.jsp").forward(request, response);  
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/RegisterVolunteer.jsp").forward(request, response);
        }
    }
}