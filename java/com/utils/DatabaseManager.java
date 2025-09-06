package com.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseManager {
    private static final String URL = "jdbc:mysql://localhost:3307/mmwebapp_db"; //Change the port on this one if you also changed the port on the XAMPP MySQL
    private static final String USER = "merryaccess";
    private static final String PASSWORD = "M3@lsOnWheels";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}