<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%
    // Define dietary tags and allergens
    List<String> dietTags = Arrays.asList("Vegetarian","Vegan","Pescatarian","Halal","Kosher","Gluten-free","Lactose-free",
                                          "Low-Sodium","Low-Sugar / Diabetic Friendly","Nut-free","Shellfish-free",
                                          "Egg-free","No Red Meat","Soft Food Only","Pureed Meals");

    List<String> allergenList = Arrays.asList("Gluten","Lactose","Nuts","Shellfish","Eggs","Soy","Peanuts");

    request.setAttribute("dietTags", dietTags);
    request.setAttribute("allergenList", allergenList);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Meals</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Footer.css">
</head>
<body>
<header id="site-header" class="d-flex align-items-center justify-content-between p-3">
    <div class="hlogo">
        <a href="Home">
            <img src="${pageContext.request.contextPath}/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
            <img src="${pageContext.request.contextPath}/assets/MMLogo3alt.png" alt="MerryMeal Logo" class="hhogo-image hlogo-small">
        </a>
    </div>
    <nav class="nav-links">
        <a href="Home" class="header-buttons">Home</a>
        <a href="#welcomeText" class="header-buttons">About us</a>
        <a href="Donate" class="header-buttons">Donate</a>
        <c:if test="${isLoggedIn}">
            <a href="Account" class="register-btn">Account</a>
        </c:if>
        <c:if test="${not isLoggedIn}">
            <a href="Register" class="register-btn">Login/Register</a>
        </c:if>
    </nav>
    <div class="hamburger d-lg-none" onclick="toggleMenu()">☰</div>
</header>

<a href="PartnerDashboard" class="btn btn-outline-primary">← Back to Dashboard</a>

<div class="container mt-4">
    <h1>Manage Meals</h1>
    <form action="ManageMeals" method="post" class="mb-4">
        <div class="row g-3">
            <div class="col-12">
                <input type="text" class="form-control" name="meal_name" placeholder="Meal Name" required>
            </div>
            <div class="col-12">
                <textarea class="form-control" name="meal_description" placeholder="Description"></textarea>
            </div>
            <div class="col-12">
                <label>Dietary Tags</label><br>
                <c:forEach var="tag" items="${dietTags}">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="diettags" value="${tag}" id="${tag}">
                        <label class="form-check-label" for="${tag}">${tag}</label>
                    </div>
                </c:forEach>
            </div>
            <div class="col-12 mt-3">
                <label>Allergens Present</label><br>
                <c:forEach var="allergen" items="${allergenList}">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" name="allergens" value="${allergen}" id="${allergen}">
                        <label class="form-check-label" for="${allergen}">${allergen}</label>
                    </div>
                </c:forEach>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-success">Add Meal</button>
            </div>
        </div>
    </form>

    <table class="table table-bordered">
        <thead class="table-light">
            <tr>
                <th>Meal ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Diet Tags</th>
                <th>Allergens</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="meal" items="${meals}">
                <tr>
                    <td>${meal.meal_id}</td>
                    <td>${meal.meal_name}</td>
                    <td>${meal.meal_description}</td>
                    <td>
                        <c:forEach var="tag" items="${meal.meal_diettag}">
                            <span class="badge bg-success me-1">${tag}</span>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach var="allergen" items="${meal.meal_allergens}">
                            <span class="badge bg-danger me-1">${allergen}</span>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<footer class="d-flex align-items-center justify-content-between p-5">
    <div class="flogo">
        <a href="Home">
            <img src="${pageContext.request.contextPath}/assets/MMLogo4w.png" alt="MerryMeal Logo" class="flogo-image flogo-large">
            <img src="${pageContext.request.contextPath}/assets/MMLogo2w.png" alt="MerryMeal Logo" class="flogo-image flogo-small">
        </a>
    </div>
    <nav class="footer-nav">
        <a href="Privacypolicy" class="footer-btn">Privacy Policy</a>
        <a href="TOS" class="footer-btn">Terms of Service</a>
        <a href="Careers" class="footer-btn">Careers</a>
        <a href="FAQ" class="footer-btn">FAQ</a>
    </nav>
    <div class="footer-nav">
        <p>Phone #: +65 6123 4567</p>
        <p>Email: contact@merrymeal.org</p>
        <p>Address: MerryMeal Headquarters<br>
            123 Community Care Lane<br>
            #05-01 Kindness Hub<br>
            Singapore 567890</p>
    </div>
    <div class="footer-social">
        <p>Follow us</p>
        <div class="social-icons">
            <a href="#"><img src="${pageContext.request.contextPath}/assets/instagram-icon.png" class="icon"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/assets/facebook-icon.png" class="icon"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/assets/tiktok-icon.png" class="icon"></a>
            <a href="#"><img src="${pageContext.request.contextPath}/assets/x-icon.png" class="icon"></a>
        </div>
        <p>© 2025 MerryMeal.<br>All Rights Reserved.</p>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/js/navigation.js"></script>
</body>
</html>
