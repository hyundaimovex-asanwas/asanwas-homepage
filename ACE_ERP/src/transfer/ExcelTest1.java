 package transfer;

import  javax.servlet.*;
import  javax.servlet.http.*;
import  java.io.*;

import  jxl.*;
import  jxl.write.*;
 



public class ExcelTest1 extends HttpServlet
{
    public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException,FileNotFoundException
    {
        
		response.setContentType("text/plain;charset=euc-kr");
				 PrintWriter out = response.getWriter();
				  out.println("Hey, don't call by GET Method");
				 //out.close();

		
		String filename1 = "aaaaaa" ; 
		try{ filename1 = request.getParameterValues("filename")[0];}catch(Exception e){}
		//FileInputStream fin1 = new FileInputStream(filename1);	
			out.println(filename1);
			//out.println(fin1);	 
				//out.close();

		String filepath = "C:";
        String filename = "output.xls";
        try {
            Workbook workbook = 
                Workbook.getWorkbook(new File(filepath + "/"  + filename)); 
			 

				Sheet sheet = workbook.getSheet(0); 
				Cell a1 = sheet.getCell(0,0); 
				Cell b2 = sheet.getCell(0,1); 
				Cell c2 = sheet.getCell(0,2); 

				String stringa1 = a1.getContents();
				String stringb2 = b2.getContents();
				String stringc2 = c2.getContents();
				
				// response.setContentType("text/plain;charset=euc-kr");
				 //PrintWriter out = response.getWriter();
				 out.println("Hey, don't call by GET Method");
				 //out.close();


				out.println(stringc2);
				out.close();


				//workbook.close();
        }
        catch ( Exception e ){
			//System.out.println(e.toString());
			//PrintWriter out = response.getWriter(); 
			out.println(e.toString());
			//out.close();
        }

		try {
            File file = new File( filepath+ "/" + filename );
            FileInputStream fin = new FileInputStream(file);
            int ifilesize = (int)file.length();
			out.println(ifilesize);
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

			out.println(e.toString());
        }

         
    }
}