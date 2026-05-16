<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment Successful — CineRent</title>
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
      --green:     #4caf82;
      --green2:    #6dd4a0;
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
      background: var(--green);
      border-radius: 2px;
    }

    .eyebrow-text {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--green);
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

    .page-title span { color: var(--green); }

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
      background: var(--green);
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

    .movie-status { text-align: right; }

    .status-label {
      font-family: var(--font-mono);
      font-size: 0.6rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 4px;
    }

    .status-value {
      font-family: var(--font-display);
      font-size: 1.4rem;
      letter-spacing: 1px;
      color: var(--green);
      line-height: 1;
    }

    /* Receipt Card */
    .receipt-card {
      background: var(--surface);
      border: 1px solid rgba(76, 175, 130, 0.2);
      border-radius: 3px;
      padding: 32px 32px 28px;
      position: relative;
      overflow: hidden;
    }

    .receipt-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0;
      width: 2px;
      height: 100%;
      background: var(--green);
    }

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

    /* Receipt Rows */
    .receipt-rows {
      display: flex;
      flex-direction: column;
      gap: 0;
      margin-bottom: 28px;
      border: 1px solid var(--border);
      border-radius: 2px;
      overflow: hidden;
    }

    .receipt-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 13px 18px;
      border-bottom: 1px solid var(--border);
    }

    .receipt-row:last-child { border-bottom: none; }

    .receipt-row-key {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted);
    }

    .receipt-row-val {
      font-family: var(--font-mono);
      font-size: 0.78rem;
      letter-spacing: 0.3px;
      color: var(--text);
    }

    .receipt-row-val.highlight {
      color: var(--accent2);
      font-weight: 500;
    }

    .receipt-row-val.success-tag {
      color: var(--green2);
      font-size: 0.7rem;
      letter-spacing: 2px;
      text-transform: uppercase;
    }

    /* Watch Password Box */
    .password-box {
      display: flex;
      align-items: flex-start;
      gap: 14px;
      background: rgba(76, 175, 130, 0.05);
      border: 1px solid rgba(76, 175, 130, 0.18);
      border-radius: 2px;
      padding: 16px 18px;
      margin-bottom: 28px;
    }

    .password-icon-wrap {
      width: 32px;
      height: 32px;
      background: rgba(76, 175, 130, 0.1);
      border: 1px solid rgba(76, 175, 130, 0.25);
      border-radius: 2px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      margin-top: 1px;
    }

    .password-icon-wrap i {
      color: var(--green);
      font-size: 0.75rem;
    }

    .password-text {
      font-family: var(--font-mono);
      font-size: 0.75rem;
      letter-spacing: 0.3px;
      color: var(--muted2);
      line-height: 1.6;
    }

    .password-text strong {
      color: var(--green2);
      letter-spacing: 1.5px;
      font-size: 0.82rem;
    }

    /* Action Row */
    .action-row {
      display: flex;
      align-items: center;
      gap: 12px;
      border-top: 1px solid var(--border);
      padding-top: 24px;
    }

    /* Watch Button */
    .btn-watch {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      flex: 1;
      padding: 14px 28px;
      background: var(--green);
      color: #fff;
      font-family: var(--font-mono);
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 2px;
      text-transform: uppercase;
      border: none;
      border-radius: 2px;
      text-decoration: none;
      cursor: pointer;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      box-shadow: 0 4px 20px rgba(76,175,130,0.15);
    }

    .btn-watch:hover {
      background: var(--green2);
      transform: translateY(-2px);
      box-shadow: 0 8px 28px rgba(76,175,130,0.25);
      color: #fff;
    }

    .btn-watch:active { transform: translateY(0); }

    /* Rentals Button */
    .btn-rentals {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 14px 22px;
      background: transparent;
      color: var(--muted2);
      font-family: var(--font-mono);
      font-size: 0.75rem;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      border: 1px solid var(--border2);
      border-radius: 2px;
      text-decoration: none;
      transition: all 0.18s;
    }

    .btn-rentals:hover {
      color: var(--text);
      border-color: rgba(255,255,255,0.2);
      background: rgba(255,255,255,0.03);
    }

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

    /* Home Link */
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

    /* Responsive */
    @media (max-width: 900px) {
      .navbar { padding: 0 20px; }
      .page-header, .band-divider, .main-wrap { padding-left: 20px; padding-right: 20px; }
    }

    @media (max-width: 600px) {
      .movie-status { display: none; }
      .receipt-card { padding: 22px 18px 20px; }
      .action-row { flex-direction: column; }
      .btn-watch, .btn-rentals { width: 100%; }
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
    <span class="eyebrow-text">Transaction Confirmed</span>
  </div>
  <h1 class="page-title">Payment <span>Successful</span></h1>
</div>

<!-- Band Divider -->
<div class="band-divider">
  <span class="band-label">Receipt Details</span>
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
    <div class="movie-status">
      <div class="status-label">Status</div>
      <div class="status-value">Active</div>
    </div>
  </div>

  <!-- Receipt Card -->
  <div class="receipt-card">
    <div class="section-label">Payment Receipt</div>

    <!-- Receipt Rows -->
    <div class="receipt-rows">
      <div class="receipt-row">
        <span class="receipt-row-key">Payment ID</span>
        <span class="receipt-row-val">#${payment.paymentId}</span>
      </div>
      <div class="receipt-row">
        <span class="receipt-row-key">Movie</span>
        <span class="receipt-row-val">${movie.title}</span>
      </div>
      <div class="receipt-row">
        <span class="receipt-row-key">Amount Paid</span>
        <span class="receipt-row-val highlight">Rs ${payment.amount}</span>
      </div>
      <div class="receipt-row">
        <span class="receipt-row-key">Status</span>
        <span class="receipt-row-val success-tag">Confirmed</span>
      </div>
    </div>

    <!-- Watch Password -->
    <div class="password-box">
      <div class="password-icon-wrap">
        <i class="fas fa-lock-open"></i>
      </div>
      <div class="password-text">
        Your rental is now active. Use watch password <strong>movie123</strong> to unlock your stream.
      </div>
    </div>

    <!-- Actions -->
    <div class="action-row">
      <a class="btn-watch" href="/watch/${movie.id}">
        <i class="fas fa-play" style="font-size:0.65rem;"></i>
        Watch Online
      </a>
      <a class="btn-rentals" href="/my-rentals">
        <i class="fas fa-list" style="font-size:0.6rem;"></i>
        My Rentals
      </a>
    </div>

  </div>

  <!-- Secure + Home -->
  <div class="secure-row">
    <i class="fas fa-shield-halved" style="font-size:0.65rem;color:var(--muted);"></i>
    <span class="secure-text">Secured &amp; Encrypted</span>
    <div class="secure-dot"></div>
    <span class="secure-text">256-bit SSL</span>
  </div>

  <div class="cancel-row">
    <a href="/home" class="cancel-link">
      <i class="fas fa-arrow-left" style="font-size:0.6rem;"></i>
      Back to Home
    </a>
  </div>

</div>

</body>
</html>
