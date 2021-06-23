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
		//############### Connection생성 ##########################
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
			 //파일업로드 1
       // 파일 삭제 성공후 파일 목록에서 삭제하기 위해  호출
				parent.delResult();
			//-->
			</script>
<%	
		}else{
%>
		<script language="javascript">
		<!--
			alert("작업실패");
		//-->
		</script>
<%		
		}
}
%>