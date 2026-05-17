<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Privacy Policy — CineRent</title>
  <meta name="description" content="Learn how CineRent collects, uses, and protects your personal information in our Privacy Policy.">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Syne:wght@400;600;700;800&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    :root {
      --black:   #0a0a0a;
      --dark:    #111111;
      --card:    #161616;
      --border:  #242424;
      --border2: #2e2e2e;
      --muted:   #555555;
      --soft:    #888888;
      --light:   #c8c8c8;
      --white:   #f0ede8;
      --gold:    #c9a84c;
      --gold2:   #e8c870;
      --font-display: 'Cormorant Garamond', Georgia, serif;
      --font-ui:      'Syne', sans-serif;
      --font-mono:    'DM Mono', monospace;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html { scroll-behavior: smooth; }

    body {
      background: var(--black);
      color: var(--white);
      font-family: var(--font-ui);
      font-size: 16px;
      line-height: 1.6;
      overflow-x: hidden;
      -webkit-font-smoothing: antialiased;
    }

    body::after {
      content: '';
      position: fixed;
      inset: 0;
      z-index: 9999;
      pointer-events: none;
      opacity: 0.025;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 512 512' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='512' height='512' filter='url(%23noise)' opacity='1'/%3E%3C/svg%3E");
      background-size: 200px;
    }

    a { text-decoration: none; color: inherit; }

    /* NAVBAR */
    .navbar {
      position: fixed;
      top: 0; left: 0; right: 0;
      z-index: 100;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 48px;
      height: 64px;
      background: rgba(10,10,10,0.94);
      backdrop-filter: blur(24px);
      border-bottom: 1px solid var(--border);
    }

    .nav-brand { display: flex; align-items: center; gap: 8px; }
    .brand-name {
      font-family: var(--font-display);
      font-size: 1.55rem;
      font-weight: 600;
      color: var(--white);
      letter-spacing: 0.04em;
    }
    .brand-dot { width: 5px; height: 5px; border-radius: 50%; background: var(--gold); }

    .nav-actions { display: flex; align-items: center; gap: 10px; }

    .btn-nav-ghost {
      padding: 8px 22px;
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--soft);
      border: 1px solid var(--border2);
      background: transparent;
      transition: all 0.2s;
      display: inline-block;
    }
    .btn-nav-ghost:hover { color: var(--white); border-color: var(--soft); }

    .btn-nav-fill {
      padding: 8px 22px;
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--black);
      background: var(--gold);
      border: 1px solid var(--gold);
      transition: all 0.2s;
      display: inline-block;
    }
    .btn-nav-fill:hover { background: var(--gold2); border-color: var(--gold2); }

    /* PAGE HERO */
    .page-hero {
      padding-top: 64px;
      border-bottom: 1px solid var(--border);
      background: radial-gradient(ellipse at 50% 0%, rgba(201,168,76,0.06) 0%, transparent 60%), var(--dark);
      position: relative;
      overflow: hidden;
    }

    .page-hero-inner {
      max-width: 820px;
      margin: 0 auto;
      padding: 80px 40px 64px;
      position: relative;
      z-index: 1;
    }

    .page-eyebrow {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 22px;
      display: flex;
      align-items: center;
      gap: 14px;
    }
    .page-eyebrow::before {
      content: '';
      display: block;
      width: 32px; height: 1px;
      background: var(--gold);
      opacity: 0.6;
    }

    .page-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 6vw, 5rem);
      font-weight: 300;
      line-height: 1.05;
      margin-bottom: 20px;
    }
    .page-title em { font-style: italic; color: var(--gold); }

    .page-meta {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      letter-spacing: 0.1em;
      color: var(--muted);
    }

    /* CONTENT */
    .content-wrap {
      max-width: 820px;
      margin: 0 auto;
      padding: 72px 40px 100px;
    }

    .toc {
      background: var(--card);
      border: 1px solid var(--border);
      padding: 28px 32px;
      margin-bottom: 60px;
    }

    .toc-label {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 16px;
    }

    .toc ol {
      list-style: none;
      counter-reset: toc;
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .toc ol li {
      counter-increment: toc;
      font-family: var(--font-mono);
      font-size: 0.78rem;
      color: var(--soft);
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .toc ol li::before {
      content: counter(toc, decimal-leading-zero);
      color: var(--muted);
      font-size: 0.65rem;
    }
    .toc ol li a { color: var(--soft); transition: color 0.2s; }
    .toc ol li a:hover { color: var(--gold); }

    .section-block {
      margin-bottom: 52px;
      padding-bottom: 52px;
      border-bottom: 1px solid var(--border);
    }
    .section-block:last-child { border-bottom: none; }

    .section-number {
      font-family: var(--font-mono);
      font-size: 0.63rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 14px;
    }

    .section-block h2 {
      font-family: var(--font-display);
      font-size: 1.75rem;
      font-weight: 400;
      margin-bottom: 20px;
      color: var(--white);
    }

    .section-block p {
      font-size: 0.92rem;
      color: var(--light);
      line-height: 1.9;
      font-weight: 300;
      margin-bottom: 14px;
    }
    .section-block p:last-child { margin-bottom: 0; }

    .section-block ul {
      list-style: none;
      margin: 14px 0;
      display: flex;
      flex-direction: column;
      gap: 9px;
    }
    .section-block ul li {
      font-size: 0.9rem;
      color: var(--light);
      line-height: 1.7;
      font-weight: 300;
      display: flex;
      align-items: flex-start;
      gap: 12px;
    }
    .section-block ul li::before {
      content: '';
      display: block;
      min-width: 4px; height: 4px;
      border-radius: 50%;
      background: var(--gold);
      margin-top: 8px;
      flex-shrink: 0;
    }

    .highlight-box {
      background: rgba(201,168,76,0.04);
      border: 1px solid rgba(201,168,76,0.18);
      border-left: 3px solid var(--gold);
      padding: 18px 22px;
      margin: 20px 0;
      font-size: 0.89rem;
      color: var(--light);
      line-height: 1.75;
      font-weight: 300;
    }

    /* DATA TABLE */
    .data-table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
      font-size: 0.88rem;
    }
    .data-table th {
      font-family: var(--font-mono);
      font-size: 0.62rem;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: var(--gold);
      padding: 12px 16px;
      text-align: left;
      background: var(--card);
      border: 1px solid var(--border);
    }
    .data-table td {
      padding: 12px 16px;
      color: var(--light);
      border: 1px solid var(--border);
      line-height: 1.6;
      font-weight: 300;
    }
    .data-table tr:nth-child(even) td { background: rgba(255,255,255,0.015); }

    /* FOOTER */
    footer {
      border-top: 1px solid var(--border);
      padding: 32px 80px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .footer-brand {
      font-family: var(--font-display);
      font-size: 1.05rem;
      color: var(--muted);
      letter-spacing: 0.05em;
    }
    .footer-links { display: flex; gap: 26px; }
    .footer-links a {
      font-family: var(--font-mono);
      font-size: 0.64rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      transition: color 0.2s;
    }
    .footer-links a:hover { color: var(--gold); }
    .footer-links a.active { color: var(--gold); }
    .footer-copy {
      font-family: var(--font-mono);
      font-size: 0.63rem;
      color: var(--muted);
      letter-spacing: 0.06em;
    }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(22px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .page-hero-inner > * { animation: fadeUp 0.7s ease both; }
    .page-eyebrow { animation-delay: 0.05s; }
    .page-title   { animation-delay: 0.15s; }
    .page-meta    { animation-delay: 0.25s; }

    @media (max-width: 768px) {
      .navbar { padding: 0 20px; }
      .page-hero-inner, .content-wrap { padding-left: 20px; padding-right: 20px; }
      footer { flex-direction: column; gap: 18px; padding: 24px 20px; text-align: center; }
      .footer-links { flex-wrap: wrap; justify-content: center; }
      .data-table { font-size: 0.78rem; }
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a href="/" class="nav-brand">
    <span class="brand-name">CineRent</span>
    <span class="brand-dot"></span>
  </a>
  <div class="nav-actions">
    <a href="/login" class="btn-nav-ghost">Sign In</a>
    <a href="/signup" class="btn-nav-fill">Get Started</a>
  </div>
</nav>

<!-- PAGE HERO -->
<div class="page-hero">
  <div class="page-hero-inner">
    <div class="page-eyebrow">Legal</div>
    <h1 class="page-title"><em>Privacy</em> Policy</h1>
    <p class="page-meta">Last updated: May 2026 &nbsp;·&nbsp; Effective immediately</p>
  </div>
</div>

<!-- CONTENT -->
<div class="content-wrap">

  <!-- TABLE OF CONTENTS -->
  <div class="toc">
    <div class="toc-label">Contents</div>
    <ol>
      <li><a href="#information">Information We Collect</a></li>
      <li><a href="#how-we-use">How We Use Your Information</a></li>
      <li><a href="#sharing">Information Sharing</a></li>
      <li><a href="#cookies">Cookies &amp; Tracking</a></li>
      <li><a href="#security">Data Security</a></li>
      <li><a href="#retention">Data Retention</a></li>
      <li><a href="#rights">Your Rights</a></li>
      <li><a href="#children">Children's Privacy</a></li>
      <li><a href="#contact">Contact Us</a></li>
    </ol>
  </div>

  <div class="highlight-box">
    Your privacy matters to us. This policy explains what personal data CineRent collects, why we collect it, and how we protect it. We do not sell your personal information to third parties.
  </div>

  <!-- SECTION 1 -->
  <div class="section-block" id="information">
    <div class="section-number">01 — Data Collection</div>
    <h2>Information We Collect</h2>
    <p>We collect information you provide directly to us and information generated automatically through your use of our platform.</p>

    <table class="data-table">
      <thead>
        <tr>
          <th>Category</th>
          <th>Examples</th>
          <th>When Collected</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Account Data</td>
          <td>Name, email, password (hashed)</td>
          <td>Registration</td>
        </tr>
        <tr>
          <td>Payment Data</td>
          <td>Transaction ID, rental amount</td>
          <td>At checkout</td>
        </tr>
        <tr>
          <td>Usage Data</td>
          <td>Movies viewed, watch history</td>
          <td>During use</td>
        </tr>
        <tr>
          <td>Device Data</td>
          <td>Browser type, IP address</td>
          <td>Automatically</td>
        </tr>
      </tbody>
    </table>

    <p>We do not store full credit card numbers. Payment processing is handled by secure third-party providers.</p>
  </div>

  <!-- SECTION 2 -->
  <div class="section-block" id="how-we-use">
    <div class="section-number">02 — Usage</div>
    <h2>How We Use Your Information</h2>
    <p>We use your information for the following purposes:</p>
    <ul>
      <li>To process rentals and manage your account</li>
      <li>To provide customer support and respond to inquiries</li>
      <li>To send transactional emails (receipts, rental confirmations)</li>
      <li>To improve our movie catalogue and platform features</li>
      <li>To detect and prevent fraudulent or unauthorized activity</li>
      <li>To comply with legal obligations</li>
    </ul>
    <p>We will only send marketing communications if you have opted in. You may unsubscribe at any time via the link in any email we send.</p>
  </div>

  <!-- SECTION 3 -->
  <div class="section-block" id="sharing">
    <div class="section-number">03 — Sharing</div>
    <h2>Information Sharing</h2>
    <p>We do not sell, trade, or rent your personal information to third parties. We may share your data only in the following limited circumstances:</p>
    <ul>
      <li><strong>Service Providers:</strong> Trusted vendors who assist in operating our platform (e.g., payment processors, email services), bound by confidentiality agreements</li>
      <li><strong>Legal Compliance:</strong> When required by law, court order, or governmental authority</li>
      <li><strong>Business Transfers:</strong> In the event of a merger or acquisition, your data may be transferred to the new entity</li>
      <li><strong>Safety:</strong> To protect the rights, property, or safety of CineRent, our users, or others</li>
    </ul>
  </div>

  <!-- SECTION 4 -->
  <div class="section-block" id="cookies">
    <div class="section-number">04 — Cookies</div>
    <h2>Cookies &amp; Tracking</h2>
    <p>CineRent uses cookies and similar technologies to maintain your session, remember your preferences, and analyse usage patterns.</p>
    <ul>
      <li><strong>Session Cookies:</strong> Essential for keeping you logged in during your visit</li>
      <li><strong>Preference Cookies:</strong> Store your settings and display preferences</li>
      <li><strong>Analytics Cookies:</strong> Help us understand how users interact with the platform</li>
    </ul>
    <p>You can control cookie behaviour through your browser settings. Note that disabling certain cookies may affect platform functionality.</p>
  </div>

  <!-- SECTION 5 -->
  <div class="section-block" id="security">
    <div class="section-number">05 — Security</div>
    <h2>Data Security</h2>
    <p>We implement industry-standard security measures to protect your personal information, including:</p>
    <ul>
      <li>HTTPS encryption for all data transmission</li>
      <li>Bcrypt hashing for stored passwords</li>
      <li>Regular security audits and vulnerability assessments</li>
      <li>Restricted employee access to personal data</li>
    </ul>
    <div class="highlight-box">
      While we strive to protect your data, no method of transmission over the internet is 100% secure. In the unlikely event of a data breach, we will notify affected users in accordance with applicable law.
    </div>
  </div>

  <!-- SECTION 6 -->
  <div class="section-block" id="retention">
    <div class="section-number">06 — Retention</div>
    <h2>Data Retention</h2>
    <p>We retain your personal information for as long as your account is active, or as long as needed to provide our services. After account deletion:</p>
    <ul>
      <li>Account data is deleted within 30 days</li>
      <li>Transaction records are retained for 7 years for legal and tax compliance</li>
      <li>Anonymised usage analytics may be kept indefinitely</li>
    </ul>
  </div>

  <!-- SECTION 7 -->
  <div class="section-block" id="rights">
    <div class="section-number">07 — Your Rights</div>
    <h2>Your Rights</h2>
    <p>You have the following rights regarding your personal data:</p>
    <ul>
      <li><strong>Access:</strong> Request a copy of the data we hold about you</li>
      <li><strong>Correction:</strong> Request correction of inaccurate information</li>
      <li><strong>Deletion:</strong> Request deletion of your account and associated data</li>
      <li><strong>Portability:</strong> Request your data in a machine-readable format</li>
      <li><strong>Objection:</strong> Object to certain uses of your data</li>
    </ul>
    <p>To exercise any of these rights, please contact us at privacy@cinerent.lk. We will respond within 30 days.</p>
  </div>

  <!-- SECTION 8 -->
  <div class="section-block" id="children">
    <div class="section-number">08 — Children</div>
    <h2>Children's Privacy</h2>
    <p>CineRent is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected such information, we will delete it promptly.</p>
    <p>Users between 13 and 17 years of age must have parental or guardian consent to create an account and use the platform.</p>
  </div>

  <!-- SECTION 9 -->
  <div class="section-block" id="contact">
    <div class="section-number">09 — Contact</div>
    <h2>Contact Us</h2>
    <p>If you have questions or concerns about this Privacy Policy or how we handle your data, please contact our Privacy team:</p>
    <ul>
      <li>Email: privacy@cinerent.lk</li>
      <li>Address: CineRent, Colombo, Sri Lanka</li>
      <li>Response time: Within 30 days</li>
    </ul>
  </div>

</div>

<!-- FOOTER -->
<footer>
  <div class="footer-brand">CineRent</div>
  <div class="footer-links">
    <a href="#">About</a>
    <a href="/terms">Terms</a>
    <a href="/privacy" class="active">Privacy</a>
    <a href="#">Contact</a>
    <a href="#">Help</a>
  </div>
  <div class="footer-copy">2026 CineRent. All rights reserved.</div>
</footer>

</body>
</html>

