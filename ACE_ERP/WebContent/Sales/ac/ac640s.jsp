<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����������ǥ ��Ȳ
 * ���α׷�ID 	: AC640S
 * J  S  P		: ac640s
 * �� �� ��		: Ac640S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-27
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

			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			sSDate.Text = '<%=firstday%>';	
			fnInit();
		} 
		 
		function fnInit() {
			div = 'init';
	        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //�����ڵ�
	
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS=codeDs1,O:S_GOODS_DS=codeDs2)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		}
		//��ǰ��ȸ
			function fnSelectLcGoods() {
				window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
				var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				    + ",sSaupSid=" + lc1.ValueOfIndex("saup_sid", lc1.Index)
						+ ",sDepartDate=";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
				    "JSP(O:S_GOODS_DS=codeDs2)",
				    param);
				tr_post(tr1);
			};
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sGoods_sid=" + lc2.ValueOfIndex("goods_sid", lc2.Index)
		             + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sSalDamSid=" + sSalDamSid.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac640S",
			    "JSP(O:DS1=ds1)",
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:����������ǥ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����������ǥ","����������ǥ.xls", 8);
		}
    	
		/**
	     * �˻����� �븮��  �˾� 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }   
	 /*
	 * ��������� �˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup4() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];					
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';					
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
	<script language=JavaScript	for=saup_sid event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=lc1 event=OnSelChange()>
		fnSelectLcGoods();//��ǰ ��˻�
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
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border='0' cellpadding='0' cellspacing='0' width='845' bordercolor=orange>	
	<tr>
		<td width='845px'>
			<table  border='0' cellpadding='0' cellspacing='0' width='845'>
				<tr>
					<td>
						<table  border='0' cellpadding='0' cellspacing='0' width='545px'>
							<tr>
								<td>
									<table border='0' cellpadding='0' cellspacing='1' width='345' bgcolor="#666666">
										<tr>
											<td align=left width=70 class="text">&nbsp;���������</td>
		                        			<td align=left bgcolor="#ffffff" colspan="2">&nbsp;																										
												<input id="sSalDamSid" type="hidden" value="0">                                
												<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
												<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
											</td>
										</tr>
									</table>
								</td>
								<td align='right'>
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
	<tr height="5px">
		<td></td>
	</tr>
	<tr height="30px">
		<td width='845px'>
			<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
				<tr height='30px'>
					<td align=left class="text" width="60px">����</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																										
						<%=HDConstant.COMMENT_START%>
                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=codeDs1>
							<param name=BindColumn      value="saup_sid">
                            <param name=BindColVal      value="saup_sid">
							<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^120">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>	
					<td align="center" width="60px" height="30px" class="text" >�븮��</td>
					<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
                        <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
                        <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                        <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
					</td>
					<td align=left class="text"  width="60">�۾����</td>
                    <td align=left bgcolor="#ffffff">&nbsp;																							
						<%=HDConstant.COMMENT_START%>
						<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
							<param name=Text 		value="">
							<param name=Alignment 	value=1>
							<param name=Format 		value="0000-00">
							<param name=Cursor	 	value="iBeam">
							<param name=Border	 	value="false">		
							<param name=InheritColor      value="true">																																																				
							<param name=ReadOnly  	value="false">
							<param name=SelectAll  	value="true">
							<param name=SelectAllOnClick  	value="true">		
							<param name=SelectAllOnClickAny   value="false">

																										
						</object>
						<%=HDConstant.COMMENT_END%>																				
					</td>																							
					<td align=left class="text" width="80">��ǰ����</td>
                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
							<param name=ComboDataID		value=codeDs2>
							<param name=BindColumn      value="goods_sid">
                            <param name=BindColVal      value="goods_sid">
							<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
							<param name=ListExprFormat  value="goods_nm^0^140"></object>
						<%=HDConstant.COMMENT_END%>&nbsp;	
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
							 <param name="SuppressOption"    value="1">
							 <param name=ViewSummary     value=1>
							<param name="Format" 			value="
								<C> name='����ó�ڵ�'   	ID='client_cd'  	width=80 	align=left editlimit=61 show=false </C>
								<C> name='�븮��'   		ID='client_nm'  	width=100 	align=left editlimit=61 show=true suppress=1  SumText='�հ�'</C>
								<C> name='�������'   	ID='depart_date'  	width=80 	align=left editlimit=61 show=true suppress=2  mask='XXXX-XX-XX' </C>
								<C> name='��ǰ'   		ID='goods_nm'  		width=100 	align=left editlimit=61 show=true suppress=3 </C>
								<C> name='�ο�' 			ID='person_cnt'		width=50    align=right show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�����\\��'   		ID='tour_amt'  		width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�����������\\��'   	ID='subtract_amt'  	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�Աݾ�'   		ID='pay_amt'  		width=100 	align=right editlimit=61 show=true  SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='��������\\{���(��-��)}\\��100'   	ID='comm_rate'  	width=80 	align=right editlimit=61 show=true SumText=@avg SumTextAlign=right</C>
								<C> name='�������\\��'   	ID='comm_amt'  		width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�����ݾ�'   	ID='cont_amt'  		width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='���ޱݾ�'   	ID='sale_amt'  		width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�ΰ���'   		ID='tax_amt'  		width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<C> name='�հ��'   		ID='tot_amt'  		width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								
								
								       
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

