<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 출발일 변경
 * 프로그램ID 	 : RV530I
 * J  S  P		 : rv530i
 * 서 블 릿		 : RV530I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-12
 * 기능정의		 : 출발일 변경 (조회, 신규, 저장, 취소, 삭제)
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
		if (ds1.countrow < 1){
			var s_temp1 = "STATUS_CD:STRING,ACCEPT_DATE:STRING,A_ACCEPT_NO:STRING,CUST_NM:STRING,REQ_NO:STRING,CLIENT_SID:INT,CLIENT_DAM_NM:STRING,MOBILE_NO:STRING,A_DEPART_DATE:STRING,A_ACCEPT_SID:INT,RSV_SID:INT,CUST_SID:INT,MANAGE_NO:STRING,A_ROOM_TYPE_SID:STRING,A_ROOM_TYPE_CD:STRING,A_ROOM_TYPE_NM:STRING,A_SAL_AMT:INT,PAY_AMT:INT,DEPART_DATE:STRING,ACCEPT_SID:INT,ACCEPT_NO:STRING,ROOM_TYPE_SID:INT,ROOM_TYPE_CD:STRING,ROOM_TYPE_NM:STRING,SAL_AMT:INT,AMT:INT,REASON:STRING,DESC:STRING,";
			ds1.SetDataHeader(s_temp1);
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
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv530I",
            "JSP(O:IMAGE=imgDs,O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2); 
        //대리점
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
        //작업상태1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset(); 
        //작업상태2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();        
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
            + "sClientSid=" + sClientSid.value + "," 
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
            + "sBgnDate=" + sBgnDate.text + ","                         
            + "sEndDate=" + sEndDate.text;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv530I",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);
    }
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow() {
		if ( sClientSid.value == '0' ) {
			alert("대리점을 선택해 주세요");
			return;
		}
		ds1.addrow();
		ds1.namevalue(ds1.rowposition,"client_sid") = sClientSid.value;
		ds1.namevalue(ds1.rowposition,"accept_date") = '<%=firstday%>';
		lc_status2.index = lc_status2.IndexOfColumn("detail", "RR");
		ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");				
		
		for ( i=1;i<=ds_client_info.CountRow;i++ ) {
			if ( sClientSid.value == ds_client_info.namevalue(i,"client_sid") )  {
				client_dam_nm.value = ds_client_info.namevalue(i,"client_dam_nm");
				mobile_no.value = ds_client_info.namevalue(i,"tel_no");
				break;
			}
		}			
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow() {
		if (ds2.IsUpdated )
			alert("수정중인 행이 있습니다.");	
		else
			ds1.deleterow(ds1.rowposition);
	}
	/*
	 * 적용
	 */
	function fnApply() {
		if ( ds1.isUpdated ) {
			for ( i=1; i<= ds1.CountRow; i++ )  {
				if ( ds1.RowStatus(i) == 1 || ds1.RowStatus(i) == 3 ) {
					if ( ds1.namevalue(i,"a_accept_sid") == '' || ds1.namevalue(i,"a_accept_sid") == '0' ) {
						alert("신청서 번호(변경전)를 입력해 주세요.");
						return;
					}			
					if ( ds1.namevalue(i,"rsv_sid") == '' || ds1.namevalue(i,"rsv_sid") == '0' ) {
						alert("성명을 입력해 주세요.");
						return;
					}
					if ( ds1.namevalue(i,"accept_sid") == '' || ds1.namevalue(i,"accept_sid") == '0' ) {
						alert("신청서 번호(변경후)를 입력해 주세요.");
						return;
					}					
				}
			}		
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv530I",
	             "JSP(I:DEFAULT=ds1,O:reqNoDS=reqNoDS,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * 취소
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
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
	 * 신청서 번호 팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup2(change_div) {    
		if ( change_div == 'nochange' ) {
			if ( sClientSid.value == '0' ) {
				alert("대리점를 선택해 주세요");
				return;
			}             
			if ( a_depart_date.text.trim() == '' ) {
				alert("출발일자를 입력해 주세요.");
				return;
			}             		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rv011h.jsp?sClientSid="+sClientSid.value+"&sADepartDate="+a_depart_date.text;
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	
			arrResult = showModalDialog(strURL,arrParam,strPos);	
	
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	a_accept_sid.value = arrParam[0];
				a_accept_no.value = arrParam[1];
			} else {
		    	a_accept_sid.value = 0;
				a_accept_no.value = '';
			}
		}
		if ( change_div == 'change' ) {
			if ( sClientSid.value == '0' ) {
				alert("대리점를 선택해 주세요");
				return;
			}             
			if ( depart_date.text.trim() == '' ) {
				alert("출발일자를 입력해 주세요.");
				return;
			}             		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rv011h.jsp?sClientSid="+sClientSid.value+"&sDepartDate="+depart_date.text;
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	
			arrResult = showModalDialog(strURL,arrParam,strPos);	
	
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	accept_sid.value = arrParam[0];
				accept_no.value = arrParam[1];
			} else {
		    	accept_sid.value = 0;
				accept_no.value = '';
			}
		}		
	} 	
	/*
	 * 성명(고객정보) 팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup3() { 
		if ( sClientSid.value == '0' ) {
			alert("대리점를 선택해 주세요");
			return;
		} 	
		if ( a_accept_sid.value.trim() == '' || a_accept_sid.value.trim() == '0' ) {
			alert("신청서 번호를 입력해 주세요.");
			return;
		}             
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv012h.jsp?sClientSid="+sClientSid.value+"&sAAcceptSid="+a_accept_sid.value+"&sAcceptDate=&sAcceptTime=";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			rsv_sid.value = arrParam[8];							
	    	cust_sid.value = arrParam[0];				
	    	cust_nm.value = arrParam[1];
	    	manage_no.value = arrParam[2];
			a_room_type_sid.value = arrParam[7];																
			a_room_type_cd.value = arrParam[11];																			
			a_room_type_nm.value = arrParam[12];											
			a_sal_amt.text = arrParam[9];													
			pay_amt.text = arrParam[10];																														
		} else {
			rsv_sid.value = 0;									
	    	cust_sid.value = 0;			
	    	cust_nm.value = '';
	    	manage_no.value = '';
			a_room_type_sid.value = 0;	
			a_room_type_cd.value = '';																			
			a_room_type_nm.value = '';																		
			a_sal_amt.text = 0;													
			pay_amt.text = 0;																
		}
	} 	
	/*
	 * 객실타입 팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup4() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	room_type_sid.value = arrParam[0];
				room_type_cd.value = arrParam[1];
				room_type_nm.value = arrParam[2];					
			} else {
		    	room_type_sid.value = 0;
				room_type_cd.value = '';
				room_type_nm.value = '';
			}
	} 	
	/*
	 * 대리점 자동셋팅(조건)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {
		var exit=false;	
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
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
		</script>
		
		<script language=JavaScript for=gr1 event=OnKeyPress(kcode)>
			if ( kcode == 40 || kcode == 38 ) {
				if ( ds1.isUpdated || ds2.IsUpdated ) {
				} else
						fnSelectDS2();
			}
		</script>		
		
		<script language=JavaScript for= lc_status2 event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");		
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
            var count=1;
            for ( i=1;i<=ds1.CountRow;i++ ) {
            	if ( ds1.namevalue(i,"req_no") == '' )
		            ds1.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds1.ResetStatus();
            
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
		var msg='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        //에러메시지
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);   
		    
        //메시지 처리
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
            var count=1;
            for ( i=1;i<=ds1.CountRow;i++ ) {
            	if ( ds1.namevalue(i,"req_no") == '' )
		            ds1.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds1.ResetStatus();
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
	</script>	
	
	<script language=JavaScript  for=ds_status2 event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";	                	 			 	
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
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >																																								
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
				                <C> name='신청번호(변경전)'    ID='a_accept_no'  width=100 align=center editlimit=15 edit=none show=true</C>															                
				                <C> name='이름'      ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='관리번호'       ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>															                																		
				                <C> name='매출처SID'   ID='client_sid'  align=left editlimit=12 show=false</C>
				                <C> name='담당자'        ID='client_dam_nm'       align=left editlimit=20 show=false</C>
				                <C> name='연락처'    ID='mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='출발일(변경전)'  ID='a_depart_date'         align=left show=false</C>
				                <C> name='신청SID(변경전)'   ID='a_accept_sid'  align=left editlimit=12 show=false</C>
				                <C> name='예약SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
				                <C> name='고객SID'     ID='cust_sid'    align=left editlimit=12 show=false</C>
				                <C> name='주민/여권번호'    ID='manage_no'   align=left editlimit=20 show=false</C>
				                <C> name='객실타입SID(변경전)'        ID='a_room_type_sid'       align=left editlimit=12 show=false</C>															                
				                <C> name='신청객실타입CD(변경전)'       ID='a_room_type_cd'      align=left editlimit=10 show=false</C>
				                <C> name='신청객실타입NM(변경전)'       ID='a_room_type_nm'      align=left editlimit=50 show=false</C>
				                <C> name='판매액'    ID='a_sal_amt'   align=left editlimit=33 show=false</C>
				                <C> name='입금액'      ID='pay_amt'     align=left editlimit=33 show=false</C>
				                <C> name='출발일(변경후)'        ID='depart_date'       align=left show=false</C>
				                <C> name='신청서SID(변경후)' ID='accept_sid'        align=left editlimit=12 show=false</C>
				                <C> name='신청번호(변경후)'  ID='accept_no'         align=left editlimit=15 show=false</C>
				                <C> name='객실타입SID(변경후)'        ID='room_type_sid'       align=left editlimit=12 show=false</C>
				                <C> name='객실타입CD(변경후)' ID='room_type_cd'        align=left editlimit=10 show=false</C>
				                <C> name='객실타입NM(변경후)' ID='room_type_nm'        align=left editlimit=50 show=false</C>
				                <C> name='판매액(변경후)'      ID='sal_amt'     align=left editlimit=12 show=false</C>
				                <C> name='판매자액(변경후)'  ID='amt'         align=left editlimit=12 show=false</C>
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
															<input id="client_dam_nm" type="text" class="textbox"  style="text-align:left;"  value="" size="20">
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연락처</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="textbox" style="text-align:left;"  value="" size="20">
														</td>	
													</tr>		
													<tr>
														<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="4">&nbsp;(변경전)
														</td>
													</tr>																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">출발일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=a_depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="a_accept_sid" type="hidden" value="0">&nbsp;                                
															<input id="a_accept_no" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="신청서번호를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2('nochange');">
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">성명</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">																									
															<input type="hidden" name="cust_sid" value="0">&nbsp;
															<input id="cust_nm" id="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="고객정보를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup3();">																										
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="boardt04"  size="20" style="text-align:left;" value="" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">객실타입</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="a_room_type_sid" type="hidden" value="0">
															<input id="a_room_type_cd" type="hidden" value="">&nbsp;																										
															<input id="a_room_type_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px;color:black; text-align:left;" readonly>																						
														</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="2">&nbsp;
														</td>					
													</tr>																																																																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">판매액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=a_sal_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>						
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">입금액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=pay_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																										
														</td>																										
													</tr>	
													<tr>
														<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="4">&nbsp;(변경후)
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
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;                                																									
															<input id="accept_no" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center"  value="" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="신청서번호를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2('change');">																																																																													
														</td>																									
													</tr>																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">객실타입</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type=hidden id=room_type_sid value="0">																									
															<input type=hidden id=room_type_cd>&nbsp;																																																			
															<input id="room_type_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:left"  value="" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="객실타입을 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">																																																																																																							
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">판매액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=sal_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
													</tr>	
													<tr>
														<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="2">&nbsp;
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">판매차액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>																									
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">사유</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="textbox" style="text-align:left;" size="50" value="">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">처리결과</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left"  colspan="3">&nbsp;
															<input id="desc" type="text" class="boardt04"  style="text-align:left" size="50" value="">
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
	     <C>Col=req_no           Ctrl=req_no             Param=value </C>
	     <C>Col=client_sid               Ctrl=client_sid         Param=value </C>
	     <C>Col=accept_date              Ctrl=accept_date                Param=text </C>
	     <C>Col=status_cd                Ctrl=status_cd          Param=value </C>
	     <C>Col=client_dam_nm            Ctrl=client_dam_nm              Param=value </C>
	     <C>Col=mobile_no                Ctrl=mobile_no          Param=value </C>
	     <C>Col=a_depart_date              Ctrl=a_depart_date                Param=text </C>
	     <C>Col=a_accept_sid               Ctrl=a_accept_sid         Param=value </C>
	     <C>Col=a_accept_no                Ctrl=a_accept_no          Param=value </C>
	     <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
	     <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
	     <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
	     <C>Col=manage_no                Ctrl=manage_no          Param=value </C>
         <C>Col=a_room_type_sid           Ctrl=a_room_type_sid             Param=value </C>	     
         <C>Col=a_room_type_cd           Ctrl=a_room_type_cd             Param=value </C>
         <C>Col=a_room_type_nm           Ctrl=a_room_type_nm             Param=value </C>
         <C>Col=a_sal_amt                Ctrl=a_sal_amt          Param=text </C>
         <C>Col=pay_amt          Ctrl=pay_amt            Param=text </C>
         <C>Col=depart_date            Ctrl=depart_date              Param=text </C>
         <C>Col=accept_sid             Ctrl=accept_sid               Param=value </C>
         <C>Col=accept_no              Ctrl=accept_no                Param=value </C>
         <C>Col=room_type_sid            Ctrl=room_type_sid              Param=value </C>
         <C>Col=room_type_cd             Ctrl=room_type_cd               Param=value </C>
         <C>Col=room_type_nm             Ctrl=room_type_nm               Param=value </C>
         <C>Col=sal_amt          Ctrl=sal_amt            Param=text </C>
         <C>Col=amt              Ctrl=amt                Param=text </C>
         <C>Col=reason           Ctrl=reason             Param=value </C>
         <C>Col=desc             Ctrl=desc               Param=value </C>                      
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    

<input type="hidden" name="row" value="">

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

