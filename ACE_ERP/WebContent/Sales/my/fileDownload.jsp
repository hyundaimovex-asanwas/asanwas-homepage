<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.BufferedOutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.common.HDConstant" %>



<%

// 	String szContextPath = "/HDAgent/";
	String szContextPath = request.getContextPath();

 	String szFileName = request.getParameter("down");
//	String path = request.getParameter("downPath");
	
 	String serverDir= HDConstant.FILE_UPLOAD_PATH_NOTICES;
	//String serverDir= path;

 	String szFilePath = serverDir + szFileName;

StringUtil.printMsg("���ϸ�", szFilePath,this);
    File file = new File( szFilePath);

    BufferedInputStream fin=null;
    BufferedOutputStream fout=null;

    if( file.exists())
    {
         int filesize = (int)file.length();
         
         StringUtil.printMsg("������ ���� ===" , filesize, this);
         byte[] b = new byte[filesize];

         if( request.getHeader("User-Agent").indexOf("MSIE 5.5") != -1)
         {
          System.out.println( 1);

             response.setHeader("Content-Type", "doesn/matter;");
             response.setHeader("Content-Disposition", "filename=" + new String(szFileName.getBytes(),"EUC-KR") + ";");
         }
         else
         {
           // ���� reset�� �߿�

  			 response.reset();
             response.setContentType("application/x-msdownload;charset=EUC-KR");

             response.setHeader("Content-Disposition", "attachment; filename=" + new String( szFileName.getBytes("EUC-KR"), "8859_1")  + ";");
             response.setHeader("Content-Description", "JSP Generated Data");
         }

         fin = new BufferedInputStream(new FileInputStream(file));
         fout = new BufferedOutputStream( response.getOutputStream());
         for(int k = 0; (k = fin.read(b)) != -1;)
         {
             fout.write(b, 0, k);
             
         }
         
      

     }  else  { // file �� �������� ������..
         PrintWriter pw = response.getWriter();
//         out.print("file not exist !! <br>");
  //       out.print("value of filepath == "+szFilePath);
    //     out.print("value of filename == "+szFileName);
         StringUtil.printMsg("-----",this);
         out.println("<script>alert('������ �������� �ʽ��ϴ�!'); history.go(-1);</script>");
         
     }
    
     
    
%>
