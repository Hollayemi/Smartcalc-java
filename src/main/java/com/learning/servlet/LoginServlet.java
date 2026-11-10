package com.learning.servlet;

import com.learning.dao.UserDAO;
import com.learning.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String action = req.getParameter("action"); // "login" or "register"

        System.out.println(username + " " + password + " " + action);

        if ("register".equals(action)) {
            User newUser = new User(0, username, password);

            if (userDAO.register(newUser)) {
                resp.sendRedirect("login.jsp?registered=true");
            } else {
                resp.sendRedirect("login.jsp?error=Username already exists");
            }
        } else {
            User user = userDAO.login(username, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user); // Store user in session
                resp.sendRedirect("index.jsp");
            } else {
                resp.sendRedirect("login.jsp?error=Invalid credentials");
            }
        }
    }
}