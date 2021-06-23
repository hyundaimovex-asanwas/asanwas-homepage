<%--
  - 다운로드 경로 체크 함수 추가- 20091019 심동현
--%>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import ="java.io.*, com.hmm.asan.common.util.Utility" %>

<%

	response.reset();
    String dn_path="";
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



    dn_path = checkpath(path, sysfilename); 

if (!dn_path.equals("error")) { 

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

}else{
	out.println("can NOT find file!");
}

%>