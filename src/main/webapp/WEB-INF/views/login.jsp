<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login — CineRent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    :root {
      --ink:       #0a0a0f;
      --surface:   #101018;
      --panel:     #13131e;
      --border:    rgba(255,255,255,0.07);
      --muted:     #4a4a6a;
      --soft:      #8888aa;
      --light:     #d8d8ee;
      --white:     #f5f5fa;
      --gold:      #c9a84c;
      --gold-glow: rgba(201,168,76,0.18);
      --red:       #e8384f;
      --red-dim:   rgba(232,56,79,0.12);
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: var(--ink);
      color: var(--white);
      min-height: 100vh;
      display: flex;
      font-family: 'DM Sans', sans-serif;
      overflow: hidden;
    }

    /* ── Film-strip left panel ── */
    .cinema-panel {
      display: none;
      position: relative;
      width: 52%;
      background: var(--surface);
      overflow: hidden;
      flex-shrink: 0;
    }

    @media (min-width: 900px) { .cinema-panel { display: flex; flex-direction: column; } }

    /* Vertical film-strip gutters */
    .strip {
      position: absolute;
      top: 0;
      bottom: 0;
      width: 32px;
      background: var(--ink);
      display: flex;
      flex-direction: column;
      gap: 10px;
      padding: 14px 0;
      z-index: 3;
    }
    .strip.left  { left: 0; }
    .strip.right { right: 0; }
    .strip-hole {
      width: 18px;
      height: 12px;
      background: var(--surface);
      border-radius: 3px;
      margin: 0 auto;
      border: 1px solid rgba(255,255,255,0.06);
    }

    /* Poster grid */
    .poster-grid {
      position: absolute;
      inset: 0 32px;
      display: grid;
      grid-template-columns: 1fr 1fr 1fr;
      gap: 2px;
      overflow: hidden;
    }

    .poster-col {
      display: flex;
      flex-direction: column;
      gap: 2px;
    }
    .poster-col.down  { animation: scrollDown 28s linear infinite; }
    .poster-col.up    { animation: scrollUp   32s linear infinite; }
    .poster-col.down2 { animation: scrollDown 24s linear infinite; }

    @keyframes scrollDown { from { transform: translateY(0); }    to { transform: translateY(-50%); } }
    @keyframes scrollUp   { from { transform: translateY(-50%); } to { transform: translateY(0); } }

    .poster-item {
      aspect-ratio: 2/3;
      background: var(--panel);
      position: relative;
      overflow: hidden;
      flex-shrink: 0;
    }

    .poster-item::before {
      content: '';
      position: absolute;
      inset: 0;
      background: linear-gradient(135deg,
        hsl(var(--hue, 220), 40%, 12%) 0%,
        hsl(var(--hue, 220), 60%, 20%) 50%,
        hsl(var(--hue, 220), 30%, 10%) 100%
      );
    }

    .poster-item::after {
      content: '';
      position: absolute;
      inset: 0;
      background: repeating-linear-gradient(
        0deg,
        transparent,
        transparent 2px,
        rgba(0,0,0,0.08) 2px,
        rgba(0,0,0,0.08) 4px
      );
    }

    /* Assign hues to poster items */
    .poster-item:nth-child(1)  { --hue: 200; }
    .poster-item:nth-child(2)  { --hue: 350; }
    .poster-item:nth-child(3)  { --hue: 30;  }
    .poster-item:nth-child(4)  { --hue: 260; }
    .poster-item:nth-child(5)  { --hue: 140; }
    .poster-item:nth-child(6)  { --hue: 10;  }
    .poster-item:nth-child(7)  { --hue: 190; }
    .poster-item:nth-child(8)  { --hue: 320; }
    .poster-item:nth-child(9)  { --hue: 60;  }
    .poster-item:nth-child(10) { --hue: 240; }
    .poster-item:nth-child(11) { --hue: 170; }
    .poster-item:nth-child(12) { --hue: 0;   }

    /* Vignette + overlay on poster grid */
    .grid-overlay {
      position: absolute;
      inset: 0 32px;
      background:
        radial-gradient(ellipse at center, transparent 20%, rgba(10,10,15,0.7) 100%),
        linear-gradient(to right, rgba(10,10,15,0.6), transparent 30%, transparent 70%, rgba(10,10,15,0.6));
      z-index: 2;
      pointer-events: none;
    }

    /* Brand block over the panel */
    .panel-brand {
      position: relative;
      z-index: 4;
      margin: auto 52px;
      padding: 0;
    }

    .panel-eyebrow {
      font-family: 'DM Sans', sans-serif;
      font-size: 0.7rem;
      font-weight: 600;
      letter-spacing: 0.25em;
      color: var(--gold);
      text-transform: uppercase;
      margin-bottom: 16px;
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .panel-eyebrow::before {
      content: '';
      display: block;
      width: 28px;
      height: 1px;
      background: var(--gold);
      opacity: 0.6;
    }

    .panel-wordmark {
      font-family: 'Playfair Display', serif;
      font-size: 4.2rem;
      font-weight: 900;
      line-height: 0.92;
      color: var(--white);
      letter-spacing: -2px;
      margin-bottom: 24px;
    }

    .panel-wordmark em {
      font-style: italic;
      color: var(--gold);
    }

    .panel-desc {
      font-size: 0.9rem;
      font-weight: 300;
      color: var(--soft);
      line-height: 1.75;
      max-width: 300px;
      margin-bottom: 36px;
    }

    .panel-stats {
      display: flex;
      gap: 32px;
    }

    .stat-item { display: flex; flex-direction: column; gap: 3px; }

    .stat-num {
      font-family: 'Playfair Display', serif;
      font-size: 1.6rem;
      font-weight: 700;
      color: var(--white);
    }

    .stat-label {
      font-size: 0.72rem;
      font-weight: 500;
      letter-spacing: 0.08em;
      color: var(--muted);
      text-transform: uppercase;
    }

    /* Horizontal rule accent */
    .rule-accent {
      display: block;
      width: 48px;
      height: 2px;
      background: linear-gradient(90deg, var(--gold), transparent);
      margin-bottom: 32px;
    }

    /* ── Right / form side ── */
    .form-side {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 40px 24px;
      position: relative;
      background: var(--ink);
    }

    /* Subtle grid texture */
    .form-side::before {
      content: '';
      position: absolute;
      inset: 0;
      background-image:
        linear-gradient(rgba(255,255,255,0.015) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255,255,255,0.015) 1px, transparent 1px);
      background-size: 48px 48px;
      pointer-events: none;
    }

    .form-box {
      position: relative;
      z-index: 1;
      width: 100%;
      max-width: 400px;
    }

    /* Mobile wordmark */
    .mobile-brand {
      display: block;
      font-family: 'Playfair Display', serif;
      font-size: 2rem;
      font-weight: 900;
      color: var(--white);
      letter-spacing: -1px;
      margin-bottom: 32px;
    }
    .mobile-brand em { font-style: italic; color: var(--gold); }
    @media (min-width: 900px) { .mobile-brand { display: none; } }

    /* Section header */
    .form-heading {
      font-family: 'Playfair Display', serif;
      font-size: 2.1rem;
      font-weight: 700;
      line-height: 1.1;
      color: var(--white);
      margin-bottom: 6px;
    }

    .form-sub {
      font-size: 0.88rem;
      color: var(--muted);
      margin-bottom: 36px;
    }

    /* Alert */
    .alert {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 11px 14px;
      border-radius: 8px;
      font-size: 0.85rem;
      margin-bottom: 24px;
    }
    .alert-error {
      background: var(--red-dim);
      border: 1px solid rgba(232,56,79,0.28);
      color: #f08090;
    }
    .alert-success {
      background: rgba(60,200,120,0.1);
      border: 1px solid rgba(60,200,120,0.25);
      color: #6dffc0;
    }
    .alert i { font-size: 0.9rem; flex-shrink: 0; }

    /* Field */
    .field { margin-bottom: 20px; }

    .field-label {
      display: block;
      font-size: 0.75rem;
      font-weight: 600;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 8px;
    }

    .field-wrap { position: relative; }

    .field-icon {
      position: absolute;
      left: 0;
      top: 0;
      bottom: 0;
      width: 44px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--muted);
      font-size: 0.85rem;
      pointer-events: none;
      transition: color 0.2s;
      z-index: 1;
    }

    .field-input {
      display: block;
      width: 100%;
      background: var(--panel);
      border: 1px solid var(--border);
      border-radius: 10px;
      color: var(--white);
      font-family: 'DM Sans', sans-serif;
      font-size: 0.93rem;
      padding: 13px 14px 13px 44px;
      transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
      outline: none;
      -webkit-appearance: none;
    }

    .field-input::placeholder { color: var(--muted); }

    .field-input:focus {
      border-color: rgba(201,168,76,0.5);
      background: rgba(201,168,76,0.04);
      box-shadow: 0 0 0 3px rgba(201,168,76,0.08);
    }

    .field-wrap:focus-within .field-icon { color: var(--gold); }

    .pw-toggle {
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      padding: 4px;
      color: var(--muted);
      cursor: pointer;
      font-size: 0.85rem;
      line-height: 1;
      transition: color 0.2s;
    }
    .pw-toggle:hover { color: var(--gold); }

    /* Extras row */
    .extras {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
      margin-top: -4px;
    }

    .remember {
      display: flex;
      align-items: center;
      gap: 8px;
      cursor: pointer;
      color: var(--soft);
      font-size: 0.84rem;
    }

    .remember input[type="checkbox"] {
      width: 15px;
      height: 15px;
      accent-color: var(--gold);
      cursor: pointer;
    }

    .forgot {
      font-size: 0.84rem;
      color: var(--gold);
      text-decoration: none;
      opacity: 0.85;
      transition: opacity 0.2s;
    }
    .forgot:hover { opacity: 1; }

    /* Submit button */
    .btn-submit {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      width: 100%;
      padding: 14px;
      border: none;
      border-radius: 10px;
      background: var(--gold);
      color: var(--ink);
      font-family: 'DM Sans', sans-serif;
      font-size: 0.93rem;
      font-weight: 700;
      letter-spacing: 0.04em;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: transform 0.2s, box-shadow 0.2s, filter 0.2s;
      box-shadow: 0 4px 20px rgba(201,168,76,0.3);
    }

    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 28px rgba(201,168,76,0.45);
      filter: brightness(1.06);
    }

    .btn-submit:active { transform: translateY(0); }

    /* Shimmer */
    .btn-submit::after {
      content: '';
      position: absolute;
      top: 0; left: -120%;
      width: 60%; height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.25), transparent);
      transition: left 0.45s;
    }
    .btn-submit:hover::after { left: 160%; }

    /* Spinner */
    .btn-submit.loading .spinner {
      display: inline-block;
      width: 14px;
      height: 14px;
      border: 2px solid rgba(10,10,15,0.3);
      border-top-color: var(--ink);
      border-radius: 50%;
      animation: spin 0.7s linear infinite;
    }
    .spinner { display: none; }
    @keyframes spin { to { transform: rotate(360deg); } }

    /* Divider */
    .divider {
      display: flex;
      align-items: center;
      gap: 14px;
      margin: 26px 0;
      color: var(--muted);
      font-size: 0.78rem;
      letter-spacing: 0.08em;
      text-transform: uppercase;
    }
    .divider::before, .divider::after {
      content: '';
      flex: 1;
      height: 1px;
      background: var(--border);
    }

    /* Footer */
    .form-footer {
      text-align: center;
      font-size: 0.86rem;
      color: var(--muted);
    }

    .form-footer a {
      color: var(--soft);
      text-decoration: none;
      font-weight: 600;
      transition: color 0.2s;
      border-bottom: 1px solid rgba(136,136,170,0.25);
      padding-bottom: 1px;
    }
    .form-footer a:hover { color: var(--gold); border-bottom-color: var(--gold); }

    .admin-btn {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      margin-top: 18px;
      padding: 8px 20px;
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 999px;
      color: var(--soft);
      font-size: 0.8rem;
      font-weight: 500;
      text-decoration: none;
      letter-spacing: 0.04em;
      transition: all 0.2s;
      background: rgba(255,255,255,0.03);
    }
    .admin-btn:hover {
      border-color: rgba(255,255,255,0.22);
      color: var(--white);
      background: rgba(255,255,255,0.06);
    }
    .admin-btn i { font-size: 0.78rem; opacity: 0.7; }

    /* Entrance animations */
    .form-box > * {
      opacity: 0;
      transform: translateY(16px);
      animation: fadeUp 0.5s ease forwards;
    }
    .form-box > *:nth-child(1) { animation-delay: 0.05s; }
    .form-box > *:nth-child(2) { animation-delay: 0.12s; }
    .form-box > *:nth-child(3) { animation-delay: 0.18s; }
    .form-box > *:nth-child(4) { animation-delay: 0.24s; }
    .form-box > *:nth-child(5) { animation-delay: 0.30s; }
    .form-box > *:nth-child(6) { animation-delay: 0.36s; }
    .form-box > *:nth-child(7) { animation-delay: 0.42s; }
    .form-box > *:nth-child(8) { animation-delay: 0.48s; }
    .form-box > *:nth-child(9) { animation-delay: 0.54s; }
    @keyframes fadeUp {
      to { opacity: 1; transform: translateY(0); }
    }

    .panel-brand {
      opacity: 0;
      animation: fadeUp 0.7s ease 0.1s forwards;
    }
  </style>
