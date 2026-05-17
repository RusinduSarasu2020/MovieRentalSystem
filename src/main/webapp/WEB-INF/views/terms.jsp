<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Terms of Service — CineRent</title>
  <meta name="description" content="Read CineRent's Terms of Service to understand the rules and guidelines for using our movie rental platform.">
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
    <h1 class="page-title">Terms of <em>Service</em></h1>
    <p class="page-meta">Last updated: May 2026 &nbsp;·&nbsp; Effective immediately</p>
  </div>
</div>

<!-- CONTENT -->
<div class="content-wrap">

  <!-- TABLE OF CONTENTS -->
  <div class="toc">
    <div class="toc-label">Contents</div>
    <ol>
      <li><a href="#acceptance">Acceptance of Terms</a></li>
      <li><a href="#account">Account Registration</a></li>
      <li><a href="#rentals">Rental Rules & Access</a></li>
      <li><a href="#payment">Payments & Refunds</a></li>
      <li><a href="#content">Content & Intellectual Property</a></li>
      <li><a href="#conduct">Prohibited Conduct</a></li>
      <li><a href="#liability">Limitation of Liability</a></li>
      <li><a href="#termination">Termination</a></li>
      <li><a href="#contact">Contact Us</a></li>
    </ol>
  </div>

  <div class="highlight-box">
    Please read these Terms of Service carefully before using the CineRent platform. By accessing or using our service, you agree to be bound by these terms. If you do not agree, please do not use our platform.
  </div>

  <!-- SECTION 1 -->
  <div class="section-block" id="acceptance">
    <div class="section-number">01 — Acceptance</div>
    <h2>Acceptance of Terms</h2>
    <p>By creating a CineRent account or accessing any part of our platform, you confirm that you are at least 18 years old (or have parental consent if between 13–17), and that you agree to be legally bound by these Terms of Service and our Privacy Policy.</p>
    <p>We reserve the right to modify these terms at any time. Continued use of the platform after changes have been posted constitutes your acceptance of the revised terms.</p>
  </div>

  <!-- SECTION 2 -->
  <div class="section-block" id="account">
    <div class="section-number">02 — Account</div>
    <h2>Account Registration</h2>
    <p>To use CineRent's rental services, you must create an account with accurate and complete information. You are responsible for:</p>
    <ul>
      <li>Maintaining the confidentiality of your login credentials</li>
      <li>All activity that occurs under your account</li>
      <li>Notifying us immediately of any unauthorized access</li>
      <li>Ensuring your contact information remains up to date</li>
    </ul>
    <p>CineRent reserves the right to suspend or terminate any account that is found to be in violation of these terms.</p>
  </div>

  <!-- SECTION 3 -->
  <div class="section-block" id="rentals">
    <div class="section-number">03 — Rentals</div>
    <h2>Rental Rules &amp; Access</h2>
    <p>When you rent a movie through CineRent, you are granted a limited, non-exclusive, non-transferable license to stream that title for personal, non-commercial use within the rental period.</p>
    <ul>
      <li>Rental periods are typically 48 hours from the time of payment</li>
      <li>Movies may only be streamed within the licensed territory</li>
      <li>You may not download, record, or redistribute any content</li>
      <li>Access is limited to one device session at a time</li>
    </ul>
    <p>CineRent does not guarantee the continuous availability of any specific title. Content may be removed from the platform at any time due to licensing changes.</p>
  </div>

  <!-- SECTION 4 -->
  <div class="section-block" id="payment">
    <div class="section-number">04 — Payment</div>
    <h2>Payments &amp; Refunds</h2>
    <p>All rental fees are charged in Sri Lankan Rupees (LKR) and are non-refundable once streaming has begun. Payment is processed securely at the time of rental confirmation.</p>
    <div class="highlight-box">
      Refunds may be issued at CineRent's discretion in cases of technical failure on our end that prevented you from watching a rented title. Please contact our support team within 24 hours of the incident.
    </div>
    <p>We are not responsible for additional fees charged by your bank or payment provider, including foreign transaction fees.</p>
  </div>

  <!-- SECTION 5 -->
  <div class="section-block" id="content">
    <div class="section-number">05 — Content</div>
    <h2>Content &amp; Intellectual Property</h2>
    <p>All movies, trailers, artwork, and other media available on CineRent are the property of their respective copyright holders and are licensed to CineRent for distribution. No content on the platform may be reproduced, distributed, or used for commercial purposes without explicit written permission.</p>
    <p>The CineRent name, logo, and platform design are trademarks of CineRent and may not be used without prior written consent.</p>
  </div>

  <!-- SECTION 6 -->
  <div class="section-block" id="conduct">
    <div class="section-number">06 — Conduct</div>
    <h2>Prohibited Conduct</h2>
    <p>You agree not to engage in any of the following activities while using CineRent:</p>
    <ul>
      <li>Circumventing geographic or device restrictions</li>
      <li>Screen recording, capturing, or redistributing rented content</li>
      <li>Using automated tools, bots, or scripts to access the platform</li>
      <li>Sharing your account credentials with others</li>
      <li>Attempting to hack, disrupt, or interfere with the platform</li>
      <li>Uploading malicious code or content</li>
    </ul>
    <p>Violation of these rules may result in immediate account termination and potential legal action.</p>
  </div>

  <!-- SECTION 7 -->
  <div class="section-block" id="liability">
    <div class="section-number">07 — Liability</div>
    <h2>Limitation of Liability</h2>
    <p>CineRent is provided "as is" without warranties of any kind, express or implied. To the maximum extent permitted by law, CineRent and its affiliates shall not be liable for any indirect, incidental, special, or consequential damages arising from your use of the platform.</p>
    <p>Our total liability to you for any claim shall not exceed the amount you paid for the specific rental that gave rise to the claim.</p>
  </div>

  <!-- SECTION 8 -->
  <div class="section-block" id="termination">
    <div class="section-number">08 — Termination</div>
    <h2>Termination</h2>
    <p>You may delete your CineRent account at any time from your account settings. Upon termination, your right to use the platform ceases immediately, and any active rentals will expire according to their original rental window.</p>
    <p>CineRent may suspend or terminate your account without notice if you breach these terms, engage in fraudulent activity, or for any other reason at our sole discretion.</p>
  </div>

  <!-- SECTION 9 -->
  <div class="section-block" id="contact">
    <div class="section-number">09 — Contact</div>
    <h2>Contact Us</h2>
    <p>If you have questions about these Terms of Service, please reach out to us:</p>
    <ul>
      <li>Email: legal@cinerent.lk</li>
      <li>Address: CineRent, Colombo, Sri Lanka</li>
      <li>Response time: Within 3 business days</li>
    </ul>
  </div>

</div>

<!-- FOOTER -->
<footer>
  <div class="footer-brand">CineRent</div>
  <div class="footer-links">
    <a href="#">About</a>
    <a href="/terms" class="active">Terms</a>
    <a href="/privacy">Privacy</a>
    <a href="#">Contact</a>
    <a href="#">Help</a>
  </div>
  <div class="footer-copy">2026 CineRent. All rights reserved.</div>
</footer>

</body>
</html>

