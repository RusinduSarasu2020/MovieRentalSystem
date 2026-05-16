<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Movies — CineRent Admin</title>
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
    .form-control, .form-select {
      background: #0f3460;
      color: #fff;
      border-color: #1a4a7a;
    }
    .form-control:focus, .form-select:focus {
      background: #0f3460;
      color: #fff;
      border-color: #e94560;
    }
    .form-control::placeholder { color: #aaa; }
    .table-dark { --bs-table-bg: #0f3460; }

    /* Banner upload modal */
    .modal-content {
      background: #0f3460;
      color: #fff;
      border: 1px solid #1a4a7a;
      border-radius: 12px;
    }
    .modal-header { border-bottom: 1px solid #1a4a7a; }
    .modal-footer { border-top: 1px solid #1a4a7a; }
    .banner-preview {
      width: 100%;
      max-height: 200px;
      object-fit: cover;
      border-radius: 8px;
      border: 2px solid #1a4a7a;
      display: none;
      margin-top: 10px;
    }
    .current-banner-wrap { text-align: center; margin-bottom: 12px; }
    .current-banner-wrap img {
      width: 100px;
      height: 140px;
      object-fit: cover;
      border-radius: 8px;
      border: 2px solid #e94560;
    }
    .current-banner-wrap small { display: block; margin-top: 4px; color: #aaa; }
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
      <a href="/admin/movies" class="active">🎬 Manage Movies</a>
      <a href="/admin/users">👥 Manage Users</a>
      <a href="/admin/rentals">📦 Rentals</a>
      <a href="/admin/payments">💳 Payments</a>
      <a href="/admin/reviews">⭐ Reviews</a>
      <a href="/admin/reports">📈 Reports</a>
      <a href="/admin/settings">⚙️ Settings</a>
    </div>

    <div class="col-md-10 p-4">
      <h3 class="mb-4">🎬 Manage Movies</h3>

      <%-- Add Movie Form --%>
      <div class="card mb-4" style="background:#0f3460;border:0;border-radius:12px;padding:20px">
        <h5 class="mb-3">Add New Movie</h5>
        <form method="post" action="/admin/movies/add" class="row g-2">
          <div class="col-md-3">
            <input class="form-control" name="title" placeholder="Title" required>
          </div>
          <div class="col-md-2">
            <select class="form-select" name="genre">
              <option value="Scifi">Scifi</option>
              <option value="Horror">Horror</option>
              <option value="Documentary">Documentary</option>
              <option value="Family">Family</option>
              <option value="Child">Child</option>
              <option value="Comedy">Comedy</option>
              <option value="Adventure">Adventure</option>
              <option value="Crime">Crime</option>
              <option value="Thriller">Thriller</option>
              <option value="Psychological">Psychological</option>
            </select>
          </div>
          <div class="col-md-1">
            <input class="form-control" name="duration" type="number" placeholder="Min" required>
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
            <input class="form-control" name="rating" type="number" step="0.1" min="0" max="10" placeholder="Rating">
          </div>
          <div class="col-md-1">
            <input class="form-control" name="price" type="number" step="0.01" placeholder="Price" required>
          </div>
          <div class="col-md-2">
            <input class="form-control" name="posterUrl" placeholder="Poster URL">
          </div>
          <div class="col-md-1">
            <button class="btn btn-success w-100">Add</button>
          </div>
        </form>
      </div>

      <%-- Movies Table --%>
      <div class="table-responsive">
        <table class="table table-dark table-striped align-middle">
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
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="m" items="${movies}">
              <tr>
                <td>${m.id}</td>
                <td>
                  <img src="${m.posterUrl}" width="40" height="55"
                       style="object-fit:cover;border-radius:4px"
                       onerror="this.src='https://picsum.photos/40/55'">
                </td>
                <td><strong>${m.title}</strong></td>
                <td>${m.genre}</td>
                <td>${m.duration} min</td>
                <td>${m.quality}</td>
                <td>⭐ ${m.rating}</td>
                <td>Rs ${m.price}</td>
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
                <td>
                  <%-- Delete button --%>
                  <form method="post" action="/admin/movies/${m.id}/delete" class="d-inline"
                        onsubmit="return confirm('Delete ${m.title}?')">
                    <button class="btn btn-sm btn-danger">Delete</button>
                  </form>

                  <%-- Update Banner button --%>
                  <button class="btn btn-sm btn-warning ms-1"
                          onclick="openBannerModal(${m.id}, '${m.title}', '${m.posterUrl}')"
                          title="Update Banner">
                    🖼 Banner
                  </button>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty movies}">
              <tr>
                <td colspan="10" class="text-center text-muted">No movies found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <%-- ========== Update Banner Modal ========== --%>
  <div class="modal fade" id="bannerModal" tabindex="-1" aria-labelledby="bannerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="bannerModalLabel">🖼 Update Movie Banner</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <form id="bannerForm" method="post" enctype="multipart/form-data">
          <div class="modal-body">

            <%-- Movie title display --%>
            <p class="mb-3">
              Movie: <strong id="bannerMovieTitle" class="text-warning"></strong>
            </p>

            <%-- Current poster preview --%>
            <div class="current-banner-wrap">
              <img id="currentBannerImg" src="" alt="Current Banner"
                   onerror="this.src='https://picsum.photos/100/140'">
              <small>Current Banner</small>
            </div>

            <%-- File input --%>
            <div class="mb-3">
              <label for="bannerFileInput" class="form-label">Choose new banner image</label>
              <input class="form-control" type="file" id="bannerFileInput" name="bannerFile"
                     accept="image/*" required onchange="previewBanner(event)">
              <div class="form-text text-secondary">Accepted: JPG, PNG, WebP — Max 10 MB</div>
            </div>

            <%-- New image preview --%>
            <img id="bannerNewPreview" class="banner-preview" alt="New Banner Preview">

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-warning">Upload Banner</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    var bannerModal = new bootstrap.Modal(document.getElementById('bannerModal'));

    function openBannerModal(movieId, movieTitle, posterUrl) {
      // Set movie info
      document.getElementById('bannerMovieTitle').textContent = movieTitle;

      // Set current banner
      var currentImg = document.getElementById('currentBannerImg');
      currentImg.src = posterUrl && posterUrl.trim() !== ''
          ? posterUrl
          : 'https://picsum.photos/100/140';

      // Set form action
      document.getElementById('bannerForm').action = '/admin/movies/' + movieId + '/update-banner';

      // Reset file input and new preview
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
