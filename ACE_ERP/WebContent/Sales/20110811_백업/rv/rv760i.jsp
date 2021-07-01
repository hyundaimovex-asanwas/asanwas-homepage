<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 통일부번호 생성
 * 프로그램ID 	 : RV760I_00001
 * J  S  P		 : rm760i_00001
 * 서 블 릿		 : RM760I_00001
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-07-07
 * 기능정의		 :  통일부번호 생성 (번호지움, 일괄생성, 조회, 저장, 취소)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-12-02][박경국] 방북 불허자 검색조건 추가
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
        var div='';
	/*
	 * 페이지로딩
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			sBgnDate.text='<%=firstday%>';		
			fnInit();
		}
	/*
	 * 선조회
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
            "JSP(O:DS5=ds5,O:DS8=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //지역코드
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("출발일자를 입력해주세요.");
				return;
			}			
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","1");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
	            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams") + ",";
	            if ( sSRejectYn.checked == true ) 
		            param += "sSRejectYn=Y,";	            	
		        else 
		            param += "sSRejectYn=N,"	            			        
	            param += "sCountryGu=" + ds8.namevalue(ds8.rowposition,"country_gu");	
	            
	            ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * 출경시간, 상품조회
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS3=ds3,O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * 반조회
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text + ","	            
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time");			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  
	/*
	 * 조 조회
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sDepartDate=" + sBgnDate.text + ","	
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","        
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		
	/*
	 * 적용
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
	             "JSP(I:DEFAULT=ds1,O:DS9=ds9)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow() {
		if ( ds1.CountRow < 1 ) {
			alert("최소한 하나 이상의 데이터가 있어야 합니다.");
			return;
		}
		var maxUnityNo = 1;
		var row = 1;
		for ( i=1;i<=ds1.CountRow;i++ ) {
			if ( ds1.namevalue(i,"unity_no").length == 12 && ds1.namevalue(i,"unity_no") != '' ) {
				maxUnityNo = Number(ds1.namevalue(i,"unity_no").substring(8,12));
				row = i;
				break;
			}
		}
		for ( j=1;j<=ds1.CountRow;j++ ) {
			if ( ds1.namevalue(j,"unity_no").length == 12 && ds1.namevalue(j,"unity_no") != '' && ( maxUnityNo < Number(ds1.namevalue(j,"unity_no").substring(8,12)) ) ) {
				maxUnityNo = Number(ds1.namevalue(j,"unity_no").substring(8,12));
				row = j;
			}
		}
//		ds1.addrow();
		for ( k=1;k<=ds1.CountRow;k++ ) {
			if ( ds1.namevalue(k,"unity_no") == '' ) {
				maxUnityNo += 1;					
				if ( maxUnityNo < 10 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "000" + maxUnityNo;
				else if ( maxUnityNo < 100 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "00" + maxUnityNo;						
				else if ( maxUnityNo < 1000 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "0" + maxUnityNo;												
				else
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + maxUnityNo;																				
			}
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
	 * 번호지움
	 */
	function fnEraser() {
		if (ds1.CountRow < 1 ) {
			alert("최소한 하나 이상의 데이터가 있어야 합니다.");
			return;
		}		
        window.status="번호를 지우는 중입니다. 잠시만 기다려 주십시오...";	
		for( i=1; i<=ds1.CountRow; i++ )
			ds1.namevalue(i,"unity_no") = '';		
        window.status="번호지움이 완료 되었습니다.";				
	}		
	/*
	 * 일괄생성
	 */
	function fnCreate() {
		if ( ds1.CountRow < 1 ) {
			alert("최소한 하나 이상의 데이터가 있어야 합니다.");
			return;
		}	
      
      window.status="일괄생성 중입니다. 잠시만 기다려 주십시오...";
      var count=1;
		if(ds2.namevalue(ds2.rowposition,"saup_sid")=="2"){
			count=5001;
		}

		for(i=1;i<=ds1.CountRow;i++ ) {
         ds1.namevalue(i,"data_modify") = 'T';									
         if (count < 10 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "000" + count;
         else if ( count < 100 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "00" + count;						
         else if ( count < 1000 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "0" + count;												
         else
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + count;																		
         count++;
		}
      window.status="일괄생성이 완료되었습니다.";		
	}
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( div != 'init' ) {	//출발일자
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
		if ( div != 'init' ) {	//출경시간
			div = 'init';					
			fnSelectDs6();		
		}
	</script>	
	
	<script language=JavaScript for= lc5 event=OnSelChange()>
		if ( div != 'init' ) {	//반
			div = 'init';					
			fnSelectDs7();		
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            //메시지 처리
            if ( ds9.namevalue(1,"pMsg") != '' )
            	alert(ds9.namevalue(1,"pMsg"));
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
          
        //에러메시지처리
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
		    
		//메시지처리
        if ( ds9.namevalue(1,"pMsg") != '' )
        	alert(ds9.namevalue(1,"pMsg"));		    
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
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
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
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
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr4.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr4.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr4.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	totalNum.value = ds1.CountRow;
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
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

<%
/*=============================================================================
			DataSet Components(DS) 선언
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
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/eraser.gif"   	style="cursor:hand" onclick="fnEraser()">
									<img src="<%=dirPath%>/Sales/images/bundle.gif"		style="cursor:hand" onClick="fnCreate();">																																		
									<img src="<%=dirPath%>/Sales/images/add_create.gif"		style="cursor:hand" onClick="fnAddRow();">			
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr height="50px">
					<td align="left"  colspan='2' width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="710px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d" height=26>
			            					<td align=left class="text" width="70">지역</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left class="text"  width="70"><b>출발일자</b></td>
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
													<param name=SelectAllOnClick  	value="true">		
													<param name=SelectAllOnClickAny  	value="false">																							
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;	
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="depart_time">
                                                    <param name=BindColVal      value="depart_time">
													<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^50"></object>
												<%=HDConstant.COMMENT_END%>																				
											</td>																							
			            					<td align=left class="text" width="70">상품정보</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="goods_sid">
                                                    <param name=BindColVal      value="goods_sid">
													<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;	
											</td>
										</tr>
			                            <tr bgcolor="#6f7f8d" height=26>	
			            					<td align=left class="text" width="70">반/조</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc5 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="class">
                                                    <param name=BindColVal      value="class">
													<param name=EditExprFormat	value="%,%;class,class_nm">
													<param name=ListExprFormat  value="class_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>	
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc6 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
													<param name=BindColumn      value="teams">
                                                    <param name=BindColVal      value="teams">
													<param name=EditExprFormat	value="%,%;teams,teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>																					
											</td>											                            
			            					<td align=left class="text" width="70">고객구분</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
					                            <object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>		
											</td>	
		            						<td align=left class="text" width="70">국적구분</td>
			                                <td align=left bgcolor="#ffffff" valign="middle" colspan="5">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc7 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
													<param name=BindColumn      value="country_gu">
                                                    <param name=BindColVal      value="country_gu">
													<param name=EditExprFormat	value="%,%;country_gu,country_gu_nm">
													<param name=ListExprFormat  value="country_gu_nm^0^120">
												</object>
												<%=HDConstant.COMMENT_END%>	
											</td>	
			            				</tr>		
			            			</table>
			            			<td  id=cancel_cd width="130px">
										<table width='130' border='0' cellpadding='0' cellspacing='0' style='border:1px solid #6f7f8d'>
											<tr >
												<td width='130' height='20'>
													<table width='100%' border='0' cellspacing='0' cellpadding='0'>
														<tr >
															<td width='25' height='25'><input name='sSRejectYn' type='checkbox' value='Y'></td>
															<td>&nbsp;방북 불허자</td>
														</tr >
													</table>							
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
										<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
	                            			<param name="DataID"		VALUE="ds1">
	                            			<param name="BorderStyle"   VALUE="0">
	                            			<param name=ColSizing       value="true">
	                            			<param name="editable"      value="true">
	                            			<param name=UsingOneClick  	value="1">
	                                        <Param Name="AllShowEdit"   value="True">
	                                        <param name="SortView"      value="Right">
											<param name=SuppressOption value=1>								                                        
											<param name="Format" 			value="
								               <C> name='통일부번호'     ID='unity_no'    width=100 align=center editlimit=12 show=true</C>
								               <C> name='반'        ID='class'        BgColor=#fefec0 width=40 align=right editlimit=3 edit=none show=true</C>
								               <C> name='조'        ID='teams'      BgColor=#fefec0 width=40  align=right editlimit=3 edit=none show=true</C>
								               <C> name='객실타입' ID='room_type_cd'     BgColor=#fefec0 width=60   align=center edit=none editlimit=10 show=true</C>
								               <C> name='성명'      ID='cust_nm'     BgColor=#fefec0 width=60 align=left editlimit=30 edit=none sort=true show=true</C>
								               <C> name='주민번호'    ID='manage_no'   BgColor=#fefec0 width=90  align=center editlimit=20 edit=none show=true</C>
								               <C> name='고객구분'   ID='cust_gu_nm'  BgColor=#fefec0 width=60 align=left editlimit=50 edit=none show=true</C>
								               <C> name='주소'     ID='address1'    BgColor=#fefec0 width=170  align=left editlimit=60 edit=none show=true</C>
								               <C> name='예약SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
								               <C> name='기본통일부번호'     ID='default_unity_no'    align=left editlimit=8 show=false</C>
								               <C> name='data_modify'     ID='data_modify'    align=left editlimit=8 show=false</C>															               
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
		<tr id="total">
			<td width="845px" height="30" class="textbox" style="border:0">
				총건수 : <input type="text" name="totalNum" style="border:0;align=left" width="20">
			</td>
		</tr>							
	</table>
	
	<!--------------------------------- 코딩 부분 끝 -------------------------------->	
	
	<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
	
