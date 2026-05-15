<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Users — CineRent Admin</title>
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
    .form-control {
      background: #0f3460;
      color: #fff;
      border-color: #1a4a7a;
    }
    .form-control:focus { background: #0f3460; color: #fff; }
    .form-control::placeholder { color: #aaa; }
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
      <a href="/admin/users" class="active">👥 Manage Users</a>
      <a href="/admin/rentals">📦 Rentals</a>
      <a href="/admin/payments">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-4">👥 Manage Users</h3>

      <form class="mb-3 row g-2" method="get" action="/admin/users">
        <div class="col-md-4">
          <input class="form-control" name="q" placeholder="🔍 Search by username..." value="${param.q}">
        </div>
        <div class="col-auto">
          <button class="btn btn-outline-light">Search</button>
        </div>
      </form>

      <div class="table-responsive">
        <table class="table table-dark table-striped align-middle">
          <thead>
            <tr>
              <th>ID</th>
              <th>Username</th>
              <th>Email</th>
              <th>Phone</th>
              <th>Role</th>
              <th>Blocked</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="u" items="${users}">
              <tr>
                <td>${u.id}</td>
                <td><strong>${u.username}</strong></td>
                <td>${u.email}</td>
                <td>${u.phone}</td>
                <td>
                  <c:choose>
                    <c:when test="${u.role == 'ADMIN'}">
                      <span class="badge bg-warning text-dark">ADMIN</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-secondary">USER</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${u.blocked}">
                      <span class="badge bg-danger">Blocked</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-success">Active</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <form method="post" action="/admin/users/${u.id}/toggle" class="d-inline">
                    <button class="btn btn-sm btn-warning">
                      ${u.blocked ? 'Unblock' : 'Block'}
                    </button>
                  </form>
                  <c:if test="${u.role != 'ADMIN'}">
                    <form method="post" action="/admin/users/${u.id}/delete" class="d-inline"
                          onsubmit="return confirm('Delete user ${u.username}?')">
                      <button class="btn btn-sm btn-danger">Delete</button>
                    </form>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty users}">
              <tr>
                <td colspan="7" class="text-center text-muted">No users found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
