<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���¾�ü��ȸ
 * ���α׷�ID 	: CU050S
 * J  S  P		: cu050S
 * �� �� ��		: Cu050S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-16
 * �������	: ���¾�ü ����Ʈ ��ȸ
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
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			
			fnInit(); 
		} 
		 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu050S",
            	"JSP(O:S_USEYN=sCodeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
		
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050S",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
		}
			
		/*
		 * ����Ʈ
		 */
		function fnPrintDs1() {
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
		        getObjectFirst("gr1").SetExcelTitle(1, "value:���¾�ü�� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr1").GridToExcel("���¾�ü�� ��ȸ", "���¾�ü��  ��ȸ.xls", 8);
			
		}
		
		/*
		 * ���������
		 */
		 
		 function fnSalDamPopup(flag) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
				
			 	if (flag == "S") {
			 		sSal_dam_sid.value = arrParam[0];
			 		sSal_dam_nm.value = arrParam[2];
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = arrParam[0];
			 		sal_dam_nm.value = arrParam[2];
			 	}
			} else {
				if (flag == "S") {
			 		sSal_dam_sid.value = "";
			 		sSal_dam_nm.value = "";
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = "";
			 		sal_dam_nm.value = "";
			 	}
			}
		 }
		
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮�� ��ȸ -->
		<param name="SyncLoad" 	value="true">
	</object>
	
	
	
	<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='525px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height='30px' class='text'>���¾�ü</td>
						<td width='100px' height='30px' bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
							<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height='30px' class='text'>�����</td>
						<td width='120px' height='30px' bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
							<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="��������ڸ� �˻��մϴ�"  style="cursor:hand" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
						<td width='80px' height='30px' class='text'>�������</td>
						<td width='100px' height='30px' bgcolor='#FFFFFF'>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='300px'>
					<tr>
						<td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onclick="fnExcelDs1()">
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='447px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="SuppressOption"    value="1">
											<param name=FixSizing  value="false">
											<param name="Format" 			value="
										               <FC> name='���������'   	ID='sal_dam_nm'  	width=100  align=center editlimit=22 show=true suppress=1 (FixedColumn)</FC>
										               <FC> name='���¾�ü�ڵ�'   	ID='client_cd'   	width=100  align=center editlimit=5 show=true (FixedColumn)</FC>
										               <FC> name='�ŷ�ó�ڵ�'     	ID='vend_cd'     	width=100  align=right editlimit=13 show=true (FixedColumn)</FC>
										               <C> name='���¾�ü��'    	ID='client_nm'   	width=150  align=left editlimit=30 show=true</C>
										               <C> name='����'  			ID='dir_yn_name'   	width=40  align=center editlimit=50 show=true</C>
										               <C> name='����' 			ID='area_cd_name'   width=40  align=center editlimit=50 show=true</C>
										               <C> name='�븮�������'   	ID='client_dam_nm'  width=120  align=center editlimit=20 show=true</C>
										               <C> name='��ȭ��ȣ'       ID='tel_no'      	width=120  align=left editlimit=20 show=true</C>
										               <C> name='�޴��ȣ'    	ID='mobile_no'   	width=120  align=left editlimit=15 show=true</C>
										               <C> name='�ѽ���ȣ'       	ID='fax_no'      	width=120  align=left editlimit=20 show=true</C>
										               <C> name='�����ּ�'       	ID='e_mail'      	width=200  align=left editlimit=30 show=true</C>
										               <C> name='�������' 		ID='use_yn_name'    width=60  align=center editlimit=50 show=true</C>
										        	">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
   
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

