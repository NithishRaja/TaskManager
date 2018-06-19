<%@include file="./../../common/head.jsp"%>
    <%
        if(request.getParameter("worker")==null){
//            if worker is not mentioned redirect to index page
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "./index.jsp");
        }
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting current worker details
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT * FROM worker WHERE id="+request.getParameter("worker"));
            worker.next();
//            getting department name of current worker
            Statement stm = con.createStatement();
            ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+worker.getInt("department_id"));
            dept.next();
//            getting task of current worker
            Statement st = con.createStatement();
            ResultSet task = st.executeQuery("SELECT * FROM tasklist WHERE worker_id="+worker.getInt("id"));
    %>
    <body>
        <section>
            <h1>Details: </h1>
            <article class="card-body">
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
                       value="<%=dept.getString("department_name")%>"
                       readonly>
            </article>
            <h1>Tasks: </h1>
                <%while(task.next()){%>
                    <div class="card">
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
                <%}%>
        </section>
        <footer class="card-footer">
            <form method="POST" action="./getExcelSheet.jsp">
                <input type="submit"
                       name="get_excel_sheet"
                       value="Get excel sheet"
                       class="btn btn-success"/>
            </form>
        </footer>
    </body>
<%@include file="./../../common/foot.jsp"%>
