<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���ԽŰ�
 * ���α׷�ID 	 : CQ130S
 * J  S  P		 : cq130s
 * �� �� ��		 : Cq130S
 * �� �� ��		 : ������
 * �� �� ��		 : 2006-07-08
 * �������		 : ���ԽŰ� ��ȸ,���
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-03-07][�ɵ���] ����Ʈ ��� ��ġ ���� (with ���繫�� ���� �븮)
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){                 
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=ds5,O:COUNTRY=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
				+ "sManageNo=" + txt_manage_no.value;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq130S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ���ð�, ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds3,O:S_GOODS_DS=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + txt_depart_date.text + ","	            
           + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
			 + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index);
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  

	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
         + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
            + "sDepartDate=" + txt_depart_date.text + ","	
           + "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time", drp_depart_time.Index) + "," 
            + "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","     
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		
		
	/*
	 * ����
	 */
	function fnApply() {

	}
	/*
	 * ���
	 */
	function fnCancel() {

	}
	/*
	 * ����
	 */
	function fnExcel() {

	}
	/*
	 * ��������
	 */
	function fnEraser() {

	}		
	/*
	 * ����Ʈ
	 */
	function fnPrint() {
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sCountryGu=" + drp_country_cd.ValueOfIndex("detail",drp_country_cd.Index) + ","
				+ "sManageNo=" + txt_manage_no.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq130S",
            "JSP(O:DEFAULT=ds9)",
            param);
		 fnOnProgressStart();
        tr_post(tr1);
    }

	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( txt_depart_date.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//��ǰ 
			div = 'init';
			fnSelectDs6();		
		}
	</script>
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
	//	if ( div != 'init' ) {	//���ð�
	//		div = 'init';
	//		fnSelectDs6();		
	//	}
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';					
			fnSelectDs7();		
		}
	</script>		
