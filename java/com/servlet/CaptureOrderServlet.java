package com.servlet;

import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import com.utils.PayPalUtil;

@WebServlet("/capture-order")
public class CaptureOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String orderId = req.getParameter("orderID");
        String clientId = "Abo2xKMyjhGEjkxb-a1evrmiDjsyItqJeVStljHTLAte37mErt_ixDeIQ-jci01PP5JF4o4mdKv9y8d0";
        String secret = "EDnzs9ElSg05bh3GJX-Y8QFpYYypwE2pvZfbr5dYCRHYbiQWLdKiGhRE_Y6I2uzuVqGRomkQi5wOG8GU"; // replace with your PayPal Sandbox secret

        String accessToken = PayPalUtil.getAccessToken(clientId, secret);

        HttpURLConnection conn = PayPalUtil.makeRequest(
            "https://api-m.sandbox.paypal.com/v2/checkout/orders/" + orderId + "/capture",
            "POST",
            accessToken
        );

        String response = PayPalUtil.readResponse(conn);
        resp.setContentType("application/json");
        resp.getWriter().write(response);
    }
}
