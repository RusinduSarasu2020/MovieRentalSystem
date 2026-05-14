<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>${movie.title} — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
    }

    /* ── Navbar ── */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 100;
      padding: 14px 32px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: rgba(15,12,41,0.9);
      backdrop-filter: blur(16px);
      border-bottom: 1px solid rgba(255,255,255,0.07);
    }

    .nav-brand {
      font-size: 1.5rem;
      font-weight: 800;
      text-decoration: none;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .nav-right { display: flex; align-items: center; gap: 10px; }

    .btn-nav {
      padding: 7px 18px;
      border-radius: 18px;
      font-size: 0.85rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }

    .btn-nav-outline {
      border: 1.5px solid rgba(255,255,255,0.15);
      color: #c4b8e0;
      background: transparent;
    }
    .btn-nav-outline:hover {
      border-color: rgba(238,9,121,0.45);
      color: #fff;
      background: rgba(238,9,121,0.08);
    }

    .btn-nav-warn {
      border: 1.5px solid rgba(255,193,7,0.3);
      color: #ffc107;
      background: rgba(255,193,7,0.06);
    }
    .btn-nav-warn:hover { background: rgba(255,193,7,0.14); color: #ffc107; }

    /* ── Hero Backdrop ── */
    .movie-hero {
      position: relative;
      background: linear-gradient(135deg, rgba(238,9,121,0.1) 0%, rgba(255,106,0,0.07) 100%);
      border-bottom: 1px solid rgba(255,255,255,0.06);
      padding: 48px 32px 40px;
      overflow: hidden;
    }

    .movie-hero::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(ellipse at 80% 50%, rgba(238,9,121,0.08) 0%, transparent 60%);
      pointer-events: none;
    }

    .movie-hero-inner {
      max-width: 1264px;
      margin: 0 auto;
      display: flex;
      gap: 36px;
      align-items: flex-start;
      position: relative;
    }

    /* ── Poster ── */
    .poster-wrap {
      flex-shrink: 0;
      position: relative;
      width: 240px;
    }

    .poster-img {
      width: 240px;
      height: 360px;
      object-fit: cover;
      border-radius: 16px;
      border: 1px solid rgba(255,255,255,0.08);
      display: block;
      box-shadow: 0 24px 60px rgba(0,0,0,0.6);
    }

    .quality-badge {
      position: absolute;
      top: 12px;
      left: 12px;
      padding: 4px 10px;
      border-radius: 7px;
      font-size: 0.72rem;
      font-weight: 700;
      letter-spacing: 0.3px;
    }
    .quality-4K    { background: linear-gradient(90deg,#ff6a00,#ee0979); color:#fff; }
    .quality-1080p { background: rgba(99,102,241,0.9); color:#fff; }
    .quality-720p  { background: rgba(16,185,129,0.8); color:#fff; }
    .quality-480p  { background: rgba(100,100,100,0.8); color:#fff; }

    .avail-pill {
      position: absolute;
      bottom: 12px;
      left: 50%;
      transform: translateX(-50%);
      padding: 5px 14px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 700;
      white-space: nowrap;
    }
    .avail-yes { background: rgba(34,197,94,0.2); border: 1px solid rgba(34,197,94,0.4); color: #22c55e; }
    .avail-no  { background: rgba(239,68,68,0.2); border: 1px solid rgba(239,68,68,0.4); color: #ef4444; }

    /* ── Movie Info ── */
    .movie-info { flex: 1; padding-top: 8px; }

    .movie-title-main {
      font-size: 2.4rem;
      font-weight: 800;
      line-height: 1.15;
      margin-bottom: 12px;
    }

    .meta-row {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      align-items: center;
      margin-bottom: 16px;
    }

    .meta-chip {
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.78rem;
      font-weight: 600;
      background: rgba(255,255,255,0.06);
      border: 1px solid rgba(255,255,255,0.1);
      color: #a89fc8;
    }

    .rating-chip {
      display: flex;
      align-items: center;
      gap: 5px;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.82rem;
      font-weight: 700;
      background: rgba(255,193,7,0.1);
      border: 1px solid rgba(255,193,7,0.25);
      color: #ffc107;
    }

    .movie-description {
      font-size: 0.95rem;
      color: #8a80a8;
      line-height: 1.75;
      margin-bottom: 28px;
      max-width: 660px;
    }

    .price-row {
      display: flex;
      align-items: center;
      gap: 16px;
      margin-bottom: 24px;
    }

    .movie-price {
      font-size: 2rem;
      font-weight: 800;
      background: linear-gradient(90deg,#ff6a00,#ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .price-note { font-size: 0.8rem; color: #5a5280; }

    .action-row { display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }

    .btn-rent-main {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 13px 32px;
      border-radius: 12px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.95rem;
      text-decoration: none;
      border: none;
      cursor: pointer;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 20px rgba(238,9,121,0.35);
    }
    .btn-rent-main:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 28px rgba(238,9,121,0.5);
      color: #fff;
    }

    .btn-back {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 13px 24px;
      border-radius: 12px;
      border: 1.5px solid rgba(255,255,255,0.15);
      color: #c4b8e0;
      background: transparent;
      font-weight: 600;
      font-size: 0.92rem;
      text-decoration: none;
      transition: all 0.2s;
    }
    .btn-back:hover {
      border-color: rgba(238,9,121,0.4);
      color: #fff;
      background: rgba(238,9,121,0.07);
    }

    .badge-unavail {
      display: inline-flex;
      align-items: center;
      gap: 7px;
      padding: 12px 22px;
      border-radius: 12px;
      background: rgba(239,68,68,0.12);
      border: 1.5px solid rgba(239,68,68,0.3);
      color: #ef4444;
      font-weight: 700;
      font-size: 0.9rem;
    }

    /* ── Divider ── */
    .section-divider {
      border: none;
      border-top: 1px solid rgba(255,255,255,0.06);
      margin: 0;
    }

    /* ── Reviews Section ── */
    .reviews-section {
      max-width: 1264px;
      margin: 0 auto;
      padding: 40px 32px 60px;
    }

    .section-title {
      font-size: 1.3rem;
      font-weight: 800;
      margin-bottom: 24px;
      display: flex;
      align-items: center;
      gap: 10px;
      color: #c4b8e0;
    }

    .section-title::after {
      content: '';
      flex: 1;
      height: 1px;
      background: rgba(255,255,255,0.06);
    }

    /* Review Form */
    .review-form-card {
      background: #1a1740;
      border: 1px solid rgba(255,255,255,0.07);
      border-radius: 16px;
      padding: 24px;
      margin-bottom: 32px;
    }

    .review-form-title {
      font-size: 0.9rem;
      font-weight: 700;
      color: #7a6fa0;
      margin-bottom: 16px;
      text-transform: uppercase;
      letter-spacing: 0.6px;
    }

    .review-form-row {
      display: flex;
      gap: 12px;
      align-items: flex-start;
      flex-wrap: wrap;
    }

    .form-control-dark {
      background: rgba(255,255,255,0.05) !important;
      border: 1.5px solid rgba(255,255,255,0.1) !important;
      border-radius: 10px !important;
      color: #fff !important;
      font-size: 0.88rem;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .form-control-dark:focus {
      outline: none !important;
      border-color: rgba(238,9,121,0.55) !important;
      box-shadow: 0 0 0 3px rgba(238,9,121,0.1) !important;
      background: rgba(255,255,255,0.07) !important;
    }
    .form-control-dark::placeholder { color: #5a5280 !important; }

    .rating-input-wrap { flex: 0 0 130px; }
    .textarea-wrap { flex: 1; min-width: 220px; }

    .btn-post-review {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 7px;
      padding: 11px 26px;
      border: none;
      border-radius: 10px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.88rem;
      cursor: pointer;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 14px rgba(238,9,121,0.25);
      white-space: nowrap;
      align-self: stretch;
    }
    .btn-post-review:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(238,9,121,0.4);
    }

    /* Review Cards */
    .reviews-list { display: flex; flex-direction: column; gap: 14px; }

    .review-card {
      background: #1a1740;
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: 14px;
      padding: 18px 20px;
      transition: border-color 0.2s;
    }
    .review-card:hover { border-color: rgba(238,9,121,0.2); }

    .review-header {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 10px;
    }

    .reviewer-avatar {
      width: 36px; height: 36px;
      border-radius: 50%;
      background: linear-gradient(135deg, #ff6a00, #ee0979);
      display: flex; align-items: center; justify-content: center;
      font-size: 0.82rem; font-weight: 700; color: #fff;
      flex-shrink: 0;
    }

    .reviewer-name {
      font-weight: 700;
      font-size: 0.92rem;
    }

    .review-date {
      font-size: 0.76rem;
      color: #5a5280;
    }

    .review-stars {
      margin-left: auto;
      display: flex;
      align-items: center;
      gap: 5px;
      background: rgba(255,193,7,0.1);
      border: 1px solid rgba(255,193,7,0.2);
      border-radius: 16px;
      padding: 3px 10px;
      font-size: 0.8rem;
      font-weight: 700;
      color: #ffc107;
    }

    .review-comment {
      font-size: 0.9rem;
      color: #8a80a8;
      line-height: 1.65;
    }

    .empty-reviews {
      text-align: center;
      padding: 50px 20px;
      background: rgba(26,23,64,0.5);
      border: 1px dashed rgba(255,255,255,0.07);
      border-radius: 16px;
    }
    .empty-reviews .empty-icon { font-size: 2.5rem; opacity: 0.35; margin-bottom: 12px; }
    .empty-reviews p { color: #5a5280; font-size: 0.9rem; }

    /* ── Scrollbar ── */
    ::-webkit-scrollbar { width: 6px; }
    ::-webkit-scrollbar-track { background: #0f0c29; }
    ::-webkit-scrollbar-thumb { background: #302b63; border-radius: 3px; }
    ::-webkit-scrollbar-thumb:hover { background: #ee0979; }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/home" class="nav-brand">🎬 CineRent</a>
  <div class="nav-right">
    <a href="/my-rentals" class="btn-nav btn-nav-outline">
      <i class="fas fa-film"></i> My Rentals
    </a>
    <a href="/logout" class="btn-nav btn-nav-warn">
      <i class="fas fa-right-from-bracket"></i> Logout
    </a>
  </div>
</nav>

<!-- Movie Hero -->
<div class="movie-hero">
  <div class="movie-hero-inner">

    <!-- Poster -->
    <div class="poster-wrap">
      <img class="poster-img"
           src="${not empty movie.posterUrl ? movie.posterUrl : 'https://picsum.photos/seed/'.concat(movie.id).concat('/300/450')}"
           alt="${movie.title}"
           onerror="this.src='https://picsum.photos/seed/${movie.id}/300/450'">
      <span class="quality-badge quality-${movie.quality == '4K' ? '4K' : movie.quality == '1080p' ? '1080p' : movie.quality == '720p' ? '720p' : '480p'}">
        ${movie.quality}
      </span>
      <span class="avail-pill ${movie.available ? 'avail-yes' : 'avail-no'}">
        ${movie.available ? '● Available' : '● Currently Rented'}
      </span>
    </div>

    <!-- Info -->
    <div class="movie-info">
      <h1 class="movie-title-main">${movie.title}</h1>

      <div class="meta-row">
        <span class="meta-chip"><i class="fas fa-tag" style="font-size:0.72rem;margin-right:4px;"></i>${movie.genre}</span>
        <span class="meta-chip"><i class="fas fa-clock" style="font-size:0.72rem;margin-right:4px;"></i>${movie.duration} min</span>
        <span class="rating-chip"><i class="fas fa-star"></i>${movie.rating} / 5</span>
      </div>

      <p class="movie-description">${not empty movie.description ? movie.description : 'No description available for this title.'}</p>

      <div class="price-row">
        <span class="movie-price">Rs ${movie.price}</span>
        <span class="price-note">/ rental</span>
      </div>

      <div class="action-row">
        <c:choose>
          <c:when test="${movie.available}">
            <a href="/payment/${movie.id}" class="btn-rent-main">
              <i class="fas fa-play-circle"></i> Rent Now
            </a>
          </c:when>
          <c:otherwise>
            <div class="badge-unavail">
              <i class="fas fa-circle-xmark"></i> Currently Rented — Not Available
            </div>
          </c:otherwise>
        </c:choose>
        <a href="/home" class="btn-back">
          <i class="fas fa-arrow-left"></i> Back
        </a>
      </div>
    </div>

  </div>
</div>

<hr class="section-divider">

<!-- Reviews -->
<div class="reviews-section">

  <div class="section-title">
    <i class="fas fa-comments" style="font-size:1rem; background:linear-gradient(90deg,#ff6a00,#ee0979);-webkit-background-clip:text;-webkit-text-fill-color:transparent;"></i>
    Reviews
  </div>

  <!-- Post Review Form -->
  <div class="review-form-card">
    <div class="review-form-title">Write a Review</div>
    <form method="post" action="/review/${movie.id}">
      <div class="review-form-row">
        <div class="rating-input-wrap">
          <input class="form-control form-control-dark" name="rating" type="number"
                 min="1" max="5" placeholder="Rating (1–5)" required
                 style="height:44px;">
        </div>
        <div class="textarea-wrap">
          <textarea class="form-control form-control-dark" name="comment"
                    placeholder="Share your thoughts about this movie..."
                    rows="2" required></textarea>
        </div>
        <button type="submit" class="btn-post-review">
          <i class="fas fa-paper-plane"></i> Post Review
        </button>
      </div>
    </form>
  </div>

  <!-- Reviews List -->
  <c:choose>
    <c:when test="${not empty reviews}">
      <div class="reviews-list">
        <c:forEach var="r" items="${reviews}">
          <div class="review-card">
            <div class="review-header">
              <div class="reviewer-avatar">
                ${r.user.username.substring(0,1).toUpperCase()}
              </div>
              <div>
                <div class="reviewer-name">${r.user.username}</div>
                <div class="review-date">${r.createdAt}</div>
              </div>
              <div class="review-stars">
                <i class="fas fa-star"></i> ${r.rating}/5
              </div>
            </div>
            <p class="review-comment">${r.comment}</p>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <div class="empty-reviews">
        <div class="empty-icon">💬</div>
        <p>No reviews yet — be the first to share your thoughts!</p>
      </div>
    </c:otherwise>
  </c:choose>

</div>

</body>
</html>
