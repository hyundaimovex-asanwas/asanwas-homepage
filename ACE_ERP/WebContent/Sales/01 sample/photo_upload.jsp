<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ���������
 * ���α׷�ID 	: RM020I
 * J  S  P		: rm020i
 * �� �� ��		: Rm020I
 * �� �� ��		: ������
 * �� �� ��		: 2006-06-08
 * �������		: ���������(��ȸ ��� ���� ����)
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>		
		<script language="javascript">
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
//		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
//		fnInit();
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ 
// Parameter 	: 
%>
	function fnInit(){
	        cfStyleGrid(getObjectFirst("gr1"), "comn");
	}
</script>

</head>                                                                                 
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>                              
                                                                                        
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
							
<table border="0" cellpadding="0" cellspacing="0" width="100%" bordercolor=orange> 
  <tr>
  	<td>
		<table width="400px" cellpadding="0" cellspacing="0" border="0">
		  <tr> 
			<td style="width:70px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">���ڵ�</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="2">
			</td>
			<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">���̸�</td>
			<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
				<input id="txt_dong_nm" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:100px; height:18px;" maxlength="30">
			</td>
		  </tr>
		</table>
  	</td>
  </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
                                                                                    
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		                    
                                                                                    