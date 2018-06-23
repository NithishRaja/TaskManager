<%@include file="./../common/head.jsp"%>
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
        <%@include file="./../common/navbar.jsp" %>
        <section class="container">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-assigned-tab" data-toggle="tab" href="#nav-assigned" role="tab" aria-controls="nav-home" aria-selected="true">Assigned</a>
                    <a class="nav-item nav-link" id="nav-inprogress-tab" data-toggle="tab" href="#nav-inprogress" role="tab" aria-controls="nav-profile" aria-selected="false">In Progress</a>
                </div>
            </nav>
        <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade show active" id="nav-assigned" role="tabpanel">
        <%while(task.next()){
            if(task.getString("status").equals("assigned")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <div class="card" style="margin-top: 2%;">
            <!-- Displaying task details -->
            <div class="card-header">
                <label class="col-md-3">Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label class="offset-3 col-md-3">Date: </label><%= task.getString("date") %>
            </div>
            <div class="card-body">
            <label for="assigned-description">Description: </label>
            <textarea class="form-control" 
                      id="assigned-description" 
                      readonly><%= task.getString("description") %></textarea>
            <label for="assigned-remarks">Remarks: </label>
            <textarea class="form-control"
                      id="assigned-remarks"
                      readonly><%= task.getString("remarks") %></textarea>                    
            </div>
            <!-- Form to change task status from assigned to inprogress -->
            <div class="card-footer">
            <form method="POST" action="./startTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-outline-success" type="submit" name="start_task" value="Start task"/>
            </form>                
            </div>
        </div>
        <%}}
        task.beforeFirst();
        %>
        </div>
        <div class="tab-pane fade" id="nav-inprogress" role="tabpanel">
        <%while(task.next()){
            if(task.getString("status").equals("inprogress")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <div class="card" style="margin-top: 2%;">
            <!-- Displaying task details -->
            <div class="card-header">
                <label class="col-md-3">Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label class="offset-3 col-md-3">Date: </label><%= task.getString("date") %>
            </div>
            <div class="card-body">
            <label for="inprogress-description">Description: </label>
            <textarea class="form-control"
                      id="inprogress-description"
                      readonly><%= task.getString("description") %></textarea>
            <label for="inprogress-remarks">Remarks: </label>
            <textarea class="form-control"
                      id="inprogress-remarks"
                      readonly><%= task.getString("remarks") %></textarea>
            </div>
            <!-- TODO: add form to upload files regarding the task -->
            <!-- Form to change task status from inprogress to closed -->
            <div class="card-footer">
            <form method="POST" action="./closeTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-outline-success" type="submit" name="close_task" value="Close task"/>
            </form>
            </div>
        </div>
        <%}}%>
        </div>
        </div>
        </section>
    </body>
<%@include file="./../common/foot.jsp"%>
