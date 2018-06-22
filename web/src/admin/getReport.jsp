<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>

<%
//    checking if form is submitted
    if(request.getParameter("get_report")!=null){
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting inprogress tasks 
            Statement stmt1 = con.createStatement();
            ResultSet inprogressTask = stmt1.executeQuery("SELECT * FROM tasklist WHERE status=\"inprogress\"");
//            getting closed tasks 
            Statement stmt2 = con.createStatement();
            ResultSet closedTask = stmt2.executeQuery("SELECT * FROM tasklist WHERE status=\"closed\"");            
//            setting file name
            String filename="F:/Nithish/spreadsheet/report.xls";
//            creating new sheet
            HSSFWorkbook hwb=new HSSFWorkbook();
            HSSFSheet sheet =  hwb.createSheet("new sheet");
//            initialising row counter
            int i=0;
//            creating row for in progress tasks
            HSSFRow rowtitle1=   sheet.createRow((short)i);
//            inserting task status
            rowtitle1.createCell((short) 0).setCellValue("In Progress tasks");
//            updating row counter
            ++i;
//            creating row for headers
            HSSFRow rowhead1=   sheet.createRow((short)i);
//            setting row headers            
            rowhead1.createCell((short) 0).setCellValue("SNo");
            rowhead1.createCell((short) 1).setCellValue("department");
            rowhead1.createCell((short) 2).setCellValue("Description");
            rowhead1.createCell((short) 3).setCellValue("Remarks");
            rowhead1.createCell((short) 4).setCellValue("Worker");
            rowhead1.createCell((short) 5).setCellValue("Date");
//            updating row counter
            ++i;
//            inputing values into sheet
            while(inprogressTask.next()){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+inprogressTask.getInt("department_id"));
                dept.next();
//                getting worker name
                Statement st = con.createStatement();
                ResultSet worker = st.executeQuery("SELECT name FROM worker WHERE id="+inprogressTask.getInt("worker_id"));
                worker.next();
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(dept.getString("department_name"));
                row.createCell((short) 2).setCellValue(inprogressTask.getString("description"));
                row.createCell((short) 3).setCellValue(inprogressTask.getString("remarks"));
                row.createCell((short) 4).setCellValue(worker.getString("name"));
                row.createCell((short) 5).setCellValue(inprogressTask.getString("date"));
//                updating row counter
                ++i;                
            }
//            creating row for closed tasks
            HSSFRow rowtitle2= sheet.createRow((short)i);
//            inserting task status
            rowtitle2.createCell((short) 0).setCellValue("Closed tasks");
//            updating row counter
            ++i;
//            creating row for headers
            HSSFRow rowhead2=   sheet.createRow((short)i);
//            setting row headers            
            rowhead2.createCell((short) 0).setCellValue("SNo");
            rowhead2.createCell((short) 1).setCellValue("department");
            rowhead2.createCell((short) 2).setCellValue("Description");
            rowhead2.createCell((short) 3).setCellValue("Remarks");
            rowhead2.createCell((short) 4).setCellValue("Worker");
            rowhead2.createCell((short) 5).setCellValue("Date");
//            updating row counter
            ++i;
//            inputing values into sheet
            while(closedTask.next()){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+closedTask.getInt("department_id"));
                dept.next();
//                getting worker name
                Statement st = con.createStatement();
                ResultSet worker = st.executeQuery("SELECT name FROM worker WHERE id="+closedTask.getInt("worker_id"));
                worker.next();
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(dept.getString("department_name"));
                row.createCell((short) 2).setCellValue(closedTask.getString("description"));
                row.createCell((short) 3).setCellValue(closedTask.getString("remarks"));
                row.createCell((short) 4).setCellValue(worker.getString("name"));
                row.createCell((short) 5).setCellValue(closedTask.getString("date"));
//                updating row counter
                ++i;                
            }
//            writing file
            FileOutputStream fileOut =  new FileOutputStream(filename);
            hwb.write(fileOut);
            fileOut.close();
//            closing connection
            con.close();
        }catch(Exception e){
//            e.printStackTrace();
            System.out.println("exception: ");
            System.out.println(e);
        }
//        redirect to worker page
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "./worker.jsp");        
    }else{
//        redirect to index page
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "./index.jsp");
    }
%>