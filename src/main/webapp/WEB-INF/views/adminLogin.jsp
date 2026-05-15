<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login — CineRent</title>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
      --cream:   #F5F0E8;
      --paper:   #EDE6D6;
      --ink:     #1A1410;
      --red:     #C0392B;
      --red-dim: #8B2318;
      --gold:    #B8933A;
      --mid:     #6B5D4F;
      --line:    rgba(26,20,16,0.15);
    }

    body {
      min-height: 100vh;
      background-color: var(--ink);
      background-image:
        repeating-linear-gradient(
          0deg,
          transparent,
          transparent 39px,
          rgba(255,255,255,0.03) 39px,
          rgba(255,255,255,0.03) 40px
        );
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'DM Mono', monospace;
      padding: 2rem;
    }

    /* Film strip left edge */
    body::before {
      content: '';
      position: fixed;
      left: 0; top: 0; bottom: 0;
      width: 48px;
      background:
        repeating-linear-gradient(
          180deg,
          transparent 0px,
          transparent 28px,
          rgba(255,255,255,0.06) 28px,
          rgba(255,255,255,0.06) 32px,
          transparent 32px,
          transparent 60px
        );
      border-right: 1px solid rgba(255,255,255,0.04);
    }
    body::after {
      content: '';
      position: fixed;
      right: 0; top: 0; bottom: 0;
      width: 48px;
      background:
        repeating-linear-gradient(
          180deg,
          transparent 0px,
          transparent 28px,
          rgba(255,255,255,0.06) 28px,
          rgba(255,255,255,0.06) 32px,
          transparent 32px,
          transparent 60px
        );
      border-left: 1px solid rgba(255,255,255,0.04);
    }

    /* Ticket / card */
    .ticket {
      width: 100%;
      max-width: 420px;
      background: var(--cream);
      position: relative;
      animation: slideUp 0.55s cubic-bezier(0.22, 1, 0.36, 1) both;
    }

    @keyframes slideUp {
      from { opacity: 0; transform: translateY(28px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    /* Ticket top — header block */
    .ticket-head {
      background: var(--ink);
      padding: 28px 32px 24px;
      position: relative;
      overflow: hidden;
    }

    .ticket-head::after {
      content: '';
      position: absolute;
      bottom: 0; left: 0; right: 0;
      height: 1px;
      background: repeating-linear-gradient(
        90deg,
        var(--gold) 0px, var(--gold) 6px,
        transparent 6px, transparent 12px
      );
    }

    .brand {
      font-family: 'Bebas Neue', sans-serif;
      font-size: 11px;
      letter-spacing: 0.35em;
      color: var(--gold);
      margin-bottom: 6px;
    }

    .ticket-title {
      font-family: 'Bebas Neue', sans-serif;
      font-size: 48px;
      color: var(--cream);
      line-height: 1;
      letter-spacing: 0.04em;
    }

    .ticket-title span {
      color: var(--red);
    }

    .ticket-sub {
      font-size: 10px;
      letter-spacing: 0.2em;
      color: var(--mid);
      margin-top: 10px;
      text-transform: uppercase;
    }

    /* Perforation between head and body */
    .perf {
      display: flex;
      align-items: center;
      position: relative;
      background: var(--ink);
    }

    .perf-edge {
      width: 24px;
      height: 24px;
      background: var(--ink);
      border-radius: 50%;
      flex-shrink: 0;
      position: relative;
      z-index: 2;
    }
    .perf-edge.left  { margin-left: -12px; background: #0e0c09; }
    .perf-edge.right { margin-right: -12px; background: #0e0c09; }

    .perf-line {
      flex: 1;
      border-top: 2px dashed rgba(255,255,255,0.08);
    }

    /* Body */
    .ticket-body {
      background: var(--paper);
      padding: 28px 32px 32px;
    }

    /* Error */
    .alert {
      font-size: 11px;
      letter-spacing: 0.05em;
      color: var(--red);
      border-left: 3px solid var(--red);
      padding: 8px 12px;
      margin-bottom: 20px;
      background: rgba(192,57,43,0.07);
    }

    /* Field */
    .field {
      margin-bottom: 18px;
      animation: slideUp 0.55s cubic-bezier(0.22, 1, 0.36, 1) both;
    }
    .field:nth-child(2) { animation-delay: 0.07s; }
    .field:nth-child(3) { animation-delay: 0.14s; }

    label {
      display: block;
      font-size: 10px;
      letter-spacing: 0.25em;
      text-transform: uppercase;
      color: var(--mid);
      margin-bottom: 6px;
    }

    input {
      width: 100%;
      background: var(--cream);
      border: none;
      border-bottom: 1.5px solid var(--line);
      padding: 10px 0;
      font-family: 'DM Mono', monospace;
      font-size: 14px;
      color: var(--ink);
      outline: none;
      transition: border-color 0.2s;
      caret-color: var(--red);
    }

    input:focus {
      border-bottom-color: var(--red);
    }

    input::placeholder {
      color: rgba(26,20,16,0.25);
      font-weight: 300;
    }

    /* Rule */
    .rule {
      border: none;
      border-top: 1px solid var(--line);
      margin: 24px 0;
    }

    /* Submit button */
    .btn {
      width: 100%;
      background: var(--ink);
      color: var(--cream);
      border: none;
      padding: 14px;
      font-family: 'Bebas Neue', sans-serif;
      font-size: 20px;
      letter-spacing: 0.18em;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      transition: background 0.2s;
    }

    .btn::before {
      content: '';
      position: absolute;
      inset: 0;
      background: var(--red);
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 0.3s cubic-bezier(0.22, 1, 0.36, 1);
    }

    .btn:hover::before { transform: scaleX(1); }

    .btn span {
      position: relative;
      z-index: 1;
    }

    /* Seat dots decor */
    .dots {
      position: absolute;
      top: 20px; right: 28px;
      display: flex; gap: 5px;
    }
    .dot {
      width: 6px; height: 6px;
      border-radius: 50%;
      background: rgba(255,255,255,0.1);
    }
    .dot:last-child { background: var(--red); opacity: 0.7; }
  </style>
</head>
<body>

  <div class="ticket">

    <!-- Header -->
    <div class="ticket-head">
      <div class="dots">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
      </div>
      <div class="brand">CineRent — Staff Access</div>
      <div class="ticket-title">ADMIN<br><span>PANEL</span></div>
      <div class="ticket-sub">Authorized Personnel Only</div>
    </div>

    <!-- Perforation -->
    <div class="perf">
      <div class="perf-edge left"></div>
      <div class="perf-line"></div>
      <div class="perf-edge right"></div>
    </div>

    <!-- Form body -->
    <div class="ticket-body">

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert"><%= request.getAttribute("error") %></div>
      <% } %>

      <form method="post" action="/admin/login">

        <div class="field">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Enter username"
            autocomplete="off"
            required>
        </div>

        <div class="field">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter password"
            required>
        </div>

        <hr class="rule">

        <button class="btn" type="submit">
          <span>Authenticate</span>
        </button>

      </form>
    </div>

  </div>

</body>
</html>
