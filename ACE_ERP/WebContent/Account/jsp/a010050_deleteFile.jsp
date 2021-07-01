<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%@ page import="Account.common.HDConstant"%>
<%
	request.setCharacterEncoding("euc-kr");   //이걸 적용하니까....한글이 깨어지지 않네...

	String mode				= Util.getString(request.getParameter("mode"),"");
	String realFileName		= Util.getString(request.getParameter("realFileName"),"");
	String virtualFileName	= Util.getString(request.getParameter("virtualFileName"),"");
	
	/*	
	System.out.println("a010050_deleteFile::");                       
	System.out.println("mode::"+mode);                       //입력 모드  
	System.out.println("realFileName::"+realFileName);       //화면상 파일명  로컬에서는 한글명이 깨어져서 보임. 
	System.out.println("virtualFileName::"+virtualFileName); //시스템 파일명
    */
	
	String saveDir 	=  HDConstant.FILE_UPLOAD_PATH_ACCOUNT+"vend/";	//서버 첨부파일 저장 경로
	//String saveDir 	=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//로컬 첨부파일 저장 경로
	//String saveDir 	=  "/asanwas/구매/pu010/";	//서버 첨부파일 저장 경로

	//String saveDir 		=  "C:\\fileupTest/";	//로컬......

	String FilePath = saveDir+virtualFileName;
	File del = new File(FilePath);			
	
	//System.out.println("FilePath::"+FilePath); //경로
				
	if (del.exists()){
		//System.out.println("파일있오::"); //경로
		del.delete();
		//System.out.println("삭제::"); //경로	
		out.println("<script language=\"javascript\">");
		out.println("<!--");
		out.println("parent.delResult('"+realFileName+"','"+virtualFileName+"')");
		out.println("//-->");
		out.println("</script>");
		out.flush();
		//out.close();
	}else{
		System.out.println("파일없오::"); //경로
	}
%>
	<script language="javascript">
	<!--
    // 파일 삭제 성공후 파일 목록에서 삭제하기 위해  호출
		//parent.delResult();
	//-->
	</script>