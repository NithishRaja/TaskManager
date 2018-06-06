<%-- 
    Document   : index
    Created on : 6 Jun, 2018, 10:37:31 AM
    Author     : Nithish Raja.G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="./static/css/bootstrap.css"/>
        <title>Login</title>
    </head>
    <%
        int flag=1;
        if(request.getParameter("submit")!=null){
            System.out.println(request.getParameter("email"));
        }else{
            flag=0;
        }
    %>
    <body class="container">
        <section>
            <form method="POST" action="index.jsp">
                <div class="form-group row">
                    <label for="email" class="col-form-label">Email: </label>
                    <div class="col-md-10">
                        <input type="email" class="form-control" id="email" name="email" placeholder="enter email here" />    
                    </div>
                </div>
                <div class="form-group row">
                    <label for="password" class="col-form-label">Password: </label>
                    <div class="col-md-10">
                        <input type="password" class="form-control" id="password" name="password" placeholder="enter password here"/>
                    </div>
                </div>
                <input type="submit" name="submit" class="btn btn-primary" value="Login"/>
            </form>
            <%
                if(flag==0){
            %>
            <div class="alert alert-warning" role="alert">iyviviui</div>    
            <%
                }
            %>
        </section>
    </body>
</html>
