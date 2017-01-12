<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

Vector<Integer> MemberVec =  new Vector<Integer>();
Vector<String> IdVec =  new Vector<String>();
Vector<String> PassVec =  new Vector<String>();
Vector<String> FNameVec =  new Vector<String>();
Vector<String> LNameVec =  new Vector<String>();
Vector<String> EmailVec =  new Vector<String>();
Vector<String> PhoneVec =  new Vector<String>();
Vector<Integer> ExpVec =  new Vector<Integer>();




 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
	  
	  String sql = "select * from Member ";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		MemberVec.addElement(rs.getInt("Member_Code"));
		IdVec.addElement(rs.getString("Id"));
		PassVec.addElement(rs.getString("Password"));
		FNameVec.addElement(rs.getString("F_Name"));
		LNameVec.addElement(rs.getString("L_Name"));
		EmailVec.addElement(rs.getString("Email"));
		PhoneVec.addElement(rs.getString("Phone"));
		ExpVec.addElement(rs.getInt("EXP"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "{\"Login\":[";
for(int i=0; i<MemberVec.size(); i++){
	
	jsonStr += "{\"member\":\""+MemberVec.elementAt(i)+"\",";
	jsonStr += "\"id\":\""+IdVec.elementAt(i)+"\",";
	jsonStr += "\"pass\":\""+PassVec.elementAt(i)+"\",";
	jsonStr += "\"fname\":\""+FNameVec.elementAt(i)+"\",";
	jsonStr += "\"lname\":\""+LNameVec.elementAt(i)+"\",";
	jsonStr += "\"email\":\""+EmailVec.elementAt(i)+"\",";
	jsonStr += "\"phone\":\""+PhoneVec.elementAt(i)+"\",";
	jsonStr += "\"exp\":\""+ExpVec.elementAt(i)+"\"}";
	
		if((i+1) != MemberVec.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]}";


		out.print(jsonStr);
%>
