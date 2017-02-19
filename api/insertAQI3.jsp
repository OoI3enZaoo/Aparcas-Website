<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%

String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";


String id = request.getParameter("id");
String name = request.getParameter("name");



 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	  String sql = "INSERT INTO AQI3 VALUES ("+id+",'"+name+"')";

      Statement stmt = con.createStatement();
      stmt.executeUpdate(sql);   
	  stmt.close();
      con.close();


}catch(Exception e){
	out.println("exception = "+e);
}

%>
