<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Segoe UI', sans-serif;
      overflow: hidden;
    }

    /* Animated background */
    body::before {
      content: '';
      position: fixed;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(ellipse at 20% 50%, rgba(238,9,121,0.15) 0%, transparent 50%),
                  radial-gradient(ellipse at 80% 20%, rgba(255,106,0,0.12) 0%, transparent 50%),
                  radial-gradient(ellipse at 50% 80%, rgba(26,23,64,0.8) 0%, transparent 60%);
      animation: bgFloat 8s ease-in-out infinite alternate;
      z-index: 0;
    }

    @keyframes bgFloat {
      0%   { transform: translate(0, 0) rotate(0deg); }
      100% { transform: translate(2%, 3%) rotate(1deg); }
    }

    .page-wrapper {
      position: relative;
      z-index: 1;
      display: flex;
      align-items: center;
      gap: 60px;
      padding: 20px;
    }

    /* Brand side */
    .brand-side {
      display: none;
      flex-direction: column;
      align-items: flex-start;
      max-width: 340px;
    }

    @media (min-width: 900px) {
      .brand-side { display: flex; }
    }

    .brand-logo {
      font-size: 2.8rem;
      font-weight: 800;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: -1px;
      margin-bottom: 12px;
    }

    .brand-logo span {
      background: none;
      -webkit-text-fill-color: #fff;
    }

    .brand-tagline {
      font-size: 1.05rem;
      color: #a89fc8;
      line-height: 1.6;
      margin-bottom: 28px;
    }

    .feature-list {
      list-style: none;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .feature-list li {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 0.9rem;
      color: #c4b8e0;
    }

    .feature-list li i {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      font-size: 1rem;
      width: 20px;
    }

    /* Card */
    .card {
      background: rgba(26, 23, 64, 0.85);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: 24px;
      padding: 40px 36px;
      width: 400px;
      box-shadow: 0 30px 80px rgba(0,0,0,0.5), 0 0 0 1px rgba(238,9,121,0.08);
    }

    .card-header-custom {
      text-align: center;
      margin-bottom: 30px;
    }

    .card-icon {
      width: 58px;
      height: 58px;
      background: linear-gradient(135deg, #ff6a00, #ee0979);
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 16px;
      font-size: 1.4rem;
      box-shadow: 0 8px 24px rgba(238,9,121,0.35);
    }

    .card-title {
      font-size: 1.6rem;
      font-weight: 700;
      margin-bottom: 4px;
    }

    .card-subtitle {
      font-size: 0.85rem;
      color: #8a7fb0;
    }

    /* Alert */
    .alert-danger {
      background: rgba(220, 53, 69, 0.15);
      border: 1px solid rgba(220, 53, 69, 0.35);
      border-radius: 10px;
      color: #ff8a95;
      font-size: 0.88rem;
      padding: 10px 14px;
      margin-bottom: 20px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    /* Form */
    .form-group {
      margin-bottom: 18px;
    }

    .form-label {
      font-size: 0.82rem;
      font-weight: 600;
      color: #a89fc8;
      margin-bottom: 7px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .input-wrapper {
      position: relative;
    }

    .input-icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #5a5280;
      font-size: 0.95rem;
      pointer-events: none;
      transition: color 0.2s;
    }

    .form-control {
      background: rgba(255,255,255,0.05);
      border: 1.5px solid rgba(255,255,255,0.1);
      border-radius: 12px;
      color: #fff;
      padding: 12px 14px 12px 40px;
      font-size: 0.95rem;
      width: 100%;
      transition: all 0.25s ease;
    }

    .form-control:focus {
      outline: none;
      background: rgba(255,255,255,0.08);
      border-color: rgba(238,9,121,0.6);
      box-shadow: 0 0 0 3px rgba(238,9,121,0.12);
      color: #fff;
    }

    .form-control:focus + .input-icon,
    .input-wrapper:focus-within .input-icon {
      color: #ee0979;
    }

    .form-control::placeholder { color: #5a5280; }

    /* Password toggle */
    .toggle-pw {
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #5a5280;
      cursor: pointer;
      font-size: 0.9rem;
      transition: color 0.2s;
      background: none;
      border: none;
      padding: 0;
    }

    .toggle-pw:hover { color: #ee0979; }

    /* Remember + Forgot */
    .form-extras {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }

    .remember-me {
      display: flex;
      align-items: center;
      gap: 7px;
      font-size: 0.85rem;
      color: #8a7fb0;
      cursor: pointer;
    }

    .remember-me input[type="checkbox"] {
      accent-color: #ee0979;
      width: 15px;
      height: 15px;
      cursor: pointer;
    }

    .forgot-link {
      font-size: 0.85rem;
      color: #ee0979;
      text-decoration: none;
      transition: opacity 0.2s;
    }

    .forgot-link:hover { opacity: 0.75; color: #ee0979; }

    /* Button */
    .btn-login {
      width: 100%;
      padding: 13px;
      border: none;
      border-radius: 12px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-size: 1rem;
      font-weight: 700;
      letter-spacing: 0.3px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 6px 24px rgba(238,9,121,0.4);
    }

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 32px rgba(238,9,121,0.55);
    }

    .btn-login:active { transform: translateY(0); }

    .btn-login .btn-text { position: relative; z-index: 1; }

    .btn-login::after {
      content: '';
      position: absolute;
      top: 0; left: -100%;
      width: 100%; height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
      transition: left 0.4s;
    }

    .btn-login:hover::after { left: 100%; }

    /* Divider */
    .divider {
      display: flex;
      align-items: center;
      gap: 12px;
      margin: 22px 0;
      color: #3d3660;
      font-size: 0.8rem;
    }

    .divider::before, .divider::after {
      content: '';
      flex: 1;
      height: 1px;
      background: rgba(255,255,255,0.07);
    }

    /* Footer links */
    .card-footer-links {
      text-align: center;
      font-size: 0.88rem;
      color: #6e658f;
    }

    .card-footer-links a {
      color: #c084fc;
      text-decoration: none;
      font-weight: 600;
      transition: color 0.2s;
    }

    .card-footer-links a:hover { color: #ee0979; }

    .admin-link-wrap {
      margin-top: 14px;
    }

    .btn-admin {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 20px;
      border-radius: 20px;
      border: 1.5px solid rgba(255,193,7,0.3);
      color: #ffc107;
      font-size: 0.82rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
      background: rgba(255,193,7,0.05);
    }

    .btn-admin:hover {
      background: rgba(255,193,7,0.12);
      border-color: rgba(255,193,7,0.6);
      color: #ffc107;
      transform: translateY(-1px);
    }

    /* Loading spinner on submit */
    .btn-login.loading .btn-text::after {
      content: '';
      display: inline-block;
      width: 14px;
      height: 14px;
      border: 2px solid rgba(255,255,255,0.4);
      border-top-color: #fff;
      border-radius: 50%;
      animation: spin 0.7s linear infinite;
      margin-left: 10px;
      vertical-align: middle;
    }

    @keyframes spin { to { transform: rotate(360deg); } }
  </style>
</head>
<body>

<div class="page-wrapper">

  <!-- Brand Side (visible on wide screens) -->
  <div class="brand-side">
    <div class="brand-logo">Cine<span>Rent</span></div>
    <p class="brand-tagline">
      Stream and rent the latest movies from the comfort of your home.
      HD quality, instant access, no waiting.
    </p>
    <ul class="feature-list">
      <li><i class="fas fa-film"></i> Thousands of movies in HD & 4K</li>
      <li><i class="fas fa-bolt"></i> Instant streaming, no buffering</li>
      <li><i class="fas fa-tag"></i> Affordable rental prices</li>
      <li><i class="fas fa-shield-halved"></i> Secure payments</li>
      <li><i class="fas fa-star"></i> Ratings & reviews by community</li>
    </ul>
  </div>

  <!-- Login Card -->
  <div class="card">

    <div class="card-header-custom">
      <div class="card-icon">
        <i class="fas fa-clapperboard"></i>
      </div>
      <div class="card-title">Welcome Back</div>
      <div class="card-subtitle">Sign in to your CineRent account</div>
    </div>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
      <div class="alert-danger">
        <i class="fas fa-circle-exclamation"></i>
        <%= request.getAttribute("error") %>
      </div>
    <% } %>

    <!-- Success Message -->
    <% if (request.getAttribute("success") != null) { %>
      <div class="alert-danger" style="background:rgba(25,135,84,0.15);border-color:rgba(25,135,84,0.35);color:#6dffb3;">
        <i class="fas fa-circle-check"></i>
        <%= request.getAttribute("success") %>
      </div>
    <% } %>

    <form method="post" action="/login" id="loginForm">

      <!-- Username -->
      <div class="form-group">
        <label class="form-label">Username</label>
        <div class="input-wrapper">
          <input class="form-control"
                 type="text"
                 name="username"
                 placeholder="Enter your username"
                 autocomplete="username"
                 required>
          <i class="fas fa-user input-icon"></i>
        </div>
      </div>

      <!-- Password -->
      <div class="form-group">
        <label class="form-label">Password</label>
        <div class="input-wrapper">
          <input class="form-control"
                 type="password"
                 name="password"
                 id="passwordField"
                 placeholder="Enter your password"
                 autocomplete="current-password"
                 required>
          <i class="fas fa-lock input-icon"></i>
          <button type="button" class="toggle-pw" onclick="togglePassword()" id="toggleBtn">
            <i class="fas fa-eye" id="eyeIcon"></i>
          </button>
        </div>
      </div>

      <!-- Remember + Forgot -->
      <div class="form-extras">
        <label class="remember-me">
          <input type="checkbox" name="remember"> Remember me
        </label>
        <a href="/forgot-password" class="forgot-link">Forgot password?</a>
      </div>

      <!-- Submit -->
      <button type="submit" class="btn-login" id="loginBtn">
        <span class="btn-text">Sign In &nbsp;<i class="fas fa-arrow-right"></i></span>
      </button>

    </form>

    <div class="divider">or</div>

    <!-- Sign up -->
    <div class="card-footer-links">
      Don't have an account? <a href="/signup">Create one free</a>
    </div>

    <!-- Admin -->
    <div class="admin-link-wrap text-center">
      <a href="/admin/login" class="btn-admin">
        <i class="fas fa-shield-halved"></i> Admin Portal
      </a>
    </div>

  </div>
</div>

<script>
  // Toggle password visibility
  function togglePassword() {
    const field = document.getElementById('passwordField');
    const icon  = document.getElementById('eyeIcon');
    if (field.type === 'password') {
      field.type = 'text';
      icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
      field.type = 'password';
      icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
  }

  // Loading state on submit
  document.getElementById('loginForm').addEventListener('submit', function() {
    const btn = document.getElementById('loginBtn');
    btn.classList.add('loading');
    btn.disabled = true;
  });
</script>

</body>
</html>
