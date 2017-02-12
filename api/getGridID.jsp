
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";

String[] grids = request.getParameterValues("grids");

String gridsname = request.getParameter("gridsname");
Vector<String> idVec =  new Vector<String>();




String sql  = null;
 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);


if(grids != null && gridsname == null){
    String result = "";
    for(int i = 0; i<grids.length; i++){
        if(i+1 == grids.length ){
          result = result +grids[i];
        }else{
          result = result  +grids[i] + ",";
        }
      }
	  sql = "SELECT DISTINCT(id) FROM grid_lut WHERE SCODE in ("+result+")";

}
else if (gridsname != null && grids == null){
  sql = "SELECT DISTINCT(id) FROM grid_lut WHERE SNAME = '"+gridsname+"'";


}


      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);

	  while (rs.next()) {
		idVec.addElement(rs.getString("id"));
	  }

	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

//xxxxx create JSON text


String jsonStr = "[";
for(int i=0; i<idVec.size(); i++){

	jsonStr += "{\"id\":\""+idVec.elementAt(i)+"\"}";


		if((i+1) != idVec.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);
%>
