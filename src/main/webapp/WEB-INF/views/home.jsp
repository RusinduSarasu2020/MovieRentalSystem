<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CineRent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
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
      --red: #c0392b;
      --green: #27ae60;
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

    .nav-center {
      display: flex;
      align-items: center;
      gap: 32px;
    }
    .nav-link {
      font-size: 13px;
      font-weight: 500;
      color: var(--muted);
      text-decoration: none;
      letter-spacing: 0.4px;
      text-transform: uppercase;
      transition: color 0.2s;
    }
    .nav-link:hover { color: var(--cream); }
    .nav-link.active { color: var(--gold); }

    .nav-right {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .nav-user {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: 13px;
      color: var(--muted);
    }
    .avatar {
      width: 30px; height: 30px;
      border-radius: 50%;
      background: var(--ink-3);
      border: 1px solid var(--gold);
      display: flex; align-items: center; justify-content: center;
      font-family: 'Playfair Display', serif;
      font-size: 12px;
      font-weight: 700;
      color: var(--gold);
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
    }
    .btn-ghost:hover {
      border-color: rgba(200,169,110,0.4);
      color: var(--gold);
      background: rgba(200,169,110,0.05);
    }

    .btn-gold {
      padding: 7px 20px;
      border: 1px solid var(--gold);
      border-radius: 100px;
      background: transparent;
      color: var(--gold);
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 500;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      text-decoration: none;
      cursor: pointer;
      transition: all 0.2s;
    }
    .btn-gold:hover {
      background: var(--gold);
      color: var(--ink);
    }

    /* ── HERO ── */
    .hero {
      position: relative;
      padding: 80px 48px 60px;
      overflow: hidden;
      border-bottom: 1px solid var(--wire);
    }

    .hero-bg {
      position: absolute;
      inset: 0;
      background:
        radial-gradient(ellipse 60% 80% at 80% 50%, rgba(200,169,110,0.05) 0%, transparent 60%),
        radial-gradient(ellipse 50% 60% at 20% 80%, rgba(100,60,180,0.04) 0%, transparent 60%);
    }

    .hero-lines {
      position: absolute;
      right: 0; top: 0; bottom: 0;
      width: 40%;
      background-image: repeating-linear-gradient(
        0deg,
        var(--wire-2) 0px,
        var(--wire-2) 1px,
        transparent 1px,
        transparent 40px
      );
      mask-image: linear-gradient(to left, rgba(0,0,0,0.5), transparent);
    }

    .hero-inner {
      position: relative;
      max-width: 680px;
    }

    .hero-label {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 24px;
    }
    .hero-label::before {
      content: '';
      display: block;
      width: 28px;
      height: 1px;
      background: var(--gold);
    }

    .hero-title {
      font-family: 'Playfair Display', serif;
      font-size: clamp(36px, 5vw, 56px);
      font-weight: 900;
      line-height: 1.05;
      color: var(--cream);
      letter-spacing: -1px;
      margin-bottom: 20px;
    }
    .hero-title em {
      font-style: italic;
      color: var(--gold);
    }

    .hero-sub {
      font-size: 15px;
      font-weight: 300;
      color: var(--muted);
      letter-spacing: 0.2px;
      max-width: 460px;
      line-height: 1.7;
    }

    .hero-stats {
      display: flex;
      gap: 40px;
      margin-top: 40px;
    }
    .hero-stat-num {
      font-family: 'Playfair Display', serif;
      font-size: 28px;
      font-weight: 700;
      color: var(--cream);
      line-height: 1;
      margin-bottom: 4px;
    }
    .hero-stat-num span { color: var(--gold); font-size: 18px; }
    .hero-stat-lbl {
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: 1.5px;
      color: var(--muted);
    }

    /* ── FILTER STRIP ── */
    .filter-strip {
      position: sticky;
      top: 62px;
      z-index: 150;
      background: rgba(17,17,24,0.92);
      backdrop-filter: blur(16px);
      border-bottom: 1px solid var(--wire);
      padding: 14px 48px;
    }

    .filter-row {
      display: flex;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
    }

    .filter-search {
      position: relative;
      flex: 2;
      min-width: 200px;
    }
    .filter-search svg {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--muted-2);
      width: 15px; height: 15px;
      pointer-events: none;
    }

    .f-input, .f-select {
      width: 100%;
      height: 40px;
      background: var(--ink-3);
      border: 1px solid var(--wire);
      border-radius: var(--r);
      color: var(--cream);
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      transition: border-color 0.2s, background 0.2s;
      appearance: none;
    }
    .f-input { padding: 0 12px 0 38px; }
    .f-select { padding: 0 32px 0 12px; flex: 1; min-width: 120px; }
    .f-input::placeholder { color: var(--muted-2); }
    .f-input:focus, .f-select:focus {
      outline: none;
      border-color: rgba(200,169,110,0.45);
      background: var(--ink-2);
    }
    .f-select option { background: var(--ink-2); color: var(--cream); }

    .select-wrap {
      position: relative;
      flex: 1;
      min-width: 120px;
    }
    .select-wrap svg {
      position: absolute;
      right: 10px; top: 50%;
      transform: translateY(-50%);
      pointer-events: none;
      color: var(--muted);
      width: 12px; height: 12px;
    }

    .f-num {
      width: 100%;
      height: 40px;
      background: var(--ink-3);
      border: 1px solid var(--wire);
      border-radius: var(--r);
      color: var(--cream);
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      padding: 0 12px;
      transition: border-color 0.2s;
    }
    .f-num::placeholder { color: var(--muted-2); }
    .f-num:focus { outline: none; border-color: rgba(200,169,110,0.45); }
    .f-num-wrap { flex: 0.7; min-width: 100px; }

    .btn-search {
      height: 40px;
      padding: 0 24px;
      border: none;
      border-radius: var(--r);
      background: var(--gold);
      color: var(--ink);
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      font-weight: 600;
      letter-spacing: 0.3px;
      cursor: pointer;
      white-space: nowrap;
      transition: background 0.2s, transform 0.15s;
    }
    .btn-search:hover { background: var(--gold-pale); transform: translateY(-1px); }
    .btn-search:active { transform: translateY(0); }

    .btn-clear {
      height: 40px;
      padding: 0 14px;
      border: 1px solid var(--wire);
      border-radius: var(--r);
      background: transparent;
      color: var(--muted);
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      transition: all 0.2s;
    }
    .btn-clear:hover { color: var(--cream); border-color: rgba(255,255,255,0.15); }

    /* ── GENRE TABS ── */
    .genre-row {
      background: var(--ink-2);
      border-bottom: 1px solid var(--wire);
      padding: 0 48px;
      overflow-x: auto;
      scrollbar-width: none;
      display: flex;
      gap: 0;
    }
    .genre-row::-webkit-scrollbar { display: none; }

    .gtab {
      padding: 14px 20px;
      font-size: 12px;
      font-weight: 500;
      letter-spacing: 0.6px;
      text-transform: uppercase;
      color: var(--muted);
      text-decoration: none;
      white-space: nowrap;
      border-bottom: 2px solid transparent;
      transition: color 0.2s, border-color 0.2s;
    }
    .gtab:hover { color: var(--cream); }
    .gtab.active { color: var(--gold); border-bottom-color: var(--gold); }

    /* ── MAIN ── */
    .main {
      max-width: 1360px;
      margin: 0 auto;
      padding: 36px 48px 80px;
    }

    .results-bar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
    }

    .results-heading {
      font-family: 'Playfair Display', serif;
      font-size: 20px;
      font-weight: 700;
      color: var(--cream);
    }
    .results-count {
      font-size: 12px;
      color: var(--muted);
      margin-top: 2px;
      letter-spacing: 0.3px;
    }

    .sort-wrap {
      position: relative;
    }
    .sort-wrap svg {
      position: absolute;
      right: 10px; top: 50%;
      transform: translateY(-50%);
      pointer-events: none;
      color: var(--muted);
      width: 12px; height: 12px;
    }
    .sort-select {
      height: 36px;
      padding: 0 32px 0 12px;
      background: var(--ink-3);
      border: 1px solid var(--wire);
      border-radius: var(--r);
      color: var(--muted);
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      appearance: none;
      cursor: pointer;
      transition: border-color 0.2s;
    }
    .sort-select:focus { outline: none; border-color: rgba(200,169,110,0.4); color: var(--cream); }
    .sort-select option { background: var(--ink-2); }

    /* ── GRID ── */
    .movies-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 20px;
    }

    /* ── CARD ── */
    .card {
      background: var(--ink-2);
      border: 1px solid var(--wire);
      border-radius: var(--r-lg);
      overflow: hidden;
      transition: transform 0.32s cubic-bezier(.22,.68,0,1.2), border-color 0.28s, box-shadow 0.32s;
      position: relative;
    }
    .card:hover {
      transform: translateY(-6px);
      border-color: rgba(200,169,110,0.22);
      box-shadow: 0 24px 64px rgba(0,0,0,0.6), 0 0 0 1px rgba(200,169,110,0.1);
    }

    .poster-wrap {
      position: relative;
      overflow: hidden;
      height: 290px;
    }
    .poster {
      width: 100%; height: 100%;
      object-fit: cover;
      display: block;
      transition: transform 0.4s ease, filter 0.3s;
    }
    .card:hover .poster {
      transform: scale(1.06);
      filter: brightness(0.6);
    }

    /* scrim at bottom of poster */
    .poster-scrim {
      position: absolute;
      inset: 0;
      background: linear-gradient(
        to top,
        rgba(10,10,15,1) 0%,
        rgba(10,10,15,0.4) 40%,
        transparent 70%
      );
      opacity: 0.7;
      transition: opacity 0.3s;
    }
    .card:hover .poster-scrim { opacity: 1; }

    /* Hover CTA */
    .poster-cta {
      position: absolute;
      inset: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.25s;
    }
    .card:hover .poster-cta { opacity: 1; }

    .cta-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 11px 26px;
      border-radius: 100px;
      background: var(--gold);
      color: var(--ink);
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      text-decoration: none;
      transform: translateY(6px);
      transition: transform 0.3s cubic-bezier(.22,.68,0,1.2);
    }
    .card:hover .cta-btn { transform: translateY(0); }
    .cta-btn:hover { background: var(--gold-pale); }

    /* quality badge */
    .q-badge {
      position: absolute;
      top: 12px;
      left: 12px;
      padding: 3px 8px;
      border-radius: 4px;
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 0.8px;
      text-transform: uppercase;
    }
    .q-4K   { background: var(--gold); color: var(--ink); }
    .q-1080p { background: rgba(88,100,255,0.85); color: #c0c4ff; }
    .q-720p  { background: rgba(30,160,110,0.75); color: #a0e8cc; }
    .q-480p  { background: rgba(80,80,80,0.7);    color: #bbb; }

    /* availability dot */
    .avail-dot {
      position: absolute;
      top: 14px; right: 14px;
      width: 8px; height: 8px;
      border-radius: 50%;
      border: 1.5px solid rgba(10,10,15,0.8);
    }
    .avail-yes { background: var(--green); }
    .avail-no  { background: var(--red); }

    /* card body */
    .card-body {
      padding: 14px 16px 18px;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 15px;
      font-weight: 700;
      color: var(--cream);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      margin-bottom: 5px;
      line-height: 1.2;
    }

    .card-meta {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 11px;
      color: var(--muted);
      letter-spacing: 0.3px;
      margin-bottom: 8px;
    }
    .card-meta .sep { color: var(--muted-2); }

    .card-rating {
      display: flex;
      align-items: center;
      gap: 4px;
      font-size: 12px;
      color: var(--gold);
      font-weight: 600;
      margin-bottom: 12px;
    }
    .card-rating svg { width: 12px; height: 12px; fill: var(--gold); }

    .card-footer {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 12px;
    }
    .price {
      font-family: 'Playfair Display', serif;
      font-size: 18px;
      font-weight: 700;
      color: var(--gold);
    }
    .price-label {
      font-size: 10px;
      color: var(--muted);
      letter-spacing: 0.5px;
      text-transform: uppercase;
      margin-top: 1px;
    }
    .avail-label {
      font-size: 11px;
      font-weight: 500;
    }
    .avail-label.yes { color: var(--green); }
    .avail-label.no  { color: var(--red); }

    .rent-btn {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      width: 100%;
      height: 38px;
      border: 1px solid rgba(200,169,110,0.3);
      border-radius: var(--r);
      background: transparent;
      color: var(--gold);
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      text-decoration: none;
      transition: all 0.2s;
    }
    .rent-btn:hover {
      background: var(--gold);
      color: var(--ink);
      border-color: var(--gold);
    }
    .rent-btn svg { width: 13px; height: 13px; }

    /* divider line in card */
    .card-divider {
      height: 1px;
      background: var(--wire);
      margin: 10px 0;
    }

    /* ── EMPTY STATE ── */
    .empty {
      grid-column: 1 / -1;
      text-align: center;
      padding: 100px 20px;
    }
    .empty-icon {
      width: 64px; height: 64px;
      margin: 0 auto 20px;
      opacity: 0.15;
    }
    .empty h4 {
      font-family: 'Playfair Display', serif;
      font-size: 20px;
      color: var(--cream);
      margin-bottom: 8px;
      font-weight: 700;
    }
    .empty p { font-size: 13px; color: var(--muted); }
    .empty a { color: var(--gold); text-decoration: none; }
    .empty a:hover { text-decoration: underline; }

    /* ── SCROLLBAR ── */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: var(--ink); }
    ::-webkit-scrollbar-thumb { background: var(--muted-2); border-radius: 3px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--gold); }

    /* ── STAGGERED CARD ANIMATION ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(18px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .card {
      animation: fadeUp 0.4s ease both;
    }
    .card:nth-child(1)  { animation-delay: 0.04s; }
    .card:nth-child(2)  { animation-delay: 0.08s; }
    .card:nth-child(3)  { animation-delay: 0.12s; }
    .card:nth-child(4)  { animation-delay: 0.16s; }
    .card:nth-child(5)  { animation-delay: 0.20s; }
    .card:nth-child(6)  { animation-delay: 0.24s; }
    .card:nth-child(7)  { animation-delay: 0.28s; }
    .card:nth-child(8)  { animation-delay: 0.32s; }
    .card:nth-child(9)  { animation-delay: 0.36s; }
    .card:nth-child(10) { animation-delay: 0.40s; }

    @media (max-width: 768px) {
      .navbar, .filter-strip, .genre-row, .hero, .main { padding-left: 20px; padding-right: 20px; }
      .nav-center { display: none; }
      .hero-stats { gap: 24px; }
      .movies-grid { grid-template-columns: repeat(auto-fill, minmax(155px, 1fr)); gap: 14px; }
      .poster-wrap { height: 240px; }
    }
  </style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
  <a href="/home" class="brand">
    <span class="brand-cine">Cine</span>
    <div class="brand-dot"></div>
    <span class="brand-rent">Rent</span>
  </a>

  <div class="nav-center">
    <a href="/home" class="nav-link active">Browse</a>
    <a href="/my-rentals" class="nav-link">My Rentals</a>
    <a href="/new-releases" class="nav-link">New Releases</a>
  </div>

  <div class="nav-right">
    <div class="nav-user">
      <div class="avatar">
        ${not empty sessionScope.username ? sessionScope.username.substring(0,1).toUpperCase() : 'U'}
      </div>
      <span style="color:#9898a8; font-size:13px;">${not empty sessionScope.username ? sessionScope.username : 'Guest'}</span>
    </div>
    <a href="/my-rentals" class="btn-ghost">My Rentals</a>
    <a href="/logout" class="btn-gold">Sign Out</a>
  </div>
</nav>

<!-- ── HERO ── -->
<section class="hero">
  <div class="hero-bg"></div>
  <div class="hero-lines"></div>
  <div class="hero-inner">
    <div class="hero-label">Premium Film Library</div>
    <h1 class="hero-title">
      Cinema, curated<br>for <em>your evening.</em>
    </h1>
    <p class="hero-sub">Thousands of titles spanning every genre — from pulse-racing thrillers to quiet documentaries. Rent in moments, watch tonight.</p>
    <div class="hero-stats">
      <div>
        <div class="hero-stat-num">4K<span>+</span></div>
        <div class="hero-stat-lbl">Titles Available</div>
      </div>
      <div>
        <div class="hero-stat-num">4<span>K</span></div>
        <div class="hero-stat-lbl">Ultra HD Quality</div>
      </div>
      <div>
        <div class="hero-stat-num">24<span>h</span></div>
        <div class="hero-stat-lbl">Rental Window</div>
      </div>
    </div>
  </div>
</section>

<!-- ── FILTER STRIP ── -->
<div class="filter-strip">
  <form class="filter-row" method="get" action="/home">
    <div class="filter-search">
      <svg viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
        <circle cx="9" cy="9" r="6"/><path d="M15 15l3 3"/>
      </svg>
      <input class="f-input" name="q" placeholder="Search title or keyword..." value="${param.q}" autocomplete="off">
    </div>

    <div class="select-wrap">
      <select class="f-select" name="genre">
        <option value="">All Genres</option>
        <c:forEach var="g" items="${['Scifi','Horror','Documentary','Family','Child','Comedy','Adventure','Crime','Thriller','Psychological']}">
          <option <c:if test="${param.genre == g}">selected</c:if>>${g}</option>
        </c:forEach>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 4l4 4 4-4"/></svg>
    </div>

    <div class="select-wrap">
      <select class="f-select" name="quality">
        <option value="">Any Quality</option>
        <option <c:if test="${param.quality == '480p'}">selected</c:if> value="480p">480p SD</option>
        <option <c:if test="${param.quality == '720p'}">selected</c:if> value="720p">720p HD</option>
        <option <c:if test="${param.quality == '1080p'}">selected</c:if> value="1080p">1080p Full HD</option>
        <option <c:if test="${param.quality == '4K'}">selected</c:if> value="4K">4K Ultra HD</option>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 4l4 4 4-4"/></svg>
    </div>

    <div class="f-num-wrap">
      <input class="f-num" name="minRating" type="number" step="0.1" min="0" max="10" placeholder="Min rating" value="${param.minRating}">
    </div>

    <div class="f-num-wrap">
      <input class="f-num" name="maxDuration" type="number" placeholder="Max minutes" value="${param.maxDuration}">
    </div>

    <button type="submit" class="btn-search">Search</button>
    <a href="/home" class="btn-clear">
      <svg width="13" height="13" viewBox="0 0 13 13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M1 1l11 11M12 1L1 12"/></svg>
    </a>
  </form>
</div>

<!-- ── GENRE TABS ── -->
<div class="genre-row">
  <a href="/home"                     class="gtab ${empty param.genre ? 'active' : ''}">All</a>
  <a href="/home?genre=Scifi"         class="gtab ${param.genre == 'Scifi'         ? 'active' : ''}">Sci-Fi</a>
  <a href="/home?genre=Horror"        class="gtab ${param.genre == 'Horror'        ? 'active' : ''}">Horror</a>
  <a href="/home?genre=Comedy"        class="gtab ${param.genre == 'Comedy'        ? 'active' : ''}">Comedy</a>
  <a href="/home?genre=Thriller"      class="gtab ${param.genre == 'Thriller'      ? 'active' : ''}">Thriller</a>
  <a href="/home?genre=Adventure"     class="gtab ${param.genre == 'Adventure'     ? 'active' : ''}">Adventure</a>
  <a href="/home?genre=Crime"         class="gtab ${param.genre == 'Crime'         ? 'active' : ''}">Crime</a>
  <a href="/home?genre=Family"        class="gtab ${param.genre == 'Family'        ? 'active' : ''}">Family</a>
  <a href="/home?genre=Documentary"   class="gtab ${param.genre == 'Documentary'   ? 'active' : ''}">Documentary</a>
  <a href="/home?genre=Psychological" class="gtab ${param.genre == 'Psychological' ? 'active' : ''}">Psychological</a>
</div>

<!-- ── MAIN ── -->
<main class="main">

  <div class="results-bar">
    <div>
      <div class="results-heading">
        <c:choose>
          <c:when test="${not empty param.genre}">${param.genre} Films</c:when>
          <c:when test="${not empty param.q}">Results for &ldquo;${param.q}&rdquo;</c:when>
          <c:otherwise>All Films</c:otherwise>
        </c:choose>
      </div>
      <div class="results-count">
        <c:if test="${not empty movies}">${movies.size()} title${movies.size() == 1 ? '' : 's'} found</c:if>
      </div>
    </div>

    <div class="sort-wrap">
      <select class="sort-select" onchange="sortMovies(this.value)">
        <option value="">Sort by&hellip;</option>
        <option value="rating">Rating</option>
        <option value="price-asc">Price: Low to High</option>
        <option value="price-desc">Price: High to Low</option>
        <option value="duration">Duration</option>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 4l4 4 4-4"/></svg>
    </div>
  </div>

  <div class="movies-grid" id="moviesGrid">
    <c:forEach var="m" items="${movies}">
      <div class="card"
           data-rating="${m.rating}"
           data-price="${m.price}"
           data-duration="${m.duration}">

        <div class="poster-wrap">
          <img class="poster"
               src="${not empty m.posterUrl ? m.posterUrl : 'https://picsum.photos/seed/'.concat(m.id).concat('/300/450')}"
               alt="${m.title}"
               onerror="this.src='https://picsum.photos/seed/${m.id}/300/450'">

          <div class="poster-scrim"></div>

          <span class="q-badge q-${m.quality == '4K' ? '4K' : m.quality == '1080p' ? '1080p' : m.quality == '720p' ? '720p' : '480p'}">
            ${m.quality}
          </span>

          <span class="avail-dot ${m.available ? 'avail-yes' : 'avail-no'}"
                title="${m.available ? 'Available to rent' : 'Currently rented'}"></span>

          <div class="poster-cta">
            <a href="/movie/${m.id}" class="cta-btn">
              <svg viewBox="0 0 16 16" fill="currentColor" width="13" height="13"><path d="M5 3.5l8 4.5-8 4.5V3.5z"/></svg>
              View Details
            </a>
          </div>
        </div>

        <div class="card-body">
          <div class="card-title" title="${m.title}">${m.title}</div>
          <div class="card-meta">
            <span>${m.genre}</span>
            <span class="sep">/</span>
            <span>${m.duration} min</span>
          </div>
          <div class="card-rating">
            <svg viewBox="0 0 12 12"><path d="M6 1l1.35 2.73L10.5 4.2l-2.25 2.19.53 3.1L6 7.95l-2.78 1.54.53-3.1L1.5 4.2l3.15-.47z"/></svg>
            <span>${m.rating}</span>
          </div>

          <div class="card-divider"></div>

          <div class="card-footer">
            <div>
              <div class="price">Rs ${m.price}</div>
              <div class="price-label">per rental</div>
            </div>
            <div class="avail-label ${m.available ? 'yes' : 'no'}">
              ${m.available ? 'Available' : 'Rented'}
            </div>
          </div>

          <a href="/movie/${m.id}" class="rent-btn">
            <svg viewBox="0 0 16 16" fill="currentColor"><path d="M5 3.5l8 4.5-8 4.5V3.5z"/></svg>
            Rent Now
          </a>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty movies}">
      <div class="empty">
        <svg class="empty-icon" viewBox="0 0 64 64" fill="none" stroke="currentColor" stroke-width="1.5">
          <rect x="6" y="10" width="52" height="44" rx="4"/>
          <circle cx="32" cy="32" r="10"/>
          <path d="M29 32l6-4v8l-6-4z" fill="currentColor" stroke="none"/>
          <path d="M6 20h52"/>
          <circle cx="14" cy="15" r="2" fill="currentColor"/>
          <circle cx="22" cy="15" r="2" fill="currentColor"/>
        </svg>
        <h4>No films found</h4>
        <p>Try adjusting your filters or <a href="/home">browse everything</a>.</p>
      </div>
    </c:if>
  </div>
</main>

<script>
  function sortMovies(by) {
    if (!by) return;
    const grid = document.getElementById('moviesGrid');
    const cards = Array.from(grid.querySelectorAll('.card'));
    cards.sort((a, b) => {
      if (by === 'rating')      return parseFloat(b.dataset.rating) - parseFloat(a.dataset.rating);
      if (by === 'price-asc')   return parseFloat(a.dataset.price)  - parseFloat(b.dataset.price);
      if (by === 'price-desc')  return parseFloat(b.dataset.price)  - parseFloat(a.dataset.price);
      if (by === 'duration')    return parseInt(a.dataset.duration)  - parseInt(b.dataset.duration);
      return 0;
    });
    cards.forEach(c => grid.appendChild(c));
  }
</script>

</body>
</html>
