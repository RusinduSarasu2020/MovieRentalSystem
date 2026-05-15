<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Settings — CineRent Admin</title>
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
    .settings-card {
      background: #0f3460;
      border-radius: 14px;
      padding: 24px;
      margin-bottom: 20px;
    }
    code {
      background: #0a2744;
      padding: 2px 8px;
      border-radius: 4px;
      color: #ff6a00;
    }
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
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings" class="active">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-1">⚙️ System Settings</h3>
      <p class="text-muted mb-4">Reference for system constants and configurations</p>

      <div class="row g-3">
        <div class="col-md-6">
          <div class="settings-card">
            <h5 class="mb-3">🎬 Genres Available</h5>
            <div class="d-flex flex-wrap gap-2">
              <span class="badge bg-secondary px-3 py-2">Scifi</span>
              <span class="badge bg-secondary px-3 py-2">Horror</span>
              <span class="badge bg-secondary px-3 py-2">Documentary</span>
              <span class="badge bg-secondary px-3 py-2">Family</span>
              <span class="badge bg-secondary px-3 py-2">Child</span>
              <span class="badge bg-secondary px-3 py-2">Comedy</span>
              <span class="badge bg-secondary px-3 py-2">Adventure</span>
              <span class="badge bg-secondary px-3 py-2">Crime</span>
              <span class="badge bg-secondary px-3 py-2">Thriller</span>
              <span class="badge bg-secondary px-3 py-2">Psychological</span>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="settings-card">
            <h5 class="mb-3">📋 Rental Rules</h5>
            <table class="table table-sm" style="color:#ccc">
              <tr><td>Late fee per day</td><td><strong class="text-white">Rs 50</strong></td></tr>
              <tr><td>Default rental period</td><td><strong class="text-white">7 days</strong></td></tr>
              <tr><td>Configurable in</td><td><code>RentalService.java</code></td></tr>
            </table>
          </div>
        </div>

        <div class="col-md-6">
          <div class="settings-card">
            <h5 class="mb-3">🔐 Default Credentials</h5>
            <table class="table table-sm" style="color:#ccc">
              <tr><td>Admin username</td><td><code>admin</code></td></tr>
              <tr><td>Admin password</td><td><code>admin123</code></td></tr>
              <tr><td>Movie watch password</td><td><code>movie123</code></td></tr>
              <tr><td>Test card number</td><td><code>4111111111111111</code></td></tr>
              <tr><td>Test card expiry</td><td><code>12/28</code></td></tr>
              <tr><td>Test card CVV</td><td><code>123</code></td></tr>
            </table>
          </div>
        </div>

        <div class="col-md-6">
          <div class="settings-card">
            <h5 class="mb-3">🏗️ OOP Architecture</h5>
            <table class="table table-sm" style="color:#ccc">
              <tr><td>Encapsulation</td><td>All model classes (private fields)</td></tr>
              <tr><td>Inheritance</td><td><code>Admin extends User</code><br><code>CardPayment extends Payment</code></td></tr>
              <tr><td>Polymorphism</td><td><code>processPayment()</code> overridden</td></tr>
              <tr><td>Abstraction</td><td><code>Payment</code> is abstract</td></tr>
              <tr><td>DB strategy</td><td>SINGLE_TABLE inheritance</td></tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
