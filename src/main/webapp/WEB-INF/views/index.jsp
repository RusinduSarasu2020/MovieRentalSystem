<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>CineRent — Movie Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
      overflow-x: hidden;
    }

    /* ── Animated BG ── */
    .bg-layer {
      position: fixed;
      inset: 0;
      z-index: 0;
      background:
        radial-gradient(ellipse at 15% 40%, rgba(238,9,121,0.18) 0%, transparent 55%),
        radial-gradient(ellipse at 85% 15%, rgba(255,106,0,0.14) 0%, transparent 50%),
        radial-gradient(ellipse at 50% 90%, rgba(48,43,99,0.6) 0%, transparent 60%),
        linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
      animation: bgPulse 10s ease-in-out infinite alternate;
    }
    @keyframes bgPulse {
      0%   { opacity: 1; }
      100% { opacity: 0.85; }
    }

    /* Floating particles */
    .particles { position: fixed; inset: 0; z-index: 0; pointer-events: none; }
    .particle {
      position: absolute;
      border-radius: 50%;
      background: rgba(238,9,121,0.15);
      animation: floatUp linear infinite;
    }
    @keyframes floatUp {
      0%   { transform: translateY(100vh) scale(0); opacity: 0; }
      10%  { opacity: 1; }
      90%  { opacity: 0.4; }
      100% { transform: translateY(-10vh) scale(1); opacity: 0; }
    }

    /* ── Navbar ── */
    .navbar {
      position: fixed;
      top: 0; left: 0; right: 0;
      z-index: 100;
      padding: 16px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: rgba(15,12,41,0.7);
      backdrop-filter: blur(16px);
      border-bottom: 1px solid rgba(255,255,255,0.06);
    }

    .nav-brand {
      font-size: 1.6rem;
      font-weight: 800;
      text-decoration: none;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: -0.5px;
    }

    .nav-links { display: flex; gap: 10px; align-items: center; }

    .nav-btn {
      padding: 8px 20px;
      border-radius: 20px;
      font-size: 0.88rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }

    .nav-btn-outline {
      border: 1.5px solid rgba(255,255,255,0.2);
      color: #c4b8e0;
      background: transparent;
    }
    .nav-btn-outline:hover {
      border-color: rgba(238,9,121,0.5);
      color: #fff;
      background: rgba(238,9,121,0.08);
    }

    .nav-btn-fill {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      border: none;
      box-shadow: 0 4px 16px rgba(238,9,121,0.35);
    }
    .nav-btn-fill:hover {
      transform: translateY(-1px);
      box-shadow: 0 8px 24px rgba(238,9,121,0.5);
      color: #fff;
    }

    /* ── Hero ── */
    .hero {
      position: relative;
      z-index: 1;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 120px 20px 80px;
    }

    .hero-badge {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: rgba(238,9,121,0.12);
      border: 1px solid rgba(238,9,121,0.25);
      border-radius: 20px;
      padding: 6px 16px;
      font-size: 0.82rem;
      color: #ff8ab5;
      margin-bottom: 28px;
      animation: fadeDown 0.6s ease both;
    }

    .hero-badge i { color: #ee0979; }

    .hero h1 {
      font-size: clamp(3rem, 8vw, 5.5rem);
      font-weight: 900;
      line-height: 1.05;
      margin-bottom: 20px;
      animation: fadeDown 0.7s ease 0.1s both;
    }

    .hero h1 .gradient-text {
      background: linear-gradient(90deg, #ff6a00, #ee0979, #c084fc);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .hero p.lead {
      font-size: 1.15rem;
      color: #a89fc8;
      max-width: 520px;
      line-height: 1.7;
      margin-bottom: 38px;
      animation: fadeDown 0.7s ease 0.2s both;
    }

    .hero-actions {
      display: flex;
      gap: 14px;
      flex-wrap: wrap;
      justify-content: center;
      margin-bottom: 60px;
      animation: fadeDown 0.7s ease 0.3s both;
    }

    .btn-glow {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: none;
      padding: 14px 36px;
      font-weight: 700;
      font-size: 1rem;
      border-radius: 30px;
      color: #fff;
      text-decoration: none;
      box-shadow: 0 8px 28px rgba(238,9,121,0.4);
      position: relative;
      overflow: hidden;
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-glow:hover {
      transform: translateY(-3px);
      box-shadow: 0 14px 40px rgba(238,9,121,0.55);
      color: #fff;
    }

    .btn-glow::after {
      content: '';
      position: absolute;
      top: 0; left: -100%;
      width: 100%; height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.18), transparent);
      transition: left 0.5s;
    }
    .btn-glow:hover::after { left: 100%; }

    .btn-ghost {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 13px 34px;
      font-weight: 700;
      font-size: 1rem;
      border-radius: 30px;
      color: #c4b8e0;
      text-decoration: none;
      border: 1.5px solid rgba(255,255,255,0.15);
      background: rgba(255,255,255,0.04);
      backdrop-filter: blur(6px);
      transition: all 0.2s;
    }
    .btn-ghost:hover {
      color: #fff;
      border-color: rgba(238,9,121,0.45);
      background: rgba(238,9,121,0.08);
      transform: translateY(-2px);
    }

    /* Stats strip */
    .stats-strip {
      display: flex;
      gap: 40px;
      flex-wrap: wrap;
      justify-content: center;
      animation: fadeDown 0.7s ease 0.4s both;
    }

    .stat-item { text-align: center; }
    .stat-num {
      font-size: 1.7rem;
      font-weight: 800;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .stat-label { font-size: 0.78rem; color: #6e658f; text-transform: uppercase; letter-spacing: 0.5px; }

    /* ── Features ── */
    .section {
      position: relative;
      z-index: 1;
      padding: 80px 20px;
    }

    .section-title {
      text-align: center;
      font-size: 2rem;
      font-weight: 800;
      margin-bottom: 10px;
    }

    .section-sub {
      text-align: center;
      color: #6e658f;
      font-size: 0.95rem;
      margin-bottom: 50px;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 24px;
      max-width: 1000px;
      margin: 0 auto;
    }

    .feature-card {
      background: rgba(26,23,64,0.7);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255,255,255,0.07);
      border-radius: 20px;
      padding: 30px 24px;
      text-align: center;
      transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
    }

    .feature-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 20px 50px rgba(238,9,121,0.15);
      border-color: rgba(238,9,121,0.25);
    }

    .feature-icon {
      width: 56px;
      height: 56px;
      border-radius: 16px;
      background: linear-gradient(135deg, #ff6a00, #ee0979);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.3rem;
      margin: 0 auto 16px;
      box-shadow: 0 6px 20px rgba(238,9,121,0.3);
    }

    .feature-card h5 {
      font-size: 1rem;
      font-weight: 700;
      margin-bottom: 8px;
    }

    .feature-card p {
      font-size: 0.85rem;
      color: #7a6fa0;
      line-height: 1.6;
    }

    /* ── Genre Chips ── */
    .genres-wrap {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      justify-content: center;
      max-width: 700px;
      margin: 0 auto;
    }

    .genre-chip {
      padding: 8px 20px;
      border-radius: 20px;
      border: 1.5px solid rgba(255,255,255,0.1);
      background: rgba(255,255,255,0.04);
      color: #a89fc8;
      font-size: 0.85rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }

    .genre-chip:hover {
      border-color: rgba(238,9,121,0.5);
      background: rgba(238,9,121,0.1);
      color: #fff;
      transform: translateY(-2px);
    }

    /* ── CTA Banner ── */
    .cta-banner {
      position: relative;
      z-index: 1;
      margin: 0 20px 80px;
      border-radius: 28px;
      padding: 60px 40px;
      text-align: center;
      background: linear-gradient(135deg, rgba(255,106,0,0.18), rgba(238,9,121,0.18));
      border: 1px solid rgba(238,9,121,0.2);
      backdrop-filter: blur(10px);
      overflow: hidden;
    }

    .cta-banner::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(ellipse at 50% 0%, rgba(238,9,121,0.2) 0%, transparent 70%);
    }

    .cta-banner h2 {
      font-size: 2.2rem;
      font-weight: 800;
      margin-bottom: 12px;
      position: relative;
    }

    .cta-banner p {
      color: #a89fc8;
      margin-bottom: 30px;
      position: relative;
    }

    /* ── Footer ── */
    footer {
      position: relative;
      z-index: 1;
      text-align: center;
      padding: 30px 20px;
      border-top: 1px solid rgba(255,255,255,0.06);
      color: #3d3660;
      font-size: 0.82rem;
    }

    footer a {
      color: #5a5280;
      text-decoration: none;
      margin: 0 8px;
      transition: color 0.2s;
    }
    footer a:hover { color: #ee0979; }

    @keyframes fadeDown {
      from { opacity: 0; transform: translateY(-20px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* Admin link */
    .admin-tiny {
      position: fixed;
      bottom: 20px;
      right: 24px;
      z-index: 100;
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 8px 16px;
      border-radius: 20px;
      background: rgba(255,193,7,0.1);
      border: 1px solid rgba(255,193,7,0.25);
      color: #ffc107;
      font-size: 0.8rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }
    .admin-tiny:hover {
      background: rgba(255,193,7,0.18);
      color: #ffc107;
    }
  </style>
</head>
<body>

<div class="bg-layer"></div>

<!-- Particles -->
<div class="particles" id="particles"></div>

<!-- Navbar -->
<nav class="navbar">
  <a href="/" class="nav-brand">🎬 CineRent</a>
  <div class="nav-links">
    <a href="/login"  class="nav-btn nav-btn-outline">Login</a>
    <a href="/signup" class="nav-btn nav-btn-fill">Sign Up Free</a>
  </div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hero-badge">
    <i class="fas fa-circle-play"></i> Now streaming in 4K
  </div>
  <h1>
    The Future of<br>
    <span class="gradient-text">Movie Rentals</span>
  </h1>
  <p class="lead">
    Rent blockbusters, stream instantly, and enjoy HD quality movies
    from the comfort of your home — anytime, anywhere.
  </p>
  <div class="hero-actions">
    <a href="/signup" class="btn-glow">
      <i class="fas fa-rocket"></i> Get Started Free
    </a>
    <a href="/login" class="btn-ghost">
      <i class="fas fa-sign-in-alt"></i> Sign In
    </a>
  </div>

  <div class="stats-strip">
    <div class="stat-item">
      <div class="stat-num">10K+</div>
      <div class="stat-label">Movies</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">4K</div>
      <div class="stat-label">Ultra HD</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">500K+</div>
      <div class="stat-label">Happy Users</div>
    </div>
    <div class="stat-item">
      <div class="stat-num">Rs 250</div>
      <div class="stat-label">Starting Price</div>
    </div>
  </div>
</section>

<!-- Features -->
<section class="section">
  <div class="section-title">Why Choose CineRent?</div>
  <div class="section-sub">Everything you need for the perfect movie night</div>
  <div class="features-grid">
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-film"></i></div>
      <h5>Massive Library</h5>
      <p>Thousands of movies across every genre — updated weekly.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-bolt"></i></div>
      <h5>Instant Access</h5>
      <p>Rent and start watching in seconds. No waiting, no downloads.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-tv"></i></div>
      <h5>HD & 4K Quality</h5>
      <p>Crystal-clear picture quality from 480p up to stunning 4K.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-shield-halved"></i></div>
      <h5>Secure Payments</h5>
      <p>Your transactions are fully encrypted and 100% safe.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-star"></i></div>
      <h5>Ratings & Reviews</h5>
      <p>Read honest reviews and ratings from our movie community.</p>
    </div>
    <div class="feature-card">
      <div class="feature-icon"><i class="fas fa-tag"></i></div>
      <h5>Best Prices</h5>
      <p>Affordable rentals starting at just Rs 99. No subscription needed.</p>
    </div>
  </div>
</section>

<!-- Genres -->
<section class="section" style="padding-top:0;">
  <div class="section-title">Browse by Genre</div>
  <div class="section-sub">What are you in the mood for?</div>
  <div class="genres-wrap">
    <a href="/login" class="genre-chip">🚀 Sci-Fi</a>
    <a href="/login" class="genre-chip">😱 Horror</a>
    <a href="/login" class="genre-chip">🎭 Drama</a>
    <a href="/login" class="genre-chip">😂 Comedy</a>
    <a href="/login" class="genre-chip">🎬 Thriller</a>
    <a href="/login" class="genre-chip">🏄 Adventure</a>
    <a href="/login" class="genre-chip">🔍 Crime</a>
    <a href="/login" class="genre-chip">👨‍👩‍👧 Family</a>
    <a href="/login" class="genre-chip">🧠 Psychological</a>
    <a href="/login" class="genre-chip">🎥 Documentary</a>
  </div>
</section>

<!-- CTA Banner -->
<div class="cta-banner">
  <h2>Ready to Watch?</h2>
  <p>Join hundreds of thousands of movie lovers on CineRent today.</p>
  <a href="/signup" class="btn-glow">
    <i class="fas fa-user-plus"></i> Create Free Account
  </a>
</div>

<!-- Footer -->
<footer>
  <div style="margin-bottom:10px;">
    <a href="#">About</a>
    <a href="#">Terms</a>
    <a href="#">Privacy</a>
    <a href="#">Contact</a>
  </div>
  © 2026 CineRent. All rights reserved.
</footer>

<!-- Admin shortcut -->
<a href="/admin/login" class="admin-tiny">
  <i class="fas fa-shield-halved"></i> Admin
</a>

<script>
  // Generate floating particles
  const container = document.getElementById('particles');
  for (let i = 0; i < 18; i++) {
    const p = document.createElement('div');
    p.className = 'particle';
    const size = Math.random() * 6 + 3;
    p.style.cssText = `
      width:${size}px; height:${size}px;
      left:${Math.random()*100}%;
      animation-duration:${Math.random()*12+8}s;
      animation-delay:${Math.random()*10}s;
      background: rgba(${Math.random()>0.5?'238,9,121':'255,106,0'},${Math.random()*0.2+0.05});
    `;
    container.appendChild(p);
  }
</script>

</body>
</html>
