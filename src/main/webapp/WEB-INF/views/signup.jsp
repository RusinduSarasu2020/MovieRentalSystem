<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account — CineRent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --ink: #0a0a0f;
      --ink-2: #111118;
      --ink-3: #1a1a26;
      --gold: #c8a96e;
      --gold-pale: #e8d5a8;
      --cream: #f5f0e8;
      --muted: #5c5c74;
      --muted-2: #3a3a50;
      --wire: rgba(255,255,255,0.07);
      --wire-2: rgba(255,255,255,0.04);
      --r: 6px;
      --r-lg: 12px;
    }

    html { scroll-behavior: smooth; }

    body {
      background: var(--ink);
      color: #d8d4cc;
      font-family: 'DM Sans', sans-serif;
      font-size: 14px;
      font-weight: 400;
      line-height: 1.6;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* ── GRAIN OVERLAY ── */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 1000;
      opacity: 0.35;
    }

    /* ── NAVBAR ── */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 200;
      height: 62px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 48px;
      background: rgba(10,10,15,0.88);
      backdrop-filter: blur(20px) saturate(1.5);
      border-bottom: 1px solid var(--wire);
    }

    .brand {
      display: flex;
      align-items: baseline;
      gap: 3px;
      text-decoration: none;
    }
    .brand-cine {
      font-family: 'Playfair Display', serif;
      font-size: 22px;
      font-weight: 900;
      color: var(--cream);
      letter-spacing: -0.5px;
    }
    .brand-rent {
      font-family: 'Playfair Display', serif;
      font-size: 22px;
      font-weight: 400;
      font-style: italic;
      color: var(--gold);
      letter-spacing: -0.5px;
    }
    .brand-dot {
      width: 5px; height: 5px;
      border-radius: 50%;
      background: var(--gold);
      margin: 0 2px 2px;
      align-self: flex-end;
    }

    .nav-right {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .btn-ghost {
      padding: 7px 20px;
      border: 1px solid var(--wire);
      border-radius: 100px;
      background: transparent;
      color: var(--muted);
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 500;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      text-decoration: none;
      cursor: pointer;
      transition: all 0.2s;
      display: inline-block;
    }
    .btn-ghost:hover {
      border-color: rgba(200,169,110,0.4);
      color: var(--gold);
      background: rgba(200,169,110,0.05);
    }

    /* ── PAGE LAYOUT ── */
    .page {
      min-height: calc(100vh - 62px);
      display: grid;
      grid-template-columns: 1fr 1fr;
    }

    /* ── LEFT PANEL ── */
    .left-panel {
      position: relative;
      padding: 72px 64px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      border-right: 1px solid var(--wire);
      overflow: hidden;
    }

    .left-bg {
      position: absolute;
      inset: 0;
      background:
        radial-gradient(ellipse 70% 60% at 20% 30%, rgba(200,169,110,0.06) 0%, transparent 60%),
        radial-gradient(ellipse 50% 70% at 80% 80%, rgba(100,60,180,0.04) 0%, transparent 60%);
      pointer-events: none;
    }

    .left-lines {
      position: absolute;
      left: 0; top: 0; right: 0; bottom: 0;
      background-image: repeating-linear-gradient(
        90deg,
        var(--wire-2) 0px,
        var(--wire-2) 1px,
        transparent 1px,
        transparent 60px
      );
      mask-image: linear-gradient(to bottom, transparent, rgba(0,0,0,0.4) 20%, rgba(0,0,0,0.4) 80%, transparent);
      pointer-events: none;
    }

    .left-content {
      position: relative;
      max-width: 460px;
    }

    .panel-label {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 28px;
    }
    .panel-label::before {
      content: '';
      display: block;
      width: 28px;
      height: 1px;
      background: var(--gold);
    }

    .panel-heading {
      font-family: 'Playfair Display', serif;
      font-size: clamp(36px, 4vw, 52px);
      font-weight: 900;
      color: var(--cream);
      line-height: 1.1;
      letter-spacing: -1px;
      margin-bottom: 20px;
    }
    .panel-heading em {
      font-weight: 400;
      font-style: italic;
      color: var(--gold);
    }

    .panel-sub {
      font-size: 14px;
      font-weight: 300;
      color: var(--muted);
      line-height: 1.7;
      margin-bottom: 48px;
      max-width: 380px;
    }

    .perks {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }

    .perk {
      display: flex;
      align-items: flex-start;
      gap: 16px;
    }

    .perk-icon {
      width: 36px;
      height: 36px;
      flex-shrink: 0;
      border: 1px solid rgba(200,169,110,0.25);
      border-radius: var(--r);
      background: rgba(200,169,110,0.05);
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--gold);
      margin-top: 2px;
    }

    .perk-text strong {
      display: block;
      font-size: 13px;
      font-weight: 600;
      color: var(--cream);
      margin-bottom: 2px;
      letter-spacing: 0.2px;
    }
    .perk-text span {
      font-size: 12px;
      color: var(--muted);
      font-weight: 300;
    }

    .divider-h {
      width: 100%;
      height: 1px;
      background: var(--wire);
      margin: 48px 0;
    }

    /* ── RIGHT PANEL / FORM ── */
    .right-panel {
      padding: 72px 64px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      background: var(--ink-2);
    }

    .form-wrap {
      max-width: 400px;
      width: 100%;
    }

    .form-heading {
      font-family: 'Playfair Display', serif;
      font-size: 28px;
      font-weight: 700;
      color: var(--cream);
      letter-spacing: -0.5px;
      margin-bottom: 6px;
    }

    .form-sub {
      font-size: 13px;
      color: var(--muted);
      margin-bottom: 36px;
      font-weight: 300;
    }

    /* ── ALERT ── */
    .alert-error {
      background: rgba(192,57,43,0.12);
      border: 1px solid rgba(192,57,43,0.35);
      border-left: 3px solid #c0392b;
      border-radius: var(--r);
      padding: 12px 16px;
      font-size: 13px;
      color: #e07070;
      margin-bottom: 24px;
      line-height: 1.5;
    }

    /* ── FORM FIELDS ── */
    .field-group {
      display: flex;
      flex-direction: column;
      gap: 14px;
      margin-bottom: 8px;
    }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .field-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }

    .field label {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 1.2px;
      text-transform: uppercase;
      color: var(--muted);
    }

    .field-input-wrap {
      position: relative;
    }

    .field-icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--muted-2);
      pointer-events: none;
      transition: color 0.2s;
    }

    .field input {
      width: 100%;
      height: 44px;
      background: var(--ink-3);
      border: 1px solid var(--wire);
      border-radius: var(--r);
      padding: 0 14px 0 40px;
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      font-weight: 400;
      color: var(--cream);
      outline: none;
      transition: border-color 0.2s, background 0.2s;
      -webkit-appearance: none;
    }

    .field input::placeholder {
      color: var(--muted-2);
    }

    .field input:focus {
      border-color: rgba(200,169,110,0.5);
      background: rgba(26,26,38,0.8);
    }

    .field input:focus + .field-icon,
    .field-input-wrap:focus-within .field-icon {
      color: var(--gold);
    }

    /* password strength bar */
    .strength-bar {
      height: 2px;
      background: var(--wire);
      border-radius: 4px;
      margin-top: 6px;
      overflow: hidden;
    }
    .strength-fill {
      height: 100%;
      width: 0%;
      border-radius: 4px;
      transition: width 0.3s, background 0.3s;
    }

    .field-hint {
      font-size: 11px;
      color: var(--muted-2);
      margin-top: 2px;
    }

    /* ── SEPARATOR ── */
    .form-sep {
      height: 1px;
      background: var(--wire);
      margin: 24px 0;
    }

    /* ── SUBMIT ── */
    .btn-submit {
      width: 100%;
      height: 46px;
      background: transparent;
      border: 1px solid var(--gold);
      border-radius: 100px;
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: var(--gold);
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: color 0.25s;
      margin-bottom: 20px;
    }

    .btn-submit::before {
      content: '';
      position: absolute;
      inset: 0;
      background: var(--gold);
      transform: translateX(-100%);
      transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .btn-submit:hover {
      color: var(--ink);
    }

    .btn-submit:hover::before {
      transform: translateX(0);
    }

    .btn-submit span {
      position: relative;
      z-index: 1;
    }

    .form-footer {
      text-align: center;
      font-size: 12px;
      color: var(--muted);
    }

    .form-footer a {
      color: var(--gold);
      text-decoration: none;
      font-weight: 500;
      transition: color 0.2s;
    }
    .form-footer a:hover {
      color: var(--gold-pale);
    }

    /* ── TERMS ── */
    .terms-line {
      font-size: 11px;
      color: var(--muted-2);
      text-align: center;
      line-height: 1.6;
      margin-top: 16px;
    }
    .terms-line a {
      color: var(--muted);
      text-decoration: underline;
      text-underline-offset: 2px;
      transition: color 0.2s;
    }
    .terms-line a:hover { color: var(--gold); }

    /* ── ENTRY ANIMATION ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(16px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .left-content { animation: fadeUp 0.55s ease both; }
    .form-wrap    { animation: fadeUp 0.55s 0.1s ease both; }
  </style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
  <a class="brand" href="/">
    <span class="brand-cine">Cine</span>
    <div class="brand-dot"></div>
    <span class="brand-rent">Rent</span>
  </a>
  <div class="nav-right">
    <a href="/login" class="btn-ghost">Sign In</a>
  </div>
</nav>

<!-- ── PAGE ── -->
<div class="page">

  <!-- LEFT PANEL -->
  <div class="left-panel">
    <div class="left-bg"></div>
    <div class="left-lines"></div>

    <div class="left-content">
      <div class="panel-label">Join CineRent</div>
      <h1 class="panel-heading">
        Your cinema,<br><em>starts here.</em>
      </h1>
      <p class="panel-sub">
        Create a free account and unlock thousands of curated films — from golden-era classics to this week's new releases.
      </p>

      <div class="perks">
        <div class="perk">
          <div class="perk-icon">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="3" width="12" height="10" rx="1.5"/>
              <path d="M6 7l2.5 2L11 6"/>
            </svg>
          </div>
          <div class="perk-text">
            <strong>4,000+ Titles Available</strong>
            <span>Action, drama, documentary, horror and more — all in one place.</span>
          </div>
        </div>

        <div class="perk">
          <div class="perk-icon">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="8" cy="8" r="6"/>
              <path d="M8 5v3.5l2 1.5"/>
            </svg>
          </div>
          <div class="perk-text">
            <strong>24-Hour Rental Window</strong>
            <span>Rent once, watch at your own pace within a full day.</span>
          </div>
        </div>

        <div class="perk">
          <div class="perk-icon">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
              <path d="M2 5l6-3 6 3v6l-6 3-6-3V5z"/>
              <path d="M8 2v12M2 5l6 3 6-3"/>
            </svg>
          </div>
          <div class="perk-text">
            <strong>Up to 4K Ultra HD Quality</strong>
            <span>480p through 4K — watch in the quality that suits you.</span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- RIGHT PANEL -->
  <div class="right-panel">
    <div class="form-wrap">

      <h2 class="form-heading">Create Account</h2>
      <p class="form-sub">Free to join. No subscription required.</p>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error"><%= request.getAttribute("error") %></div>
      <% } %>

      <form method="post" action="/signup" autocomplete="off">

        <div class="field-group">

          <div class="field-row">
            <div class="field">
              <label for="email">Email</label>
              <div class="field-input-wrap">
                <input id="email" name="email" type="email" placeholder="you@example.com" required autocomplete="email">
                <svg class="field-icon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="1.5" y="3" width="12" height="9" rx="1.5"/>
                  <path d="M1.5 5l6 4 6-4"/>
                </svg>
              </div>
            </div>

            <div class="field">
              <label for="username">Username</label>
              <div class="field-input-wrap">
                <input id="username" name="username" type="text" placeholder="cinephile99" required autocomplete="username">
                <svg class="field-icon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="7.5" cy="5" r="3"/>
                  <path d="M1.5 13.5a6 6 0 0111 0"/>
                </svg>
              </div>
            </div>
          </div>

          <div class="field">
            <label for="phone">Phone Number</label>
            <div class="field-input-wrap">
              <input id="phone" name="phone" type="tel" placeholder="+94 77 000 0000" required autocomplete="tel">
              <svg class="field-icon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="4" y="1" width="7" height="13" rx="1.5"/>
                <circle cx="7.5" cy="11.5" r="0.75" fill="currentColor" stroke="none"/>
              </svg>
            </div>
          </div>

          <div class="field">
            <label for="password">Password</label>
            <div class="field-input-wrap">
              <input id="password" name="password" type="password" placeholder="Create a strong password" required autocomplete="new-password" oninput="updateStrength(this.value)">
              <svg class="field-icon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="2.5" y="6.5" width="10" height="7" rx="1"/>
                <path d="M5 6.5V4.5a2.5 2.5 0 015 0v2"/>
              </svg>
            </div>
            <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
            <div class="field-hint" id="strengthLabel"></div>
          </div>

          <div class="field">
            <label for="password2">Confirm Password</label>
            <div class="field-input-wrap">
              <input id="password2" name="password2" type="password" placeholder="Repeat your password" required autocomplete="new-password">
              <svg class="field-icon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="2.5" y="6.5" width="10" height="7" rx="1"/>
                <path d="M5 6.5V4.5a2.5 2.5 0 015 0v2"/>
                <path d="M5 10l2 1.5L10 9" stroke-linejoin="round"/>
              </svg>
            </div>
          </div>

        </div>

        <div class="form-sep"></div>

        <button type="submit" class="btn-submit">
          <span>Create My Account</span>
        </button>

        <div class="form-footer">
          Already have an account? <a href="/login">Sign in instead</a>
        </div>

        <div class="terms-line">
          By creating an account you agree to our <a href="/terms">Terms of Service</a> and <a href="/privacy">Privacy Policy</a>.
        </div>

      </form>
    </div>
  </div>

</div>

<script>
  function updateStrength(val) {
    const fill = document.getElementById('strengthFill');
    const label = document.getElementById('strengthLabel');
    let score = 0;
    if (val.length >= 8)  score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    const levels = [
      { pct: '0%',   color: 'transparent', text: '' },
      { pct: '25%',  color: '#c0392b',     text: 'Weak' },
      { pct: '55%',  color: '#e67e22',     text: 'Fair' },
      { pct: '80%',  color: '#f1c40f',     text: 'Good' },
      { pct: '100%', color: '#27ae60',     text: 'Strong' },
    ];

    const l = levels[val.length === 0 ? 0 : score];
    fill.style.width = l.pct;
    fill.style.background = l.color;
    label.textContent = l.text;
    label.style.color = l.color;
  }
</script>

</body>
</html>
