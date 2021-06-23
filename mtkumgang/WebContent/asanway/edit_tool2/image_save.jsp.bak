<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.board.dao.StarCommentBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>


<% 

	String saveDir	=  Config.getInstance().getProperty("imjkmd","editUpload"); //"/was/web/tour/asanway/upload/editUpload/"

	int maxSize = 5*1024*1024;

   //첨부파일 용량 체크
    if(request.getContentLength() > maxSize ){

		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("alert('최대용량은 5M를 넘을 수 없습니다.');");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		out.close();

		return;
	}	
    //첨부파일 용량 체크
 
	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());
	String mode				= Util.getString(multi.getParameter("mode"),"");
	String realFileName    	= Util.getString(multi.getParameter("realFileName"),"");
	
	String saveDirName    	= ParamUtil.getReqParameter(multi.getParameter("saveDirName")); //"/was/web/tour/asanway/upload/noticeEditorUpload/"
	String moveDir			= saveDirName;//Config.getInstance().getProperty("imjkmd",saveDirName);
	String editServer		= Config.getInstance().getProperty("imjkmd","rootServer")+"asanway/upload/noticeEditorUpload/";
	String fileName = new String();
	String fileSystemName = new String();
	
	Enumeration enum = multi.getFileNames();
	File systemFile = null;
	File tempFile = null;
	int sepIndex = 0;
	String fileExtName = "";
	String virtualName = "";
	String fileSeq = "";
	

    
 	// 임시디렉토리(editUpload)에 저장된 파일을 새로운 디렉토리(moveDir)에
	// 유닉크한 이름으로 바꾸어서 저장한다. 
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
		if(systemFile.exists()){
			
		    //유닉크한 파일이름 얻기
		    fileSeq = Util.getSeqText();

			//파일 이름을 시퀀스번호로 변경한다.
		    virtualName = fileSeq+fileExtName;
              
			tempFile = new File(moveDir+virtualName);
			
			//서버에 저장한다.
			systemFile.renameTo(tempFile);
		}
	}
			
			
	
%>
<script language=javascript>

		parent.opener.setImage('<%=virtualName%>','<%=editServer%>','center','bottom');
		self.close();
</script>