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

String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE+"board/";	//���� ÷������ ���� ���
			
		String FilePath = saveDir+virtualFileName;
		File del = new File(FilePath);			
					
		if (del.exists()) del.delete();
%>
		<script language="javascript">
		<!--
	       // ���� ���� ������ ���� ��Ͽ��� �����ϱ� ����  ȣ��
			parent.delResult();
		//-->
		</script>