<script language=JavaScript  for=ds8 event="OnLoadCompleted(row)"> <!-- ���� -->
			div.value = '';
			ds8.deleteRow(1);
			ds8.deleteRow(1);
			drp_country_cd.Index = 0;
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	//fnSelectDs6();
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
	//ds9.namevalue(ds9.rowposition,"depart_date")=txt_depart_date.text;
	//ds9.namevalue(ds9.rowposition,"arrive_date")=txt_arrive_date.value;
	pr1.preview();
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object><%--����--%>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object><%--���--%>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--���ð�--%>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--��ǰ--%>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%----%>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--��--%>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--��--%>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--��������--%>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
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
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="840px"  cellpadding="0" cellspacing="0">
												<tr>
													<td align="right" colspan="2">
														<table border="0"  cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td align="right" height="30px">		
																	<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
																	<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()">
																	<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">&nbsp;&nbsp;
													 			</td>
															</tr>	
														</table>
													</td>											
												</tr>
												<tr>
													<td align="left"  colspan='2' width="845px">
														<table width="840px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="840px">
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
																			<td align="center" width="80px" class="text">����</td>
																			<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                						                             			<%=HDConstant.COMMENT_START%>
    																			<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds2>
                						                                        	<param name=SearchColumn    value="saup_nm">
																					<param name=ListExprFormat  value="saup_nm^0^200">
																				</object>
																				<%=HDConstant.COMMENT_END%>
																				&nbsp;</nobr>
																			</td>
																			<td align="center" width="80px" class="text">�������</td>
																			<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                            						                 			<%=HDConstant.COMMENT_START%>
                            						             				<object id=txt_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>            
                               							               				<param name=Format      value="YYYY-MM-DD">
                            						                   				<PARAM NAME=InputFormat value="YYYYMMDD">
                              						                 				<param name=Alignment   value=1>
                           						                    				<param name=ClipMode    value=true>
                              							               				<param name=Border      value=false>
                               							              			</object>&nbsp;
    																			<object id=drp_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds3>
                                   							                     	<param name=SearchColumn    value="depart_time_nm">
																					<param name=ListExprFormat  value="depart_time_nm^0^200">
																				</object>
																				<%=HDConstant.COMMENT_END%>
																				&nbsp;</nobr>
																			</td>
																			<td align="center" width="80px" class="text" >��ǰ����</td>
																			<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
    																			<%=HDConstant.COMMENT_START%>
    																			<object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds4>
                                          							              	<param name=SearchColumn    value="goods_nm">
																					<param name=ListExprFormat  value="goods_nm^0^200">
																				</object>
																				<%=HDConstant.COMMENT_END%>
																				&nbsp;</nobr>
																			</td>
																			<td align="center" width="80px" class="text">��/��</td>
																			<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
    																			<%=HDConstant.COMMENT_START%>
    																			<object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds6>
                                                						        	<param name=SearchColumn    value="class_nm">
																					<param name=ListExprFormat  value="class_nm^0^200">
																				</object>
    																			<object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds7>
                                          							              	<param name=SearchColumn    value="teams_nm">
																					<param name=ListExprFormat  value="teams_nm^0^200">
																				</object>
																				<%=HDConstant.COMMENT_END%>
																				&nbsp;</nobr>
																			</td>																				
											            				</tr>
											                            <tr bgcolor="#6f7f8d">
																			<td align="center" width="80px" class="text">��������</td>
																			<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
                						                             			<%=HDConstant.COMMENT_START%>
    																			<object id=drp_country_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds8>
                						                                        	<param name=SearchColumn    value="detail_nm">
																					<param name=ListExprFormat  value="detail_nm^0^200">
																				</object>
																				<%=HDConstant.COMMENT_END%>
																				&nbsp;</nobr>
																			</td>
																			<td align="center" width="80px" class="text">�ֹ�/���ǹ�ȣ</td>
																			<td align="left" bgcolor="#ffffff" colspan="5"><nobr>&nbsp;
																				<input type="text" name="txt_manage_no" size="11" maxlength="20" class="textbox">
																				&nbsp;</nobr>
																			</td>																				
											            				</tr>
											            			</table>
																</td>
															</tr>															
														</table>	
													</td>											
												</tr>
												<tr> 
													<td height='5px'></td>
												</tr>												
												<tr>
													<td width="840px" colspan='2'>
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="840px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																	<%=HDConstant.COMMENT_START%>
																	<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:420px" border="1">
																	    <param name="DataID"            value="ds1">
																	    <param name="BorderStyle"       value="0">
																	    <!-- param name="Fillarea"          value="true"-->
																	    <param name="ColSizing"         value="true">
																	    <param name="editable"          value="true">
																		<param name=ViewSummary     value=1>
																		<param name="Format"            value=" 
                                                                            <C> name='No.'           ID='{CURROW}'              Width=40  align=center edit=none SumText='�Ѱ�'</C>
                                                                            <C> name='���ð�'     ID='depart_time'    Width=60  align=center edit=none SumText=@count</C>
                                                                            <C> name='��ǰ'         ID='goods_nm'       Width=140  align=left edit=none</C>
																	        <C> name='��'           ID='class'        	Width=60  align=center edit=none</C>
																	        <C> name='��'           ID='teams'        	Width=50  align=center edit=none</C>
																	        <C> name='����'      	ID='tour_no'       	Width=50  align=center edit=none</C>
																	        <C> name='����'    		ID='cust_nm'       	Width=140  align=left edit=none</C>
																	        <C> name='����'  		ID='sex'            Width=50  align=center edit=none</C>
                                                                            <C> name='�ֹε�Ϲ�ȣ' ID='regi_no'        Width=100  align=center edit=none </C>
																	        <C> name='����'         ID='country_cd'    	Width=150  align=left edit=none</C>
																	        <C> name='�������ȣ'   ID='unity_no'       Width=110  align=center edit=none</C>
                                                                            <C> name='�ּ�'         ID='address1'       Width=200  align=left edit=none</C>
                                                                            <C> name='��ȭ��ȣ'     ID='tel_no'         Width=100  align=center edit=none</C>
																	        <C> name='����/�����'  ID='company_nm'     Width=100  align=left edit=none</C>
																	        <C> name='�������'     ID='tour_obj'      Width=100  align=left edit=none</C>
																	        <C> name='�����'      	ID='start_end'      Width=80  align=left edit=none</C>
																	        <C> name='������'       ID='end_start'      Width=80  align=left edit=none</C>
																	        <C> name='���ڸ�'       ID='goods_nm'       Width=130  align=left edit=none</C>
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
				
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="MasterDataID"			VALUE="ds9">
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<PARAM NAME="Format"                VALUE="
<B>id=default ,left=0,top=0 ,right=2001 ,bottom=1191 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='unity_no1', left=1106, top=546, right=1988, bottom=601, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=1106, top=575, right=1988, bottom=622, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=313, top=546, right=1193, bottom=601, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no1', left=313, top=575, right=1193, bottom=622, face='3 of 9 Barcode', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=237, top=556, right=584, bottom=599, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tour_obj', left=782, top=517, right=982, bottom=559, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tour_obj', left=1574, top=517, right=1775, bottom=559, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='company_nm', left=1032, top=556, right=1377, bottom=599, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=1032, top=63, right=1617, bottom=119, align='left', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm', left=237, top=63, right=824, bottom=119, align='left', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=237, top=269, right=532, bottom=327, face='����', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='regi_no', left=529, top=269, right=824, bottom=327, face='����', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='regi_no', left=1324, top=269, right=1617, bottom=327, face='����', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='birthday', left=1032, top=269, right=1327, bottom=327, face='����', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='f_sex_chk', left=1714, top=277, right=1769, bottom=332, face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='m_sex_chk', left=1714, top=224, right=1769, bottom=279, face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='m_sex_chk', left=911, top=224, right=966, bottom=279, face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='f_sex_chk', left=911, top=277, right=966, bottom=332, face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=1403, top=356, right=1775, bottom=414, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='country_cd', left=237, top=356, right=611, bottom=414, align='left', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='unity_no', left=608, top=356, right=982, bottom=414, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='country_cd', left=1032, top=356, right=1406, bottom=414, align='left', face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=237, top=464, right=611, bottom=506, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='address1', left=1032, top=464, right=1406, bottom=506, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tel_no', left=1509, top=461, right=1880, bottom=506, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tel_no', left=713, top=461, right=1087, bottom=506, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='goods_nm', left=1403, top=667, right=1775, bottom=722, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='start_end', left=237, top=667, right=611, bottom=722, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='goods_nm', left=608, top=667, right=982, bottom=722, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='end_start', left=1032, top=667, right=1406, bottom=722, face='����', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
	</object> 
<%=HDConstant.COMMENT_END%>      


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

