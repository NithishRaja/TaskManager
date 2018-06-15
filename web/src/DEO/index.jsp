<%-- 
    Document   : index
    Created on : 14 Jun, 2018, 8:00:59 PM
    Author     : Nithish Raja.G
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
//            redirect to login page if not logged in
            if(session.getAttribute("name")==null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "./../../index.jsp");
            }
            if(request.getParameter("submit")!=null){
                System.out.println(request.getParameter("description"));
                System.out.println(request.getParameter("department"));
                System.out.println(request.getParameter("remarks"));
                System.out.println(request.getParameter("date"));
            }
            try{
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
                Statement stmt = con.createStatement();
//                getting the departments list
                ResultSet rs=stmt.executeQuery("SELECT * FROM department");
        %>
    <body>
        <header>
            <h1>Add new task</h1>
        </header>
        <section>
            <form method="POST" action="./index.jsp">
                <div>
                    <label for="department">Department: </label>
                    <select name="department"
                            id="department">
                        <%while(rs.next()){%>
                        <option value="<%= rs.getInt("id") %>">
                            <%= rs.getString("department_name") %>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div>
                    <label for="description">Description: </label>
                    <textarea required 
                              name="description"
                              id="description"
                              placeholder="enter description here">
                    </textarea>
                </div>
                <div>
                    <label for="remarks">Remarks: </label>
                    <textarea name="remarks"
                              id="remarks"
                              placeholder="enter remarks here">
                    </textarea>
                </div>
                <div>
                    <label for="date">Date: </label>
                    <input required 
                           type="date" 
                           name="date"
                           id="date"/>
                </div>
                <input type="submit" name="submit" value="add" />
            </form>
        </section>
    </body>
    <%
//            closing connection
            con.close();
        }catch(Exception e){
            System.out.println(e);
        }
    %>
</html>
