<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>MerryMeal</title>
	<link rel="icon" href="<%= request.getContextPath() %>/assets/favicon.ico" type="image/x-icon">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type = "text/css" href = "">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Header.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Footer.css">
    <link rel = "stylesheet" type = "text/css" href="<%= request.getContextPath() %>/css/Homepage.css?v=1">
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
		<section class="background-section text-center d-flex align-items-center justify-content-center">
    		<div class="overlay">
        		<div>
            		<h1 class="wecometext">
                		"Delivering Nutrition with Compassion,<br>One Meal At A Time"
            		</h1>
        		</div>   
        		<div class="d-flex justify-content-center gap-3 mt-4"> <!-- Add margin top to space from header -->
            		<a href="VolunteerRegister" class="btn btn-primary CTA-btn">Become a Volunteer</a>
            		<a href="Donate" class="btn btn-primary CTA-btn">Donate Now</a>
        		</div>
    		</div>
		</section>
		
		<section class ="Aboutus-section text-center d-flex align-items-center justify-content-between">
			<img src= "<%= request.getContextPath() %>/assets/Sideimageright.jpg" alt="Side Image" class="">
			<div class="Aboutus-text" id="welcomeText">
				<h1>ABOUT MERRYMEAL</h1>
				<p> MerryMeal is a charitable organization dedicated to preparing and delivering nutritious meals to seniors and individuals with disabilities who are unable to cook for themselves. Our mission is to ensure that every member receives a warm, healthy meal with care and compassion.</p>
				<p> Our Services runs between <b>Monday to Friday</b>, delivering <b>hot meals</b> to our members. We can still deliver <b>cold meals on the weekends and to those who are 10km away.</b></p>
			</div>
			<img src= "<%= request.getContextPath() %>/assets/Sideimageleft.jpg" alt="Side Image" class="">
		</section>
		
		<section class = "separator"></section>
		
		<section class="members-section text-center p-3" id="whoWeHelp" >
			<h2>Who We Help</h2>
			<div class="members-container d-flex flex-wrap justify-content-center">
				<div class="members">
					<img src= "<%= request.getContextPath() %>/assets/Disabled.jpg" alt="Disabled Person" class="">
					<p>Individuals with Disability</p>
				</div>
				<div class="members">
					<img src= "<%= request.getContextPath() %>/assets/Senior.jpg" alt="Disabled Person" class="">
					<p>Senior</p>
				</div>
				<div class="members">
					<img src= "<%= request.getContextPath() %>/assets/LTIP.jpg" alt="Disabled Person" class="">
					<p>Long-Term Illness Patient</p>
				</div>
			</div>
			<div class="members-btn-container">
				<a href="#whoWeHelp" class="btn btn-primary members-btn">Learn More</a>
			</div>
		</section>
		
		<section class = "separator"></section>
		
		<section class="memvol-section text-center p-3">
			<div>
				<h2>From Our Members</h2>
				<div class="ourmembers-container d-flex flex-wrap justify-content-center">
					<div class="ourmembers">
						<img src= "<%= request.getContextPath() %>/assets/Caregiver1.jpg" alt="Caregiver" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
					<div class="ourmembers">
						<img src= "<%= request.getContextPath() %>/assets/Caregiver2.png" alt="Caregiver" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
						<div class="ourmembers">
						<img src= "<%= request.getContextPath() %>/assets/Caregiver3.jpg" alt="Caregiver" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
				</div>
				<div class="ourvolunteers-container d-flex flex-wrap justify-content-center">
					<h2>From Our Volunteers</h2>
					<div class="ourvolunteers">
						<img src= "<%= request.getContextPath() %>/assets/Volunteer1.jpg" alt="Volunteer" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
					<div class="ourvolunteers">
						<img src= "<%= request.getContextPath() %>/assets/Volunteer2.jpg" alt="Volunteer" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
						<div class="ourvolunteers">
						<img src= "<%= request.getContextPath() %>/assets/Volunteer3.jpg" alt="Volunteer" class="">
						<p>Lorem ipsum dolor sit amet, 
						consectetur adipisicing elit, 
						sed do eiusmod tempor incididunt 
						ut labore et dolore magna 
						aliqua.</p>
					</div>
				</div>
			</div>
		</section>
		
		<section class="partners-section text-center p-5">
			<h2 class="partners-section-h2"> Our Partners</h2>
				<div>
					<img src="<%= request.getContextPath() %>/assets/Unilever.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/Nestle.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/DoorDash.png" class="partlogo">
				</div>
				<div>
					<img src="<%= request.getContextPath() %>/assets/MasterCard.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/CVSHealth.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/WholeFood.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/Unilever.png" class="partlogo">
					<img src="<%= request.getContextPath() %>/assets/AARP.png" class="partlogo">
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
</body>
</html>