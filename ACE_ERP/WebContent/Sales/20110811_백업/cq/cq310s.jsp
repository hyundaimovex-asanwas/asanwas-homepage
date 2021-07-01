<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: UNC ������
 * ���α׷�ID 	: RV310S
 * J  S  P		: rv310s
 * �� �� ��		: Rv310S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-06
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-12-04][�ɵ���] ���� �˻�����
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sClass=" + drp_class.ValueOfIndex("class", drp_class.Index)
			          + ",sTeam=" + drp_teams.ValueOfIndex("teams", drp_teams.Index)
			          + ",sJobsel=" + sJobsel.value
			          + ",sCustNm=" + sCustNm.value;
			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq310S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
		
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
                    + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
        			+ "sDepartDate=" + sBgnDate.text + ","	            
        			+ "sGoodsSid=" + lc3.ValueOfIndex("goods_sid",lc3.Index);
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            v_param);
        tr_post(tr3);
	}	  

	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
        			  + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
                    + "sDepartDate=" + sBgnDate.text + ","	
                    + "sDepartTime=" + lc2.ValueOfIndex("depart_time", lc2.Index) + ","    
                    + "sGoodsSid=" + lc3.ValueOfIndex("goods_sid",lc3.Index) + ","    
                    + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            v_param);
        tr_post(tr4);
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
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for=lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	<script language=JavaScript for=lc3 event=OnSelChange()>
		if ( div != 'init' ) {	//��ǰ 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';				
			fnSelectDs7();		
		}
	</script>		
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
//	fnSelectDs6();
</script>


<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)"> 
	fnSelectDs6();
</script>



<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
</script>

<script language=JavaScript  for=ds9 event="OnLoadCompleted(row)">
	pr1.PreView();
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
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
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td width='695px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="70">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds2>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="70">�������</td>
	                    <td align=left bgcolor="#ffffff" width=160>&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
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
	                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle >
								<param name=ComboDataID		value=ds3>
								<param name=BindColumn      value="depart_time">
	                            <param name=BindColVal      value="depart_time">
								<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
								<param name=ListExprFormat  value="depart_time_nm^0^40">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=left class="text" width="60">��ǰ����</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds4>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^120"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
					</tr>
					<tr height='30px'>
				   <td align="center" width="70px" class="text">��/��</td>
		            <td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                <%=HDConstant.COMMENT_START%>
		                <object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
		                    <param name=ComboDataID     value=ds6>
		                    <param name=SearchColumn    value="class_nm">
		                    <param name=ListExprFormat  value="class_nm^0^100">
		                </object>
		                <object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=50 border="0" align=absmiddle>
		                    <param name=ComboDataID     value=ds7>
		                    <param name=SearchColumn    value="teams_nm">
		                    <param name=ListExprFormat  value="teams_nm^0^50">
		                </object>
		                <%=HDConstant.COMMENT_END%>
		                &nbsp;</nobr>
		            </td>
		            <td align=left class="text" width="70px">������</td>
		            <td align="left" bgcolor="#ffffff">&nbsp;
    					<select name="sJobsel">
							 <option value="">��ü</option>
							 <option value="1">������</option>
							 <option value="2">�����</option>
							 <option value="3">���������</option>
						</select>
					</td>
		            <td align=center class="text">����</td>
		            <td align="left" bgcolor="#ffffff">&nbsp;
						<input type="text" name=sCustNm value="" size=15 maxlength="15" class='textbox'>
					</td>
		        </tr>
				</table>
			
			</td>
			<td width='150px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='150'>
					<tr>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
							
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
					               <C> name='��������ȣ'      		ID='tour_no'     width=100 align=center editlimit=20 	show=true</C>						
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

