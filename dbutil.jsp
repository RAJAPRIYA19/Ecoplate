<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecoplate", "root", "P1r2i3y4a5.");
    } catch (Exception e) {
        out.println("Database Connection Error: " + e.getMessage());
    }
%>
