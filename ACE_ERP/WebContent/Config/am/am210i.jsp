<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���������_HISTORY
 * ���α׷�ID 	: am210i
 * J  S  P		: am210i
 * �� �� ��		: AM210I
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-01-10
 * [��  ��   ��  ��][������] ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
%>
<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
<script language="javascript">
	 var v_job='';
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		fnInit();
	} 
	function fnInit() {
	ds_send_status_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=IT001";
    ds_send_status_cd.Reset();//�������� ����
    ds_receive_status_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=IT001";
    ds_receive_status_cd.Reset();//��������� ����
	}
	
	/*
	 * ���� ��ȸ
	 */
	function fnSelect() {
		v_job = "S";
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		        	+ ",sItem_cd="+ sItem_cd.value
		          	+ ",sItem_nm=" + sItem_nm.value
		          	+ ",sModel_nm=" + sModel_nm.value;

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%> Am210I",
		    "JSP(O:DS1=ds1)",
		    param);
		   
		tr_post(tr1);
	}
		
	/*
	* �ο� �˾� : ���� ����� ��ȸ
	*/
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"send_empnmk") = arrParam[2];
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "send_empno") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"send_empnmk") = "";
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = "";
			ds1.namevalue(ds1.rowposition,"send_empno") = "";
   		}				
	}
	/*
	* �ο� �˾� : ���� ����� ��ȸ
	*/
	function fnCustPopup2() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"receive_empnmk") = arrParam[2];
	   		ds1.namevalue(ds1.rowposition, "receive_deptnm") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "receive_empno") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"receive_empnmk") = "";
	   		ds1.namevalue(ds1.rowposition, "receive_deptnm") = "";
			ds1.namevalue(ds1.rowposition,"receive_empno") = "";
   		}				
	}			 	 			 	 
	/*
	 * ����
	 */
	function fnExcelDs1() {
		if(ds1.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        } 
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:���������_HISTORY; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("���������","���������_HISTORY.xls", 8);
	}

	//����
	function fnApply() {
		if ( ds1.isUpdated ) {
            v_job = "I";
            window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
            
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%> Am210I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
         } else {
         	alert("������Ʈ�� ���� �����ϴ�.");
		 }
	}	
	//���
	function fnCancel(){
		if(ds1.IsUpdated){
			ds1.undoall();
			v_job=""; //��Ҵ����� ���� �ʱ�ȭ
		}
		window.status="������_HISTORY �۾��� ��ҵǾ����ϴ�.";
		return;
	}
</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		if(v_job=="I"){
			fnSelect();
		};
	</script>	
	<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="send_empnmk") {
			fnCustPopup();
		}
		if (colid=="receive_empnmk") {
			fnCustPopup2();
		}
		
	</script>        
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_send_status_cd classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_receive_status_cd classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' bgcolor='#666666'>
								<tr>
									<td width='70px' height="30px" class='text'>������ȣ</td>
									<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='hidden'  	name='sItem_sid' 		value='' maxlength='20' 	size='10' 	class='textbox'>
										<input type='text' 			name='sItem_cd' 		value='' maxlength='20' 	size='10' 	class='textbox'>
									</td>
									<td width='70px' 	height="30px" class='text'>ǰ��</td>
									<td width='100px' 	height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='text'  	name='sItem_nm' 		value='' maxlength='20' 	size='10' 	class='textbox'>
									</td>
									<td width='70px' height="30px" class='text'>�� ��</td>
									<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
										<input type='text'  	name='sModel_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  		style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 			<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/save.gif" 		style="cursor:hand" align=absmiddle onClick="fnApply();">			<!-- ���� -->
				                        <img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle onclick="fnCancel()">			<!-- ��� -->
				                        <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="True">
								<param name="BorderStyle"	value="0">
								<Param Name="AllShowEdit"   value="True">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name=ViewSummary     value=1>
								<param name="Format" 		value="
									
									<C> name='������ȣ'   	ID='item_cd'  	width=66 	align=center edit=none show=true </C>
									<C> name='ǰ��'   		ID='item_nm'  	width=60 	align=left show=true   edit=none</C>
									<C> name='�𵨸�'   	ID='model_nm'  	width=80 	align=left show=true   edit=none</C>
									<C> name='���' 			ID='send_empno'  	width=55 	align=center  show=true  edit=none BgColor=pink editlimit=61 </C>
									<C> name='�μ�'   		ID='send_deptnm'	width=90 	align=left  show=true  edit=none BgColor=pink editlimit=61 </C>
									<C> name='����\\�����'   		ID='send_empnmk'  		width=70 	align=center  editlimit=61 editstyle=popup show=true  Edit=any BgColor=pink editlimit=61 </C>
									<C> name='��������\\(���º���)'   		ID='send_status_cd'  		width=70 	align=center  show=true  EditStyle=Lookup  editlimit=61 Data='ds_send_status_cd:detail:detail_nm' BgColor=pink</C>
									<C> name='���' 			ID='receive_empno'  	width=55 	align=center  show=true  edit=none BgColor=#D7FFDA editlimit=61 </C>
									<C> name='�μ�'   		ID='receive_deptnm'	width=90 	align=left  show=true  edit=none BgColor=#D7FFDA editlimit=61 </C>
									<C> name='����\\�����'   		ID='receive_empnmk'  		width=70 	align=center  show=true   editstyle=popup Edit=any BgColor=#D7FFDA editlimit=61 </C>
									<C> name='���������\\(���º���)'   		ID='receive_status_cd'  		width=70 	align=center  show=true   editlimit=61 EditStyle=Lookup Data='ds_receive_status_cd:detail:detail_nm' BgColor=#D7FFDA</C>
									<C> name='���'   		ID='remarks'  	width=150 	align=left show=true   editlimit=200</C>
								">
							</object>
										<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
					<br>
					��   �۾�����<br>
					1. "�̵�/���� �� ������"�� ��ȸ�մϴ�.<br>
					2. [��������]���� [������] ��ư�� ���� "���� �����"�� �����մϴ�.<br>
					3. [��������(���º���)]���� ������ ���¸� �����մϴ�. <br>
					4. [���������]���� [������] ��ư�� ���� "���� �����"�� �����մϴ�.<br>
					5. [���������(���º���)]���� ������ ���¸� �����մϴ�. <br>
					6. [����] ��ư�� ������ ������_HISTORY ���泻���� ����˴ϴ�.<br>
					<br>
					�� �ű����� �� ��쿡�� ��������ڸ� �����Ͻ� ��, �����մϴ�.<br>
					�� �н�/��� �� ��쿡�� �������ڸ� �����Ͻ� ��, �����մϴ�. <br>
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
        <param name="DataId" value="ds1">
        <param name=BindInfo    value="
            <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
            <C>Col=accept_no                Ctrl=accept_no          Param=Text </C>
            <C>Col=accept_date              Ctrl=accept_date        Param=Text </C>
            <C>Col=goods_sid              Ctrl=v_goods        Param=BindColVal </C>
            <C>Col=depart_date              Ctrl=depart_date        Param=Text </C>
        ">
</object>
<%=HDConstant.COMMENT_END%>	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

