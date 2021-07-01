<%--
  - 설명: 파일 첨부 업로드
--%>
<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="pms.common.HDConstant"%>
<%
  		String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"pu010/";	//로컬 첨부파일 저장 경로
		//String saveDir 		=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//로컬 첨부파일 저장 경로

	int maxSize = 10*1024*1024;						//맥스 사이즈 설정

   //첨부파일 용량 체크
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('최대용량은 10M를 넘을 수 없습니다.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	
    //첨부파일 용량 체크
 
	MultipartRequest multi	= new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());
	String mode				= Util.getString(multi.getParameter("mode"),"");
	String realFileName 	= Util.getString(multi.getParameter("realFileName"),"");
	String virtualFileName	= Util.getString(multi.getParameter("virtualFileName"),"");
	


		String fileName = new String();
		String fileSystemName = new String();
		Enumeration enum = multi.getFileNames();
		  File systemFile = null;
		  File tempFile = null;
		  int sepIndex = 0;
		  String fileExtName = "";
			String virtualName = "";
			
			while(enum.hasMoreElements())
			{  
				fileName = (String)enum.nextElement();
				fileSystemName = multi.getFilesystemName(fileName);
			  //확장자 뽑아내기
			  sepIndex = fileSystemName.indexOf(".");
		    if(sepIndex>0){
		        fileExtName =  fileSystemName.substring(sepIndex);
		    }
			  //업데이트 된 파일 찾기
			  systemFile = new File(saveDir+fileSystemName);
		    //업데이트 된 파일이 있으면..
		    //파일이름 
		    String fileSeq = Util.getSeqText();
		  
			  if(systemFile.exists()){
			      //파일 이름을 시퀀스번호로 변경한다.
			      virtualName = fileSeq+fileExtName;
			      tempFile = new File(saveDir+virtualName);
			      //서버에 저장한다.
			      systemFile.renameTo(tempFile);
			  }
			}
%>
	<script language="javascript">
	<!--
	
	  
    //파일업로드 1
    // 파일 목록에 추가
    	parent.addFileList('<%= realFileName%>','<%= virtualName%>');
	//-->
	</script>
