<%@include file="./../../common/head.jsp"%>
    <%
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting worker info
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT id, name, email, department_id FROM worker");
    %>
    <body class="container-fluid">
        <%@include file="./nav.jsp"%>
        <section class="container">
            <%while(worker.next()){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+worker.getInt("department_id"));
            %>
            <div class="card">
                <div class="card-body">
                    <label for="name">Name: </label>
                    <input type="text" 
                           class="form-control" 
                           id="name"
                           value="<%=worker.getString("name")%>"
                           readonly/>
                    <label for="email">Email: </label>
                    <input type="text"
                           class="form-control"
                           id="email"
                           value="<%=worker.getString("email")%>"
                           readonly/>
                    <label for="department">Department: </label>
                    <input type="text"
                           class="form-control"
                           id="department"
                           value="<%=dept.next()?dept.getString("department_name"):""%>"
                           readonly/>
                </div>
                <div class="card-footer">
                    <a class="btn btn-success" href="./workerDetails.jsp?worker=<%=worker.getInt("id")%>">get more details</a>
                </div>
            </div>
            <%}%>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
