<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String sql = null;
String data = request.getParameter("data");
Vector<String> scode =  new Vector<String>();
Vector<String> sname =  new Vector<String>();
Vector<String> dcode =  new Vector<String>();
Vector<String> dname =  new Vector<String>();
Vector<String> pname =  new Vector<String>();
Vector<String> pcode =  new Vector<String>();



 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);
    if(data == null){
      sql = "SELECT DISTINCT sname, scode,DNAME,DCODE,PCODE,PNAME FROM grid_lut ORDER by SNAME";
    }

      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
        scode.addElement(rs.getString("scode"));
        sname.addElement(rs.getString("SNAME"));
        dcode.addElement(rs.getString("DCODE"));
        dname.addElement(rs.getString("DNAME"));
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
    jsonStr += "\"pname\":\""+pname.elementAt(i)+"\",";
    jsonStr += "\"pcode\":\""+pcode.elementAt(i)+"\"}";



		if((i+1) != scode.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
