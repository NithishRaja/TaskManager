<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>

<%
//    check if get_excel_sheet form is submitted
    if(request.getParameter("get_excel_sheet")!=null){
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
            Statement stmt = con.createStatement();
            ResultSet task = stmt.executeQuery("SELECT * FROM tasklist WHERE worker_id="+request.getParameter("worker"));
            Statement stm = con.createStatement();
            ResultSet worker = stm.executeQuery("SELECT name FROM worker WHERE id="+request.getParameter("worker"));
            worker.next();
//            setting file name
            String filename="F:/Nithish/spreadsheet/"+worker.getString("name")+"_tasklist.xls";
//            creating new sheet
            HSSFWorkbook hwb=new HSSFWorkbook();
            HSSFSheet sheet =  hwb.createSheet("new sheet");
//            initialising row counter
            int i=0;
//            creating first row for headers
            HSSFRow rowhead=   sheet.createRow((short)i);
//            setting row headers            
            rowhead.createCell((short) 0).setCellValue("SNo");
            rowhead.createCell((short) 1).setCellValue("department");
            rowhead.createCell((short) 2).setCellValue("Description");
            rowhead.createCell((short) 3).setCellValue("Remarks");
            rowhead.createCell((short) 4).setCellValue("Status");
            rowhead.createCell((short) 5).setCellValue("Date");
//            updating row counter
            ++i;
//            inputing values into sheet
            while(task.next()){
                System.out.println("counter: "+i);
//                getting department name
                Statement s = con.createStatement();
                ResultSet dept = s.executeQuery("SELECT department_name FROM department WHERE id="+task.getInt("department_id"));
                dept.next();
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(dept.getString("department_name"));
                row.createCell((short) 2).setCellValue(task.getString("description"));
                row.createCell((short) 3).setCellValue(task.getString("remarks"));
                row.createCell((short) 4).setCellValue(task.getString("status"));
                row.createCell((short) 5).setCellValue(task.getString("date"));
//                updating row counter
                ++i;
            }
//            writing file
            FileOutputStream fileOut =  new FileOutputStream(filename);
            hwb.write(fileOut);
            fileOut.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
//        redirect to workerDetails page
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "./workerDetails.jsp?worker="+request.getParameter("worker"));
    }else{
//        redirect to index page
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", "./index.jsp");        
    }
%>