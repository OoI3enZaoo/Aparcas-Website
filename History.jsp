<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

Vector<Integer> indexHistory =  new Vector<Integer>();
Vector<Integer> id_district =  new Vector<Integer>();
Vector<String> Date =  new Vector<String>();
Vector<Float> AQI0000 = new Vector<Float>();
Vector<Float> AQI0100 = new Vector<Float>();
Vector<Float> AQI0200 = new Vector<Float>();
Vector<Float> AQI0300 = new Vector<Float>();
Vector<Float> AQI0400 = new Vector<Float>();
Vector<Float> AQI0500 = new Vector<Float>();
Vector<Float> AQI0600 = new Vector<Float>();
Vector<Float> AQI0700 = new Vector<Float>();
Vector<Float> AQI0800 = new Vector<Float>();
Vector<Float> AQI0900 = new Vector<Float>();
Vector<Float> AQI1000 = new Vector<Float>();
Vector<Float> AQI1100 = new Vector<Float>();
Vector<Float> AQI1200 = new Vector<Float>();
Vector<Float> AQI1300 = new Vector<Float>();
Vector<Float> AQI1400 = new Vector<Float>();
Vector<Float> AQI1500 = new Vector<Float>();
Vector<Float> AQI1600 = new Vector<Float>();
Vector<Float> AQI1700 = new Vector<Float>();
Vector<Float> AQI1800 = new Vector<Float>();
Vector<Float> AQI1900 = new Vector<Float>();
Vector<Float> AQI2000 = new Vector<Float>();
Vector<Float> AQI2100 = new Vector<Float>();
Vector<Float> AQI2200 = new Vector<Float>();
Vector<Float> AQI2300 = new Vector<Float>();
 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  
	  String sql = "select * from History ";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		indexHistory.addElement(rs.getInt("Index_History"));
		id_district.addElement(rs.getInt("Id_District"));
		Date.addElement(rs.getDate("Date").toString());
		AQI0000.addElement(rs.getFloat("AQI0000"));
		AQI0100.addElement(rs.getFloat("AQI0100"));
		AQI0200.addElement(rs.getFloat("AQI0200"));
		AQI0300.addElement(rs.getFloat("AQI0300"));
		AQI0400.addElement(rs.getFloat("AQI0400"));
		AQI0500.addElement(rs.getFloat("AQI0500"));
		AQI0600.addElement(rs.getFloat("AQI0600"));
		AQI0700.addElement(rs.getFloat("AQI0700"));
		AQI0800.addElement(rs.getFloat("AQI0800"));
		AQI0900.addElement(rs.getFloat("AQI0900"));
		AQI1000.addElement(rs.getFloat("AQI1000"));
		AQI1100.addElement(rs.getFloat("AQI1100"));
		AQI1200.addElement(rs.getFloat("AQI1200"));
		AQI1300.addElement(rs.getFloat("AQI1300"));
		AQI1400.addElement(rs.getFloat("AQI1400"));
		AQI1500.addElement(rs.getFloat("AQI1500"));
		AQI1600.addElement(rs.getFloat("AQI1600"));
		AQI1700.addElement(rs.getFloat("AQI1700"));
		AQI1800.addElement(rs.getFloat("AQI1800"));
		AQI1900.addElement(rs.getFloat("AQI1900"));
		AQI2000.addElement(rs.getFloat("AQI2000"));
		AQI2100.addElement(rs.getFloat("AQI2100"));
		AQI2200.addElement(rs.getFloat("AQI2200"));
		AQI2300.addElement(rs.getFloat("AQI2300"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "{\"AQI_History\":[";
for(int i=0; i<indexHistory.size(); i++){
	
	jsonStr += "{\"index_History\":\""+indexHistory.elementAt(i)+"\",";
	jsonStr += "\"id_district\":\""+id_district.elementAt(i)+"\",";
	jsonStr += "\"date\":\""+Date.elementAt(i)+"\",";
	jsonStr += "\"AQI0\":\""+AQI0000.elementAt(i)+"\",";
	jsonStr += "\"AQI1\":\""+AQI0100.elementAt(i)+"\",";
	jsonStr += "\"AQI2\":\""+AQI0200.elementAt(i)+"\",";
	jsonStr += "\"AQI3\":\""+AQI0300.elementAt(i)+"\",";
	jsonStr += "\"AQI4\":\""+AQI0400.elementAt(i)+"\",";
	jsonStr += "\"AQI5\":\""+AQI0500.elementAt(i)+"\",";
	jsonStr += "\"AQI6\":\""+AQI0600.elementAt(i)+"\",";
	jsonStr += "\"AQI7\":\""+AQI0700.elementAt(i)+"\",";
	jsonStr += "\"AQI8\":\""+AQI0800.elementAt(i)+"\",";
	jsonStr += "\"AQI9\":\""+AQI0900.elementAt(i)+"\",";
	jsonStr += "\"AQI10\":\""+AQI1000.elementAt(i)+"\",";
	jsonStr += "\"AQI11\":\""+AQI1100.elementAt(i)+"\",";
	jsonStr += "\"AQI12\":\""+AQI1200.elementAt(i)+"\",";
	jsonStr += "\"AQI13\":\""+AQI1300.elementAt(i)+"\",";
	jsonStr += "\"AQI14\":\""+AQI1400.elementAt(i)+"\",";
	jsonStr += "\"AQI15\":\""+AQI1500.elementAt(i)+"\",";
	jsonStr += "\"AQI16\":\""+AQI1600.elementAt(i)+"\",";
	jsonStr += "\"AQI17\":\""+AQI1700.elementAt(i)+"\",";
	jsonStr += "\"AQI18\":\""+AQI1800.elementAt(i)+"\",";
	jsonStr += "\"AQI19\":\""+AQI1900.elementAt(i)+"\",";
	jsonStr += "\"AQI20\":\""+AQI2000.elementAt(i)+"\",";
	jsonStr += "\"AQI21\":\""+AQI2100.elementAt(i)+"\",";
	jsonStr += "\"AQI22\":\""+AQI2200.elementAt(i)+"\",";
	jsonStr += "\"AQI23\":\""+AQI2300.elementAt(i)+"\"}";
	
		if((i+1) != indexHistory.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]}";


		out.print(jsonStr);
%>
