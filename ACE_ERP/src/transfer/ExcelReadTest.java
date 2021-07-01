 package transfer;

import  javax.servlet.*;
import  javax.servlet.http.*;
import  java.io.*;
import java.io.InputStream.*;
import java.io.IOException.*;
import java.io.ByteArrayInputStream.*;
import java.io.FileInputStream.*;
import java.io.FileOutputStream.*;
import java.util.*;
import java.lang.Object.*;
import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
 

import java.text.DecimalFormat;
import jxl.*;
import jxl.write.*;
import java.awt.*;

public class ExcelReadTest extends HttpServlet
{
    public void init(ServletConfig config) throws ServletException
    {
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
         
		 
		String filepath = "/tmp";
        String filename = "output.xls";
        try { 
				
				Workbook workbook = Workbook.getWorkbook(new File(filepath + "/" + filename));
				

				Sheet sheet = workbook.getSheet(0); 
				Cell a1 = sheet.getCell(0,0); 
				Cell b2 = sheet.getCell(0,1); 
				Cell c2 = sheet.getCell(0,2); 

				String stringa1 = a1.getContents();
				String stringb2 = b2.getContents();
				String stringc2 = c2.getContents();

				System.out.println(stringa1);
				System.out.println(stringb2);
				System.out.println(stringc2); 
				 
            
        }
        catch ( Exception e ){
			System.out.println(e.toString());
        }

         
    }
}


  