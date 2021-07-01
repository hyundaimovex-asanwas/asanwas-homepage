<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 인덱스_관광영업
 * 프로그램ID 	: index_sales
 * J  S  P		: index_sales.jsp
 * 서 블 릿		: 
 * 작 성 자		: 심동현
 * 작 성 일		: 2007-08-13
 * 기능정의		: 트리메뉴 적용한 새 관광영업 메인화면
 * 수정내용		: 
 * 수 정 자		: 심동현
 * 최종수정일자 	: 
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="expires" content="0">
    <jsp:include page="common/include/head.jsp"/>
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
		function fnOnLoad(){
			fnInit();
			fnInit_tree(); //트리초기
		}
	/*
	 * 데이타셋 헤더 설정
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "MENU_IDX:INT,PARENT_IDX:INT, SCDNM:STRING,SEQ:INT,LEVEL:INT";
			ds1.SetDataHeader(s_temp1);
		}	
	}
	/*
	 * 선조회
	 */
	function fnInit(){
        v_job = "H";
//        div='init';
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";        		
        
//        ds_lc_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item1=Y";
//        ds_lc_use.Reset();         
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
   	     	+ "menu_level=" + getObjectFirst("menu_level").value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS_MENU=ds_menu)",
            param);
        tr_post(tr1); 		
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {    
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
       	     	+ "menu_level=" + getObjectFirst("menu_level").value;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * 레벨2조회
	 */
    function fnSelectDS3() {
        v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "menu_idx=" + ds_lc1.namevalue(ds_lc1.rowposition,"menu_idx");

        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS3=ds_lc2)",
            param);
        tr_post(tr2);
    }   
	/*
	 * 레벨3조회
	 */		
	function fnSelectDS4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "menu_idx=" + ds_lc2.namevalue(ds_lc2.rowposition,"menu_idx");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS4=ds_lc3)",
            param);
        tr_post(tr3)
	}    
	/*
	 * 행추가(그리드별)
	 */
	function fnAddRow1() {
		if ( ds3.namevalue(ds3.rowposition,"upjang_sid" )==0 || ds3.namevalue(ds3.rowposition,"upjang_sid" )==''  ) 
			alert("영업장 정보를 먼저 선택해주세요.");
		else if ( ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==0 || ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==''  ) 
			alert("동 정보를 먼저 선택해주세요.");			
		else if ( ds4.namevalue(ds4.rowposition,"room_type_sid" )==0 || ds4.namevalue(ds4.rowposition,"room_type_sid" )=='' ) 
			alert("객실타입을 먼저 선택해주세요.");			
		else  {
			ds1.addrow();
			ds1.namevalue(ds1.rowposition,"upjang_sid")=ds3.namevalue(ds3.rowposition,"upjang_sid" );
			ds1.namevalue(ds1.rowposition,"upjang_nm")=ds3.namevalue(ds3.rowposition,"upjang_nm" );			
			ds1.namevalue(ds1.rowposition,"dong_sid")=ds_dong.namevalue(ds_dong.rowposition,"dong_sid" );												
			ds1.namevalue(ds1.rowposition,"room_type_sid")=ds4.namevalue(ds4.rowposition,"room_type_sid" );			
			ds1.namevalue(ds1.rowposition,"room_type_cd")=ds4.namevalue(ds4.rowposition,"room_type_cd" );						
		}
		
	}
	/*
	 * 행삭제(그리드별)
	 */
	function fnDeleteRow1() {
		ds1.deleterow(ds1.rowposition);
	}
	/*
	 * 적용
	 */
	function fnApply() {
		if (ds1.IsUpdated ) {
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
       	     	+ "menu_idx=" + ds_lc3.namevalue(ds_lc3.rowposition,"menu_idx");
       	     	
    	    ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
	            "JSP(I:DS1=ds1)",
	            param);
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
	
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	   if (row < 1 && ( colid=='bgn_date' || colid=='end_date' || colid=='room_view_cd' ) ) {
		   	for(i=1;i<=ds1.CountRow;i++)
	     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
	   }		
	   if (row < 1 && colid=='use_yn' ) {
		   	for(i=1;i<=ds1.CountRow;i++)
		    	ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
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
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
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
	    fnOnProgressEnd();
	</script>
	
	
	<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
        var flag = false;
        if(colid='room_view_cd'){
            for(var i=1; i<=ds5.CountRow; i++){
                if(ds5.NameValue(i, "detail")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "room_view_nm") = ds5.NameValue(i, "detail_nm");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "room_view_nm") = "";
        }		
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

<object id=ds_lc1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_menu classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>

<link rel="stylesheet" href="<%=dirPath%>/Common/css/KIS.css">
<script language=javascript src=<%=dirPath%>/Common/js/fnc_index_sales.js></script>
</head>

<body style=margin:0px ONLOAD="init();">
<!-- progress bar window -->
<iframe id=newsWin frameborder=0 marginwidth=0 marginheight=0 scrolling=no style="BACKGROUND:black; POSITION: absolute;DISPLAY:none;width:200;height:120;left: expression((document.body.clientWidth - 200)/2);top: expression((document.body.clientHeight - 120)/2);background: black;Z-INDEX: 9"></iframe>

<TABLE width=100% height=100% border=0 cellspacing="0" cellpadding="0">
	<TR WIDTH="100%">
	  <TD WIDTH="100%" HEIGHT=130 VALIGN=top><!-- 탑메뉴 -->
		<TABLE CELLPADDING="0" CELLSPACING="0" border=0 width=100%>
		  <TR STYLE="height:42px;">
			<TD><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
		  </TR>
		  <TR STYLE="height:35px;">
			<TD Background=<%=dirPath%>/images/Common/topMenu_back.gif>
				<FONT COLOR=#FFFFFF style="font-weight:bold;padding-left:12px">한채영(2070141)님　[관리본부 > 경리부 > 전산팀]</font>
			</TD>
		  </TR>
		  <TR STYLE="height:3px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		  <TR STYLE="height:49px;">
			<TD>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=center><img src=<%=dirPath%>/images/Common/ti_SETTLE.gif border=0></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM><FONT COLOR=#333333 style="font-size:16px;padding-left:12px">판매가 수정</font></TD>
					<TD ALIGN=right VALIGN=BOTTOM><FONT COLOR=#333333 style="padding-right:12px">홈>관광영업>객실관리>보증금 입금</font></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:1px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		</TABLE>
	  </TD>
	</TR>
	<TR WIDTH="100%">
	  <TD WIDTH="100%" VALIGN=top>
		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E8FFE8 STYLE="border-right:1 solid #DFDFDF;">
				<!-- 레프트 메뉴 패널 -->
				<DIV style='width:100%;height:30px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open여부에 따라 이미지 소스결정...쿠키로 저장할 것.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:300px;padding-left:12px;padding-right:8px;display:;'>
				  <jsp:include page="/erp/Common/jsp/cm010i_1.jsp"  flush="true"/>
				</DIV>
				<!-- 레프트 메뉴 패널 -->
			</TD>
			<TD WIDTH=100% STYLE="padding:12px;" VALIGN=top>
				
				<!-- 본문시작 -->
				<TABLE border=0 cellspacing=0 cellpadding=0 WIDTH=100%>
				  <TR>
					<TD STYLE='border-bottom:1 solid #009999;border-top:6 solid #009999;padding:7px'  BGCOLOR=#E8FFE8 height=60>
						봉ㅇ
					</TD>
				  </TR>
				</TABLE>
				<!-- 본문시작 -->

			</TD>
		  </TR>
		</TABLE>
	  <TD>
	</TR>
<!--
 	<TR HEIGHT=30>
	  <TD WIDTH="100%" STYLE="border-top:1 solid #FFD104">
		<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
		  <TR>
			<TD width=158 ALIGN=center>Message</TD>
			<TD ALIGN=LEFT STYLE="padding-top:2px;padding-left:12px;color:#0000CC" ID=msgText>KIS-WA에 오신 것을 환영합니다.</TD>
		  </TR>
		</TABLE>	  
	  </TD>
	</TR>
-->

</TABLE>
</body>
</html>


