<%@ page import="java.util.*" %> 
<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />

<!DOCTYPE html>
<html>
<head>
  <title>Registration form</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">   
  <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
     
    <link href="bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
  	<script src="bower_components/jquery/dist/jquery.min.js"></script>
</head>
<body>


<div class="container">
      <div class="starter-template">
        <h1>Register Status</h1>        
        
    
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
		//out.println("sql = "+sql);
		int num = dbm.executeUpdate(sql);		
		//out.println("num = "+num);		
		
		if(num == 1){
			%>
			<p class="lead">Success<br> click <a href = "http://sysnet.utcc.ac.th/aparcas/dashboard.html">Here</a> to Back to Dashboard page</p>
			<%
			
		}else{
			%>
			<p class="lead">Fail<br> click <a href = "http://sysnet.utcc.ac.th/aparcas/dashboard.html">Here</a> to Back to Dashboard page</p>
			<%			
		}
		
		%>
		  </div>
		</div>
		<%
		
		
		
	

	}catch(Exception e){out.print(e);}
	dbm.closeConnection();
%>

</body>
</html>
