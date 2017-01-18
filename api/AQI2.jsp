<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

Vector<String> idVec =  new Vector<String>();
Vector<String> NameVec =  new Vector<String>();
Vector<String> LatVec =  new Vector<String>();
Vector<String> LongVec =  new Vector<String>();
Vector<Float> COVec =  new Vector<Float>();
Vector<Float> NO2Vec =  new Vector<Float>();
Vector<Float> O3Vec =  new Vector<Float>();
Vector<Float> SO2Vec =  new Vector<Float>();
Vector<Float> PM25Vec =  new Vector<Float>();
Vector<Float> RadioVec =  new Vector<Float>();
Vector<String> DID =  new Vector<String>();
Vector<String> DNAME =  new Vector<String>();
Vector<String> Time =  new Vector<String>();


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  
	  String sql = "select * from AQI2 ";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		idVec.addElement(rs.getString("id"));
		NameVec.addElement(rs.getString("first_name"));
		LatVec.addElement(rs.getString("Lat"));
		LongVec.addElement(rs.getString("Lng"));
		COVec.addElement(rs.getFloat("CO"));
		NO2Vec.addElement(rs.getFloat("NO2"));
		O3Vec.addElement(rs.getFloat("O3"));
		SO2Vec.addElement(rs.getFloat("SO2"));
		PM25Vec.addElement(rs.getFloat("PM25"));
		DID.addElement(rs.getString("district_id"));
		DNAME.addElement(rs.getString("district_name"));
		RadioVec.addElement(rs.getFloat("Radio"));
		
		Time.addElement(rs.getString("timestamp"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<idVec.size(); i++){
	
	jsonStr += "{\"id\":\""+idVec.elementAt(i)+"\",";
	jsonStr += "\"name\":\""+NameVec.elementAt(i)+"\",";
	jsonStr += "\"lat\":\""+LatVec.elementAt(i)+"\",";
	jsonStr += "\"long\":\""+LongVec.elementAt(i)+"\",";
	jsonStr += "\"co\":\""+COVec.elementAt(i)+"\",";
	jsonStr += "\"no2\":\""+NO2Vec.elementAt(i)+"\",";
	jsonStr += "\"o3\":\""+O3Vec.elementAt(i)+"\",";
	jsonStr += "\"so2\":\""+SO2Vec.elementAt(i)+"\",";
	jsonStr += "\"pm25\":\""+PM25Vec.elementAt(i)+"\",";
	jsonStr += "\"radio\":\""+RadioVec.elementAt(i)+"\",";
	jsonStr += "\"districtID\":\""+DID.elementAt(i)+"\",";
	jsonStr += "\"districtName\":\""+DNAME.elementAt(i)+"\",";
	jsonStr += "\"timestamp\":\""+Time.elementAt(i)+"\"}";
	
		if((i+1) != idVec.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
