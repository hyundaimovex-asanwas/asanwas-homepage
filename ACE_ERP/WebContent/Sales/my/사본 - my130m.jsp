<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.my.BaseDataClass" %>
<%@ page import="sales.common.HDConstant" %>
<%
/******************************************************************************
 * �ý��۸� 		: ����������
 * ���α׷�ID 	: MY130M
 * J  S  P		: my130m
 * �� �� ��		: My130I
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: ���÷��ΰ��� (����)
 * ��������		: 
 * �� �� ��		: 
 * ������������ 	:  
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�


   // ContextPath
   String dirPath = request.getContextPath(); //HDASan
   		String servletPath = "/services/servlet/sales.common.my.BaseServlet";
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
<script language=javascript>
<!--
function fnOnLoad(){
	myEditor.editBox.document.body.innerHTML = "<%=value.get("brd_contents")%>";
}


	// ����
	function fnUpdate(id) {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_UPDATE%>'; // �۾� Ÿ��
		
		f.brd_no.value = id;
		f.brd_contents.value = myEditor.editBox.document.body.innerHTML;
		
		f.ref.value = "<%=value.get("ref")%>";
		f.ref_step.value = "<%=value.get("ref_step")%>";
		f.ref_level.value = "<%=value.get("ref_level")%>"; 
		alert("<%=value.get("sys_file")%>")
		f.method = "post";
		f.submit();
	}
	function fnCancel() {
		var f = document.form1;
		
		f.action = "<%=dirPath%><%=servletPath%>";

		f.actId.value = "my130s";
		f.process_flag.value = '<%=HDConstant.PROCESS_TYPE_SEARCH%>'; // �۾� Ÿ��

		f.method = "post";
		f.submit();
	}
//-->
</script>		
	</head>
	
<jsp:include page="/Sales/common/include/body_s.jsp"/>
					<!-- ���� �ڵ� �κ� ����  -->
            			<tr>
            			    <td height="10"></td>
            			</tr>
						<tr> 
							<td><table width="845" border="0" cellspacing="0" cellpadding="0" ID="Table1">
							   
                        	     <tr> 
                        	       <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                        	       <td colspan="3" style="padding-top:3px">&nbsp;&nbsp; 
                        	         <input type="text" name="brd_subject" size="70" value="<%=value.get("brd_subject")%>"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td width="80" height="30" align='right' valign="middle" bgcolor="#F3F0F9"><b><font color="#555555">�� �� ��&nbsp;</font></b></td>
                        	       <td style="padding-top:3px" colspan="3">&nbsp;&nbsp; 
                        	         <%=value.get("brd_creator")%>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	      <form  name="fileForm" method="post" enctype="multipart/form-data">
	                            <tr>
	                              <td width="80" height='30' align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">÷������&nbsp;</font></b></td>
	                              <td style="padding-top:3px" colspan="3">&nbsp;&nbsp;
	                                <input type="file" name="real_files" size="60" ID="File1"></td>
	                            </tr>
	                             </form> 
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	      <form name="form1"> 
                        	     <tr> 
                        	       <td width="80" height="30" align='right' valign='middle' bgcolor="#F3F0F9"><b><font color="#555555">�� &nbsp;&nbsp;&nbsp;��&nbsp;</font></b></td>
                        	       <td style="padding-top:3px" colspan="3">&nbsp;&nbsp; 
                        	      	<!--==========================================//-->
                        	        <iframe src="<%=dirPath%>/Sales/common/htmlEditor/myEditor.htm" frameborder="0" marginWidth=0 marginHeight=0 width="750" height="400" scrolling="no" name="myEditor"  ></iframe>
                        	     <!--==========================================//-->
                        	       </td>
                        	     </tr>
                        	     <tr> 
                        	       <td bgcolor="E1E1E1" height="1" colspan="4"></td>
                        	     </tr>
                        	     <tr bgcolor="92C306"> 
                        	       <td colspan="4" height="1"></td>
                        	     </tr>
                        	     <tr> 
                        	       <td colspan="4" align="center" style="padding-top:5px"><a href="javascript:fnUpdate('<%=value.get("brd_no")%>');"><img src="<%=dirPath%>/Sales/images/b_ok.gif" alt="" border="0"></a>&nbsp;&nbsp;<a href="javascript:fnCancel();"><img src="<%=dirPath%>/Sales/images/b_cancel.gif" alt="" border="0"></a></td>
                        	     </tr>
                                    	     
                        	   </table></td>
						</tr>
					<!-- ���� �ڵ� �κ� ��  -->
<input type="hidden" name="actId" 			value=""> <!-- �׼� ID -->
<input type="hidden" name="process_flag" 	value=""> <!-- �۾� �÷��� -->
<input type="hidden" name="brd_no" 			value="">
<input type="hidden" name="brd_contents" 	value=""> <!--  ���� -->
<input type="hidden" name="brd_subject" value=""><!-- ����-->
<input type="hidden" name="ref" 			value=""> <!--  �亯�� ���� �۹�ȣ   -->
<input type="hidden" name="ref_step" 		value=""> <!--  ����� ����   -->
<input type="hidden" name="ref_level" 		value=""> <!-- �亯���� -->


<input type="text" name="real_file" 	value="">
<input type="text" name="sys_file" 	value="">
      	<iframe id="fileUploadFrame" 
          	name="fileUploadFrame"
			style="visibility:hidden; position:absolute; left:0px; top:0px;" 
			Frameborder="0" width="0px" height="0px">
		</iframe>   
</form>                 
<jsp:include page="/Sales/common/include/body_e.jsp"/>