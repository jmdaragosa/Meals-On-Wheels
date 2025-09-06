
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MerryMeal Admin Dashboard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Custom CSS only -->
  <link rel="stylesheet" href="css/admindashboard.css">
</head>
<body>

  <!-- Mobile Toggle Button -->
  <button class="toggle-btn d-md-none" onclick="toggleSidebar()">☰</button>

  <div class="admin-dashboard"> <!-- Scoped wrapper -->

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
      <h4 class="text-center mb-4">MerryMeal Admin</h4>
      <a href="#">Dashboard</a>
      <a href="DeliveryProgress">Deliveries</a>
      <a href="#">Donations</a>
      <a href="#" onclick="handleLogout()">Logout</a>
    </div>

    <!-- Overlay -->
    <div class="overlay" id="overlay" onclick="toggleSidebar()"></div>

    <!-- Main Content -->
    <div class="main">
      <h3 class="mb-3 fw-bold">Dashboard Reports</h3>
      <div class="row mb-3">
        <div class="col-md-3 col-12 mb-2">
          <input type="date" class="form-control" placeholder="Start Date">
        </div>
        <div class="col-md-3 col-12 mb-2">
          <input type="date" class="form-control" placeholder="End Date">
        </div>
        <div class="col-md-3 col-12 mb-2">
          <button class="btn btn-primary w-100">Filter</button>
        </div>
      </div>

      <div class="row g-4">
        <div class="col-lg-4 col-md-6 col-12">
          <div class="card card-delivery p-3">
            <h5>Total Deliveries</h5>
            <p class="fs-4" id="deliveryCount">--</p>
          </div>
        </div>
        <div class="col-lg-4 col-md-6 col-12">
          <div class="card card-donation p-3">
            <h5>Total Donations</h5>
            <p class="fs-4" id="donationCount">--</p>
          </div>
        </div>
        <div class="col-lg-4 col-md-6 col-12">
          <div class="card card-registration p-3">
            <h5>New Registrations</h5>
            <p class="fs-4" id="registrationCount">--</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- JavaScript inline -->
  <!-- JavaScript inline -->
  <script>
    function toggleSidebar() {
      document.getElementById("sidebar").classList.toggle("active");
      document.getElementById("overlay").classList.toggle("active");
    }

    function handleLogout() {
      window.location.href = "Homepage.jsp"; // redirect to login.jsp
    }

    // ✅ Load total donations on page loaded
    window.onload = function () {
      fetch('<%=request.getContextPath()%>/get-total-donation')
        .then(response => response.json())
        .then(data => {
          document.getElementById("donationCount").textContent = "$" + (data.total || 0).toFixed(2);
        })
        .catch(error => {
          console.error("Error loading donation total:", error);
        });
    };
  </script>

</body>
</html>
