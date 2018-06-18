<%@include file="./../../common/head.jsp"%>
        <%
//            redirect to login page if not logged in
            if(session.getAttribute("name")==null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "./../../index.jsp");
            }
            try{
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//                get current worker tasks from database
                Statement stmt = con.createStatement();
                ResultSet task = stmt.executeQuery("SELECT * FROM tasklist WHERE worker_id="+session.getAttribute("id"));                 
%>
    <body>
        <h1>Assigned Tasks</h1>
        <ul>
        <%while(task.next()){
            if(task.getString("status").equals("assigned")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <li>
            <!-- Displaying task details -->
            <label>Description: </label><%= task.getString("description") %>
            <label>Remarks: </label><%= task.getString("remarks") %>
            <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
            <label>Date: </label><%= task.getString("date") %>
            <!-- Form to change task status from assigned to inprogress -->
            <form method="POST" action="./startTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input type="submit" name="start_task" value="Start task"/>
            </form>
        </li>
        <%}}
        task.beforeFirst();
        %>
        </ul>
        <h1>In Progress Tasks</h1>
        <ul>
        <%while(task.next()){
            if(task.getString("status").equals("inprogress")){
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT * FROM department WHERE id="+task.getInt("department_id"));
        %>
        <li>
            <!-- Displaying task details -->
            <label>Description: </label><%= task.getString("description") %>
            <label>Remarks: </label><%= task.getString("remarks") %>
            <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
            <label>Date: </label><%= task.getString("date") %>
            <!-- Form to upload files regarding the task -->
            <!-- Form to change task status from inprogress to closed -->
            <form method="POST" action="./closeTask.jsp">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input type="submit" name="close_task" value="Close task"/>
            </form>
        </li>
        <%}}%>
        </ul>
    </body>
<%@include file="./../../common/foot.jsp"%>
