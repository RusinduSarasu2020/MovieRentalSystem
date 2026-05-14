<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Rentals — CineRent</title>
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
    .btn-nav-warn:hover { background: rgba(255,193,7,0.14); color: #ffc107; }

    /* ── Page Hero ── */
    .page-hero {
      background: linear-gradient(135deg, rgba(238,9,121,0.1) 0%, rgba(255,106,0,0.07) 100%);
      border-bottom: 1px solid rgba(255,255,255,0.06);
      padding: 36px 32px 28px;
      text-align: center;
    }

    .page-hero h2 {
      font-size: 2rem;
      font-weight: 800;
      margin-bottom: 6px;
    }

    .page-hero h2 span {
      background: linear-gradient(90deg,#ff6a00,#ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .page-hero p { color: #7a6fa0; font-size: 0.95rem; }

    /* ── Main Content ── */
    .main-content {
      max-width: 1264px;
      margin: 0 auto;
      padding: 36px 32px 60px;
    }

    /* ── Stats Row ── */
    .stats-row {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
      gap: 14px;
      margin-bottom: 36px;
    }

    .stat-card {
      background: #1a1740;
      border: 1px solid rgba(255,255,255,0.07);
      border-radius: 14px;
      padding: 18px 20px;
      text-align: center;
      transition: border-color 0.2s;
    }
    .stat-card:hover { border-color: rgba(238,9,121,0.25); }

    .stat-value {
      font-size: 1.8rem;
      font-weight: 800;
      background: linear-gradient(90deg,#ff6a00,#ee0979);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin-bottom: 4px;
    }

    .stat-label {
      font-size: 0.78rem;
      color: #5a5280;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    /* ── Rental Cards ── */
    .rentals-list { display: flex; flex-direction: column; gap: 14px; }

    .rental-card {
      background: #1a1740;
      border: 1px solid rgba(255,255,255,0.06);
      border-radius: 16px;
      padding: 20px 24px;
      display: flex;
      align-items: center;
      gap: 20px;
      transition: border-color 0.25s, transform 0.25s;
    }
    .rental-card:hover {
      border-color: rgba(238,9,121,0.22);
      transform: translateX(4px);
    }

    /* Mini poster thumbnail */
    .rental-thumb {
      width: 56px;
      height: 80px;
      border-radius: 8px;
      object-fit: cover;
      flex-shrink: 0;
      border: 1px solid rgba(255,255,255,0.08);
    }

    .rental-thumb-placeholder {
      width: 56px;
      height: 80px;
      border-radius: 8px;
      background: #26235c;
      border: 1px solid rgba(255,255,255,0.08);
      flex-shrink: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.4rem;
    }

    .rental-main { flex: 1; min-width: 0; }

    .rental-title {
      font-size: 1rem;
      font-weight: 700;
      margin-bottom: 4px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .rental-sub {
      font-size: 0.78rem;
      color: #6e658f;
      margin-bottom: 12px;
      display: flex;
      gap: 6px;
      align-items: center;
    }

    .rental-sub .dot { color: #3d3660; }

    .rental-dates {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
    }

    .date-item { font-size: 0.78rem; }
    .date-label { color: #5a5280; margin-bottom: 2px; }
    .date-value { color: #a89fc8; font-weight: 600; }

    /* Status badge */
    .status-badge {
      padding: 5px 14px;
      border-radius: 16px;
      font-size: 0.76rem;
      font-weight: 700;
      white-space: nowrap;
    }

    .status-active {
      background: rgba(238,9,121,0.12);
      border: 1px solid rgba(238,9,121,0.3);
      color: #ee0979;
    }

    .status-returned {
      background: rgba(34,197,94,0.1);
      border: 1px solid rgba(34,197,94,0.25);
      color: #22c55e;
    }

    /* Late fee */
    .late-fee {
      font-size: 0.82rem;
      font-weight: 700;
      color: #ef4444;
      background: rgba(239,68,68,0.1);
      border: 1px solid rgba(239,68,68,0.2);
      border-radius: 8px;
      padding: 4px 10px;
      white-space: nowrap;
    }

    .no-fee {
      font-size: 0.8rem;
      color: #3d3660;
    }

    .rental-actions { display: flex; flex-direction: column; gap: 8px; align-items: flex-end; flex-shrink: 0; }

    .btn-watch {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 9px 20px;
      border: none;
      border-radius: 10px;
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      color: #fff;
      font-weight: 700;
      font-size: 0.85rem;
      text-decoration: none;
      transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 14px rgba(238,9,121,0.22);
      white-space: nowrap;
    }
    .btn-watch:hover {
      transform: translateY(-1px);
      box-shadow: 0 6px 20px rgba(238,9,121,0.38);
      color: #fff;
    }

    /* ── Empty State ── */
    .empty-state {
      text-align: center;
      padding: 80px 20px;
      background: rgba(26,23,64,0.4);
      border: 1px dashed rgba(255,255,255,0.07);
      border-radius: 20px;
    }

    .empty-icon { font-size: 3.5rem; margin-bottom: 16px; opacity: 0.35; }
    .empty-state h4 { font-size: 1.2rem; color: #5a5280; margin-bottom: 8px; }
    .empty-state p  { font-size: 0.88rem; color: #3d3660; margin-bottom: 20px; }

    .btn-browse {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 11px 28px;
      border-radius: 12px;
      border: 1.5px solid rgba(255,255,255,0.15);
      color: #c4b8e0;
      background: transparent;
      font-weight: 600;
      font-size: 0.9rem;
      text-decoration: none;
      transition: all 0.2s;
    }
    .btn-browse:hover {
      border-color: rgba(238,9,121,0.4);
      color: #fff;
      background: rgba(238,9,121,0.07);
    }

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
    <a href="/home" class="btn-nav btn-nav-outline">
      <i class="fas fa-home"></i> Browse
    </a>
    <a href="/logout" class="btn-nav btn-nav-warn">
      <i class="fas fa-right-from-bracket"></i> Logout
    </a>
  </div>
</nav>

<!-- Page Hero -->
<div class="page-hero">
  <h2>My <span>Rentals</span></h2>
  <p>Track your active and past movie rentals.</p>
</div>

<!-- Main Content -->
<div class="main-content">

  <c:choose>
    <c:when test="${not empty rentals}">

      <!-- Stats Summary -->
      <div class="stats-row">
        <div class="stat-card">
          <div class="stat-value">${rentals.size()}</div>
          <div class="stat-label">Total Rentals</div>
        </div>
        <div class="stat-card">
          <div class="stat-value" style="color:#ee0979;-webkit-text-fill-color:#ee0979;background:none;">
            <c:set var="activeCount" value="0"/>
            <c:forEach var="r" items="${rentals}">
              <c:if test="${r.status == 'ACTIVE'}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if>
            </c:forEach>
            ${activeCount}
          </div>
          <div class="stat-label">Active</div>
        </div>
        <div class="stat-card">
          <div class="stat-value" style="color:#22c55e;-webkit-text-fill-color:#22c55e;background:none;">
            <c:set var="returnedCount" value="0"/>
            <c:forEach var="r" items="${rentals}">
              <c:if test="${r.status != 'ACTIVE'}"><c:set var="returnedCount" value="${returnedCount + 1}"/></c:if>
            </c:forEach>
            ${returnedCount}
          </div>
          <div class="stat-label">Returned</div>
        </div>
      </div>

      <!-- Rental Cards -->
      <div class="rentals-list">
        <c:forEach var="r" items="${rentals}">
          <div class="rental-card">

            <!-- Thumbnail -->
            <c:choose>
              <c:when test="${not empty r.movie.posterUrl}">
                <img class="rental-thumb"
                     src="${r.movie.posterUrl}"
                     alt="${r.movie.title}"
                     onerror="this.src='https://picsum.photos/seed/${r.movie.id}/56/80'">
              </c:when>
              <c:otherwise>
                <div class="rental-thumb-placeholder">🎬</div>
              </c:otherwise>
            </c:choose>

            <!-- Info -->
            <div class="rental-main">
              <div class="rental-title">${r.movie.title}</div>
              <div class="rental-sub">
                <span>${r.movie.genre}</span>
                <span class="dot">·</span>
                <span>${r.movie.quality}</span>
              </div>
              <div class="rental-dates">
                <div class="date-item">
                  <div class="date-label">Rented On</div>
                  <div class="date-value">${r.rentalDate}</div>
                </div>
                <div class="date-item">
                  <div class="date-label">Due Date</div>
                  <div class="date-value">${r.dueDate}</div>
                </div>
                <c:if test="${r.returnDate != null}">
                  <div class="date-item">
                    <div class="date-label">Returned</div>
                    <div class="date-value">${r.returnDate}</div>
                  </div>
                </c:if>
              </div>
            </div>

            <!-- Status + Fee -->
            <div style="display:flex; flex-direction:column; gap:8px; align-items:center;">
              <c:choose>
                <c:when test="${r.status == 'ACTIVE'}">
                  <span class="status-badge status-active">● ACTIVE</span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge status-returned">✓ RETURNED</span>
                </c:otherwise>
              </c:choose>
              <c:choose>
                <c:when test="${r.lateFee > 0}">
                  <span class="late-fee"><i class="fas fa-triangle-exclamation"></i> Rs ${r.lateFee}</span>
                </c:when>
                <c:otherwise>
                  <span class="no-fee">No late fee</span>
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Actions -->
            <div class="rental-actions">
              <a class="btn-watch" href="/watch/${r.movie.id}">
                <i class="fas fa-play"></i> Watch
              </a>
            </div>

          </div>
        </c:forEach>
      </div>

    </c:when>
    <c:otherwise>
      <!-- Empty State -->
      <div class="empty-state">
        <div class="empty-icon">📦</div>
        <h4>No rentals yet</h4>
        <p>You haven't rented any movies. Start browsing to find something great!</p>
        <a href="/home" class="btn-browse">
          <i class="fas fa-film"></i> Browse Movies
        </a>
      </div>
    </c:otherwise>
  </c:choose>

</div>

</body>
</html>
