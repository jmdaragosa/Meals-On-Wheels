package com.servlet;

import com.utils.DatabaseManager;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@WebServlet("/ManageMeals")
public class ManageMealsServlet extends HttpServlet {
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer partnerId = getLoggedInUserId(request);
        if (partnerId == null) {
            response.sendRedirect("Login");
            return;
        }

        List<Map<String, Object>> meals = new ArrayList<>();

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "SELECT meal_id, meal_name, meal_description, meal_diettag, meal_allergens FROM meal WHERE meal_createdby = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, partnerId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String, Object> meal = new HashMap<>();
                    meal.put("meal_id", rs.getInt("meal_id"));
                    meal.put("meal_name", rs.getString("meal_name"));
                    meal.put("meal_description", rs.getString("meal_description"));

                    // Convert JSON strings to List<String>
                    String dietJson = rs.getString("meal_diettag");
                    String allergenJson = rs.getString("meal_allergens");

                    List<String> dietList = dietJson != null ? gson.fromJson(dietJson, new TypeToken<List<String>>(){}.getType()) : new ArrayList<>();
                    List<String> allergenList = allergenJson != null ? gson.fromJson(allergenJson, new TypeToken<List<String>>(){}.getType()) : new ArrayList<>();

                    meal.put("meal_diettag", dietList);
                    meal.put("meal_allergens", allergenList);

                    meals.add(meal);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching meals.");
            return;
        }

        request.setAttribute("meals", meals);
        request.getRequestDispatcher("ManageMeals.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer partnerId = getLoggedInUserId(request);
        if (partnerId == null) {
            response.sendRedirect("Login");
            return;
        }

        String name = request.getParameter("meal_name");
        String desc = request.getParameter("meal_description");

        String[] dietTagsArray = request.getParameterValues("diettags");
        String[] allergensArray = request.getParameterValues("allergens");

        String dietTagsJson = gson.toJson(dietTagsArray != null ? Arrays.asList(dietTagsArray) : new ArrayList<>());
        String allergensJson = gson.toJson(allergensArray != null ? Arrays.asList(allergensArray) : new ArrayList<>());

        try (Connection conn = DatabaseManager.getConnection()) {
            String sql = "INSERT INTO meal (meal_name, meal_type, meal_description, meal_diettag, meal_allergens, meal_createdby) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, "LUNCH");
                stmt.setString(3, desc);
                stmt.setString(4, dietTagsJson);
                stmt.setString(5, allergensJson);
                stmt.setInt(6, partnerId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
            return;
        }

        response.sendRedirect("ManageMeals");
    }

    private Integer getLoggedInUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj != null) {
                try {
                    return Integer.parseInt(userIdObj.toString());
                } catch (NumberFormatException ignored) {
                }
            }
        }
        return null;
    }
}
