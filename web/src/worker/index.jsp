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
//                checking if start task form is submitted
                if(request.getParameter("start_task")!=null){
//                    updating task status to inprogress
                    Statement st = con.createStatement();
                    String query="UPDATE tasklist SET status=\"inprogress\" WHERE id="
                            +request.getParameter("id");
                    PreparedStatement ps=con.prepareStatement(query);
                    int i = ps.executeUpdate();
                    if(i > 0){
                        System.out.print("Record Updated Successfully");
                    }else{
                        System.out.print("There is a problem in updating Record.");
                    } 
                }
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
            <label>Description: </label><%= task.getString("description") %>
            <label>Remarks: </label><%= task.getString("remarks") %>
            <label>Department: </label><%= dept.next()?dept.getString("department_name"):"" %>
            <label>Date: </label><%= task.getString("date") %>
            <form method="POST" action="./index.js">
                <input type="hidden" name="id" value="<%=task.getInt("id")%>"/>
                <input type="submit" name="start_task" value="Start task"/>
            </form>
        </li>
        <%}}%>
        </ul>
    </body>
<%@include file="./../../common/foot.jsp"%>
