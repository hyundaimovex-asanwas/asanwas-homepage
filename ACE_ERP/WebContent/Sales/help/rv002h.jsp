<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 		: ����  Help 
 * ���α׷�ID 	: RV002H
 * J  S  P		: rv002h
 * �� �� ��		: Rv002H
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-26
 * �������		: ���� ��ȸ 
 * [ �������� ][������] ����
 * [2015-09-17][�ɵ���] ������ȣ like �˻� �߰�
 * [2018-08-21][�ɵ���] �븮�� ���� ����. help/Rv002H.java�� �����κ� ������, ������ ������~
 *                      �� ���� �׸��忡 ���¾�ü�� �߰�
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	String sClientSid = request.getParameter("sClientSid");
	String sClientNm = HDUtil.nullCheckStr(request.getParameter("sClientNm"));
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���� �˻�������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
				cfStyleGrid(getObjectFirst("gr1"), "comn");
				
				var strParam = new Array();
				strParam=window.dialogArguments;
				sClient_sid.value = strParam[0];
				sClientNm.value = strParam[1];
				sCarNo.focus();
				
			}
			
			function fnSelect() {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=" + sClient_sid.value
			          + ",sCarNo=" + sCarNo.value	//������Ϲ�ȣ
			          + ",dsType=1";
			          
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv002H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "CAR_SID")  + ";" +	// ������� SID
                                     ds1.namevalue(row, "CAR_NO") + ";" +	// ������� ��ȣ 
								 	 ds1.namevalue(row, "CAR_NM")   + ";" +	// ����
								 	 ds1.namevalue(row, "CAR_TYPE");
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
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			fnAdd();
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
		
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



	</head>	
	
<!--  BODY START -->
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table   border="0" cellpadding="0" cellspacing="0" width=479px>
			<tr>
				<td height="24px">
					<table  border="0" cellpadding="0" cellspacing="0" width=479px>
					  <tr>
						<td align="left">
							<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;height:15;">���� ����</font>
						</td>
						<td align=right >
							<img src="<%=dirPath%>/Sales/images/p_find.gif" alt="������ �˻��մϴ�" style="cursor:pointer;" onclick="fnSelect();">
						    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:pointer;" onClick="fnAdd()">                            
						    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">                          
						</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table  border="0" cellpadding="0" cellspacing="0" width=479px>
					  <tr>
						<td class="text" width="70px" height="30" style="border:1px solid #708090">���¾�ü��</td>
						<td style="border:1px solid #708090;border-width:1 1 1 0;">&nbsp;
							<input type="text" 		name="sClientNm" 	value="<%=sClientNm%>" 		class="input01" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30" readonly="readonly">
							<input type="hidden" 	name="sClient_sid" 	value="<%=sClientSid%>" 	class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
						</td>
						<td class="text" width="70px" style="border:1px solid #708090; border-width:1 1 1 0;">������ȣ</td>
						<td style="border:1px solid #708090; border-width:1 1 1 0;">&nbsp;
							<input type="text" 		name="sCarNo" 	value="" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" maxlength="30">
						</td>

					  </tr>
					</table>
				</td>
			</tr>

			<tr height="10px">
				<td width=479px></td>
			</tr>
			
			<tr>
				<td width='479px' align='center'>
					<table cellpadding="0" cellspacing="0" border="0" width=479px>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: �׸��� , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:479px; height:248px;border:1 solid #777777;">
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
									   <C> name='����SID'   		ID='car_sid'    width=80  align=left editlimit=12 show=false</C>
									   <C> name='���¾�ü��'     ID='client_nm'  width=100 align=left editlimit=30 show=true sort=true</C>
						               <C> name='������Ϲ�ȣ'     ID='car_no'     width=100 align=center editlimit=30 show=true sort=true</C>
						               <C> name='��    ��'     		ID='car_nm'     width=130 align=center editlimit=32 show=true sort=true</C>
						               <C> name='��    ��'     		ID='car_type'   width=120 align=center editlimit=30 show=true sort=true</C>
									">
								</object>
								
							</td>
						</tr>
						<tr>
							<td>
								<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
								&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
								</fieldset>
							</td>
						</tr>
						<tr>
							<td>
							<!--  ���¹� �÷���  -->
							<iframe id="LowerFrame" 
								name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;"
								 Frameborder="0" src="<%=dirPath%>/Common/include/loadingSales.jsp" 
								 width="400px" height="146px"></iframe>
							</td>
						</tr>
					</table>				
				</td>
			</tr>
		</table>

	</body>
	<!-- BODY END -->
</html>