<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment — ${movie.title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600;1,9..40,300&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

  <style>
    :root {
      --bg:        #080810;
      --surface:   #0e0e1a;
      --surface2:  #13131f;
      --border:    rgba(255,255,255,0.07);
      --border2:   rgba(255,255,255,0.12);
      --text:      #e8e4f0;
      --muted:     #5a556e;
      --muted2:    #7c7590;
      --accent:    #c8a96e;
      --accent2:   #e4c98a;
      --red:       #e05252;
      --green:     #5cba87;
      --font-display: 'Bebas Neue', sans-serif;
      --font-body:    'DM Sans', sans-serif;
      --font-mono:    'DM Mono', monospace;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html { scroll-behavior: smooth; }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font-body);
      font-size: 15px;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* Noise Grain */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 9999;
      opacity: 0.5;
    }

    /* Scrollbar */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: #2a2740; border-radius: 3px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--accent); }

    /* Navbar */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 500;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 48px;
      height: 60px;
      background: rgba(8,8,16,0.92);
      backdrop-filter: blur(20px);
      border-bottom: 1px solid var(--border);
    }

    .nav-brand {
      font-family: var(--font-display);
      font-size: 1.6rem;
      letter-spacing: 3px;
      color: var(--accent);
      text-decoration: none;
      line-height: 1;
    }

    .nav-brand span {
      color: var(--muted2);
      font-size: 1rem;
      letter-spacing: 6px;
      font-family: var(--font-mono);
      margin-left: 2px;
    }

    .nav-right { display: flex; align-items: center; gap: 6px; }

    .btn-nav {
      padding: 7px 18px;
      border-radius: 4px;
      font-size: 0.78rem;
      font-weight: 500;
      text-decoration: none;
      letter-spacing: 0.4px;
      transition: all 0.18s;
      font-family: var(--font-mono);
    }

    .btn-nav-ghost {
      color: var(--muted2);
      background: transparent;
      border: 1px solid transparent;
    }
    .btn-nav-ghost:hover {
      color: var(--text);
      border-color: var(--border2);
      background: rgba(255,255,255,0.04);
    }

    .btn-nav-logout {
      color: var(--accent);
      background: rgba(200,169,110,0.07);
      border: 1px solid rgba(200,169,110,0.2);
    }
    .btn-nav-logout:hover {
      background: rgba(200,169,110,0.14);
      border-color: rgba(200,169,110,0.4);
      color: var(--accent2);
    }

    /* Page Header */
    .page-header {
      max-width: 860px;
      margin: 0 auto;
      padding: 56px 48px 0;
    }

    .eyebrow {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 16px;
    }

    .eyebrow-line {
      width: 32px;
      height: 2px;
      background: var(--accent);
      border-radius: 2px;
    }

    .eyebrow-text {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--accent);
    }

    .page-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 5vw, 5rem);
      line-height: 0.93;
      letter-spacing: 2px;
      color: var(--text);
      text-transform: uppercase;
      margin-bottom: 40px;
    }

    .page-title span { color: var(--accent); }

    /* Band Divider */
    .band-divider {
      max-width: 860px;
      margin: 0 auto;
      padding: 0 48px 40px;
      display: flex;
      align-items: center;
    }

    .band-label {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: var(--muted);
      padding-right: 20px;
      white-space: nowrap;
    }

    .band-rule { flex: 1; height: 1px; background: var(--border); }

    /* Main Wrap */
    .main-wrap {
      max-width: 860px;
      margin: 0 auto;
      padding: 0 48px 80px;
    }

    /* Movie Summary Card */
    .movie-summary {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 3px;
      padding: 20px 24px;
      display: flex;
      align-items: center;
      gap: 18px;
      margin-bottom: 10px;
      position: relative;
      overflow: hidden;
    }

    .movie-summary::before {
      content: '';
      position: absolute;
      top: 0; left: 0;
      width: 2px;
      height: 100%;
      background: var(--accent);
    }

    .movie-poster {
      width: 48px;
      height: 68px;
      object-fit: cover;
      border-radius: 2px;
      background: var(--surface2);
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .movie-poster-placeholder {
      width: 48px;
      height: 68px;
      background: var(--surface2);
      border: 1px solid var(--border2);
      border-radius: 2px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--muted);
      flex-shrink: 0;
    }

    .movie-info { flex: 1; }

    .movie-name {
      font-family: var(--font-display);
      font-size: 1.45rem;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: var(--text);
      line-height: 1;
      margin-bottom: 6px;
    }

    .movie-genre {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted2);
    }

    .movie-amount {
      text-align: right;
    }

    .amount-label {
      font-family: var(--font-mono);
      font-size: 0.6rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 4px;
    }

    .amount-value {
      font-family: var(--font-display);
      font-size: 2rem;
      letter-spacing: 1px;
      color: var(--accent);
      line-height: 1;
    }

    .amount-currency {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      color: var(--muted2);
      letter-spacing: 1px;
    }

    /* Payment Form Card */
    .payment-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 3px;
      padding: 32px 32px 28px;
      position: relative;
      overflow: hidden;
    }

    .payment-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0;
      width: 2px;
      height: 100%;
      background: var(--border);
      transition: background 0.2s;
    }

    .payment-card:focus-within::before { background: var(--accent); }

    /* Section Label */
    .section-label {
      font-family: var(--font-mono);
      font-size: 0.62rem;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 22px;
      padding-bottom: 14px;
      border-bottom: 1px solid var(--border);
    }

    /* Form Fields */
    .field-group { margin-bottom: 18px; }

    .field-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
      margin-bottom: 18px;
    }

    .field-label {
      display: block;
      font-family: var(--font-mono);
      font-size: 0.6rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 7px;
    }

    .field-input {
      width: 100%;
      background: var(--bg);
      color: var(--text);
      border: 1px solid var(--border2);
      border-radius: 2px;
      padding: 11px 14px;
      font-family: var(--font-mono);
      font-size: 0.82rem;
      letter-spacing: 0.5px;
      outline: none;
      transition: border-color 0.18s, box-shadow 0.18s;
      -webkit-appearance: none;
    }

    .field-input::placeholder { color: var(--muted); }

    .field-input:focus {
      border-color: var(--accent);
      box-shadow: 0 0 0 3px rgba(200,169,110,0.08);
    }

    .field-input:disabled {
      background: #0a0a1a;
      color: var(--muted2);
      cursor: not-allowed;
      border-color: var(--border);
    }

    /* Total Row */
    .total-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-top: 1px solid var(--border);
      padding-top: 20px;
      margin-top: 4px;
      margin-bottom: 24px;
    }

    .total-label {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--muted);
    }

    .total-value {
      font-family: var(--font-display);
      font-size: 2rem;
      letter-spacing: 1px;
      color: var(--accent);
      line-height: 1;
    }

    /* Pay Button */
    .btn-pay {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      width: 100%;
      padding: 14px 28px;
      background: var(--accent);
      color: #0a0800;
      font-family: var(--font-mono);
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 2px;
      text-transform: uppercase;
      border: none;
      border-radius: 2px;
      cursor: pointer;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      box-shadow: 0 4px 20px rgba(200,169,110,0.15);
    }

    .btn-pay:hover {
      background: var(--accent2);
      transform: translateY(-2px);
      box-shadow: 0 8px 28px rgba(200,169,110,0.25);
      color: #050400;
    }

    .btn-pay:active { transform: translateY(0); }

    /* Test Card Hint */
    .hint-row {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-top: 20px;
      padding: 12px 16px;
      background: rgba(255,255,255,0.02);
      border: 1px solid var(--border);
      border-radius: 2px;
    }

    .hint-badge {
      font-family: var(--font-mono);
      font-size: 0.55rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted);
      background: var(--surface2);
      border: 1px solid var(--border2);
      border-radius: 2px;
      padding: 3px 7px;
      white-space: nowrap;
      flex-shrink: 0;
    }

    .hint-text {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      letter-spacing: 0.5px;
      color: var(--muted);
    }

    /* Cancel Link */
    .cancel-row {
      text-align: center;
      margin-top: 22px;
    }

    .cancel-link {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      font-family: var(--font-mono);
      font-size: 0.68rem;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: var(--muted);
      text-decoration: none;
      transition: color 0.18s;
    }

    .cancel-link:hover { color: var(--muted2); }

    /* Secure Badge */
    .secure-row {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin-top: 14px;
    }

    .secure-text {
      font-family: var(--font-mono);
      font-size: 0.6rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted);
    }

    .secure-dot {
      width: 3px;
      height: 3px;
      border-radius: 50%;
      background: var(--border2);
    }

    /* Responsive */
    @media (max-width: 900px) {
      .navbar { padding: 0 20px; }
      .page-header, .band-divider, .main-wrap { padding-left: 20px; padding-right: 20px; }
    }

    @media (max-width: 600px) {
      .field-row { grid-template-columns: 1fr; gap: 0; }
      .field-row .field-group { margin-bottom: 18px; }
      .movie-amount { display: none; }
      .payment-card { padding: 22px 18px 20px; }
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/home" class="nav-brand">CINERENT<span>STREAM</span></a>
  <div class="nav-right">
    <a href="/home" class="btn-nav btn-nav-ghost">
      <i class="fas fa-film" style="font-size:0.7rem;margin-right:4px;"></i> Browse
    </a>
    <a href="/logout" class="btn-nav btn-nav-logout">
      <i class="fas fa-right-from-bracket" style="font-size:0.7rem;margin-right:4px;"></i> Logout
    </a>
  </div>
</nav>

<!-- Page Header -->
<div class="page-header">
  <div class="eyebrow">
    <div class="eyebrow-line"></div>
    <span class="eyebrow-text">Checkout</span>
  </div>
  <h1 class="page-title">Card <span>Payment</span></h1>
</div>

<!-- Band Divider -->
<div class="band-divider">
  <span class="band-label">Order Summary</span>
  <div class="band-rule"></div>
</div>

<!-- Main Content -->
<div class="main-wrap">

  <!-- Movie Summary -->
  <div class="movie-summary">
    <div class="movie-poster-placeholder">
      <i class="fas fa-film" style="font-size:1rem;"></i>
    </div>
    <div class="movie-info">
      <div class="movie-name">${movie.title}</div>
      <div class="movie-genre">Rental</div>
    </div>
    <div class="movie-amount">
      <div class="amount-label">Amount Due</div>
      <div class="amount-value">${movie.price}</div>
      <div class="amount-currency">LKR</div>
    </div>
  </div>

  <!-- Payment Form Card -->
  <div class="payment-card">
    <div class="section-label">Card Details</div>

    <form method="post" action="/payment/${movie.id}">

      <!-- Card Number -->
      <div class="field-group">
        <label class="field-label" for="cardNumber">Card Number</label>
        <input
          class="field-input"
          type="text"
          id="cardNumber"
          name="cardNumber"
          placeholder="1234 5678 9012 3456"
          maxlength="19"
          pattern="[0-9\s]{16,19}"
          required
        >
      </div>

      <!-- Card Holder -->
      <div class="field-group">
        <label class="field-label" for="cardHolderName">Card Holder Name</label>
        <input
          class="field-input"
          type="text"
          id="cardHolderName"
          name="cardHolderName"
          placeholder="Full name on card"
          required
        >
      </div>

      <!-- Expiry + CVV -->
      <div class="field-row">
        <div class="field-group" style="margin-bottom:0;">
          <label class="field-label" for="expiryDate">Expiry Date</label>
          <input
            class="field-input"
            type="text"
            id="expiryDate"
            name="expiryDate"
            placeholder="MM/YY"
            pattern="(0[1-9]|1[0-2])/\d{2}"
            required
          >
        </div>
        <div class="field-group" style="margin-bottom:0;">
          <label class="field-label" for="cvv">CVV</label>
          <input
            class="field-input"
            type="text"
            id="cvv"
            name="cvv"
            placeholder="123"
            maxlength="3"
            pattern="\d{3}"
            required
          >
        </div>
      </div>

      <!-- Total -->
      <div class="total-row">
        <span class="total-label">Total Charge</span>
        <span class="total-value">LKR ${movie.price}</span>
      </div>

      <!-- Submit -->
      <button type="submit" class="btn-pay">
        <i class="fas fa-lock" style="font-size:0.65rem;"></i>
        Pay Now — LKR ${movie.price}
      </button>

    </form>


  </div>

  <!-- Secure + Cancel -->
  <div class="secure-row">
    <i class="fas fa-shield-halved" style="font-size:0.65rem;color:var(--muted);"></i>
    <span class="secure-text">Secured &amp; Encrypted</span>
    <div class="secure-dot"></div>
    <span class="secure-text">256-bit SSL</span>
  </div>

  <div class="cancel-row">
    <a href="/movie/${movie.id}" class="cancel-link">
      <i class="fas fa-arrow-left" style="font-size:0.6rem;"></i>
      Cancel &amp; Go Back
    </a>
  </div>

</div>

</body>
</html>
