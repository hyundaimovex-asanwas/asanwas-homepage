<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����� : �̰���-���� ��û�� ����� ��ȸ
 * ���α׷�ID 	: my400i
 * J  S  P		: my400i
 * �� �� ��		: My400I
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2010-08-20
 * [ �������� ][������] ����
 * [2010-08-30][�ɵ���] ����κ� + �󼼺κ�(������+������)
 *						���ȭ�� Ȯ ������� ������ �ƴϸ� ������ ��ĥ ������..
 * [2010-09-08][�ɵ���] help/my400h �����ؼ� ��ȸ�������� ���. ������ ���� ������
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���ڰ��� - ���� ��û ������������������������������������������������������������������������������������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
		
			// ������ �ε�
			function fnOnLoad(tree_idx){
				fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
				
		        cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		        cfStyleGrid(getObjectFirst("gr_apline"), "comn");
				fnSelect();
				
/*				var strParam = new Array();
				strParam=window.dialogArguments;
			
				if(strParam[0]!=null) { //room �ڵ� ����
					txt_room_type_cd.value=strParam[0];
				}else {
				}
				if(strParam[1]!=null) { //room �̸� ����
					txt_room_type_nm.value=strParam[1];
				}else {
				}
				if(strParam[2]!=null) { //������ ����
					upjangsid.value=strParam[2];
				}else {
				}*/
			}

		// ���� ��ȸ
		function fnSelect() {
				
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",dsType=1"
			          + ",s_ap_m_sid=<%=v_ap_m_sid%>"
			          + ",s_ap_gu=1"; //
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_HELP%>My400H",
	             "JSP(O:AP_MASTER_DS=ds_ap_master,O:AP_DETAIL_DS=ds_ap_detail,O:AP_LINE_DS=ds_ap_line)",
	             param);
	         tr_post(tr1);
		}
			
		function fnAdd() {
			var row = ds1.rowposition;
		
			window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
							 	 ds1.namevalue(row, "room_type_cd") + ";" + 
							 	 ds1.namevalue(row, "room_type_nm") + ";" +
							 	 ds1.namevalue(row, "upjang_sid") + ";" +
							 	 ds1.namevalue(row, "upjang_nm") + ";" +
							 	 ds1.namevalue(row, "std_persons");								 	 
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
			fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			fnHideLoading();
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			fnHideLoading();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "room_type_sid") + ";" +
								 ds1.namevalue(row, "room_type_cd") + ";" + 
								 ds1.namevalue(row, "room_type_nm") + ";" +
							 	 ds1.namevalue(row, "upjang_sid") + ";" +
							 	 ds1.namevalue(row, "upjang_nm") + ";" +
							 	 ds1.namevalue(row, "std_persons");		
			window.close();
		</script>
		
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
            if (keycode == 13) {
            	fnAdd();
            }
		</script>	
<!-----------------------------------------------------------------------------
	DataSet Components ���� 
	# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>
