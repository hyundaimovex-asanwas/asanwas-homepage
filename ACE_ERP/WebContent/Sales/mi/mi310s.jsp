<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ ���� ���ɺ�
 * ���α׷�ID 	: MI310S
 * J  S  P		: MI310S
 * �� �� ��		: MI310S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-08-21
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
			sFr_Depart_Date.Text = '<%=firstday%>';	
			sTo_Depart_Date.Text = '<%=firstday%>';	
			fnInit();
			
			codeDs1.insertRow(1);
			codeDs1.namevalue(1,"saup_sid") = '';
			codeDs1.namevalue(1,"saup_nm") = '��ü';
			
			sSaup_Sid.Index = 0;
			
		} 
		 
		function fnInit() {
		
			codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //�����ڵ�
	        
	        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
	        ds_cust_gu.Reset(); 
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			         + ",sSaup_Sid="+ sSaup_Sid.ValueOfIndex("saup_sid", sSaup_Sid.Index)
			         + ",sFr_Depart_Date=" + sFr_Depart_Date.Text
			         + ",sTo_Depart_Date=" + sTo_Depart_Date.Text
			         + ",v_cust_gu="+v_cust.ValueOfIndex ("DETAIL", v_cust.Index);

			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_MI%>Mi310S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.countrow==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������ ���� ���ɺ�; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("������ ���� ���ɺ�","������ ���� ���ɺ�.xls", 8);
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
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td bgcolor="#ffffff">
							<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
								<tr>
									<td align=left class="text" width="80px" >����</td>
									<td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
									    <object id=sSaup_Sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs1>
											<param name=BindColumn      value="saup_sid">
									        <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^120">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
											
									<td align=left class="text"  width="80">�������</td>
									<td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sFr_Depart_Date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 		value="">
											<param name=Alignment 	value=1>
											<param name=Format 		value="0000-00-00">
											<param name=Cursor	 	value="iBeam">
											<param name=Border	 	value="false">		
											<param name=InheritColor      value="true">																																																				
											<param name=ReadOnly  	value="false">
											<param name=SelectAll  	value="true">
											<param name=SelectAllOnClick  	value="true">		
											<param name=SelectAllOnClickAny   value="false">
										</object>~
									   	<object id=sTo_Depart_Date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 		value="">
											<param name=Alignment 	value=1>
											<param name=Format 		value="0000-00-00">
											<param name=Cursor	 	value="iBeam">
											<param name=Border	 	value="false">		
											<param name=InheritColor      value="true">																																																				
											<param name=ReadOnly  	value="false">
											<param name=SelectAll  	value="true">
											<param name=SelectAllOnClick  	value="true">	
											<param name=SelectAllOnClickAny   value="false">
										</object>&nbsp;
										<%=HDConstant.COMMENT_END%>																				
									</td>
	                                <td width="100px" height="25px" class="text">������</td>
	                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
	                                    <object id=v_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
	                                        <param name=ComboDataID     value=ds_cust_gu>
	                                        <param name=ListExprFormat  value="detail_nm^0^100">
	                                    </object>
	                                    <%=HDConstant.COMMENT_END%>
	                                </td>

								</tr>
							</table>
						</td>
						
						<td bgcolor="#ffffff">
							<table  border='0' cellpadding='0' cellspacing='0' width='200'>
								<tr>
									<td bgcolor="#ffffff">
										<table  border='0' cellpadding='0' cellspacing='0' width='200px' bgcolor="#ffffff">
											<tr>
												<td align='right' bgcolor="#ffffff">
													<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
													<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
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
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='300px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								 <param name=ViewSummary     value=1>
								<param name="Format" 			value="
									
									<C> name='����'   		ID='AREA_NM'  	width=80 	align=center editlimit=61 show=true sumText='�հ�' </C>
									<G> name='����'
									<C> name='��'   			ID='QTY_M'  	width=50 	align=right editlimit=61 show=true sumText=@sum </C>
									<C> name='��'   			ID='QTY_F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='���ɺ�'
									<C> name='10���̸�'   	ID='QTY_00'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='10��'   		ID='QTY_10'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='20��'   		ID='QTY_20'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='30��'   		ID='QTY_30'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='40��'   		ID='QTY_40'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='50��'   		ID='QTY_50'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='60��'   		ID='QTY_60'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									<C> name='70�� �̻�'   	ID='QTY_70'  	width=80 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
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

