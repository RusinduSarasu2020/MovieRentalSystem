<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Rentals — CineRent Admin</title>
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
      <a href="/admin/rentals" class="active">📦 Rentals</a>
      <a href="/admin/payments">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-4">📦 Rental Management</h3>

      <div class="table-responsive">
        <table class="table table-dark table-striped align-middle">
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
                <td>${r.id}</td>
                <td>${r.user.username}</td>
                <td>${r.movie.title}</td>
                <td>${r.rentalDate}</td>
                <td>${r.dueDate}</td>
                <td>${r.returnDate != null ? r.returnDate : '—'}</td>
                <td>
                  <c:choose>
                    <c:when test="${r.status == 'ACTIVE'}">
                      <span class="badge bg-warning text-dark">ACTIVE</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-success">RETURNED</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${r.lateFee > 0}">
                      <span class="text-danger">Rs ${r.lateFee}</span>
                    </c:when>
                    <c:otherwise>—</c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:if test="${r.status == 'ACTIVE'}">
                    <form method="post" action="/admin/rentals/${r.id}/return" class="d-inline">
                      <button class="btn btn-sm btn-success">Mark Returned</button>
                    </form>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty rentals}">
              <tr>
                <td colspan="9" class="text-center text-muted">No rentals found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
