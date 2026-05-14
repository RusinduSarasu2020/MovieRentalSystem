<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Reports — CineRent Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #16213e; color: #fff; }
    .sidebar {
      background: #0f3460;
      min-height: 100vh;
      padding: 20px 12px;
    }
    .sidebar a {
      color: #ccc;
      display: block;
      padding: 10px 14px;
      border-radius: 8px;
      text-decoration: none;
      margin-bottom: 4px;
      font-size: 0.9rem;
      transition: .2s;
    }
    .sidebar a:hover, .sidebar a.active { background: #e94560; color: #fff; }
    .stat-card {
      background: #0f3460;
      border: 0;
      border-radius: 14px;
      padding: 24px 30px;
      margin-bottom: 16px;
    }
    .stat-card h6 { color: #aaa; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; }
    .stat-card h3 { font-size: 2rem; font-weight: 700; }
  </style>
</head>
<body>
  <nav class="navbar navbar-dark px-4" style="background:#0a2744">
    <a class="navbar-brand fw-bold" href="/admin/dashboard">⚙️ CineRent Admin</a>
    <a href="/logout" class="btn btn-danger btn-sm">Logout</a>
  </nav>

  <div class="row g-0">
    <div class="col-md-2 sidebar">
      <a href="/admin/dashboard">📊 Dashboard</a>
      <a href="/admin/movies">🎬 Manage Movies</a>
      <a href="/admin/users">👥 Manage Users</a>
      <a href="/admin/rentals">📦 Rentals</a>
      <a href="/admin/payments">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports" class="active">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-1">📈 Reports & Analytics</h3>
      <p class="text-muted mb-4">System-wide summary overview</p>

      <div class="row g-3">
        <div class="col-md-4">
          <div class="stat-card" style="background:#0a3d2e">
            <h6>💰 Total Revenue</h6>
            <h3>Rs ${revenue}</h3>
            <p class="text-muted small mb-0">From successful payments only</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="stat-card">
            <h6>🎬 Total Movies</h6>
            <h3>${movies.size()}</h3>
            <p class="text-muted small mb-0">In the CineRent catalog</p>
          </div>
        </div>
        <div class="col-md-4">
          <div class="stat-card">
            <h6>👥 Total Users</h6>
            <h3>${users.size()}</h3>
            <p class="text-muted small mb-0">Registered accounts</p>
          </div>
        </div>
      </div>

      <div class="row g-3 mt-1">
        <div class="col-md-8">
          <div class="stat-card">
            <h6 class="mb-3">🎬 Movie Catalog Summary</h6>
            <table class="table table-sm" style="color:#fff">
              <thead style="color:#aaa">
                <tr>
                  <th>Title</th>
                  <th>Genre</th>
                  <th>Quality</th>
                  <th>Price</th>
                  <th>Rating</th>
                  <th>Available</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="m" items="${movies}">
                  <tr>
                    <td>${m.title}</td>
                    <td>${m.genre}</td>
                    <td>${m.quality}</td>
                    <td>Rs ${m.price}</td>
                    <td>⭐ ${m.rating}</td>
                    <td>
                      <c:choose>
                        <c:when test="${m.available}">
                          <span class="badge bg-success">Yes</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-danger">No</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-md-4">
          <div class="stat-card">
            <h6 class="mb-3">⚙️ System Info</h6>
            <p class="small text-muted mb-1">Late fee rate: <strong class="text-white">Rs 50 / day</strong></p>
            <p class="small text-muted mb-1">Default rental period: <strong class="text-white">7 days</strong></p>
            <p class="small text-muted mb-1">Watch password: <strong class="text-white">movie123</strong></p>
            <p class="small text-muted mb-0">Payment types: <strong class="text-white">Card (SINGLE_TABLE)</strong></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
