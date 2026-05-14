<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Login — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #1a1a2e;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .card {
      background: #16213e;
      border: 0;
      padding: 30px;
      width: 380px;
      margin: auto;
      border-radius: 18px;
    }
    .btn-warning { font-weight: 600; }
  </style>
</head>
<body>
  <div class="card text-light">
    <h3 class="text-center mb-4">🔐 Admin Panel</h3>
    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form method="post" action="/admin/login">
      <input class="form-control mb-2" name="username" placeholder="Admin Username" required>
      <input class="form-control mb-3" name="password" type="password" placeholder="Password" required>
      <button class="btn btn-warning w-100">Login as Admin</button>
    </form>
    <p class="text-center mt-3 small text-muted">Default → admin / admin123</p>
  </div>
</body>
</html>
