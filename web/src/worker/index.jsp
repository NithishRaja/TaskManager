<%@include file="./../common/head.jsp"%>
        <%
//            redirect to login page if not logged in
            if(session.getAttribute("name")==null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "./../../index.jsp");
            }
            try{
                Commons values = new Commons();
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//                get current worker tasks from database
                Statement stmt = con.createStatement();
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist, department WHERE tasklist.worker_id="+session.getAttribute("id")+" AND department.id=tasklist.department_id ORDER BY tasklist.id DESC");                 
%>
    <body class="body">
        <%@include file="./../common/navbar.jsp" %>
        <section class="card main-card">
        <div class="card-header card-header-background">
            <nav>
                <div class="nav nav-tabs card-header-tabs nav-tabs-center" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-inprogress-tab" data-toggle="tab" href="#nav-inprogress" role="tab" aria-controls="nav-profile" aria-selected="false">In Progress</a>
                    <a class="nav-item nav-link" id="nav-assigned-tab" data-toggle="tab" href="#nav-assigned" role="tab" aria-controls="nav-home" aria-selected="true">Assigned</a>
                    <a class="nav-item nav-link" id="nav-closed-tab" data-toggle="tab" href="#nav-closed" role="tab" aria-controls="nav-home" aria-selected="true">Closed</a>
                </div>
            </nav>
        </div>
        <div class="card-body card-main-body">
        <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade" id="nav-assigned" role="tabpanel">
        <div class="accordion" id="assignedTask">
        <%while(task.next()){
            if(task.getString("tasklist.status").equals("assigned")){
        %>
        <div class="card">
            <!-- Displaying task details -->
            <hgroup class="card-header card-toggle-header">
                <div class="card-toggle-hgroup">
                    <h5><%= task.getString("department_name") %> - <%= task.getString("date") %></h5>
                </div>
                <button class="btn btn-outline-info collapsed" data-toggle="collapse" data-target="#assignedTask<%=task.getInt("tasklist.id")%>">Toggle</button>
            </hgroup>
            <div id="assignedTask<%=task.getInt("tasklist.id")%>" class="collapse" data-parent="#assignedTask">
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
        </div>
        <%}}
        task.beforeFirst();
        %>
        </div>
        </div>
        <div class="tab-pane fade show active" id="nav-inprogress" role="tabpanel">
        <div class="accordion" id="inprogressTask">
        <%while(task.next()){
            if(task.getString("tasklist.status").equals("inprogress")){
        %>
        <div class="card">
            <!-- Displaying inprogress task details -->
            <hgroup class="card-header card-toggle-header">
                <div class="card-toggle-hgroup">
                    <h5><%= task.getString("department_name") %> - <%= task.getString("date") %></h5>
                </div>
                <button class="btn btn-outline-info collapsed" data-toggle="collapse" data-target="#inprogressTask<%=task.getInt("tasklist.id")%>">Toggle</button>
            </hgroup>
            <div id="inprogressTask<%=task.getInt("tasklist.id")%>" class="collapse" data-parent="#inprogressTask">
            <div class="card-body">
            <label for="inprogress-description">Description: </label>
            <textarea class="form-control"
                      id="inprogress-description"
                      readonly><%= task.getString("description") %></textarea>
            <label for="inprogress-remarks">Remarks: </label>
            <textarea class="form-control"
                      form="form<%=task.getInt("id")%>"
                      name="remarks"
                      id="inprogress-remarks"><%=task.getString("remarks")%></textarea>
            <!-- Form to upload file related to task -->
            <label for="upload-file-form">File: </label>
            <ul class="list-inline">
            <%
                Statement st = con.createStatement();
                ResultSet file = st.executeQuery("SELECT * FROM files WHERE task_id="+task.getInt("id"));
                while(file.next()){
            %>
                <li class="list-inline-item"><%=file.getString("filename")%></li>
            <%}%>
            </ul>
            <form id="upload-file-form" method="POST" action="./uploadFile.jsp" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input type="file" name="file" size="50" />
                <input type="submit" name="upload_file" value="Upload File" class="btn btn-outline-info" />
            </form>
            </div>
            <!-- Form to change task status from inprogress to closed -->
            <div class="card-footer">
            <form id="form<%=task.getInt("id")%>" method="POST" action="./closeTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-outline-success" type="submit" name="close_task" value="Close task"/>
            </form>
            </div>
            </div>
        </div>
        <%}}
        task.beforeFirst();
        %>
        </div>
        </div>
        <div class="tab-pane fade" id="nav-closed" role="tabpanel">
        <div class="accordion" id="closedTask">
            <%while(task.next()){
                if(task.getString("tasklist.status").equals("closed")){
            %>
            <div class="card">
                <hgroup class="card-header card-toggle-header">
                    <div class="card-toggle-hgroup">
                        <h5><%= task.getString("department_name") %> - <%= task.getString("date") %></h5>
                    </div>
                    <button class="btn btn-outline-info collapsed" data-toggle="collapse" data-target="#closedTask<%=task.getInt("tasklist.id")%>">Toggle</button>
                </hgroup>
                <div id="closedTask<%=task.getInt("tasklist.id")%>" class="collapse" data-parent="#closedTask">
                <div class="card-body">
                    <label for="closed-description">Description: </label>
                        <textarea class="form-control"
                              id="closed-description"
                              readonly><%= task.getString("description") %>
                    </textarea>
                    <label for="closed-remarks">Remarks: </label>
                    <textarea class="form-control"
                              id="closed-remarks"
                              readonly><%= task.getString("remarks") %>
                    </textarea>
                    <label for="uploaded-files">Files: </label>
                    <ul id="uploaded-files" class="list-inline">
                    <%
                        Statement ss = con.createStatement();
                        ResultSet file = ss.executeQuery("SELECT filename, id FROM files WHERE task_id="+task.getInt("id"));
                        while(file.next()){
                    %>
                        <li class="list-inline-item">
                            <a href="./downloadFile.jsp?file=<%=file.getInt("id")%>" class="btn btn-outline-info"><%=file.getString("filename")%></a>
                        </li>
                    <%}%>
                    </ul>
                </div>
                </div>
            </div>
            <%}}
            %>
            </div>
        </div>
        
        
        </div>
        </div>
        </section>
    </body>
<%@include file="./../common/foot.jsp"%>
