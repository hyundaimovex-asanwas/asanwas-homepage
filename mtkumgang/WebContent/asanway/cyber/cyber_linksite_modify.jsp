<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 26��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.LinkSiteBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	LinkSiteBean bean = new LinkSiteBean();

	String cmd = request.getParameter("cmd");
	String cateidx	 = request.getParameter("cateidx");
	String idx	 = request.getParameter("idx");
	String menutitle = "";

	if(cmd.equals("U")){
		menutitle = "���û���Ʈ ��������";
		bean.Read(request, response);

	}else if(cmd.equals("CU")){
		menutitle = "ī�װ� ��������";
		bean.CateRead(request, response);
	}else{
		out.println("<script language=javascript>window.close();</script>");
	}

	HashMap read = (HashMap)request.getAttribute("read");


%>


<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "25";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script language="javascript">
<!--
	function goInsert(cmd){
		var form = document.form;
		if(cmd == "U"){
			if( form.sitename.value=="" ){
				alert("����Ʈ����   �Է��ϼ���.");
				form.sitename.focus();
				return false;
			}

			if( form.siteurl.value=="" ){
				alert("����Ʈ�ּҸ�    �Է��ϼ���.");
				form.siteurl.focus();
				return false;
			}

		}
		else {
			if( form.name.value=="" ){
				alert("ī�װ�����  �Է��ϼ���.");
				form.name.focus();
				return false;
			}
		}
		form.submit();
	}

//-->
</script>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<form name="form" method="post" action="cyber_linksite_action.jsp" >
	<input type="hidden" name="idx" value="<%=idx%>">
	<input type="hidden" name="cateidx" value="<%=cateidx%>">
	<input type="hidden" name="cmd" value="<%=cmd%>">
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
       <td valign="top" align="center">

       <table width="400" border="0" cellspacing="0" cellpadding="0">
       		<!--
           <tr>
             <td height=40 valign=middle> * <%=menutitle%></td>
           </tr>
           -->
           <tr>
             <td height=70 valign=middle align=center><img src=/asanway/img/pop_title_site.gif></td>
           </tr>
           <tr>
             <td valign="top" style="padding:20 20 20 20;">

			   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <%if(cmd.equals("U")){%>
	                 <tr>
	                   <td height="30">������Ʈ �� : <input type="text" name="sitename" style="width:200px;height:20px"  value="<%= Utility.ko((String)read.get("SITENAME")) %>"></td>
	                 </tr>
	                 <tr>
	                   <td height="30">������Ʈ �ּ� : <input type="text" name="siteurl" style="width:200px;height:20px"  value="<%= Utility.ko((String)read.get("SITEURL")) %>"></td>
	                 </tr>
	             <%}else{%>
					  <tr>
	                   <td height="30">ī�װ���  : <input type="text" name="name" style="width:200px;height:20px"  value="<%= Utility.ko((String)read.get("NAME")) %>"></td>
	                 </tr>
				 <%}%>
 				</form>
              </table>

              </td>
           </tr>
           <tr>
             <td>&nbsp;</td>
           </tr>
         </table>
         </td>
     </tr>
     <tr>
       <td align="right"   style="padding-top:5;padding-right:20;">
       		<a href="javascript:goInsert('<%=cmd%>')"><img src="../img/bt_08.gif" width="40" height="20" hspace="4" border="0"></a>
       		<a href="#" onClick="javascript:window.close()"><img src="../img/bt_11.gif" width="40" height="20" border="0"></a>
       	</td>
     </tr>
     <tr>
       <td>&nbsp;</td>
     </tr>
   </table>
</form>

</body>
</html>
