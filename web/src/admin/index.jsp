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
    <body>
        <%@include file="./nav.jsp"%>
        <!-- display all tasks categorised according to their status -->
        <section>
            <!-- Display tasks that have status as open -->
            <h1>Open tasks: </h1>
            <ul>
            <%while(task.next()){
                if(task.getString("status").equals("open")){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
            %>
            <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <form method="POST" action="./assignWorker.jsp">
                    <input type="hidden" name="task" value="<%=task.getInt("id")%>"/>
                    <div>
                        <label for="worker">Worker: </label>
                        <select required
                                name="worker" 
                                id="worker">
                            <%while(worker.next()){%>
                            <option value="<%=worker.getInt("id")%>"><%=worker.getString("name")%></option>
                            <%}
                                worker.beforeFirst();
                            %>
                        </select>
                    </div>
                    <input type="submit" name="submit" value="Asssign Worker" />
                </form>
            </li>
            <%}}
                task.beforeFirst();
            %>
            </ul>
            <!-- Display tasks that have status as assigned -->
            <h1>Assigned tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("assigned")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
            <!-- Display tasks that have status as inprogress -->
            <h1>In progress tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("inprogress")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
            <!-- Display tasks that have status as closed -->
            <h1>Closed tasks: </h1>
            <ul>
                <%while(task.next()){
                    if(task.getString("status").equals("closed")){
//                    getting department name
                    Statement stm = con.createStatement();
                    ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                %>
                <li>
                <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
                <label>Description: </label><%= task.getString("description") %>
                <label>Remarks: </label><%= task.getString("remarks") %>
                <label>Date: </label><%= task.getString("date") %>
                <%}}
                %>
            </ul>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
