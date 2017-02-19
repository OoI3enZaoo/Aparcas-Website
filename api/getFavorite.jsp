

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String uid = request.getParameter("uid");;

Vector<String> scode =  new Vector<String>();

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	  String sql = "SELECT scode FROM `favorite` WHERE user_id = "+uid+"";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);
	  while (rs.next()) {
		    scode.addElement(rs.getString("scode"));
	  }
	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}
String jsonStr = "[";
for(int i=0; i<scode.size(); i++){

	jsonStr += "{\"scode\":\""+scode.elementAt(i)+"\"}";

		if((i+1) != scode.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
