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
    <body>
        <header>
            <h1>Add new task</h1>
        </header>
        <section>
            <form method="POST" action="./newTask.jsp">
                <div>
                    <label for="department">Department: </label>
                    <select name="department"
                            id="department">
                        <%while(rs.next()){%>
                        <option value="<%= rs.getInt("id") %>">
                            <%= rs.getString("department_name") %>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div>
                    <label for="description">Description: </label>
                    <textarea required 
                              name="description"
                              id="description"
                              placeholder="enter description here"
                              value="">
                    </textarea>
                </div>
                <div>
                    <label for="remarks">Remarks: </label>
                    <textarea name="remarks"
                              id="remarks"
                              placeholder="enter remarks here" 
                              value="">
                    </textarea>
                </div>
                <div>
                    <label for="date">Date: </label>
                    <input required 
                           type="date" 
                           name="date"
                           id="date"/>
                </div>
                <input type="submit" name="submit" value="add" />
            </form>
        </section>
    </body>
<%@include file="./../../common/foot.jsp"%>
