<%-- 
    Document   : index
    Created on : 6 Jun, 2018, 10:37:31 AM
    Author     : Nithish Raja.G
--%>
<%@page import="java.sql.*"%>
<%@page import="commons.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="./static/css/bootstrap.min.css"/>
        <link rel="stylesheet" 
              href="./static/css/custom.css"/>
        <title>TASK MANAGER</title>
    </head>
    <%
        try{
        Commons values = new Commons();
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//        getting department details
        Statement stm = con.createStatement();
        ResultSet dept = stm.executeQuery("SELECT * FROM department");
//        flag to toggle if credentials donot match
        int flag=1;
//        removing session variables if user logged out
        if(request.getParameter("logout")!=null){
            session.removeAttribute("name");
            session.removeAttribute("email");
            session.removeAttribute("id");
        }
//        checking if login form is submitted
        if(request.getParameter("submit")!=null){
            Statement stmt=con.createStatement();  
//            getting password for email
            ResultSet worker=stmt.executeQuery("SELECT * FROM worker, department WHERE worker.email=\""+request.getParameter("email")+"\" AND worker.department_id=department.id");
//            checking password
            if(worker.next()&&request.getParameter("password").equals(worker.getString("password"))){
                session.setAttribute("name", worker.getString("name"));
                session.setAttribute("email", worker.getString("email"));
                session.setAttribute("id", worker.getInt("id"));
                session.setAttribute("department_id", worker.getString("department_id"));
                session.setAttribute("department_name", worker.getString("department_name"));
                session.setAttribute("status", worker.getString("worker.status"));
                if(worker.getString("status").equals("admin")){
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "./src/admin/");
                }else if(worker.getString("status").equals("employee")){
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "./src/worker/"); 
                }
            }else{
                flag=0;
            }           
        }
    %>
    <body style="background-color: #e1e8f0;">
        <nav class="navbar navbar-background" style="display: flex;">
            <a class="navbar-brand navbar-text-color navbar-align" style="flex:1;text-align: center;" href="https://clri.org/">
                <img src="./static/images/clriLogo.png" width="50" height="50" alt="logo" />
                <h1>CSIR-Central Leather Research Institute</h1>
             </a>
        </nav>
        <main class="container" style="margin-top: 2%;">
        <!-- Task entry section -->
        <section class="card-deck">
        <article class="card index-card">
            <div class="card-header index-card-header">
                <h3 class="card-title">Task entry</h3>
            </div>
            <div class="card-body index-card-body">
            <form method="POST" action="./src/DEO/newTask.jsp">
                <div class="form-group">
                    <label for="department">Department: </label>
                    <select class="form-control"
                            name="department"
                            id="department">
                        <%while(dept.next()){%>
                        <option value="<%= dept.getInt("id") %>">
                            <%= dept.getString("department_name") %>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description: </label>
                    <textarea class="form-control"
                              required 
                              name="description"
                              id="description"
                              placeholder="enter description here"></textarea>
                </div>
                <div class="form-group">
                    <label for="remarks">Remarks: </label>
                    <textarea class="form-control"
                              name="remarks"
                              id="remarks"
                              placeholder="enter remarks here"></textarea>
                </div>
                <div class="form-group">
                    <label for="date">Date: </label>
                    <input class="form-control"
                           required 
                           type="date" 
                           name="date"
                           id="date"/>
                </div>
                <%
                    if(session.getAttribute("message")!=null){
                %>
                    <div class="alert alert-info"><%=session.getAttribute("message")%></div>
                <%  
                    session.removeAttribute("message");
                    }else if(session.getAttribute("error")!=null){
                %>
                    <div class="alert alert-warning"><%=session.getAttribute("error")%></div>
                <%        
                    session.removeAttribute("error");
                    }
                %>
                <input class="btn btn-outline-success" type="submit" name="submit" value="add" />
            </form>
            </div>
        </article>
        <!-- Login section -->
        <article class="card index-card">
            <div class="card-header index-card-header">
                <h3 class="card-title">Login</h3>
            </div>
            <div class="card-body index-card-body">
            <form method="POST" action="./index.jsp">
                <div class="form-group">
                    <label for="email">Email: </label>
                    <input class="form-control"
                           required type="text"
                           id="email" name="email"
                           placeholder="enter email"/>
                </div>
                <div class="form-group">
                    <label for="password">Password: </label>
                    <input class="form-control"
                           required type="password"
                           id="password" name="password"
                           placeholder="enter password"/>
                </div>
                <%
                    if(flag==0){
                %>
                <div class="alert alert-warning">Incorrect email and password</div>
                <%
                    }
                %>
                <input class="btn btn-outline-success" type="submit" name="submit" value="Login"/>
            </form>
            </div>
        </article>
        </section>
        </main>
    </body>
    <%
//            closing database connection
            con.close();         
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    %>
</html>
