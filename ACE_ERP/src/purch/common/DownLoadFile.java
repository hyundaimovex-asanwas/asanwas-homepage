package purch.common;

import java.io.*; 
import javax.servlet.*; 
import javax.servlet.http.*;

public class DownLoadFile extends HttpServlet { 

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException{ 
		String sourceName		= req.getParameter("sourceName");
		String realName = req.getParameter("realName");
		ServletOutputStream stream = null;
		BufferedInputStream fif = null;
	
		try{
			java.io.File file = new java.io.File(sourceName);
			
			String a= new String(realName.getBytes("euc-kr"),"8859_1");
			
			long fileLen = file.length();
		
			fif = new BufferedInputStream(new FileInputStream(file)); 
			stream = res.getOutputStream(); 
		
			// CLIENT BROWSER TYPE NOTICE VARIABLE
			String browser_type = req.getHeader("User-Agent");
		
		    res.setHeader("Content-Type", "application/octet-stream");
		    res.setHeader("Content-Disposition", "attachment;filename="+a+ ";");
			
			res.setHeader("Content-Transfer-Encoding", "binary;");
			res.setHeader("Content-Length", ""+(int)fileLen);
			res.setHeader("Pragma", "no-cache;");
			res.setHeader("Expires", "-1;");
		
			int blockSize = 65000;
			int readBytes = 0;
		    int totalRead = 0;
		    byte b[] = new byte[blockSize];
		
			while((long)totalRead < fileLen) {
				readBytes = fif.read(b, 0, blockSize);
				totalRead += readBytes;
				stream.write(b, 0, readBytes); 
			} 
		} catch(FileNotFoundException e1){
		    e1.printStackTrace();
		} catch(UnsupportedEncodingException e2){
		    e2.printStackTrace();
		} catch(IOException e3){
		    e3.printStackTrace();
		} finally{
			try{
				if (stream!=null)stream.close(); 
				if (fif!=null)fif.close(); 
			}catch(IOException e){
			    e.printStackTrace();
			}
	
		}
	} 
}
