<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����Ȯ��[�����۾�]
 * ���α׷�ID 	: RV440B
 * J  S  P		: rv440b
 * �� �� ��		: Rv440b
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-19
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-05-16][�ɵ���] ������ �˻����� �߰�
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
			var div = "";
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
		 * ����
		 */
		function fnInit() {
			sBgnDate.text='<%=firstday%>';	
				div.value = 'init';

			initDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			initDs1.Reset(); //�����ڵ�
		}
		
		/*
		 * ���ð�, ��ǰ��ȸ
		 */		
		function fnSelectCodeDs() {
		
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
	            + "sSaupSid=" + initDs1.namevalue(initDs1.rowposition,"saup_sid") + ","
				+ "sDepartDate=" + sBgnDate.text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_DEPART_TIME_DS=initDs2,O:S_GOODS_DS=initDs3)",
	            param);
	        tr_post(tr2);
	        
	        initDs2.insertRow(1);
			initDs2.namevalue(1,"depart_time_nm") = "��ü";
			initDs2.namevalue(1,"depart_time") = "";
			
			lc2.index =0;
			
			
			initDs3.insertRow(1);
			initDs3.namevalue(1,"goods_nm") = "��ü";
			initDs3.namevalue(1,"goods_sid") = "";
			
			lc3.index =0;
		}	
	
		/*
		 * ���� ��ȸ
		 */
		function fnSelect2() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv440B",
			    "JSP(O:DS2=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		/*
		 * ���� 
		 */		
		 function fnApply(gubun) {
		 	var row=ds1.countRow;
			
			var param =  "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
					  + ",sDepart_date=" + sBgnDate.Text
					  + ",sGubun=" + gubun;
					  
			if (ds1.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv440B",
//                "JSP(I:DS1=ds1,O:DS4=ds4)",
                "JSP(I:DS1=ds1)",
                param);
        		tr_post(tr1);
			}	
		 }
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect1() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sDepart_date=" + sBgnDate.Text
			          + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
			          + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index)
			          + ",sJobsel=" + sJobsel.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv440B",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		 
		function fnExcelDs1() {
			if(ds1.RowCount==0){
				alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
				return;
			}
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:�븮�� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����Ȯ��", "����Ȯ��(����).xls", 8);		 
		}
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
		window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
		document.all.LowerFrame.style.visibility="visible";	
	</script>
 
 	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		document.all.LowerFrame.style.visibility="hidden";
		for (i = 1; i<=ds1.countrow; i++) {
			ds1.namevalue(i,"flag") = "y";
		}
	</script>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		
	</script>	
	
	
	<script language=JavaScript  for=initDs1 event="OnLoadCompleted(row)"> <!-- ���� -->
			fnSelectCodeDs();
	</script>
	
	<script language=JavaScript  for=initDs2 event="OnLoadCompleted(row)"> <!-- ���ð� -->
			initDs2.deleteRow(1); <!-- ��ü ���� -->
			lc2.Index = 0;
	</script>
	
	
	<script language=JavaScript  for=initDs3 event="OnLoadCompleted(row)"> <!-- ��ǰ -->
			div.value = '';
			initDs3.deleteRow(1);
			lc3.Index = 0;
	</script>
	
	
	<script language=JavaScript for= lc1 event=OnSelChange()> <!-- ���� ü���� -->
		if ( div.value != 'init') {
			fnSelectCodeDs();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()> <!-- ���ð� ���� -->
		if ( div.value != 'init' ) {	//�������
			if ( sBgnDate.Modified ) {
				div.value = 'init';
				fnSelectCodeDs();			
			}
		}				
	</script>

<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
	<param name="SyncLoad" 	value="false">
</object>

<object id=initDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=initDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=initDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ǰ���� -->
	<param name="SyncLoad" 	value="false">
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

	<table border='0' cellpadding='0' cellspacing='0' width='100%'>	
		<tr>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='845px'>
					<tr>
						<td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer1.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect1()"> <!--  ��ȸ1: CHECKING ����-->
							<img src="<%=dirPath%>/Sales/images/upload.gif"  style="cursor:hand" align=absmiddle onclick="fnApply('U')"> <!--  (�ű�) ���ε�: CHECKING �� PHOTO -->
							<img src="<%=dirPath%>/Sales/images/refer2.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect2()"> <!--  ��ȸ2: PHOTO ���� -->
							<img src="<%=dirPath%>/Sales/images/download_sid.gif"	style="cursor:hand"	align=absmiddle onclick="fnApply('Y')" alt="���ϸ� ����(SID)�� �����մϴ�!"> <!-- �ٿ�ε� (SID)-->
							<img src="<%=dirPath%>/Sales/images/download_no.gif"	style="cursor:hand"	align=absmiddle onclick="fnApply('N')" alt="���� ���ϸ�(manage_no) ��� �����մϴ�!"> <!--  �ٿ�ε� (�ֹ�) -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onclick="fnExcelDs1()">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td width='845px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
					<tr height='30px'>
						<td align=left class="text" width="70">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=initDs1>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="70"><b>�������</b></td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="false">																					
							</object>&nbsp;
						
	                        <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=initDs2>
								<param name=BindColumn      value="depart_time">
	                            <param name=BindColVal      value="depart_time">
								<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
								<param name=ListExprFormat  value="depart_time_nm^0^50">
							</object>
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=left class="text" width="70">��ǰ����</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
								<%=HDConstant.COMMENT_START%>
	                        <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
								<param name=ComboDataID		value=initDs3>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
						</td>
			              <td align=left class="text" width="80px">������</td>
			              <td align="left" bgcolor="#ffffff">&nbsp;
	    					<select name="sJobsel"> 
		    					 <option value="0" SELECTED>��ü</option>
								 <option value="1">������</option>
								 <option value="2">�����</option>
								 <option value="3">���������</option>
							</select>
						  </td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr height='10px'>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name="IndWidth"       value="20">
											<param name=ViewSummary     value=1>
										     <param name="Format"            value="
												<C> name='No.'         ID='{CURROW}'            Width=40  align=center edit=none SumText='�Ѱ�'</C>
									             <C> name='�������'  			ID='depart_date' 	width=100 align=left editlimit=8 show=true 	bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')} mask='XXXX-XX-XX' SumText=@count</C>
									             <C> name='���ð�'  			ID='depart_time'   	width=100 align=left editlimit=4 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')} mask='XX:XX' </C>
									             <C> name='����Ÿ��' 				ID='room_type_cd'  	width=100 align=left editlimit=5 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='��û����ȣ'    		ID='accept_no'   	width=100 align=left editlimit=15 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')} mask='XXXXX-XXXXXX-XXX'</C>
									             <C> name='��SID'     			ID='cust_sid'    	width=100 align=left editlimit=12 show=false bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='������ȣ(�ֹ�/����)'   	ID='manage_no'   	width=140 align=left editlimit=20 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='����'      			ID='cust_nm'     	width=100 align=left editlimit=30 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='�����'   			ID='company_nm'  	width=100 align=left editlimit=30 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='����'    				ID='positions'   	width=100 align=left editlimit=30 show=true bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='FLAG'    			ID='flag'   		width=100 align=left editlimit=30 show=false bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
									             <C> name='IS_FILE'    			ID='is_file'   		width=100 align=left editlimit=30 show=false bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
        									     <C> name='FILE_NAME'    			ID='file_name'   		width=100 align=left editlimit=30 show=fales bgColor={IF(is_file='Y','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_LINK_COLOR%>')}</C>
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
		<tr>
			<td>
			�� ��ȸ1 : ���ε� üũ�� - <b>neophoto/cust_checking/</b> ������ ��<br>
			�� ��ȸ2 : �⡡�� Ȯ�ο� - <b>neophoto/cust/</b> ������ ��<br>
			���������� �ش� ���� ���������� ������ GRID���� ���� �Ķ������� ǥ��

			</td>
		</tr>
	</table>
	
   
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
        <input type='hidden' name='div' value=''>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

