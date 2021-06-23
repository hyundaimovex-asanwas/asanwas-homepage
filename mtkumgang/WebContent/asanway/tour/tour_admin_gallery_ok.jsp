<%--
  - 작성자: 임형수
  - 일자: 2006.06.01
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 겔러리
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourAdminGalleryBoard"%>
<%@ page import="kr.co.imjk.util.*"%>



<%


	String saveDir	= Util.getString(Config.getInstance().getProperty("imjkmd","adminGalleryUpload"),"");
          String fileRootDir = Util.getString(Config.getInstance().getProperty("imjkmd","adminGalleryLink"),
	          "/asanway/upload/adminGalleryUpload/");
	

	
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


    
	MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize,"euc-kr", new DefaultFileRenamePolicy());

	//request parameters
	int board_seq			= ParamUtil.getIntParameter(multi.getParameter("board_seq"));
	int attach_seq			= ParamUtil.getIntParameter(multi.getParameter("attach_seq"));
	int requestedPage	= ParamUtil.getIntParameter(multi.getParameter("requestedPage"));


	String title			= ParamUtil.getReqParameter(multi.getParameter("title"));
	String content		= ParamUtil.getReqParameter(multi.getParameter("content"));
	content				= content.replaceAll("'", "\"");
	String cmd				= ParamUtil.getReqParameter(multi.getParameter("cmd"));
	String part				= ParamUtil.getReqParameter(multi.getParameter("part"));
	String keyword		= ParamUtil.getReqParameter(multi.getParameter("keyword"));

	String saveDirName		= ParamUtil.getReqParameter(multi.getParameter("saveDirName"));
	
	
	String realFileName    		= Util.getString(multi.getParameter("realFileName"),"");
	String type_code    		= Util.getString(multi.getParameter("type_code"),"");

	System.out.println("2 realFileName= "+realFileName);
	
	

	Tbrd_attach_file_de_bean file_bean = new Tbrd_attach_file_de_bean();
  

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
		fileSystemName = Util.getString(multi.getFilesystemName(fileName),"");
		
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

			//첨부파일 정보 SET
			file_bean.setReal_name(fileRootDir+fileSystemName.trim());
			file_bean.setVirtual_name(fileRootDir+virtualName);
			file_bean.setAttach_file_seq(attach_seq);
			file_bean.setBoard_seq(board_seq);
		}
	}


//변수 선언
String board_type	= "09";

//DAO
TourAdminGalleryBoard dao = new TourAdminGalleryBoard();
//DTO
Tbrd_board_ma_bean bean = new Tbrd_board_ma_bean();

bean.setBoard_seq(board_seq);
bean.setTitle(title);
bean.setContent(content);
bean.setUser_id("admin");
bean.setUser_name("관리자");
bean.setType_code(type_code);

int result = 0;

if(cmd.equals("insert")){
	result = dao.insert(bean, file_bean);
}else if(cmd.equals("edit")){
	if(fileSystemName.equals("") ){
		//내용만 업데이트
		result = dao.update(bean);
		 
	}else{
		//내용과 첨부파일 업데이트
		result = dao.update(bean, file_bean);
	}
}else if(cmd.equals("del")){
	result = dao.delete(board_seq);
}else if(cmd.equals("attachDel")){
	CommonBoard commonDao = new CommonBoard();
    result = commonDao.resetAttachFile(attach_seq);
}


if(result>0){
   if(cmd.equals("attachDel")){
%>

      <SCRIPT LANGUAGE="JavaScript">
	<!--
	 alert('성공적으로 처리 되었습니다.');
	 parent.delAttachRow();
	
	//-->
	</SCRIPT>
<%
   }else{
%>
    
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	 alert('성공적으로 처리 되었습니다.');
	 parent.location.href="tour_admin_gallery.jsp";
	//-->
	</SCRIPT>
<%
   }
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
		history.back();
		//-->
		</SCRIPT>
<%
}		
%>