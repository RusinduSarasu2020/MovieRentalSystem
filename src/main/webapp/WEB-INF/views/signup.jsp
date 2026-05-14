<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Sign Up — CineRent</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #0f0c29;
      color: #fff;
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .card {
      background: #1a1740;
      border: 0;
      border-radius: 18px;
      padding: 30px;
      width: 420px;
      margin: auto;
    }
    .btn-primary {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: 0;
    }
  </style>
</head>
<body>
  <div class="card text-light">
    <h3 class="text-center mb-4">Create Account</h3>
    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form method="post" action="/signup">
      <input class="form-control mb-2" name="email" type="email" placeholder="Email" required>
      <input class="form-control mb-2" name="username" placeholder="Username" required>
      <input class="form-control mb-2" name="phone" placeholder="Phone" required>
      <input class="form-control mb-2" name="password" type="password" placeholder="Password" required>
      <input class="form-control mb-3" name="password2" type="password" placeholder="Confirm Password" required>
      <button class="btn btn-primary w-100">Sign Up</button>
    </form>
    <p class="text-center mt-3">
      <a href="/login" class="text-info">Already have an account? Login</a>
    </p>
  </div>
</body>
</html>
