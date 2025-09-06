package com.servlet;

import com.utils.DatabaseManager;
import com.utils.EncryptionUtils;
import java.io.IOException; 
import java.sql.*;	
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@MultipartConfig
@WebServlet("/Donate")
public class DonationPageServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Getting page");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/DonationPage.jsp");
	    dispatcher.forward(request, response);
	}
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Starting Process");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNum = request.getParameter("number");
        String address = request.getParameter("address");
        String donateAmount = request.getParameter("donateamount");
        String frequency = request.getParameter("frequency");
        String purpose = request.getParameter("purpose");
        String cardNum = request.getParameter("cardnum");
        String expDate = request.getParameter("expdate");
        String billAdd = request.getParameter("billadd");
        String sameAsDonAddParam = request.getParameter("sameasdonadd");
        
        boolean sameAsDonorAdd = (sameAsDonAddParam != null && sameAsDonAddParam.equalsIgnoreCase("TRUE"));
        if (sameAsDonorAdd == true) {
        	billAdd = address;
        }
        
        String subNewsParam = request.getParameter("subnews");
        
        boolean subNews = (subNewsParam != null && subNewsParam.equalsIgnoreCase("TRUE"));
        
        String anonParam = request.getParameter("anon");
        
        boolean anon = (anonParam != null && anonParam.equalsIgnoreCase("TRUE"));
        
        String notes = request.getParameter("notes");
        String dedication = request.getParameter("dedication");
        
        String encryptedCardNum = "";
        
        System.out.println("Encrypting");
        try {
            encryptedCardNum = EncryptionUtils.encrypt(cardNum);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to encrypt card number.");
            request.getRequestDispatcher("/DonationForm.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Connecting to DB");
        	try (Connection conn = DatabaseManager.getConnection()) {
            
        	System.out.println("Inserting");
            // Proceed with insertion if email is not used
            String insertQuery = "INSERT INTO donation (donor_name, donor_email, donor_phonenum, donor_address, donation_amount, donation_frequency, donation_purpose, card_number, expiry_date, billing_address, same_as_donor, subscribe_newsletter, anonymous, donor_notes, dedicate_message) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phoneNum);
                stmt.setString(4, address);
                stmt.setString(5, donateAmount);
                stmt.setString(6, frequency);
                stmt.setString(7, purpose);
                stmt.setString(8, encryptedCardNum);
                stmt.setString(9, expDate);
                stmt.setString(10, billAdd);
                stmt.setBoolean(11, sameAsDonorAdd);
                stmt.setBoolean(12, subNews);
                stmt.setBoolean(13, anon);
                stmt.setString(14, notes);
                stmt.setString(15, dedication);

                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                	System.out.println("Success");
                    request.setAttribute("message", "Donation successful!");
                    response.sendRedirect("Home");
                } else {
                	System.out.println("Failed");
                    request.setAttribute("error", "Donation Failed. Please try again.");
                    request.getRequestDispatcher("/DonationPage.jsp").forward(request, response);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("DB Fail");
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/DonationPage.jsp").forward(request, response);
        }
    }
}