<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
//String grid = request.getParameter("grid");

String[] grids = request.getParameterValues("grids");



for(int i = 0; i <grids.length; i++){
out.println("result: " + grids[i] + "\n");
}

%>
