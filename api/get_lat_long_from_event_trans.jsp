<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

Vector<String> IDVec =  new Vector<String>();
Vector<String> latVec =  new Vector<String>();
Vector<String> lonVec =  new Vector<String>();
Vector<String> TimeVec =  new Vector<String>();


Vector<String> Time =  new Vector<String>();


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  
	  String sql = "select user_id ,lat,lon,tstamp from event_trans";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
          IDVec.addElement(rs.getString("user_id"));	
		latVec.addElement(rs.getString("lat"));
		lonVec.addElement(rs.getString("lon"));		
		TimeVec.addElement(rs.getString("tstamp"));		
		
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<lonVec.size(); i++){	
    jsonStr += "{\"uid\":\""+IDVec.elementAt(i)+"\",";	
	jsonStr += "\"lat\":\""+latVec.elementAt(i)+"\",";	    
	jsonStr += "\"lon\":\""+lonVec.elementAt(i)+"\",";
	jsonStr += "\"tstamp\":\""+TimeVec.elementAt(i)+"\"}";	 
	
		if((i+1) != lonVec.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
