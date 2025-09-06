<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Delivery Progress</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/DeliveryProgress.css">  
</head>
<body>
  <!-- Header remains unchanged -->
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
  
  <a href="VolunteerDashboard" class="btn btn-outline-primary">← Back to Dashboard</a>

  <div class="container">
    <main class="main-content">
      <header class="header">
        <h1>Delivery Progress</h1>
      </header>

      <section class="delivery-list">
        <c:choose>
          <c:when test="${empty deliveryList}">
            <p style="text-align: center; font-size: 18px; margin-top: 20px;">No deliveries found.</p>
          </c:when>
          <c:otherwise>
            <c:forEach var="delivery" items="${deliveryList}">
              <div class="delivery-card ${delivery.status.toLowerCase()}"
                   data-delivery-id="${delivery.deliveryId}"
                   data-name="${delivery.clientName}"
                   data-email="${delivery.email}"
                   data-phone="${delivery.phoneNumber}"
                   data-address="${delivery.address}"
                   data-meal="${delivery.meal}"
                   data-delivery="${delivery.deliveryDate}">

                <div class="details">
                  <h3>Client: ${delivery.clientName}</h3>
                  <p>Address: ${delivery.address}</p>
                  <p>Contact: ${delivery.phoneNumber}</p
                  <p>Meal: ${delivery.meal}</p>
                  <p>Delivery Date: ${delivery.deliveryDate}</p>
                </div>

                <div class="status-wrapper">
                  <select class="status-select ${delivery.status.toLowerCase()}">
                    <option value="PENDING" ${delivery.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="DISPATCHED" ${delivery.status == 'DISPATCHED' ? 'selected' : ''}>Out for Delivery</option>
                    <option value="DELIVERED" ${delivery.status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                    <option value="CANCELLED" ${delivery.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                  </select>
                </div>
              </div>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </section>     
    </main>
  </div>

  <script src="<%= request.getContextPath() %>/js/navigation.js"></script>

 <script>
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".status-select").forEach((dropdown) => {
    const card = dropdown.closest(".delivery-card");
    
    // Set initial style
    updateDropdownStyle(dropdown);
    
    // Handle status changes
    dropdown.addEventListener("change", async () => {
      updateDropdownStyle(dropdown);
      
      const deliveryId = card.dataset.deliveryId;
      const newStatus = dropdown.value;
      
      try {
        const response = await fetch('UpdateDeliveryStatus', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: `deliveryId=${deliveryId}&status=${newStatus}`
        });
        
        if (!response.ok) {
          throw new Error('Failed to update status');
        }
        
        const result = await response.text();
        console.log('Status updated:', result);
      } catch (error) {
        console.error('Error updating status:', error);
        // Optionally revert the dropdown value
      }
    });
  });

  function updateDropdownStyle(dropdown) {
    const status = dropdown.value.toLowerCase();
    const card = dropdown.closest(".delivery-card");

    // Remove all old status classes
    ["pending", "dispatched", "delivered", "cancelled"].forEach(s => {
      card.classList.remove(s);
      dropdown.classList.remove(s);
    });

    // Add new status classes
    card.classList.add(status);
    dropdown.classList.add(status);

    // Apply background and text colors
    const colors = {
      pending: ["#ef4444", "white"],
      dispatched: ["#facc15", "black"],
      delivered: ["#10b981", "white"],
      cancelled: ["#6b7280", "white"]
    };

    const [bg, color] = colors[status] || ["", ""];
    dropdown.style.backgroundColor = bg;
    dropdown.style.color = color;
  }
});
</script>




</body>
</html>