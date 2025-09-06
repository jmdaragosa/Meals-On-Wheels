<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Volunteer Dashboard - MerryMeal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <style>
        .dashboard-section { padding: 30px 20px; }
        .section-title { margin-bottom: 15px; }
        .card { margin-bottom: 20px; }
        .info-box { background: #f8f9fa; padding: 20px; border-radius: 10px; }
    </style>
</head>
<body>
<header id="site-header" class="d-flex align-items-center justify-content-between p-3">
    <div class="hlogo">
        <a href="Home">
            <img src="<%= request.getContextPath() %>/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
        </a>
    </div>
    <nav class="nav-links">
        <a href="Home" class="header-buttons">Home</a>
        <a href="Logout" class="header-buttons">Logout</a>
    </nav>
</header>

<section class="dashboard-section container">
    <h2 class="text-center mb-4">Welcome, ${sessionScope.name}!</h2>

    <!-- Assigned Deliveries -->
    <div class="row">
        <div class="col-md-6">
            <h4 class="section-title">Your Upcoming Deliveries</h4>
            <c:choose>
                <c:when test="${not empty upcomingDeliveries}">
                    <div class="card">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="del" items="${upcomingDeliveries}">
                                <li class="list-group-item">
                                    <strong>${del[0]}</strong><br>
                                    Date: ${del[1]} | Time: ${del[2]}<br>
                                    Member: ${del[3]}<br>
                                    Address: ${del[4]}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="info-box">No upcoming deliveries assigned.</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Delivery History -->
        <div class="col-md-6">
            <h4 class="section-title">Delivery History</h4>
            <c:choose>
                <c:when test="${not empty deliveryHistory}">
                    <div class="card">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="del" items="${deliveryHistory}">
                                <li class="list-group-item">
                                    <strong>${del[0]}</strong><br>
                                    Date: ${del[1]} | Time: ${del[2]}<br>
                                    Status: ${del[3]}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="info-box">No delivery history available.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mt-4 text-center">
   		<a href="DeliveryProgress" class="btn btn-outline-success mx-2">View Delivery Progress</a>
        <a href="UpdateVolunteerProfile" class="btn btn-outline-primary mx-2">Update Profile</a>
        <a href="VolunteerDeliveries" class="btn btn-outline-secondary mx-2">Manage Deliveries</a>
    </div>
</section>

<footer class="d-flex align-items-center justify-content-between p-5">
    <div class="flogo">
        <a href="Home">
            <img src="<%= request.getContextPath() %>/assets/MMLogo4w.png" alt="MerryMeal Logo" class="flogo-image flogo-large">
        </a>
    </div>
    <nav class="footer-nav">
        <a href="Privacypolicy" class="footer-btn">Privacy Policy</a>
        <a href="TOS" class="footer-btn">Terms of Service</a>
    </nav>
    <div class="footer-social">
        <p>© 2025 MerryMeal. All Rights Reserved.</p>
    </div>
</footer>
<script src="${pageContext.request.contextPath}/js/navigation.js"></script>
</body>
</html>