</head>
<body>

  <!-- Left cinema panel -->
  <div class="cinema-panel">

    <!-- Film strip holes -->
    <div class="strip left">
      <% for (int i = 0; i < 30; i++) { %><div class="strip-hole"></div><% } %>
    </div>
    <div class="strip right">
      <% for (int i = 0; i < 30; i++) { %><div class="strip-hole"></div><% } %>
    </div>

    <!-- Scrolling poster grid -->
    <div class="poster-grid">
      <div class="poster-col down">
        <% for (int i = 0; i < 24; i++) { %><div class="poster-item"></div><% } %>
      </div>
      <div class="poster-col up">
        <% for (int i = 0; i < 24; i++) { %><div class="poster-item"></div><% } %>
      </div>
      <div class="poster-col down2">
        <% for (int i = 0; i < 24; i++) { %><div class="poster-item"></div><% } %>
      </div>
    </div>

    <div class="grid-overlay"></div>

    <!-- Brand block -->
    <div class="panel-brand">
      <div class="panel-eyebrow">Now streaming</div>
      <div class="panel-wordmark">Cine<em>Rent</em></div>
      <span class="rule-accent"></span>
      <p class="panel-desc">
        HD and 4K rentals delivered instantly. No subscriptions, no waiting — just great cinema on demand.
      </p>
      <div class="panel-stats">
        <div class="stat-item">
          <span class="stat-num">12K+</span>
          <span class="stat-label">Titles</span>
        </div>
        <div class="stat-item">
          <span class="stat-num">4K</span>
          <span class="stat-label">Ultra HD</span>
        </div>
        <div class="stat-item">
          <span class="stat-num">24h</span>
          <span class="stat-label">Rental window</span>
        </div>
      </div>
    </div>

  </div>

  <!-- Right form side -->
  <div class="form-side">
    <div class="form-box">

      <div class="mobile-brand">Cine<em>Rent</em></div>

      <div class="form-heading">Welcome back.</div>
      <div class="form-sub">Sign in to your account to continue</div>

      <!-- Error / success messages -->
      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
          <i class="fas fa-circle-exclamation"></i>
          <%= request.getAttribute("error") %>
        </div>
      <% } %>

      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
          <i class="fas fa-circle-check"></i>
          <%= request.getAttribute("success") %>
        </div>
      <% } %>

      <form method="post" action="/login" id="loginForm">

        <!-- Username -->
        <div class="field">
          <label class="field-label" for="username">Username</label>
          <div class="field-wrap">
            <span class="field-icon"><i class="fas fa-user"></i></span>
            <input
              class="field-input"
              type="text"
              id="username"
              name="username"
              placeholder="your username"
              autocomplete="username"
              required>
          </div>
        </div>

        <!-- Password -->
        <div class="field">
          <label class="field-label" for="passwordField">Password</label>
          <div class="field-wrap">
            <span class="field-icon"><i class="fas fa-lock"></i></span>
            <input
              class="field-input"
              type="password"
              id="passwordField"
              name="password"
              placeholder="your password"
              autocomplete="current-password"
              required>
            <button type="button" class="pw-toggle" onclick="togglePassword()" aria-label="Toggle password visibility">
              <i class="fas fa-eye" id="eyeIcon"></i>
            </button>
          </div>
        </div>

        <!-- Extras -->
        <div class="extras">
          <label class="remember">
            <input type="checkbox" name="remember"> Remember me
          </label>
          <a href="/forgot-password" class="forgot">Forgot password?</a>
        </div>

        <!-- Submit -->
        <button type="submit" class="btn-submit" id="loginBtn">
          <span class="btn-text">Sign In</span>
          <i class="fas fa-arrow-right"></i>
          <span class="spinner"></span>
        </button>

      </form>

      <div class="divider">or</div>

      <div class="form-footer">
        No account yet? <a href="/signup">Create one free</a>
        <br>
        <a href="/admin/login" class="admin-btn">
          <i class="fas fa-shield-halved"></i> Admin Portal
        </a>
      </div>

    </div>
  </div>

<script>
  function togglePassword() {
    const field = document.getElementById('passwordField');
    const icon  = document.getElementById('eyeIcon');
    const isHidden = field.type === 'password';
    field.type = isHidden ? 'text' : 'password';
    icon.classList.toggle('fa-eye',       !isHidden);
    icon.classList.toggle('fa-eye-slash',  isHidden);
  }

  document.getElementById('loginForm').addEventListener('submit', function () {
    const btn = document.getElementById('loginBtn');
    btn.classList.add('loading');
    btn.disabled = true;
    btn.querySelector('.btn-text').textContent = 'Signing in';
    btn.querySelector('.fa-arrow-right').style.display = 'none';
  });
</script>

</body>
</html>
