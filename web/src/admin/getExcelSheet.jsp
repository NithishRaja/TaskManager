<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="commons.*"%>
<%
//    check if get_excel_sheet form is submitted
    if(request.getParameter("get_excel_sheet")!=null){
        try{
            Commons values = new Commons();
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//            get task details
            Statement stmt = con.createStatement();
            ResultSet task = stmt.executeQuery("SELECT * FROM tasklist, department WHERE tasklist.worker_id="+request.getParameter("worker")+" AND department.id=tasklist.department_id");
//            get worker details
            Statement stm = con.createStatement();
            ResultSet worker = stm.executeQuery("SELECT name FROM worker WHERE id="+request.getParameter("worker"));
            worker.next();
//            setting file name
            String filename=values.getCloudAddress()+worker.getString("name")+"_tasklist.xls";
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
//                creating row for task
                HSSFRow row=   sheet.createRow((short)i);
//                entering values into cells
                row.createCell((short) 0).setCellValue(i);
                row.createCell((short) 1).setCellValue(task.getString("department_name"));
                row.createCell((short) 2).setCellValue(task.getString("description"));
                row.createCell((short) 3).setCellValue(task.getString("remarks"));
                row.createCell((short) 4).setCellValue(task.getString("status"));
                row.createCell((short) 5).setCellValue(task.getString("date"));
//                updating row counter
                ++i;
//                adding files
                Statement st = con.createStatement();
                ResultSet file = st.executeQuery("SELECT * FROM files WHERE task_id="+task.getInt("id"));
                int j=7;
                while(file.next()){
                    HSSFCell cell = row.createCell((short) j);
                    HSSFHyperlink link=new HSSFHyperlink(HSSFHyperlink.LINK_URL);
                    link.setAddress(values.getAddress()+"files.jsp?file="+file.getInt("id"));
                    cell.setCellValue(file.getString("filename"));
                    cell.setHyperlink(link);
                    ++j;
                }                
            }
//            writing file
            FileOutputStream fileOut =  new FileOutputStream(filename);
            hwb.write(fileOut);
            fileOut.close();
//            seetting contentType and header
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\""+worker.getString("name")+"_tasklist.xls\"");
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