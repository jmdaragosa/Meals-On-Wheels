package com.utils;

import java.io.*;
import java.net.*;
import java.util.Base64;
import org.json.JSONObject;
import org.json.JSONArray;

public class PayPalUtil {

    public static String getAccessToken(String clientId, String secret) throws IOException {
        String auth = Base64.getEncoder().encodeToString((clientId + ":" + secret).getBytes());

        URL url = new URL("https://api-m.sandbox.paypal.com/v1/oauth2/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Basic " + auth);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setDoOutput(true);

        conn.getOutputStream().write("grant_type=client_credentials".getBytes());

        String response = readResponse(conn);
        JSONObject json = new JSONObject(response);
        return json.getString("access_token");
    }

    public static HttpURLConnection makeRequest(String urlStr, String method, String accessToken) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod(method);
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);
        return conn;
    }

    public static String readResponse(HttpURLConnection conn) throws IOException {
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder content = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }

        in.close();
        return content.toString();
    }
}
