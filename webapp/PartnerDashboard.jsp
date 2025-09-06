<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Partner Dashboard - MerryMeal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <style>
        .card { border-radius: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.2); }
        .dashboard { background-color: #fff4f9; padding: 3rem; }
        h1 { color: #ff4d88; }
        .welcome-msg { margin-right: 1rem; font-weight: bold; color: #ff4d88; }
    </style>
</head>
<body>
    <!-- Header -->
    <header id="site-header" class="d-flex align-items-center justify-content-between p-3">
        <div class="hlogo">
            <a href="Home">
                <img src="${pageContext.request.contextPath}/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
                <img src="${pageContext.request.contextPath}/assets/MMLogo3alt.png" alt="MerryMeal Logo" class="hlogo-image hlogo-small">
            </a>
        </div>

        <nav class="nav-links d-flex align-items-center gap-3">
            <a href="Home" class="header-buttons">Home</a>
            <a href="Aboutus" class="header-buttons">About us</a>
            <a href="Donate" class="header-buttons">Donate</a>

            <c:choose>
    <c:when test="${not empty sessionScope.name}">
    <span class="welcome-msg">Welcome, ${sessionScope.name}</span>
    <a href="Logout" class="register-btn">Logout</a>
</c:when>

    <c:otherwise>
        <a href="Register" class="register-btn">Login/Register</a>
    </c:otherwise>
</c:choose>

        </nav>

        <div class="hamburger d-lg-none" onclick="toggleMenu()">☰</div>
    </header>

    <!-- Partner Dashboard Content -->
    <div class="container mt-5">
        <h1>Welcome, ${sessionScope.name}</h1>
        <hr>
        <div class="row text-center">
            <div class="col-md-4">
                <div class="card bg-light p-3 shadow">
                    <h4>Total Meals Offered</h4>
                    <p class="fs-1">${requestScope.totalMeals}</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-light p-3 shadow">
                    <h4>Total Deliveries Made</h4>
                    <p class="fs-1">${requestScope.totalDeliveries}</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-light p-3 shadow">
                    <h4>Total Donations</h4>
                    <p class="fs-1">₱ <c:out value="${requestScope.totalDonations}" default="0.00"/></p>
                </div>
            </div>
        </div>
    </div>

    <hr class="my-5">
    <h3 class="text-center">Quick Actions</h3>
    <div class="row text-center mt-4">
        <div class="col-md-6 mb-4">
            <a href="ManageMeals" class="text-decoration-none">
                <div class="card bg-white p-4 shadow-sm h-100">
                    <h4 class="text-primary">Manage Meals</h4>
                    <p>Create and view meals offered by your organization.</p>
                </div>
            </a>
        </div>
        <div class="col-md-6 mb-4">
            <a href="PartnerReports" class="text-decoration-none">
                <div class="card bg-white p-4 shadow-sm h-100">
                    <h4 class="text-primary">View Reports</h4>
                    <p>Track meals offered.</p>
                </div>
            </a>
        </div>
    </div>

    <!-- Footer -->

    <script src="${pageContext.request.contextPath}/js/navigation.js"></script>
</body>
</html>
