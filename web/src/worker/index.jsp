<%@include file="./../../common/head.jsp"%>
        <%
//            redirect to login page if not logged in
            if(session.getAttribute("name")==null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "./../../index.jsp");
            }
            try{
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//                get current worker tasks from database
                Statement stmt = con.createStatement();
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist WHERE worker_id="+session.getAttribute("id"));                 
%>
    <body class="container-fluid">
        <section class="container">
        <h1>Assigned Tasks</h1>
        <%while(task.next()){
            if(task.getString("status").equals("assigned")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <div class="card">
            <!-- Displaying task details -->
            <div class="card-header">
                <label class="col-md-3">Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label class="offset-3 col-md-3">Date: </label><%= task.getString("date") %>
            </div>
            <div class="card-body">
            <label for="assigned-description">Description: </label>
            <textarea class="form-control" 
                      id="assigned-description" 
                      readonly>
                <%= task.getString("description") %>
            </textarea>
            <label for="assigned-remarks">Remarks: </label>
            <textarea class="form-control"
                      id="assigned-remarks"
                      readonly>
                <%= task.getString("remarks") %>
            </textarea>                    
            </div>
            <!-- Form to change task status from assigned to inprogress -->
            <div class="card-footer">
            <form method="POST" action="./startTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-success" type="submit" name="start_task" value="Start task"/>
            </form>                
            </div>
        </div>
        <%}}
        task.beforeFirst();
        %>
        <h1>In Progress Tasks</h1>
        <%while(task.next()){
            if(task.getString("status").equals("inprogress")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <div class="card">
            <!-- Displaying task details -->
            <div class="card-header">
                <label class="col-md-3">Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label class="offset-3 col-md-3">Date: </label><%= task.getString("date") %>
            </div>
            <div class="card-body">
            <label for="inprogress-description">Description: </label>
            <textarea class="form-control"
                      id="inprogress-description"
                      readonly>
                <%= task.getString("description") %>
            </textarea>
            <label for="inprogress-remarks">Remarks: </label>
            <textarea class="form-control"
                      id="inprogress-remarks"
                      readonly>
                <%= task.getString("remarks") %>
            </textarea>
            </div>
            <!-- TODO: add form to upload files regarding the task -->
            <!-- Form to change task status from inprogress to closed -->
            <div class="card-footer">
            <form method="POST" action="./closeTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-primary" type="submit" name="close_task" value="Close task"/>
            </form>
            </div>
        </div>
        <%}}%>        
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
