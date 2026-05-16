<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Watch — ${movie.title} — CineRent</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --ink:      #0a0a0f;
      --ink-2:    #111118;
      --ink-3:    #1a1a26;
      --gold:     #c8a96e;
      --gold-pale:#e8d5a8;
      --cream:    #f5f0e8;
      --muted:    #5c5c74;
      --muted-2:  #3a3a50;
      --wire:     rgba(255,255,255,0.07);
      --wire-2:   rgba(255,255,255,0.04);
      --r:        6px;
      --r-lg:     12px;
    }

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

    /* grain */
    body::before {
      content: '';
      position: fixed; inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none; z-index: 1000; opacity: 0.35;
    }

    /* ── NAVBAR ── */
    .navbar {
      position: sticky; top: 0; z-index: 200;
      height: 62px;
      display: flex; align-items: center; justify-content: space-between;
      padding: 0 48px;
      background: rgba(10,10,15,0.88);
      backdrop-filter: blur(20px) saturate(1.5);
      border-bottom: 1px solid var(--wire);
    }
    .brand { display: flex; align-items: baseline; gap: 3px; text-decoration: none; }
    .brand-cine {
      font-family: 'Playfair Display', serif; font-size: 22px;
      font-weight: 900; color: var(--cream); letter-spacing: -0.5px;
    }
    .brand-rent {
      font-family: 'Playfair Display', serif; font-size: 22px;
      font-weight: 400; font-style: italic; color: var(--gold); letter-spacing: -0.5px;
    }
    .brand-dot {
      width: 5px; height: 5px; border-radius: 50%;
      background: var(--gold); margin: 0 2px 2px; align-self: flex-end;
    }
    .btn-ghost {
      padding: 7px 20px; border: 1px solid var(--wire); border-radius: 100px;
      background: transparent; color: var(--muted);
      font-family: 'DM Sans', sans-serif; font-size: 12px; font-weight: 500;
      letter-spacing: 0.5px; text-transform: uppercase; text-decoration: none;
      cursor: pointer; transition: all 0.2s; display: inline-block;
    }
    .btn-ghost:hover { border-color: rgba(200,169,110,0.4); color: var(--gold); background: rgba(200,169,110,0.05); }

    /* ── LOCK SCREEN ── */
    .lock-page {
      min-height: calc(100vh - 62px);
      display: flex; align-items: center; justify-content: center;
      padding: 48px 24px;
      position: relative; overflow: hidden;
    }

    .lock-bg {
      position: absolute; inset: 0;
      background:
        radial-gradient(ellipse 60% 60% at 50% 40%, rgba(200,169,110,0.06) 0%, transparent 65%),
        radial-gradient(ellipse 50% 50% at 20% 80%, rgba(100,60,180,0.04) 0%, transparent 60%);
      pointer-events: none;
    }
    .lock-grid {
      position: absolute; inset: 0;
      background-image:
        repeating-linear-gradient(0deg, var(--wire-2) 0px, var(--wire-2) 1px, transparent 1px, transparent 48px),
        repeating-linear-gradient(90deg, var(--wire-2) 0px, var(--wire-2) 1px, transparent 1px, transparent 48px);
      mask-image: radial-gradient(ellipse 60% 60% at 50% 50%, rgba(0,0,0,0.6), transparent);
      pointer-events: none;
    }

    .lock-card {
      position: relative;
      width: 100%; max-width: 440px;
      background: var(--ink-2);
      border: 1px solid var(--wire);
      border-radius: var(--r-lg);
      padding: 48px 44px;
      animation: fadeUp 0.5s ease both;
    }

    /* film strip top bar */
    .lock-card::before {
      content: '';
      position: absolute; top: 0; left: 0; right: 0; height: 3px;
      background: linear-gradient(90deg, transparent 0%, var(--gold) 40%, var(--gold-pale) 60%, transparent 100%);
      border-radius: var(--r-lg) var(--r-lg) 0 0;
      opacity: 0.7;
    }

    .lock-icon-wrap {
      width: 52px; height: 52px;
      border: 1px solid rgba(200,169,110,0.3);
      border-radius: var(--r);
      background: rgba(200,169,110,0.06);
      display: flex; align-items: center; justify-content: center;
      color: var(--gold); margin: 0 auto 24px;
    }

    .lock-label {
      display: inline-flex; align-items: center; gap: 8px;
      font-size: 11px; font-weight: 600; letter-spacing: 2px;
      text-transform: uppercase; color: var(--gold);
      margin-bottom: 12px;
    }
    .lock-label::before { content: ''; display: block; width: 20px; height: 1px; background: var(--gold); }

    .lock-title {
      font-family: 'Playfair Display', serif;
      font-size: 26px; font-weight: 700;
      color: var(--cream); letter-spacing: -0.4px;
      margin-bottom: 6px; line-height: 1.2;
    }

    .lock-sub {
      font-size: 13px; color: var(--muted); font-weight: 300;
      margin-bottom: 32px;
    }

    .field-label {
      display: block;
      font-size: 11px; font-weight: 600; letter-spacing: 1.2px;
      text-transform: uppercase; color: var(--muted);
      margin-bottom: 8px;
    }

    .field-wrap {
      position: relative; margin-bottom: 20px;
    }

    .field-wrap svg {
      position: absolute; left: 14px; top: 50%;
      transform: translateY(-50%);
      color: var(--muted-2); pointer-events: none;
      transition: color 0.2s;
    }

    .field-wrap:focus-within svg { color: var(--gold); }

    .pw-input {
      width: 100%; height: 46px;
      background: var(--ink-3);
      border: 1px solid var(--wire);
      border-radius: var(--r);
      padding: 0 44px 0 42px;
      font-family: 'DM Sans', sans-serif;
      font-size: 14px; font-weight: 400;
      color: var(--cream); outline: none;
      letter-spacing: 3px;
      transition: border-color 0.2s, background 0.2s;
    }
    .pw-input::placeholder { letter-spacing: 0; color: var(--muted-2); }
    .pw-input:focus { border-color: rgba(200,169,110,0.5); background: rgba(26,26,38,0.8); }

    .pw-toggle {
      position: absolute; right: 14px; top: 50%;
      transform: translateY(-50%);
      background: none; border: none; cursor: pointer;
      color: var(--muted-2); transition: color 0.2s; padding: 0;
    }
    .pw-toggle:hover { color: var(--gold); }

    .shake { animation: shake 0.4s ease; }
    @keyframes shake {
      0%,100% { transform: translateX(0); }
      20%      { transform: translateX(-8px); }
      40%      { transform: translateX(8px); }
      60%      { transform: translateX(-5px); }
      80%      { transform: translateX(5px); }
    }

    .error-line {
      font-size: 12px; color: #e07070;
      margin-bottom: 16px; display: none;
    }
    .error-line.show { display: block; }

    .btn-unlock {
      width: 100%; height: 46px;
      background: transparent;
      border: 1px solid var(--gold); border-radius: 100px;
      font-family: 'DM Sans', sans-serif;
      font-size: 12px; font-weight: 600;
      letter-spacing: 1.5px; text-transform: uppercase;
      color: var(--gold); cursor: pointer;
      position: relative; overflow: hidden;
      transition: color 0.25s;
    }
    .btn-unlock::before {
      content: ''; position: absolute; inset: 0;
      background: var(--gold);
      transform: translateX(-100%);
      transition: transform 0.3s cubic-bezier(0.4,0,0.2,1);
    }
    .btn-unlock:hover { color: var(--ink); }
    .btn-unlock:hover::before { transform: translateX(0); }
    .btn-unlock span { position: relative; z-index: 1; }

    .hint-line {
      text-align: center; margin-top: 20px;
      font-size: 11px; color: var(--muted-2);
    }
    .hint-line code {
      background: var(--ink-3); border: 1px solid var(--wire);
      border-radius: 4px; padding: 2px 7px;
      font-size: 11px; color: var(--muted); font-family: monospace;
    }

    /* ── PLAYER SCREEN ── */
    .player-page {
      display: none;
      min-height: calc(100vh - 62px);
      flex-direction: column;
      animation: fadeUp 0.45s ease both;
    }

    /* poster backdrop blur strip */
    .player-backdrop {
      position: relative; height: 5px;
      background: linear-gradient(90deg, transparent, rgba(200,169,110,0.3), transparent);
    }

    .player-inner {
      max-width: 960px; margin: 0 auto;
      padding: 48px 24px 72px;
      width: 100%;
    }

    /* breadcrumb */
    .breadcrumb-row {
      display: flex; align-items: center; gap: 8px;
      font-size: 12px; color: var(--muted);
      margin-bottom: 32px;
    }
    .breadcrumb-row a {
      color: var(--muted); text-decoration: none; transition: color 0.2s;
    }
    .breadcrumb-row a:hover { color: var(--gold); }
    .breadcrumb-sep { color: var(--muted-2); }
    .breadcrumb-current { color: var(--cream); }

    .player-header {
      display: flex; align-items: flex-start;
      justify-content: space-between; gap: 24px;
      margin-bottom: 24px;
      flex-wrap: wrap;
    }

    .player-title-block {}

    .player-label {
      display: inline-flex; align-items: center; gap: 8px;
      font-size: 11px; font-weight: 600; letter-spacing: 2px;
      text-transform: uppercase; color: var(--gold);
      margin-bottom: 10px;
    }
    .player-label::before { content: ''; display: block; width: 20px; height: 1px; background: var(--gold); }

    .player-title {
      font-family: 'Playfair Display', serif;
      font-size: clamp(26px, 4vw, 38px); font-weight: 900;
      color: var(--cream); letter-spacing: -0.8px; line-height: 1.1;
    }

    .meta-row {
      display: flex; align-items: center; gap: 6px;
      flex-wrap: wrap; margin-top: 10px;
    }
    .meta-pill {
      padding: 3px 10px;
      border: 1px solid var(--wire); border-radius: 100px;
      font-size: 11px; font-weight: 500; color: var(--muted);
      letter-spacing: 0.3px;
    }
    .meta-pill.gold { border-color: rgba(200,169,110,0.3); color: var(--gold); }
    .meta-sep { color: var(--muted-2); font-size: 10px; }

    .action-row {
      display: flex; gap: 10px; align-items: center;
      flex-shrink: 0;
    }

    .btn-dl {
      display: inline-flex; align-items: center; gap: 7px;
      padding: 8px 22px;
      border: 1px solid var(--wire); border-radius: 100px;
      background: transparent; color: var(--muted);
      font-family: 'DM Sans', sans-serif; font-size: 12px; font-weight: 500;
      letter-spacing: 0.5px; text-transform: uppercase;
      text-decoration: none; cursor: pointer; transition: all 0.2s;
    }
    .btn-dl:hover { border-color: rgba(200,169,110,0.4); color: var(--gold); background: rgba(200,169,110,0.05); }

    /* video container */
    .video-shell {
      position: relative;
      background: #000;
      border: 1px solid var(--wire);
      border-radius: var(--r-lg);
      overflow: hidden;
      line-height: 0;
      box-shadow: 0 0 0 1px rgba(200,169,110,0.08), 0 40px 80px rgba(0,0,0,0.7);
    }

    .video-shell video {
      width: 100%; display: block;
      border-radius: var(--r-lg);
    }

    /* gold accent corner lines */
    .video-shell::before,
    .video-shell::after {
      content: ''; position: absolute; z-index: 2; pointer-events: none;
    }
    .video-shell::before {
      top: 0; left: 0; right: 0; height: 2px;
      background: linear-gradient(90deg, transparent 0%, rgba(200,169,110,0.5) 40%, rgba(200,169,110,0.5) 60%, transparent 100%);
    }
    .video-shell::after {
      bottom: 0; left: 0; right: 0; height: 1px;
      background: linear-gradient(90deg, transparent, var(--wire), transparent);
    }

    /* ── ANIMATIONS ── */
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(14px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a class="brand" href="/home">
    <span class="brand-cine">Cine</span>
    <div class="brand-dot"></div>
    <span class="brand-rent">Rent</span>
  </a>
  <div>
    <a href="/my-rentals" class="btn-ghost">My Rentals</a>
  </div>
</nav>

<!-- LOCK SCREEN -->
<div class="lock-page" id="lockScreen">
  <div class="lock-bg"></div>
  <div class="lock-grid"></div>

  <div class="lock-card">
    <div class="lock-icon-wrap">
      <svg width="22" height="22" viewBox="0 0 22 22" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
        <rect x="4" y="10" width="14" height="11" rx="2"/>
        <path d="M7 10V6.5a4 4 0 018 0V10"/>
      </svg>
    </div>

    <div class="lock-label">Secure Screening</div>
    <h1 class="lock-title">${movie.title}</h1>
    <p class="lock-sub">Enter your watch password to begin playback.</p>

    <label class="field-label" for="pw">Watch Password</label>
    <div class="field-wrap" id="fieldWrap">
      <svg width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
        <rect x="2.5" y="6.5" width="10" height="7" rx="1"/>
        <path d="M5 6.5V4.5a2.5 2.5 0 015 0v2"/>
      </svg>
      <input class="pw-input" id="pw" type="password" placeholder="Enter password" autocomplete="off">
      <button class="pw-toggle" type="button" id="toggleBtn" onclick="togglePw()" title="Show / hide">
        <svg id="eyeIcon" width="15" height="15" viewBox="0 0 15 15" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M1 7.5S3.5 3 7.5 3s6.5 4.5 6.5 4.5S13 12 7.5 12 1 7.5 1 7.5z"/>
          <circle cx="7.5" cy="7.5" r="2"/>
        </svg>
      </button>
    </div>

    <div class="error-line" id="errLine">Incorrect password. Please try again.</div>

    <button class="btn-unlock" onclick="unlock()"><span>Unlock &amp; Watch</span></button>

    <div class="hint-line">
      Demo password: <code>movie123</code>
    </div>
  </div>
</div>

<!-- PLAYER SCREEN -->
<div class="player-page" id="playerScreen">
  <div class="player-backdrop"></div>

  <div class="player-inner">

    <div class="breadcrumb-row">
      <a href="/home">Browse</a>
      <span class="breadcrumb-sep">›</span>
      <a href="/my-rentals">My Rentals</a>
      <span class="breadcrumb-sep">›</span>
      <span class="breadcrumb-current">${movie.title}</span>
    </div>

    <div class="player-header">
      <div class="player-title-block">
        <div class="player-label">Now Playing</div>
        <h2 class="player-title">${movie.title}</h2>
        <div class="meta-row">
          <span class="meta-pill">${movie.genre}</span>
          <span class="meta-sep">·</span>
          <span class="meta-pill">${movie.duration} min</span>
          <span class="meta-sep">·</span>
          <span class="meta-pill">${movie.quality}</span>
          <span class="meta-sep">·</span>
          <span class="meta-pill gold">
            <svg width="10" height="10" viewBox="0 0 12 12" style="display:inline;vertical-align:middle;margin-right:3px" fill="currentColor">
              <path d="M6 1l1.35 2.73L10.5 4.2l-2.25 2.19.53 3.1L6 7.95l-2.78 1.54.53-3.1L1.5 4.2l3.15-.47z"/>
            </svg>${movie.rating}
          </span>
        </div>
      </div>

      <div class="action-row">
        <a class="btn-dl" href="https://www.w3schools.com/html/mov_bbb.mp4" download>
          <svg width="13" height="13" viewBox="0 0 13 13" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
            <path d="M6.5 1v8M3 6.5l3.5 3 3.5-3"/>
            <path d="M1 11h11"/>
          </svg>
          Download
        </a>
      </div>
    </div>

    <div class="video-shell">
      <video id="vid" controls poster="${movie.posterUrl}">
        <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
        Your browser does not support video playback.
      </video>
    </div>

  </div>
</div>

<script>
  const correctPw = '${movie.watchPassword}';

  function unlock() {
    const entered = document.getElementById('pw').value;
    const errLine = document.getElementById('errLine');
    const wrap    = document.getElementById('fieldWrap');

    if (entered === correctPw) {
      document.getElementById('lockScreen').style.display = 'none';
      const ps = document.getElementById('playerScreen');
      ps.style.display = 'flex';
      document.getElementById('vid').play();
    } else {
      errLine.classList.add('show');
      wrap.classList.remove('shake');
      void wrap.offsetWidth;           // reflow to restart animation
      wrap.classList.add('shake');
      document.getElementById('pw').value = '';
      document.getElementById('pw').focus();
    }
  }

  function togglePw() {
    const inp  = document.getElementById('pw');
    const icon = document.getElementById('eyeIcon');
    const show = inp.type === 'password';
    inp.type = show ? 'text' : 'password';
    icon.innerHTML = show
      ? '<path d="M2 2l11 11M6.5 5.5A2 2 0 0110 9M1 7.5S3.5 3 7.5 3c.9 0 1.75.2 2.5.5M14 7.5S12 12 7.5 12c-.9 0-1.75-.2-2.5-.5"/>'
      : '<path d="M1 7.5S3.5 3 7.5 3s6.5 4.5 6.5 4.5S13 12 7.5 12 1 7.5 1 7.5z"/><circle cx="7.5" cy="7.5" r="2"/>';
  }

  document.getElementById('pw').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') unlock();
    document.getElementById('errLine').classList.remove('show');
  });
</script>

</body>
</html>
