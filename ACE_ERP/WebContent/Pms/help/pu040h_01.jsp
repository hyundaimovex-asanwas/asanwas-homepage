<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: ���»�  Help 
 * ���α׷�ID 	: PU040H_01
 * J  S  P		: pu040h_01
 * �� �� ��		: Pu040H_01
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-11-18
 * �������		: ���»���ȸ
 *****************************************************************************/
%>
<%@ page import="pms.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	
	String toDay     = m_today.format(date.getTime());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���»���������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Pms/common/include/head.jsp"/>
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
            v_job = "S";
          
                        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    //    + ",v_vend_cd=" 	+ v_vend_cd.value			//vend_cd
                        + ",v_vend_nm=" 	+ v_vend_nm.value			//���»��
                      //  + ",v_vend_id=" 	+ v_vend_id.value;			//����ڹ�ȣ
                        //alert(v_param);
                ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H_01",
                "JSP(O:MASTER=ds1)",
                v_param);
            tr_post(tr1);
           }
           
			
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue =
                                     ds1.namevalue(row, "VEND_CD") + ";" +			
								 	 ds1.namevalue(row, "VEND_NM") + ";" +			
								 	 ds1.namevalue(row, "VEND_ID") + ";" + 			
									 ds1.namevalue(row, "VD_DIRECT") + ";" ;		

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
		<table border="0" cellpadding="0" cellspacing="0" width='479px' style="position:relative;top:1px;width:50;height:15;left:3;">
			
			<tr>
				<td align='center' width='479px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
						<tr>
							<td colspan=4 height=25 width="479px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:80;height:15;">���»���ȸ</font>
							</td>
						</tr>
						
						<tr>
							<td width=479 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='479px'>
									<tr>
										<td align=right width="479px">
											<img src="<%=dirPath%>/Sales/images/p_find.gif" style="cursor:pointer;" onclick="fnSelect();">
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:pointer;" onClick="fnAdd()">
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">                          
										</td>
									</tr>
								</table>
							</td>
						</tr>
						
						<tr>
							<td colspan='4' width='479'>
							<table width=550 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="20px">
							   	<td align=middle class="text" width="80px">�ŷ�ó��
                               	</td>
			                    <td align=middle bgcolor="#ffffff" >&nbsp;<input type="text" name="v_vend_nm" size="30" maxlength="30" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
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
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=550px; height:260px;" border="1">
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
                                    <param name=ViewSummary  value="1">
									<param name="Format" 		value="
   						                <C> name='�ŷ�ó�ڵ�'   	ID='VEND_CD'		align=left editlimit=20 show=true width=120 </C>
   						                <C> name='�ŷ�ó��'   	ID='VEND_NM'		align=left editlimit=20 show=true width=160 </C>   						                
   						                <C> name='����ڹ�ȣ'   	ID='VEND_ID'		align=left editlimit=20 show=true width=160 </C>   						                
									    <C> name='��ǥ'      		ID='VD_DIRECT'	align=left editlimit=30 show=true width=110 </C>
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