<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��Һ��� ��û 
 * ���α׷�ID 	 : RV505I
 * J  S  P		 : rv505i
 * �� �� ��		 : RV505I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2008.03.28
 * �������		 : ��� ��û
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-03-28][�ɵ���] ���� ��ҿ� ȯ�� �и�~
 * 						��û [�븮��]	������� ����
 *										���ο� ���� ���� + �����ڵ� ����
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);		   
   String firsttime = m_today.format(date.getTime()).substring(8,12);		      

    //�븮�� ����
/*    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);*/
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
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit();
		}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
//			var s_temp1 = "STATUS_CD:STRING,ACCEPT_DATE:STRING,ACCEPT_NO:STRING,CUST_NM:STRING,REQ_NO:STRING,CLIENT_SID:INT,ACCEPT_TIME:STRING,CLIENT_DAM_NM:STRING,MOBILE_NO:STRING,DEPART_DATE:STRING,DEPART_TIME:STRING,ACCEPT_SID:INT,RSV_SID:INT,CUST_SID:INT,MANAGE_NO:STRING,COMPANY_NM:STRING,POSITIONS:STRING,CUST_MOBILE_NO:STRING,TOUR_AMT:INT,PAY_AMT:INT,AMT:INT,CHARGE_CD:STRING,CHARGE_RATE:INT,BANCOD:STRING,BANNM:STRING,BANK_ACC_NO:STRING,BANK_ACCT_NM:STRING,REASON:STRING,DESC:STRING";
//			ds1.SetDataHeader(s_temp1);
			v_job = "H";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
	            "JSP(O:DEFAULT=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);           
		}
		if (selectImgDs.countrow < 1){
			var s_temp1 = "PICTURE_INFO:STRING";
			selectImgDs.SetDataHeader(s_temp1);
		}		
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>'; 
		
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
                        
        //�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
        //�۾�����1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset(); 
        //�۾�����2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();        
		//�����ڵ�
        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV006&s_item2=Y";
        codeDs1.Reset(); 
	}
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sClientSid=" + sClientSid.value + "," 
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
            + "sBgnDate=" + sBgnDate.text + ","                         
            + "sEndDate=" + sEndDate.text;
		imgDs.ClearAll();
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv505I",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);
    }

	// ���� : ���� ������ 1���� 1�� ����... ;;;;
	function fnApply() {
		if ( ds1.isUpdated){
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv505I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
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
	 * �븮���˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
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

	// ����(������) �˾�
	function fnPopup4() { 
		//���ϻ�ǰ�� ��쿡�� â ����� �ʰ� �������� ����>>
		if((ds1.namevalue(ds1.rowposition,"goods_sid")==30) || (ds1.namevalue(ds1.rowposition,"goods_sid")==35)) {
			alert("���� ��ǰ�̹Ƿ� [����]�� �����մϴ�.");
			lc_JoinCd.index = 1;
		}else{
			if ( sClientSid.value.trim() == '' || sClientSid.value.trim() == '0' ) {
				alert("�븮���� ������ �ּ���");
				return;
			}
			if ( accept_sid.value.trim() =='' || accept_sid.value.trim() == '0' ) {
				alert("��û�� ��ȣ�� �Է��� �ּ���.");
				return;
			}
	
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
	
			strURL = "<%=dirPath%>/Sales/help/rv017h.jsp?sClientSid="+sClientSid.value+"&sAcceptSid="+accept_sid.value+"&sAcceptDate="+accept_date.text+"&sAcceptTime="+accept_time.text;
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	
			arrResult = showModalDialog(strURL,arrParam,strPos);	
	
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	mCustNm.value = arrParam[0];
				mRsvSid.value = arrParam[1];
				lc_JoinCd.index=0; // �����ڵ� �ʱ�ȭ.
				
			} else {
		    	mCustNm.value = '';
				mRsvSid.value = 0;
			}
		};
	} 		
	
		
	/*
	 * �븮�� �ڵ�����(����)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
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
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 
	

</script>	    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
	</script>
		
	<script language=JavaScript for=sBgnDate event=OnKillFocus()> 
		if ( sBgnDate.Modified ) {
			sEndDate.text = sBgnDate.text;
		}
	</script>

	<script language=JavaScript for=lc_JoinCd event=OnSelChange()>
		if(v_job!="H"){//������ �ʱ�ȭ �ƴҶ��� �۵�
			if(lc_JoinCd.index==0){
				return;
			}else if(lc_JoinCd.index==1) {	//������ ���
				if(mRsvSid.value!=0){//������ ����������
					alert("������ ��쿡�� ������ �����Ͻ� �� �����ϴ�.\n������ ����� �� �ٽ� �õ����ּ���.");
					lc_JoinCd.index = 0; //�ʱ�ȭ!				
				}
			}else{ //���� �ƴ� ���
				if((ds1.namevalue(ds1.rowposition,"goods_sid")==30) || (ds1.namevalue(ds1.rowposition,"goods_sid")==35)) {
					alert("���� ��ǰ�̹Ƿ� [����]�� �����մϴ�.");
					lc_JoinCd.index = 1; //����!
				}else{
					if(mRsvSid.value==0){//������ �������� �ʾ�����
						alert("������ �ƴ� ��쿡�� ���� ������ ������ �ּ���.");
						lc_JoinCd.index = 0; //�ʱ�ȭ!				
					}
				}
			}
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
        var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
          	            
            //�޽��� ó��
			if ( msgDS.CountRow > 0 ) {
		        for ( j=1; j<=msgDS.CountRow; j++ )
		          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
				if(msg!='')
					alert(msg);
		    }
		    
			fnSelect();		    
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
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
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = tr1.SrvErrMsg("ERROR", i) + "\n";
		
		if(alertMsg!='')
			alert(alertMsg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            var count=1;
            for ( i=1;i<=ds1.CountRow;i++ ) {
            	if ( ds1.namevalue(i,"req_no") == '' )
		            ds1.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds1.ResetStatus();
       	}
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
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>	
	
	<script language=JavaScript  for=ds_bancod event="OnLoadCompleted(row)">
     	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";		
	</script>	
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
	        photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
	    else 
	        photo.src = "<%=dirPath%>/Sales/images/00000.gif";
	        
		selectImgDs.clearData();
	    selectImgDs.addrow();
	    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(Row,"picture_info");
		selectImgDs.ResetStatus();		
		
	</script>	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_charge classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_bancod classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=selectImgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
											
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=left width=70 class="text">&nbsp;�븮��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sClientSid" type="hidden" value="">
									<input id="sClientCd" type="text" class="textbox" value="" style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">

									<input id="sClientNm" type="text" class="boardt04" value="" style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
											</td>		
			            					<td align=left width=70 class="text">&nbsp;�۾�����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>																				
            					<td align=left width=70 class="text">&nbsp;��û����</td>
                                <td align=left bgcolor="#ffffff" width=300>&nbsp;																										
								     <%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
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
		<td height="10"></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="290px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=290px; height:370" border="1" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
                            <param name="ViewSummary" value="1">
							<param name="Format" 			value="
				                <C> name='�۾�����'	ID='status_cd' width=60  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true sumtext=��</C>
				                <C> name='��û��'	ID='accept_date'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX sumtext=@count</C>
				                <C> name='��û��ȣ'	ID='accept_no'  width=100 align=center editlimit=15 edit=none show=true sumtext=��</C>
				                <C> name='�̸�'		ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='������ȣ'	ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>
				                <C> name='����'		ID='M_RSV_SID' width=100  width=100  align=center editlimit=20 edit=none show=false</C>
				                <C> name='�����ڵ�'	ID='JOIN_CD'   width=100  width=100  align=center editlimit=20 edit=none show=false</C>
				                <C> name='�븮��SID' ID='client_sid' width=60  align=left editlimit=12 show=false</C>
				                <C> name='��û�ð�' ID='accept_time'         align=left show=false </C>															                
				                <C> name='�����'   ID='client_dam_nm'       align=left editlimit=20 show=false</C>
				                <C> name='����ó'   ID='mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='�����'	ID='depart_date'         align=left editlimit=8 show=false</C>
				                <C> name='��߽ð�'	ID='depart_time'         align=left editlimit=8 show=false</C>															                
				                <C> name='��ûSID' 	ID='accept_sid'  align=left editlimit=12 show=false</C>
				                <C> name='����SID' 	ID='rsv_sid'     align=left editlimit=12 show=false</C>
				                <C> name='��SID'	ID='cust_sid'    align=left editlimit=12 show=false</C>
				                <C> name='�ֹ�/���ǹ�ȣ'    ID='manage_no'   align=left editlimit=20 show=false</C>
				                <C> name='�����'   ID='company_nm'  align=left editlimit=30 show=false</C>
				                <C> name='����'    ID='positions'   align=left editlimit=30 show=false</C>
				                <C> name='����ó'    ID='cust_mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='ó�����' ID='desc'        align=left editlimit=200 show=false</C>	
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
					<td width="25px">
					</td>					
					<td align="left" valign="top" width="530px">
					  <table border="0" cellpadding="0" cellspacing="0">
						<tr>
						  <td>

							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<table width="530px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left" >&nbsp;
      												<%=HDConstant.COMMENT_START%>
						                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
														<param name=ComboDataID		value=ds_status2>
														<param name=EditExprFormat	value="%,%;detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^80">
														<param name=BindColumn      value="detail">
		                                                <param name=BindColVal      value="detail">
														<param name=Enable2  value=false>																											
													</object>
													<%=HDConstant.COMMENT_END%>
												</td>												
												<td align=center width=100 class="text"></td>
				                                <td align=left bgcolor="#ffffff">&nbsp;
												</td>															
											</tr>
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û��</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
												     <%=HDConstant.COMMENT_START%>
												     <object id=accept_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
														<param name=Text 		value="">
														<param name=Alignment 	value=1>
														<param name=Format 		value="0000-00-00">
														<param name=Cursor	 	value="iBeam">
														<param name=Border	 	value="0">		
														<param name=InheritColor      value="true">																																																				
														<param name=ReadOnly  	value="true">
														<param name=ReadOnlyBackColor  	value="#dddddd">																											
														<param name=SelectAll   value="true">																				
														<param name=SelectAllOnClick   value="true">		
														<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
													</object>
													<%=HDConstant.COMMENT_END%>&nbsp;
												     <%=HDConstant.COMMENT_START%>
												     <object id=accept_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
														<param name=Text 		value="">
														<param name=Alignment 	value=1>
														<param name=Format 		value="00:00">
														<param name=Cursor	 	value="iBeam">
														<param name=Border	 	value="0">		
														<param name=InheritColor      value="true">																																																				
														<param name=ReadOnly  	value="true">
														<param name=ReadOnlyBackColor  	value="#dddddd">																																																						
														<param name=SelectAll   value="true">																				
														<param name=SelectAllOnClick   value="true">		
														<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
													</object>
													<%=HDConstant.COMMENT_END%>																										
												</td>																								
												<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">������ȣ</td>
												<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="req_no" type="text" class="boardt04"   value="" size="20" readonly>
												</td>																																																			
											</tr>
											<tr>
												<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">�����</td>
												<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="client_dam_nm" type="text" class="boardt04"   value="�����" size="20" readonly>
												</td>																								
												<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">����ó</td>
												<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="mobile_no" type="text" class="boardt04"   value="010-3399-0101" size="20" readonly>
												</td>	
											</tr>																												
											<tr>
												<td  height="35px" bgcolor="#eeeeee" align="center" class="text" colspan=4>��� �� ����</td>
											</tr>													
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
												     <%=HDConstant.COMMENT_START%>
												     <object id=depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
														<param name=Text 		value="">
														<param name=Alignment 	value=1>
														<param name=Format 		value="0000-00-00">
														<param name=Cursor	 	value="iBeam">
														<param name=Border	 	value="0">		
														<param name=InheritColor      value="true">																																																				
														<param name=ReadOnly  	value="true">
														<param name=ReadOnlyBackColor  	value="#dddddd">
														<param name=SelectAll   value="true">																				
														<param name=SelectAllOnClick   value="true">		
														<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
													</object>
													<%=HDConstant.COMMENT_END%>&nbsp;
												     <%=HDConstant.COMMENT_START%>
												     <object id=depart_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
														<param name=Text 		value="">
														<param name=Alignment 	value=1>
														<param name=Format 		value="00:00">
														<param name=Cursor	 	value="iBeam">
														<param name=Border	 	value="0">		
														<param name=InheritColor      value="true">																																																				
														<param name=ReadOnly  	value="true">
														<param name=ReadOnlyBackColor  	value="#dddddd">
														<param name=SelectAll   value="true">																				
														<param name=SelectAllOnClick   value="true">		
														<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
													</object>
													<%=HDConstant.COMMENT_END%>
												</td>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û����ȣ</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">
													<input id="accept_sid" type="hidden" value="0">&nbsp;                                
													<input id="accept_no" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
												</td>																									
											</tr>																												
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">
													<input type="hidden" id="rsv_sid" value="0">																									
													<input type="hidden" id="cust_sid" value="0">&nbsp;
													<input id="cust_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
												</td>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ֹ�/���ǹ�ȣ</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="manage_no" type="text" class="boardt04"  size="20" value="" readonly>
												</td>																									
											</tr>																												
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="company_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px;color:black; text-align:left;" readonly>																						
												</td>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="positions" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px; text-align:left" readonly>																						
												</td>																									
											</tr>																																																																																																			
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����ó</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="cust_mobile_no" type="text" class="boardt04"  size="20" value="" style="text-align: left" readonly>
												</td>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��湮Ƚ��</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input id="north_cnt" name=north_cnt type="text"  class="boardt04" size="20" value=""  style="text-align: right" readonly>
												</td>
											</tr>
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ�һ���</td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
													<input id="reason" type="text" class="boardt04"  size="50" value="" style="text-align: left" readonly>
												</td>
											</tr>																																																																																																																							
											<tr>
												<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text"><b>�������</b></td>
												<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
													<input id="rsv_status" type="text" class="boardt04"  size="50" value="" style="text-align: left" readonly>
												</td>
											</tr>																																																																																																																							

											<!-- ������� ��Ұ��� �������� -->
											
											<tr>
												<td  height="35px" bgcolor="#eeeeee" align="center" class="text" colspan=4>������ ���� ����</td>
											</tr>
											<tr>
												<td  height="45px" width="100px" bgcolor="#eeeeee" align="center" class="text"><b>���� ����</b></td>
												<td  height="45px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<input type="hidden" name="mRsvSid" id="mRsvSid" value="0">
													<input name="mCustNm" id="mCustNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
												</td>
												<td  height="45px" width="100px" bgcolor="#eeeeee" align="center" class="text"><b>���� �ڵ�</b></td>
												<td  height="45px"  bgcolor="#FFFFFF" align="left">&nbsp;
													<%=HDConstant.COMMENT_START%>
						                            <object id=lc_JoinCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs1>
														<param name=EditExprFormat	value="%,%;detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^80">
														<param name=BindColumn      value="detail">
		                                                <param name=BindColVal      value="detail">
														<param name=ReadOnly  	value="true">
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
					</td>
				</tr>
			</table>
		</td>
	</tr>											
	<tr>											
		<td>
		�� �۾�����=<font color=red>"�����Ϸ�"</font>�� �������� ������ �� �ְ� ���� �Ŀ��� �۾�����=<font color=red>"��û���"</font>�� �˴ϴ�.<br>
		�� �������="���"�� �������� ������ ��쿡�� ������ �������־�� �մϴ�.<br>
		�� ���� ��ǰ�� "����"���� �����Ǿ�� �մϴ�.<br>
		�� ������ ������ ��쿡�� "����"���� ������ �� �����ϴ�.<br>
		�� ����ڸ� ������ ��� �Ʒ� ���׿� ������ �ּ���.<br>
		��1) �ش� ��û����ȣ�� ��������� <font color=red>�ݵ�� ����</font>�ؾ� �մϴ�.��
		��2) ������ �������� ��� <font color=red>���� ����</font>�� ���� ����� �մϴ�.

		</td>
	</tr>											
</table>
	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	<param name="DataId" value="imgDs">
	<param name=BindInfo    value="
		<C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
		<C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
	">
</object>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
        <C>Col=req_no           Ctrl=req_no             Param=value </C>
        <C>Col=client_sid               Ctrl=client_sid         Param=value </C>
        <C>Col=accept_date              Ctrl=accept_date                Param=text </C>
        <C>Col=accept_time              Ctrl=accept_time                Param=text </C>        
        <C>Col=client_dam_nm            Ctrl=client_dam_nm              Param=value </C>
        <C>Col=mobile_no                Ctrl=mobile_no          Param=value </C>
        <C>Col=depart_date              Ctrl=depart_date                Param=text </C>
        <C>Col=depart_time              Ctrl=depart_time                Param=text </C>        
        <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
        <C>Col=accept_no                Ctrl=accept_no          Param=value </C>
        <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
        <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
        <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
        <C>Col=manage_no                Ctrl=manage_no          Param=value </C>
        <C>Col=company_nm               Ctrl=company_nm         Param=value </C>
        <C>Col=positions                Ctrl=positions          Param=value </C>
        <C>Col=cust_mobile_no                Ctrl=cust_mobile_no          Param=value </C>
        <C>Col=reason           Ctrl=reason             Param=value </C>
		<C>Col=north_cnt        Ctrl=north_cnt               Param=value </C>
		<C>Col=status_cd        Ctrl=lc_status2             Param=BindColVal </C>  
        <C>Col=rsv_status       Ctrl=rsv_status          Param=value </C>	
        <C>Col=m_rsv_sid       Ctrl=mRsvSid               Param=value </C>
		<C>Col=join_cd         Ctrl=lc_JoinCd             Param=BindColVal </C>  
        <C>Col=m_cust_nm          Ctrl=mCustNm            Param=value </C>
	">
</object>
<%=HDConstant.COMMENT_END%>

<input type="hidden" name="row" value="">

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

