<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ��û�� ��ȣ 
 * ���α׷�ID   : RV011H (�ڵ�� �빮��)
 * J  S  P      : rv011h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Rv011H
 * �� �� ��        : ���ؼ�
 * �� �� ��        : 2006-07-27
 * �������     : ����� ������ ��û�� ��ȣ
 * [ �������� ][������] ����
 * [2009-08-25][�ɵ���] ���� â�� ��û�� ��ȣ �˻� ���� �߰�
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    String sDepartDate = request.getParameter("sDepartDate");
    String sClientSid = request.getParameter("sClientSid");
    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>��û�� ��ȣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
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

		        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 			
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sDepartDate=<%=sDepartDate%>"
			          + ",sClientSid=<%=sClientSid%>"
			          + ",sAcceptNo="+ sAcceptNo.value
			          + ",dsType=1";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv011H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			                
				window.returnValue = 	ds1.namevalue(row, "accept_sid") + ";" +
									 ds1.namevalue(row, "accept_no")  + ";" +
								 	 ds1.namevalue(row, "goods_cd")   + ";" +
                                     ds1.namevalue(row, "goods_nm") + ";" +								 	 
								 	 ds1.namevalue(row, "accept_date") + ";" +
								 	 ds1.namevalue(row, "a_sal_amt") + ";" +								 	 								 	 
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
					<table border="0" cellpadding="0" cellspacing="0" width=100% style="position:relative;left:4px;">
						<tr>
							<td colspan=2 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">��û�� ��ȣ</font>
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td class="text" width="180px" height="30" style="border:1 solid #708090">��û����ȣ(�Ϻε� ����)</td>
										<td width="110px" style="border:1 solid #708090;border-left-width:0px">
											<input type="text" name="sAcceptNo" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
										</td>
									</tr>
								</table>
							</td>	
							<td>
								<table border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td align=right>
										    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="��û����ȣ�� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:hand;" onclick="fnSelect();">&nbsp;&nbsp;
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
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
                        <param name="SortView"      value="Right">						
						<param name="Format" 		value="
			                <C> name='��û����ȣ'    ID='accept_no'  width=90 align=center editlimit=15 sort=true show=true</C>
			                <C> name='��ǰ��'     ID='goods_nm'   width=120 align=left editlimit=40 show=true Sort=True</C>
			                <C> name='��û����'  ID='accept_date'   width=80      align=center editlimit=8 sort=true show=true mask=XXXX-XX-XX</C>
			                <C> name='��ûSID'   ID='accept_sid'  align=left editlimit=12 show=false</C>
			                <C> name='�Ǹž�'    ID='a_sal_amt'  width=70 align=right editlimit=33 show=true Value={Number(a_sal_amt)}</C>
			                <C> name='�Աݾ�'      ID='pay_amt'   width=70  align=right editlimit=33 show=true Value={Number(pay_amt)}</C>
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
			<tr>
				<td>
				<!--  ���¹� �÷���  -->
			<iframe id="LowerFrame" 
				name="work" 
				style="visibility:hidden; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.jpg" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>