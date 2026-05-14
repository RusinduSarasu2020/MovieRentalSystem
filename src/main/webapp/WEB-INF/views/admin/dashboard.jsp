<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #16213e; color: #fff; margin: 0; }
    .sidebar {
      background: #0f3460;
      min-height: 100vh;
      padding: 20px 12px;
      position: sticky;
      top: 0;
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
    .card-stat {
      background: #0f3460;
      border: 0;
      border-radius: 14px;
      padding: 24px;
      color: #fff;
      height: 100%;
    }
    .card-stat h6 { color: #aaa; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; }
    .card-stat h2 { font-size: 2.4rem; font-weight: 700; margin: 0; }
    .card-stat .icon { font-size: 2rem; float: right; opacity: .4; }
  </style>
</head>
<body>
  <nav class="navbar navbar-dark px-4" style="background:#0a2744">
    <span class="navbar-brand fw-bold">⚙️ CineRent Admin Panel</span>
    <a href="/logout" class="btn btn-danger btn-sm">Logout</a>
  </nav>

  <div class="row g-0">
    <div class="col-md-2 sidebar">
      <p class="text-muted small px-2 mb-2">NAVIGATION</p>
      <a href="/admin/dashboard" class="active">📊 Dashboard</a>
      <a href="/admin/movies">🎬 Manage Movies</a>
      <a href="/admin/users">👥 Manage Users</a>
      <a href="/admin/rentals">📦 Rentals</a>
      <a href="/admin/payments">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-1">Dashboard</h3>
      <p class="text-muted mb-4">Welcome back, Admin. Here's your overview.</p>

      <div class="row g-3">
        <div class="col-md-3">
          <div class="card-stat">
            <span class="icon">🎬</span>
            <h6>Total Movies</h6>
            <h2>${totalMovies}</h2>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card-stat">
            <span class="icon">👥</span>
            <h6>Total Users</h6>
            <h2>${totalUsers}</h2>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card-stat">
            <span class="icon">📦</span>
            <h6>Active Rentals</h6>
            <h2>${activeRentals}</h2>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card-stat">
            <span class="icon">✅</span>
            <h6>Returned</h6>
            <h2>${returnedRentals}</h2>
          </div>
        </div>
        <div class="col-md-3 mt-2">
          <div class="card-stat" style="background:#0a3d2e">
            <span class="icon">💰</span>
            <h6>Total Revenue</h6>
            <h2>Rs ${totalRevenue}</h2>
          </div>
        </div>
      </div>

      <div class="row mt-4 g-3">
        <div class="col-md-4">
          <div class="card-stat text-center">
            <p class="mb-2">Quick Actions</p>
            <a href="/admin/movies" class="btn btn-sm btn-outline-light d-block mb-2">+ Add Movie</a>
            <a href="/admin/rentals" class="btn btn-sm btn-outline-light d-block mb-2">View Rentals</a>
            <a href="/admin/reports" class="btn btn-sm btn-outline-light d-block">View Reports</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
