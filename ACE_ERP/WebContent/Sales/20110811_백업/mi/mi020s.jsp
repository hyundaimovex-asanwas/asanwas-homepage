<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ ������ȸ
 * ���α׷�ID 	: MI020S
 * J  S  P		: Mi020s
 * �� �� ��		: Mi020S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-08-18
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
			fnInit2();
			
			codeDs1.insertRow(1);
			codeDs1.namevalue(1,"saup_sid") = '';
			codeDs1.namevalue(1,"saup_nm") = '��ü';
			
			codeDs3.insertRow(1);
			codeDs3.namevalue(1,"detail") = '';
			codeDs3.namevalue(1,"detail_nm") = '��ü';

			codeDs5.insertRow(1);
			codeDs5.namevalue(1,"detail") = '';
			codeDs5.namevalue(1,"detail_nm") = '��ü';

			codeDs7.insertRow(1);
			codeDs7.namevalue(1,"detail") = '';
			codeDs7.namevalue(1,"detail_nm") = '��ü';

			
			codeDs8.insertRow(1);
			codeDs8.namevalue(1,"detail") = '';
			codeDs8.namevalue(1,"detail_nm") = '��ü';			
			
			sSaup_Sid.Index = 0;
			sSex.Index = 0;
			sJob_Cd.Index = 0;
			sSaup_Gu.Index = 0;
			sCountry_Gu.Index = 0;
			
		} 
		 
		function fnInit() {
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_GOODS_DS=codeDs2, O:CU021=codeDs4, O:SY006=codeDs9)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			codeDs1.Reset(); //�����ڵ�
		}
		
		// ���������� ����� �ڵ带 ����ϱ� ���ظ��� 
		function fnInit2() {
			ln_TRSetting(tr2, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
            	"JSP(O:CUSTALL=codeDs6, " + // ������
					"O:NATION=codeDs8, " + // ��������
					"O:SEX=codeDs3, " + // ����
					"O:SAUP=codeDs7, " + // �������
					"O:CU020=codeDs5)",  // ���� 
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
       		 tr_post(tr2);
		}
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_Sid="+ sSaup_Sid.ValueOfIndex("saup_sid", sSaup_Sid.Index)
			         + ",sFr_Depart_Date=" + sFr_Depart_Date.Text
			          + ",sTo_Depart_Date=" + sTo_Depart_Date.Text
			         
			          + ",sGoods_Sid=" + sGoods_Sid.ValueOfIndex("goods_sid", sGoods_Sid.Index)
			           + ",sNorth_Cnt=" + sNorth_Cnt.Text
			           + ",sCust_Nm=" + sCust_Nm.value
			            + ",sManage_No=" + sManage_No.value
			            + ",sSex=" + sSex.ValueOfIndex("detail", sSex.Index)
			            + ",sAge_Cd=" + sAge_Cd.ValueOfIndex("detail", sAge_Cd.Index)
			            + ",sJob_Cd=" + sJob_Cd.ValueOfIndex("detail", sJob_Cd.Index)
			            + ",sCust_Gu=" + sCust_Gu.ValueOfIndex("detail", sCust_Gu.Index)
			            + ",sSaup_Gu=" + sSaup_Gu.ValueOfIndex("detail", sSaup_Gu.Index)
			            + ",sCountry_Gu=" + sCountry_Gu.ValueOfIndex("detail", sCountry_Gu.Index)
			            + ",sArea_Cd=" + sArea_Cd.ValueOfIndex("detail", sArea_Cd.Index)
			            + ",sCountry_Cd=" + sCountry_Cd.value;
			            
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_MI%>Mi020S",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		//��ǰ��ȸ
		function fnSelectLcGoods() {
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
			    + ",sSaupSid=" + sSaup_Sid.ValueOfIndex("saup_sid", sSaup_Sid.Index)
				+ ",sDepartDate=";
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=codeDs2)",
			    param);
			tr_post(tr2);
		};
		
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:������������ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("������������ȸ","������������ȸ.xls", 8);
		}
    	
	
	   /**
     * �����ڵ� �˾�
     */
    function fnCountryPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "����";
        arrResult = showModalDialog(strURL,arrParam,strPos);    

        if (arrResult != null) {
            arrParam = arrResult.split(";");
            
            sCountry_Cd.value = arrParam[1];
             sCountry_Nm.value = arrParam[2];
        
        } else {
          sCountry_Cd.value = "";
          sCountry_Nm.value = "";
        }
        return ;    
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
	<script language=JavaScript	for=codeDs1 event="OnLoadCompleted(row)">
		fnSelectLcGoods();
	</script>
	<script language=JavaScript for=sSaup_Sid event=OnSelChange()>
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
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs8 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs9 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����ڵ� -->
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
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
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
				<table border='0' cellpadding='0' cellspacing='0' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td bgcolor="#ffffff">
							<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
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
								</tr>
							</table>
						</td>
					</tr>
					<tr height='30px'>
						<td bgcolor="#ffffff">
							<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
								<tr>
									<td align=left class="text" width="80">��ǰ</td>
									<td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
									    <object id=sGoods_Sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs2>
											<param name=BindColumn      value="goods_sid">
									        <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^140"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
															
									<td align=left class="text" width="80">�湮Ƚ��</td>
									<td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										<object id=sNorth_Cnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
											<param name=Text 		value="">
											<param name=Alignment 	value=1>
											<param name=Format 		value="000000">
											<param name=Cursor	 	value="iBeam">
											<param name=Border	 	value="false">		
											<param name=InheritColor      value="true">																																																				
											<param name=ReadOnly  	value="false">
											<param name=SelectAll  	value="true">
											<param name=SelectAllOnClick  	value="true">		
											<param name=SelectAllOnClickAny   value="false">
										</object>
									</td>
									<td align="center" width="80px" class="text">����</td>
									<td align="center" bgcolor="#ffffff">
										<input type="text" name="sCust_Nm" ID="sCust_nm" value="" size="15" maxlength="10" class="textbox" >
									</td>			
									
									<td align="center" width="120px" class="text">�ֹ�/���ǹ�ȣ</td>
									<td align="center" bgcolor="#ffffff">
										<input type="text" name="sManage_No" Id="sManage_No" value="" size="15" maxlength="20" class="textbox" >
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height='30px'>
						<td bgcolor="#ffffff">
							<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
								<tr>
								<td width='80px' class="text">����</td>
									<td bgcolor='#ffffff'>&nbsp;&nbsp;
										<%=HDConstant.COMMENT_START%>
									<object id=sSex classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs3>
									        <param name=BindColumn      value="detail">
									        <param name=BindColVal      value="detail">
											<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
										
									
									<td align="center" width="80px"  class="text">������</td>
									<td align="center" bgcolor="#ffffff">
										<%=HDConstant.COMMENT_START%>
										<object id=sAge_Cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs4>
											<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>								
									<td width='80px'class="text" >����</td>
									<td bgcolor='#ffffff'>&nbsp;&nbsp;
										<%=HDConstant.COMMENT_START%>
									<object id=sJob_Cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs5>
									        <param name=BindColumn      value="detail">
									        <param name=BindColVal      value="detail">
											<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td align="center" width="100px"  class="text">������</td>
									<td align="center" bgcolor="#ffffff">
										<%=HDConstant.COMMENT_START%>
										<object id=sCust_Gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs6>
											<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height='30px'>
						<td bgcolor="#ffffff">
							<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
								<tr>
									<td width='80px'class="text" >�������</td>
									<td bgcolor='#ffffff'>&nbsp;&nbsp;
										<%=HDConstant.COMMENT_START%>
											<object id=sSaup_Gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=codeDs7>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
											</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									
									
									<td width='80px' height='25px'class="text" >��������</td>
									<td  align=absmiddle bgcolor='#ffffff'>&nbsp;&nbsp;
										<%=HDConstant.COMMENT_START%>
									<object id=sCountry_Gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs8>
									        <param name=BindColumn      value="detail">
									        <param name=BindColVal      value="detail">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>
									
									<td width='80px' height='25px' class="text" >�����ڵ�</td>
									<td bgcolor='#ffffff' align=absmiddle >&nbsp;&nbsp;
										<%=HDConstant.COMMENT_START%>
									<object id=sArea_Cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=codeDs9>
									        <param name=BindColumn      value="detail">
									        <param name=BindColVal      value="detail">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>
									
									
									<td width='80px' class="text">����</td>
									<td bgcolor='#ffffff'>&nbsp;&nbsp;
										<input type='text' name='sCountry_Nm' id='sCountry_Nm' value=''  readonly='readolny' size='10' class='textbox'>
										<input type='hidden' name='sCountry_Cd' id='sCountry_Cd' value=''  readonly='readolny' size='10' class='textbox'>
									    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ڵ带  �˻��մϴ�"  style="cursor:hand" id="country_btn" onclick="javascript:fnCountryPopup('<%=dirPath%>');" align='absmiddle'>
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
									
									<C> name='����'   		ID='{CURROW}'  		width=40 	align=left editlimit=61 show=true </C>
									<C> name='�����'   		ID='depart_date'  	width=80 	align=center editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' </C>
									<C> name='����'   		ID='cust_nm'  		width=80 	align=left editlimit=61 show=true </C>
									<C> name='�ֹι�ȣ'   	ID='manage_no'  	width=100 	align=left editlimit=61 show=true </C>
									<C> name='������'   		ID='age_cd'  		width=50 	align=center editlimit=61 show=true suppress=2</C>
									<C> name='����'   		ID='sex'  			width=50 	align=center editlimit=61 show=true suppress=3</C>
									<C> name='��ǰ'   		ID='goods_nm'  		width=100 	align=left editlimit=61 show=true suppress=4</C>
									<C> name='������'   		ID='upjang_nm'  	width=80 	align=left editlimit=61 show=true suppress=5</C>
									<C> name='����'   		ID='job_cd'  		width=80 	align=left editlimit=61 show=true suppress=6</C>
									<C> name='����'   		ID='country_gu'  	width=80 	align=center editlimit=61 show=true suppress=7</C>
									<C> name='�ּ���'   		ID='address1'  		width=60 	align=center editlimit=61 show=true</C>
									<C> name='������'   	ID='cust_gu'  		width=80	align=left editlimit=61 show=true suppress=8</C>
									<C> name='�������'   	ID='saup_gu'  		width=80 	align=left editlimit=61 show=true suppress=9</C>
									<C> name='Ƚ��'   		ID='north_cnt'  	width=40 	align=right editlimit=61 show=true </C>
									<C> name='����'   		ID='company_nm'  	width=50 	align=left editlimit=61 show=true </C>
									<C> name='����'   		ID='positions'  	width=50 	align=left editlimit=61 show=true </C>
									<C> name='���Ϻι�ȣ'   	ID='unity_no'  		width=80 	align=left editlimit=61 show=true </C>
									
									
									       
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

