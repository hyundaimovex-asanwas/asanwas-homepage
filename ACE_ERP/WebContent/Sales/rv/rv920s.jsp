<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����Ȯ�����_PLZ
 * ���α׷�ID 	: RV810S_N
 * J  S  P		: rv810s_n
 * �� �� ��		: Rv810S_N
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-06
 * [��  ��   ��  ��][������] ����
 * [2009-12-24][�ɵ���] ���Ǹž� �� ������� + �ɼǿ������ �и�~
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
		 var div='';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
			div = 'init';
	        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //�����ڵ�	        
		}
		
		/*
		 * ���ð�, ��ǰ��ȸ
		 */		
		function fnSelectDs3() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
	            param);
	        tr_post(tr2);
		}	
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"	
			          + ",sGcd=" + sGcd.value
			          + ",sCust_gubn=" + sCust_gubn.value
			          + ",sOpt=" + sOpt.value	;
				ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv920S",
			    "JSP(O:DS_MAIN=ds_main)",
			    param);
			tr_post(tr1);
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:����Ȯ�����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����Ȯ�����","����Ȯ�����.xls", 8);
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
	
	<script language=JavaScript	for=v_accept_no event="OnKillFocus()">
		fnSelectBound();
	</script>
	
	 <script language=JavaScript  for=ds_bound event="OnLoadCompleted(row)">
 		ds_bound.insertrow(1);
 		
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_SEQ") = "0";
		ds_bound.namevalue(ds_bound.rowposition, "BOUND_NM") = "��ü";
		
		v_bound.Index = 0; 
    </script>
    
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( sBgnDate.Modified ) {
//				div = 'init';
				fnSelectDs3();			
		}
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
//		if ( div != 'init' ) {	//����
//			div = 'init';			
			fnSelectDs3();
//		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
//		if ( div != 'init' ) {	//���ð�
//			div = 'init';					
//		}
	</script>		
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
			fnSelectDs3();
	</script>
	
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		div = "";		
	</script>	


	
	<script language=javascript for="gr1" event="OnDblClick(Row, Colid)">
		//����Ŭ�� >> �˾�ȣ��
	    if(Row==0) return;
	    popConfirm(ds1.namevalue(Row, "RSV_SID"));
	</script>

<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_bound classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ���� -->
    <param name="SyncLoad"  value="True">
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

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td align=left>
				<table  border="0" cellpadding="0" cellspacing="0" width="845px">
					<tr>
						<td style="padding-bottom:6px"><img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=right onClick="fnExcelDs1()">		<!-- ���� -->
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=right onclick="fnSelect()"> 		<!-- ��ȸ -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td align=left>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text"  width="80">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
		    				<select name="sGcd"> 
			    				<option value="0" SELECTED>��ü</option>
								<option value="2">1����</option>
								<option value="3">2����</option>
							</select>
						</td>																							
						<td align=left class="text" width="80px">�ش�о�</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
		    				<select name="sCust_gubn"> 
			    				<option value="0" SELECTED>��ü</option>
			    				<option value="1">�Ŀ���ΰ�</option>
								<option value="2">�ؾ�/���� �ι� ������</option>
								<option value="3">SNS �����</option>
							</select>
							
						</td>	
						<td align=left class="text" width="80">��������</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<select name="sOpt">
								<option value="00" SELECTED>��ü</option>
								<option value="01" >1. 4�� ����/��õ ���� ����</option>
								<option value="02" >2. 4�� ���� ���� ����</option>
								<option value="03" >3. 5�� ����/��õ ���� ����</option>
								<option value="04" >4. 5�� ���� ���� ����</option>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td>
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width:98%; height:370px ;" border="1">
					<param name="DataID"		value="ds_main">
					<param name="ColSizing"		value="true">
					<param name="Fillarea"		value="false">
					<param name="Editable"		value="false">
					<param name="BorderStyle"	value="0">
					<param name=SortView  		value="Left">
					<param name="SuppressOption"    value="1">
					<param name="ViewSummary"       value="1">
					<param name="Format" 			value="
			              <C> name='������ȣ'  		ID='evd_sid'  	width=70 	align=right show=true sumtext='��'</C>
			              <C> name='�ش�о�'   	ID='cust_gubn'  width=140 	align=left show=true sumtext=@cnt</C>
			              <C> name='��α�/SNS�ּ�' ID='blog_addr'  width=150	align=left show=true suppress=1 sumtext='��'</C>
			              <C> name='���౸��'     	ID='join_gubn'  width=70 	align=center show=true</C>
			              <C> name='�̸�'    		ID='cust_nm'   	width=60 	align=center show=true</C>
			              <C> name='�������'      	ID='cust_bday'  width=70 	align=center show=true</C>
			              <C> name='�ڵ���'    		ID='cust_mob'   width=100 	align=center show=true</C>
			              <C> name='��������' 		ID='opt_0731' 	width=160 	align=left show=true</C>
			              <C> name='�����Ͻ�' 		ID='I_DATE' 	width=130 	align=center show=true</C>
            		">
				</object>   
			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

