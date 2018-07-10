<%@include file="./../common/head.jsp"%>
    <%
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting worker info
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT * FROM worker, department WHERE department.id=worker.department_id");
//            getting task list
            Statement stm = con.createStatement();
            ResultSet task = stm.executeQuery("SELECT * FROM tasklist");
//            getting department list
            Statement st = con.createStatement();
            ResultSet dept  = st.executeQuery("SELECT * FROM department");
    %>
    <body class="body">
        <%@include file="./../common/navbar.jsp" %>
        <section class="card main-card">
            <!-- nav for toggling worker tabs -->
        <div class="card-header nav-header-background">
            <nav>
                <div class="nav nav-tabs card-header-tabs nav-tabs-center" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-current-worker-tab" data-toggle="tab" href="#nav-current-worker" role="tab" aria-controls="nav-contact" aria-selected="false">Current Employees</a>
                    <a class="nav-item nav-link" id="nav-add-worker-tab" data-toggle="tab" href="#nav-add-worker" role="tab" aria-controls="nav-home" aria-selected="true">Add Employee</a>
                </div>
            </nav>
        </div>
        <div class="card card-body card-main-body" style="overflow-y: scroll">
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-current-worker" role="tabpanel">
                    <div class="card-columns" style="margin-top: 2%">
                    <%while(worker.next()){
                    %>
                    <div class="card">
                        <div class="card-body" style="align-self: center;">
                            <h5 class="card-title center-text"><%=worker.getString("name")%></h5>
                            <p class="card-subtitle center-text"><%= worker.getString("department_name") %></p>
                        </div>
                        <div class="card-footer">
                            <a class="btn btn-outline-success" href="./workerDetails.jsp?worker=<%=worker.getInt("id")%>">get more details</a>
                        </div>
                    </div>
                    <%}%>
                    </div>
                    <form method="POST" action="./getReport.jsp">
                        <input type="submit" class="btn btn-outline-warning" style="margin-top: 1%;margin-bottom: 1%;" name="get_report" value="Generate Report"/>
                    </form>
                </div>
                <div class="tab-pane fade" id="nav-add-worker" role="tabpanel">
                    <form method="POST" class="card card-body" action="./addEmployee.jsp">
                        <div class="form-group">
                            <label for="name">Name: </label>
                            <input type="text" 
                                   name="name" 
                                   class="form-control" 
                                   placeholder="enter name here" 
                                   id="name" required/>
                        </div>
                        <div class="form-group">
                            <label for="email">Email: </label>
                            <input type="email"
                                   name="email"
                                   class="form-control"
                                   placeholder="enter email here"
                                   id="email" required/>
                        </div>
                        <div class="form-group">
                            <label for="department">Department: </label>
                            <select class="form-control"
                                    name="department"
                                    id="department">
                                <%while(dept.next()){%>
                                <option value="<%=dept.getInt("id")%>">
                                    <%=dept.getString("department_name")%>
                                </option>
                                <%}%>
                            </select>
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
                        <input type="submit" name="add" value="Add Employee" class="btn btn-outline-success"/>
                    </form>
                </div>
            </div>
        </div>
        </section>
        <footer>
            <%@include file="./nav.jsp"%>
        </footer>
    </body>
<%@include file="./../common/foot.jsp"%>