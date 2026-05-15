<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment Successful — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
      text-align: center;
    }
    .success-icon { font-size: 5rem; }
    .btn-watch {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: 0;
      color: #fff;
      padding: 12px 40px;
      border-radius: 30px;
      font-weight: 600;
    }
    .receipt {
      background: #1a1740;
      border-radius: 12px;
      padding: 20px;
      display: inline-block;
      min-width: 320px;
      margin: 20px auto;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="success-icon">✅</div>
    <h1 class="mt-2" style="color:#00ff88">Payment Successful!</h1>

    <div class="receipt">
      <p class="mb-1"><span class="text-muted">Payment ID:</span> <strong>#${payment.paymentId}</strong></p>
      <p class="mb-1"><span class="text-muted">Movie:</span> <strong>${movie.title}</strong></p>
      <p class="mb-1"><span class="text-muted">Amount Paid:</span> <strong>Rs ${payment.amount}</strong></p>
      <p class="mb-0"><span class="text-muted">Status:</span>
        <span class="badge bg-success">SUCCESS</span>
      </p>
    </div>

    <p class="text-muted mb-4">Your rental is active. Use watch password <strong>movie123</strong> to unlock.</p>

    <a class="btn btn-watch me-2" href="/watch/${movie.id}">▶ Watch Online</a>
    <a class="btn btn-outline-light" href="/my-rentals">My Rentals</a>
    <br>
    <a href="/home" class="text-muted small d-inline-block mt-3">← Back to Home</a>
  </div>
</body>
</html>
