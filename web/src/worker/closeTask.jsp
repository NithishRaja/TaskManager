<%@page import="java.sql.*"%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%
//    checking if close task form is submitted
    if(request.getParameter("close_task")!=null){
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");                    
//        updating task status to closed
        String query="UPDATE tasklist SET remarks=\""+request.getParameter("remarks")+"\", status=\"closed\" WHERE id="
            +request.getParameter("id");
        PreparedStatement ps=con.prepareStatement(query);
        int i = ps.executeUpdate();
        if(i > 0){
            System.out.print("Record Updated Successfully");
//            code to send email
//            sender email and password
            final String from = "taskmanager.clri@gmail.com";
            final String pass = "taskmanager@clri";
//            defining host
            String host = "smtp.gmail.com";
//            initializing properties
            Properties props = new Properties();
//            setting properties
            props.put("mail.smtp.host", host);
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");   
            props.put("mail.smtp.ssl.enable", "true");  
            props.put("mail.user", from);
            props.put("mail.password", pass);
            props.put("mail.port", "465");        
//            authorising session object
            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator(){
                @Override
                protected PasswordAuthentication getPasswordAuthentication(){
                    return new PasswordAuthentication(from, pass);
                }
            });
//            getting all admin email
            Statement st = con.createStatement();
            ResultSet admin = st.executeQuery("SELECT * FROM worker WHERE status=\"admin\"");
//            getting task details and worker name
            Statement s = con.createStatement();
            ResultSet task = s.executeQuery("SELECT * FROM tasklist, worker, department WHERE department.id=tasklist.department_id AND tasklist.id="+request.getParameter("id")+" AND worker.id=tasklist.worker_id");
            task.next();
//            sending mail to all admin
            while(admin.next()){
//                Create a default MimeMessage object.
                MimeMessage message = new MimeMessage(mailSession);
//                Set From: header field of the header.
                message.setFrom(new InternetAddress(from));
//                Set To: header field of the header.
                message.addRecipient(Message.RecipientType.TO,new InternetAddress(admin.getString("email")));
//                Set Subject: header field
                message.setSubject("task closed");
//                Now set the actual message
                message.setText("A task has been closed "
                        +"\n Department: "+task.getString("department_name")
                        +"\n Description: "+task.getString("description")
                        +"\n Remarks: "+task.getString("remarks")
                        +"\n Worker: "+task.getString("worker.name")
                        +"\n Date: "+task.getString("date"));
//                Send message
                Transport.send(message);
            }            
        }else{
            System.out.print("There is a problem in updating Record.");
        }
//        closing connection
        con.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>