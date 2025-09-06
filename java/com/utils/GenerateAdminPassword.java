package com.utils;

public class GenerateAdminPassword {
	public static void main(String[] args) {
        String password = "admin123"; // <-- Use your desired password here

        String salt = PasswordUtils.generateSalt();
        String hash = PasswordUtils.hashPassword(password, salt);

        System.out.println("Password: " + password);
        System.out.println("Salt: " + salt);
        System.out.println("Hash: " + hash);
    }
}
