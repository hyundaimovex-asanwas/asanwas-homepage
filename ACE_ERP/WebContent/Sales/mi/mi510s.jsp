<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���� �ܱ��� ��������Ȳ
 * ���α׷�ID 	: MI510S
 * J  S  P		: MI510S
 * �� �� ��		: MI510S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-08-21
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-11-24][�ڰ汹] �˻����� �߰�[����]
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
			sJob_yyyy.Text = '<%=firstday%>';	
			fnInit();
			
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds2.Reset(); //�����ڵ�
			codeDs1.deleteRow(2);
			sCountry_gu.Index = 0;
		} 
		 
		function fnInit() {
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:COUNTRY=codeDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			         + ",sJob_yyyy="	+ sJob_yyyy.Text
			         + ",sCountry_gu="  + sCountry_gu.ValueOfIndex("detail", sCountry_gu.Index)
			         + ",sSaupSid="		+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			            
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_MI%>Mi510S",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:���� �ܱ��� ��������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("���� �ܱ��� ��������Ȳ","���� �ܱ��� ��������Ȳ.xls", 8);
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
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �������� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>><!-- ����  -->
		    <param name="SyncLoad"  value=false>
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
									<td align=left class="text"  width="80">�۾��⵵</td>
									<td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sJob_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="true">		
											<param name=SelectAllOnClickAny value="false">
										</object>
										<%=HDConstant.COMMENT_END%>																				
									</td>			
									<td align=left width=70 class="text">&nbsp; �� ��</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;																										
  											<%=HDConstant.COMMENT_START%>
					                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds2>
												<param name=BindColumn      value="saup_sid">
                                                <param name=BindColVal      value="saup_sid">
												<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
												<param name=ListExprFormat  value="saup_nm^0^120"></object>
											<%=HDConstant.COMMENT_END%>
									</td>
									<td align=left class="text" width="80px" >��������</td>
									<td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
									    <object id=sCountry_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs1>
											<param name=BindColumn      value="detail">
									        <param name=BindColVal      value="detail">
											<param name=EditExprFormat	value="%,%;detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^120">
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
									
									<C> name='����'   		ID='{CURROW}'  	width=50 	align=center editlimit=61 show=true  sumText='�հ�'</C>
									<C> name='����'   		ID='COUNTRY_NM'  	width=100 	align=right editlimit=61 show=true </C>
									
									<G> name='�Ѱ�'
										<C> name='��'   		ID='QTY_TTM'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_TTF'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_TT'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='1��'
										<C> name='��'   		ID='QTY_01M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_01F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_01'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='2��'
										<C> name='��'   		ID='QTY_02M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_02F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_02'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='3��'
										<C> name='��'   		ID='QTY_03M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_03F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_03'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='4��'
										<C> name='��'   		ID='QTY_04M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_04F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_04'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='5��'
										<C> name='��'   		ID='QTY_05M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_05F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_05'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='6��'
										<C> name='��'   		ID='QTY_06M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_06F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_06'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='7��'
										<C> name='��'   		ID='QTY_07M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_07F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_07'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='8��'
										<C> name='��'   		ID='QTY_08M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_08F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_08'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='9��'	
										<C> name='��'   		ID='QTY_09M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_09F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_09'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='10��'
										<C> name='��'   		ID='QTY_10M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_10F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_10'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='11��'
										<C> name='��'   		ID='QTY_11M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_11F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_11'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<G> name='12��'
										<C> name='��'   		ID='QTY_12M'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_12F'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
										<C> name='��'   		ID='QTY_12'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>
									</G>
									<C> name='��'   		ID='QTY_TT'  	width=50 	align=right editlimit=61 show=true sumText=@sum</C>

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

