<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%@ page import="pms.common.HDConstant"%>
<%
String mode				= Util.getString(request.getParameter("mode"),"");
String realFileName		= Util.getString(request.getParameter("realFileName"),"");
String virtualFileName	= Util.getString(request.getParameter("virtualFileName"),"");

String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"pu010/";	//로컬 첨부파일 저장 경로
//String saveDir 		=  "/QIBM/UserData/WebSphere/AppServer/V6/Base/profiles/HDASAN/installedApps/NEWASAN_HDASAN/DB2WebServicesSamples.ear/DB2Samples.war/Pms/file/pu010/";	//로컬 첨부파일 저장 경로
//String saveDir 		=  "/asanwas/구매/pu010/";	//서버 첨부파일 저장 경로
			
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