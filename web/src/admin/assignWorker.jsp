<%@page import="java.sql.*"%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%
//    cehcking if form is submitted
    if(request.getParameter("submit")!=null){
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");    
//        update task list with worker id
        String query = "UPDATE tasklist SET worker_id="
            +request.getParameter("worker")
            +", status=\"assigned\""
            +" WHERE id="+request.getParameter("task");
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
//            getting all worker email
            Statement st = con.createStatement();
            ResultSet worker = st.executeQuery("SELECT * FROM worker WHERE id="+request.getParameter("worker"));
            worker.next();
//            sending mail to worker
//            Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);
//            Set From: header field of the header.
            message.setFrom(new InternetAddress(from));
//            Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,new InternetAddress(worker.getString("email")));
//            Set Subject: header field
            message.setSubject("task assigned");
//            Now set the actual message
            message.setText("New task has been assigned to you");
//            Send message
            Transport.send(message);      
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