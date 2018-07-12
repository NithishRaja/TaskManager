<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@page import="commons.*"%>
<%    
    Commons values = new Commons();
//    declaring variables
    File file ;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String filePath = values.getCloudAddress();
    String id = null;
    String fileName = null;
//    getting content type
    String contentType = request.getContentType();
//    checking if submitted form is multipart/form-data
    if ((contentType.indexOf("multipart/form-data") >= 0)){
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(maxMemSize);
        factory.setRepository(new File("c:/temp"));
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(maxFileSize);
        try{
            List fileItems = upload.parseRequest(request);
//            initiating iterator for getting form field values
            Iterator formFieldIterator = fileItems.iterator();
//            initiating iterator for reading file
            Iterator fileIterator = fileItems.iterator();
//            iterating throught formfields
            while(formFieldIterator.hasNext()){
                FileItem fi = (FileItem)formFieldIterator.next();
                if(fi.isFormField()&&fi.getFieldName().equals("id")){
                    id = fi.getString();
                }
            }
//            updating path string
            filePath = filePath+"task_"+id+"/";
//            iterating through files
            while(fileIterator.hasNext()){
                FileItem fi = (FileItem)fileIterator.next();
                if(!fi.isFormField()){
                    String fieldName = fi.getFieldName();
                    fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
//                    checking if directory exists
                    File f = new File(filePath);
                    if(!f.exists()){
//                        creating directory if it doesn't exist
                        f.mkdirs();
                    }
//                    writing file
                    file = new File(filePath+fileName);
                    fi.write(file);
                }
            }
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//            inserting file info
            Statement stmt = con.createStatement();
            String query = "INSERT INTO files VALUES(null, "
                    +id+", "
                    +"\""+filePath+"\", "
                    +"\""+fileName+"\""+")";
            System.out.println(query);
            stmt.executeUpdate(query);
//            closing connection
            con.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>