<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />
<%
	 String id = request.getParameter("id");
	 String pass = request.getParameter("pass");
	 String fname = request.getParameter("fname");
	 String lname = request.getParameter("lname");
	 String email = request.getParameter("email");
	 String phone = request.getParameter("phone");

	dbm.createConnection();
	try {

		String sql = "INSERT INTO Member " +
				"(Id , Password, F_Name, L_Name, Email, Phone, EXP) " + 
				"VALUES ('" + id + "','" + pass + "' " +
				",'" + fname + "','" + lname + "'" +
				",'" + email + "','" + phone + "','0') ";
		out.println("sql = "+sql);
		int num = dbm.executeUpdate(sql);
		
		out.println("num = "+num);
		

	}catch(Exception e){out.print(e);}
	dbm.closeConnection();
%>