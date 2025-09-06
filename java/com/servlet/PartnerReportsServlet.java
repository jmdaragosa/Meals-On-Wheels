package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PartnerReports")
public class PartnerReportsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(); 
    	int partnerId = Integer.parseInt(session.getAttribute("userId").toString());
        List<String> types = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "SELECT meal_type, COUNT(*) FROM meal WHERE meal_createdby = ? GROUP BY meal_type";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, partnerId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    types.add("\"" + rs.getString(1) + "\"");
                    counts.add(rs.getInt(2));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("mealTypes", types.toString());
        request.setAttribute("mealCounts", counts.toString());
        request.getRequestDispatcher("PartnerReports.jsp").forward(request, response);
    }
}
