<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  	
	  String id = request.getParameter("id");
	  String pass = request.getParameter("pass");
	  String fname = request.getParameter("fname");
	  String lname = request.getParameter("lname");
	  String email = request.getParameter("email");
	  String phone = request.getParameter("phone");
	  
		String sql = "INSERT INTO Member " +
				"(Id , Password, F_Name, L_Name, Email, Phone, EXP) " + 
				"VALUES ('" + id + "','" + pass + "' " +
				",'" + fname + "','" + lname + "'" +
				",'" + email + "','" + phone + "','0') ";
	  Statement stmt = con.createStatement();
      

	  stmt.execute(sql);

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

%>
