<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �԰� UNC ���
 * ���α׷�ID 	: CQ320S
 * �� �� ��		: �̺���
 * �� �� ��		: 2008-05-13
 * [��  ��   ��  ��][������] ����
 * [2008-05-13][�ɵ���] ����� ȭ�� �����Ͽ� ����..
 * [2009-07-08][�ɵ���] ��ǰ, �԰�ð� ��ȸ ���� �缳��
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 120);         
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
		// ������ �ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		} 

		//�ʱ�ȭ
		function fnInit() {
			sEndDate.text='<%=firstday%>';	
	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�
	        
		}
		// �������԰�ð� ��ȸ
		function fnSelectLcArTime() {
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            	  + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid")+","
		              + "sArriveDate=" + sEndDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_ARRIVE_TIME_DS=ds_ar_time)",
	            param);
	        tr_post(tr2);
		}	

		//��ǰ��ȸ
		function fnSelectLcGoods() {
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
					+ ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
					+ ",sDepartDate=";	//�԰����� �����̶� �н�
			ln_TRSetting(tr3, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr3);
		};


		// ���� ��ȸ
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sArriveDate=" + sEndDate.Text
			          + ",sArriveTime=" + lc_ar_time.ValueOfIndex("detail", lc_ar_time.Index)
					  + ",sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq320S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
	
		// ����
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:UNC ������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("UNC ������","UNC ������.xls", 8);
		}
		
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectLcGoods();
		fnSelectLcArTime();
	</script>	

	<script language=JavaScript for=sEndDate event=OnKillFocus()>
		if ( sEndDate.Modified ) {
			div = 'init';
			fnSelectLcArTime();			
		}
	</script>


<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �԰�ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ(��) -->
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td width='695px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
				  <tr height='24px'>
					<td align=left class="text" width="70">����</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																										
						<%=HDConstant.COMMENT_START%>
                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds_saup>
							<param name=BindColumn      value="saup_sid">
                            <param name=BindColVal      value="saup_sid">
							<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^100">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>	
					<td align=left class="text"  width="70">�԰�����</td>
                    <td align=left bgcolor="#ffffff" width=160>&nbsp;																							
						<%=HDConstant.COMMENT_START%>
						<object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
							<param name=Text 		value="">
							<param name=Alignment 	value=1>
							<param name=Format 		value="0000-00-00">
							<param name=Cursor	 	value="iBeam">
							<param name=Border	 	value="false">		
							<param name=InheritColor      value="true">																																																				
							<param name=ReadOnly  	value="false">
							<param name=SelectAll  	value="true">
							<param name=SelectAllOnClick  	value="true">		
							<param name=SelectAllOnClickAny  	value="false">																				
						</object>&nbsp;
                        <object id=lc_ar_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle >
							<param name=ComboDataID		value=ds_ar_time>
							<param name=BindColumn      value="detail">
                            <param name=BindColVal      value="detail">
							<param name=EditExprFormat	value="%,%;detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^40">
						</object>
						<%=HDConstant.COMMENT_END%>																				
					</td>
					<td align=left class="text" width="70">��ǰ(��)</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																										
						<%=HDConstant.COMMENT_START%>
                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds_goods>
                            <param name=SearchColumn        value="GOODS_NM">
                            <param name=Sort                value="false">
                            <param name=ListExprFormat      value="GOODS_NM^0^130">
                            <param name=BindColumn          value="GOODS_SID">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
				  </tr>
				  <tr height='24px'>
		            <td align=left class="text" width="70px">������</td>
		            <td align="left" bgcolor="#ffffff" colspan=5>&nbsp;
    					<select name="sJobsel">
							 <option value="0">��ü</option>
							 <option value="1">������</option>
							 <option value="2">�����</option>
							 <option value="3">���������</option>
						</select>
					</td>
				  </tr>
				</table>
		
			</td>
			<td width='150px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='150'>
					<tr>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
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
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=ViewSummary     value=1>
								<param name="Format" 			value="
								 <C> name='����'   		ID='{CURROW}'  width=50 align=center editlimit=62 	show=true SumText='�հ�'</C>
					               <C> name='�Ҽ�'   		ID='company_nm'  width=150 align=center editlimit=62 	show=true SumText=@count</C>
					               <C> name='��å'    		ID='positions'   width=100 align=center editlimit=62 	show=true</C>
					               <C> name='����'      		ID='cust_nm'     width=200 align=center editlimit=93 	show=true</C>
					               <C> name='����'  			ID='sex'         width=40 align=center editlimit=50 	show=true</C>
					               <C> name='�ֹε�Ϲ�ȣ'    ID='regi_no'     width=130 align=center editlimit=32 	show=true </C>
					               <C> name='�ּ�'     		ID='address1'    width=150 align=center editlimit=60 	show=true</C>
					               <C> name='CUST_SID'     	ID='cust_sid'    width=100 align=center editlimit=12 	show=false</C>
					               <C> name='CUST_GU'      	ID='cust_gu'     width=100 align=center editlimit=1 	show=false</C>
					               <C> name='COUNTRY_GU'   	ID='country_gu'  width=100 align=center editlimit=2 	show=false</C>
					               <C> name='COUNTRY_CD'   	ID='country_cd'  width=100 align=center editlimit=3 	show=false</C>
					               <C> name='���'  			ID='etc'         width=100 align=center editlimit=30 	show=true</C>
					               <C> name='ž������'       	ID='car_no'      width=100 align=center editlimit=54 	show=true</C>
					               <C> name='�������'     	ID='birthday'    width=100 align=center editlimit=10 	show=true</C>
					               <C> name='��'        		ID='class'       width=40 align=center editlimit=50 	show=true</C>
					               <C> name='��'        		ID='teams'       width=40 align=center editlimit=3 	show=true</C>
					               <C> name='��������ȣ'    ID='tour_no'     width=100 align=center editlimit=20 	show=true</C>
					               <C> name='�������'    ID='depart_date'     width=90 align=center editlimit=20 	show=true</C>
					               <C> name='��߻�ǰ'    ID='goods_nm'     width=90 align=center editlimit=20 	show=true</C>
					               <C> name='�԰�ð�'    ID='arrive_time'  width=60 align=center editlimit=20 	show=true</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>�� [��ǰ(��)] : ��� ����� ��ǰ�Դϴ�.<br>
			�� [������] : ����� = ������ ������ ��� ������Դϴ�.

			</td>
		</tr>		
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

