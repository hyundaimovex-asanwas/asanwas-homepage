<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸�     : ������
 * ���α׷�ID   : RV012H (�ڵ�� �빮��)
 * J  S  P      : rv012h (jsp���ϸ��� �ҹ��ڷ� �Ѵ� )
 * �� �� ��        : Rv012H
 * �� �� ��        : ���ؼ�
 * �� �� ��        : 2006-07-27
 * �������     : ���ȯ��ȭ�� ������ �˾�
 * [ �������� ][������] ����
 * [2008-11-14][�ɵ���] ����� ���� �� �۾�����=ȯ�Ҹ� �����ϵ��� ����
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
	String sClientSid = request.getParameter("sClientSid");	
    String sAcceptSid = request.getParameter("sAcceptSid");
    String sAcceptDate = request.getParameter("sAcceptDate");
    String sAcceptTime = request.getParameter("sAcceptTime");    
    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>����������������������������������������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			
			function fnOnLoad() {
		        cfStyleGrid(getObjectFirst("gr1"), "comn1");
				fnSelect();		        	        
			}
			
			function fnSelect() {
				fnSubSelect1();
			}
			 
			function fnSubSelect1() {
		        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>"; 			
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClientSid=<%=sClientSid%>"
			          + ",sAcceptSid=<%=sAcceptSid%>"
			          + ",sAcceptDate=<%=sAcceptDate%>"
			          + ",sAcceptTime=<%=sAcceptTime%>"
			          + ",sCustNm=" + sCustNm.value
			          + ",dsType=1";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv012H",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
			
			function fnAdd() {
				var row = ds1.rowposition;
				if(ds1.namevalue(row, "status_cd")=="NS"){ <%//����� ���%>
					alert("������°� NoShow�� ��� ��û�� �Ұ����մϴ�.\n���� ����� �������=��ҷ� �����ش޶�� ��û���ּ���.");
					return;
				}

				window.returnValue = ds1.namevalue(row, "cust_sid") + ";" +		//0
									 ds1.namevalue(row, "cust_nm")  + ";" +
								 	 ds1.namevalue(row, "manage_no")   + ";" +
                                     ds1.namevalue(row, "company_nm") + ";" +
								 	 ds1.namevalue(row, "positions") + ";" +
								 	 ds1.namevalue(row, "mobile_no") + ";" +
								 	 ds1.namevalue(row, "upjang_sid") + ";" +
								 	 ds1.namevalue(row, "a_room_type_sid") + ";" +
								 	 ds1.namevalue(row, "rsv_sid") + ";" +
								 	 ds1.namevalue(row, "a_sal_amt") + ";" +
								 	 ds1.namevalue(row, "pay_amt") + ";" +		//10
								 	 ds1.namevalue(row, "a_room_type_cd") + ";" +
								 	 ds1.namevalue(row, "a_room_type_nm") + ";" +
								 	 ds1.namevalue(row, "upjang_cd") + ";" +
								 	 ds1.namevalue(row, "upjang_nm") + ";" +
								 	 ds1.namevalue(row, "depart_date") + ";" +	//15
								 	 ds1.namevalue(row, "depart_time") + ";" +
								 	 ds1.namevalue(row, "charge_rate") + ";" +
								 	 ds1.namevalue(row, "goods_nm") + ";" + 	//��ǰ��
								 	 ds1.namevalue(row, "goods_sid") + ";" + 	//��ǰsid
								 	 ds1.namevalue(row, "confirm_yn") + ";" + 	//�����
								 	 ds1.namevalue(row, "status_nm") + ";" + 	//������¸�
								 	 ds1.namevalue(row, "status_cd");			//��������ڵ�
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
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:150;height:15;">������</font>
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:219px;">
									<tr>
										<td class="text" width="80px" height="30" style="border:1 solid #708090">����</td>
										<td width="110px" style="border:1 solid #708090;border-left-width:0px">
											<input type="text" name="sCustNm" class="textbox" style="position:relative;left:8px;width:100px;" onkeydown="if(event.keyCode==13) fnSelect();"  maxlength="30">
										</td>
									</tr>
								</table>
							</td>	
							<td>
								<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:247px">
									<tr>
										<td align=right>
										    <img src="<%=dirPath%>/Sales/images/p_find.gif" alt="�������� �˻��մϴ�" style="position:relative;left:8px;top:0px;cursor:pointer;" onclick="fnSelect();">&nbsp;&nbsp;
										    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="cursor:pointer;" onClick="fnClose()">                          
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
					<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=479px; height:280px;" border="1">
						<param name="DataID"		value="ds1">
						<param name="BorderStyle" 	value="0"> 
						<param name="AllShowEdit" 	value="false"> <!-- Edit����  -->
						<param name="ColSizing"     value="true">
						<param name="Fillarea"		value="true">
						<param name="AutoResizing" 	value=true> 
						<param name="Editable"  	value="false">
						<param name="AddSelectRows" value=true>
						<param name="IndWidth"      value="0">
                        <param name="SortView"      value="Right">						
						<param name="LineColor" 	value="#dddddd">
						<param name="ViewSummary" 	value="1">
						<param name="Format" 		value="
                            <FC> name=''            ID='{String(CURROW)}'        Width=25    align=center </FC>
			                <C> name='��SID'			ID='cust_sid'    align=left editlimit=12 show=false</C>
			                <C> name='�ѱۼ���'			ID='cust_nm'  width=80   align=left editlimit=30 show=true sort=true  Sumtext=@cnt</C>
			                <C> name='�ֹ�/���ǹ�ȣ'	ID='manage_no'  width=110 align=center editlimit=20 show=true sort=true  Sumtext='��'</C>
			                <C> name='�\\����'		ID='CONFIRM_YN'  width=50 align=center show=true </C>
			                <C> name='����\\����'		ID='STATUS_CD'  width=50 align=center show=true </C>
			                <C> name='�����'   		ID='company_nm' width=100 align=left editlimit=30 show=true</C>
			                <C> name='����'    			ID='positions' width=50  align=left editlimit=30 show=true</C>
			                <C> name='�޴���'    		ID='mobile_no' width=90  align=left editlimit=15 show=true</C>
			                <C> name='����SID'   		ID='upjang_sid'  align=left editlimit=12 show=false</C>
							<C> name='����'				ID='upjang_cd'	 width=60 align=center editlimit=10 show=true</C>
							<C> name='�����'			ID='upjang_nm'	width=110 align=left editlimit=50 show=true</C>			                
			                <C> name='��û����Ÿ��SID'  ID='a_room_type_sid'     align=left editlimit=12 show=false</C>
							<C> name='��û����Ÿ��'		ID='a_room_type_cd' width=80	 align=center editlimit=10 show=true</C>
							<C> name='��û����Ÿ�Ը�'	ID='a_room_type_nm'	width=90 align=left editlimit=50 show=true</C>			                
			                <C> name='����SID'      	ID='rsv_sid'     align=left editlimit=12 show=false</C>
			                <C> name='�Ǹž�'    		ID='a_sal_amt' width=70  align=right editlimit=33 show=true Value={Number(a_sal_amt)}</C>
			                <C> name='�Աݾ�'      		ID='pay_amt'   width=70  align=right editlimit=33 show=true Value={Number(pay_amt)}</C>
   			                <C> name='�������'      	ID='depart_date'   width=70  align=center show=true mask=XXXX-XX-XX</C>
			                <C> name='���ð�'      	ID='depart_time'   width=60  align=center show=true</C>			                			                
			                <C> name='ǥ�ذ�����'		ID='charge_rate'  width=70   align=right dec=0 show=true</C>			                			                			                
						">
					</object>
					<%=HDConstant.COMMENT_END%>
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