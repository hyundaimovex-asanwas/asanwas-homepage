<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 		: �ο�  Help 
 * ���α׷�ID 	: RV004H
 * J  S  P		: rv004h
 * �� �� ��		: Rv004H
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-26
 * �������		: ��Ͻ�û�� ����� �ο����� ��
 * [ ���� ����][������] ����
 * [2009-12-23][�ɵ���] ������ ���� ����� Ÿ�ֿ̹� ������
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	
	String sClientSid = HDUtil.nullCheckStr(request.getParameter("sClientSid"));
	String sClientNm = HDUtil.nullCheckStr(request.getParameter("sClientNm"));
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>�ο�����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
				cfStyleGrid(getObjectFirst("gr1"), "comn");
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=" + client_sid.value
			          + ",sKeyWord=" + sKeyWord.value
			          + ",dsType=1";
			          
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv004H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "CUST_SID")  + ";" +	<%// ���������ȣ%>
                                     ds1.namevalue(row, "CUST_NM") + ";" +		<%// ������%>
								 	 ds1.namevalue(row, "MANAGE_NO") + ";" +	<%// �ֹ�/���ǹ�ȣ %>
								 	 ds1.namevalue(row, "CUST_TYPE") + ";" +	<%// ��������%>
								 	 ds1.namevalue(row, "N_CARD_NO") + ";" +	<%// �������ȣ%>
								 	 ds1.namevalue(row, "WORK_NO");				<%// �ǹ���ȣ%>
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
//			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
//			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ���� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
//			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
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
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%=HDConstant.COMMENT_END%>
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
		<table border="0" cellpadding="0" cellspacing="0" width='479px' style="position:relative;top:1px;width:50;height:15;left:3;">
			
			<tr>
				<td align='center' width='479px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">�ο�����</font>
							</td>
						</tr>
						
						<tr>
							<td width=479 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
									<tr>
										<td align=right width="479px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�����ڸ� �˻��մϴ�" style="cursor:hand;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:hand;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan='4' width='479'>
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width=479>
									<tr>
									<!-- <td class="text" width="80px" height="30" bgcolor="#ffffff">���¾�ü</td>
										<td width="200px"  bgcolor="#ffffff" >&nbsp;&nbsp;
									  	 <input type='text' name='sClientNm' value="<%//=sClientNm%>" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="20"  maxlength="30" readonly="readonly">   -->
											<input type="hidden" name="client_sid" value="<%=sClientSid%>" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="20"  maxlength="30">
										</td>
										<td class="text" width="180px" height="30" bgcolor="#ffffff">����/�ֹε�Ϲ�ȣ</td>
										<td width="150px"  bgcolor="#ffffff" >&nbsp;&nbsp;
											<input type='text' name='sKeyWord' value="" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();" size="10"  maxlength="30"> 
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="5px" >
				<td colspan='4'></td>
			</tr>
			
			<tr>
				<td width='479px' align='center' colspan='4'>
					<table cellpadding="0" cellspacing="0" border="0" width='479px'>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: �׸��� , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								<%=HDConstant.COMMENT_START%>
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:260px;" border="1">
									<param name="DataID"		value="ds1">
									<param name="BorderStyle" 	value="0"> 
									<param name="ColSizing"     value="true">
									<param name="AutoResizing" 	value=true> 
									<param name="Editable"  	value="false">
									<param name="AddSelectRows" value=true>
									<param name=SortView  		value="Right">
                                    <param name=ViewSummary  value="1">
									<param name="Format" 		value="
									  	<C> name='��SID'    		ID='cust_sid'	align=left editlimit=12 show=false width=100 </C>
						                <C> name='����'      		ID='cust_nm'	align=left editlimit=30 show=true width=110 sumtext=@count Sort=True</C>
						                <C> name='�ֹ�/���ǹ�ȣ'   	ID='manage_no'	align=left editlimit=20 show=true width=130 sumtext=�� Sort=True</C>
						                <C> name='�������ȣ' 	ID='N_CARD_NO'	align=CENTER editlimit=20 show=true width=120 </C>
						                <C> name='�ǹ���ȣ'     	ID='work_no'	align=CENTER editlimit=20 show=true width=100 </C>
									">
								</object>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>