<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : �븮�� ������ �������
 * ���α׷�ID 	 : AC610B
 * J  S  P		 : ac610b
 * �� �� ��		 : AC610B
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-08-12
 * �������		 :  �븮�� ������ �������  (����, ��ȸ, ����, ���, ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-02-05][�ɵ���] �������� �� ���������� ������ ��ũ��Ʈ ����.
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMM");
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
		sBgnDate.text='<%=firstday%>';		
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
 		//���������
        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_saldam.Reset();  
        //�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset(); 
        
		//������ �ڵ�
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC020";
        codeDs1.Reset();
        
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("�۾������ �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","	        
	            + "sClientSid=" + sClientSid.value + ","	            
	            + "sJobYymm=" + sBgnDate.text + ","
	            + "sGoodsSid=" + ds3.namevalue(ds3.rowposition,"goods_sid") + ","
	            + "sAcceptNo=" + sAcceptNo.value + ","  
	             + "sSalDamSid=" + sSalDamSid.value;            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac610B",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 *  ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac610B",
	            "JSP(O:DS3=ds3)",
	            param);
	        tr_post(tr2);
	}	
	/*
	 * ����
	 */
	function fnCreate() {
        v_job = "I";	
         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
			+ "sJobYymm="+sBgnDate.text
			 + ",sSalDamSid=" + sSalDamSid.value;
	        ln_TRSetting(tr3, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac610B",
	            "JSP(I:DSCREATE=ds_create,O:DS9=ds9)",
	            param);
	        tr_post(tr3);
	}	
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_AC%>Ac610B",
	             "JSP(I:DEFAULT=ds1,O:DS9=ds9)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	/*
	 * �����(�׸��庰)
	 */
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}	
	/*
	 * �븮���˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	}	
	/*
	 * �븮�� �ڵ�����(����)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds_saldam' ) {	//���������
			for ( i=1; i<=ds_saldam.CountRow; i++ ) {
				if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
					sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
					sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
					sSalDamSid.value = '';
					sSalDamNm.value = '';
			}			
		}
		if ( dataSet == 'ds_client' ) {	//�븮��
			for ( i=1; i<=ds_client.CountRow; i++ ) {
				if ( ds_client.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds_client.namevalue(i,"client_sid");
					sClientNm.value = ds_client.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = 0;
				sClientNm.value = '';
			}			
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
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	
	<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
        if(colid=='comm_rate'){
			ds1.namevalue(row,"comm_amt") = Math.round(( (ds1.namevalue(row,"tour_amt")-ds1.namevalue(row,"subtract_amt"))  * ds1.namevalue(row,"comm_rate") ) / 100);
			ds1.namevalue(row,"sale_amt") = Math.round(( ds1.namevalue(row,"comm_amt") + ds1.namevalue(row,"cont_amt") ));			
			ds1.namevalue(row,"tax_amt") = Math.round(ds1.namevalue(row,"sale_amt") / 10);
			ds1.namevalue(row,"tot_amt") = Math.round(ds1.namevalue(row,"sale_amt") + ds1.namevalue(row,"tax_amt"));			
        }		
        if(colid=='cont_amt'){
			ds1.namevalue(row,"comm_amt") = Math.round(( (ds1.namevalue(row,"tour_amt")-ds1.namevalue(row,"subtract_amt")) * ds1.namevalue(row,"comm_rate") ) / 100);
			ds1.namevalue(row,"sale_amt") = Math.round(( ds1.namevalue(row,"comm_amt") + ds1.namevalue(row,"cont_amt") ));			
			ds1.namevalue(row,"tax_amt") = Math.round(ds1.namevalue(row,"sale_amt") / 10);
			ds1.namevalue(row,"tot_amt") = Math.round(ds1.namevalue(row,"sale_amt") + ds1.namevalue(row,"tax_amt"));			
        }		        		
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=ds9.CountRow; j++ )
          	msg+=ds9.namevalue(j,"pMsg")+"\n";
         if ( ds9.CountRow > 0 ) 
          	alert(msg);            
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
        
        //�����޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
		    
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=ds9.CountRow; j++ )
          	msg+=ds9.namevalue(j,"pMsg")+"\n";
         if ( ds9.CountRow > 0 ) 
          	alert(msg);  		    
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "������ �Ϸ� �Ǿ����ϴ�.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	div='';
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_create classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
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
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
												<tr>
													<td align="right" colspan="2">
														<table border="0"  cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td align="right" height="30px">		
																	<img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:hand" onClick="fnCreate();">
																	<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
																	<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
																	<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
																	<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:hand" onClick="fnDeleteRow()" >																																							
													 			</td>
															</tr>	
														</table>
													</td>											
												</tr>
												<tr height="50px">
													<td align="left"  colspan='2' width="845px">
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="845px">
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left class="text" width="70">�����</td>
											                                <td align=left bgcolor="#ffffff" colspan="4">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds2>
																					<param name=BindColumn      value="saup_sid">
							                                                        <param name=BindColVal      value="saup_sid">
																					<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
																					<param name=ListExprFormat  value="saup_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>	
																			<td align=left width=70 class="text">&nbsp;���������</td>
											                                <td align=left bgcolor="#ffffff" colspan="2">&nbsp;																										
																				<input id="sSalDamSid" type="hidden" value="0">                                
																				<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
																				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
																				<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
																			</td>
																		</tr>
											                            <tr bgcolor="#6f7f8d">																			
											            					<td align=left width=70 class="text">&nbsp;����ó</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
																				<input id="sClientSid" type="hidden" value="0">                                
																				<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
																				<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
																				<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;" maxlength="50" onBlur="" readOnly>																						
																			</td>																				
											            					<td align=left class="text"  width="70">�۾����</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																							
   							      												<%=HDConstant.COMMENT_START%>
   							      												<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
																					<param name=Text 		value="">
																					<param name=Alignment 	value=1>
																					<param name=Format 		value="0000-00">
																					<param name=Cursor	 	value="iBeam">
																					<param name=Border	 	value="false">		
																					<param name=InheritColor      value="true">																																																				
																					<param name=ReadOnly  	value="false">
																					<param name=SelectAll  	value="true">
																					<param name=SelectAllOnClick  	value="true">		
																					<param name=SelectAllOnClickAny  	value="false">																							
																				</object>
																				<%=HDConstant.COMMENT_END%>&nbsp;	
																			</td>																							
											            					<td align=left class="text" width="70">��ǰ</td>
											                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds3>
																					<param name=BindColumn      value="goods_sid">
							                                                        <param name=BindColVal      value="goods_sid">
																					<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
																					<param name=ListExprFormat  value="goods_nm^0^100"></object>
																				<%=HDConstant.COMMENT_END%>&nbsp;	
																			</td>
										            						<td align=left class="text" width="70">��û����ȣ</td>
											                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
																				<input id="sAcceptNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;">	
																			</td>																																						
											            				</tr>		
											            			</table>
																</td>
															</tr>															
														</table>	
													</td>											
												</tr>
												<tr height="10">
													<td colspan='2'></td>
												</tr>													
												<tr>
													<td width="845px" colspan='2'>
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:380" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>
												                        <param name="ViewSummary"       value="1">
																		<param name="Format" 			value="                  
										                                  <G> name='����'																		
															                <C> name='�ڵ�'    ID='client_cd' BgColor=#fefec0 width=50 align=center editlimit=5 edit=none SumText='�հ�' show=true suppress=1</C>
															                <C> name='�븮����'    ID='client_nm' BgColor=#fefec0 width=80  align=left editlimit=50 edit=none show=true suppress=2</C>
															                <C> name='�������'  ID='depart_date'   BgColor=#fefec0  width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX</C>
															                <C> name='��ǰ'     ID='goods_nm' BgColor=#fefec0 width=80  align=left editlimit=40 edit=none show=true suppress=3</C>
															                <C> name='��û����ȣ'    ID='accept_no' BgColor=#fefec0 width=100 align=center editlimit=14 edit=none show=true suppress=4</C>
										                                  </G>
															                <C> name='�ο�'		ID='person_cnt' 	BgColor=#fefec0 width=50 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
										                                  <G> name='�����'
															                <C> name='�� ��'    ID='tour_amt'  BgColor=#fefec0 width=100 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='���'     ID='tour_amt_dp'  BgColor=#fefec0 width=80 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='NoShow'   ID='tour_amt_ns'  BgColor=#fefec0 width=80 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
										                                  </G>
															                <C> name='�����������\\��' ID='subtract_amt'  BgColor=#fefec0 width=80 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='�Աݾ�'      ID='pay_amt'  BgColor=#fefec0 width=100  align=right editlimit=14 edit=none dec=0  show=false</C>
															                <C> name='�ڵ�'      ID='comm_cd'  BgColor=#fefec0 width=50  align=CENTER editlimit=14 edit=none show=TRUE editstyle=lookup data='codeDs1:detail:detail_nm'</C>
															                <C> name='��������\\��'    ID='comm_rate'  width=50 align=right editlimit=7 SumText=@avg show=true dec=2</C>
															                <C> name='������\\(��-��)����'     ID='comm_amt' BgColor=#fefec0  width=100 align=right editlimit=14 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='����������'     ID='cont_amt'  width=65  align=right editlimit=12 SumText=@sum dec=0 show=true</C>
										                                  <G> name='�����᳻��'															                
															                <C> name='���ް���'     ID='sale_amt' BgColor=#fefec0 width=100  align=right editlimit=12 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='�ΰ���'      ID='tax_amt' BgColor=#fefec0  width=100  align=right editlimit=12 edit=none SumText=@sum dec=0 show=true</C>
															                <C> name='�հ�'      ID='tot_amt' BgColor=#fefec0  width=100  align=right editlimit=12 edit=none SumText=@sum dec=0 show=true</C>
										                                  </G>															                
															                <C> name='�۾����'     ID='job_yymm'   width=60 align=center editlimit=6 show=false</C>
															                <C> name='��û��SID'   ID='accept_sid'  align=left editlimit=12 show=false</C>
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
										<td>�� ����� �κ�<br>
											����������~ 2008-11 : ����ڸ� �ش�<br>
											��2008-12 ~ 2009-04 : ���, ��� �ش�<br>
											��2009-05 ~ ��������: ���, ��� ���� ǥ��
										</td>
									</tr>
								</table>
							
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

