<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
	String dirPath = request.getContextPath();
%>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
	<title></title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">

<%//css �� �ϴ� ��δ� �״��. html5+CSS3 ����� ��������.%>
<link href="<%=dirPath%>/Sales/common/css/common.css" rel="stylesheet" type="text/css">

<%//�λ��... %>
<link href="<%=dirPath%>/Payroll/common/css/common.css" rel="stylesheet" type="text/css">

<%//�λ��... %>
	<script language="javascript" src="<%=dirPath%>/Payroll/common/include/PubFun.js"></script>

	<script language="javascript" src="<%=dirPath%>/Payroll/common/include/XChart.js"></script>

	
<%//IE��ġ object ���� script �ʼ�!%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script>

<%//15000�� : �̻��̳� ��-_- �ڴϽ� �ҽ�%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>


<%//200�� : �����ý��� ��� - �ַ� �˻� helpâ ���� ���� ���%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_pop.js"></script>      

<%//1900�� : �ڴϽ� �ҽ�%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script>        

<script language="javascript">
  <%//�λ� ����� %>
	var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
	var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
	var  gcurdate	="<%=(String)session.getAttribute("vcurdate")%>";
	var  gautlevel	="<%=(String)session.getAttribute("vautlevel")%>";
	var  gdeptcd	="<%=(String)session.getAttribute("vdeptcd")%>";
	var  gdeptnm	="<%=(String)session.getAttribute("vdeptnm")%>";
	var  gfdcode	="<%=(String)session.getAttribute("vfdcode")%>";
	var  gfdname	="<%=(String)session.getAttribute("vfdname")%>";
	var  gcocode	="<%=(String)session.getAttribute("vcocode")%>";
	var  gconame	="<%=(String)session.getAttribute("vconame")%>";
	var  gjobdty	="<%=(String)session.getAttribute("vjobdty")%>";
	var ssID			="<%=(String)session.getAttribute("ssID")%>";
	var gusrpos	="<%=(String)session.getAttribute("vusrpos")%>";
	var gusrip		="<%=(String)session.getAttribute("vusrip")%>";
	
</script>  


