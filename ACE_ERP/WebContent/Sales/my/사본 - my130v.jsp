<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.my.BaseDataClass" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sales.common.HDConstant" %>
<%
/******************************************************************************
 * �ý��۸� 		: ����������
 * ���α׷�ID 	: MY130V
 * J  S  P		: my130v
 * �� �� ��		: My130I
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: ���÷��ΰ��� (��)
 * ��������		: 
 * �� �� ��		: 
 * ������������ 	:  
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�

   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   
		String servletPath = "/services/servlet/sales.common.my.BaseServlet";
 // ArrayList data = (ArrayList)request.getAttribute("DATA");
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
	
		BaseDataClass value = (BaseDataClass)request.getAttribute("DATA");
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<!-- HEAD ���� -->
	<jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
	<script language="javascript">
	<!--
	function fnOnLoad(){

	}

	// ����Ʈ�� 
	function fnSearch() {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_SEARCH%>'; // �۾� Ÿ��

		f.method = "post";
		f.submit();
	}
	
	// ���������� 
	function fnModify(id) {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_EDIT%>'; // �۾� Ÿ��

		f.brd_no.value = id;

		f.method = "post";
		f.submit();
	}
	// ���� 
	function fnDelete() {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_DELETE%>'; // �۾� Ÿ��

		f.brd_no.value = "<%=value.get("brd_no")%>";

		f.method = "post";
		f.submit();
	}
	
	// �亯������ �̵�
	function fnReply(id) {
		var f = document.form1;
		
		f.action = "<%=dirPath%>/Sales/my/my130r.jsp?menu_title=my130s&ut=A&mt=M";

		f.brd_no.value = id;
		f.ref.value = "<%=value.get("ref")%>";
		f.ref_step.value = "<%=value.get("ref_step")%>";
		f.ref_level.value = "<%=value.get("ref_level")%>";
		
		f.method = "post";
		f.submit();
	}
	
	//-->
	</script>
	</head>
</head>
<jsp:include page="/Sales/common/include/body_s.jsp"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	
<form name="form1" >	
	<table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table3">
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>							
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">��  &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                                       <td colspan="3" style="padding-top:3px">&nbsp;&nbsp;<%=value.get("brd_subject")%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                                       <td width="340" style="padding-top:3px">&nbsp;&nbsp;<%=value.get("brd_creator")%></td>
                                       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                                       <td width="345" align="left" style="padding-top:3px">&nbsp;&nbsp;<%=value.get("brd_cdate").substring(0,16)%></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                              	   <tr>
                              	      <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
                              	      <td width="345" align="left">&nbsp;&nbsp;<%=value.get("real_file")%>&nbsp;&nbsp;<a href="<%=dirPath%>/Sales/my/fileDownload.jsp?down=<%=value.get("sys_file")%>" target="" ><img src="<%=dirPath%>/Sales/images/file.gif" border=0 align="absmiddle"></a></td>
                              	     <td colspan="3">&nbsp;&nbsp;</td>
                              	   </tr>
                              	   <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr> 
                                       <td colspan="4" align="center"> 
                              	         <table width="100%" border="0" cellspacing="0" cellpadding="10" ID="Table2">
                                           <tr> 
                                             <td height='80' valign='top'><%=value.get("brd_contents")%></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                     <tr> 
                                       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                                     </tr>
                                     <tr align="center"> 
                                       <td align="right" colspan="4" style="padding-top:5px"> 
                                         <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                           <tr> 
                                             <td align="right">
	                                             <a href="javascript:fnReply('<%=value.get("brd_no")%>');"><img src="<%=dirPath%>/Sales/images/b_reply.gif" border="0"></a>
	                                             <a href="javascript:fnModify('<%=value.get("brd_no")%>');">		<img src="<%=dirPath%>/Sales/images/b_edit.gif" border="0"></a>
	                                             <a href="javascript:fnDelete();">	<img src="<%=dirPath%>/Sales/images/b_del.gif" border="0"></a>
	                                             <a href="javascript:fnSearch();">		<img src="<%=dirPath%>/Sales/images/b_list.gif" border="0"></a></td>
                                           </tr>
                                         </table></td>
                                     </tr>
                                    
                                   </table></td>
						</tr>
					<!-- ���� �ڵ� �κ� ��  -->
	<input type="hidden" name="brd_no" value="">
	
	<input type="hidden" name="search_key" value="">
	<input type="hidden" name="search_values" value="">
	
	<input type="hidden" name="ref" value="">				<!-- ������ȣ -->
	<input type="hidden" name="ref_step" value="">			<!-- �亯���� -->
	<input type="hidden" name="ref_level" value="">			<!-- �亯���� -->
	
	<input type="hidden" name="actId" 			value=""> 	<!-- �׼� ID -->
	<input type="hidden" name="process_flag" 	value=""> 	<!-- �۾� �÷��� -->
  </form>
<jsp:include page="/Sales/common/include/body_e.jsp"/>
 
