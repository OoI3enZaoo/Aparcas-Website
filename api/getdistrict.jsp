<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?characterEncoding=UTF-8";

Vector<String> data1 =  new Vector<String>();
Vector<String> data2 =  new Vector<String>();


String data = request.getParameter("data");
String checkdname = request.getParameter("checkdname");
String grid_id = request.getParameter("grid_id");
String sql = null;
String value1 = null;
String value2 = null;

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

    if(data.equals("s") && checkdname != null){
       value1 = "sname";
       value2 = "scode";
       sql =  "SELECT DISTINCT "+value1+" , "+value2+" FROM grid_lut where dname = '"+checkdname+"'";

     }
      else if(data.equals("d") && checkdname == null){
          value1 = "dname";
          value2 = "dcode";
         sql =  "SELECT DISTINCT  "+value1+" , "+value2+" FROM grid_lut";

       }
       else if (data.equals("sd") && grid_id != null){
         value1 = "dname";
         value2 = "sname";
         sql =  "SELECT "+value1+" , "+value2+"  FROM grid_lut where id =  "+grid_id+"";
       }
       Statement stmt = con.createStatement();
       ResultSet rs = stmt.executeQuery(sql);
     while (rs.next()) {
         data1.addElement(rs.getString(value1));
         data2.addElement(rs.getString(value2));
     }
     stmt.close();
       con.close();


     String jsonStr = "[";
     for(int i=0; i<data1.size(); i++){
     jsonStr += "{\""+value1+"\":\""+data1.elementAt(i)+"\",";
     jsonStr += "\""+value2+"\":\""+data2.elementAt(i)+"\"}";

     if((i+1) != data1.size()){
     jsonStr += ",";
     }
   }
     jsonStr += "]";

     out.print(jsonStr);


}catch(Exception e){
out.println("exception = "+e);
}

%>
