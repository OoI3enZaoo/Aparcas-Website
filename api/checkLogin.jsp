<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String userDB = "root";
String passDB = "";
String urlDB = "jdbc:mysql://sysnet.utcc.ac.th/Aparcas?";

String user_email = request.getParameter("user_email");
String user_pwd = request.getParameter("user_pwd");

Vector<Integer> cnt =  new Vector<Integer>();
Vector<String> fname =  new Vector<String>();
Vector<String> lname =  new Vector<String>();
Vector<String> user_id =  new Vector<String>();

 try {
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection(urlDB,userDB,passDB);

	 	String sql = "select count(*) as cnt , fname,lname,user_id from user where email='"+user_email+"' and user_pwd='"+user_pwd+"'";
      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery(sql);
	  int rowCnt = 0;
	   while (rs.next()) {
        cnt.addElement(rs.getInt("cnt"));
        fname.addElement(rs.getString("fname"));
        lname.addElement(rs.getString("lname"));
        user_id.addElement(rs.getString("user_id"));
	  }
	  stmt.close();
      con.close();

}catch(Exception e){
	out.println("exception = "+e);
}

String jsonStr = "[";
for(int i=0; i<cnt.size(); i++){
	jsonStr += "{\"cnt\":\""+cnt.elementAt(i)+"\",";
  jsonStr += "\"fname\":\""+fname.elementAt(i)+"\",";
  jsonStr += "\"lname\":\""+lname.elementAt(i)+"\",";
  jsonStr += "\"user_id\":\""+user_id.elementAt(i)+"\"}";

		if((i+1) != cnt.size()){
		jsonStr += ",";
	}
}
		jsonStr += "]";


		out.print(jsonStr);


%>
