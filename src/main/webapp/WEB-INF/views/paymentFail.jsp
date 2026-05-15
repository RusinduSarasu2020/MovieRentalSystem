<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment Failed — CineRent</title>
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
    .fail-icon { font-size: 5rem; }
    .btn-retry {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: 0;
      color: #fff;
      padding: 12px 40px;
      border-radius: 30px;
      font-weight: 600;
    }
    .error-box {
      background: rgba(255, 50, 50, 0.1);
      border: 1px solid #ff3333;
      border-radius: 10px;
      padding: 15px 25px;
      display: inline-block;
      margin: 20px auto;
      max-width: 500px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="fail-icon">❌</div>
    <h1 class="mt-2" style="color:#ff4444">Payment Failed</h1>

    <div class="error-box">
      <p class="mb-0 text-danger">${error}</p>
    </div>

    <p class="text-muted mb-4">
      Please check your card details:<br>
      Card number must be 16 digits · CVV must be 3 digits · Expiry format MM/YY · Card must not be expired.
    </p>

    <a class="btn btn-retry me-2" href="/payment/${movie.id}">🔄 Retry Payment</a>
    <a class="btn btn-outline-light" href="/movie/${movie.id}">← Back to Movie</a>
    <br>
    <a href="/home" class="text-muted small d-inline-block mt-3">← Home</a>
  </div>
</body>
</html>
