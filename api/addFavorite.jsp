<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String sql = null;
String uid = request.getParameter("uid");
String scode = request.getParameter("scode");


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

      sql = "INSERT INTO favorite VALUES ('"+uid+"',"+scode+");";

      Statement stmt = con.createStatement();
      stmt.executeUpdate(sql);
	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

%>
