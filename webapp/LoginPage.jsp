<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>MerryMeal</title>
    <link rel = "stylesheet" type = "text/css" href = "">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Footer.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Loginpage.css">
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
            <a href="Aboutus" class="header-buttons">About us</a>
            <a href="Donate" class="header-buttons">Donate</a>
            <c:choose>
            	<c:when test="${not empty sessionScope.userFirstName}">
                	<a href="Account" class="register-btn">Account</a>
            	</c:when>
            	<c:otherwise>
                	<a href="Register" class="register-btn">Login/Register</a>
           		</c:otherwise>
        	</c:choose>
        </nav>
        
        <div class="hamburger d-lg-none" onclick="toggleMenu()">☰</div>
    </header>
    
	<body>
		<section class = "loginform-section d-flex justify-content-center">
			<div class = "loginform-container">
			<c:if test="${not empty sessionScope.message}">
    				<div class="alert alert-success alert-dismissible fade show" role="alert">
    					${sessionScope.message}
    					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
    				<c:remove var="message" scope="session"/>
				</c:if>

				<c:if test="${not empty sessionScope.error}">
        			<div class="alert alert-danger alert-dismissible fade show" role="alert">
            			${sessionScope.error}
            			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        			</div>	
        			<c:remove var="error" scope="session"/>
    			</c:if>
				<div class = "d-flex align-items-center justify-content-center text-center">
				<h1> Login </h1>
				</div>	
				<form class = "row g-3 justify-content-center" action="Login" method="post">
					<div>
						<label for = "email" class = "form-label">Email</label>
						<input type = "text" class = "form-control" id = "email" name = "email" required>
					</div>
					<div>
						<label for = "password" class = "form-label">Password</label>
						<input type = "password" class = "form-control" id = "password" name = "password" required>
					</div>
					<div>
						<fieldset class="mb-3">
    					<legend class="col-form-label pt-0" >Account Type</legend>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="acctype" id="member" value="MEMBER" checked>
        						<label class="form-check-label" for="member">
          							Member / Caregiver
        						</label>
      						</div>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="acctype" id="volunteer" value="VOLUNTEER">
        						<label class="form-check-label" for="volunteer">
          							Volunteer
        						</label>
      						</div>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="acctype" id="partner" value="PARTNER">
        						<label class="form-check-label" for="partner">
          							Partner
        						</label>
      						</div>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="acctype" id="admin" value="ADMIN">
        						<label class="form-check-label" for="admin">
          							Admin
        						</label>
      						</div>
  						</fieldset>	
  					</div>
  					<button type="submit" class="btn btn-primary submit-btn">Submit</button>
				</form>
			</div>
		</section>	
	</body>
	
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