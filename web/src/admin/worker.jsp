<%@include file="./../common/head.jsp"%>
    <%
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting worker info
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT id, name, email, department_id FROM worker");
//            getting task list
            Statement stm = con.createStatement();
            ResultSet task = stm.executeQuery("SELECT * FROM tasklist");
    %>
    <body class="container-fluid">
        <%@include file="./../common/navbar.jsp" %>
        <section class="container">
        <article>
        <div class="row">
            <%while(worker.next()){
            %>
            <div class="card col-3" style="margin-top: 1%;">
                <div class="card-body" style="align-self: center;">
                    <h5 class="card-title" style="text-align: center;"><%=worker.getString("name")%></h5> 
                    <a class="btn btn-outline-success" href="./workerDetails.jsp?worker=<%=worker.getInt("id")%>">get more details</a>
                </div>
            </div>
            <%}%>
        </div>
        <form method="POST" action="./getReport.jsp">
            <input type="submit" class="btn btn-outline-warning" style="margin-top: 1%;margin-bottom: 1%;" name="get_report" value="Generate Report"/>
        </form>
        </article>
        </section>
        <footer>
            <%@include file="./nav.jsp"%>
        </footer>
    </body>
<%@include file="./../common/foot.jsp"%>
