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
    <body class="container-fluid row">
        <%@include file="./nav.jsp"%>
        <section class="offset-1 col-8">
        <div class="row">
            <%while(worker.next()){
            %>
            <div class="card col-md-4">
                <div class="card-body">
                    <h5 class="card-title"><%=worker.getString("name")%></h5> 
                    <a class="btn btn-success" href="./workerDetails.jsp?worker=<%=worker.getInt("id")%>">get more details</a>
                </div>
            </div>
            <%}%>
        </div>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
