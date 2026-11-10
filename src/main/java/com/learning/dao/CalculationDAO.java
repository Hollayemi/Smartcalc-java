package com.learning.dao;

import com.learning.model.Calculation;
import com.learning.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CalculationDAO {
    // Save calculation for a specific user
    public void save(int userId, Calculation calc) {
        String sql = "INSERT INTO calculation_history (user_id, operand1, operand2, operator, result) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setDouble(2, calc.getOperand1());
            stmt.setDouble(3, calc.getOperand2());
            stmt.setString(4, calc.getOperator());
            stmt.setDouble(5, calc.getResult());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get history for a specific user
    public List<Calculation> getHistory(int userId) {
        List<Calculation> history = new ArrayList<>();
        String sql = "SELECT * FROM calculation_history WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                history.add(new Calculation(
                        rs.getDouble("operand1"),
                        rs.getDouble("operand2"),
                        rs.getString("operator"),
                        rs.getDouble("result")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}