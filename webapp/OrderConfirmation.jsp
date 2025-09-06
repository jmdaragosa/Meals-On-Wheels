<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Order Confirmation - MerryMeal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <style>
        body { padding: 40px; background: #f8f9fa; }
        .confirmation-box {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 0 10px #ccc;
        }
    </style>
</head>
<body>
    <div class="confirmation-box">
        <h2>Thank you for your order!</h2>
        <p>Your meal order has been successfully placed.</p>
        <p>You can check your upcoming deliveries in your dashboard.</p>
        <a href="MemberDashboard" class="btn btn-primary mt-3">Back to Dashboard</a>
    </div>
</body>
</html>
