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
<% //�α��� üũ : 2008-11-27 �ɵ����߰� 
String vusrid="";

	Cookie[] cookies = request.getCookies();
	if ((cookies != null) && (cookies.length > 0)) {
		for(int i=0; i < cookies.length; i++) {
			Cookie thisCookie = cookies[i];
			if(thisCookie.getName().equals("vusrid"))  vusrid      = thisCookie.getValue();
		}
	}

	if (vusrid==""||vusrid.length()==0) {    //���� �Բ� ���� ȭ������ 
		%>
		<script language="javascript">
			alert("���� �α������� �ʾҽ��ϴ�.\n\n���� �α��� ���ּ���!");
//			top.location.href="http://erp.hdasan.com";	//���ð��߿��� �ּ����� ���´�.
		</script>
		<%
	}
	///////////////////////////////////////////
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
	
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(<%=tree_idx%>);">
<script language=javascript>
	get_cookdata();
	//alert(loginNM);
    loginNM.innerHTML=GetCookie("vusrnm");
    loginID.innerHTML=GetCookie("vusrid");
</script>
