<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />

<%
/**  if(session.getAttribute("ssuid") == null){
		response.sendRedirect("./");
	}

    String ssfn = (String)session.getAttribute("ssfn");
	String ssln = (String)session.getAttribute("ssln");

	if(request.getParameter("SSSN") != null){
		session.setAttribute("SSSN",request.getParameter("SSSN"));
	}
**/
    String cmbContent = "<option value='null'></option>";
	dbm.createConnection();

    try {
        String sql = "SELECT DISTINCT SNAME FROM `grid_lut` ORDER BY SNAME;";
        ResultSet rs = dbm.executeQuery(sql);

		while((rs!=null) && (rs.next())){
			//out.println(rs.getString("SNAME"));
			cmbContent = cmbContent + "<option value='" + rs.getString("SNAME").substring(4) + "'>" + rs.getString("SNAME") + "</option>";
		}
    } catch (Exception e) {
		out.println(e.getMessage());
		e.printStackTrace();
	}

	dbm.closeConnection();
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

<script type = "text/javascript">
function showPredictDetail(){
	var apiKey = "3483ac6971d195fb4d9c0a1607a9db9c";
	var dt1, dt2, dt3, dt4, dt5;
	var temp1, temp2, temp3, temp4, temp5;
	var humid1, humid2, humid3, humid4, humid5;
	if ($('#subdistrict :selected').val() != "null"){
	$.getJSON("http://api.openweathermap.org/data/2.5/forecast?q=" + $('#subdistrict :selected').val() + "&&units=metric&appid=" + apiKey, function(data) {
        dt1 = data["list"][0]["dt\_txt"].substring(0,10);
		temp1 = data["list"][0]["main"]["temp"];
		humid1 = data["list"][0]["main"]["humidity"];
        dt2 = data["list"][8]["dt\_txt"].substring(0,10);
		temp2 = data["list"][8]["main"]["temp"];
		humid2 = data["list"][8]["main"]["humidity"];
        dt3 = data["list"][16]["dt\_txt"].substring(0,10);
		temp3 = data["list"][16]["main"]["temp"];
		humid3 = data["list"][16]["main"]["humidity"];
        dt4 = data["list"][24]["dt\_txt"].substring(0,10);
		temp4 = data["list"][24]["main"]["temp"];
		humid4 = data["list"][24]["main"]["humidity"];
        dt5 = data["list"][32]["dt\_txt"].substring(0,10);
		temp5 = data["list"][32]["main"]["temp"];
		humid5 = data["list"][32]["main"]["humidity"];
		$('#predictContent').load('predictDetail.jsp', {"dt1": dt1, "temp1": temp1, "humid1": humid1, "dt2": dt2, "temp2": temp2, "humid2": humid2, "dt3": dt3, "temp3": temp3, "humid3": humid3, "dt4": dt4, "temp4": temp4, "humid4": humid4, "dt5": dt5, "temp5": temp5, "humid5": humid5});
     });
	}
}

function clearPredictDetail(){
	$('#predictContent').empty();
}
</script>


</head>

<body>


    <header>
<div class="container">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <h4><strong>Air Pollution and Radioactive Contamination Analyzing System (APARCAS)</strong> &nbsp;&nbsp;</h4>

        </div>

    </div>
</div>
</header>


<section class="menu-section">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">

               <ul id="menu-top" class="nav navbar-nav navbar-right">
                    <li><a  href="realtime.html">คุณภาพอากาศแบบเรียลไทม์</a></li>
                    <li><a  href="radioactive.html">ประวัติปริมาณกัมมันตรังสี</a></li>
                    <li><a  href="airquality.html">ประวัติคุณภาพอากาศ</a></li>
                    <li><a  href="directions.html">ค้นหาเส้นทางหลีกเลี่ยงมลพิษ</a></li>
                    <li><a  class="menu-top-active" href="predict.html">พยากรณ์คุณภาพอากาศ</a></li>
                    <li><a   href="aqi.html">ดัชนีคุณภาพอากาศ</a></li>
                </ul>
            </div>
        </div>
    </div>
</section>




<div class="container">
    <div class="row">
        <div class="col">

<br>
                    <h4 class="category text-center">ระบบพยากรณ์คุณภาพอากาศ</h4>
                    <br>
        </div>
    </div>
    <div class="row">
        <div class="col">
                    <form>
					<label>กรุณาเลือกแขวง </label>&nbsp; &nbsp;
					<select id="subdistrict" onchange="showPredictDetail()">
					<% out.println(cmbContent); %>
					</select>
                    </form>
        </div>
    </div>
    <div class="row">
        <div class="col" id="predictContent">
        </div>
    </div>
</div>

</body>

<script src="bower_components/bootstrap/dist/js/bootstrap.min.js" type="text/javascript"></script>





<script src="bower_components/bootstrap/dist/js/bootstrap-notify.js"></script>




</html>
