<%@page import="java.sql.*"%>
<%@page import="java.util.*,javax.mail.*"%>
<%@page import="javax.mail.internet.*" %>
<%@page import="commons.*"%>
<%
//    checking if form is submitted
    if(request.getParameter("submit")!=null){
        try{
        Commons values = new Commons();
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//        update table if form is submitted
        Statement stm = con.createStatement();
        String query = "INSERT INTO tasklist VALUES(null,null,"
            +request.getParameter("department")+","
            +"\""+request.getParameter("description")+"\","
            +"\""+request.getParameter("remarks")+"\",\"open\","
            +"\""+request.getParameter("date")+"\")";
        stm.executeUpdate(query);
        session.setAttribute("message", "task inserted successfully");
//        code to send email
//        sender email and password
        final String from = values.getEmailName();
        final String pass = values.getEmailPassword();
//        defining host
        String host = values.getEmailHost();
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
//        getting all admin email
        Statement st = con.createStatement();
        ResultSet admin = st.executeQuery("SELECT * FROM worker WHERE status=\"admin\"");
//        getting department name
        Statement s = con.createStatement();
        ResultSet dept = s.executeQuery("SELECT * FROM department WHERE id="+request.getParameter("department"));
        dept.next();
//        sending mail to all admin
        while(admin.next()){
//            Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);
//            Set From: header field of the header.
            message.setFrom(new InternetAddress(from));
//            Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,new InternetAddress(admin.getString("email")));
//            Set Subject: header field
            message.setSubject("new task added");
//            Now set the actual message
            message.setText("New task has been added "
                    +"\n Department: "+dept.getString("department_name")
                    +"\n Description: "+request.getParameter("description")
                    +"\n Remarks: "+request.getParameter("remarks")
                    +"\n Date: "+request.getParameter("date"));
//            Send message
            Transport.send(message);
        }
//        closing connection
        con.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
            session.removeAttribute("message");
            session.setAttribute("error", "failed to insert task");
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./../../index.jsp");
%>
