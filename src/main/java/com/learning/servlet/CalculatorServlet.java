package com.learning.servlet;

import com.learning.dao.CalculationDAO;
import com.learning.model.Calculation;
import com.learning.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet {
    private CalculationDAO calcDAO = new CalculationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Check Session (Session Management)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp?error=Please login first"); // Session expired or not logged in
            return;
        }
        User user = (User) session.getAttribute("user");

        // 2. Perform Math
        double num1 = Double.parseDouble(req.getParameter("num1"));
        double num2 = Double.parseDouble(req.getParameter("num2"));
        String operator = req.getParameter("operator");
        double result = 0;

        switch (operator) {
            case "+": result = num1 + num2; break;
            case "-": result = num1 - num2; break;
            case "*": result = num1 * num2; break;
            case "/":
                if (num2 == 0) {
                    req.setAttribute("error", "Cannot divide by zero!");
                    req.getRequestDispatcher("index.jsp").forward(req, resp);
                    return;
                }
                result = num1 / num2; break;
        }

        // 3. Save to DB linked to user
        calcDAO.save(user.getId(), new Calculation(num1, num2, operator, result));

        // 4. Redirect back to index to prevent form resubmission on refresh
        req.setAttribute("result", result);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}