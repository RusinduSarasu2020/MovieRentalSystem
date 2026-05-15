<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payments — CineRent Admin</title>
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
    .table-dark { --bs-table-bg: #0f3460; }
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
      <a href="/admin/payments" class="active">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-4">💳 Payment Records</h3>

      <div class="table-responsive">
        <table class="table table-dark table-striped align-middle">
          <thead>
            <tr>
              <th>Payment ID</th>
              <th>User</th>
              <th>Movie</th>
              <th>Amount</th>
              <th>Status</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${payments}">
              <tr>
                <td>#${p.paymentId}</td>
                <td>${p.user.username}</td>
                <td>${p.movie.title}</td>
                <td>Rs ${p.amount}</td>
                <td>
                  <c:choose>
                    <c:when test="${p.status == 'SUCCESS'}">
                      <span class="badge bg-success">SUCCESS</span>
                    </c:when>
                    <c:when test="${p.status == 'FAILED'}">
                      <span class="badge bg-danger">FAILED</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-secondary">PENDING</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${p.createdAt}</td>
              </tr>
            </c:forEach>
            <c:if test="${empty payments}">
              <tr>
                <td colspan="6" class="text-center text-muted">No payments recorded.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
