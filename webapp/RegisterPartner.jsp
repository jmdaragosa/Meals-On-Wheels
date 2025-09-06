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
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/RegisterMem.css">
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
		<section class = "Memform-section d-flex justify-content-center">
			<div class = "Memform-container">
				<c:if test="${not empty sessionScope.message}">
    				<div class="alert alert-success alert-dismissible fade show" role="alert">
    					${sessionScope.message}
    					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
    				<c:remove var="message" scope="session"/>
				</c:if>

				<c:if test="${not empty sessionScope.error}">
        			<div class="alert alert-danger alert-dismissible fade show" role="alert">
            			${error}
            			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        			</div>	
        			<c:remove var="error" scope="session"/>
    			</c:if>
				<div class = "d-flex align-items-center justify-content-left">
				<h1> Partner Registration Form </h1>
				<p class="info"> * is required </p>
				</div>
				<form class = "row g-3" action="PartnerRegister" method="post">
					<div class = "col-md-6">
						<label for = "orgname" class = "form-label">*Organization Name</label>
						<input type = "text" class = "form-control" id = "orgname" name="orgname"required>
					</div>
					<div class="col-md-6">
  						<legend class="col-form-label pt-0">*Type Of Service (Select All the Apply)</legend>
   						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Meal-Preparation" value="Meal-Preparation">
  							<label class="form-check-label" for="Meal-Preparation">Meal Preparation</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Logistic-Delivery" value="Logistic-Delivery">
  							<label class="form-check-label" for="Logistic-Delivery">Logistic / Delivery</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Funding-Sponsership" value="Funding-Sponsership">
  							<label class="form-check-label" for="Funding-Sponsership">Funding / Sponsership</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Healthcare-Dietitian-Support" value="Healthcare-Dietitian-Support">
  							<label class="form-check-label" for="Healthcare-Dietitian-Support">Healthcare / Dietitian Support</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Storage-Cold-Chain" value="Storage-Cold-Chain">
  							<label class="form-check-label" for="Storage-Cold-Chain">Storage / Cold Chain</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Volunteer-Coordination" value="Volunteer-Coordination">
  							<label class="form-check-label" for="Volunteer-Coordination">Volunteer Coordination</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "servtype" id="Community-Outreach-Referrals" value="Community-Outreach-Referrals">
  							<label class="form-check-label" for="Community-Outreach-Referrals">Community Outreach / Referrals</label>
						</div>	
  					</div>
  					<div class = "col-md-6">
						<label for = "contname" class = "form-label">*Contact Person / Representative Name</label>
						<input type = "text" class = "form-control" id = "contname" name="contname" required>
					</div>
					<div class = "col-md-3">
						<p>Availability for Volunteering</p>
						<label for = "dayrange" class = "form-label">Day Range</label>
						<input type = "text" class = "form-control" id = "dayrange" name="dayrange">
  					</div>
  					<div class = "col-md-3">
  						<p>.</p>
						<label for = "timerange" class = "form-label">Time Range</label>
						<input type = "text" class = "form-control" id = "timerange" name="timerange">
  					</div>
  					<div class="col-md-6">
   						<label for="email" class="form-label">*Email</label>
    					<input type="email" class="form-control" id="email" name="email" required>
  					</div>
  					<div class="col-md-6">
   						<label for="orgdesc" class="form-label">Organization Description</label>
    					<textarea class="form-control" id = "orgdesc" name="orgdesc" rows="3"></textarea>
  					</div>
  					<div class="col-md-6">
   						<label for="address" class="form-label">*Business Address</label>
    					<input type="text" class="form-control" id="address" name="address" required>
  					</div>
  					<div class="col-md-6">
   						<label for="number" class="form-label">*Phone Number</label>
    					<input type="tel" class="form-control" name = "number" id="number" required>
  					</div>
  					<div class="col-md-6">
   						<label for="password" class="form-label">*Password</label>
    					<input type="password" class="form-control" name="password" id="password" required>
  					</div>
  					<div class="col-md-6">
   						<label for="confpassword" class="form-label">*Confirm Password</label>
    					<input type="password" class="form-control" name="confpassword" id="confpassword" required>
  					</div>
  					<p class = "warn">By Registering, you agree to MerryMeal's Terms Of Use and Privacy Policy</p>
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