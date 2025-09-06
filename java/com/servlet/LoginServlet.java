package com.servlet;

import com.utils.DatabaseManager;
import com.utils.PasswordUtils;
import java.io.IOException; 
import java.sql.*;	
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;


@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/LoginPage.jsp");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String accountType = request.getParameter("acctype");		
		
		String tableName;
        String idColumn;
        String nameColumn;
        String emailColumn;
        String passwordColumn;
        String saltColumn;
        
		switch (accountType) {
        case "PARTNER":
            tableName = "partneruser";
            idColumn = "org_userid";
            nameColumn = "org_name";
            emailColumn = "org_email";
            passwordColumn = "org_password";
            saltColumn = "org_salt";
            break;
        case "VOLUNTEER":
            tableName = "volunteeruser";
            idColumn = "vol_userid";
            nameColumn = "vol_name";
            emailColumn = "vol_email";
            passwordColumn = "vol_password";
            saltColumn = "vol_salt";
            break;
        case "ADMIN":
            tableName = "adminuser";
            idColumn = "admin_userid";
            nameColumn = "admin_name";
            emailColumn = "admin_email";
            passwordColumn = "admin_password";
            saltColumn = "admin_salt";
            break;
        default: // Default to "User"
            tableName = "memberuser";
            idColumn = "mem_userid";
            nameColumn = "mem_name";
            emailColumn = "mem_email";
            passwordColumn = "mem_password";
            saltColumn = "mem_salt";
            break;
		}
		
	    try (Connection conn = DatabaseManager.getConnection()) {
	        String sql = "SELECT " + idColumn + ", " + nameColumn + ", " + passwordColumn + ", " + saltColumn + " FROM " + tableName + " WHERE " + emailColumn + " = ?";
	        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setString(1, email);
	            try (ResultSet rs = stmt.executeQuery()) {
	                if (rs.next()) {
	                    String userId = rs.getString(idColumn);
	                    String name = rs.getString(nameColumn);
	                    String salt = rs.getString(saltColumn);
	                    String storedHash = rs.getString(passwordColumn);

	                    // Verify the entered password
	                    if (PasswordUtils.verifyPassword(password, salt, storedHash)) {
	                        // Password is correct, create session
	                        HttpSession session = request.getSession();
	                        session.setAttribute("userId", userId);
	                        session.setAttribute("name", name);
	                        session.setAttribute("email", email);
	                        session.setAttribute("accountType", accountType);
	                        
	                        if ("PARTNER".equals(accountType)) {
	                            response.sendRedirect("PartnerDashboard");
	                        } else if ("VOLUNTEER".equals(accountType)) {
	                            response.sendRedirect("VolunteerDashboard");
	                        } else if ("ADMIN".equals(accountType)) {
	                            response.sendRedirect("admin-dashboard");
	                        }else {
	                            response.sendRedirect("MemberDashboard");
	                        }

	                    } else {
	                        // Wrong password
	                        HttpSession session = request.getSession();
	                        session.setAttribute("error", "Incorrect password");
	                        response.sendRedirect("Login");
	                        return;
	                    }
	                } else {
	                    // Email not found
	                	HttpSession session = request.getSession();
                    	session.setAttribute("error", "Invalid Email");
                    	request.getRequestDispatcher("Login").forward(request, response); 
                        return;
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
	    }
	}	
}