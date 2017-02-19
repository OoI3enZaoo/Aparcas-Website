<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.StringReader"%>
<%@ page import="java.util.Random"%>

<%@ page import="weka.classifiers.Evaluation"%>
<%@ page import="weka.classifiers.trees.J48"%>
<%@ page import="weka.core.Instance"%>
<%@ page import="weka.core.Instances"%>

<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />

<%! 
	private Instances trainData = null;
	private J48 treeModel = null;
	private String trainDataFile= "conf//UCIAQI.arff";
	
	private void loadDataset() throws IOException{
		BufferedReader reader = new BufferedReader(new FileReader(trainDataFile));
		trainData = new Instances(reader);
		trainData.setClassIndex(trainData.numAttributes() - 1); 
	}
	
	private void trainModel() throws Exception{
		String[] options = new String[1];
		options[0] = "-U";
		treeModel = new J48();
		treeModel.setOptions(options);
		treeModel.buildClassifier(trainData);
		
		//System.out.println("Tree Model: "+treeModel);
		//return "Tree Model: " + treeModel;
	}

	private void evaluateModel() throws Exception{
		Evaluation eval = new Evaluation(trainData); 
		eval.crossValidateModel(treeModel, trainData, 10, new Random());
		String result = eval.toSummaryString()+eval.toMatrixString(); 

		// System.out.println("Evaluation result: "+result); 
		// return "Evaluation result: "+result; 
	}

	private String predictAQI(String temp, String humidity) throws Exception{
		String  inputData = "";
		inputData += "@RELATION UCIAQI \n"; 

		inputData += "@ATTRIBUTE temp	REAL \n";
		inputData += "@ATTRIBUTE humidity	REAL \n";
		inputData += "@ATTRIBUTE aqi 	{0,51,101,201,301} \n";

		inputData += "@DATA \n";
		inputData += temp;
		inputData += ","; 
		inputData += humidity;
		inputData += ",? \n";
		
		BufferedReader strReader = new BufferedReader(new StringReader(inputData));
		Instances testData = new Instances(strReader);
		
		Instance instance = testData.instance(0); 
		int classIndex = testData.numAttributes() - 1; 
		testData.setClassIndex(classIndex); 
		instance.setClassMissing(); 

		double cls = treeModel.classifyInstance(instance); 
		instance.setClassValue(cls); 
		String resId = instance.stringValue(classIndex); 
		if (Integer.valueOf(resId) == 0){
			return "l1คุณภาพดี";
		}
		else if (Integer.valueOf(resId) == 51){
			return "l2คุณภาพปานกลาง";
		}
		else if (Integer.valueOf(resId) == 101){
			return "l3มีผลกระทบต่อสุขภาพ";
		}
		else if (Integer.valueOf(resId) == 201){
			return "l4มีผลกระทบต่อสุขภาพมาก";
		}
		else {return "l5อันตราย " + resId;}
		//return "erg: " + resId + ", " + cls + " Instance: " + instance; 
	}
	
%>

<%
	String dt1 = request.getParameter("dt1");
	String temp1 = request.getParameter("temp1");	
	String humid1 = request.getParameter("humid1");
	String dt2 = request.getParameter("dt2");
	String temp2 = request.getParameter("temp2");	
	String humid2 = request.getParameter("humid2");	
	String dt3 = request.getParameter("dt3");
	String temp3 = request.getParameter("temp3");	
	String humid3 = request.getParameter("humid3");	
	String dt4 = request.getParameter("dt4");
	String temp4 = request.getParameter("temp4");	
	String humid4 = request.getParameter("humid4");	
	String dt5 = request.getParameter("dt5");
	String temp5 = request.getParameter("temp5");	
	String humid5 = request.getParameter("humid5");	
	String aqi1 = "", aqi2 = "", aqi3 = "", aqi4 = "", aqi5 = "";
	
	try {
		loadDataset();
		trainModel();
		evaluateModel();
		aqi1 = predictAQI(temp1, humid1);
		aqi2 = predictAQI(temp2, humid2);
		aqi3 = predictAQI(temp3, humid3);		
		aqi4 = predictAQI(temp4, humid4);
		aqi5 = predictAQI(temp5, humid5);
	} catch (Exception e) {
		out.println("Error Happen");
		e.printStackTrace();
	}	
	
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

  .l1 {
    background: #b3e0ff;
  }    
  
  .l2 {
    background: #c2f0c2;
  }    
  
  .l3 {
    background: #ffffb3;
  }

  .l4 {
    background: #ffd9b3;
  }    
  
  .l5 {
    background: #ffcccc;
  }    
  
  #full-width {
       padding: 0 0 0 0;
   }
</style>


</head>

<body>


<div class="container">
    <div class="row">
	    <div id="day1" class="col-md-2 panel <%=aqi1.substring(0,2)%>">
		<% 
			out.println("<label>วันที่:</label> " + dt1 + "<br/>"); 
			out.println("<label>อุณหภูมิ (เซลเซียส):</label> " + temp1 + "<br/>"); 			
			out.println("<label>ความชื้น (เปอร์เซ็นต์):</label> " + humid1  + "<br/>");
			out.println("<label>คุณภาพอากาศ:</label> <br/>" + aqi1.substring(2));
		%>
		</div>
	    <div id="day2" class="col-md-2 panel <%=aqi2.substring(0,2)%>">
		<% 
			out.println("<label>วันที่:</label> " + dt2 + "<br/>"); 
			out.println("<label>อุณหภูมิ (เซลเซียส):</label> " + temp2 + "<br/>"); 			
			out.println("<label>ความชื้น (เปอร์เซ็นต์):</label> " + humid2  + "<br/>");
			out.println("<label>คุณภาพอากาศ:</label> <br/>" + aqi2.substring(2));
		%>
		</div>		
	    <div id="day3" class="col-md-2 panel <%=aqi3.substring(0,2)%>">
		<% 
			out.println("<label>วันที่:</label> " + dt3 + "<br/>"); 
			out.println("<label>อุณหภูมิ (เซลเซียส):</label> " + temp3 + "<br/>"); 			
			out.println("<label>ความชื้น (เปอร์เซ็นต์):</label> " + humid3  + "<br/>");
			out.println("<label>คุณภาพอากาศ:</label> <br/>" + aqi3.substring(2));
		%>
		</div>
	    <div id="day4" class="col-md-2 panel <%=aqi4.substring(0,2)%>">
		<% 
			out.println("<label>วันที่:</label> " + dt4 + "<br/>"); 
			out.println("<label>อุณหภูมิ (เซลเซียส):</label> " + temp4 + "<br/>"); 			
			out.println("<label>ความชื้น (เปอร์เซ็นต์):</label> " + humid4  + "<br/>");
			out.println("<label>คุณภาพอากาศ:</label> <br/>" + aqi4.substring(2));
		%>
		</div>
	    <div id="day5" class="col-md-2 panel <%=aqi5.substring(0,2)%>">
		<% 
			out.println("<label>วันที่:</label> " + dt5 + "<br/>"); 
			out.println("<label>อุณหภูมิ (เซลเซียส):</label> " + temp5 + "<br/>"); 			
			out.println("<label>ความชื้น (เปอร์เซ็นต์):</label> " + humid5  + "<br/>");
			out.println("<label>คุณภาพอากาศ:</label> <br/>" + aqi5.substring(2));
		%>
		</div>		
	</div>
</div>
</body>

<script src="bower_components/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>





<script src="bower_components/bootstrap/dist/js/bootstrap-notify.js"></script>




</html>
