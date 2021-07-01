<%@ page contentType="text/html; charset=euc-kr" import ="java.io.*, com.hmm.asan.common.util.Utility" %>

<%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*" %>


<%@ include file="config.inc.jsp" %>
<%@ include file="secure.inc.jsp" %>
<% 
	//입력되는 파일명의 한글처리 
	String filename = java.net.URLDecoder.decode(request.getParameter("file")); 
	String filename2 = new String(filename.getBytes("euc-kr"),"8859_1"); 
	String dirname = java.net.URLDecoder.decode(request.getParameter("dir")); 
	String dirname2 = new String(dirname.getBytes("euc-kr"),"8859_1"); 
	String dn_path, FilePath; 
	dn_path = checkpath(dirname2, filename2); 
	if (!dn_path.equals("error")) { 
		//파일 전송 프로세스 
		FilePath = DN_PATH+dn_path; 
		File file = new File(FilePath); // 절대경로 입력. 
		byte b[] = new byte[(int)file.length()]; 
		
		response.setHeader("Content-Disposition", "attachment;filename=" + filename2 + ";"); 
		
		if (file.isFile()) { 
			BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file)); 
			BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream()); 
			int read = 0;
			
			while ((read = fin.read(b)) != -1) { 
				outs.write(b,0,read); 
			} 
			
			outs.close(); 
			fin.close(); 
		}
	} else { 
		out.println("입력값 오류1"); 
		return;
	}
%>



<%

	response.reset();

    String dir = request.getParameter("dir");
    if(dir == null) dir = "";

	String path = "";
	if(dir.equals("")) {
//		path = session.getServletContext().getRealPath("/upload/")+ "/";
		path = "/was/file_upload/";
	}	else {
//		path = session.getServletContext().getRealPath("/upload/")+ "/" + dir + "/";
		path = "/was/file_upload/" + dir + "/";
	}

    String filename ="";
    String sysfilename ="";
	String filename1 = "";
	String filename2 = "";
	String filename3 = "";
    if( request.getParameter("filename")!=null)
    {
    	filename3 = request.getParameter("filename");
 //   	filename3 = java.net.URLDecoder.decode(request.getParameter("filename"));
 //   	filename = Utility.ko(request.getParameter("filename"));
//    	filename1 = new String(request.getParameter("filename").getBytes("ISO-8859-1"),"euc-kr");
//    	filename2 = java.net.URLEncoder.encode(filename1, "UTF-8");
    }

     if( request.getParameter("sysfilename")!=null)
    {
    	//sysfilename=java.net.URLDecoder.decode(request.getParameter("sysfilename"));
    	//sysfilename = Utility.ko(request.getParameter("sysfilename"));
    	sysfilename = request.getParameter("sysfilename");
    }

    int filesize = 0;
    String filetype = null;

    String filePath = path + sysfilename;
    java.io.File file = new File(filePath);
    filesize = (int)file.length();

	String header   = request.getHeader("User-Agent");
	String mime = getServletContext().getMimeType(file.toString());
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