<object id="ds_ap_master" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds_ap_detail" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds_ap_line" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>
<object id="ds2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>	
<%=HDConstant.COMMENT_END%>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width='845'>	
	<tr>
		<td width='845px'>

			<table border="0" cellpadding="0" cellspacing="0" width=700 align=center>
			  <tr>
				<td><img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnAdd()">
				    <img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:8px;top:0px;cursor:hand;" onClick="fnClose()">                          
				</td>
			  </tr>
			</table>

			
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�⺻����</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>

		<table width="700px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">������ȣ</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="req_no" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="status_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û�Ͻ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="accept_datetime" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�븮�������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="client_dam_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">����ó</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="mobile_no" type="text" class="textbox2"  style="height:19px" size="18" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�븮����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="client_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����Ͻ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="depart_datetime" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��û����ȣ</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="accept_no" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��ǰ��</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="goods_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>

			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="cust_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">�ֹ�/���ǹ�ȣ</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="manage_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;<input id="company_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>

			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��û�ǰ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;<input id="reason" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">�����ǰ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;<input id="desc" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>

		</table>

	
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�����׸�</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='200px' border='1'>
		<param name="DataID"            value="ds_ap_detail">
		<param name="ColSizing"         value="true">
		<param name="Editable"          value="false">
		<param name="SuppressOption"    value="1">
		<param name="BorderStyle"       value="0">
		<param name=UsingOneClick       value="1">
		<Param Name="AllShowEdit"       value="True">
		<param name="ViewSummary"       value="1">
		<param name="Format"            value="
			<C> name='RSV_SID'		ID='RSV_SID'       	width=40 align=right Edit=None DEC=0 show=false</C>
			<C> name='�̿�����'  	ID='USE_DATE'     	width=70 align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX suppress=1</C>
			<C> name='������'     	ID='UPJANG_NM'      width=70 align=left   suppress=2</C>
			<C> name='�׸�'       	ID='MENU_NM'   		width=120 align=left  suppress=3 SumText='�ѡ���'</C>
			<C> name='ȸ��' 		ID='USE_SEQ'      	width=40 align=center dec=0 suppress=4</C>
			<C> name='�ܰ�'     	ID='UNIT_AMT'       width=40 align=right dec=0</C>
			<C> name='��ȭ'    		ID='CURRENCY_CD'  	width=40 align=center </C>
			<C> name='ȯ��'	      	ID='EXCH_AMT'       width=40 align=center DEC=0</C>
			<C> name='����'       	ID='SALE_QTY'       width=40 align=right DEC=0</C>
			<C> name='�հ�(��)' 	ID='SUM_AMT'   		width=70 align=right decao=0 Sumtext=@sum</C>
			<C> name='�������'   	ID='REMARKS'        width=150 align=left </C>
		">
		</object>
		<%=HDConstant.COMMENT_END%>

	</td>
  </tr>
</table>


<!-- ���� / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">���缱</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=700>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='100px' border='1'>
			<param name="DataID"		value="ds_ap_line">
			<param name="ColSizing"		value="true">
			<param name="Fillarea"		value="false">
			<param name="Editable"		value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
              <C> name='����SID'    ID='ap_m_sid'   	width=80	align=left editlimit=5 show=FALSE edit=none</C>
			  <C> name='����'     	ID='ap_type_nm'		width=60	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID='empnmk'		   	width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='����'		ID='paygrd'   		width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID='deptnm'		   	width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID='ap_status_d_nm'	width=70 	align=center editlimit=30 show=true edit=none</C>
              <C> name='�ǰ�'	    ID='ap_desc'   		width=189	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID='u_date'			width=120 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>




	</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
		<param name="DataId" value="ds_ap_master">           
		<param name=BindInfo	value="                                                
        <C>Col=req_no           		Ctrl=req_no             	Param=value </C>
        <C>Col=status_nm	       		Ctrl=status_nm          	Param=value </C>    
        <C>Col=accept_datetime     		Ctrl=accept_datetime       	Param=value </C>
        <C>Col=client_dam_nm       		Ctrl=client_dam_nm         	Param=value </C>
        <C>Col=mobile_no        		Ctrl=mobile_no          	Param=value </C>    
        <C>Col=client_nm        		Ctrl=client_nm          	Param=value </C>    
        <C>Col=depart_datetime     		Ctrl=depart_datetime       	Param=value </C>
        <C>Col=accept_no        		Ctrl=accept_no          	Param=value </C>
        <C>Col=goods_nm         		Ctrl=goods_nm           	Param=value </C>    
        <C>Col=cust_nm          		Ctrl=cust_nm            	Param=value </C>
        <C>Col=manage_no	    		Ctrl=manage_no          	Param=value </C>    
        <C>Col=company_nm       		Ctrl=company_nm         	Param=value </C>
        <C>Col=reason           		Ctrl=reason             	Param=value </C>
        <C>Col=desc             		Ctrl=desc               	Param=value </C>    
		">
	</object>
<%=HDConstant.COMMENT_END%>      
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

