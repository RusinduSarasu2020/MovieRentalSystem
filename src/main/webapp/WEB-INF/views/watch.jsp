<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Watch — ${movie.title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: #000;
      color: #fff;
      min-height: 100vh;
      text-align: center;
      padding-top: 40px;
    }
    .lock-box {
      background: #1a1740;
      border-radius: 16px;
      padding: 40px;
      width: 400px;
      margin: 60px auto;
    }
    .lock-icon { font-size: 3rem; }
    .btn-unlock {
      background: linear-gradient(90deg, #ff6a00, #ee0979);
      border: 0;
      color: #fff;
      padding: 10px 40px;
      border-radius: 30px;
      font-weight: 600;
    }
    #player { margin: 30px auto; }
    video { border-radius: 12px; max-width: 100%; }
  </style>
</head>
<body>
  <nav style="position:absolute;top:0;left:0;right:0;padding:12px 24px;background:#111;display:flex;justify-content:space-between;align-items:center">
    <a href="/home" class="text-light text-decoration-none fw-bold">🎬 CineRent</a>
    <a href="/my-rentals" class="text-light small">My Rentals</a>
  </nav>

  <div id="lockScreen" class="lock-box">
    <div class="lock-icon">🔒</div>
    <h4 class="mt-2">${movie.title}</h4>
    <p class="text-muted small">Enter your watch password to unlock</p>
    <input id="pw" class="form-control mb-3" type="password"
           placeholder="Watch password"
           style="background:#0f0c29;color:#fff;border-color:#444;text-align:center">
    <button class="btn btn-unlock" onclick="unlock()">Unlock & Watch</button>
    <p class="text-muted small mt-3">Password: <code>movie123</code></p>
  </div>

  <div id="player" style="display:none">
    <h3 class="mb-3">${movie.title}</h3>
    <p class="text-muted">${movie.genre} · ${movie.duration} min · ${movie.quality} · ⭐ ${movie.rating}</p>
    <video id="vid" controls width="800" poster="${movie.posterUrl}">
      <source src="https://www.w3schools.com/html/mov_bbb.mp4" type="video/mp4">
      Your browser does not support video playback.
    </video>
    <br>
    <a class="btn btn-success mt-3"
       href="https://www.w3schools.com/html/mov_bbb.mp4" download>⬇ Download Movie</a>
    <a class="btn btn-outline-light mt-3 ms-2" href="/my-rentals">← My Rentals</a>
  </div>

  <script>
    const correctPw = '${movie.watchPassword}';
    function unlock() {
      const entered = document.getElementById('pw').value;
      if (entered === correctPw) {
        document.getElementById('lockScreen').style.display = 'none';
        document.getElementById('player').style.display = 'block';
        document.getElementById('vid').play();
      } else {
        alert('❌ Wrong password! Try: movie123');
        document.getElementById('pw').value = '';
        document.getElementById('pw').focus();
      }
    }
    document.getElementById('pw').addEventListener('keypress', function(e) {
      if (e.key === 'Enter') unlock();
    });
  </script>
</body>
</html>
