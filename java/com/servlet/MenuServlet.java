package com.servlet;

import com.dao.MealDAO;
import com.models.Meal;
import com.utils.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DatabaseManager.getConnection()) {
            MealDAO mealDAO = new MealDAO(conn);
            List<Meal> meals = mealDAO.getAllMeals();

            request.setAttribute("mealList", meals);
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
