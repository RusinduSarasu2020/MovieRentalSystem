<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment — ${movie.title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .card {
      background: #1a1740;
      border: 0;
      padding: 30px;
      width: 480px;
      margin: auto;
      border-radius: 18px;
    }
    .btn-pay {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: 0;
      color: #fff;
      width: 100%;
    }
    .form-control {
      background: #0f0c29;
      color: #fff;
      border-color: #444;
    }
    .form-control:focus { background: #0f0c29; color: #fff; border-color: #ff6a00; }
    .form-control::placeholder { color: #888; }
    .form-control:disabled { background: #0a0a1f; color: #aaa; }
    .card-icon { font-size: 2.5rem; }
  </style>
</head>
<body>
  <div class="card text-light">
    <div class="text-center mb-3">
      <span class="card-icon">💳</span>
      <h3 class="mt-1">Card Payment</h3>
    </div>

    <div class="alert" style="background:#0f3460;border:0;border-radius:10px">
      <strong>Movie:</strong> ${movie.title}<br>
      <strong>Amount:</strong> Rs ${movie.price}
    </div>

    <form method="post" action="/payment/${movie.id}">
      <div class="mb-2">
        <label class="form-label small text-muted">Card Number</label>
        <input class="form-control" name="cardNumber" placeholder="1234 5678 9012 3456"
               maxlength="16" pattern="\d{16}" required>
      </div>
      <div class="mb-2">
        <label class="form-label small text-muted">Card Holder Name</label>
        <input class="form-control" name="cardHolderName" placeholder="Full name on card" required>
      </div>
      <div class="row mb-2">
        <div class="col">
          <label class="form-label small text-muted">Expiry Date</label>
          <input class="form-control" name="expiryDate" placeholder="MM/YY"
                 pattern="(0[1-9]|1[0-2])/\d{2}" required>
        </div>
        <div class="col">
          <label class="form-label small text-muted">CVV</label>
          <input class="form-control" name="cvv" placeholder="123"
                 maxlength="3" pattern="\d{3}" required>
        </div>
      </div>
      <div class="mb-3">
        <label class="form-label small text-muted">Total Amount</label>
        <input class="form-control" value="Rs ${movie.price}" disabled>
      </div>
      <button class="btn btn-pay py-2 fw-bold">Pay Now — Rs ${movie.price}</button>
    </form>

    <p class="text-center mt-3 small text-muted">
      🔒 Test card: 4111111111111111 · 12/28 · 123
    </p>
    <p class="text-center">
      <a href="/movie/${movie.id}" class="text-muted small">← Cancel</a>
    </p>
  </div>
</body>
</html>
