<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Partner Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Footer.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<header id = "site-header" class="d-flex align-items-center justify-content-between p-3">
        <div class="hlogo">
            <a href="Home">
            <img src="<%= request.getContextPath() %>/assets/MMLogo1altc.png" alt="MerryMeal Logo" class="hlogo-image hlogo-large">
            <img src="<%= request.getContextPath() %>/assets/MMLogo3alt.png" alt="MerryMeal Logo" class="hhogo-image hlogo-small"> <!-- Small Logo -->
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
	<div class="container mt-5">
	        <h1>Reports Overview</h1>
	        <canvas id="mealChart" width="400" height="200"></canvas>
	 </div>
<script>
        const ctx = document.getElementById('mealChart').getContext('2d');
        const mealChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: <%= request.getAttribute("mealTypes") %>,
                datasets: [{
                    label: 'Meals Offered',
                    data: <%= request.getAttribute("mealCounts") %>,
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'top' },
                    title: { display: true, text: 'Meal Type Distribution' }
                }
            }
        });
    </script>
<footer class="d-flex align-items-center justify-content-between p-5">
        <div class="flogo">
            <a href="Home">
            <img src="<%= request.getContextPath() %>/assets/MMLogo4w.png" alt="MerryMeal Logo" class="flogo-image flogo-large"> <!-- Large Logo -->
            <img src="<%= request.getContextPath() %>/assets/MMLogo2w.png" alt="MerryMeal Logo" class="flogo-image flogo-small"> <!-- Small Logo -->
            </a>
        </div>

 		<nav class="footer-nav">
            <a href="Privacypolicy" class="footer-btn">Privacy Policy</a>
            <a href="TOS" class="footer-btn">Terms of Service</a>
            <a href="Careers" class="footer-btn">Careers</a>
            <a href="FAQ" class="footer-btn">FAQ</a>
        </nav>
		
		<div class="footer-nav">
            <p> Phone #: +65 6123 4567</p>
            <p> Email: contact@merrymeal.org </p>
            <p> Address: MerryMeal Headquarters<br>
            123 Community Care Lane<br>
			#05-01 Kindness Hub<br>
			Singapore 567890</p>
        </div>
        
        <div class="footer-social">
            <p>Follow us</p>
            <div class="social-icons">
                <a href="#">
                    <img src="<%= request.getContextPath() %>/assets/instagram-icon.png" class = "icon">
                </a>
                <a href="#">
                    <img src="<%= request.getContextPath() %>/assets/facebook-icon.png" class = "icon">
                </a>
                <a href="#">
                    <img src="<%= request.getContextPath() %>/assets/tiktok-icon.png" class = "icon">
                </a>
                <a href="#">
                    <img src="<%= request.getContextPath() %>/assets/x-icon.png" class = "icon">
                </a>
            </div>
            <p> © 2025 MerryMeal. <br>
            All Rights Reserved.</p>
        </div> 
    </footer>
	<script src="<%= request.getContextPath() %>/js/navigation.js"></script>
</body>
</html>
