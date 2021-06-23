<%--
  - 작성자: 임형수
  - 일자: 2006.04.17
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 별점 코멘트형 게시판 파일 업로드
  - 파일확장자 체크 추가 - 20091019 심동현
--%>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.Util"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%
  
	String saveDir 		=  Config.getInstance().getProperty("imjkmd","memGalleryUpload");
	saveDir = saveDir+Util.getToMonth()+"/";
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
	String mode					   		= Util.getString(multi.getParameter("mode"),"");
	String realFileName    		= Util.getString(multi.getParameter("realFileName"),"");
	String virtualFileName    = Util.getString(multi.getParameter("virtualFileName"),"");
	
//out.println(realFileName+"<BR>");
//out.println(virtualFileName+"<BR>");

	String chkExt="false"; //확장자 체크용 스트링(20091015)
	chkExt = checkext(realFileName, avaExt); 

	if (chkExt.equals("true")) { //확장자체크를 통과하면 업로드
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
<%
	} else { //금지된 확장자
%>
	<script language="javascript">
		alert("해당 확장자의 파일은 업로드할 수 없습니다.");
	</script>
<%
	}
%>