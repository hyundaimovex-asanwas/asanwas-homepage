<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ������
 * ���α׷�ID   : RV012H (�ڵ�� �빮��)
 * J  S  P      : rv012h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Rv012H
 * �� �� ��        : ���ؼ�
 * �� �� ��        : 2006-07-27
 * �������     : ������
 * ��������     : 
 * �� �� ��        : 
 * ������������ :  
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    String sAcceptSid = request.getParameter("sAcceptSid");
    String sAcceptDate = request.getParameter("sAcceptDate");
    String sAcceptTime = request.getParameter("sAcceptTime");    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>�Աݰ��� ��ȣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
		        cfStyleGrid(getObjectFirst("gr1"), "comn");
				fnSelect();		        	        
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
		        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 			
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sAcceptSid=<%=sAcceptSid%>"
			          + ",sAcceptDate=<%=sAcceptDate%>"
			          + ",sAcceptTime=<%=sAcceptTime%>"
			          + ",dsType=1";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv013H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;

				window.returnValue = 	ds1.namevalue(row, "card_sid") + ";" +
									 ds1.namevalue(row, "pay_manage_no")  + ";" +
                                     ds1.namevalue(row, "card_no") + ";" +								 	 
								 	 ds1.namevalue(row, "issue_company_nm") + ";" +
								 	 ds1.namevalue(row, "agree_no") + ";" +	
								 	 ds1.namevalue(row, "pay_date") + ";" +	
								 	 ds1.namevalue(row, "pay_amt");
			 	fnClose();
			}			
			
			function fnClose() {
				window.close();
			}
			
			
		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
	<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		fnAdd();
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		totalNum.value = ds1.CountRow;
	</script>		

<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
	</head>	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" >
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" width="479px">
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">�Աݰ��� ��ȣ</font>
							</td>
						</tr>
						<tr>
							<td colspan="4" align=right width="479px">
							    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<%=HDConstant.COMMENT_START%>
					<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:248px;" border="1">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
						<param name="LineColor" 	value="#dddddd">
						<param name="Format" 		value="
			                <C> name='ī��SID'     ID='card_sid'    align=left editlimit=12 show=false</C>
			                <C> name='����������ȣ'        ID='pay_manage_no'    width=80   align=center editlimit=40 show=true</C>
			                <C> name='ī���ȣ'      ID='card_no'   width=105  align=center editlimit=20 show=true</C>
			                <C> name='ī��߱޻��'     ID='issue_company_nm'  width=85  align=left editlimit=20 show=true</C>
			                <C> name='���ι�ȣ'     ID='agree_no'   width=65 align=center editlimit=8 show=true</C>
			                <C> name='��������'     ID='pay_date'  width=70  align=center editlimit=8 show=true mask=XXXX-XX-XX</C>
			                <C> name='�����ݾ�'     ID='pay_amt'  width=70  align=center decao=0</C>
						">
					</object>
					<%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : <input type="text" name="totalNum" style="border:0;align=left" width="20"></font>
					</fieldset>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>