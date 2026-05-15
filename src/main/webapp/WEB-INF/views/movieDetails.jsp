<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>${movie.title} — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600;1,9..40,300&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">

  <style>
    :root {
      --bg:        #080810;
      --surface:   #0e0e1a;
      --surface2:  #13131f;
      --border:    rgba(255,255,255,0.07);
      --border2:   rgba(255,255,255,0.12);
      --text:      #e8e4f0;
      --muted:     #5a556e;
      --muted2:    #7c7590;
      --accent:    #c8a96e;
      --accent2:   #e4c98a;
      --red:       #e05252;
      --green:     #5cba87;
      --font-display: 'Bebas Neue', sans-serif;
      --font-body:    'DM Sans', sans-serif;
      --font-mono:    'DM Mono', monospace;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html { scroll-behavior: smooth; }

    body {
      background: var(--bg);
      color: var(--text);
      font-family: var(--font-body);
      font-size: 15px;
      min-height: 100vh;
      overflow-x: hidden;
    }

    /* ─── Noise Grain ─────────────────────────────── */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 9999;
      opacity: 0.5;
    }

    /* ─── Scrollbar ───────────────────────────────── */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: #2a2740; border-radius: 3px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--accent); }

    /* ─── Navbar ──────────────────────────────────── */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 500;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 48px;
      height: 60px;
      background: rgba(8,8,16,0.92);
      backdrop-filter: blur(20px);
      border-bottom: 1px solid var(--border);
    }

    .nav-brand {
      font-family: var(--font-display);
      font-size: 1.6rem;
      letter-spacing: 3px;
      color: var(--accent);
      text-decoration: none;
      line-height: 1;
    }

    .nav-brand span {
      color: var(--muted2);
      font-size: 1rem;
      letter-spacing: 6px;
      font-family: var(--font-mono);
      margin-left: 2px;
    }

    .nav-right { display: flex; align-items: center; gap: 6px; }

    .btn-nav {
      padding: 7px 18px;
      border-radius: 4px;
      font-size: 0.78rem;
      font-weight: 500;
      text-decoration: none;
      letter-spacing: 0.4px;
      transition: all 0.18s;
      font-family: var(--font-mono);
    }

    .btn-nav-ghost {
      color: var(--muted2);
      background: transparent;
      border: 1px solid transparent;
    }
    .btn-nav-ghost:hover {
      color: var(--text);
      border-color: var(--border2);
      background: rgba(255,255,255,0.04);
    }

    .btn-nav-logout {
      color: var(--accent);
      background: rgba(200,169,110,0.07);
      border: 1px solid rgba(200,169,110,0.2);
    }
    .btn-nav-logout:hover {
      background: rgba(200,169,110,0.14);
      border-color: rgba(200,169,110,0.4);
      color: var(--accent2);
    }

    /* ─── Hero Layout ─────────────────────────────── */
    .hero {
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: 0;
      max-width: 1300px;
      margin: 0 auto;
      padding: 64px 48px 0;
      align-items: start;
    }

    /* ─── Poster Column ───────────────────────────── */
    .poster-col {
      position: sticky;
      top: 80px;
      padding-right: 48px;
    }

    .poster-frame {
      position: relative;
      width: 240px;
    }

    .poster-img {
      display: block;
      width: 240px;
      height: 356px;
      object-fit: cover;
      border-radius: 2px;
      border: 1px solid rgba(255,255,255,0.06);
      filter: brightness(0.95);
      transition: filter 0.3s;
    }
    .poster-frame:hover .poster-img { filter: brightness(1.05); }

    /* corner ornament */
    .poster-frame::before,
    .poster-frame::after {
      content: '';
      position: absolute;
      width: 20px;
      height: 20px;
      border-color: var(--accent);
      border-style: solid;
    }
    .poster-frame::before {
      top: -6px; left: -6px;
      border-width: 2px 0 0 2px;
    }
    .poster-frame::after {
      bottom: -6px; right: -6px;
      border-width: 0 2px 2px 0;
    }

    .quality-tag {
      position: absolute;
      top: 10px;
      right: -10px;
      padding: 5px 11px;
      font-family: var(--font-mono);
      font-size: 0.68rem;
      font-weight: 500;
      letter-spacing: 0.5px;
      border-radius: 2px;
    }
    .quality-4K    { background: var(--accent); color: #1a1200; }
    .quality-1080p { background: #5b6cf5; color: #fff; }
    .quality-720p  { background: #3da87a; color: #fff; }
    .quality-480p  { background: #555; color: #ddd; }

    .avail-bar {
      margin-top: 16px;
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 14px;
      border-radius: 3px;
      font-size: 0.78rem;
      font-family: var(--font-mono);
      font-weight: 500;
      letter-spacing: 0.3px;
      width: 240px;
    }
    .avail-yes {
      background: rgba(92,186,135,0.08);
      border: 1px solid rgba(92,186,135,0.22);
      color: var(--green);
    }
    .avail-no {
      background: rgba(224,82,82,0.08);
      border: 1px solid rgba(224,82,82,0.2);
      color: var(--red);
    }
    .avail-dot {
      width: 7px; height: 7px;
      border-radius: 50%;
      flex-shrink: 0;
    }
    .avail-yes .avail-dot { background: var(--green); box-shadow: 0 0 6px var(--green); animation: pulse-green 2s infinite; }
    .avail-no  .avail-dot { background: var(--red); }

    @keyframes pulse-green {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.4; }
    }

    /* ─── Info Column ─────────────────────────────── */
    .info-col { padding-bottom: 64px; }

    /* Eyebrow */
    .eyebrow {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 18px;
    }

    .eyebrow-line {
      width: 32px;
      height: 2px;
      background: var(--accent);
      border-radius: 2px;
    }

    .eyebrow-text {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--accent);
    }

    /* Title */
    .movie-title {
      font-family: var(--font-display);
      font-size: clamp(3.2rem, 5vw, 5.5rem);
      line-height: 0.93;
      letter-spacing: 2px;
      color: var(--text);
      margin-bottom: 28px;
      text-transform: uppercase;
    }

    /* Meta chips */
    .meta-strip {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-bottom: 32px;
    }

    .meta-tag {
      padding: 5px 13px;
      border-radius: 2px;
      font-family: var(--font-mono);
      font-size: 0.72rem;
      letter-spacing: 0.3px;
      color: var(--muted2);
      background: var(--surface2);
      border: 1px solid var(--border);
    }

    .meta-tag.rating {
      color: var(--accent);
      background: rgba(200,169,110,0.07);
      border-color: rgba(200,169,110,0.2);
    }

    /* Divider rule */
    .info-rule {
      border: none;
      border-top: 1px solid var(--border);
      margin: 0 0 28px;
    }

    /* Description */
    .movie-desc {
      font-size: 0.95rem;
      color: var(--muted2);
      line-height: 1.85;
      font-weight: 300;
      max-width: 600px;
      font-style: italic;
      margin-bottom: 36px;
    }

    /* Price block */
    .price-block {
      display: flex;
      align-items: baseline;
      gap: 8px;
      margin-bottom: 32px;
    }

    .price-currency {
      font-family: var(--font-mono);
      font-size: 0.85rem;
      color: var(--muted);
      letter-spacing: 1px;
    }

    .price-amount {
      font-family: var(--font-display);
      font-size: 3.8rem;
      line-height: 1;
      color: var(--accent);
      letter-spacing: 1px;
    }

    .price-per {
      font-family: var(--font-mono);
      font-size: 0.72rem;
      color: var(--muted);
      letter-spacing: 1px;
      text-transform: uppercase;
      align-self: flex-end;
      padding-bottom: 6px;
    }

    /* Action row */
    .action-row { display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }

    .btn-rent {
      display: inline-flex;
      align-items: center;
      gap: 9px;
      padding: 14px 36px;
      background: var(--accent);
      color: #0a0800;
      font-family: var(--font-mono);
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      text-decoration: none;
      border-radius: 2px;
      border: none;
      cursor: pointer;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      box-shadow: 0 4px 24px rgba(200,169,110,0.18);
    }
    .btn-rent:hover {
      background: var(--accent2);
      transform: translateY(-2px);
      box-shadow: 0 8px 32px rgba(200,169,110,0.28);
      color: #050400;
    }

    .btn-back {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 14px 24px;
      background: transparent;
      color: var(--muted2);
      font-family: var(--font-mono);
      font-size: 0.78rem;
      letter-spacing: 1.2px;
      text-transform: uppercase;
      text-decoration: none;
      border-radius: 2px;
      border: 1px solid var(--border2);
      transition: all 0.18s;
    }
    .btn-back:hover {
      color: var(--text);
      border-color: rgba(255,255,255,0.25);
      background: rgba(255,255,255,0.03);
    }

    .badge-unavail {
      display: inline-flex;
      align-items: center;
      gap: 9px;
      padding: 14px 24px;
      background: rgba(224,82,82,0.07);
      border: 1px solid rgba(224,82,82,0.22);
      color: var(--red);
      font-family: var(--font-mono);
      font-size: 0.78rem;
      letter-spacing: 0.8px;
      border-radius: 2px;
    }

    /* ─── Divider Band ─────────────────────────────── */
    .band-divider {
      max-width: 1300px;
      margin: 0 auto 0;
      padding: 0 48px;
    }

    .band-inner {
      border-top: 1px solid var(--border);
      display: flex;
      align-items: center;
      gap: 0;
      padding: 20px 0 0;
      margin-top: 48px;
    }

    .band-label {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: var(--muted);
      padding-right: 20px;
      white-space: nowrap;
    }

    .band-rule { flex: 1; height: 1px; background: var(--border); }

    /* ─── Reviews ──────────────────────────────────── */
    .reviews-wrap {
      max-width: 1300px;
      margin: 0 auto;
      padding: 40px 48px 80px;
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: 0;
    }

    .reviews-sidebar {
      padding-right: 48px;
      padding-top: 4px;
    }

    .sidebar-label {
      font-family: var(--font-display);
      font-size: 2.6rem;
      letter-spacing: 2px;
      line-height: 1;
      color: var(--text);
      text-transform: uppercase;
      margin-bottom: 8px;
    }

    .sidebar-sub {
      font-family: var(--font-mono);
      font-size: 0.7rem;
      letter-spacing: 2px;
      color: var(--muted);
      text-transform: uppercase;
    }

    .reviews-main {}

    /* Review Form */
    .form-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 3px;
      padding: 24px;
      margin-bottom: 28px;
      position: relative;
      overflow: hidden;
    }

    .form-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0;
      height: 2px;
      background: linear-gradient(90deg, var(--accent), transparent);
    }

    .form-label-sm {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted);
      display: block;
      margin-bottom: 8px;
    }

    .input-row {
      display: flex;
      gap: 12px;
      align-items: flex-start;
      flex-wrap: wrap;
    }

    .input-dark {
      background: rgba(255,255,255,0.03) !important;
      border: 1px solid var(--border2) !important;
      border-radius: 2px !important;
      color: var(--text) !important;
      font-family: var(--font-mono) !important;
      font-size: 0.82rem !important;
      transition: border-color 0.2s, background 0.2s;
      padding: 10px 13px !important;
    }
    .input-dark:focus {
      outline: none !important;
      border-color: rgba(200,169,110,0.5) !important;
      background: rgba(200,169,110,0.04) !important;
      box-shadow: none !important;
      color: var(--text) !important;
    }
    .input-dark::placeholder { color: var(--muted) !important; }

    .rating-wrap { flex: 0 0 140px; }
    .textarea-wrap { flex: 1; min-width: 200px; }

    .btn-post {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 10px 22px;
      border: none;
      border-radius: 2px;
      background: var(--accent);
      color: #0a0800;
      font-family: var(--font-mono);
      font-size: 0.72rem;
      font-weight: 500;
      letter-spacing: 1.2px;
      text-transform: uppercase;
      cursor: pointer;
      transition: background 0.18s, transform 0.15s;
      white-space: nowrap;
      align-self: stretch;
    }
    .btn-post:hover {
      background: var(--accent2);
      transform: translateY(-1px);
    }

    /* Review cards */
    .review-list { display: flex; flex-direction: column; gap: 12px; }

    .review-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 3px;
      padding: 18px 20px;
      transition: border-color 0.2s;
      position: relative;
    }
    .review-card:hover { border-color: rgba(200,169,110,0.18); }

    .review-head {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 12px;
    }

    .avatar {
      width: 34px; height: 34px;
      border-radius: 2px;
      background: var(--surface2);
      border: 1px solid var(--border2);
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: var(--font-display);
      font-size: 1.2rem;
      color: var(--accent);
      letter-spacing: 1px;
      flex-shrink: 0;
    }

    .reviewer-name {
      font-weight: 600;
      font-size: 0.88rem;
      color: var(--text);
      line-height: 1.2;
    }

    .review-date {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      color: var(--muted);
      letter-spacing: 0.3px;
    }

    .star-badge {
      margin-left: auto;
      display: flex;
      align-items: center;
      gap: 5px;
      background: rgba(200,169,110,0.08);
      border: 1px solid rgba(200,169,110,0.18);
      border-radius: 2px;
      padding: 4px 10px;
      font-family: var(--font-mono);
      font-size: 0.72rem;
      color: var(--accent);
      letter-spacing: 0.3px;
    }

    .review-body {
      font-size: 0.88rem;
      color: var(--muted2);
      line-height: 1.75;
      font-weight: 300;
    }

    /* Empty state */
    .empty-state {
      padding: 48px 24px;
      text-align: center;
      border: 1px dashed rgba(255,255,255,0.06);
      border-radius: 3px;
    }

    .empty-icon-wrap {
      width: 48px; height: 48px;
      border: 1px solid var(--border2);
      border-radius: 2px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 14px;
      color: var(--muted);
    }

    .empty-state p {
      font-family: var(--font-mono);
      font-size: 0.75rem;
      color: var(--muted);
      letter-spacing: 0.5px;
    }

    /* ─── Responsive ───────────────────────────────── */
    @media (max-width: 900px) {
      .navbar { padding: 0 20px; }
      .hero, .reviews-wrap, .band-divider { padding-left: 20px; padding-right: 20px; }
      .hero { grid-template-columns: 1fr; }
      .reviews-wrap { grid-template-columns: 1fr; }
      .poster-col { position: static; padding-right: 0; margin-bottom: 36px; display: flex; flex-direction: column; align-items: flex-start; }
      .reviews-sidebar { padding-right: 0; margin-bottom: 24px; }
      .movie-title { font-size: 3rem; }
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/home" class="nav-brand">CINERENT<span>STREAM</span></a>
  <div class="nav-right">
    <a href="/my-rentals" class="btn-nav btn-nav-ghost">
      <i class="fas fa-film" style="font-size:0.7rem;margin-right:4px;"></i> My Rentals
    </a>
    <a href="/logout" class="btn-nav btn-nav-logout">
      <i class="fas fa-right-from-bracket" style="font-size:0.7rem;margin-right:4px;"></i> Logout
    </a>
  </div>
</nav>

<!-- Hero -->
<div class="hero">

  <!-- Poster -->
  <div class="poster-col">
    <div class="poster-frame">
      <img class="poster-img"
           src="${not empty movie.posterUrl ? movie.posterUrl : 'https://picsum.photos/seed/'.concat(movie.id).concat('/300/450')}"
           alt="${movie.title}"
           onerror="this.src='https://picsum.photos/seed/${movie.id}/300/450'">
      <span class="quality-tag quality-${movie.quality == '4K' ? '4K' : movie.quality == '1080p' ? '1080p' : movie.quality == '720p' ? '720p' : '480p'}">
        ${movie.quality}
      </span>
    </div>

    <div class="avail-bar ${movie.available ? 'avail-yes' : 'avail-no'}">
      <div class="avail-dot"></div>
      ${movie.available ? 'Available to Rent' : 'Currently Rented'}
    </div>
  </div>

  <!-- Info -->
  <div class="info-col">

    <div class="eyebrow">
      <div class="eyebrow-line"></div>
      <span class="eyebrow-text">Feature Film</span>
    </div>

    <h1 class="movie-title">${movie.title}</h1>

    <div class="meta-strip">
      <span class="meta-tag">${movie.genre}</span>
      <span class="meta-tag">${movie.duration} MIN</span>
      <span class="meta-tag rating">
        <i class="fas fa-star" style="font-size:0.6rem;margin-right:4px;"></i>${movie.rating} / 5
      </span>
    </div>

    <hr class="info-rule">

    <p class="movie-desc">${not empty movie.description ? movie.description : 'No description available for this title.'}</p>

    <div class="price-block">
      <span class="price-currency">LKR</span>
      <span class="price-amount">${movie.price}</span>
      <span class="price-per">per rental</span>
    </div>

    <div class="action-row">
      <c:choose>
        <c:when test="${movie.available}">
          <a href="/payment/${movie.id}" class="btn-rent">
            <i class="fas fa-play" style="font-size:0.7rem;"></i> Rent Now
          </a>
        </c:when>
        <c:otherwise>
          <div class="badge-unavail">
            <i class="fas fa-circle-xmark" style="font-size:0.75rem;"></i> Not Available
          </div>
        </c:otherwise>
      </c:choose>
      <a href="/home" class="btn-back">
        <i class="fas fa-arrow-left" style="font-size:0.68rem;"></i> Back
      </a>
    </div>

  </div>
</div>

<!-- Band Divider -->
<div class="band-divider">
  <div class="band-inner">
    <span class="band-label">Audience Reviews</span>
    <div class="band-rule"></div>
  </div>
</div>

<!-- Reviews -->
<div class="reviews-wrap">

  <div class="reviews-sidebar">
    <div class="sidebar-label">Reviews</div>
    <div class="sidebar-sub">Community voices</div>
  </div>

  <div class="reviews-main">

    <!-- Post Review Form -->
    <div class="form-card">
      <span class="form-label-sm">Write a Review</span>
      <form method="post" action="/review/${movie.id}">
        <div class="input-row">
          <div class="rating-wrap">
            <input class="form-control input-dark"
                   name="rating" type="number"
                   min="1" max="5"
                   placeholder="Rating  1 - 5"
                   required
                   style="height:42px;">
          </div>
          <div class="textarea-wrap">
            <textarea class="form-control input-dark"
                      name="comment"
                      placeholder="Share your thoughts on this film..."
                      rows="2" required></textarea>
          </div>
          <button type="submit" class="btn-post">
            <i class="fas fa-paper-plane" style="font-size:0.65rem;"></i> Post
          </button>
        </div>
      </form>
    </div>

    <!-- Review List -->
    <c:choose>
      <c:when test="${not empty reviews}">
        <div class="review-list">
          <c:forEach var="r" items="${reviews}">
            <div class="review-card">
              <div class="review-head">
                <div class="avatar">${r.user.username.substring(0,1).toUpperCase()}</div>
                <div>
                  <div class="reviewer-name">${r.user.username}</div>
                  <div class="review-date">${r.createdAt}</div>
                </div>
                <div class="star-badge">
                  <i class="fas fa-star" style="font-size:0.6rem;"></i> ${r.rating} / 5
                </div>
              </div>
              <p class="review-body">${r.comment}</p>
            </div>
          </c:forEach>
        </div>
      </c:when>
      <c:otherwise>
        <div class="empty-state">
          <div class="empty-icon-wrap">
            <i class="far fa-comment" style="font-size:1.1rem;"></i>
          </div>
          <p>No reviews yet. Be the first to write one.</p>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</div>

</body>
</html>
