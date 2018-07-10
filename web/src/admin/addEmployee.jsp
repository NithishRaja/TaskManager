<%@page import="java.sql.*"%>
<%@page import="java.util.*,javax.mail.*"%>
<%@page import="javax.mail.internet.*" %>
<%
//    cehcking if form is submitted
    if(request.getParameter("add")!=null){
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//        insert worker
        Statement stmt = con.createStatement();
        String query = "INSERT INTO worker VALUES(null,"
                + "\""+request.getParameter("name")+"\","
                + "\""+request.getParameter("email")+"\","
                + request.getParameter("department")+","
                + "\"employee\","
                + "\"defaultpassword\")";
        stmt.executeUpdate(query);
        session.setAttribute("message", "Employee account created successfully");
//        code to send email
//        sender email and password
        final String from = "taskmanager.clri@gmail.com";
        final String pass = "taskmanager@clri";
//        defining host
        String host = "smtp.gmail.com";
//        initializing properties
        Properties props = new Properties();
//        setting properties
        props.put("mail.smtp.host", host);
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");   
        props.put("mail.smtp.ssl.enable", "true");  
        props.put("mail.user", from);
        props.put("mail.password", pass);
        props.put("mail.port", "465");        
//        authorising session object
        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator(){
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(from, pass);
            }
        });
//        Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
//        Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
//        Set To: header field of the header.
        message.addRecipient(Message.RecipientType.TO,new InternetAddress(request.getParameter("email")));
//        Set Subject: header field
        message.setSubject("Account created");
//        Now set the actual message
        message.setText("A task manager account has been created for you\n"
                + "Name: "+request.getParameter("name")+"\n"
                + "Email: "+request.getParameter("email")+"\n"
                + "Password: defaultpassword\n\n"
                + "Login to change your password");
//        Send message
        Transport.send(message);            
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
            session.removeAttribute("message");
            session.setAttribute("error", "failed to create account");
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./worker.jsp");
%>