<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CineRent — Premium Movie Rentals</title>
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

    /* ─── NAVBAR ─── */
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

    .nav-brand {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .brand-name {
      font-family: var(--font-display);
      font-size: 1.55rem;
      font-weight: 600;
      color: var(--white);
      letter-spacing: 0.04em;
    }

    .brand-dot {
      width: 5px;
      height: 5px;
      border-radius: 50%;
      background: var(--gold);
    }

    .nav-center {
      display: flex;
      gap: 36px;
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
    }

    .nav-center a { transition: color 0.2s; }
    .nav-center a:hover { color: var(--gold); }

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

    /* ─── HERO ─── */
    .hero {
      min-height: 100vh;
      display: grid;
      grid-template-columns: 1fr 1fr;
      padding-top: 64px;
      border-bottom: 1px solid var(--border);
    }

    .hero-left {
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 80px 64px 80px 80px;
      border-right: 1px solid var(--border);
    }

    .hero-left::before {
      content: '';
      position: absolute;
      left: 40px; top: 20%; bottom: 20%;
      width: 1px;
      background: linear-gradient(to bottom, transparent, var(--gold), transparent);
      opacity: 0.35;
    }

    .hero-eyebrow {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 28px;
      display: flex;
      align-items: center;
      gap: 14px;
      animation: fadeUp 0.8s ease 0.1s both;
    }

    .hero-eyebrow::before {
      content: '';
      display: block;
      width: 32px; height: 1px;
      background: var(--gold);
      opacity: 0.6;
    }

    .hero-headline {
      font-family: var(--font-display);
      font-size: clamp(3.4rem, 5.5vw, 5.6rem);
      font-weight: 300;
      line-height: 1.0;
      letter-spacing: -0.5px;
      color: var(--white);
      margin-bottom: 28px;
      animation: fadeUp 0.8s ease 0.2s both;
    }

    .hero-headline strong { font-weight: 600; display: block; }
    .hero-headline em { font-style: italic; color: var(--gold); }

    .hero-sub {
      font-family: var(--font-display);
      font-size: 1.15rem;
      font-weight: 300;
      font-style: italic;
      color: var(--soft);
      line-height: 1.75;
      max-width: 400px;
      margin-bottom: 48px;
      animation: fadeUp 0.8s ease 0.3s both;
    }

    .hero-cta {
      display: flex;
      gap: 12px;
      animation: fadeUp 0.8s ease 0.4s both;
    }

    .btn-primary {
      display: inline-block;
      padding: 14px 38px;
      background: var(--gold);
      color: var(--black);
      font-family: var(--font-mono);
      font-size: 0.72rem;
      font-weight: 500;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      border: 1px solid var(--gold);
      transition: all 0.22s;
    }
    .btn-primary:hover { background: var(--gold2); border-color: var(--gold2); transform: translateY(-2px); }

    .btn-secondary {
      display: inline-block;
      padding: 14px 34px;
      background: transparent;
      color: var(--light);
      font-family: var(--font-mono);
      font-size: 0.72rem;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      border: 1px solid var(--border2);
      transition: all 0.22s;
    }
    .btn-secondary:hover { border-color: var(--soft); color: var(--white); }

    /* ─── HERO RIGHT ─── */
    .hero-right {
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: flex-end;
      padding: 60px 60px 60px 56px;
      background: radial-gradient(ellipse at 75% 20%, rgba(201,168,76,0.05) 0%, transparent 55%), var(--dark);
      overflow: hidden;
    }

    /* Reel circle decoration */
    .reel-deco {
      position: absolute;
      top: -80px; right: -80px;
      width: 380px; height: 380px;
      border-radius: 50%;
      border: 1px solid rgba(201,168,76,0.07);
      pointer-events: none;
      animation: spinSlow 50s linear infinite;
    }
    .reel-deco::before {
      content: '';
      position: absolute;
      inset: 24px;
      border-radius: 50%;
      border: 1px solid rgba(201,168,76,0.05);
    }
    .reel-deco::after {
      content: '';
      position: absolute;
      inset: 60px;
      border-radius: 50%;
      border: 1px solid rgba(201,168,76,0.03);
    }
    @keyframes spinSlow { to { transform: rotate(360deg); } }

    /* Film strip right edge */
    .filmstrip {
      position: absolute;
      right: 0; top: 0; bottom: 0;
      width: 26px;
      background: var(--border);
      display: flex;
      flex-direction: column;
      gap: 8px;
      padding: 10px 4px;
      overflow: hidden;
    }
    .filmstrip-hole {
      width: 18px; height: 11px;
      background: var(--black);
      border-radius: 2px;
      flex-shrink: 0;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1px;
      background: var(--border);
      border: 1px solid var(--border);
      margin-bottom: 44px;
      animation: fadeUp 0.8s ease 0.5s both;
    }

    .stat-cell {
      background: var(--card);
      padding: 26px 26px;
    }

    .stat-num {
      font-family: var(--font-display);
      font-size: 2.5rem;
      font-weight: 600;
      color: var(--gold);
      line-height: 1;
      letter-spacing: -1px;
      margin-bottom: 6px;
    }

    .stat-label {
      font-family: var(--font-mono);
      font-size: 0.64rem;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: var(--muted);
    }

    .genre-headline {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 12px;
      animation: fadeUp 0.8s ease 0.6s both;
    }

    .genre-row {
      display: flex;
      flex-wrap: wrap;
      gap: 7px;
      animation: fadeUp 0.8s ease 0.7s both;
    }

    .genre-tag {
      padding: 6px 14px;
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.07em;
      color: var(--soft);
      border: 1px solid var(--border2);
      background: rgba(255,255,255,0.02);
      transition: all 0.2s;
    }
    .genre-tag:hover { border-color: var(--gold); color: var(--gold); background: rgba(201,168,76,0.05); }

    /* ─── MARQUEE ─── */
    .divider-strip {
      border-top: 1px solid var(--border);
      border-bottom: 1px solid var(--border);
      overflow: hidden;
    }
    .marquee-track {
      display: flex;
      animation: marquee 26s linear infinite;
      white-space: nowrap;
    }
    .marquee-item {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      color: var(--muted);
      padding: 14px 30px;
      border-right: 1px solid var(--border);
      flex-shrink: 0;
    }
    .marquee-item span { color: var(--gold); margin-right: 8px; }
    @keyframes marquee {
      0%   { transform: translateX(0); }
      100% { transform: translateX(-50%); }
    }

    /* ─── FEATURES ─── */
    .section {
      padding: 100px 80px;
      border-top: 1px solid var(--border);
    }

    .section-header {
      display: flex;
      align-items: flex-end;
      justify-content: space-between;
      margin-bottom: 56px;
    }

    .section-label {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.16em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 14px;
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .section-label::before {
      content: '';
      display: block;
      width: 22px; height: 1px;
      background: var(--gold);
    }

    .section-title {
      font-family: var(--font-display);
      font-size: 2.9rem;
      font-weight: 300;
      line-height: 1.1;
    }
    .section-title em { font-style: italic; color: var(--gold); }

    .section-count {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      color: var(--muted);
      letter-spacing: 0.08em;
      padding-bottom: 4px;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 1px;
      background: var(--border);
      border: 1px solid var(--border);
    }

    .feature-card {
      background: var(--card);
      padding: 44px 38px;
      transition: background 0.25s;
      position: relative;
      overflow: hidden;
    }

    .feature-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0;
      height: 1px;
      background: var(--gold);
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 0.35s ease;
    }
    .feature-card:hover::before { transform: scaleX(1); }
    .feature-card:hover { background: #191919; }

    .feature-num {
      font-family: var(--font-display);
      font-size: 3.2rem;
      font-weight: 600;
      color: rgba(201,168,76,0.1);
      line-height: 1;
      margin-bottom: 22px;
      letter-spacing: -2px;
    }

    .feature-rule {
      width: 32px; height: 1px;
      background: var(--gold);
      margin-bottom: 18px;
      opacity: 0.45;
    }

    .feature-title {
      font-size: 1.0rem;
      font-weight: 600;
      color: var(--white);
      margin-bottom: 10px;
      letter-spacing: 0.01em;
    }

    .feature-desc {
      font-size: 0.86rem;
      color: var(--muted);
      line-height: 1.78;
      font-weight: 300;
    }

    /* ─── PRICING ─── */
    .pricing-band {
      border-top: 1px solid var(--border);
      background: radial-gradient(ellipse at 30% 50%, rgba(201,168,76,0.04) 0%, transparent 60%), var(--dark);
      padding: 100px 80px;
    }

    .pricing-inner {
      max-width: 920px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 80px;
      align-items: center;
    }

    .pricing-copy p {
      font-size: 0.88rem;
      color: var(--muted);
      line-height: 1.8;
      font-weight: 300;
      margin: 20px 0 36px;
    }

    .price-card {
      border: 1px solid var(--border2);
      background: var(--card);
      padding: 40px;
      position: relative;
    }

    .price-badge {
      position: absolute;
      top: -1px; right: 28px;
      font-family: var(--font-mono);
      font-size: 0.58rem;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      color: var(--black);
      background: var(--gold);
      padding: 4px 12px;
    }

    .price-header {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 20px;
      padding-bottom: 20px;
      border-bottom: 1px solid var(--border);
    }

    .price-amount {
      font-family: var(--font-display);
      font-size: 3.4rem;
      font-weight: 600;
      color: var(--gold);
      line-height: 1;
      margin-bottom: 4px;
    }

    .price-unit {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      color: var(--muted);
      letter-spacing: 0.08em;
      margin-bottom: 28px;
    }

    .price-features {
      list-style: none;
      margin-bottom: 32px;
    }

    .price-features li {
      font-size: 0.875rem;
      color: var(--light);
      padding: 9px 0;
      border-bottom: 1px solid var(--border);
      display: flex;
      align-items: center;
      gap: 12px;
      font-weight: 300;
    }
    .price-features li::before {
      content: '';
      display: block;
      width: 4px; height: 4px;
      border-radius: 50%;
      background: var(--gold);
      flex-shrink: 0;
    }

    .btn-block {
      display: block;
      width: 100%;
      text-align: center;
    }

    /* ─── CTA ─── */
    .cta-section {
      border-top: 1px solid var(--border);
      position: relative;
      overflow: hidden;
      padding: 110px 80px;
      text-align: center;
    }
    .cta-section::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(ellipse at 50% 0%, rgba(201,168,76,0.07) 0%, transparent 60%);
      pointer-events: none;
    }
    .cta-section::after {
      content: '';
      position: absolute;
      left: 0; right: 0; top: 0;
      height: 1px;
      background: linear-gradient(90deg, transparent, var(--gold), transparent);
      opacity: 0.25;
    }

    .cta-label {
      font-family: var(--font-mono);
      font-size: 0.67rem;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 22px;
    }

    .cta-title {
      font-family: var(--font-display);
      font-size: clamp(2.8rem, 5vw, 5rem);
      font-weight: 300;
      line-height: 1.05;
      margin-bottom: 20px;
    }
    .cta-title em { font-style: italic; color: var(--gold); }

    .cta-sub {
      font-size: 0.93rem;
      color: var(--muted);
      max-width: 400px;
      margin: 0 auto 44px;
      line-height: 1.8;
      font-weight: 300;
    }

    .cta-buttons {
      display: flex;
      gap: 12px;
      justify-content: center;
    }

    /* ─── FOOTER ─── */
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

    .footer-links {
      display: flex;
      gap: 26px;
    }
    .footer-links a {
      font-family: var(--font-mono);
      font-size: 0.64rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      transition: color 0.2s;
    }
    .footer-links a:hover { color: var(--gold); }

    .footer-copy {
      font-family: var(--font-mono);
      font-size: 0.63rem;
      color: var(--muted);
      letter-spacing: 0.06em;
    }

    /* Admin */
    .admin-link {
      position: fixed;
      bottom: 22px; right: 26px;
      z-index: 100;
      font-family: var(--font-mono);
      font-size: 0.62rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--muted);
      border: 1px solid var(--border2);
      padding: 7px 16px;
      background: rgba(10,10,10,0.92);
      backdrop-filter: blur(10px);
      transition: all 0.2s;
    }
    .admin-link:hover { color: var(--gold); border-color: var(--gold); }

    /* ─── ANIMATIONS ─── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(26px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .reveal {
      opacity: 0;
      transform: translateY(22px);
      transition: opacity 0.7s ease, transform 0.7s ease;
    }
    .reveal.visible { opacity: 1; transform: translateY(0); }

    /* ─── RESPONSIVE ─── */
    @media (max-width: 960px) {
      .hero { grid-template-columns: 1fr; }
      .hero-left { padding: 60px 36px; }
      .hero-left::before { display: none; }
      .hero-right { padding: 48px 36px; border-top: 1px solid var(--border); }
      .navbar { padding: 0 24px; }
      .nav-center { display: none; }
      .section { padding: 70px 32px; }
      .features-grid { grid-template-columns: 1fr; }
      .pricing-inner { grid-template-columns: 1fr; gap: 48px; }
      .pricing-band, .cta-section { padding: 70px 32px; }
      footer { flex-direction: column; gap: 18px; padding: 28px 32px; text-align: center; }
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

  <div class="nav-center">
    <a href="/login">Browse</a>
    <a href="/login">New Releases</a>
    <a href="/login">Top Rated</a>
    <a href="/login">Genres</a>
  </div>

  <div class="nav-actions">
    <a href="/login" class="btn-nav-ghost">Sign In</a>
    <a href="/signup" class="btn-nav-fill">Get Started</a>
  </div>
</nav>

<!-- HERO -->
<section class="hero">

  <div class="hero-left">
    <div class="hero-eyebrow">Premium Cinema Experience</div>

    <h1 class="hero-headline">
      <strong>Rent. Watch.</strong>
      <em>Fall in Love</em><br>
      with Film.
    </h1>

    <p class="hero-sub">
      A curated library of over ten thousand titles — from timeless
      classics to the latest releases — delivered instantly to your
      screen in stunning 4K.
    </p>

    <div class="hero-cta">
      <a href="/signup" class="btn-primary">Start Watching</a>
      <a href="/login" class="btn-secondary">Sign In</a>
    </div>
  </div>

  <div class="hero-right">
    <div class="reel-deco"></div>

    <div class="filmstrip">
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
      <div class="filmstrip-hole"></div><div class="filmstrip-hole"></div>
    </div>

    <div class="stats-grid">
      <div class="stat-cell">
        <div class="stat-num">10K+</div>
        <div class="stat-label">Titles Available</div>
      </div>
      <div class="stat-cell">
        <div class="stat-num">4K</div>
        <div class="stat-label">Ultra HD Quality</div>
      </div>
      <div class="stat-cell">
        <div class="stat-num">500K</div>
        <div class="stat-label">Active Members</div>
      </div>
      <div class="stat-cell">
        <div class="stat-num">Rs 250</div>
        <div class="stat-label">Starting Price</div>
      </div>
    </div>

    <div class="genre-headline">Browse by genre</div>
    <div class="genre-row">
      <a href="/login" class="genre-tag">Sci-Fi</a>
      <a href="/login" class="genre-tag">Horror</a>
      <a href="/login" class="genre-tag">Drama</a>
      <a href="/login" class="genre-tag">Comedy</a>
      <a href="/login" class="genre-tag">Thriller</a>
      <a href="/login" class="genre-tag">Adventure</a>
      <a href="/login" class="genre-tag">Crime</a>
      <a href="/login" class="genre-tag">Documentary</a>
      <a href="/login" class="genre-tag">Psychological</a>
      <a href="/login" class="genre-tag">Family</a>
    </div>
  </div>

</section>

<!-- MARQUEE -->
<div class="divider-strip">
  <div class="marquee-track">
    <span class="marquee-item"><span>/</span>Instant Streaming</span>
    <span class="marquee-item"><span>/</span>HD &amp; 4K Quality</span>
    <span class="marquee-item"><span>/</span>10,000+ Titles</span>
    <span class="marquee-item"><span>/</span>No Subscription Required</span>
    <span class="marquee-item"><span>/</span>Secure Payments</span>
    <span class="marquee-item"><span>/</span>Rent in Seconds</span>
    <span class="marquee-item"><span>/</span>New Releases Weekly</span>
    <span class="marquee-item"><span>/</span>Starting Rs 250</span>
    <span class="marquee-item"><span>/</span>Instant Streaming</span>
    <span class="marquee-item"><span>/</span>HD &amp; 4K Quality</span>
    <span class="marquee-item"><span>/</span>10,000+ Titles</span>
    <span class="marquee-item"><span>/</span>No Subscription Required</span>
    <span class="marquee-item"><span>/</span>Secure Payments</span>
    <span class="marquee-item"><span>/</span>Rent in Seconds</span>
    <span class="marquee-item"><span>/</span>New Releases Weekly</span>
    <span class="marquee-item"><span>/</span>Starting Rs 250</span>
  </div>
</div>

<!-- FEATURES -->
<section class="section">
  <div class="section-header reveal">
    <div>
      <div class="section-label">Why CineRent</div>
      <h2 class="section-title">Built for <em>serious</em><br>film lovers</h2>
    </div>
    <div class="section-count">06 features</div>
  </div>

  <div class="features-grid">
    <div class="feature-card reveal">
      <div class="feature-num">01</div>
      <div class="feature-rule"></div>
      <div class="feature-title">Massive Library</div>
      <p class="feature-desc">Over ten thousand titles spanning every genre, era, and language. Our catalogue grows every week with content curated by genuine cinema enthusiasts.</p>
    </div>
    <div class="feature-card reveal" style="transition-delay:0.08s">
      <div class="feature-num">02</div>
      <div class="feature-rule"></div>
      <div class="feature-title">Instant Access</div>
      <p class="feature-desc">Rent a title and begin watching in under thirty seconds. No waiting rooms, no queues, no pre-downloads required — just press play.</p>
    </div>
    <div class="feature-card reveal" style="transition-delay:0.16s">
      <div class="feature-num">03</div>
      <div class="feature-rule"></div>
      <div class="feature-title">HD &amp; 4K Streaming</div>
      <p class="feature-desc">Crystal-clear playback from 720p to cinema-grade 4K Ultra HD. Adaptive bitrate ensures smooth streaming on any connection speed.</p>
    </div>
    <div class="feature-card reveal">
      <div class="feature-num">04</div>
      <div class="feature-rule"></div>
      <div class="feature-title">Secure Payments</div>
      <p class="feature-desc">Every transaction is protected by bank-grade encryption. Your payment data is never stored — complete peace of mind with every rental.</p>
    </div>
    <div class="feature-card reveal" style="transition-delay:0.08s">
      <div class="feature-num">05</div>
      <div class="feature-rule"></div>
      <div class="feature-title">Ratings &amp; Reviews</div>
      <p class="feature-desc">Genuine reviews from our half-million member community help you choose your next film. No bots, no paid placements, no sponsored rankings.</p>
    </div>
    <div class="feature-card reveal" style="transition-delay:0.16s">
      <div class="feature-num">06</div>
      <div class="feature-rule"></div>
      <div class="feature-title">Affordable Pricing</div>
      <p class="feature-desc">Rentals from as low as Rs 250 with no monthly commitment. Pay only for what you watch, when you watch it — on your terms.</p>
    </div>
  </div>
</section>

<!-- PRICING -->
<div class="pricing-band">
  <div class="pricing-inner">
    <div class="pricing-copy reveal">
      <div class="section-label">Pricing</div>
      <h2 class="section-title">Simple,<br><em>honest</em> pricing</h2>
      <p>No hidden fees, no recurring charges. Choose a film, pay once, enjoy it for 48 hours. That is all there is to it.</p>
      <a href="/signup" class="btn-primary">Create Free Account</a>
    </div>

    <div class="price-card reveal">
      <div class="price-badge">Most Popular</div>
      <div class="price-header">Standard Rental</div>
      <div class="price-amount">Rs 250</div>
      <div class="price-unit">per title / 48-hour access</div>
      <ul class="price-features">
        <li>Full HD streaming up to 1080p</li>
        <li>48-hour rental window</li>
        <li>Watch on any device</li>
        <li>Pause and resume anytime</li>
        <li>No subscription required</li>
      </ul>
      <a href="/signup" class="btn-primary btn-block">Rent a Movie Now</a>
    </div>
  </div>
</div>

<!-- CTA -->
<section class="cta-section">
  <div class="cta-label reveal">Join the Community</div>
  <h2 class="cta-title reveal">
    Your next great<br><em>film experience</em><br>awaits.
  </h2>
  <p class="cta-sub reveal">
    Over 500,000 movie lovers already call CineRent home.
    Create your free account in under a minute and start watching tonight.
  </p>
  <div class="cta-buttons reveal">
    <a href="/signup" class="btn-primary">Create Free Account</a>
    <a href="/login" class="btn-secondary">Browse the Library</a>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-brand">CineRent</div>
  <div class="footer-links">
    <a href="#">About</a>
    <a href="#">Terms</a>
    <a href="#">Privacy</a>
    <a href="#">Contact</a>
    <a href="#">Help</a>
  </div>
  <div class="footer-copy">2026 CineRent. All rights reserved.</div>
</footer>

<!-- Admin -->
<a href="/admin/login" class="admin-link">Admin Panel</a>

<script>
  // Scroll reveal
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        observer.unobserve(e.target);
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
</script>

</body>
</html>
