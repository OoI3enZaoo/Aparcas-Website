<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />
<%
Vector<Integer> id_district =  new Vector<Integer>();
Vector<Integer> id_province =  new Vector<Integer>();
Vector<String> name_district =  new Vector<String>();

	dbm.createConnection();
	try {

		String sql = "SELECT * FROM District";
		ResultSet rs = dbm.executeQuery(sql);
		
        while(rs.next()){
			id_district.addElement(rs.getInt("Id_District"));
			id_province.addElement(rs.getInt("Id_Province"));
			name_district.addElement(rs.getString("Name"));
		}

	}catch(Exception e){out.print(e);}
	dbm.closeConnection();
	
	//xxxxx create JSON text


	String jsonStr = "{\"AQI_History\":[";
	for(int i=0; i<id_district.size(); i++){
		
		jsonStr += "{\"id_district\":\""+id_district.elementAt(i)+"\",";
		jsonStr += "\"id_province\":\""+id_province.elementAt(i)+"\",";
		jsonStr += "\"Name\":\""+name_district.elementAt(i)+"\"}";
		
			if((i+1) != id_district.size()){ 
			jsonStr += ",";
		}
	}
			jsonStr += "]}";


			out.print(jsonStr);
%>