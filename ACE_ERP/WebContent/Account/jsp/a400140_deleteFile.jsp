<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.HtmlUtil"%>
<%@ page import="kr.co.imjk.util.StringUtil"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="Account.common.HDConstant"%>
<%
		request.setCharacterEncoding("euc-kr");
		
		String mode				= Util.getString(request.getParameter("mode"),"");
		String realFileName		= Util.getString(request.getParameter("realFileName"),"");
		String virtualFileName	= request.getParameter("virtualFileName");

        String saveDir 		=  HDConstant.FILE_UPLOAD_PATH_FILE;	//�������
        //String saveDir = "C:\\";	//���� ÷������ ���� ���
        //System.out.println("virtualFileName::"+virtualFileName); 
        //String virtualFileName2 = new String(virtualFileName.getBytes("8859_1"),"euc-kr");
        //System.out.println("virtualFileName2::"+virtualFileName2); 

		String FilePath = saveDir+virtualFileName;
		//System.out.println("FilePath::"+FilePath);
        
		File del = new File(FilePath);			 
					
		//System.out.println("deldeldeldel::"+del);
		
		if (del.exists()) del.delete();
		
%>
		<script language="javascript">
		<!--
	    // ���� ���� ������ ���� ��Ͽ��� �����ϱ� ����  ȣ��
			parent.delResult();
		//-->
		</script>