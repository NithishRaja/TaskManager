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
            <ul>
                <li><label>Name: </label><%=worker.getString("name")%></li>
                <li><label>Email: </label><%=worker.getString("email")%></li>
                <li><label>Department: </label><%=dept.getString("department_name")%></li>                
            </ul>
            <h1>Tasks: </h1>
            <ul>
                <%while(task.next()){%>
                    <li>
                        <label>Description: </label><%=task.getString("description")%>
                        <label>Remarks: </label><%=task.getString("remarks")%>
                        <label>Status: </label><%=task.getString("status")%>
                        <label>Date: </label><%=task.getString("date")%>
                    </li>
                <%}%>
            </ul>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
