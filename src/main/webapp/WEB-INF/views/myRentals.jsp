<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Rentals — CineRent</title>
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

    /* Noise Grain */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 9999;
      opacity: 0.5;
    }

    /* Scrollbar */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: #2a2740; border-radius: 3px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--accent); }

    /* Navbar */
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

    /* Page Header */
    .page-header {
      max-width: 1300px;
      margin: 0 auto;
      padding: 56px 48px 0;
    }

    .eyebrow {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 16px;
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

    .page-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 5vw, 5rem);
      line-height: 0.93;
      letter-spacing: 2px;
      color: var(--text);
      text-transform: uppercase;
      margin-bottom: 40px;
    }

    .page-title span {
      color: var(--accent);
    }

    /* Stats Row */
    .stats-band {
      max-width: 1300px;
      margin: 0 auto;
      padding: 0 48px 48px;
    }

    .stats-inner {
      border-top: 1px solid var(--border);
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 0;
      padding-top: 28px;
    }

    .stat-item {
      padding: 0 32px 0 0;
      position: relative;
    }

    .stat-item + .stat-item {
      padding-left: 32px;
      border-left: 1px solid var(--border);
    }

    .stat-num {
      font-family: var(--font-display);
      font-size: 3.8rem;
      line-height: 1;
      letter-spacing: 1px;
      margin-bottom: 4px;
    }

    .stat-num.total  { color: var(--text); }
    .stat-num.active { color: var(--accent); }
    .stat-num.done   { color: var(--green); }

    .stat-label {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 2.5px;
      text-transform: uppercase;
      color: var(--muted);
    }

    /* Band Divider */
    .band-divider {
      max-width: 1300px;
      margin: 0 auto;
      padding: 0 48px 40px;
      display: flex;
      align-items: center;
      gap: 0;
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

    /* Main Content */
    .main-wrap {
      max-width: 1300px;
      margin: 0 auto;
      padding: 0 48px 80px;
    }

    /* Rental Card */
    .rentals-list { display: flex; flex-direction: column; gap: 10px; }

    .rental-card {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 3px;
      padding: 22px 24px;
      display: grid;
      grid-template-columns: 56px 1fr auto auto auto;
      align-items: center;
      gap: 22px;
      transition: border-color 0.2s;
      position: relative;
      overflow: hidden;
    }

    .rental-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0;
      width: 2px;
      height: 100%;
      background: var(--border);
      transition: background 0.2s;
    }

    .rental-card:hover { border-color: rgba(200,169,110,0.2); }
    .rental-card:hover::before { background: var(--accent); }

    /* Poster Thumb */
    .rental-thumb {
      width: 56px;
      height: 80px;
      object-fit: cover;
      border-radius: 2px;
      border: 1px solid rgba(255,255,255,0.06);
      display: block;
      flex-shrink: 0;
    }

    .rental-thumb-placeholder {
      width: 56px;
      height: 80px;
      border-radius: 2px;
      background: var(--surface2);
      border: 1px solid var(--border2);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }

    .thumb-icon {
      width: 18px; height: 18px;
      color: var(--muted);
    }

    /* Info */
    .rental-info { min-width: 0; }

    .rental-title {
      font-family: var(--font-display);
      font-size: 1.45rem;
      letter-spacing: 1px;
      color: var(--text);
      text-transform: uppercase;
      line-height: 1;
      margin-bottom: 8px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .rental-meta {
      display: flex;
      gap: 6px;
      align-items: center;
      flex-wrap: wrap;
      margin-bottom: 14px;
    }

    .meta-pill {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      letter-spacing: 0.3px;
      color: var(--muted2);
      background: var(--surface2);
      border: 1px solid var(--border);
      padding: 3px 10px;
      border-radius: 2px;
    }

    .meta-sep { color: var(--muted); font-size: 0.6rem; }

    .rental-dates {
      display: flex;
      gap: 22px;
      flex-wrap: wrap;
    }

    .date-item {}

    .date-label {
      font-family: var(--font-mono);
      font-size: 0.6rem;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--muted);
      margin-bottom: 3px;
    }

    .date-value {
      font-family: var(--font-mono);
      font-size: 0.78rem;
      color: var(--text);
      letter-spacing: 0.3px;
    }

    /* Status */
    .status-col { display: flex; flex-direction: column; align-items: center; gap: 8px; flex-shrink: 0; }

    .status-badge {
      font-family: var(--font-mono);
      font-size: 0.65rem;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      padding: 5px 13px;
      border-radius: 2px;
      white-space: nowrap;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .status-active {
      background: rgba(200,169,110,0.08);
      border: 1px solid rgba(200,169,110,0.22);
      color: var(--accent);
    }

    .status-active .status-dot {
      width: 6px; height: 6px;
      border-radius: 50%;
      background: var(--accent);
      animation: pulse-gold 2s infinite;
    }

    .status-returned {
      background: rgba(92,186,135,0.08);
      border: 1px solid rgba(92,186,135,0.22);
      color: var(--green);
    }

    .status-returned .status-dot {
      width: 6px; height: 6px;
      border-radius: 50%;
      background: var(--green);
    }

    @keyframes pulse-gold {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.35; }
    }

    /* Late Fee */
    .fee-col { flex-shrink: 0; }

    .late-fee {
      font-family: var(--font-mono);
      font-size: 0.72rem;
      font-weight: 500;
      color: var(--red);
      background: rgba(224,82,82,0.08);
      border: 1px solid rgba(224,82,82,0.2);
      border-radius: 2px;
      padding: 5px 12px;
      white-space: nowrap;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .no-fee {
      font-family: var(--font-mono);
      font-size: 0.68rem;
      color: var(--muted);
      letter-spacing: 0.5px;
    }

    /* Action */
    .action-col { flex-shrink: 0; }

    .btn-watch {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 11px 24px;
      background: var(--accent);
      color: #0a0800;
      font-family: var(--font-mono);
      font-size: 0.72rem;
      font-weight: 500;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      text-decoration: none;
      border-radius: 2px;
      border: none;
      cursor: pointer;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      box-shadow: 0 4px 20px rgba(200,169,110,0.15);
      white-space: nowrap;
    }

    .btn-watch:hover {
      background: var(--accent2);
      transform: translateY(-2px);
      box-shadow: 0 8px 28px rgba(200,169,110,0.25);
      color: #050400;
    }

    /* Empty State */
    .empty-state {
      padding: 80px 24px;
      text-align: center;
      border: 1px dashed rgba(255,255,255,0.06);
      border-radius: 3px;
    }

    .empty-frame {
      width: 64px; height: 64px;
      border: 1px solid var(--border2);
      border-radius: 2px;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 20px;
      color: var(--muted);
      position: relative;
    }

    .empty-frame::before,
    .empty-frame::after {
      content: '';
      position: absolute;
      width: 12px; height: 12px;
      border-color: var(--accent);
      border-style: solid;
      opacity: 0.4;
    }
    .empty-frame::before { top: -4px; left: -4px; border-width: 1px 0 0 1px; }
    .empty-frame::after  { bottom: -4px; right: -4px; border-width: 0 1px 1px 0; }

    .empty-title {
      font-family: var(--font-display);
      font-size: 2rem;
      letter-spacing: 2px;
      color: var(--muted);
      text-transform: uppercase;
      margin-bottom: 8px;
    }

    .empty-sub {
      font-family: var(--font-mono);
      font-size: 0.72rem;
      letter-spacing: 1px;
      color: var(--muted);
      margin-bottom: 28px;
    }

    .btn-browse {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 12px 28px;
      background: transparent;
      color: var(--muted2);
      font-family: var(--font-mono);
      font-size: 0.75rem;
      letter-spacing: 1.2px;
      text-transform: uppercase;
      text-decoration: none;
      border-radius: 2px;
      border: 1px solid var(--border2);
      transition: all 0.18s;
    }

    .btn-browse:hover {
      color: var(--text);
      border-color: rgba(200,169,110,0.35);
      background: rgba(200,169,110,0.05);
    }

    /* Responsive */
    @media (max-width: 900px) {
      .navbar { padding: 0 20px; }
      .page-header, .stats-band, .band-divider, .main-wrap { padding-left: 20px; padding-right: 20px; }
      .rental-card { grid-template-columns: 48px 1fr; grid-template-rows: auto auto auto; gap: 14px; }
      .status-col, .fee-col, .action-col { grid-column: 2; justify-content: flex-start; flex-direction: row; flex-wrap: wrap; }
      .stats-inner { grid-template-columns: 1fr 1fr 1fr; gap: 0; }
    }

    @media (max-width: 600px) {
      .stats-inner { grid-template-columns: 1fr; gap: 20px; }
      .stat-item + .stat-item { border-left: none; padding-left: 0; border-top: 1px solid var(--border); padding-top: 20px; }
      .rental-card { padding: 16px; }
      .rental-title { font-size: 1.1rem; }
    }

    /* Settings Modal */
    .modal-overlay {
      position: fixed; inset: 0; background: rgba(0,0,0,0.8); backdrop-filter: blur(5px);
      display: none; align-items: center; justify-content: center; z-index: 1000;
    }
    .modal-content-custom {
      background: var(--surface); border: 1px solid var(--border); border-radius: 4px;
      width: 100%; max-width: 400px; padding: 24px; box-shadow: 0 10px 40px rgba(0,0,0,0.5);
    }
    .modal-header-custom { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .modal-header-custom h3 { font-family: var(--font-display); font-size: 1.8rem; letter-spacing: 1px; color: var(--text); margin: 0; }
    .close-btn { background: none; border: none; color: var(--muted); font-size: 24px; cursor: pointer; }
    .close-btn:hover { color: var(--red); }
    .form-group-custom { margin-bottom: 16px; text-align: left; }
    .form-group-custom label { display: block; font-size: 0.8rem; color: var(--muted); margin-bottom: 6px; font-family: var(--font-mono); letter-spacing: 0.5px; }
    .form-group-custom input { 
      width: 100%; height: 42px; background: var(--bg); border: 1px solid var(--border); 
      border-radius: 3px; color: var(--text); padding: 0 12px; font-family: var(--font-body);
    }
    .form-group-custom input:focus { outline: none; border-color: rgba(200,169,110,0.4); }
    .btn-save { width: 100%; background: var(--accent); color: #0a0800; border: none; padding: 12px; border-radius: 2px; font-family: var(--font-mono); font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-top: 10px; cursor: pointer; transition: background 0.2s; }
    .btn-save:hover { background: var(--accent2); }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/home" class="nav-brand">CINERENT<span>STREAM</span></a>
  <div class="nav-right">
    <a href="/home" class="btn-nav btn-nav-ghost">
      <i class="fas fa-film" style="font-size:0.7rem;margin-right:4px;"></i> Browse
    </a>
    <button onclick="openSettingsModal()" class="btn-nav btn-nav-ghost" style="border:none; cursor:pointer;" title="Settings">
      <i class="fas fa-cog" style="font-size:0.8rem;"></i>
    </button>
    <a href="/logout" class="btn-nav btn-nav-logout">
      <i class="fas fa-right-from-bracket" style="font-size:0.7rem;margin-right:4px;"></i> Logout
    </a>
  </div>
</nav>

<!-- Page Header -->
<div class="page-header">
  <div class="eyebrow">
    <div class="eyebrow-line"></div>
    <span class="eyebrow-text">Account</span>
  </div>
  <h1 class="page-title">My <span>Rentals</span></h1>
</div>

<!-- Stats Band -->
<c:if test="${not empty rentals}">
  <div class="stats-band">
    <div class="stats-inner">
      <div class="stat-item">
        <div class="stat-num total">${rentals.size()}</div>
        <div class="stat-label">Total Rentals</div>
      </div>
      <div class="stat-item">
        <c:set var="activeCount" value="0"/>
        <c:forEach var="r" items="${rentals}">
          <c:if test="${r.status == 'ACTIVE'}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if>
        </c:forEach>
        <div class="stat-num active">${activeCount}</div>
        <div class="stat-label">Active Now</div>
      </div>
      <div class="stat-item">
        <c:set var="returnedCount" value="0"/>
        <c:forEach var="r" items="${rentals}">
          <c:if test="${r.status != 'ACTIVE'}"><c:set var="returnedCount" value="${returnedCount + 1}"/></c:if>
        </c:forEach>
        <div class="stat-num done">${returnedCount}</div>
        <div class="stat-label">Returned</div>
      </div>
    </div>
  </div>
</c:if>

<!-- Band Label -->
<div class="band-divider">
  <span class="band-label">Rental History</span>
  <div class="band-rule"></div>
</div>

<!-- Main Content -->
<div class="main-wrap">

  <c:choose>
    <c:when test="${not empty rentals}">
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
                <div class="rental-thumb-placeholder">
                  <i class="fas fa-film thumb-icon"></i>
                </div>
              </c:otherwise>
            </c:choose>

            <!-- Info -->
            <div class="rental-info">
              <div class="rental-title">${r.movie.title}</div>
              <div class="rental-meta">
                <span class="meta-pill">${r.movie.genre}</span>
                <span class="meta-sep">&#183;</span>
                <span class="meta-pill">${r.movie.quality}</span>
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

            <!-- Status -->
            <div class="status-col">
              <c:choose>
                <c:when test="${r.status == 'ACTIVE'}">
                  <span class="status-badge status-active">
                    <span class="status-dot"></span> Active
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge status-returned">
                    <span class="status-dot"></span> Returned
                  </span>
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Late Fee -->
            <div class="fee-col">
              <c:choose>
                <c:when test="${r.lateFee > 0}">
                  <span class="late-fee">
                    <i class="fas fa-triangle-exclamation" style="font-size:0.65rem;"></i> LKR ${r.lateFee}
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="no-fee">No late fee</span>
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Watch -->
            <div class="action-col">
              <a class="btn-watch" href="/watch/${r.movie.id}">
                <i class="fas fa-play" style="font-size:0.65rem;"></i> Watch
              </a>
            </div>

          </div>
        </c:forEach>
      </div>
    </c:when>

    <c:otherwise>
      <!-- Empty State -->
      <div class="empty-state">
        <div class="empty-frame">
          <i class="fas fa-film" style="font-size:1.2rem;"></i>
        </div>
        <div class="empty-title">No Rentals Yet</div>
        <p class="empty-sub">You have not rented any titles. Start browsing to find something great.</p>
        <a href="/home" class="btn-browse">
          <i class="fas fa-arrow-right" style="font-size:0.65rem;"></i> Browse Films
        </a>
      </div>
    </c:otherwise>
  </c:choose>

</div>

<!-- Settings Modal -->
<div id="settingsModal" class="modal-overlay">
  <div class="modal-content-custom">
    <div class="modal-header-custom">
      <h3>Account Settings</h3>
      <button type="button" class="close-btn" onclick="closeSettingsModal()">&times;</button>
    </div>
    <form action="/user/update" method="POST">
      <div class="form-group-custom">
        <label>Username</label>
        <input type="text" name="username" value="${sessionScope.user.username}" required>
      </div>
      <div class="form-group-custom">
        <label>Email Address</label>
        <input type="email" name="email" value="${sessionScope.user.email}" required>
      </div>
      <div class="form-group-custom">
        <label>New Password (leave blank to keep current)</label>
        <input type="password" name="password" placeholder="••••••••">
      </div>
      <button type="submit" class="btn-save">Save Changes</button>
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
