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
//                getting the departments list                
                Statement stmt = con.createStatement();
                ResultSet rs=stmt.executeQuery("SELECT * FROM department");
        %>
    <body class="container-fluid">
        <header>
            <h1>Add new task</h1>
        </header>
        <section class="container">
            <form method="POST" action="./newTask.jsp">
                <div class="form-group">
                    <label for="department">Department: </label>
                    <select class="form-control"
                            name="department"
                            id="department">
                        <%while(rs.next()){%>
                        <option value="<%= rs.getInt("id") %>">
                            <%= rs.getString("department_name") %>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description: </label>
                    <textarea class="form-control"
                              required 
                              name="description"
                              id="description"
                              placeholder="enter description here"></textarea>
                </div>
                <div class="form-group">
                    <label for="remarks">Remarks: </label>
                    <textarea class="form-control"
                              name="remarks"
                              id="remarks"
                              placeholder="enter remarks here"></textarea>
                </div>
                <div class="form-group">
                    <label for="date">Date: </label>
                    <input class="form-control"
                           required 
                           type="date" 
                           name="date"
                           id="date"/>
                </div>
                <%
                    if(session.getAttribute("message")!=null){
                %>
                    <div class="alert alert-info"><%=session.getAttribute("message")%></div>
                <%  
                    session.removeAttribute("message");
                    }else if(session.getAttribute("error")!=null){
                %>
                    <div class="alert alert-warning"><%=session.getAttribute("error")%></div>
                <%        
                    session.removeAttribute("error");
                    }
                %>
                <input class="btn btn-success" type="submit" name="submit" value="add" />
            </form>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
