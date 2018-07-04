<%@include file="./../common/head.jsp"%>
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
//                getting all tasks details from database
                Statement stmt=con.createStatement();  
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist, department, worker WHERE department.id=tasklist.department_id AND worker.id=tasklist.worker_id ORDER BY tasklist.id DESC");
//                getting open tasks
                Statement stmts = con.createStatement();
                ResultSet openTask = stmts.executeQuery("SELECT * FROM tasklist, department WHERE department.id=tasklist.department_id AND tasklist.status=\"open\" ORDER BY tasklist.id DESC");
//                getting workers from database
                Statement st=con.createStatement();
                ResultSet worker=st.executeQuery("SELECT id, name FROM worker WHERE status=\"employee\"");
        %>
    <body>
        <%@include file="./../common/navbar.jsp" %>
        <!-- display all tasks categorized according to their status -->
        <section class="card">
            <!-- nav for toggling task status -->
        <div class="card-header nav-header-background">
            <nav>
                <div class="nav nav-tabs card-header-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-closed-tab" data-toggle="tab" href="#nav-closed" role="tab" aria-controls="nav-contact" aria-selected="false">Closed</a>
                    <a class="nav-item nav-link" id="nav-open-tab" data-toggle="tab" href="#nav-open" role="tab" aria-controls="nav-home" aria-selected="true">Open</a>
                    <a class="nav-item nav-link" id="nav-asssigned-tab" data-toggle="tab" href="#nav-assigned" role="tab" aria-controls="nav-profile" aria-selected="false">Assigned</a>
                    <a class="nav-item nav-link" id="nav-inprogress-tab" data-toggle="tab" href="#nav-inprogress" role="tab" aria-controls="nav-contact" aria-selected="false">In Progress</a>
                </div>
            </nav>
        </div>
        <div class="card-body card-main-body">
            <!-- displaying tasks according to status selected -->
            <div class="tab-content" id="nav-tabContent">
            <!-- Display tasks that have status as open -->
            <div class="tab-pane fade" id="nav-open" role="tabpanel">
            <div class="accordion" id="openTask">
            <%while(openTask.next()){
                if(openTask.getString("tasklist.status").equals("open")){
            %>
            <div class="card">
                <hgroup class="card-header center-text">
                    <h5><%= openTask.getString("department_name") %></h5>
                    <h6><%= openTask.getString("date") %></h6>
                    <button class="btn btn-outline-info collapsed" data-toggle="collapse" data-target="#openTask<%=openTask.getInt("tasklist.id")%>">Toggle</button>
                </hgroup>
                <div id="openTask<%=openTask.getInt("tasklist.id")%>" class="collapse" data-parent="#openTask">
                <div class="card-body">
                <label for="open-description">Description: </label>
                <textarea class="form-control"
                          id="open-description"
                          readonly><%= openTask.getString("description") %>
                </textarea>
                <label for="open-remarks">Remarks: </label>
                <textarea class="form-control"
                          id="open-remarks"
                          readonly><%= openTask.getString("remarks") %>
                </textarea>
                </div>
                <div class="card-footer">
                <form method="POST" action="./assignWorker.jsp">
                    <input type="hidden" name="task" value="<%=openTask.getInt("id")%>"/>
                    <div class="form-group">
                        <label for="worker">Assign Employee: </label>
                        <select class="form-control"
                                required
                                name="worker" 
                                id="worker">
                            <%while(worker.next()){%>
                            <option value="<%=worker.getInt("id")%>"><%=worker.getString("name")%></option>
                            <%}
                                worker.beforeFirst();
                            %>
                        </select>
                    </div>
                    <input class="btn btn-outline-success" type="submit" name="submit" value="Asssign Worker" />
                </form>                    
                </div>
                </div>
            </div>
            <%}}
                openTask.beforeFirst();
            %>
            </div>
            </div>
            <!-- Display tasks that have status as assigned -->
            <div class="tab-pane fade" id="nav-assigned" role="tabpanel">    
            <div class="accordion" id="assignedTask">
            <%while(task.next()){
                    if(task.getString("tasklist.status").equals("assigned")){
                %>
                <div class="card">
                <hgroup class="card-header center-text">
                    <h5><%= task.getString("department_name") %></h5>
                    <h6><%= task.getString("date") %></h6>
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
                <div class="card-footer center-text">
                    <label>Employee Assigned: <%= task.getString("worker.name") %></label>
                </div>
                </div>
                </div>
                <%}}
                    task.beforeFirst();
                %>
                </div>
                </div>
            <!-- Display tasks that have status as inprogress -->
                <div class="tab-pane fade" id="nav-inprogress" role="tabpanel">
                <div class="accordion" id="inprogressTask">
                <%while(task.next()){
                    if(task.getString("tasklist.status").equals("inprogress")){
                %>
                <div class="card">
                    <hgroup class="card-header center-text">
                        <h5><%= task.getString("department_name") %></h5>
                        <h6><%= task.getString("date") %></h6>
                        <button class="btn btn-outline-info collapsed" data-toggle="collapse" data-target="#inprogressTask<%=task.getInt("tasklist.id")%>">Toggle</button>
                    </hgroup>
                    <div id="inprogressTask<%=task.getInt("tasklist.id")%>" class="collapse" data-parent="#inprogressTask">
                    <div class="card-body">
                        <label>Description: </label>
                        <textarea class="form-control"
                                  id="inprogress-description"
                                  readonly><%= task.getString("description") %>
                        </textarea>
                        <label>Remarks: </label>
                        <textarea class="form-control"
                                  id="inprogress-remarks"
                                  readonly><%= task.getString("remarks") %>
                        </textarea>
                    </div>
                    <div class="card-footer center-text">
                        <label>Employee Assigned: <%= task.getString("worker.name") %></label>
                    </div>
                    </div>
                </div>
                <%}}
                    task.beforeFirst();
                %>
                </div>
                </div>
            <!-- Display tasks that have status as closed -->
                <div class="tab-pane fade show active" id="nav-closed" role="tabpanel">
                <div class="accordion" id="closedTask">
                <%while(task.next()){
                    if(task.getString("tasklist.status").equals("closed")){
                %>
                <div class="card">
                    <hgroup class="card-header center-text">
                        <h5><%= task.getString("department_name") %></h5>
                        <h6><%= task.getString("date") %></h6>
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
                    <div class="card-footer center-text">
                        <label>Employee Assigned: <%= task.getString("worker.name") %></label>
                    </div>
                    </div>
                </div>
                <%}}
                %>
                </div>
                </div>
            </div>
        </div>
        <footer class="card-footer"><%@include file="./nav.jsp"%></footer>
        </section>
    </body>
<%@include file="./../common/foot.jsp"%>
