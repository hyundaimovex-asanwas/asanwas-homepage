<%@ page info="tempfile upload"  contentType="text/html;charset=euc-kr" %>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.io.*"%>
<%
String saveDir					   = Util.getString(request.getParameter("saveDir"),"");
String mode					   		= Util.getString(request.getParameter("mode"),"");
String realFileName    		= Util.getString(request.getParameter("realFileName"),"");
String virtualFileName    = Util.getString(request.getParameter("virtualFileName"),"");


saveDir 		=  Config.getInstance().getProperty("imjkmd",saveDir);

//out.println(saveDir+"<BR>");
//out.println(mode+"<BR>");

if(mode.equals("i_del")){			
			
		String FilePath = saveDir+virtualFileName.substring(0,6)+"/"+virtualFileName;
		//out.println(FilePath+"<BR>");
		File del = new File(FilePath);			

		if (del.exists()) del.delete();
%>
		<script language="javascript">
		<!--
			parent.delResult();
		//-->
		</script>
<%
		return;			
}else if(mode.equals("u_del")){
		//############### Connection���� ##########################
		CommonBoard CommonDao = new CommonBoard();
		//#########################################################
		
		int result = CommonDao.deleteAttachFile(virtualFileName);
		
		if(result > 0){
		
			String FilePath = saveDir+virtualFileName;
			File del = new File(FilePath);			
						
			if (del.exists()) del.delete();
%>
			<script language="javascript">
			<!--
			 //���Ͼ��ε� 1
       // ���� ���� ������ ���� ��Ͽ��� �����ϱ� ����  ȣ��
				parent.delResult();
			//-->
			</script>
<%	
		}else{
%>
		<script language="javascript">
		<!--
			alert("�۾�����");
		//-->
		</script>
<%		
		}
}
%>