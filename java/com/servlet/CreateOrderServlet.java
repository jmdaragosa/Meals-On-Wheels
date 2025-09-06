package com.servlet;

import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import org.json.JSONObject;
import com.utils.PayPalUtil;

@WebServlet("/create-order")
public class CreateOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String clientId = "Abo2xKMyjhGEjkxb-a1evrmiDjsyItqJeVStljHTLAte37mErt_ixDeIQ-jci01PP5JF4o4mdKv9y8d0";
        String secret = "EDnzs9ElSg05bh3GJX-Y8QFpYYypwE2pvZfbr5dYCRHYbiQWLdKiGhRE_Y6I2uzuVqGRomkQi5wOG8GU"; // replace with your PayPal Sandbox secret

        BufferedReader reader = req.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        JSONObject json = new JSONObject(sb.toString());
        String amount = json.getString("amount");

        String accessToken = PayPalUtil.getAccessToken(clientId, secret);

        JSONObject orderPayload = new JSONObject()
            .put("intent", "CAPTURE")
            .put("purchase_units", new org.json.JSONArray()
                .put(new JSONObject()
                    .put("amount", new JSONObject()
                        .put("currency_code", "USD")
                        .put("value", amount)
                    )
                )
            );

        HttpURLConnection conn = PayPalUtil.makeRequest(
            "https://api-m.sandbox.paypal.com/v2/checkout/orders", "POST", accessToken
        );
        conn.getOutputStream().write(orderPayload.toString().getBytes());

        String response = PayPalUtil.readResponse(conn);
        resp.setContentType("application/json");
        resp.getWriter().write(response);
    }
}
