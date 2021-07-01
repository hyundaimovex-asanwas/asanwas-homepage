<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 승급/FOC/AD
 * 프로그램ID 	 : RV521I
 * J  S  P		 : rv521i
 * 서 블 릿		 : RV521I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-09
 * 기능정의		 : 승급/FOC/AD (조회, 저장, 취소)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   String firstday = m_today.format(date.getTime());		   
%>

<!-- HTML 시작-->
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
	 * 페이지로딩
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			fnInit();
		}
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
		if (selectImgDs.countrow < 1){
			var s_temp1 = "PICTURE_INFO:STRING";
			selectImgDs.SetDataHeader(s_temp1);
		}				
	}
	/*
	 * 선조회
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>'; 
		
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        fnSetHeader();

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	    
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv521I",
            "JSP(O:IMAGE=imgDs,O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);   
        //영업담당자
        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_saldam.Reset();              
        //대리점
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
        //작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset(); 
        //작업상태2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();        
        //작업구분
        ds_job.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV026&s_item1=Y";
        ds_job.Reset(); 
        
	}
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSalDamSid=" + sSalDamSid.value + ","                 
            + "sClientSid=" + sClientSid.value + "," 
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
            + "sBgnDate=" + sBgnDate.text + ","                         
            + "sEndDate=" + sEndDate.text;
		imgDs.ClearData();
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv521I",
            "JSP(O:DS1=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }
	/*
	 * 적용
	 */
	function fnApply() {
		if ( ds1.isUpdated || imgDs.isUpdated ) {
			if ( accept_sid.value.trim() == '' || accept_sid.value.trim() == '0' ) {
				alert("신청서 번호를 입력해 주세요.");
				return;
			}			
			if ( rsv_sid.value.trim() == '' || rsv_sid.value.trim() == '0' ) {
				alert("성명을 입력해 주세요.");
				return;
			}	
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv521I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
	         
			selectImgDs.clearData();
		    selectImgDs.addrow();
		    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(ds1.rowposition,"picture_info");
			selectImgDs.ResetStatus();	 
		}        
	}
	/*
	 * 취소
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			lc_status2.index = lc_status2.IndexOfColumn("detail", ds1.namevalue(	ds1.rowposition,"status_cd"));						
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	/*
	 * 대리점팝업
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
	/*
	 * 영업담당자 팝업
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
	/*
	 * 대리점 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds_saldam' ) {	//영업담당자
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
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
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
	/*
	 * 작업상태 셋팅
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnStatusSet(status) {
		lc_status2.index = lc_status2.IndexOfColumn("detail", status);
	} 		
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
			index=lc_job.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"ad_job_sel"));
			lc_job.index=index;			
			
		    imgDs.RowPosition = Row;							
		</script>
		
		<script language=JavaScript for= lc_status2 event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");		
		</script>	
		
		<script language=JavaScript for= lc_job event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "ad_job_sel") = ds_job.namevalue(ds_job.rowposition, "detail");		
		</script>	
		
		<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
		    	txt_file.value = gcip_file.value;
		    	photo.src = gcip_file.value;
		    }
		</script>	

		<script language=JavaScript for=sBgnDate event=OnKillFocus()> 
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
			}
		</script>		
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        var msg='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            
            //메시지 처리
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 ) 
	          	alert(msg);              
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);    
		    
        //메시지 처리
		var msg='';		    
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);  			             
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
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
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
		lc_status2.index=index;
		index=lc_job.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"ad_job_sel"));
		lc_job.index=index;	
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>	
	

	<script language=JavaScript  for=ds_job event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";	                	 			 	
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
			DataSet Components(DS) 선언
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
<object id=ds_job classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

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
            					<td align=left width=70 class="text">&nbsp;영업담당자</td>
                                <td align=left bgcolor="#ffffff" colspan="5">&nbsp;																										
									<input id="sSalDamSid" type="hidden" value="0">                                
									<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="영업담당자를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
									<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
								</td>		
            				</tr>											                        
                            <tr bgcolor="#6f7f8d">
            					<td align=left width=70 class="text">&nbsp;대리점</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sClientSid" type="hidden" value="0">                                
									<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
								</td>		
            					<td align=left width=70 class="text">&nbsp;작업상태</td>
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
            					<td align=left width=70 class="text">&nbsp;신청일자</td>
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
							<param name="Format" 			value="
				                <C> name='작업상태'    ID='status_cd' width=60  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true</C>																		
				                <C> name='신청일'  ID='accept_date'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX</C>															                															                
				                <C> name='신청번호'    ID='accept_no'  width=100 align=center editlimit=15 edit=none show=true</C>															                
				                <C> name='이름'      ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='관리번호'       ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>															                
				                <C> name='매출처SID'   ID='client_sid'  align=left editlimit=12 show=false</C>
				                <C> name='담당자'        ID='client_dam_nm'       align=left editlimit=20 show=false</C>
				                <C> name='연락처'    ID='mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='출발일'  ID='depart_date'         align=left editlimit=8 show=false</C>
				                <C> name='신청SID'   ID='accept_sid'  align=left editlimit=12 show=false</C>
				                <C> name='예약SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
				                <C> name='고객SID'     ID='cust_sid'    align=left editlimit=12 show=false</C>
				                <C> name='주민/여권번호'    ID='manage_no'   align=left editlimit=20 show=false</C>
				                <C> name='직장명'   ID='company_nm'  align=left editlimit=30 show=false</C>
				                <C> name='직위'    ID='positions'   align=left editlimit=30 show=false</C>
				                <C> name='연락처'    ID='cust_mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='적용금액'  ID='amt'         align=left editlimit=12 show=false</C>
				                <C> name='작업구분'   ID='ad_job_sel'  align=left editlimit=3 show=false</C>
				                <C> name='사유'       ID='reason'      align=left editlimit=200 show=false</C>
				                <C> name='처리결과' ID='desc'        align=left editlimit=200 show=false</C>                
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_status2>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable2  value=false>																																																						
															</object>
															<%=HDConstant.COMMENT_END%>
															<img src="<%=dirPath%>/Sales/images/take_com.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnStatusSet('JO')">
															<img src="<%=dirPath%>/Sales/images/request_can.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnStatusSet('RC')">																																																																								
														</td>																									
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청일</td>
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
															<%=HDConstant.COMMENT_END%>
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">관리번호</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="req_no" type="text" class="boardt04"   value="" size="20" readonly>
														</td>																																																			
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">담당자</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="boardt04"  style="text-align:left;" value="" size="20" readonly>
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연락처</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="boardt04"  style="text-align:left;" value="" size="20" style="text-align:left" readonly>
														</td>	
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">출발일</td>
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
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;                                
															<input id="accept_no" type="text" class="boardt04"  style= "position:relative;left:0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">성명</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">																									
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="boardt04"  size="20" value="" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">직장</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="company_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px;color:black; text-align:left" readonly>																						
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">직위</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="positions" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px; text-align:left;" readonly>																						
														</td>																									
													</tr>																																																																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">연락처</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="cust_mobile_no" type="text" class="boardt04"  size="20" value="" style="text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업구분</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_job classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_job>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^110">
																<param name=Enable2  value=false>																																																																																	
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
													</tr>																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">사유</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="boardt04"  size="50" style="text-align:left;" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">처리결과</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left"  colspan="3">&nbsp;
															<input id="desc" type="text" class="textbox"  style="text-align:left;"  size="50" value="">
														</td>
													</tr>
													<tr>
														<td width="25px" bgcolor="#ffffff" colspan="4">
															<table border="0" cellpadding="0" cellspacing="0" width="300px" height="120px" bgcolor="#666666" style="border:0px solid #6f7f8d">
																<tr bgcolor="#ffffff">
																	<td width="150px" bgcolor="#ffffff">
																		<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="120px">
																	</td>
																	<td width="400px" align="left" bgcolor="#ffffff" align="absmiddle">
                                                                        <input type=hidden name=txt_file>
																		<br><br>
																		<img src="<%=dirPath%>/Sales/images/print.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="pr1.preview();" >																													
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
			</table>
		</td>
	</tr>											
</table>
	
<%
/*=============================================================================
			Bind 선언
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
<%=HDConstant.COMMENT_END%>       
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
	     <C>Col=req_no           Ctrl=req_no             Param=value </C>
	     <C>Col=client_sid               Ctrl=client_sid         Param=value </C>
	     <C>Col=accept_date              Ctrl=accept_date                Param=text </C>
	     <C>Col=status_cd                Ctrl=status_cd          Param=value </C>
	     <C>Col=client_dam_nm            Ctrl=client_dam_nm              Param=value </C>
	     <C>Col=mobile_no                Ctrl=mobile_no          Param=value </C>
	     <C>Col=depart_date              Ctrl=depart_date                Param=text </C>
	     <C>Col=accept_sid               Ctrl=accept_sid         Param=value </C>
	     <C>Col=accept_no                Ctrl=accept_no          Param=value </C>
	     <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
	     <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
	     <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
	     <C>Col=manage_no                Ctrl=manage_no          Param=value </C>
	     <C>Col=company_nm               Ctrl=company_nm         Param=value </C>
	     <C>Col=positions                Ctrl=positions          Param=value </C>
	     <C>Col=cust_mobile_no                Ctrl=cust_mobile_no          Param=value </C>
	     <C>Col=amt              Ctrl=amt                Param=text </C>
	     <C>Col=ad_job_sel               Ctrl=ad_job_sel         Param=value </C>
	     <C>Col=reason           Ctrl=reason             Param=value </C>
	     <C>Col=desc             Ctrl=desc               Param=value </C>                       
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    

<input type="hidden" name="row" value="">
<!-----------------------------------------------------------------------------
					출력물 정의부분
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="DetailDataID"			VALUE="selectImgDs">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='picture_info' ,left=80 ,top=120 ,right=1900 ,bottom=2700</I>
		</B>
	">
	</object> 
<%=HDConstant.COMMENT_END%>  

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

