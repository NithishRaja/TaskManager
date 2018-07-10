<%@include file="./head.jsp"%>
<%
    if(session.getAttribute("id")==null){
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "./../../index.jsp");
    }
    try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
        if(request.getParameter("update")!=null){
//            getting worker details
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT * FROM worker WHERE id="+session.getAttribute("id"));
            worker.next();
            if(worker.getString("password").equals(request.getParameter("existingPassword"))){
//                updating database with new values
                String query = "UPDATE worker SET "
                        + "name=\""+request.getParameter("name")+"\","
                        + "email=\""+request.getParameter("email")+"\"";
                if(request.getParameter("newPassword")!=null&&!request.getParameter("newPassword").equals("")){
                    query = query+","
                            + "password=\""+request.getParameter("newPassword")+"\"";
                }
                query = query+" WHERE id="+session.getAttribute("id");
                PreparedStatement ps=con.prepareStatement(query);
                int i = ps.executeUpdate();
                if(i>0){
                    session.setAttribute("message", "Updated successfully");
                    session.removeAttribute("name");
                    session.removeAttribute("email");
                    session.setAttribute("name", request.getParameter("name"));
                    session.setAttribute("email", request.getParameter("email"));
                }else{
                    session.setAttribute("error", "Unable to update");
                }
            }else{
                session.setAttribute("error", "Existing password does not match");
            }
        }
%>
<body class="body">
    <%@include file="./navbar.jsp"%>
    <div style="padding-left: 15%;padding-right: 15%;padding-top: 2%">
    <form method="POST" action="./editAccount.jsp">
        <div class="form-group">
            <label for="name">Name: </label>
            <input type="text" 
                   name="name"
                   id="name"
                   placeholder="Enter name here"
                   value="<%=session.getAttribute("name")%>"
                   class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="email">Email: </label>
            <input type="email" 
                   name="email"
                   id="email"
                   placeholder="Enter email here"
                   value="<%=session.getAttribute("email")%>"
                   class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="existing-password">Existing Password: </label>
            <input type="password" 
                   name="existingPassword"
                   id="existing-password"
                   placeholder="Enter existing password here"
                   class="form-control" required/>
        </div>
        <div class="form-group">
            <label for="new-password">New Password: </label>
            <input type="password"
                   name="newPassword"
                   id="new-password"
                   placeholder="Enter new password here"
                   class="form-control"/>
        </div>
        <%
            if(session.getAttribute("error")!=null){
        %>
        <div class="alert alert-warning"><%=session.getAttribute("error")%></div>
        <%
            session.removeAttribute("error");
            }else if(session.getAttribute("message")!=null){
        %>
        <div class="alert alert-info"><%=session.getAttribute("message")%></div>
        <%
            session.removeAttribute("message");
            }
        %>
        <input type="submit" class="btn btn-outline-success" value="update" name="update" />
    </form>
    </div>
</body>
<%@include file="./foot.jsp"%>