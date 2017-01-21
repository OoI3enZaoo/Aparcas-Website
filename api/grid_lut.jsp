<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

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

        

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);	  
	  String sql = "select SUB_CODE ,SNAME,DCODE,DNAME ,xmin,xmax,ymin,ymax  ,PNAME,PCODE from grid_lut ";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {		
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
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<scode.size(); i++){
	
	jsonStr += "{\"scode\":\""+scode.elementAt(i)+"\",";	
    jsonStr += "\"sname\":\""+sname.elementAt(i)+"\",";
    jsonStr += "\"dcode\":\""+dcode.elementAt(i)+"\",";
    jsonStr += "\"dname\":\""+dname.elementAt(i)+"\",";
    jsonStr += "\"xmin\":\""+xmin.elementAt(i)+"\",";
    jsonStr += "\"xmax\":\""+xmax.elementAt(i)+"\",";
    jsonStr += "\"ymin\":\""+ymin.elementAt(i)+"\",";
    jsonStr += "\"ymax\":\""+ymax.elementAt(i)+"\",";	
    jsonStr += "\"pname\":\""+pname.elementAt(i)+"\",";	
    jsonStr += "\"pcode\":\""+pcode.elementAt(i)+"\"}";	
	
	
		if((i+1) != scode.size()){ 
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
