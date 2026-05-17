<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Rentals — CineRent Admin</title>
  <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --bg-deep:       #080c14;
      --bg-panel:      #0d1626;
      --bg-card:       #111d30;
      --accent:        #c8973a;
      --accent-dim:    #8a6526;
      --accent-glow:   rgba(200,151,58,.18);
      --text-primary:  #e8e0d0;
      --text-muted:    #7a8499;
      --text-faint:    #3d4a60;
      --border:        rgba(200,151,58,.12);
      --border-strong: rgba(200,151,58,.3);
      --danger:        #c0392b;
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

    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.04'/%3E%3C/svg%3E");
      pointer-events: none;
      z-index: 0;
    }

    /* Topbar */
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

    /* Sidebar */
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
    .sidebar a svg { width: 15px; height: 15px; flex-shrink: 0; }
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

    /* Main */
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

    /* Table */
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

    .td-id     { color: var(--text-faint); font-size: 12px; font-family: monospace; }
    .td-user   { font-weight: 500; }
    .td-movie  { color: var(--text-muted); }
    .td-date   { color: var(--text-muted); font-size: 12px; }
    .td-dash   { color: var(--text-faint); }
    .td-latefee { font-weight: 600; color: #e57368; }

    .badge-status {
      display: inline-block;
      font-size: 10px;
      font-weight: 600;
      letter-spacing: .08em;
      text-transform: uppercase;
      padding: 4px 10px;
      border-radius: 20px;
    }
    .badge-active {
      background: rgba(200,151,58,.14);
      color: var(--accent);
      border: 1px solid rgba(200,151,58,.28);
    }
    .badge-returned {
      background: rgba(39,105,90,.25);
      color: #5ecfb8;
      border: 1px solid rgba(94,207,184,.2);
    }

    .btn-return {
      background: transparent;
      border: 1px solid rgba(94,207,184,.3);
      color: #5ecfb8;
      font-size: 11px;
      font-weight: 500;
      letter-spacing: .06em;
      text-transform: uppercase;
      padding: 5px 13px;
      border-radius: 5px;
      cursor: pointer;
      transition: all .18s;
      font-family: 'DM Sans', sans-serif;
    }
    .btn-return:hover {
      background: rgba(39,105,90,.2);
      border-color: #5ecfb8;
    }

    .empty-row td {
      text-align: center;
      color: var(--text-faint);
      padding: 48px;
      font-size: 13px;
      letter-spacing: .04em;
    }

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
    <a href="/admin/movies">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M7 4v16M17 4v16M2 9h5M2 15h5M17 9h5M17 15h5"/></svg>
      Manage Movies
    </a>
    <a href="/admin/users">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></svg>
      Manage Users
    </a>

    <div class="nav-section">Operations</div>
    <a href="/admin/rentals" class="active">
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
      <h1>Rental Management</h1>
      <p>Track active rentals, due dates, and process returns.</p>
    </div>

    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>User</th>
            <th>Movie</th>
            <th>Rented On</th>
            <th>Due Date</th>
            <th>Returned</th>
            <th>Status</th>
            <th>Late Fee</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${rentals}">
            <tr>
              <td class="td-id">#${r.id}</td>
              <td class="td-user">${r.user.username}</td>
              <td class="td-movie">${r.movie.title}</td>
              <td class="td-date">${r.rentalDate}</td>
              <td class="td-date">${r.dueDate}</td>
              <td class="td-date">
                <c:choose>
                  <c:when test="${r.returnDate != null}">${r.returnDate}</c:when>
                  <c:otherwise><span class="td-dash">—</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${r.status == 'ACTIVE'}">
                    <span class="badge-status badge-active">Active</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge-status badge-returned">Returned</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${r.lateFee > 0}">
                    <span class="td-latefee">Rs ${r.lateFee}</span>
                  </c:when>
                  <c:otherwise><span class="td-dash">—</span></c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:if test="${r.status == 'ACTIVE'}">
                  <form method="post" action="/admin/rentals/${r.id}/return" class="d-inline">
                    <button type="submit" class="btn-return">Mark Returned</button>
                  </form>
                </c:if>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty rentals}">
            <tr class="empty-row">
              <td colspan="9">No rentals found.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>

  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
