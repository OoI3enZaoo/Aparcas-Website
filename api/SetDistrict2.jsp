<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%

String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";

String id = request.getParameter("id");
String name = request.getParameter("name");
String province = request.getParameter("province");
String co = request.getParameter("co");
String no2 = request.getParameter("no2");
String o3 = request.getParameter("o3");
String so2 = request.getParameter("so2");
String pm25 = request.getParameter("pm25");
String radio = request.getParameter("radio");
String timestamp = request.getParameter("timestamp");


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  String sql = "INSERT INTO District2 VALUES ("+id+",'"+name+"','"+province+"',"+co+","+no2+","+o3+","+so2+","+pm25+","+radio+",'"+timestamp+"')";
	  

      Statement stmt = con.createStatement();
      stmt.executeUpdate(sql);   
	  stmt.close();
      con.close();


}catch(Exception e){
	out.println("exception = "+e);
}

%>
