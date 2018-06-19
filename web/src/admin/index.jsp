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
    <body class="container-fluid">
        <%@include file="./nav.jsp"%>
        <!-- display all tasks categorised according to their status -->
        <section class="container">
            <!-- Display tasks that have status as open -->
            <h1>Open tasks: </h1>
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
            <!-- Display tasks that have status as assigned -->
            <h1>Assigned tasks: </h1>
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
            <!-- Display tasks that have status as inprogress -->
            <h1>In progress tasks: </h1>
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
            <!-- Display tasks that have status as closed -->
            <h1>Closed tasks: </h1>
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
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
