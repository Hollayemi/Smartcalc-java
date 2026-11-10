<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SmartCalc - Login</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 350px; }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        input { width: 100%; padding: 12px; margin: 8px 0; border: 1px solid #ccc; border-radius: 6px; }
        .btn-group { display: flex; gap: 10px; margin-top: 10px; }
        button { flex: 1; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .btn-login { background-color: #007bff; color: white; }
        .btn-register { background-color: #28a745; color: white; }
        .error { color: red; text-align: center; font-size: 14px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>SmartCalc</h2>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %><div class="error"><%= error %></div><% } %>

        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <div class="btn-group">
                <button type="submit" name="action" value="login" class="btn-login">Login</button>
                <button type="submit" name="action" value="register" class="btn-register">Register</button>
            </div>
        </form>
    </div>
</body>
</html>