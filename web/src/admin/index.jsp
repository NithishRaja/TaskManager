<%@include file="./../../common/head.jsp"%>
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
//                getting all tasks from database
                Statement stmt=con.createStatement();  
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist");
//                getting workers from database
                Statement st=con.createStatement();
                ResultSet worker=st.executeQuery("SELECT id, name FROM worker WHERE status=\"employee\"");
        %>
    <body class="container-fluid row">
        <%@include file="./nav.jsp"%>
        <!-- display all tasks categorised according to their status -->
        <section class="offset-1 col-8">
            <!-- nav for toggling task status -->
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-open-tab" data-toggle="tab" href="#nav-open" role="tab" aria-controls="nav-home" aria-selected="true">Open</a>
                    <a class="nav-item nav-link" id="nav-asssigned-tab" data-toggle="tab" href="#nav-assigned" role="tab" aria-controls="nav-profile" aria-selected="false">Assigned</a>
                    <a class="nav-item nav-link" id="nav-inprogress-tab" data-toggle="tab" href="#nav-inprogress" role="tab" aria-controls="nav-contact" aria-selected="false">In Progress</a>
                    <a class="nav-item nav-link" id="nav-closed-tab" data-toggle="tab" href="#nav-closed" role="tab" aria-controls="nav-contact" aria-selected="false">Closed</a>
                </div>
            </nav>
            <!-- displaying tasks according to status selected -->
            <div class="tab-content" id="nav-tabContent">
            <!-- Display tasks that have status as open -->
            <div class="tab-pane fade show active" id="nav-open" role="tabpanel">
            <%while(task.next()){
                if(task.getString("status").equals("open")){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
            %>
            <div class="card">
                <div class="card-header">
                    <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                    <label>Date: </label><%= task.getString("date") %>
                </div>
                <div class="card-body">
                <label for="open-description">Description: </label>
                <textarea class="form-control"
                          id="open-description"
                          readonly><%= task.getString("description") %>
                </textarea>
                <label for="open-remarks">Remarks: </label>
                <textarea class="form-control"
                          id="open-remarks"
                          readonly><%= task.getString("remarks") %>
                </textarea>
                </div>
                <div class="card-footer">
                <form method="POST" action="./assignWorker.jsp">
                    <input type="hidden" name="task" value="<%=task.getInt("id")%>"/>
                    <div class="form-group">
                        <label for="worker">Worker: </label>
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
                    <input class="btn btn-success" type="submit" name="submit" value="Asssign Worker" />
                </form>                    
                </div>
            </div>
            <%}}
                task.beforeFirst();
            %>
            </div>
            <!-- Display tasks that have status as assigned -->
            <div class="tab-pane fade" id="nav-assigned" role="tabpanel">    
            <%while(task.next()){
                    if(task.getString("status").equals("assigned")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
//                    getting worker name                    
                    Statement s = con.createStatement();
                    ResultSet assignedWorker = s.executeQuery("SELECT name FROM worker WHERE id="+task.getInt("worker_id"));
                %>
                <div class="card">
                <div class="card-header">
                    <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                    <label>Date: </label><%= task.getString("date") %>
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
                <div class="card-footer">
                    <label>Worker: </label><%= assignedWorker.next()?assignedWorker.getString("name"):"" %>
                </div>
                </div>
                <%}}
                    task.beforeFirst();
                %>
                </div>
            <!-- Display tasks that have status as inprogress -->
                <div class="tab-pane fade" id="nav-inprogress" role="tabpanel">
                <%while(task.next()){
                    if(task.getString("status").equals("inprogress")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
//                    getting worker name
                    Statement s = con.createStatement();
                    ResultSet assignedWorker = s.executeQuery("SELECT name FROM worker WHERE id="+task.getInt("worker_id"));
                %>
                <div class="card">
                    <div class="card-header">
                        <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                        <label>Date: </label><%= task.getString("date") %>
                    </div>    
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
                    <div class="card-footer">
                        <label>Worker: </label><%= assignedWorker.next()?assignedWorker.getString("name"):"" %>
                    </div>
                </div>
                <%}}
                    task.beforeFirst();
                %>
                </div>
            <!-- Display tasks that have status as closed -->
                <div class="tab-pane fade" id="nav-closed" role="tabpanel">
                <%while(task.next()){
                    if(task.getString("status").equals("closed")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
//                    getting worker name
                    Statement s = con.createStatement();
                    ResultSet assignedWorker = s.executeQuery("SELECT name FROM worker WHERE id="+task.getInt("worker_id"));                    
                %>
                <div class="card">
                    <div class="card-header">
                        <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                        <label>Date: </label><%= task.getString("date") %>
                    </div>
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
                    </div>
                    <div class="card-footer">
                        <label>Worker: </label><%= assignedWorker.next()?assignedWorker.getString("name"):"" %>
                    </div>
                </div>
                <%}}
                %>
                </div>
            </div>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
