package com.learning.model;

public class Calculation {
    private double operand1;
    private double operand2;
    private String operator;
    private double result;

    public Calculation(double operand1, double operand2, String operator, double result) {
        this.operand1 = operand1;
        this.operand2 = operand2;
        this.operator = operator;
        this.result = result;
    }
    // Getters
    public double getOperand1() { return operand1; }
    public double getOperand2() { return operand2; }
    public String getOperator() { return operator; }
    public double getResult() { return result; }
}