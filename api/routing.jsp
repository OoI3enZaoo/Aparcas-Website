<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.json.*" %>
<%@ page import="org.apache.http.HttpResponse" %>
<%@ page import="org.apache.http.client.ClientProtocolException" %>
<%@ page import="org.apache.http.client.HttpClient" %>
<%@ page import="org.apache.http.client.methods.HttpGet" %>
<%@ page import="org.apache.http.impl.client.HttpClientBuilder" %>

<%@ page import="uk.me.jstott.jcoord.LatLng" %>
<%@ page import="uk.me.jstott.jcoord.UTMRef" %>

<%@ page import="java.awt.geom.Line2D" %>
<%@ page import="java.awt.geom.Point2D" %>
<%@ page import="java.awt.geom.Rectangle2D" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dbm" class="th.ac.utcc.database.DBManager" />
<%
	Vector<Integer> gridVec = new Vector<Integer>();
	Vector<Double> gxminVec = new Vector<Double>();
	Vector<Double> gxmaxVec = new Vector<Double>();
	Vector<Double> gyminVec = new Vector<Double>();
	Vector<Double> gymaxVec = new Vector<Double>();
	Vector<Integer> aqiVec = new Vector<Integer>();

	int aqi_threshold = 50;

	String routeStr = request.getParameter("route");
	JSONObject routeObj = new JSONObject(routeStr);

	
	double xmin = Double.parseDouble(((JSONObject)routeObj.get("bounds")).get("west").toString());
	double ymin = Double.parseDouble(((JSONObject)routeObj.get("bounds")).get("south").toString());
	double xmax = Double.parseDouble(((JSONObject)routeObj.get("bounds")).get("east").toString());
	double ymax = Double.parseDouble(((JSONObject)routeObj.get("bounds")).get("north").toString());
	
	//xxxxxxxxxx get all grids that intersect with route envelope xxxxxxxxxx

	try{
		String url = "https://www.googleapis.com/fusiontables/v1/query?key=AIzaSyD2Wl_1_czaWb9aBDSdMNLlOXMNI9ULibw&sql=SELECT%20id%20FROM%201x40iw0b31K2vTT6ZiSUxBWUfBbznoppAtERA7S2G%20WHERE%20ST_INTERSECTS(geometry,%20RECTANGLE(LATLNG("+ymin+","+xmin+"),LATLNG("+ymax+","+xmax+")))";	

		HttpClient client = HttpClientBuilder.create().build();
		HttpGet req = new HttpGet(url);
		HttpResponse res = client.execute(req);
		
		BufferedReader rd = new BufferedReader(new InputStreamReader(res.getEntity().getContent()));

		//StringBuffer result = new StringBuffer();
		String result = "";
		String line = "";

		while ((line = rd.readLine()) != null) {
			result += line;
		}
		
		//xxxxxxxxxxxxx to json xxxxxxxxxxxxxxxxx
		JSONObject jsonResult = new JSONObject(result);
		JSONArray rArray = (JSONArray)((JSONArray)jsonResult.get("rows"));
		for(int i=0; i<rArray.length(); i++){
			JSONArray gArray = (JSONArray)rArray.get(i);
			int gid = gArray.getInt(0);
			//out.println("getGridID Response : "+ gid);
			gridVec.addElement(gid);

			dbm.createConnection();
			try {
				String sql = "SELECT xmin,xmax,ymin,ymax,aqi FROM grid_lut where id = "+gid;
				ResultSet rs = dbm.executeQuery(sql);
				
				if(rs.next()){
					double gxmin = Double.parseDouble(rs.getString("xmin"));
					double gxmax = Double.parseDouble(rs.getString("xmax"));
					double gymin = Double.parseDouble(rs.getString("ymin"));
					double gymax = Double.parseDouble(rs.getString("ymax"));
					int aqi = Integer.parseInt(rs.getString("aqi"));
					gxminVec.addElement(gxmin);
					gxmaxVec.addElement(gxmax);
					gyminVec.addElement(gymin);
					gymaxVec.addElement(gymax);
					aqiVec.addElement(aqi);
					//out.println("gxmin = "+gxmin+","+gxmax+","+gymin+","+gymax+","+aqi);
				}
			}catch(Exception e){out.print("query grid exception: "+e);}
			dbm.closeConnection();
		}
	
	}catch(Exception e){out.println(e);}

	//out.println("gridVec = "+gridVec.size());
	
	int intsCnt = 0;

	//xxxxxxxxxxxxxxxxxxxxxxxx check intersection xxxxxxxxxxxxxxxxxxxxxxxx
	boolean passDangerGrid = false;
	Vector<Integer> dangerGridVec = new Vector<Integer>();

	JSONArray pArray = (JSONArray)routeObj.get("overview_path");
	//out.println("no of path points = "+pArray.length());
	for(int i=0; i<pArray.length(); i++){
		if(i == pArray.length() - 1){
			break;
		}

		JSONObject p1 = (JSONObject)pArray.get(i);
		double lat1 = Double.parseDouble((p1.get("lat")).toString());
		double lng1 = Double.parseDouble((p1.get("lng")).toString());
		//out.println("lat1 = "+lat1+", lng1 = "+lng1);

		JSONObject p2 = (JSONObject)pArray.get(i+1);
		double lat2 = Double.parseDouble((p2.get("lat")).toString());
		double lng2 = Double.parseDouble((p2.get("lng")).toString());
		//out.println("lat2 = "+lat2+", lng2 = "+lng2);

		//OOOOOOOOOOOOO create line segment oooooooooooo
		Line2D.Double segment = new Line2D.Double();

		LatLng x1 = new LatLng(lat1,lng1);
	    x1.toWGS84();
	    UTMRef utm_x1 = x1.toUTMRef();
	    
	    LatLng x2 = new LatLng(lat2,lng2);
	    x2.toWGS84();
	    UTMRef utm_x2 = x2.toUTMRef();

		//out.println("utm_x1 = "+utm_x1.getEasting()+" : "+utm_x1.getNorthing());
	    //out.println("utm_x2 = "+utm_x2.getEasting()+" : "+utm_x2.getNorthing());

	    segment.setLine(utm_x1.getEasting(), utm_x1.getNorthing(), utm_x2.getEasting(), utm_x2.getNorthing());
			
		//xxxxxxxxxxxxx for each segment -> loop through all grids xxxxxxxxx
		
		for(int j=0; j<gridVec.size(); j++){
			Rectangle2D.Double poly = new Rectangle2D.Double(gxminVec.elementAt(j),gyminVec.elementAt(j),(gxmaxVec.elementAt(j)-gxminVec.elementAt(j)),(gymaxVec.elementAt(j)-gxminVec.elementAt(j)));

			boolean intersect = poly.intersectsLine(segment);
			int gid = gridVec.elementAt(j);
			int aqi = aqiVec.elementAt(j);
			if (intersect && (aqi > aqi_threshold)) {
				 //out.println("intersect:"+intsCnt+", gid = "+gid+", aqi="+aqi);
				 passDangerGrid = true;
				 dangerGridVec.addElement(gid);
				 intsCnt++;
			}
		}//end for gridVec.size()
	}//end for pArray.length()
	
	
	Set<Integer> uniqueGidSet = new HashSet<Integer>();
	uniqueGidSet.addAll(dangerGridVec);
	out.println("{\"danger_grid\":"+uniqueGidSet.toString()+"}");
	
%>