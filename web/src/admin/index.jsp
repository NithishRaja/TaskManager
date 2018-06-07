<%-- 
    Document   : index
    Created on : 7 Jun, 2018, 7:10:05 PM
    Author     : Nithish Raja.G
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"
              href="./../../static/css/bootstrap.css"/>
        <title>TASK MANAGER</title>
    </head>
    <%
//        connecting to database
try {
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
                Statement stmt=con.createStatement();  
                Statement stm=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
//                checking for form submission
                if(request.getParameter("submit")!=null){
                    System.out.println("form submit success");
//                    update tasklist (assign worker to task)
                    PreparedStatement ps=con.prepareStatement("UPDATE tasklist SET status=\"assigned\", worker_assigned="+request.getParameter("worker")+" WHERE id="+request.getParameter("task"));
                    int i=ps.executeUpdate();
                    if(i>0){
                        System.out.println("update success");
                    }else{
                        System.out.println("update failed");
                    }
                }
//                getting unassigned tasks    
                ResultSet rs=stmt.executeQuery("SELECT * FROM tasklist WHERE status=\"unassigned\"");
                ResultSet result=stm.executeQuery("SELECT name, id, isAdmin FROM employee");
    %>
    <body class="container">
        <section>
            <ul class="list-group">
            <%while(rs.next()){%>
            <%if(rs.getString("status").equals("unassigned")){%>
                <li class="list-group-item">
                    <!-- TODO: make description collapse and expand -->
                    <!--<a class="btn btn-info"
                       data-toggle="collapse" 
                       href="#description<%=rs.getInt("id")%>"
                       role="button"
                       aria-expanded="false" 
                       aria-controls="description<%=rs.getInt("id")%>">
                    expand
                    </a>-->
                    <div id="description<%=rs.getInt("id")%>" class="card">
                        <div class="card-header">
                            <span class="col-md-auto">Department: <%= rs.getString("department") %></span>
                            <span class="offset-md-3 col-md-auto">Status: <%= rs.getString("status") %></span>
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                            <%= rs.getString("description")%>
                            </p>
                        </div>
                        <div class="card-footer">
                            <!-- form to specify worker -->
                            <form method="POST" action="index.jsp">
                            <!-- tag to keep track of task -->
                            <input type="hidden" name="task" value="<%= rs.getInt("id")%>" />
                            <div class="form-group">
                                <label for="worker">Worker: </label>
                                <select id="worker" class="form-control" name="worker">
                                <%while(result.next()){%>
                                <%if(result.getString("isAdmin").equals("false")){%>
                                <option value="<%= result.getInt("id") %>"><%= result.getString("name") %></option>
                                <%}
                                }   
                                result.beforeFirst();
                                %>
                                </select>
                            </div>
                            <input class="btn btn-primary" type="submit" name="submit" value="Assign Worker" />
                            </form>
                        </div>
                    </div>
                </li>
            <%}%>
            <%}%>
            </ul>
        </section>
    </body>
    <%
//        closing connection
        con.close();  
            }catch(SQLException e) {
                out.println("SQLException caught: " +e.getMessage());
            }
    %>
</html>
