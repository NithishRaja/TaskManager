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
    %>
    <body>
        <%@include file="./../common/navbar.jsp" %>
        <section class="container">
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
        </section>
        <footer>
            <%@include file="./nav.jsp"%>
        </footer>
    </body>
<%@include file="./../common/foot.jsp"%>
