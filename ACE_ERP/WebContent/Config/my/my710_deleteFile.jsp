<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%@ page import="sales.common.*"%>
<%
String mode				= Util.getString(request.getParameter("mode"),"");
String realFileName		= Util.getString(request.getParameter("realFileName"),"");
String virtualFileName	= Util.getString(request.getParameter("virtualFileName"),"");

String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"board/";	//로컬 첨부파일 저장 경로
			
		String FilePath = saveDir+virtualFileName;
		File del = new File(FilePath);			
					
		if (del.exists()) del.delete();
%>
		<script language="javascript">
		<!--
	       // 파일 삭제 성공후 파일 목록에서 삭제하기 위해  호출
			parent.delResult();
		//-->
		</script>