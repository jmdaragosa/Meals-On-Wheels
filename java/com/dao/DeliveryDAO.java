package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.models.Delivery;
import com.utils.DatabaseManager;

public class DeliveryDAO {

    public List<Delivery> getAllDeliveries() {
        List<Delivery> deliveries = new ArrayList<>();

        String sql = """
            SELECT 
                d.delivery_id,
                d.status,
                d.delivery_date,
                m.meal_name AS meal,
                u.mem_name AS client_name,
                u.mem_email AS email,
                u.mem_phonenum AS phone,
                u.mem_address AS address,
                u.mem_dietreq AS dietary_request
            FROM delivery d
            JOIN meal m ON d.meal_id = m.meal_id
            JOIN memberuser u ON d.member_id = u.mem_userid
        """;

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Delivery d = new Delivery();
                d.setDeliveryId(rs.getInt("delivery_id"));
                d.setStatus(rs.getString("status"));
                d.setDeliveryDate(rs.getString("delivery_date"));
                d.setMeal(rs.getString("meal"));
                d.setClientName(rs.getString("client_name"));
                d.setEmail(rs.getString("email"));
                d.setPhoneNumber(rs.getString("phone"));
                d.setAddress(rs.getString("address"));
                deliveries.add(d);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deliveries;
    }

    public boolean updateDeliveryStatus(int deliveryId, String newStatus) {
        String sql = "UPDATE delivery SET status = ? WHERE delivery_id = ?";

        try (Connection conn = DatabaseManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus.toUpperCase());
            stmt.setInt(2, deliveryId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
