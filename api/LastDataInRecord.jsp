
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";



String scode = request.getParameter("scode");

Vector<String> aqiVec =  new Vector<String>();
Vector<String> coVec =  new Vector<String>();
Vector<String> no2Vec =  new Vector<String>();
Vector<String> o3Vec =  new Vector<String>();
Vector<String> so2Vec =  new Vector<String>();
Vector<String> pm25Vec =  new Vector<String>();
Vector<String> radVec =  new Vector<String>();
Vector<String> uidVec =  new Vector<String>();
Vector<String> tstampVec =  new Vector<String>();
Vector<String> snameVec =  new Vector<String>();
Vector<String> dnameVec =  new Vector<String>();
Vector<String> pnameVec =  new Vector<String>();

String user_id = null;
String tstamp = null;
String sql = null;
;
ResultSet rs;
Statement stmt;

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	  sql = "select unix_timestamp(tstamp) as tstamp, user_id from grid_lut where scode = '"+scode+"' and tstamp = (SELECT max(tstamp) FROM `grid_lut` WHERE scode = '"+scode+"' and tstamp not like 0) and user_id not like ''";
      stmt = con.createStatement();
      rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		    user_id = rs.getString("user_id");
        tstamp = rs.getString("tstamp");
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}


try {
   Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

   sql = "SELECT aqi,co,no2,o3,so2,pm25,rad,user_id,from_unixtime(tstamp) as tstamp FROM event_trans WHERE tstamp = "+tstamp+" and user_id = "+user_id+"";
     stmt = con.createStatement();
     rs = stmt.executeQuery(sql);

   while (rs.next()) {
     aqiVec.addElement(rs.getString("aqi"));
     coVec.addElement(rs.getString("co"));
     no2Vec.addElement(rs.getString("no2"));
     o3Vec.addElement(rs.getString("o3"));
     so2Vec.addElement(rs.getString("so2"));
     pm25Vec.addElement(rs.getString("pm25"));
     radVec.addElement(rs.getString("rad"));
     tstampVec.addElement(rs.getString("tstamp"));
     uidVec.addElement(rs.getString("user_id"));
   }


   stmt.close();
     con.close();

}catch(Exception e){
 out.println("exception = "+e);
}


try {
   Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

   sql = "SELECT sname ,dname,pname FROM `grid_lut` WHERE scode = "+scode+" limit 1";
     stmt = con.createStatement();
     rs = stmt.executeQuery(sql);

   while (rs.next()) {
     snameVec.addElement(rs.getString("sname"));
     dnameVec.addElement(rs.getString("dname"));
     pnameVec.addElement(rs.getString("pname"));

   }


   stmt.close();
     con.close();

}catch(Exception e){
 out.println("exception = "+e);
}









//xxxxx create JSON text



String jsonStr = "[";
for(int i=0; i<aqiVec.size(); i++){

  jsonStr += "{\"aqi\":\""+aqiVec.elementAt(i)+"\",";
  jsonStr += "\"co\":\""+coVec.elementAt(i)+"\",";
  jsonStr += "\"no2\":\""+no2Vec.elementAt(i)+"\",";
  jsonStr += "\"o3\":\""+o3Vec.elementAt(i)+"\",";
  jsonStr += "\"so2\":\""+so2Vec.elementAt(i)+"\",";
  jsonStr += "\"pm25\":\""+pm25Vec.elementAt(i)+"\",";
  jsonStr += "\"rad\":\""+radVec.elementAt(i)+"\",";
  jsonStr += "\"tstamp\":\""+tstampVec.elementAt(i)+"\",";
  jsonStr += "\"user_id\":\""+uidVec.elementAt(i)+"\",";
  jsonStr += "\"sname\":\""+snameVec.elementAt(i)+"\",";
  jsonStr += "\"dname\":\""+dnameVec.elementAt(i)+"\",";
  jsonStr += "\"pname\":\""+pnameVec.elementAt(i)+"\"}";


		if((i+1) != aqiVec.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
