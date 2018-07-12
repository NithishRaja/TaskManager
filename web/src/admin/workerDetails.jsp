<%@include file="./../common/head.jsp"%>
    <%
        if(request.getParameter("worker")==null){
//            if worker is not mentioned redirect to index page
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "./index.jsp");
        }
        try{
            Commons values = new Commons();
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//            getting current worker details
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT * FROM worker, department WHERE worker.id="+request.getParameter("worker")+" AND department.id=worker.department_id");
            worker.next();
//            getting task of current worker
            Statement st = con.createStatement();
            ResultSet task = st.executeQuery("SELECT * FROM tasklist WHERE worker_id="+worker.getInt("worker.id")+" ORDER BY id DESC");
    %>
    <body>
        <%@include file="./../common/navbar.jsp" %>
        <section class="container">
            <article class="card-body">
                <header>
                    <h1>Details: </h1>
                </header>
                <label for="name">Name: </label>
                <input type="text"
                       class="form-control"
                       id="name"
                       value="<%=worker.getString("name")%>"
                       readonly>
                <label for="email">Email: </label>
                <input type="text"
                       class="form-control"
                       if="email"
                       value="<%=worker.getString("email")%>"
                       readonly>
                <label for="department">Department: </label>
                <input type="text"
                       class="form-control"
                       id="department"
                       value="<%=worker.getString("department_name")%>"
                       readonly>
            </article>
            <article>
                <header>
                    <h1>Tasks: </h1>
                </header>
                <%while(task.next()){%>
                    <div class="card" style="margin-bottom: 2%;">
                        <div class="card-body">
                        <label for="description">Description: </label>
                        <textarea class="form-control"
                                  id="description"
                                  readonly><%=task.getString("description")%></textarea>
                        <label for="remarks">Remarks: </label>
                        <textarea class="form-control"
                                  id="remarks"
                                  readonly><%=task.getString("remarks")%></textarea>
                        <label for="status">Status: </label>
                        <textarea class="form-control"
                                  id="status"
                                  readonly><%=task.getString("status")%></textarea>
                        <label for="date">Date: </label>
                        <input type="date"
                               class="form-control"
                               id="date"
                               value="<%=task.getString("date")%>"
                               readonly/>
                    </div>
                </div>
                <%}%>
            </article>
            <article>
                <form method="POST" action="./getExcelSheet.jsp">
                    <input type="hidden" name="worker" value="<%=worker.getInt("id")%>"/>
                    <input type="submit"
                           name="get_excel_sheet"
                           value="Get excel sheet"
                           class="btn btn-outline-warning"/>
                </form>
            </article>
        </section>
    </body>
<%@include file="./../common/foot.jsp"%>
