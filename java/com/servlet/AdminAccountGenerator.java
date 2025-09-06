package com.servlet;

import java.security.MessageDigest;
import java.security.SecureRandom;

public class AdminAccountGenerator {
    public static void main(String[] args) {
        String password = "admin123";
        String salt = generateSalt();
        String hashedPassword = hashPassword(password, salt);

        System.out.println("Use this in your SQL:");
        System.out.println("Salt: " + salt);
        System.out.println("Hashed Password: " + hashedPassword);
    }

    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] saltBytes = new byte[16];
        random.nextBytes(saltBytes);
        StringBuilder sb = new StringBuilder();
        for (byte b : saltBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    public static String hashPassword(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update((salt + password).getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
