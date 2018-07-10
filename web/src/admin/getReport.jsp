<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.*"%>
<%@page import="commons.*"%>
<%
//    checking if form is submitted
    if(request.getParameter("get_report")!=null){
        try{
            Commons values = new Commons();
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//            getting task details 
            Statement stmt1 = con.createStatement();
            ResultSet task = stmt1.executeQuery("SELECT * FROM tasklist, department, worker WHERE department.id=tasklist.department_id AND worker.id=tasklist.worker_id ORDER BY tasklist.status DESC");
//            getting open task details
            Statement stmt2 = con.createStatement();
            ResultSet openTask = stmt2.executeQuery("SELECT * FROM tasklist, department WHERE department.id=tasklist.department_id AND tasklist.status=\"open\" ORDER BY tasklist.status DESC");
//            setting file name
            String filename="F:/Nithish/spreadsheet/report.xls";
//            creating new sheet
            HSSFWorkbook hwb=new HSSFWorkbook();
            HSSFSheet sheet =  hwb.createSheet("new sheet");
//            initialising row counter
            int i=0;
//            creating row for headers
            HSSFRow rowhead1=   sheet.createRow((short)i);
//            setting row headers            
            rowhead1.createCell((short) 0).setCellValue("SNo");
            rowhead1.createCell((short) 1).setCellValue("department");
            rowhead1.createCell((short) 2).setCellValue("Description");
            rowhead1.createCell((short) 3).setCellValue("Remarks");
            rowhead1.createCell((short) 4).setCellValue("Worker");
            rowhead1.createCell((short) 5).setCellValue("Date");
            rowhead1.createCell((short) 6).setCellValue("Status");
//            updating row counter
            ++i;
//            inputing task values into sheet
            while(task.next()){
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(task.getString("department_name"));
                row.createCell((short) 2).setCellValue(task.getString("description"));
                row.createCell((short) 3).setCellValue(task.getString("remarks"));
                row.createCell((short) 4).setCellValue(task.getString("worker.name"));
                row.createCell((short) 5).setCellValue(task.getString("date"));
                row.createCell((short) 6).setCellValue(task.getString("status"));
//                updating row counter
                ++i;
//                adding files
                Statement st = con.createStatement();
                ResultSet file = st.executeQuery("SELECT * FROM files WHERE task_id="+task.getInt("id"));
                int j=7;
                while(file.next()){
                    HSSFCell cell = row.createCell((short) j);
                    HSSFHyperlink link=new HSSFHyperlink(HSSFHyperlink.LINK_URL);
                    link.setAddress("http://localhost:8084/TaskManager/files.jsp?file="+file.getInt("id"));
                    cell.setCellValue(file.getString("filename"));
                    cell.setHyperlink(link);
                    ++j;
                }
            }
//            inputting open task values into sheet
            while(openTask.next()){
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(openTask.getString("department_name"));
                row.createCell((short) 2).setCellValue(openTask.getString("description"));
                row.createCell((short) 3).setCellValue(openTask.getString("remarks"));
                row.createCell((short) 4).setCellValue("");
                row.createCell((short) 5).setCellValue(openTask.getString("date"));
                row.createCell((short) 6).setCellValue(openTask.getString("status"));
//                updating row counter
                ++i;                       
//                adding files
                Statement st = con.createStatement();
                ResultSet file = st.executeQuery("SELECT * FROM files WHERE task_id="+openTask.getInt("id"));
                int j=7;
                while(file.next()){
                    HSSFCell cell = row.createCell((short) j);
                    HSSFHyperlink link=new HSSFHyperlink(HSSFHyperlink.LINK_URL);
                    link.setAddress("http://localhost:8084/TaskManager/files.jsp?file="+file.getInt("id"));
                    cell.setCellValue(file.getString("filename"));
                    cell.setHyperlink(link);
                    ++j;
                }
            }
//            seetting contentType and header
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"report.xls\"");            
//            writing file
            FileOutputStream fileOut =  new FileOutputStream(filename);
            hwb.write(fileOut);
            fileOut.close();
//            initializing PrintWriter
            PrintWriter output = response.getWriter();
//            initializing output stream
            FileInputStream fileInputStream = new FileInputStream(filename);
//            writing file
            int j;
            while ((j = fileInputStream.read()) != -1) {
		output.write(j);
            }
//            closing FileInputStream
            fileInputStream.close();
//            closing PrintWriter
            output.close();         
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