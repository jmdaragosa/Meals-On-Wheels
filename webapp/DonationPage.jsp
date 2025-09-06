<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>MerryMeal – Donate</title>

  <!-- CSS -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Header.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Footer.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/DonationPage.css">

  <!-- PayPal SDK + SweetAlert2 -->
  <script src="https://www.paypal.com/sdk/js?client-id=Abo2xKMyjhGEjkxb-a1evrmiDjsyItqJeVStljHTLAte37mErt_ixDeIQ-jci01PP5JF4o4mdKv9y8d0&currency=USD"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

  <!-- ===== DONATION FORM ============================================== -->
  <section class="Memform-section d-flex justify-content-center">
    <div class="Memform-container">
      <div class="text-center mb-4"><h1>Donation Form</h1></div>

      <form class="row g-3" id="donationForm">
        <!-- ─── Donor Information ─────────────────────────────────────── -->
        <h2>Donor Information</h2>
        <div class="col-md-6"><label>*Name</label><input  type="text" class="form-control" name="name"    required></div>
        <div class="col-md-6"><label>*Email</label><input type="email" class="form-control" name="email"   required></div>
        <div class="col-md-6"><label>*Phone Number</label><input type="tel"  class="form-control" name="number" required></div>
        <div class="col-md-6"><label>*Address</label><input type="text" class="form-control" name="address" id="address" required></div>

        <!-- ─── Donor Details ─────────────────────────────────────────── -->
        <h2>Donor Details</h2>
        <div class="col-md-6">
          <label>*Donation Amount ($)</label>
          <input type="number" class="form-control" id="donateamount" name="donateamount" required>
        </div>
        <div class="col-md-6">
          <fieldset class="mb-3">
            <legend>*Frequency</legend>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ONE-TIME" checked><label class="form-check-label">One&nbsp;Time</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="MONTHLY"><label class="form-check-label">Monthly</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="QUARTERLY"><label class="form-check-label">Quarterly</label></div>
            <div class="form-check form-check-inline"><input class="form-check-input" type="radio" name="frequency" value="ANNUALLY"><label class="form-check-label">Annually</label></div>
          </fieldset>
        </div>
        <div class="col-md-12"><label>Purpose / Campaign</label><textarea class="form-control" name="purpose" rows="3"></textarea></div>

        <!-- ─── Card Place-holders (still visible) ────────────────────── -->
        <h2>Payment Information</h2>
        <div class="col-md-6"><label>*Card Number</label><input type="number" class="form-control" name="cardnum" required></div>
        <div class="col-md-6"><label>*Expiry Date</label><input type="date"   class="form-control" name="expdate" required></div>
        <div class="col-md-6"><label>*CVV</label><input type="num"    class="form-control" name="cvv"    required></div>

        <!-- PayPal button -->
        <div class="col-md-12" id="paypal-container" style="display:none">
          <p><strong>Or donate with PayPal:</strong></p>
          <div id="paypal-button-container"></div>
        </div>

        <!-- ─── Billing Address ───────────────────────────────────────── -->
        <div class="col-md-6">
          <label>*Billing Address</label>
          <input type="text" class="form-control" name="billadd" id="billadd" required>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="checkbox" id="sameasdonadd">
            <label class="form-check-label">Same as Donor Address</label>
          </div>
        </div>

        <!-- ─── Other Options ─────────────────────────────────────────── -->
        <h2>Other Options</h2>
        <div class="col-md-12">
          <div class="form-check"><input class="form-check-input" type="checkbox" name="subnews"><label class="form-check-label">Subscribe To Newsletter</label></div>
          <div class="form-check"><input class="form-check-input" type="checkbox" name="anon"><label class="form-check-label">Anonymous Donation</label></div>
        </div>
        <div class="col-md-6"><label>Notes or Message</label><textarea class="form-control" name="notes" rows="3"></textarea></div>
        <div class="col-md-6"><label>Dedicate Donation</label><textarea class="form-control" name="dedication" rows="3"></textarea></div>

        <div class="col-md-12">
          <button type="submit" class="btn btn-primary submit-btn">Donate</button>
          <p id="paypal-success-msg" class="text-success mt-2" style="display:none">✅ Donation completed via PayPal. No need to click Donate.</p>
        </div>
      </form>
    </div>
  </section>

  <!-- ===== FOOTER placeholder ========================================== -->
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

  <!-- ===== JavaScript ================================================== -->
  <script src="<%=request.getContextPath()%>/js/navigation.js"></script>

  <script>
    /* ──────────────────────────────────────────────────────────────
       Helpers & Common Elements
    ────────────────────────────────────────────────────────────── */
    const form     = document.querySelector("#donationForm");
    const nameIn   = form.querySelector('input[name="name"]');
    const emailIn  = form.querySelector('input[name="email"]');
    const phoneIn  = form.querySelector('input[name="number"]');
    const addrIn   = document.getElementById("address");
    const cardIn   = form.querySelector('input[name="cardnum"]');
    const amountIn = document.getElementById("donateamount");
    const billAddr = document.getElementById("billadd");
    const sameBox  = document.getElementById("sameasdonadd");

    /* Copy donor → billing address */
    sameBox.addEventListener("change", () => {
      billAddr.value    = sameBox.checked ? addrIn.value : "";
      billAddr.readOnly = sameBox.checked;
    });
    addrIn.addEventListener("input", () => {
      if (sameBox.checked) billAddr.value = addrIn.value;
    });

    /* Show PayPal button only when amount > 0 */
    const ppContainer = document.getElementById("paypal-container");
    amountIn.addEventListener("input", () => {
      const a = parseFloat(amountIn.value);
      ppContainer.style.display = (!isNaN(a) && a > 0) ? "block" : "none";
    });

    /* ───────── Manual (non-PayPal) submit ─────────────────────── */
    document.querySelector(".submit-btn").addEventListener("click", e => {
      e.preventDefault();

      /* Validate required donor fields */
      if (!nameIn.value.trim() || !emailIn.value.trim() || !phoneIn.value.trim()) {
        Swal.fire({ icon:"warning", title:"Required Fields Missing", text:"Please fill out name, email, and phone number." });
        return;
      }

      const fd = new FormData(form);

      /* Last-4-only card number; remove expiry */
      const rawCard = cardIn.value.trim();
      const last4   = rawCard ? "**** **** **** " + rawCard.slice(-4) : "";
      fd.set("cardnum", last4 || "(Card No Unavailable)");
      fd.delete("expdate");

      /* Optional clean-ups */
      fd.delete("sameasdonadd");

      /* Send to Apps Script & DB */
      fetch("https://script.google.com/macros/s/AKfycbxjbzPjR2BkTPTm6uiNT7LZ8_tX6Rv9KGhML_g-JsYbtTphDeTmSBZs8yCpphVu1Sg/exec",
            { method:"POST", body:fd })
      .then(r => r.json())
      .then(d => {
        if (d.result === "success") {
          Swal.fire({ icon:"success",
                      title:"Thank You!",
                      html:'🎉 Your donation was submitted successfully.<br><br><a href="Homepage.jsp" class="btn btn-success">Return to Homepage</a>',
                      showConfirmButton:false });
          form.reset();
          billAddr.readOnly = false;
        } else {
          Swal.fire({ icon:"error", title:"Oops!", text:d.message });
        }
      })
      .catch(err => {
        console.error(err);
        Swal.fire({ icon:"error", title:"Oops!", text:"Something went wrong." });
      });
    });

    /* ───────── PayPal Buttons ─────────────────────────────────── */
	/* ======== PayPal Buttons =========================================== */
	paypal.Buttons({
	  createOrder: () => {

	    /* ✅  NEW validation — blocks PayPal if name / e-mail / phone empty */
	    if (!nameIn.value.trim() || !emailIn.value.trim() || !phoneIn.value.trim()) {
	      Swal.fire({
	        icon : "warning",
	        title: "Required Fields Missing",
	        text : "Please fill out Name, E-mail and Phone Number before paying with PayPal."
	      });
	      throw new Error("Required donor fields missing");
	    }

	    /* existing amount check  */
	    const amt = amountIn.value;
	    if (!amt || parseFloat(amt) <= 0) {
	      Swal.fire("Please enter a valid donation amount.");
	      throw new Error("Invalid amount");
	    }

	    /* unchanged order-creation request */
	    return fetch('<%=request.getContextPath()%>/create-order', {
	             method : "POST",
	             headers: { "Content-Type":"application/json" },
	             body   : JSON.stringify({ amount: amt })
	           })
	           .then(r => r.json())
	           .then(d => d.id);
	  },

      onApprove: (data, actions) => {
        /* 1️⃣  Retrieve order details, then capture */
        return actions.order.get()
          .then(orderData =>
            fetch('<%=request.getContextPath()%>/capture-order?orderID=' + data.orderID,
                  { method:"POST" })
            .then(() => orderData)
          )
          .then(details => {
            /* 2️⃣  Extract PayPal name / address */
            let payName = "";
            if (details.payer?.name?.given_name) {
              payName = `${details.payer.name.given_name} ${details.payer.name.surname}`.trim();
            } else if (details.purchase_units?.[0]?.shipping?.name?.full_name) {
              payName = details.purchase_units[0].shipping.name.full_name.trim();
            }
            const addrObj = details.purchase_units?.[0]?.shipping?.address || {};
            const payAddr = [addrObj.address_line_1,
                             addrObj.admin_area_2,
                             addrObj.postal_code,
                             addrObj.country_code]
                            .filter(Boolean).join(", ");

            if (!nameIn.value.trim() && payName) nameIn.value = payName;
            if (!addrIn.value.trim() && payAddr) addrIn.value = payAddr;
            billAddr.value = addrIn.value;          // billing = shipping
            billAddr.readOnly = true;

            /* 3️⃣  Build FormData */
            const fd = new FormData(form);
            fd.set("name",    nameIn.value.trim());
            fd.set("address", addrIn.value.trim());
            fd.set("cardnum", "(Paid via PayPal)");
            fd.delete("expdate");
            fd.delete("sameasdonadd");
            fd.delete("anon");
            fd.delete("subnews");

            /* 4️⃣  Send to Apps Script + DB */
            return Promise.all([
              fetch("https://script.google.com/macros/s/AKfycbxjbzPjR2BkTPTm6uiNT7LZ8_tX6Rv9KGhML_g-JsYbtTphDeTmSBZs8yCpphVu1Sg/exec",
                    { method:"POST", body:fd }),
              fetch("<%=request.getContextPath()%>/record-donation",
                    { method:"POST", body:fd })
            ]).then(() => fd);   // pass FormData down
          })
          .then(fd => {
            /* 5️⃣  Show success */
            Swal.fire({
              icon:"success",
              title:`Thank You, ${fd.get("name")}!`,
              html:'🎉 Your PayPal donation was successful.<br><br><a href="Homepage.jsp" class="btn btn-success">Return to Homepage</a>',
              showConfirmButton:false
            });
            form.reset();
            billAddr.readOnly = false;
            document.querySelector(".submit-btn").disabled = true;
            document.getElementById("paypal-success-msg").style.display = "block";
          })
          .catch(err => {
            console.error(err);
            Swal.fire({ icon:"error", title:"PayPal Payment Failed", text:"Please try again." });
          });
      },

      onError: err => {
        console.error(err);
        Swal.fire({ icon:"error", title:"PayPal Payment Failed", text:"Please try again." });
      }
    }).render("#paypal-button-container");
  </script>
</body>
</html>