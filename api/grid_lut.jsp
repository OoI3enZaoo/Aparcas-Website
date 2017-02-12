<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String sql = null;
String data = request.getParameter("data");
Vector<String> idVec =  new Vector<String>();
Vector<String> scode =  new Vector<String>();
Vector<String> sname =  new Vector<String>();
Vector<String> dcode =  new Vector<String>();
Vector<String> dname =  new Vector<String>();
Vector<String> xmin =  new Vector<String>();
Vector<String> xmax =  new Vector<String>();
Vector<String> ymin =  new Vector<String>();
Vector<String> ymax =  new Vector<String>();
Vector<String> pname =  new Vector<String>();
Vector<String> pcode =  new Vector<String>();
Vector<String> aqiVec =  new Vector<String>();
Vector<String> tstampVec =  new Vector<String>();



 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
    if(data == null){
      sql = "select id,SUB_CODE ,SNAME,DCODE,DNAME ,xmin,xmax,ymin,ymax ,PNAME,PCODE,aqi ,tstamp from grid_lut where aqi >0  order by id DESC limit 140";

    }
    else if (data.equals("3HourAgo")){
      sql = "SELECT id,SUB_CODE ,SNAME,DCODE,DNAME ,xmin,xmax,ymin,ymax ,PNAME,PCODE,aqi ,tstamp  FROM grid_lut WHERE tstamp > DATE_SUB(NOW(), INTERVAL 70 Hour)";
    }
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
        idVec.addElement(rs.getString("id"));
        scode.addElement(rs.getString("SUB_CODE"));
        sname.addElement(rs.getString("SNAME"));
        dcode.addElement(rs.getString("DCODE"));
        dname.addElement(rs.getString("DNAME"));
        xmin.addElement(rs.getString("xmin"));
        xmax.addElement(rs.getString("xmax"));
        ymin.addElement(rs.getString("ymin"));
        ymax.addElement(rs.getString("ymax"));
        pname.addElement(rs.getString("PNAME"));
        pcode.addElement(rs.getString("PCODE"));
        aqiVec.addElement(rs.getString("aqi"));
        tstampVec.addElement(rs.getString("tstamp"));

	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<scode.size(); i++){
    jsonStr += "{\"id\":\""+idVec.elementAt(i)+"\",";
	   jsonStr += "\"scode\":\""+scode.elementAt(i)+"\",";
    jsonStr += "\"sname\":\""+sname.elementAt(i)+"\",";
    jsonStr += "\"dcode\":\""+dcode.elementAt(i)+"\",";
    jsonStr += "\"dname\":\""+dname.elementAt(i)+"\",";
    jsonStr += "\"xmin\":\""+xmin.elementAt(i)+"\",";
    jsonStr += "\"xmax\":\""+xmax.elementAt(i)+"\",";
    jsonStr += "\"ymin\":\""+ymin.elementAt(i)+"\",";
    jsonStr += "\"ymax\":\""+ymax.elementAt(i)+"\",";
    jsonStr += "\"pname\":\""+pname.elementAt(i)+"\",";
    jsonStr += "\"pcode\":\""+pcode.elementAt(i)+"\",";
    jsonStr += "\"aqi\":\""+aqiVec.elementAt(i)+"\",";
    jsonStr += "\"timestamp\":\""+tstampVec.elementAt(i)+"\"}";


		if((i+1) != scode.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
