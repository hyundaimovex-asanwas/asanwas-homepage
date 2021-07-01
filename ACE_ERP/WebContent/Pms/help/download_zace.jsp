<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="java.io.*"%>
<%@ page import="com.hmm.asan.common.util.Utility"%>
<%@ page import="sales.common.*"%>
<%@ page import="pms.common.HDConstant"%>
<%
	response.reset();

    String dir = request.getParameter("dir");
    
    if(dir == null) dir = "";
    
 	if( request.getParameter("sysfilename")!=null)
    {
    	sysfilename = request.getParameter("sysfilename");
    }    
    
	String path = "http://203.242.32.115/"+sysfilename;
	
	//if(dir.equals("")) {
	//	path = HDConstant.FILE_UPLOAD_PATH_FILE+"pu010/";	//로컬 첨부파일 저장 경로
	//}	else {
	//	path = HDConstant.FILE_UPLOAD_PATH_FILE + dir + "/";
	//}

    String filename ="";
    String sysfilename ="";
	String filename1 = "";
	String filename2 = "";
	String filename3 = "";
	
    //if( request.getParameter("filename")!=null)
    //{
	//   	filename3 = Utility.ko(request.getParameter("filename"));
    //}

 	//if( request.getParameter("sysfilename")!=null)
    //{
    //	sysfilename = request.getParameter("sysfilename");
    //}

    int filesize = 0;
    String filetype = null;

    String filePath = path + sysfilename;
    java.io.File file = new File(filePath);
    filesize = (int)file.length();

	String header   = request.getHeader("User-Agent");
	String mime = pageContext.getServletContext().getMimeType(file.toString());
	//String mime = getServletContext().getMimeType(file.toString()); 수정 전_20140115
   	if (mime == null){
		mime = "application/octet-stream";
	}
	response.setContentType(mime);
	response.setContentType("text/html; charset=euc-kr");

 	BufferedInputStream bin = null;
	BufferedOutputStream bos = null;

   try {

		response.setContentLength(filesize);

		String value = "";
	   if(header.indexOf("MSIE 5.5") != -1) {
		   value = "filename=\"" + filename3 + "\";";
		} else {
		   value ="attachment;filename=\"" +filename3+ "\";";
		}

			byte b[];

			try {
			 	 b = value.getBytes(response.getCharacterEncoding());
			} catch (Exception ex) {
				b = value.getBytes();
			}

		char c[] = new char[b.length];
		for (int i=0;i<b.length;i++) {
		  c[i]=(char)(((char)b[i])&0xff);
		  //System.out.println("characters=" + c[i]);
		}

	   response.setHeader("Content-Type", ""+mime+"; charset=euc-kr");
	   response.setHeader("Content-Disposition",new String(c));
	   response.setHeader("Content-Transfer-Encoding", "binary;");
	   response.setHeader("Pragma", "no-cache;");
	   response.setHeader("Expires", "-1;");
	   response.setHeader("Content-Length", "" + filesize );

		bin = new BufferedInputStream( new FileInputStream(file) );
		bos = new BufferedOutputStream( response.getOutputStream() );

		byte[] buf = new byte[2048]; //buffer size 2K.
		int read = 0;
		while ((read = bin.read(buf)) != -1) {
			bos.write(buf,0,read);
		}
		bos.close();
		bin.close();

	} catch (Exception e) {
	} finally {
//		bos.flush();
		if(bos != null) bos.close();
		if(bin != null) bin.close();
	}
%>