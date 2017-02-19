<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%@ page import="weka.classifiers.Evaluation"%>
<%@ page import="weka.classifiers.trees.J48"%>
<%@ page import="weka.core.Instance"%>
<%@ page import="weka.core.Instances"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />

<%
	String dt1 = request.getParameter("dt1");
	double temp1 = Double.parseDouble(request.getParameter("temp1"));
	double humid1 = Double.parseDouble(request.getParameter("humid1"));
	String dt2 = request.getParameter("dt2");
	double temp2 = Double.parseDouble(request.getParameter("temp2"));
	double humid2 = Double.parseDouble(request.getParameter("humid2"));
	String dt3 = request.getParameter("dt3");
	double temp3 = Double.parseDouble(request.getParameter("temp3"));
	double humid3 = Double.parseDouble(request.getParameter("humid3"));
	String dt4 = request.getParameter("dt4");
	double temp4 = Double.parseDouble(request.getParameter("temp4"));
	double humid4 = Double.parseDouble(request.getParameter("humid4"));
	String dt5 = request.getParameter("dt5");
	double temp5 = Double.parseDouble(request.getParameter("temp5"));
	double humid5 = Double.parseDouble(request.getParameter("humid5"));
%>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="aparcaslogo.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Aparcas Project</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="bower_components/jquery/dist/jquery.js"></script>
    <script src="bower_components/jquery-ui/jquery-ui.js"></script>

    <!-- Bootstrap core CSS     -->
    <link href="bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet" />
    <!-- Animation library for notifications   -->
    <link href="bower_components/bootstrap/dist/css/animate.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="bower_components/jquery/src/css/jquery-ui.css">


    <link rel="stylesheet" href="bower_components/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css"
    />

    <link href="https://fonts.googleapis.com/css?family=Mitr" rel="stylesheet">




    <link href="assets/css/style.css" rel="stylesheet" />



    <style type="text/css">



      html, body {
        margin-left:auto;
        margin-right:auto;
        font-family: 'Mitr', sans-serif;
        margin: auto;
        padding: 0 0 0 0;
      }

table{
    border: 1px solid black;
}
th{
    padding: 0px 0px 0px 50px;
}
.modal-body {
    position: relative;
    overflow-y: auto;
    max-height: 400px;
    padding: 15px;
}

  #legend {
    background: #FFF;
    padding: 10px;
    margin: 5px;
    font-size: 12px;
    font-family: Arial, sans-serif;
  }

  .color {
    border: 1px solid;
    height: 12px;
    width: 12px;
    margin-right: 3px;
    float: left;
  }

  .blue {
    background: #4d4dff;
  }

  .green {
    background: #4dff88;
  }

  .yellow {
    background: #ffff4d;
  }

  .orange {
    background: #ff944d;
  }

  .red {
    background: #ff4d4d;
  }

  #full-width {
       padding: 0 0 0 0;
   }
</style>


</head>

<body>


<div class="container-fluid">
    <div class="row">
	    <div id="day1" class="col-md-2">
		<%
			out.println(dt1);
			out.println(temp1);
			out.println(humid1);
		%>
		</div>
	    <div id="day2" class="col-md-2">
		<%
			out.println(dt2);
			out.println(temp2);
			out.println(humid2);
		%>
	</div>
	    <div id="day3" class="col-md-2">
		<%
			out.println(dt3);
			out.println(temp3);
			out.println(humid3);
		%>
		</div>
	    <div id="day4" class="col-md-2">
		<%
			out.println(dt4);
			out.println(temp4);
			out.println(humid4);
		%>
		</div>
	    <div id="day5" class="col-md-2">
		<%
			out.println(dt5);
			out.println(temp5);
			out.println(humid5);
		%>
		</div>
		</div>
    </div>


</body>

<script src="bower_components/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>





<script src="bower_components/bootstrap/dist/js/bootstrap-notify.js"></script>




</html>
