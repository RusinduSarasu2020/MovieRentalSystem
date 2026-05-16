<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Movies — CineRent Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg-deep:       #080c14;
      --bg-panel:      #0d1626;
      --bg-card:       #111d30;
      --bg-input:      #0d1a2e;
      --accent:        #c8973a;
      --accent-dim:    #8a6526;
      --accent-glow:   rgba(200,151,58,.18);
      --text-primary:  #e8e0d0;
      --text-muted:    #7a8499;
      --text-faint:    #3d4a60;
      --border:        rgba(200,151,58,.12);
      --border-strong: rgba(200,151,58,.3);
      --danger:        #c0392b;
      --success:       #27695a;
      --sidebar-w:     230px;
      --topbar-h:      60px;
    }

    html, body {
      height: 100%;
      background: var(--bg-deep);
      color: var(--text-primary);
      font-family: 'DM Sans', sans-serif;
      font-size: 14px;
      overflow-x: hidden;
    }

    /* ── Noise texture overlay ─────────────────────────── */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 0;
    }

    /* ── Topbar ───────────────────────────────────────── */
    .topbar {
      position: fixed;
      top: 0; left: 0; right: 0;
      height: var(--topbar-h);
      background: var(--bg-panel);
      border-bottom: 1px solid var(--border);
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 28px;
      z-index: 100;
      backdrop-filter: blur(12px);
    }

    .brand {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.4rem;
      font-weight: 700;
      letter-spacing: .04em;
      color: var(--accent);
      text-decoration: none;
    }
    .brand span {
      color: var(--text-muted);
      font-weight: 300;
      font-size: 1rem;
      margin-left: 6px;
    }

    .btn-logout {
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 500;
      letter-spacing: .08em;
      text-transform: uppercase;
      color: var(--text-muted);
      background: transparent;
      border: 1px solid var(--text-faint);
      padding: 6px 18px;
      border-radius: 4px;
      text-decoration: none;
      transition: all .2s;
    }
    .btn-logout:hover {
      color: var(--text-primary);
      border-color: var(--danger);
      background: rgba(192,57,43,.12);
    }

    /* ── Sidebar ──────────────────────────────────────── */
    .sidebar {
      position: fixed;
      top: var(--topbar-h);
      left: 0;
      bottom: 0;
      width: var(--sidebar-w);
      background: var(--bg-panel);
      border-right: 1px solid var(--border);
      padding: 32px 16px;
      overflow-y: auto;
      z-index: 90;
    }

    .nav-section {
      font-size: 10px;
      letter-spacing: .14em;
      text-transform: uppercase;
      color: var(--text-faint);
      font-weight: 600;
      padding: 0 10px;
      margin: 24px 0 8px;
    }
    .nav-section:first-child { margin-top: 0; }

    .sidebar a {
      display: flex;
      align-items: center;
      gap: 10px;
      color: var(--text-muted);
      padding: 9px 12px;
      border-radius: 6px;
      text-decoration: none;
      font-size: 13px;
      font-weight: 400;
      letter-spacing: .01em;
      transition: all .18s;
      margin-bottom: 2px;
      border: 1px solid transparent;
      position: relative;
    }
    .sidebar a svg { width:15px; height:15px; flex-shrink:0; }
    .sidebar a:hover {
      color: var(--text-primary);
      background: rgba(200,151,58,.07);
      border-color: var(--border);
    }
    .sidebar a.active {
      color: var(--accent);
      background: var(--accent-glow);
      border-color: var(--border-strong);
      font-weight: 500;
    }
    .sidebar a.active::before {
      content: '';
      position: absolute;
      left: -16px;
      top: 50%;
      transform: translateY(-50%);
      width: 3px;
      height: 60%;
      background: var(--accent);
      border-radius: 0 2px 2px 0;
    }

    /* ── Main content ─────────────────────────────────── */
    .main {
      margin-left: var(--sidebar-w);
      margin-top: var(--topbar-h);
      padding: 36px 40px;
      min-height: calc(100vh - var(--topbar-h));
      position: relative;
      z-index: 1;
    }

    .page-header {
      margin-bottom: 32px;
    }
    .page-header h1 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 2.1rem;
      font-weight: 600;
      color: var(--text-primary);
      letter-spacing: .02em;
      line-height: 1.1;
    }
    .page-header p {
      color: var(--text-muted);
      font-size: 13px;
      margin-top: 6px;
    }

    /* ── Card ─────────────────────────────────────────── */
    .card-panel {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 28px 30px;
      margin-bottom: 28px;
    }
    .card-panel h5 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.15rem;
      font-weight: 600;
      color: var(--accent);
      letter-spacing: .04em;
      margin-bottom: 20px;
      text-transform: uppercase;
    }

    /* ── Form controls ────────────────────────────────── */
    .form-control, .form-select {
      background: var(--bg-input);
      color: var(--text-primary);
      border: 1px solid var(--border);
      border-radius: 7px;
      font-family: 'DM Sans', sans-serif;
      font-size: 13px;
      padding: 9px 13px;
      transition: border-color .18s, box-shadow .18s;
    }
    .form-control::placeholder { color: var(--text-faint); }
    .form-control:focus, .form-select:focus {
      background: var(--bg-input);
      color: var(--text-primary);
      border-color: var(--accent-dim);
      box-shadow: 0 0 0 3px var(--accent-glow);
      outline: none;
    }
    .form-select option { background: var(--bg-panel); }

    /* ── Buttons ──────────────────────────────────────── */
    .btn-primary-custom {
      background: var(--accent);
      color: #0a0c10;
      border: none;
      border-radius: 7px;
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 600;
      letter-spacing: .07em;
      text-transform: uppercase;
      padding: 10px 20px;
      width: 100%;
      cursor: pointer;
      transition: all .2s;
    }
    .btn-primary-custom:hover {
      background: #e0aa47;
      transform: translateY(-1px);
      box-shadow: 0 6px 20px var(--accent-glow);
    }

    .btn-del {
      background: transparent;
      border: 1px solid rgba(192,57,43,.4);
      color: #e57368;
      font-size: 11px;
      font-weight: 500;
      letter-spacing: .06em;
      text-transform: uppercase;
      padding: 5px 12px;
      border-radius: 5px;
      cursor: pointer;
      transition: all .18s;
      font-family: 'DM Sans', sans-serif;
    }
    .btn-del:hover {
      background: rgba(192,57,43,.15);
      border-color: var(--danger);
      color: #ff6b6b;
    }

    .btn-banner {
      background: transparent;
      border: 1px solid var(--border-strong);
      color: var(--accent);
      font-size: 11px;
      font-weight: 500;
      letter-spacing: .06em;
      text-transform: uppercase;
      padding: 5px 12px;
      border-radius: 5px;
      cursor: pointer;
      transition: all .18s;
      font-family: 'DM Sans', sans-serif;
      margin-left: 6px;
    }
    .btn-banner:hover {
      background: var(--accent-glow);
      border-color: var(--accent);
      color: #e0aa47;
    }

    /* ── Table ────────────────────────────────────────── */
    .table-wrap {
      overflow-x: auto;
      border-radius: 12px;
      border: 1px solid var(--border);
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    thead {
      background: var(--bg-panel);
    }
    thead th {
      font-size: 10px;
      font-weight: 600;
      letter-spacing: .12em;
      text-transform: uppercase;
      color: var(--text-faint);
      padding: 14px 18px;
      border-bottom: 1px solid var(--border);
      white-space: nowrap;
    }
    tbody tr {
      border-bottom: 1px solid var(--border);
      transition: background .15s;
    }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: rgba(200,151,58,.04); }
    tbody td {
      padding: 14px 18px;
      color: var(--text-primary);
      font-size: 13px;
      vertical-align: middle;
    }
    .td-id { color: var(--text-faint); font-size: 12px; font-family: monospace; }
    .td-title { font-weight: 500; }
    .td-genre {
      color: var(--accent);
      font-size: 11px;
      font-weight: 500;
      letter-spacing: .05em;
      text-transform: uppercase;
    }
    .td-rating { color: #d4a843; font-size: 13px; }
    .td-price { font-weight: 600; color: var(--text-primary); }
    .td-duration { color: var(--text-muted); }

    .poster-thumb {
      width: 38px;
      height: 52px;
      object-fit: cover;
      border-radius: 5px;
      border: 1px solid var(--border);
      display: block;
    }

    .badge-avail {
      display: inline-block;
      font-size: 10px;
      font-weight: 600;
      letter-spacing: .08em;
      text-transform: uppercase;
      padding: 4px 10px;
      border-radius: 20px;
    }
    .badge-yes {
      background: rgba(39,105,90,.25);
      color: #5ecfb8;
      border: 1px solid rgba(94,207,184,.2);
    }
    .badge-no {
      background: rgba(192,57,43,.18);
      color: #e57368;
      border: 1px solid rgba(192,57,43,.25);
    }

    .empty-row td {
      text-align: center;
      color: var(--text-faint);
      padding: 48px;
      font-size: 13px;
      letter-spacing: .04em;
    }

    /* ── Modal ────────────────────────────────────────── */
    .modal-content {
      background: var(--bg-card);
      color: var(--text-primary);
      border: 1px solid var(--border-strong);
      border-radius: 14px;
      font-family: 'DM Sans', sans-serif;
    }
    .modal-header {
      border-bottom: 1px solid var(--border);
      padding: 20px 24px;
    }
    .modal-title {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.2rem;
      font-weight: 600;
      color: var(--accent);
      letter-spacing: .04em;
    }
    .modal-body { padding: 24px; }
    .modal-footer {
      border-top: 1px solid var(--border);
      padding: 16px 24px;
      gap: 10px;
    }
    .btn-close-custom {
      background: transparent;
      border: none;
      color: var(--text-muted);
      font-size: 1.1rem;
      cursor: pointer;
      line-height: 1;
      transition: color .15s;
    }
    .btn-close-custom:hover { color: var(--text-primary); }

    .modal-movie-name {
      font-size: 13px;
      color: var(--text-muted);
      margin-bottom: 20px;
    }
    .modal-movie-name strong {
      color: var(--accent);
      font-weight: 600;
    }

    .current-poster-wrap {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 20px;
      gap: 8px;
    }
    .current-poster-wrap img {
      width: 80px;
      height: 110px;
      object-fit: cover;
      border-radius: 8px;
      border: 2px solid var(--border-strong);
    }
    .current-poster-wrap small {
      font-size: 10px;
      letter-spacing: .08em;
      text-transform: uppercase;
      color: var(--text-faint);
    }

    .form-label-custom {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: var(--text-muted);
      display: block;
      margin-bottom: 8px;
    }
    .form-hint {
      font-size: 11px;
      color: var(--text-faint);
      margin-top: 5px;
    }

    .banner-preview {
      width: 100%;
      max-height: 180px;
      object-fit: cover;
      border-radius: 8px;
      border: 1px solid var(--border);
      display: none;
      margin-top: 12px;
    }

    .btn-modal-cancel {
      background: transparent;
      border: 1px solid var(--border);
      color: var(--text-muted);
      border-radius: 7px;
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 500;
      letter-spacing: .06em;
      text-transform: uppercase;
      padding: 9px 20px;
      cursor: pointer;
      transition: all .18s;
    }
    .btn-modal-cancel:hover {
      border-color: var(--text-muted);
      color: var(--text-primary);
    }
    .btn-modal-upload {
      background: var(--accent);
      border: none;
      color: #0a0c10;
      border-radius: 7px;
      font-family: 'DM Sans', sans-serif;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: .07em;
      text-transform: uppercase;
      padding: 9px 22px;
      cursor: pointer;
      transition: all .2s;
    }
    .btn-modal-upload:hover {
      background: #e0aa47;
      box-shadow: 0 4px 16px var(--accent-glow);
    }

    /* ── Divider line ─────────────────────────────────── */
    .divider {
      border: none;
      border-top: 1px solid var(--border);
      margin: 0 0 28px;
    }

    /* ── Scrollbar ────────────────────────────────────── */
    ::-webkit-scrollbar { width: 5px; height: 5px; }
    ::-webkit-scrollbar-track { background: var(--bg-deep); }
    ::-webkit-scrollbar-thumb { background: var(--text-faint); border-radius: 4px; }
  </style>
</head>
<body>

  <!-- Topbar -->
  <nav class="topbar">
    <a class="brand" href="/admin/dashboard">CineRent <span>Admin Console</span></a>
    <a href="/logout" class="btn-logout">Logout</a>
  </nav>

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="nav-section">Overview</div>
    <a href="/admin/dashboard">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
      Dashboard
    </a>

    <div class="nav-section">Catalogue</div>
    <a href="/admin/movies" class="active">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M7 4v16M17 4v16M2 9h5M2 15h5M17 9h5M17 15h5"/></svg>
      Manage Movies
    </a>
    <a href="/admin/users">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
      Manage Users
    </a>

    <div class="nav-section">Operations</div>
    <a href="/admin/rentals">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
      Rentals
    </a>
    <a href="/admin/payments">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="1" y="4" width="22" height="16" rx="2"/><path d="M1 10h22"/></svg>
      Payments
    </a>
    <a href="/admin/reviews">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
      Reviews
    </a>

    <div class="nav-section">System</div>
    <a href="/admin/reports">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M18 20V10M12 20V4M6 20v-6"/></svg>
      Reports
    </a>
    <a href="/admin/settings">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14M4.93 4.93a10 10 0 0 0 0 14.14"/></svg>
      Settings
    </a>
  </aside>

  <!-- Main -->
  <main class="main">

    <div class="page-header">
      <h1>Manage Movies</h1>
      <p>Add, update, or remove titles from the catalogue.</p>
    </div>

    <!-- Add Movie Form -->
    <div class="card-panel">
      <h5>Add New Title</h5>
      <form method="post" action="/admin/movies/add">
        <div class="row g-2 align-items-end">
          <div class="col-md-3">
            <input class="form-control" name="title" placeholder="Movie title" required>
          </div>
          <div class="col-md-2">
            <select class="form-select" name="genre">
              <option value="Scifi">Sci-Fi</option>
              <option value="Horror">Horror</option>
              <option value="Documentary">Documentary</option>
              <option value="Family">Family</option>
              <option value="Child">Children</option>
              <option value="Comedy">Comedy</option>
              <option value="Adventure">Adventure</option>
              <option value="Crime">Crime</option>
              <option value="Thriller">Thriller</option>
              <option value="Psychological">Psychological</option>
            </select>
          </div>
          <div class="col-md-1">
            <input class="form-control" name="duration" type="number" placeholder="Mins" required>
          </div>
          <div class="col-md-1">
            <select class="form-select" name="quality">
              <option>480p</option>
              <option>720p</option>
              <option selected>1080p</option>
              <option>4K</option>
            </select>
          </div>
          <div class="col-md-1">
            <input class="form-control" name="rating" type="number" step="0.1" min="0" max="10" placeholder="0.0">
          </div>
          <div class="col-md-1">
            <input class="form-control" name="price" type="number" step="0.01" placeholder="Price" required>
          </div>
          <div class="col-md-2">
            <input class="form-control" name="posterUrl" placeholder="Poster URL">
          </div>
          <div class="col-md-1">
            <button type="submit" class="btn-primary-custom">Add</button>
          </div>
        </div>
      </form>
    </div>

    <!-- Movies Table -->
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Poster</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Duration</th>
            <th>Quality</th>
            <th>Rating</th>
            <th>Price</th>
            <th>Available</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="m" items="${movies}">
            <tr>
              <td class="td-id">#${m.id}</td>
              <td>
                <img class="poster-thumb"
                     src="${m.posterUrl}"
                     onerror="this.src='https://picsum.photos/38/52'"
                     alt="${m.title}">
              </td>
              <td class="td-title">${m.title}</td>
              <td class="td-genre">${m.genre}</td>
              <td class="td-duration">${m.duration} min</td>
              <td style="color:var(--text-muted)">${m.quality}</td>
              <td class="td-rating">${m.rating}</td>
              <td class="td-price">Rs ${m.price}</td>
              <td>
                <c:choose>
                  <c:when test="${m.available}">
                    <span class="badge-avail badge-yes">Yes</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge-avail badge-no">No</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <form method="post" action="/admin/movies/${m.id}/delete" class="d-inline"
                      onsubmit="return confirm('Delete ${m.title}?')">
                  <button type="submit" class="btn-del">Delete</button>
                </form>
                <button class="btn-banner"
                        onclick="openBannerModal(${m.id}, '${m.title}', '${m.posterUrl}')">
                  Banner
                </button>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty movies}">
            <tr class="empty-row">
              <td colspan="10">No movies in the catalogue yet.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </main>

  <!-- Update Banner Modal -->
  <div class="modal fade" id="bannerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Movie Banner</h5>
          <button type="button" class="btn-close-custom" data-bs-dismiss="modal" aria-label="Close">&times;</button>
        </div>

        <form id="bannerForm" method="post" enctype="multipart/form-data">
          <div class="modal-body">

            <p class="modal-movie-name">
              Movie: <strong id="bannerMovieTitle"></strong>
            </p>

            <div class="current-poster-wrap">
              <img id="currentBannerImg" src="" alt="Current Banner"
                   onerror="this.src='https://picsum.photos/80/110'">
              <small>Current Banner</small>
            </div>

            <div class="mb-3">
              <label class="form-label-custom" for="bannerFileInput">New Banner Image</label>
              <input class="form-control" type="file" id="bannerFileInput" name="bannerFile"
                     accept="image/*" required onchange="previewBanner(event)">
              <p class="form-hint">JPG, PNG, WebP &mdash; Max 10 MB</p>
            </div>

            <img id="bannerNewPreview" class="banner-preview" alt="Preview">
          </div>

          <div class="modal-footer">
            <button type="button" class="btn-modal-cancel" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn-modal-upload">Upload Banner</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    var bannerModal = new bootstrap.Modal(document.getElementById('bannerModal'));

    function openBannerModal(movieId, movieTitle, posterUrl) {
      document.getElementById('bannerMovieTitle').textContent = movieTitle;

      var currentImg = document.getElementById('currentBannerImg');
      currentImg.src = posterUrl && posterUrl.trim() !== ''
          ? posterUrl : 'https://picsum.photos/80/110';

      document.getElementById('bannerForm').action = '/admin/movies/' + movieId + '/update-banner';
      document.getElementById('bannerFileInput').value = '';

      var preview = document.getElementById('bannerNewPreview');
      preview.style.display = 'none';
      preview.src = '';

      bannerModal.show();
    }

    function previewBanner(event) {
      var file = event.target.files[0];
      if (!file) return;
      var reader = new FileReader();
      reader.onload = function(e) {
        var preview = document.getElementById('bannerNewPreview');
        preview.src = e.target.result;
        preview.style.display = 'block';
      };
      reader.readAsDataURL(file);
    }
  </script>
</body>
</html>
