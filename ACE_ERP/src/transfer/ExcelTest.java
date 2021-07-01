package transfer;

import  javax.servlet.*;
import  javax.servlet.http.*;
import  java.io.*;

import  jxl.*;
import  jxl.write.*;


public class ExcelTest extends HttpServlet
{
    public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String filepath = "c:";
        String filename = "output.xls";
        try {
            WritableWorkbook workbook = 
                Workbook.createWorkbook(new File( filepath+ "\\" + filename )); 

            WritableSheet sheet = workbook.createSheet("First Sheet", 0); 
            Label label = new Label(0, 2, "Pungjoo"); 
            sheet.addCell(label); 

            jxl.write.Number number = new jxl.write.Number(3, 4, 3.1459); 
            sheet.addCell(number); 

            workbook.write(); 
            workbook.close();
        }
        catch ( Exception e ){
        }

        try {
            File file = new File( filepath+ "\\" + filename );
            FileInputStream fin = new FileInputStream(file);
            int ifilesize = (int)file.length();
            byte b[] = new byte[ifilesize];

            response.setContentLength(ifilesize);
            response.setContentType("application/smnet");
            response.setHeader(
                "Content-Disposition",
                "attachment; filename=" + filename+";"
            );
            ServletOutputStream oout = response.getOutputStream();
            fin.read(b);
            oout.write(b,0,ifilesize);
            oout.close();
            fin.close();
            file.delete();
        }
        catch ( Exception e ) {
        }
    }
}