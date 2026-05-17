<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CineRent — Premium Film Library</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;0,700;1,300;1,400;1,700&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --void:    #07080d;
      --deep:    #0d0e18;
      --surface: #12131f;
      --lift:    #1b1c2e;
      --edge:    rgba(255,255,255,0.06);
      --edge2:   rgba(255,255,255,0.03);
      --amber:   #e8b96a;
      --amber2:  #f5d49a;
      --ember:   #c9422a;
      --jade:    #2aad6f;
      --slate:   #6b6d8a;
      --smoke:   #999bb8;
      --parchment: #f0ead8;
      --r: 8px;
      --r2: 16px;
    }

    html { scroll-behavior: smooth; }

    body {
      background: var(--void);
      color: #ccc9e0;
      font-family: 'Outfit', sans-serif;
      font-size: 14px;
      font-weight: 400;
      line-height: 1.6;
      min-height: 100vh;
      overflow-x: hidden;
    }

    body::after {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 512 512' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='g'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23g)' opacity='0.05'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 9999;
      opacity: 0.28;
    }

    /* ─── NAVBAR ─── */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 500;
      height: 66px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 52px;
      background: rgba(7,8,13,0.85);
      backdrop-filter: blur(24px) saturate(1.8);
      border-bottom: 1px solid var(--edge);
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 10px;
      text-decoration: none;
    }
    .brand-icon {
      width: 34px; height: 34px;
      background: var(--amber);
      border-radius: 8px;
      display: flex; align-items: center; justify-content: center;
    }
    .brand-icon svg { width: 18px; height: 18px; color: var(--void); }
    .brand-wordmark {
      font-family: 'Cormorant Garamond', serif;
      font-size: 24px;
      font-weight: 700;
      color: var(--parchment);
      letter-spacing: -0.5px;
    }
    .brand-wordmark em { font-style: italic; color: var(--amber); }

    .nav-links {
      display: flex;
      align-items: center;
      gap: 36px;
    }
    .nav-link {
      font-size: 13px;
      font-weight: 500;
      color: var(--slate);
      text-decoration: none;
      letter-spacing: 0.3px;
      transition: color 0.2s;
      position: relative;
    }
    .nav-link::after {
      content: '';
      position: absolute;
      bottom: -4px; left: 0; right: 0;
      height: 1px;
      background: var(--amber);
      transform: scaleX(0);
      transition: transform 0.2s;
    }
    .nav-link:hover { color: var(--parchment); }
    .nav-link:hover::after { transform: scaleX(1); }
    .nav-link.active { color: var(--amber); }
    .nav-link.active::after { transform: scaleX(1); }

    .nav-right { display: flex; align-items: center; gap: 14px; }
    .avatar-wrap { display: flex; align-items: center; gap: 9px; }
    .avatar {
      width: 32px; height: 32px;
      border-radius: 50%;
      background: var(--lift);
      border: 1.5px solid var(--amber);
      display: flex; align-items: center; justify-content: center;
      font-family: 'Cormorant Garamond', serif;
      font-size: 14px; font-weight: 700;
      color: var(--amber);
    }
    .avatar-name { font-size: 13px; color: var(--smoke); }

    .btn-outline {
      padding: 7px 18px;
      border: 1px solid var(--edge);
      border-radius: 100px;
      background: transparent;
      color: var(--slate);
      font-family: 'Outfit', sans-serif;
      font-size: 12px; font-weight: 500;
      letter-spacing: 0.4px;
      text-decoration: none;
      cursor: pointer;
      transition: all 0.2s;
    }
    .btn-outline:hover { border-color: rgba(232,185,106,0.35); color: var(--amber); }

    .btn-amber {
      padding: 7px 20px;
      border: 1.5px solid var(--amber);
      border-radius: 100px;
      background: var(--amber);
      color: var(--void);
      font-family: 'Outfit', sans-serif;
      font-size: 12px; font-weight: 600;
      letter-spacing: 0.4px;
      text-decoration: none;
      cursor: pointer;
      transition: all 0.2s;
    }
    .btn-amber:hover { background: var(--amber2); border-color: var(--amber2); }

    /* ─── HERO ─── */
    .hero {
      position: relative;
      min-height: 380px;
      display: flex;
      align-items: center;
      padding: 60px 52px;
      border-bottom: 1px solid var(--edge);
      overflow: hidden;
    }

    /* ── Poster filmstrip (right panel) ── */
    .hero-filmstrip {
      position: absolute;
      right: 0; top: 0; bottom: 0;
      width: 62%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      gap: 6px;
      overflow: hidden;
      mask-image:
        linear-gradient(to right,  transparent 0%, rgba(0,0,0,0.6) 20%, rgba(0,0,0,0.9) 60%, rgba(0,0,0,0.5) 100%),
        linear-gradient(to bottom, transparent 0%, black 12%, black 88%, transparent 100%);
      mask-composite: intersect;
    }

    .filmstrip-row {
      display: flex;
      gap: 6px;
      animation: filmScroll 38s linear infinite;
    }
    .filmstrip-row:nth-child(2) { animation-direction: reverse; animation-duration: 52s; }
    .filmstrip-row:nth-child(3) { animation-duration: 44s; }
    .filmstrip-row:nth-child(4) { animation-direction: reverse; animation-duration: 48s; }
    .filmstrip-row:nth-child(5) { animation-duration: 56s; }

    @keyframes filmScroll {
      from { transform: translateX(0); }
      to   { transform: translateX(-50%); }
    }

    /* Movie poster thumbnails – portrait aspect ratio */
    .film-thumb {
      width: 80px;
      height: 118px;
      object-fit: cover;
      border-radius: 6px;
      flex-shrink: 0;
      filter: brightness(0.55) saturate(0.65);
      border: 1px solid rgba(255,255,255,0.07);
      transition: filter 0.3s;
    }
    .film-thumb:hover { filter: brightness(0.75) saturate(0.9); }

    .hero-veil {
      position: absolute;
      inset: 0;
      background:
        radial-gradient(ellipse 50% 110% at 0% 50%, var(--void) 28%, transparent 65%),
        radial-gradient(ellipse 55% 80% at 28% 50%, rgba(7,8,13,0.75) 0%, transparent 65%);
      pointer-events: none;
    }

    .hero-content {
      position: relative;
      z-index: 2;
      max-width: 560px;
    }

    .hero-eyebrow {
      display: inline-flex;
      align-items: center;
      gap: 10px;
      font-size: 11px; font-weight: 600;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--amber);
      margin-bottom: 22px;
    }
    .hero-eyebrow-line { display: block; width: 32px; height: 1px; background: var(--amber); }

    .hero-title {
      font-family: 'Cormorant Garamond', serif;
      font-size: clamp(40px, 5vw, 64px);
      font-weight: 700;
      line-height: 1.0;
      color: var(--parchment);
      letter-spacing: -1.5px;
      margin-bottom: 18px;
    }
    .hero-title em { font-style: italic; color: var(--amber); }

    .hero-sub {
      font-size: 15px; font-weight: 300;
      color: var(--slate);
      line-height: 1.75;
      max-width: 440px;
    }

    .hero-pills {
      display: flex;
      gap: 10px;
      margin-top: 32px;
      flex-wrap: wrap;
    }
    .hero-pill {
      display: flex; align-items: center; gap: 7px;
      padding: 8px 16px;
      border-radius: 100px;
      background: var(--surface);
      border: 1px solid var(--edge);
    }
    .hero-pill-num {
      font-family: 'Cormorant Garamond', serif;
      font-size: 20px; font-weight: 700;
      color: var(--parchment); line-height: 1;
    }
    .hero-pill-num sup { font-size: 12px; color: var(--amber); }
    .hero-pill-lbl { font-size: 11px; color: var(--slate); letter-spacing: 0.5px; }

    /* ─── FILTERS ─── */
    .filters {
      position: sticky;
      top: 66px;
      z-index: 400;
      background: rgba(13,14,24,0.94);
      backdrop-filter: blur(20px);
      border-bottom: 1px solid var(--edge);
      padding: 12px 52px;
    }

    .filter-row {
      display: flex; align-items: center; gap: 8px; flex-wrap: wrap;
    }

    .f-search { position: relative; flex: 2.5; min-width: 200px; }
    .f-search-icon {
      position: absolute; left: 13px; top: 50%;
      transform: translateY(-50%);
      color: var(--slate); width: 15px; height: 15px;
      pointer-events: none;
    }
    .f-input {
      width: 100%; height: 40px;
      background: var(--surface);
      border: 1px solid var(--edge);
      border-radius: var(--r);
      color: var(--parchment);
      font-family: 'Outfit', sans-serif; font-size: 13px;
      padding: 0 12px 0 38px;
      transition: border-color 0.2s;
    }
    .f-input::placeholder { color: var(--slate); }
    .f-input:focus { outline: none; border-color: rgba(232,185,106,0.4); background: var(--lift); }

    .f-select-wrap { position: relative; flex: 1; min-width: 120px; }
    .f-select-wrap svg {
      position: absolute; right: 10px; top: 50%;
      transform: translateY(-50%);
      pointer-events: none; color: var(--slate); width: 12px; height: 12px;
    }
    .f-select {
      width: 100%; height: 40px;
      background: var(--surface); border: 1px solid var(--edge);
      border-radius: var(--r); color: var(--smoke);
      font-family: 'Outfit', sans-serif; font-size: 13px;
      padding: 0 30px 0 12px; appearance: none;
      transition: border-color 0.2s; cursor: pointer;
    }
    .f-select:focus { outline: none; border-color: rgba(232,185,106,0.4); background: var(--lift); color: var(--parchment); }
    .f-select option { background: var(--deep); }

    .f-num-wrap { flex: 0.8; min-width: 110px; }
    .f-num {
      width: 100%; height: 40px;
      background: var(--surface); border: 1px solid var(--edge);
      border-radius: var(--r); color: var(--parchment);
      font-family: 'Outfit', sans-serif; font-size: 13px;
      padding: 0 12px; transition: border-color 0.2s;
    }
    .f-num::placeholder { color: var(--slate); }
    .f-num:focus { outline: none; border-color: rgba(232,185,106,0.4); }

    .btn-search {
      height: 40px; padding: 0 22px; border: none;
      border-radius: var(--r);
      background: var(--amber); color: var(--void);
      font-family: 'Outfit', sans-serif; font-size: 13px; font-weight: 600;
      cursor: pointer; white-space: nowrap;
      transition: background 0.2s, transform 0.15s;
    }
    .btn-search:hover { background: var(--amber2); transform: translateY(-1px); }

    .btn-clear {
      height: 40px; width: 40px;
      border: 1px solid var(--edge); border-radius: var(--r);
      background: transparent; color: var(--slate);
      font-family: 'Outfit', sans-serif; font-size: 13px;
      cursor: pointer; text-decoration: none;
      display: inline-flex; align-items: center; justify-content: center;
      transition: all 0.2s; flex-shrink: 0;
    }
    .btn-clear:hover { color: var(--ember); border-color: rgba(201,66,42,0.4); }

    /* ─── GENRE TABS ─── */
    .genre-bar {
      background: var(--deep);
      border-bottom: 1px solid var(--edge);
      padding: 0 52px;
      display: flex; overflow-x: auto; scrollbar-width: none; gap: 0;
    }
    .genre-bar::-webkit-scrollbar { display: none; }

    .gtab {
      padding: 13px 22px;
      font-size: 12px; font-weight: 500; letter-spacing: 0.6px;
      color: var(--slate); text-decoration: none; white-space: nowrap;
      border-bottom: 2px solid transparent;
      transition: color 0.2s, border-color 0.2s;
    }
    .gtab:hover { color: var(--smoke); }
    .gtab.active { color: var(--amber); border-bottom-color: var(--amber); }

    /* ─── MAIN ─── */
    .main {
      max-width: 1420px;
      margin: 0 auto;
      padding: 36px 52px 100px;
    }

    .results-bar {
      display: flex; align-items: flex-end;
      justify-content: space-between;
      margin-bottom: 30px;
    }
    .results-title {
      font-family: 'Cormorant Garamond', serif;
      font-size: 26px; font-weight: 700;
      color: var(--parchment); letter-spacing: -0.3px;
    }
    .results-count { font-size: 12px; color: var(--slate); margin-top: 3px; letter-spacing: 0.2px; }

    .sort-wrap { position: relative; }
    .sort-wrap svg {
      position: absolute; right: 10px; top: 50%;
      transform: translateY(-50%);
      pointer-events: none; color: var(--slate); width: 11px; height: 11px;
    }
    .sort-select {
      height: 36px; padding: 0 30px 0 12px;
      background: var(--surface); border: 1px solid var(--edge);
      border-radius: var(--r); color: var(--slate);
      font-family: 'Outfit', sans-serif; font-size: 12px;
      appearance: none; cursor: pointer;
    }
    .sort-select:focus { outline: none; color: var(--parchment); }
    .sort-select option { background: var(--deep); }

    /* ─── MOVIE GRID ─── */
    .movies-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(195px, 1fr));
      gap: 18px;
    }

    /* ─── CARD ─── */
    .card {
      background: var(--surface);
      border: 1px solid var(--edge);
      border-radius: var(--r2);
      overflow: hidden;
      transition: transform 0.35s cubic-bezier(.22,.68,0,1.2), border-color 0.3s, box-shadow 0.35s;
      position: relative;
      animation: riseUp 0.45s ease both;
    }

    @keyframes riseUp {
      from { opacity: 0; transform: translateY(22px); }
      to   { opacity: 1; transform: translateY(0); }
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

    .card:hover {
      transform: translateY(-8px);
      border-color: rgba(232,185,106,0.25);
      box-shadow: 0 28px 70px rgba(0,0,0,0.7), 0 0 0 1px rgba(232,185,106,0.12);
    }

    .poster-wrap {
      position: relative;
      height: 285px;
      overflow: hidden;
      background: var(--lift);
    }

    .poster {
      width: 100%; height: 100%;
      object-fit: cover; display: block;
      transition: transform 0.45s ease, filter 0.3s;
    }
    .card:hover .poster { transform: scale(1.07); filter: brightness(0.5); }

    .poster-gradient {
      position: absolute; inset: 0;
      background: linear-gradient(to top, rgba(7,8,13,1) 0%, rgba(7,8,13,0.5) 35%, transparent 65%);
      opacity: 0.75; transition: opacity 0.3s;
    }
    .card:hover .poster-gradient { opacity: 1; }

    .q-badge {
      position: absolute; top: 11px; left: 11px;
      padding: 3px 7px; border-radius: 5px;
      font-family: 'Outfit', sans-serif;
      font-size: 10px; font-weight: 700;
      letter-spacing: 0.8px; text-transform: uppercase;
      backdrop-filter: blur(6px);
    }
    .q-4K    { background: rgba(232,185,106,0.9); color: var(--void); }
    .q-1080p { background: rgba(80,90,255,0.8);   color: #d0d4ff; }
    .q-720p  { background: rgba(30,160,120,0.8);  color: #a0f0d0; }
    .q-480p  { background: rgba(60,60,80,0.8);    color: #aaa; }

    .avail-dot {
      position: absolute; top: 13px; right: 13px;
      width: 9px; height: 9px; border-radius: 50%;
      border: 2px solid rgba(7,8,13,0.7);
    }
    .avail-yes { background: var(--jade); box-shadow: 0 0 6px var(--jade); }
    .avail-no  { background: var(--ember); box-shadow: 0 0 6px var(--ember); }

    .poster-cta {
      position: absolute; inset: 0;
      display: flex; align-items: center; justify-content: center;
      opacity: 0; transition: opacity 0.25s;
    }
    .card:hover .poster-cta { opacity: 1; }

    .cta-pill {
      display: flex; align-items: center; gap: 7px;
      padding: 10px 22px; border-radius: 100px;
      background: var(--amber); color: var(--void);
      font-family: 'Outfit', sans-serif;
      font-size: 12px; font-weight: 700; letter-spacing: 0.5px;
      text-decoration: none; text-transform: uppercase;
      transform: translateY(8px);
      transition: transform 0.35s cubic-bezier(.22,.68,0,1.2), background 0.2s;
    }
    .card:hover .cta-pill { transform: translateY(0); }
    .cta-pill:hover { background: var(--amber2); }

    .card-body { padding: 14px 16px 18px; }

    .card-title {
      font-family: 'Cormorant Garamond', serif;
      font-size: 17px; font-weight: 700;
      color: var(--parchment);
      white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
      margin-bottom: 5px; line-height: 1.2;
    }

    .card-meta {
      display: flex; align-items: center; gap: 6px;
      font-size: 11px; color: var(--slate);
      margin-bottom: 9px;
    }
    .card-meta .dot { width: 3px; height: 3px; border-radius: 50%; background: var(--slate); }

    .card-rating {
      display: flex; align-items: center; gap: 4px;
      font-size: 12px; color: var(--amber); font-weight: 600;
      margin-bottom: 12px;
    }
    .star { fill: var(--amber); width: 11px; height: 11px; }

    .divider { height: 1px; background: var(--edge); margin: 10px 0 12px; }

    .card-footer {
      display: flex; align-items: flex-end;
      justify-content: space-between; margin-bottom: 12px;
    }
    .price {
      font-family: 'Cormorant Garamond', serif;
      font-size: 22px; font-weight: 700;
      color: var(--amber); line-height: 1;
    }
    .price-label { font-size: 10px; color: var(--slate); letter-spacing: 0.5px; margin-top: 2px; }
    .avail-chip { font-size: 11px; font-weight: 600; padding: 3px 8px; border-radius: 100px; }
    .avail-chip.yes { background: rgba(42,173,111,0.12); color: var(--jade); }
    .avail-chip.no  { background: rgba(201,66,42,0.12);  color: var(--ember); }

    .rent-btn {
      display: flex; align-items: center; justify-content: center; gap: 6px;
      width: 100%; height: 38px;
      border: 1px solid rgba(232,185,106,0.25);
      border-radius: var(--r);
      background: rgba(232,185,106,0.04);
      color: var(--amber);
      font-family: 'Outfit', sans-serif;
      font-size: 12px; font-weight: 600; letter-spacing: 0.4px;
      text-transform: uppercase; text-decoration: none;
      transition: all 0.22s; cursor: pointer;
    }
    .rent-btn:hover { background: var(--amber); color: var(--void); border-color: var(--amber); }

    /* ─── EMPTY STATE ─── */
    .empty { grid-column: 1 / -1; text-align: center; padding: 110px 20px; }
    .empty-icon { width: 72px; height: 72px; margin: 0 auto 24px; opacity: 0.12; }
    .empty h4 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 24px; font-weight: 700;
      color: var(--parchment); margin-bottom: 8px;
    }
    .empty p { font-size: 14px; color: var(--slate); }
    .empty a { color: var(--amber); text-decoration: none; }
    .empty a:hover { text-decoration: underline; }

    ::-webkit-scrollbar { width: 4px; }
    ::-webkit-scrollbar-track { background: var(--void); }
    ::-webkit-scrollbar-thumb { background: var(--lift); border-radius: 4px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--amber); }

    @media (max-width: 768px) {
      .navbar, .filters, .genre-bar, .hero, .main { padding-left: 20px; padding-right: 20px; }
      .nav-links { display: none; }
      .hero-filmstrip { width: 0; }
      .movies-grid { grid-template-columns: repeat(auto-fill, minmax(155px, 1fr)); gap: 14px; }
      .poster-wrap { height: 240px; }
    }

    /* ─── MODAL ─── */
    .modal-overlay {
      position: fixed; inset: 0; background: rgba(0,0,0,0.8); backdrop-filter: blur(5px);
      display: none; align-items: center; justify-content: center; z-index: 1000;
    }
    .modal-content {
      background: var(--surface); border: 1px solid var(--edge); border-radius: var(--r2);
      width: 100%; max-width: 400px; padding: 24px; box-shadow: 0 10px 40px rgba(0,0,0,0.5);
    }
    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .modal-header h3 { font-family: 'Cormorant Garamond', serif; font-size: 22px; color: var(--parchment); }
    .close-btn { background: none; border: none; color: var(--slate); font-size: 24px; cursor: pointer; }
    .close-btn:hover { color: var(--ember); }
    .form-group { margin-bottom: 16px; }
    .form-group label { display: block; font-size: 12px; color: var(--slate); margin-bottom: 6px; letter-spacing: 0.5px; }
    .form-group input { 
      width: 100%; height: 42px; background: var(--deep); border: 1px solid var(--edge); 
      border-radius: var(--r); color: var(--parchment); padding: 0 12px; font-family: 'Outfit', sans-serif;
    }
    .form-group input:focus { outline: none; border-color: rgba(232,185,106,0.4); }
    .modal-footer { margin-top: 24px; }
  </style>
</head>
<body>

<!-- ─── NAVBAR ─── -->
<nav class="navbar">
  <a href="/home" class="brand">
    <div class="brand-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polygon points="23 7 16 12 23 17 23 7"/><rect x="1" y="5" width="15" height="14" rx="2"/>
      </svg>
    </div>
    <span class="brand-wordmark">Cine<em>Rent</em></span>
  </a>

  <nav class="nav-links">
    <a href="/home"         class="nav-link active">Browse</a>
    <a href="/my-rentals"   class="nav-link">My Rentals</a>
    <a href="/new-releases" class="nav-link">New Releases</a>
  </nav>

  <div class="nav-right">
    <div class="avatar-wrap">
      <div class="avatar">
        ${not empty sessionScope.username ? sessionScope.username.substring(0,1).toUpperCase() : 'G'}
      </div>
      <span class="avatar-name">${not empty sessionScope.username ? sessionScope.username : 'Guest'}</span>
    </div>
    <a href="/my-rentals" class="btn-outline">My Rentals</a>
    <button onclick="openSettingsModal()" class="btn-outline" style="padding: 7px 12px; display: flex; align-items: center; justify-content: center;" title="Settings">
      <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="12" cy="12" r="3"></circle>
        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
      </svg>
    </button>
    <a href="/logout"     class="btn-amber">Sign Out</a>
  </div>
</nav>

<!-- ─── HERO ─── -->
<section class="hero">

  <!--
    ╔══════════════════════════════════════════════════════════════════╗
    ║  FILMSTRIP — 5 rows of real movie poster thumbnails (portrait)  ║
    ║  Each row duplicated so the CSS infinite-scroll loop works.     ║
    ║  Posters: TMDB /w185 path  (80×118 rendered via object-fit)    ║
    ╚══════════════════════════════════════════════════════════════════╝
  -->
  <div class="hero-filmstrip">

    <!-- ROW 1  – Action / Blockbusters -->
    <div class="filmstrip-row">
      <%-- Inception --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg" alt="Inception">
      <%-- The Dark Knight --%>    <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/qJ2tW6WMUDux911r6m7haRef0WH.jpg" alt="The Dark Knight">
      <%-- Interstellar --%>       <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/gEU2QniE6E77NI6lCU6MxlNBvIe.jpg" alt="Interstellar">
      <%-- Avengers: Endgame --%>  <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
      <%-- Top Gun: Maverick --%>  <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/62HCnUTziyWcpDaBO2i1DX17ljH.jpg" alt="Top Gun: Maverick">
      <%-- John Wick --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/fZPSd91akSEgmv5WKQrsKMCqkzQ.jpg" alt="John Wick">
      <%-- Mad Max Fury Road --%>  <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/kqjL17yufvn9OVLyXYpvtyrFfak.jpg" alt="Mad Max: Fury Road">
      <%-- duplicate set for infinite scroll --%>
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/qJ2tW6WMUDux911r6m7haRef0WH.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/gEU2QniE6E77NI6lCU6MxlNBvIe.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/62HCnUTziyWcpDaBO2i1DX17ljH.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/fZPSd91akSEgmv5WKQrsKMCqkzQ.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/kqjL17yufvn9OVLyXYpvtyrFfak.jpg" alt="">
    </div>

    <!-- ROW 2  – Sci-Fi / Fantasy -->
    <div class="filmstrip-row">
      <%-- Dune: Part Two --%>     <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg" alt="Dune Part Two">
      <%-- Oppenheimer --%>        <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg" alt="Oppenheimer">
      <%-- The Matrix --%>         <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg" alt="The Matrix">
      <%-- Avatar --%>             <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg" alt="Avatar">
      <%-- Blade Runner 2049 --%>  <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg" alt="Blade Runner 2049">
      <%-- Dune 2021 --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/d5NXSklpcvkCitereitwanWe6VS.jpg" alt="Dune">
      <%-- The Martian --%>        <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/5aGhaIHYuQbqlHWvWYqMCnj40y2.jpg" alt="The Martian">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/d5NXSklpcvkCitereitwanWe6VS.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/5aGhaIHYuQbqlHWvWYqMCnj40y2.jpg" alt="">
    </div>

    <!-- ROW 3  – Drama / Thriller -->
    <div class="filmstrip-row">
      <%-- The Godfather --%>       <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/3bhkrj58Vtu7enYsLegHQDbe3Fs.jpg" alt="The Godfather">
      <%-- Parasite --%>            <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg" alt="Parasite">
      <%-- Joker --%>               <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg" alt="Joker">
      <%-- Fight Club --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg" alt="Fight Club">
      <%-- Shutter Island --%>      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/bnT4HN6UUkJD5X8EvFiGPMKxAYJ.jpg" alt="Shutter Island">
      <%-- No Country for Old Men --%> <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/6d5L9i0pFHi6f2RfGbMRLGPCmxd.jpg" alt="No Country for Old Men">
      <%-- Whiplash --%>            <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7fn624j5lj3xTme2SgiLCeuedmO.jpg" alt="Whiplash">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/3bhkrj58Vtu7enYsLegHQDbe3Fs.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/bnT4HN6UUkJD5X8EvFiGPMKxAYJ.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/6d5L9i0pFHi6f2RfGbMRLGPCmxd.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7fn624j5lj3xTme2SgiLCeuedmO.jpg" alt="">
    </div>

    <!-- ROW 4  – Horror / Psychological -->
    <div class="filmstrip-row">
      <%-- Get Out --%>             <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg" alt="Get Out">
      <%-- Hereditary --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/l7Seg5WxPgdGBvEsYDsQBkjezJD.jpg" alt="Hereditary">
      <%-- The Silence of the Lambs --%> <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg" alt="The Silence of the Lambs">
      <%-- Black Swan --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/wedBqDFpB6dBNGBbAXNhczGjNlN.jpg" alt="Black Swan">
      <%-- Midsommar --%>           <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7LEI8ulZzO5gy9Ww2NVCrKmc9Bp.jpg" alt="Midsommar">
      <%-- A Quiet Place --%>       <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/nAU74GmpUk7t5iklEp3bufwDq4n.jpg" alt="A Quiet Place">
      <%-- The Witch --%>           <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/fGiYAGLBEjxkEd3oP0RHo14kKOK.jpg" alt="The Witch">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/l7Seg5WxPgdGBvEsYDsQBkjezJD.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/wedBqDFpB6dBNGBbAXNhczGjNlN.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/7LEI8ulZzO5gy9Ww2NVCrKmC9Bp.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/nAU74GmpUk7t5iklEp3bufwDq4n.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/fGiYAGLBEjxkEd3oP0RHo14kKOK.jpg" alt="">
    </div>

    <!-- ROW 5  – Comedy / Animation / Family -->
    <div class="filmstrip-row">
      <%-- Spirited Away --%>       <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg" alt="Spirited Away">
      <%-- The Grand Budapest Hotel --%> <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/nX5XotM9yprCKarRH4HKB39PCZI.jpg" alt="The Grand Budapest Hotel">
      <%-- Once Upon a Time in Hollywood --%> <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg" alt="Once Upon a Time in Hollywood">
      <%-- Everything Everywhere --%> <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg" alt="Everything Everywhere All at Once">
      <%-- Knives Out --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/pThyQovXQrqVPlq4bFUL4vCnqbS.jpg" alt="Knives Out">
      <%-- The Truman Show --%>     <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/vuza0WqY239yBXOadKlGwJsZJFE.jpg" alt="The Truman Show">
      <%-- La La Land --%>          <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg" alt="La La Land">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/nX5XotM9yprCKarRH4HKB39PCZI.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/8j58iEBw9pOXFD2L0nt0ZXeHviB.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/w3LxiVYdWWRvEVdn5RYq6jIqkb1.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/pThyQovXQrqVPlq4bFUL4vCnqbS.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/vuza0WqY239yBXOadKlGwJsZJFE.jpg" alt="">
      <img class="film-thumb" src="https://image.tmdb.org/t/p/w185/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg" alt="">
    </div>

  </div><!-- /hero-filmstrip -->

  <div class="hero-veil"></div>

  <div class="hero-content">
    <div class="hero-eyebrow">
      <span class="hero-eyebrow-line"></span>
      Premium Film Library
    </div>
    <h1 class="hero-title">
      Cinema, curated<br>for <em>your evening.</em>
    </h1>
    <p class="hero-sub">Thousands of titles spanning every genre — from pulse-racing thrillers to quiet documentaries. Rent in moments, watch tonight.</p>
    <div class="hero-pills">
      <div class="hero-pill">
        <span class="hero-pill-num">4K<sup>+</sup></span>
        <span class="hero-pill-lbl">Titles</span>
      </div>
      <div class="hero-pill">
        <span class="hero-pill-num">4<sup>K</sup></span>
        <span class="hero-pill-lbl">Ultra HD</span>
      </div>
      <div class="hero-pill">
        <span class="hero-pill-num">24<sup>h</sup></span>
        <span class="hero-pill-lbl">Rental Window</span>
      </div>
    </div>
  </div>

</section>

<!-- ─── FILTERS ─── -->
<div class="filters">
  <form class="filter-row" method="get" action="/home">
    <div class="f-search">
      <svg class="f-search-icon" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round">
        <circle cx="9" cy="9" r="6"/><path d="M15 15l3 3"/>
      </svg>
      <input class="f-input" name="q" placeholder="Search title or keyword…" value="${param.q}" autocomplete="off">
    </div>

    <div class="f-select-wrap">
      <select class="f-select" name="genre">
        <option value="">All Genres</option>
        <c:forEach var="g" items="${['Scifi','Horror','Documentary','Family','Child','Comedy','Adventure','Crime','Thriller','Psychological']}">
          <option <c:if test="${param.genre == g}">selected</c:if>>${g}</option>
        </c:forEach>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 4l4 4 4-4"/></svg>
    </div>

    <div class="f-select-wrap">
      <select class="f-select" name="quality">
        <option value="">Any Quality</option>
        <option <c:if test="${param.quality == '480p'}">selected</c:if> value="480p">480p SD</option>
        <option <c:if test="${param.quality == '720p'}">selected</c:if> value="720p">720p HD</option>
        <option <c:if test="${param.quality == '1080p'}">selected</c:if> value="1080p">1080p Full HD</option>
        <option <c:if test="${param.quality == '4K'}">selected</c:if> value="4K">4K Ultra HD</option>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 4l4 4 4-4"/></svg>
    </div>

    <div class="f-num-wrap">
      <input class="f-num" name="minRating" type="number" step="0.1" min="0" max="10" placeholder="Min rating" value="${param.minRating}">
    </div>

    <div class="f-num-wrap">
      <input class="f-num" name="maxDuration" type="number" placeholder="Max minutes" value="${param.maxDuration}">
    </div>

    <button type="submit" class="btn-search">Search</button>
    <a href="/home" class="btn-clear" title="Clear filters">
      <svg width="12" height="12" viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round">
        <path d="M1 1l10 10M11 1L1 11"/>
      </svg>
    </a>
  </form>
</div>

<!-- ─── GENRE TABS ─── -->
<div class="genre-bar">
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

<!-- ─── MAIN ─── -->
<main class="main">

  <div class="results-bar">
    <div>
      <div class="results-title">
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
        <option value="rating">Top Rated</option>
        <option value="price-asc">Price: Low → High</option>
        <option value="price-desc">Price: High → Low</option>
        <option value="duration">Duration</option>
      </select>
      <svg viewBox="0 0 12 12" fill="none" stroke="currentColor" stroke-width="2"><path d="M2 4l4 4 4-4"/></svg>
    </div>
  </div>

  <!-- ─── MOVIES GRID ─── -->
  <div class="movies-grid" id="moviesGrid">

    <c:forEach var="m" items="${movies}">
      <div class="card"
           data-rating="${m.rating}"
           data-price="${m.price}"
           data-duration="${m.duration}">

        <div class="poster-wrap">
          <%--
            Poster image priority:
            1. m.posterUrl  – explicit URL stored by backend
            2. m.tmdbId     – TMDB poster path  → use /w500/ for card size
            3. Fallback     – picsum seeded by movie id (always same image per movie)
          --%>
          <img class="poster"
               src="${not empty m.posterUrl
                       ? m.posterUrl
                       : not empty m.tmdbId
                           ? 'https://image.tmdb.org/t/p/w500/'.concat(m.tmdbId)
                           : 'https://picsum.photos/seed/mv'.concat(m.id).concat('/400/600')}"
               alt="${m.title}"
               loading="lazy"
               onerror="this.onerror=null;this.src='https://picsum.photos/seed/mv${m.id}/400/600'">

          <div class="poster-gradient"></div>

          <span class="q-badge q-${m.quality == '4K' ? '4K' : m.quality == '1080p' ? '1080p' : m.quality == '720p' ? '720p' : '480p'}">
            ${m.quality}
          </span>

          <span class="avail-dot ${m.available ? 'avail-yes' : 'avail-no'}"
                title="${m.available ? 'Available to rent' : 'Currently rented out'}"></span>

          <div class="poster-cta">
            <a href="/movie/${m.id}" class="cta-pill">
              <svg width="12" height="12" viewBox="0 0 16 16" fill="currentColor"><path d="M5 3.5l8 4.5-8 4.5V3.5z"/></svg>
              View Details
            </a>
          </div>
        </div>

        <div class="card-body">
          <div class="card-title" title="${m.title}">${m.title}</div>

          <div class="card-meta">
            <span>${m.genre}</span>
            <span class="dot"></span>
            <span>${m.duration} min</span>
          </div>

          <div class="card-rating">
            <svg class="star" viewBox="0 0 12 12"><path d="M6 1l1.35 2.73L10.5 4.2l-2.25 2.19.53 3.1L6 7.95l-2.78 1.54.53-3.1L1.5 4.2l3.15-.47z"/></svg>
            <span>${m.rating}</span>
          </div>

          <div class="divider"></div>

          <div class="card-footer">
            <div>
              <div class="price">Rs ${m.price}</div>
              <div class="price-label">per rental</div>
            </div>
            <span class="avail-chip ${m.available ? 'yes' : 'no'}">
              ${m.available ? 'Available' : 'Rented'}
            </span>
          </div>

          <a href="/movie/${m.id}" class="rent-btn">
            <svg width="12" height="12" viewBox="0 0 16 16" fill="currentColor"><path d="M5 3.5l8 4.5-8 4.5V3.5z"/></svg>
            Rent Now
          </a>
        </div>

      </div>
    </c:forEach>

    <c:if test="${empty movies}">
      <div class="empty">
        <svg class="empty-icon" viewBox="0 0 64 64" fill="none" stroke="currentColor" stroke-width="1.4">
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
      if (by === 'rating')     return parseFloat(b.dataset.rating) - parseFloat(a.dataset.rating);
      if (by === 'price-asc')  return parseFloat(a.dataset.price)  - parseFloat(b.dataset.price);
      if (by === 'price-desc') return parseFloat(b.dataset.price)  - parseFloat(a.dataset.price);
      if (by === 'duration')   return parseInt(a.dataset.duration)  - parseInt(b.dataset.duration);
      return 0;
    });
    cards.forEach(c => grid.appendChild(c));
  }
</script>

<!-- Settings Modal -->
<div id="settingsModal" class="modal-overlay">
  <div class="modal-content">
    <div class="modal-header">
      <h3>Account Settings</h3>
      <button type="button" class="close-btn" onclick="closeSettingsModal()">&times;</button>
    </div>
    <form action="/user/update" method="POST">
      <div class="form-group">
        <label>Username</label>
        <input type="text" name="username" value="${sessionScope.user.username}" required>
      </div>
      <div class="form-group">
        <label>Email Address</label>
        <input type="email" name="email" value="${sessionScope.user.email}" required>
      </div>
      <div class="form-group">
        <label>New Password (leave blank to keep current)</label>
        <input type="password" name="password" placeholder="••••••••">
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn-amber" style="width: 100%;">Save Changes</button>
      </div>
    </form>
  </div>
</div>

<script>
  function openSettingsModal() { document.getElementById('settingsModal').style.display = 'flex'; }
  function closeSettingsModal() { document.getElementById('settingsModal').style.display = 'none'; }
  <c:if test="${not empty successMessage}">
    setTimeout(() => {
      alert('${successMessage}');
    }, 100);
  </c:if>
</script>

</body>
</html>
