<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";

Vector<String> scodeVec =  new Vector<String>();
Vector<String> snameVec =  new Vector<String>();
Vector<String> dcodeVec =  new Vector<String>();
Vector<String> dnameVec =  new Vector<String>();
Vector<String> pcodeVec =  new Vector<String>();
Vector<String> pnameVec =  new Vector<String>();


 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);


       String sql =  "SELECT DISTINCT(scode),sname,dcode,dname,pcode,pname FROM grid_lut";

       Statement stmt = con.createStatement();
       ResultSet rs = stmt.executeQuery(sql);
     while (rs.next()) {
         scodeVec.addElement(rs.getString("scode"));
         snameVec.addElement(rs.getString("sname"));
         dcodeVec.addElement(rs.getString("dcode"));
         dnameVec.addElement(rs.getString("dname"));
         pcodeVec.addElement(rs.getString("pcode"));
         pnameVec.addElement(rs.getString("pname"));
     }
     stmt.close();
       con.close();

     String jsonStr = "[";
     for(int i=0; i<scodeVec.size(); i++){
     jsonStr += "{\"scode\":\""+scodeVec.elementAt(i)+"\",";
     jsonStr += "\"sname\":\""+snameVec.elementAt(i)+"\",";
     jsonStr += "\"dcode\":\""+dcodeVec.elementAt(i)+"\",";
     jsonStr += "\"dname\":\""+dnameVec.elementAt(i)+"\",";
     jsonStr += "\"pcode\":\""+pcodeVec.elementAt(i)+"\",";
     jsonStr += "\"pname\":\""+pnameVec.elementAt(i)+"\"}";

     if((i+1) != scodeVec.size()){
     jsonStr += ",";
     }
   }
     jsonStr += "]";

     out.print(jsonStr);


}catch(Exception e){
out.println("exception = "+e);
}

%>
