<%-- 
    Document   : index
    Created on : 14 Jun, 2018, 8:01:17 PM
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
//        redirect to login page if not logged in
        if(session.getAttribute("name")==null){
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "./../../index.jsp");
        }
        try{
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//                cehcking if sorm is submitted
                if(request.getParameter("submit")!=null){
//                    update task list with worker id
                    Statement s=con.createStatement();
                    String query = "UPDATE tasklist SET worker_id="
                            +request.getParameter("worker")
                            +", status=\"assigned\""
                            +" WHERE id="+request.getParameter("task");
                    PreparedStatement ps=con.prepareStatement(query);
                    int i = ps.executeUpdate();
                    if(i > 0){
                        System.out.print("Record Updated Successfully");
                    }else{
                        System.out.print("There is a problem in updating Record.");
                    } 
                }
//                getting all tasks from database
                Statement stmt=con.createStatement();  
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist");
//                getting workers from database
                Statement st=con.createStatement();
                ResultSet worker=st.executeQuery("SELECT id, name FROM worker WHERE status=\"employee\"");
        %>
    <body>
        <%@include file="./nav.jsp"%>
        <!-- display all tasks categorised according to their status -->
        <section>
            <!-- Display tasks that have status as open -->
            <h1>Open tasks: </h1>
            <ul>
            <%while(task.next()){
                if(task.getString("status").equals("open")){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
            %>
            <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <form method="POST" action="./index.jsp">
                    <input type="hidden" name="task" value="<%=task.getInt("id")%>"/>
                    <div>
                        <label for="worker">Worker: </label>
                        <select required
                                name="worker" 
                                id="worker">
                            <%while(worker.next()){%>
                            <option value="<%=worker.getInt("id")%>"><%=worker.getString("name")%></option>
                            <%}
                                worker.beforeFirst();
                            %>
                        </select>
                    </div>
                    <input type="submit" name="submit" value="Asssign Worker" />
                </form>
            </li>
            <%}}
                task.beforeFirst();
            %>
            </ul>
            <!-- Display tasks that have status as assigned -->
            <h1>Assigned tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("assigned")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
            <!-- Display tasks that have status as inprogress -->
            <h1>In progress tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("inprogress")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
            <!-- Display tasks that have status as closed -->
            <h1>Closed tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("closed")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
        </section>
    </body>
    <%
        }catch(Exception e){
            System.out.println(e);
        }
    %>
</html>
