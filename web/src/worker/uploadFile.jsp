<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
//    checking if start task form is submitted
    if(request.getParameter("start_task")!=null){
        try{
            System.out.println(request.getParameter("file"));
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>