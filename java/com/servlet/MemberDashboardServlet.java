package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import com.google.gson.Gson;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/MemberDashboard")
public class MemberDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountType") == null || !"MEMBER".equals(session.getAttribute("accountType"))) {
            response.sendRedirect("Login");
            return;
        }

        int memberId;
        try {
            memberId = Integer.parseInt(session.getAttribute("userId").toString());
        } catch (Exception e) {
            response.sendRedirect("Login");
            return;
        }

        try (Connection conn = DatabaseManager.getConnection()) {
            // Upcoming meals
        	String upcomingSql = """
        		    SELECT m.meal_name, d.delivery_date, d.delivery_time
        		    FROM delivery d
        		    JOIN meal m ON d.meal_id = m.meal_id
        		    WHERE d.member_id = ? AND d.delivery_date >= CURDATE()
        		    ORDER BY d.delivery_date ASC
        		    LIMIT 5
        		""";
        	


            try (PreparedStatement stmt = conn.prepareStatement(upcomingSql)) {
                stmt.setInt(1, memberId);
                ResultSet rs = stmt.executeQuery();

                List<String[]> upcomingMeals = new ArrayList<>();
                while (rs.next()) {
                    upcomingMeals.add(new String[] {
                        rs.getString("meal_name"),
                        rs.getString("delivery_date"),
                        rs.getString("delivery_time")

                    });
                }
                request.setAttribute("upcomingMeals", upcomingMeals);
            }

            // Meal history
            String historySql = """
            	    SELECT m.meal_name, d.delivery_date, d.delivery_time
            	    FROM delivery d
            	    JOIN meal m ON d.meal_id = m.meal_id
            	    WHERE d.member_id = ? AND d.delivery_date < CURDATE()
            	    ORDER BY d.delivery_date DESC
            	    LIMIT 5
            	""";


            try (PreparedStatement stmt = conn.prepareStatement(historySql)) {
                stmt.setInt(1, memberId);
                ResultSet rs = stmt.executeQuery();

                List<String[]> mealHistory = new ArrayList<>();
                while (rs.next()) {
                    mealHistory.add(new String[] {
                        rs.getString("meal_name"),
                        rs.getString("delivery_date"),  
                        rs.getString("delivery_time") 
                    });
                }
                request.setAttribute("mealHistory", mealHistory);
            }

            // Dietary preferences
            String prefSql = "SELECT mem_dietreq FROM memberuser WHERE mem_userid = ?";
            try (PreparedStatement stmt = conn.prepareStatement(prefSql)) {
                stmt.setInt(1, memberId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String dietJson = rs.getString("mem_dietreq");
                    request.setAttribute("dietPrefs", dietJson);
                }
            }
            
         // All available meals
            String mealsSql = "SELECT meal_id, meal_name, meal_description, meal_diettag, meal_allergens FROM meal";
            try (PreparedStatement stmt = conn.prepareStatement(mealsSql);
                 ResultSet rs = stmt.executeQuery()) {

                List<Map<String, Object>> allMeals = new ArrayList<>();
                Gson gson = new Gson();

                while (rs.next()) {
                    Map<String, Object> meal = new HashMap<>();
                    meal.put("mealId", rs.getInt("meal_id"));
                    meal.put("mealName", rs.getString("meal_name"));
                    meal.put("mealDescription", rs.getString("meal_description"));

                    try {
                        meal.put("mealDietTag", gson.fromJson(rs.getString("meal_diettag"), List.class));
                    } catch (Exception e) {
                        meal.put("mealDietTag", List.of("Invalid"));
                    }

                    try {
                        meal.put("mealAllergens", gson.fromJson(rs.getString("meal_allergens"), List.class));
                    } catch (Exception e) {
                        meal.put("mealAllergens", List.of("Invalid"));
                    }

                    allMeals.add(meal);
                }

                request.setAttribute("allMeals", allMeals);
            }


        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
            return;
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("MemberDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
