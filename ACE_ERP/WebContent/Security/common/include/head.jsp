<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : PMS
 * J  S  P      : head.jsp
 * [ �������� ][������] ����
 * [2011-07-01][�ɵ���] PMS�� ���鼭 �ߺ� ���� ���� �� ����ȭ. (�ϰ� ����;;)
 *****************************************************************************/
%>
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

<%//���������... %>
<link href="<%=dirPath%>/Pms/common/css/common.css" rel="stylesheet" type="text/css">

<%//���������... %>
	<script language="javascript" src="<%=dirPath%>/Pms/common/include/PubFun.js"></script>

<%//1200�� : �ۺ� ���. �α��� ���� ����ó��... %>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/PubFun.js"></script>

<%//IE��ġ object ���� script �ʼ�!%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/embedControl.js"></script>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/menu.js"></script>

<%//15000�� : �̻��̳� ��-_- �ڴϽ� �ҽ�%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common_gauce.js"></script>

<%//���� �ý��� ��� - �ַ� �˻� helpâ ���� ���� ���%>
	<script language="javascript" src="<%=dirPath%>/Pms/common/js/common_pop.js"></script>      

<%//1900�� : �ڴϽ� �ҽ�%>
	<script language="javascript" src="<%=dirPath%>/Sales/common/js/common.js"></script>        

	<script language="javascript">

<%//������� ����� %>
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
</script>  


	