<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String user_email = request.getParameter("email");


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	 	String sql = "select count(*) as cnt from user where email='"+user_email+"'";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);
	  int rowCnt = 0;
	  while (rs.next()) {
		rowCnt = rs.getInt("cnt");
	  }

	  if(rowCnt > 0){
		out.print("1");

	  }else{
		out.print("0");
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

%>
