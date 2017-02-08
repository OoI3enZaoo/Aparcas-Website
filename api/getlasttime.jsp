
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";


Vector<String> Time =  new Vector<String>();


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	  String sql = "SELECT  from_unixtime(tstamp,'%Y-%m-%d') AS Time FROM event_trans ORDER by from_unixtime(tstamp) DESC LIMIT 1";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		Time.addElement(rs.getString("Time"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<Time.size(); i++){

	jsonStr += "{\"mTime\":\""+Time.elementAt(i)+"\"}";


		if((i+1) != Time.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
