<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>CineRent — Home</title>
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

    .nav-user {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 0.88rem;
      color: #a89fc8;
      margin-right: 6px;
    }

    .nav-user .avatar {
      width: 32px; height: 32px;
      border-radius: 50%;
      background: linear-gradient(135deg,#ff6a00,#ee0979);
      display: flex; align-items: center; justify-content: center;
      font-size: 0.8rem; font-weight: 700; color: #fff;
    }

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
    .btn-nav-warn:hover {
      background: rgba(255,193,7,0.14);
      color: #ffc107;
    }

    /* ── Hero Banner ── */
    .home-hero {
      background: linear-gradient(135deg, rgba(238,9,121,0.12) 0%, rgba(255,106,0,0.08) 100%);
      border-bottom: 1px solid rgba(255,255,255,0.06);
      padding: 40px 32px 32px;
      text-align: center;
    }

    .home-hero h2 {
      font-size: 2rem;
      font-weight: 800;
      margin-bottom: 6px;
    }

    .home-hero h2 span {
      background: linear-gradient(90deg,#ff6a00,#ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .home-hero p { color: #7a6fa0; font-size: 0.95rem; }

    /* ── Search & Filter Bar ── */
    .filter-bar {
      background: rgba(26,23,64,0.8);
      backdrop-filter: blur(12px);
      border-bottom: 1px solid rgba(255,255,255,0.06);
      padding: 18px 32px;
      position: sticky;
      top: 65px;
      z-index: 90;
    }

    .filter-row {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      align-items: center;
      max-width: 1200px;
      margin: 0 auto;
    }

    .filter-input-wrap {
      position: relative;
      flex: 2;
      min-width: 180px;
    }

    .filter-input-wrap i {
      position: absolute;
      left: 12px;
      top: 50%;
      transform: translateY(-50%);
      color: #5a5280;
      font-size: 0.85rem;
      pointer-events: none;
    }

    .form-control, .form-select {
      background: rgba(255,255,255,0.05) !important;
      border: 1.5px solid rgba(255,255,255,0.1) !important;
      border-radius: 10px !important;
      color: #fff !important;
      font-size: 0.88rem;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .filter-input-wrap .form-control {
      padding-left: 34px;
    }

    .form-control:focus, .form-select:focus {
      outline: none !important;
      border-color: rgba(238,9,121,0.55) !important;
      box-shadow: 0 0 0 3px rgba(238,9,121,0.1) !important;
      background: rgba(255,255,255,0.07) !important;
    }

    .form-control::placeholder { color: #5a5280 !important; }

    .form-select option {
      background: #1a1740;
      color: #fff;
    }

    .btn-search {
      padding: 9px 24px;
      border: none;
      border-radius: 10px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.88rem;
      cursor: pointer;
      white-space: nowrap;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 14px rgba(238,9,121,0.3);
    }

    .btn-search:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(238,9,121,0.45);
    }

    .btn-clear {
      padding: 9px 16px;
      border-radius: 10px;
      border: 1.5px solid rgba(255,255,255,0.1);
      background: transparent;
      color: #7a6fa0;
      font-size: 0.85rem;
      cursor: pointer;
      text-decoration: none;
      transition: all 0.2s;
    }
    .btn-clear:hover { color: #ee0979; border-color: rgba(238,9,121,0.3); }

    /* ── Genre Tabs ── */
    .genre-tabs {
      padding: 16px 32px 0;
      display: flex;
      gap: 8px;
      overflow-x: auto;
      scrollbar-width: none;
      max-width: 1264px;
      margin: 0 auto;
    }
    .genre-tabs::-webkit-scrollbar { display: none; }

    .genre-tab {
      padding: 6px 16px;
      border-radius: 16px;
      border: 1.5px solid rgba(255,255,255,0.08);
      background: rgba(255,255,255,0.03);
      color: #7a6fa0;
      font-size: 0.82rem;
      font-weight: 600;
      white-space: nowrap;
      cursor: pointer;
      text-decoration: none;
      transition: all 0.2s;
    }
    .genre-tab:hover, .genre-tab.active {
      background: rgba(238,9,121,0.12);
      border-color: rgba(238,9,121,0.4);
      color: #fff;
    }

    /* ── Main Content ── */
    .main-content {
      max-width: 1264px;
      margin: 0 auto;
      padding: 28px 32px 60px;
    }

    .results-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 22px;
    }

    .results-title {
      font-size: 1.1rem;
      font-weight: 700;
      color: #c4b8e0;
    }

    .results-count {
      font-size: 0.82rem;
      color: #5a5280;
    }

    /* Sort dropdown */
    .sort-select {
      background: rgba(255,255,255,0.05) !important;
      border: 1.5px solid rgba(255,255,255,0.1) !important;
      border-radius: 8px !important;
      color: #a89fc8 !important;
      font-size: 0.82rem;
      padding: 6px 12px;
    }

    /* ── Movie Cards ── */
    .movies-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
      gap: 22px;
    }

    .card-movie {
      background: #1a1740;
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: 16px;
      overflow: hidden;
      transition: transform 0.28s ease, box-shadow 0.28s ease, border-color 0.28s;
      cursor: pointer;
      position: relative;
    }

    .card-movie:hover {
      transform: translateY(-8px) scale(1.01);
      box-shadow: 0 20px 50px rgba(238,9,121,0.25);
      border-color: rgba(238,9,121,0.3);
    }

    .movie-poster-wrap {
      position: relative;
      overflow: hidden;
    }

    .movie-poster {
      width: 100%;
      height: 300px;
      object-fit: cover;
      display: block;
      transition: transform 0.4s ease;
    }

    .card-movie:hover .movie-poster {
      transform: scale(1.05);
    }

    /* Overlay on hover */
    .poster-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(to top, rgba(15,12,41,0.95) 0%, rgba(15,12,41,0.2) 60%, transparent 100%);
      opacity: 0;
      transition: opacity 0.3s;
      display: flex;
      align-items: flex-end;
      justify-content: center;
      padding-bottom: 16px;
    }

    .card-movie:hover .poster-overlay { opacity: 1; }

    .overlay-btn {
      display: flex;
      align-items: center;
      gap: 6px;
      padding: 10px 24px;
      border-radius: 20px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.88rem;
      text-decoration: none;
      box-shadow: 0 4px 16px rgba(238,9,121,0.4);
      transform: translateY(10px);
      transition: transform 0.3s;
    }

    .card-movie:hover .overlay-btn { transform: translateY(0); }

    /* Quality badge */
    .quality-badge {
      position: absolute;
      top: 10px;
      left: 10px;
      padding: 3px 8px;
      border-radius: 6px;
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.3px;
    }

    .quality-4K  { background: linear-gradient(90deg,#ff6a00,#ee0979); color:#fff; }
    .quality-1080p { background: rgba(99,102,241,0.85); color:#fff; }
    .quality-720p  { background: rgba(16,185,129,0.75); color:#fff; }
    .quality-480p  { background: rgba(100,100,100,0.7); color:#fff; }

    /* Available badge */
    .avail-badge {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 10px; height: 10px;
      border-radius: 50%;
      border: 2px solid #0f0c29;
    }
    .avail-yes { background: #22c55e; }
    .avail-no  { background: #ef4444; }

    .card-body-movie {
      padding: 14px 14px 16px;
    }

    .movie-title {
      font-size: 0.95rem;
      font-weight: 700;
      margin-bottom: 5px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .movie-meta {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 0.76rem;
      color: #6e658f;
      margin-bottom: 4px;
      flex-wrap: wrap;
    }

    .movie-meta .dot { color: #3d3660; }

    .movie-rating {
      display: flex;
      align-items: center;
      gap: 4px;
      font-size: 0.78rem;
      color: #ffc107;
      font-weight: 600;
      margin-bottom: 12px;
    }

    .movie-price {
      font-size: 1rem;
      font-weight: 800;
      background: linear-gradient(90deg,#ff6a00,#ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .btn-rent {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
      width: 100%;
      padding: 9px;
      border: none;
      border-radius: 10px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.85rem;
      text-decoration: none;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 14px rgba(238,9,121,0.25);
    }

    .btn-rent:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(238,9,121,0.4);
      color: #fff;
    }

    /* ── Empty State ── */
    .empty-state {
      grid-column: 1/-1;
      text-align: center;
      padding: 80px 20px;
    }

    .empty-icon {
      font-size: 3.5rem;
      margin-bottom: 16px;
      opacity: 0.4;
    }

    .empty-state h4 { font-size: 1.2rem; color: #5a5280; margin-bottom: 8px; }
    .empty-state p  { font-size: 0.88rem; color: #3d3660; }

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
    <div class="nav-user">
      <div class="avatar">${not empty sessionScope.username ? sessionScope.username.substring(0,1).toUpperCase() : 'U'}</div>
      <span>${not empty sessionScope.username ? sessionScope.username : 'User'}</span>
    </div>
    <a href="/my-rentals" class="btn-nav btn-nav-outline">
      <i class="fas fa-film"></i> My Rentals
    </a>
    <a href="/logout" class="btn-nav btn-nav-warn">
      <i class="fas fa-right-from-bracket"></i> Logout
    </a>
  </div>
</nav>

<!-- Hero Banner -->
<div class="home-hero">
  <h2>Browse <span>Movies</span></h2>
  <p>Thousands of titles ready to stream — pick yours.</p>
</div>

<!-- Filter Bar -->
<div class="filter-bar">
  <form class="filter-row" method="get" action="/home">
    <div class="filter-input-wrap">
      <i class="fas fa-magnifying-glass"></i>
      <input class="form-control" name="q" placeholder="Search title..." value="${param.q}">
    </div>

    <select class="form-select" name="genre" style="flex:1;min-width:130px;">
      <option value="">All Genres</option>
      <c:forEach var="g" items="${['Scifi','Horror','Documentary','Family','Child','Comedy','Adventure','Crime','Thriller','Psychological']}">
        <option <c:if test="${param.genre == g}">selected</c:if>>${g}</option>
      </c:forEach>
    </select>

    <select class="form-select" name="quality" style="flex:1;min-width:120px;">
      <option value="">Any Quality</option>
      <option <c:if test="${param.quality == '480p'}">selected</c:if> value="480p">480p</option>
      <option <c:if test="${param.quality == '720p'}">selected</c:if> value="720p">720p</option>
      <option <c:if test="${param.quality == '1080p'}">selected</c:if> value="1080p">1080p</option>
      <option <c:if test="${param.quality == '4K'}">selected</c:if> value="4K">4K</option>
    </select>

    <input class="form-control" name="minRating" type="number" step="0.1"
           placeholder="Min ⭐" value="${param.minRating}" style="flex:0.8;min-width:100px;">

    <input class="form-control" name="maxDuration" type="number"
           placeholder="Max mins" value="${param.maxDuration}" style="flex:0.8;min-width:100px;">

    <button type="submit" class="btn-search">
      <i class="fas fa-search"></i> Search
    </button>
    <a href="/home" class="btn-clear">
      <i class="fas fa-xmark"></i> Clear
    </a>
  </form>
</div>

<!-- Genre Tabs -->
<div style="background:#0f0c29; padding-bottom:4px;">
  <div class="genre-tabs">
    <a href="/home" class="genre-tab ${empty param.genre ? 'active' : ''}">All</a>
    <a href="/home?genre=Scifi"          class="genre-tab ${param.genre == 'Scifi'          ? 'active' : ''}">🚀 Sci-Fi</a>
    <a href="/home?genre=Horror"         class="genre-tab ${param.genre == 'Horror'         ? 'active' : ''}">😱 Horror</a>
    <a href="/home?genre=Comedy"         class="genre-tab ${param.genre == 'Comedy'         ? 'active' : ''}">😂 Comedy</a>
    <a href="/home?genre=Thriller"       class="genre-tab ${param.genre == 'Thriller'       ? 'active' : ''}">🎬 Thriller</a>
    <a href="/home?genre=Adventure"      class="genre-tab ${param.genre == 'Adventure'      ? 'active' : ''}">🏄 Adventure</a>
    <a href="/home?genre=Crime"          class="genre-tab ${param.genre == 'Crime'          ? 'active' : ''}">🔍 Crime</a>
    <a href="/home?genre=Family"         class="genre-tab ${param.genre == 'Family'         ? 'active' : ''}">👨‍👩‍👧 Family</a>
    <a href="/home?genre=Documentary"    class="genre-tab ${param.genre == 'Documentary'    ? 'active' : ''}">🎥 Documentary</a>
    <a href="/home?genre=Psychological"  class="genre-tab ${param.genre == 'Psychological'  ? 'active' : ''}">🧠 Psychological</a>
  </div>
</div>

<!-- Main Content -->
<div class="main-content">

  <div class="results-header">
    <div>
      <div class="results-title">
        <c:choose>
          <c:when test="${not empty param.genre}">${param.genre} Movies</c:when>
          <c:when test="${not empty param.q}">Results for "${param.q}"</c:when>
          <c:otherwise>All Movies</c:otherwise>
        </c:choose>
      </div>
      <div class="results-count">
        <c:if test="${not empty movies}">${movies.size()} title(s) found</c:if>
      </div>
    </div>
    <select class="sort-select form-select" style="width:auto;" onchange="sortMovies(this.value)">
      <option value="">Sort By</option>
      <option value="rating">⭐ Rating</option>
      <option value="price">💰 Price</option>
      <option value="duration">⏱ Duration</option>
    </select>
  </div>

  <div class="movies-grid" id="moviesGrid">
    <c:forEach var="m" items="${movies}">
      <div class="card-movie">
        <div class="movie-poster-wrap">
          <img class="movie-poster"
               src="${not empty m.posterUrl ? m.posterUrl : 'https://picsum.photos/seed/'.concat(m.id).concat('/300/450')}"
               alt="${m.title}"
               onerror="this.src='https://picsum.photos/seed/${m.id}/300/450'">

          <!-- Quality Badge -->
          <span class="quality-badge quality-${m.quality == '4K' ? '4K' : m.quality == '1080p' ? '1080p' : m.quality == '720p' ? '720p' : '480p'}">
            ${m.quality}
          </span>

          <!-- Availability dot -->
          <span class="avail-badge ${m.available ? 'avail-yes' : 'avail-no'}"
                title="${m.available ? 'Available' : 'Unavailable'}"></span>

          <!-- Hover overlay -->
          <div class="poster-overlay">
            <a href="/movie/${m.id}" class="overlay-btn">
              <i class="fas fa-circle-play"></i> View Details
            </a>
          </div>
        </div>

        <div class="card-body-movie">
          <div class="movie-title" title="${m.title}">${m.title}</div>
          <div class="movie-meta">
            <span>${m.genre}</span>
            <span class="dot">·</span>
            <span>${m.duration} min</span>
          </div>
          <div class="movie-rating">
            <i class="fas fa-star"></i>
            <span>${m.rating}</span>
          </div>
          <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px;">
            <span class="movie-price">Rs ${m.price}</span>
            <span style="font-size:0.72rem; color:${m.available ? '#22c55e' : '#ef4444'};">
              ${m.available ? '● Available' : '● Rented'}
            </span>
          </div>
          <a href="/movie/${m.id}" class="btn-rent">
            <i class="fas fa-play"></i> Rent Now
          </a>
        </div>
      </div>
    </c:forEach>

    <c:if test="${empty movies}">
      <div class="empty-state">
        <div class="empty-icon">🎬</div>
        <h4>No movies found</h4>
        <p>Try adjusting your search filters or <a href="/home" style="color:#ee0979;">browse all movies</a>.</p>
      </div>
    </c:if>
  </div>
</div>

<script>
  function sortMovies(by) {
    if (!by) return;
    const grid = document.getElementById('moviesGrid');
    const cards = Array.from(grid.querySelectorAll('.card-movie'));
    cards.sort((a, b) => {
      if (by === 'rating') {
        const ra = parseFloat(a.querySelector('.movie-rating span')?.textContent || 0);
        const rb = parseFloat(b.querySelector('.movie-rating span')?.textContent || 0);
        return rb - ra;
      }
      if (by === 'price') {
        const pa = parseFloat(a.querySelector('.movie-price')?.textContent.replace('Rs ','') || 0);
        const pb = parseFloat(b.querySelector('.movie-price')?.textContent.replace('Rs ','') || 0);
        return pa - pb;
      }
      if (by === 'duration') {
        const da = parseInt(a.querySelector('.movie-meta span:nth-child(3)')?.textContent || 0);
        const db = parseInt(b.querySelector('.movie-meta span:nth-child(3)')?.textContent || 0);
        return da - db;
      }
      return 0;
    });
    cards.forEach(c => grid.appendChild(c));
  }
</script>

</body>
</html>
