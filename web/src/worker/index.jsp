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
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist, department WHERE tasklist.worker_id="+session.getAttribute("id")+" AND department.id=tasklist.department_id");                 
%>
    <body>
        <%@include file="./../common/navbar.jsp" %>
        <section class="card">
        <div class="card-header">
            <nav>
                <div class="nav nav-tabs card-header-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-inprogress-tab" data-toggle="tab" href="#nav-inprogress" role="tab" aria-controls="nav-profile" aria-selected="false">In Progress</a>
                    <a class="nav-item nav-link" id="nav-assigned-tab" data-toggle="tab" href="#nav-assigned" role="tab" aria-controls="nav-home" aria-selected="true">Assigned</a>
                </div>
            </nav>
        </div>
        <div class="card-body">
        <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade" id="nav-assigned" role="tabpanel">
        <%while(task.next()){
        %>
        <div class="card" style="margin-top: 2%;">
            <!-- Displaying task details -->
            <div class="card-header">
                <label class="col-3">Department: </label><%= task.getString("department_name") %>
                <label class="offset-3 col-3">Date: </label><%= task.getString("date") %>
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
        <%}
        task.beforeFirst();
        %>
        </div>
        <div class="tab-pane fade show active" id="nav-inprogress" role="tabpanel">
        <%while(task.next()){
        %>
        <div class="card" style="margin-top: 2%;">
            <!-- Displaying inprogress task details -->
            <div class="card-header">
                <label class="col-3">Department: </label><%= task.getString("department_name") %>
                <label class="offset-3 col-3">Date: </label><%= task.getString("date") %>
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
                <input type="submit" name="upload_file" value="Upload File" class="btn-outline-success" />
            </form>
            </div>
            <!-- Form to change task status from inprogress to closed -->
            <div class="card-footer">
            <form method="POST" action="./closeTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input class="btn btn-outline-success" type="submit" name="close_task" value="Close task"/>
            </form>
            </div>
        </div>
        <%}%>
        </div>
        </div>
        </div>
        </section>
    </body>
<%@include file="./../common/foot.jsp"%>
