<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.*" %>
<%
	String dirPath = request.getContextPath();
	
	//���� tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //�޾ƿ� ���� �޴� ��! fnOnLoad() �Լ��� �Ķ���ͷ� �����Ͽ� �޴�����!
%>





<script language="JavaScript">
	document.onkeydown = function() {	//�� �������� ���� ���� ��ũ��Ʈ.
		if( event.keyCode ==113 ) { //F2
			helpme();				//��� ȣ��
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
		}
	}

	function helpme(){	//���� ���� ���
		window.open("<%=dirPath%>/Helpshop/baseFrame.jsp?menu_idx=<%=tree_idx%>","Helpshop","width=900px, height=700px, resizable=yes,");
	}
	
</script> 

<!-- BODY header begin-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">

<%
/*=============================================================================
			Status Bar Falsh
	�ֽ� : loadingBar
	������ �� �� : LowerFrame
=============================================================================*/
%>	
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

	<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Sales/common/html/progress.htm" width="400px" height="146px"></iframe>	
	


<!-- BODY header end-->

