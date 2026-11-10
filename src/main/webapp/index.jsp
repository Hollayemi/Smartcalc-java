<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.learning.model.User" %>
<%@ page import="com.learning.dao.CalculationDAO" %>
<%@ page import="com.learning.model.Calculation" %>
<%@ page import="java.util.List" %>

<%
    // Check session on page load
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }

    // Fetch history
    CalculationDAO dao = new CalculationDAO();
    List<Calculation> history = dao.getHistory(user.getId());
%>

<html>
<head>
    <title>SmartCalc - Dashboard</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; background: #fff; padding: 15px 25px; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .header h1 { margin: 0; font-size: 24px; color: #333; }
        .logout { color: #dc3545; text-decoration: none; font-weight: bold; }
        .calc-box { background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 20px; text-align: center; }
        .calc-box input, .calc-box select { padding: 10px; font-size: 16px; border: 1px solid #ddd; border-radius: 5px; margin: 5px; width: 100px; }
        .calc-box button { padding: 10px 20px; font-size: 16px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .calc-box button:hover { background: #0056b3; }
        .result-display { font-size: 20px; font-weight: bold; color: #28a745; margin-top: 15px; }
        .history-table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .history-table th, .history-table td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        .history-table th { background-color: #007bff; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Welcome, <%= user.getUsername() %>!</h1>
            <a href="logout" class="logout">Logout</a>
        </div>

        <div class="calc-box">
            <h3>Perform Calculation</h3>
            <form action="calculate" method="post">
                <input type="number" step="any" name="num1" required placeholder="0">
                <select name="operator">
                    <option value="+">+</option>
                    <option value="-">-</option>
                    <option value="*">×</option>
                    <option value="/">÷</option>
                </select>
                <input type="number" step="any" name="num2" required placeholder="0">
                <button type="submit">Calculate</button>
            </form>

            <% if (request.getAttribute("result") != null) { %>
                <div class="result-display">Result: <%= request.getAttribute("result") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div style="color: red; margin-top: 10px;"><%= request.getAttribute("error") %></div>
            <% } %>
        </div>

        <h3>Your Calculation History</h3>
        <table class="history-table">
            <thead>
                <tr>
                    <th>Expression</th>
                    <th>Result</th>
                </tr>
            </thead>
            <tbody>
                <% if (history.isEmpty()) { %>
                    <tr><td colspan="2" style="text-align: center;">No calculations yet.</td></tr>
                <% } else {
                    for (Calculation c : history) { %>
                    <tr>
                        <td><%= c.getOperand1() %> <%= c.getOperator() %> <%= c.getOperand2() %></td>
                        <td><strong><%= c.getResult() %></strong></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
</body>
</html>