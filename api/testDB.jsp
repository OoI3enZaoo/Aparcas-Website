<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />
<%

	dbm.createConnection();
	try {

		String sql = "SELECT * FROM caregiver";
		ResultSet rs = dbm.executeQuery(sql);
		
        while(rs.next()){
			out.println("first name: "+rs.getString("firstname")+", ");
			out.println("last name: "+rs.getString("lastname")+"<br>");
		}

	}catch(Exception e){out.print(e);}
	dbm.closeConnection();
%>