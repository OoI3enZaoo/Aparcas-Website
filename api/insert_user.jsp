<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%

String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";


String user_id = request.getParameter("user_id");
String user_pwd = request.getParameter("user_pwd");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String bdate = request.getParameter("bdate");
String email = request.getParameter("email");



 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  String sql = "INSERT INTO user VALUES ("+user_id+",'"+user_pwd+"','"+fname+"','"+lname+"','"+bdate+"','"+email+"')";
      Statement stmt = con.createStatement();
      stmt.executeUpdate(sql);
	  stmt.close();
      con.close();


}catch(Exception e){
	out.println("exception = "+e);
}

%>
