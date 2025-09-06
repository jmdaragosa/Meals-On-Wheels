package com.dao;

import com.models.Meal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MealDAO {
    private Connection conn;

    public MealDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Meal> getAllMeals() throws SQLException {
        List<Meal> meals = new ArrayList<>();
        String sql = "SELECT * FROM meal";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Meal meal = new Meal();
                meal.setMeal_id(rs.getInt("meal_id"));
                meal.setMeal_name(rs.getString("meal_name"));
                meal.setMeal_type(rs.getString("meal_type"));
                meal.setMeal_description(rs.getString("meal_description"));
                meals.add(meal);
            }
        }

        return meals;
    }
}
