<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���� ������Ȳ (���Һ�)
 * ���α׷�ID 	: RV820S
 * J  S  P		: rv820s
 * �� �� ��		: Rv820S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-08
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-11-13][�ɵ���] ������ ��Ȳ ����
 *						�ݰ���� ���� �� ������ �޶� ����� �����ϴ� �׸��� ���� �����ȴ�
 *						���� �������� ��..�׸��� ������ �ٸ���.. ��..
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
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			fnInit();
		} 
		 
		function fnInit() {
			sJob_date.text='<%=firstday%>';	
		}
		
		
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var saupSid = 5;
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid=5"
			          + ",sJob_date=" + sJob_date.Text
			          + ",sClientSid=";
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0&&ds2.RowCount==0&&ds3.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
			
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").SetExcelTitle(1, "value:PLZ ���� ������Ȳ(���Һ�) ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr3").GridToExcel("PLZ���� ������Ȳ(���Һ�)","PLZ ���� ������Ȳ(���Һ�).xls", 8);
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
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- PLZ �׸���  -->
	<param name="SyncLoad" 	value="true">
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
		
		<tr height="30px">
			<td width='545px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text"  width="70">�۾����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">																					
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>
					 	</td>
					</tr>
				</table>
			</td>
			<td width='200'>
				<table   border='0' cellpadding='0' cellspacing='0' width='200'>
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
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds3">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              	<FC> name='������'    	ID='RSV_CLOSE_DATE' width=60 align=left 	editlimit=5 show=true		suppress=1</FC>
						              	<FC> name='�����'    	ID='DEPART_DATE'   	width=60 align=left 	editlimit=50 show=true		suppress=2</FC>
   						             	<FC> name='��ǰ'    		ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='��¼���'    	ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='�հ�'    	ID='U_TT'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='����(��õ)'    	ID='U_1001'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�籸(ȣ�ڱ�)'    	ID='U_YGH'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�籸(��Ǳ�)'    	ID='U_YGP'   		width=90 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   						              	
										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
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

			</td>
		</tr>
	</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

