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
            			${sessionScope.error}
            			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        			</div>	
        			<c:remove var="error" scope="session"/>
    			</c:if>
				<div class = "d-flex align-items-center justify-content-left">
				<h1> Member / Caregiver Registration Form </h1>
				<p class="info"> * is required </p>
				</div>	
				<form class="row g-3" action="${pageContext.request.contextPath}/MemberRegister" method="post">
					<div class = "col-md-6">
						<label for = "name" class = "form-label">*Name</label>
						<input type = "text" class = "form-control" id = "name" name = "name" required>
					</div>
					<div class = "col-md-6">
						<fieldset class="mb-3">
    					<legend class="col-form-label pt-0">*Role</legend>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="userrole" id="member" value="MEMBER" checked>
        						<label class="form-check-label" for="member">
          							Member
        						</label>
      						</div>
      						<div class="form-check form-check-inline">
        						<input class="form-check-input" type="radio" name="userrole" id="caregiver" value="CAREGIVER">
        						<label class="form-check-label" for="caregiver">
          							Caregiver
        						</label>
      						</div>
  						</fieldset>	
  					</div>
  					<div class="col-md-6">
   						<label for="email" class="form-label">*Email</label>
    					<input type="email" class="form-control" id="email" name="email" required>
  					</div>
  					
  					<div class="col-md-6">
  						<legend class="col-form-label pt-0">Dietary Requirements (Select All the Apply)</legend>
   						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Vegetarian" value="Vegetarian">
  							<label class="form-check-label" for="Vegetarian">Vegetarian</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Vegan" value="Vegan">
  							<label class="form-check-label" for="Vegan">Vegan</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Pescatarian" value="Pescatarian">
  							<label class="form-check-label" for="Pescatarian">Pescatarian</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Halal" value="Halal">
  							<label class="form-check-label" for="Halal">Halal</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Kosher" value="Kosher">
  							<label class="form-check-label" for="Kosher">Kosher</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Gluten-free" value="Gluten-free">
  							<label class="form-check-label" for="Gluten-free">Gluten-free</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Lactose-free" value="Lactose-free">
  							<label class="form-check-label" for="Lactose-free">Lactose-free</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Low-Sodium" value="Low-Sodium">
  							<label class="form-check-label" for="Low-Sodium">Low-Sodium</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Low-Sugar" value="Low-Sugar / Diabetic Friendly">
  							<label class="form-check-label" for="Low-Sugar">Low-Sugar / Diabetic Friendly</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Nut-free" value="Nut-free">
  							<label class="form-check-label" for="Nut-free">Nut-free</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Shellfish-free" value="Shellfish-free">
  							<label class="form-check-label" for="Shellfish-free">Shellfish-free</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Egg-free" value="Egg-free">
  							<label class="form-check-label" for="Egg-free">Egg-free</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="No-Red-Meat" value="No Red Meat">
  							<label class="form-check-label" for="No-Red-Meat">No Red Meat</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Soft-Food-Only" value="Soft Food Only">
  							<label class="form-check-label" for="Soft-Food-Only">Soft Food Only</label>
						</div>
						<div class="form-check form-check-inline">
  							<input class="form-check-input" type="checkbox" name= "dietaryreq" id="Pureed-Meals" value="Pureed Meals">
  							<label class="form-check-label" for="Pureed-Meals">Pureed Meals</label>
						</div>		
  					</div>
  					<div class="col-md-6">
   						<label for="number" class="form-label">*Phone Number</label>
    					<input type="tel" class="form-control" name = "phoneNum" id="number" required>
  					</div>
  					<div class="col-md-6">
   						<label for="disability-info" class="form-label">Disability / Special Needs Information</label>
    					<textarea class="form-control" id = "disability-info" name="disDesc" rows="3"></textarea>
  					</div>
  					<div class="col-md-6">
   						<label for="address" class="form-label">*Address</label>
    					<input type="text" class="form-control" name="address" id="address" required>
  					</div>
  					<div class="col-md-12">
					  <label class="form-label">Delivery Schedule</label>
					  <p class="form-control-plaintext">Hot noon meals are delivered <strong>Monday to Friday</strong>.</p>
					  <input type="hidden" name="deltime" value="AFTERNOON">
					</div>
  					<div class="col-md-6">
   						<label for="password" class="form-label">*Password</label>
    					<input type="password" class="form-control" name="password" id="password" required>
    					<small class="form-text text-muted">Password must be at least 8 characters long and contain a number.</small>
  					</div>
  					<div class="col-md-6">
   						<label for="confpassword" class="form-label">*Confirm Password</label>
    					<input type="password" class="form-control" name="confpassword" id="confpassword" required>
    					<small class="form-text text-muted">Re-type your password to confirm.</small>
  					</div>
  					<div class="col-md-6">
   						<label for="emername" class="form-label">*Emergency Contact Name</label>
    					<input type="text" class="form-control" name="emername" id="emername" required>
  					</div>
  					<div class="col-md-6">
   						<label for="emernum" class="form-label">*Emergency Contact Number</label>
    					<input type="tel" class="form-control"  name="emernum" id="emernum" required>
  					</div>
  					<p class = "warn">By Registering, you agree to MerryMeal's Terms Of Use and Privacy Policy</p>
  					<button type="submit" class="btn btn-primary submit-btn">Submit</button>
				</form>
			</div>
		</section>
	
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
	<script>
  document.querySelector("form").addEventListener("submit", function(e) {
    const password = document.getElementById("password").value;
    const confirm = document.getElementById("confpassword").value;
    if (password !== confirm) {
      e.preventDefault();
      alert("Passwords do not match. Please make sure both fields are the same.");
    }
  });
</script>
</body>
</html>