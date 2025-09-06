<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Member Dashboard - MerryMeal</title>
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
        <a href="Donate" class="header-buttons">Donate</a>
        <a href="Logout" class="header-buttons">Logout</a>
    </nav>
</header>

<section class="dashboard-section container">
    <h2 class="text-center mb-4">Welcome, ${sessionScope.name}!</h2>
    <c:if test="${not empty sessionScope.orderSuccess}">
    <div class="alert alert-success" role="alert">${sessionScope.orderSuccess}</div>
    <c:remove var="orderSuccess" scope="session" />
</c:if>
<c:if test="${not empty sessionScope.orderError}">
    <div class="alert alert-danger" role="alert">${sessionScope.orderError}</div>
    <c:remove var="orderError" scope="session" />
</c:if>
    

    <!-- Upcoming Deliveries -->
    <div class="row">
        <div class="col-md-6">
            <h4 class="section-title">Upcoming Meal Deliveries</h4>
            <c:choose>
                <c:when test="${not empty upcomingMeals}">
                    <div class="card">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="meal" items="${upcomingMeals}">
                                <li class="list-group-item">
                                    <strong>${meal[0]}</strong><br>
                                    Date: ${meal[1]} | Time: ${meal[2]}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="info-box">No upcoming deliveries.</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Meal History -->
        <div class="col-md-6">
            <h4 class="section-title">Recent Meal History</h4>
            <c:choose>
                <c:when test="${not empty mealHistory}">
                    <div class="card">
                        <ul class="list-group list-group-flush">
                            <c:forEach var="meal" items="${mealHistory}">
                                <li class="list-group-item">
                                    <strong>${meal[0]}</strong><br>
                                    Date: ${meal[1]} | Time: ${meal[2]}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="info-box">No past meals found.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Dietary Preferences -->
    <div class="row mt-4">
        <div class="col-md-12">
            <h4 class="section-title">Your Dietary Preferences</h4>
            <c:choose>
                <c:when test="${not empty dietPrefs}">
                    <div class="info-box">
                        <pre>${dietPrefs}</pre>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="info-box">No preferences found. You can update your profile to add them.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>


<!-- Available Meals to Order -->
<div class="row mt-4">
    <div class="col-md-12">
        <h4 class="section-title">Available Meals to Order</h4>
        <c:choose>
            <c:when test="${not empty allMeals}">
                <div class="row">
                    <c:forEach var="meal" items="${allMeals}">
                        <div class="col-md-4 mb-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">${meal.mealName}</h5>
									<p class="card-text">${meal.mealDescription}</p>
									
									<p><strong>Dietary Tags:</strong></p>
									<ul>
									    <c:forEach var="tag" items="${meal.mealDietTag}">
									        <li>${tag}</li>
									    </c:forEach>
									</ul>
									
									<p><strong>Allergens:</strong></p>
									<ul>
									    <c:forEach var="allergen" items="${meal.mealAllergens}">
									        <li>${allergen}</li>
									    </c:forEach>
									</ul>


                                    <form action="PlaceOrder" method="post">
                                        <input type="hidden" name="mealId" value="${meal.mealId}" />
                                        <button type="submit" class="btn btn-success btn-sm">Order This Meal</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="info-box">No meals available for ordering at this time.</div>
            </c:otherwise>
        </c:choose>
    </div>
</div>





    <!-- Quick Actions -->
    <div class="row mt-4">
        <div class="col-md-12 text-center">
            <a href="UpdateProfile" class="btn btn-outline-primary mx-2">Update Profile</a>
            <a href="Messages" class="btn btn-outline-secondary mx-2">View Messages</a>
        </div>
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
<script>
  document.addEventListener("DOMContentLoaded", () => {
    // Utility: Convert JSON list string to <li> items
    function renderJsonList(ulElement, jsonString) {
      try {
        const items = JSON.parse(jsonString);
        if (Array.isArray(items)) {
          items.forEach(item => {
            const li = document.createElement("li");
            li.textContent = item;
            ulElement.appendChild(li);
          });
        } else {
          ulElement.innerHTML = "<li>None</li>";
        }
      } catch (e) {
        ulElement.innerHTML = "<li>Invalid data</li>";
      }
    }

    document.querySelectorAll(".diet-list").forEach(el => {
      renderJsonList(el, el.dataset.json);
    });

    document.querySelectorAll(".allergen-list").forEach(el => {
      renderJsonList(el, el.dataset.json);
    });
  });
</script>

</body>
</html>
