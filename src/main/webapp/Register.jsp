<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
    <%@ page import="javax.sql.*" %>
    <%
        String fname1 = request.getParameter("fname");
        String lname1 = request.getParameter("lname");
        String email1 = request.getParameter("email");
       
        String uid1 = request.getParameter("uid");
       
        String address1 = request.getParameter("address");
        String pass1 = request.getParameter("pass1");
        String pass2 = request.getParameter("pass2");

        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        Connection conn = null;
        ResultSet rs = null;

        String query1 = "SELECT uid FROM customer WHERE uid=?";
        String query2 = "INSERT INTO customer(uid, pass, fname, lname, email, address) VALUES(?, ?, ?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase", "root", "Chetarsh@123");
            ps1 = conn.prepareStatement(query1);
            ps1.setString(1, uid1);
            rs = ps1.executeQuery();

            if (rs.next()) {
                response.sendRedirect("RegisterError1.html");
            } else {
                if (pass1.equals(pass2)) {
                    ps2 = conn.prepareStatement(query2);
                    ps2.setString(1, uid1);
                    ps2.setString(2, pass1);
                    ps2.setString(3, fname1);
                    ps2.setString(4, lname1);
                    ps2.setString(5, email1);
                    ps2.setString(6, address1);
                    
                    int i = ps2.executeUpdate();
                    response.sendRedirect("Login.html");
                } else {
                    response.sendRedirect("RegisterError2.html");
                }
            }
        } catch (Exception e) {
            out.println(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>    
</body>
</html>
