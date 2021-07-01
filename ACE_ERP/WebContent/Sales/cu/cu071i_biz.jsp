<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 방북교육 신청
 * 프로그램ID 	: CU070I
 * J  S  P			: cu070i
 * 서 블 릿		: Cu070i
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-12
 * 기능정의		 : 방북교육및방북증신청 조회,저장
 * [수  정   일  자][수정자] 내용
 * [2006-06-20][이병욱]
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-01-31][심동현] 새 정책에 따라 대폭 수정.
 * [2008-04-21][심동현] 방북교육과 방북증 발급 신청 분리  
 * [2010-04-06][박경국] 방북증발급신청 메뉴(방북교육은 통통 온라인교육으로 진행)
 * [2010-04-16][심동현] 재발급 신청서 업로드 변경(이미지 업로드 42번 서버로)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">

    var v_job = "";
    var today = "";
	<%// 페이지 로딩 %>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
			fnInit(); 
		}
	<%// 초기화 : 고객정보를 얻어온다%>
	function fnInit(){		
        v_job = "H";
        today = new Date();
        if(today.getMonth()<10) {
        	if(today.getDate()<10) {
        		txt_req_dt.text=today.getYear()+"0"+(today.getMonth()+1)+"0"+today.getDate();
        	}
        	else {
        		txt_req_dt.text=today.getYear()+"0"+(today.getMonth()+1)+""+today.getDate();
        	}
        } else {
        	txt_req_dt.text=today.getYear()+""+(today.getMonth()+1)+""+today.getDate();
        };
        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU015";
		ds2.Reset(); //방북작업구분
 		ds3.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU014";
		ds3.Reset(); //방북교육유무
 		ds8.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU016";
		ds8.Reset(); //방북목적		
 		ds9.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds9.Reset(); //지역코드
 		//ds9.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?proType=S&dsType=1";
		//ds9.Reset(); //지역(그리드용)


		//지역(검색조건: 전체포함)
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS_ALL=ds4)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		fnEducDate();
		
		fnSetHeaderDs1();
		
		drp_visit_object.Index = 1;
	}

	<%// 데이터셋 헤더 설정 (디테일)%>
	function fnSetHeaderDs1(){
		if (ds1.countrow<1){
			var s_temp = ""
			+ "CLIENT_NM:STRING,CUST_NM:STRING,MANAGE_NO:STRING,REQ_DT:STRING,EDUC_PLAN_DT:STRING,SAUP_SID:INT,"
			+ "N_EDUC_YN:STRING,N_JOB_GU:STRING,VISIT_OBJECT_CD:STRING,VISIT_OBJECT:STRING,REMARKS:STRING,"
			+ "CLIENT_SID:INT,EDUC_CARD_SID:INT,CUST_SID:INT";
			ds1.SetDataHeader(s_temp);
		}
	};

	
	function fnEducDate() {	
		ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            	"JSP(O:EDUC_PLAN_DT=codeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}

	<%// 메인조회-------------------------------%>
	function fnSelect() {	
        v_job = "S";

        if(ds1.IsUpdated!=false && confirm("지금 현재 작업중인 데이터가 있습니다. 진행하시겠습니까")==false)
            return;
/*        if(txt_client_cd.value=="" || txt_client_sid.value == "") {
        	alert("협력업체코드를 입력하십시오.");
            return;
        }        */
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid=" + txt_client_sid.value												// 거래처 아이디
                 // + ",sEducPlanDt=" + txt_educ_dt.text											// 교육일자
				  + ",sVisitObjCd=" + drp_visit_object.ValueOfIndex("detail", drp_visit_object.Index)				// 방북목적코드
                 // + ",sSaupSid=" + drp_saup_sid_s.ValueOfIndex("saup_sid", drp_saup_sid_s.Index)		// 사업소 SID
                  + ",sCustNm=" + txt_cust_nm.value																						// 고객명 
                  + ",sManageNo=" + txt_manage_no.value;	
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}

	<%//협력업체 키보드로 조회------------------------------------------%>
	function fnSelectDs11() {
		if(txt_client_cd.value!=""&&txt_client_nm.value=="") {
			ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?proType=S&dsType=1&keyWord="+txt_client_cd.value+"&gubun=2" ;
			ds5.Reset();
		}
	}

	<%//협력업체정보 조회--------------------------------------------%>
	function fnSelectDs13() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=4"
                  + ",sClientSid=" + txt_client_sid.value;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
            "JSP(O:DEFAULT=ds7)",
            param);
        tr_post(tr2);
	}
	<%// 행추가 (그리드별)--------------------------------------------%>
	function fnAddRow() {
        if(txt_client_cd.value=="" || txt_client_sid.value == "") {
        	alert("협력업체코드를 입력하십시오.");
            return;
        }	
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"req_dt")=txt_req_dt.text;	//신청일자
		ds1.namevalue(ds1.rowposition,"n_job_gu")=drp_n_job_gu.ValueOfIndex ("detail", drp_n_job_gu.Index);//작업구분
		ds1.namevalue(ds1.rowposition,"visit_object_cd")=drp_visit_object.ValueOfIndex ("detail", drp_visit_object.Index); //방북목적구분(세팅값)
		ds1.namevalue(ds1.rowposition,"visit_object")= getObjectFirst("txt_visit_object").value ;	//방북목적
		ds1.namevalue(ds1.rowposition,"client_sid") = txt_client_sid.value;
		ds1.namevalue(ds1.rowposition,"client_nm") = txt_client_nm.value;
		ds1.namevalue(ds1.rowposition,"educ_card_sid") = 0;
		ds1.namevalue(ds1.rowposition,"saup_sid") = drp_saup_sid.ValueOfIndex ("saup_sid", drp_saup_sid.Index); //지역세팅
		//ds1.namevalue(ds1.rowposition,"educ_plan_dt")=txt_educ_plan_dt.ValueOfIndex("title_nm",txt_educ_plan_dt.Index);//교육예정일자
		//ds1.namevalue(ds1.rowposition,"n_educ_yn")="2";	//교육유무(==2)		
	}
	<%//행삭제 (그리드별)--------------------------------------------%>
	function fnDeleteRow() {
		ds1.DeleteRow(ds1.RowPosition);
	}
	<%//적용 --------------------------------------------%>
	function fnApply() {
		if (ds1.IsUpdated) {
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu071I",
                "JSP(I:DS1=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,sDrp_n_job_gu="+drp_n_job_gu.ValueOfIndex("detail", drp_n_job_gu.Index)
                + ",sClientSid="+txt_client_cd.value
                );
        		tr_post(tr1);
		}	
	}
	<%//취소--------------------------------------------%>
	function fnCancel() {
	 	ds1.UndoAll();
	}
		
	<%//인쇄 (사용안함)--------------------------------------------%>
	function fnPrintDs1() {
	
	}
	<%//엑셀 (사용안함)--------------------------------------------%>
	function fnExcelDs1() {

	}

	<%// 인원 팝업 : 인원 그리드에서 --------------------------------------------%>
	function fnCustPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv004h.jsp?sClientSid="+txt_client_sid.value;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	   		ds1.namevalue(ds1.rowposition,"cust_sid") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition,"cust_nm") = arrParam[1];
	   		ds1.namevalue(ds1.rowposition, "manage_no") = arrParam[2];
	   		
	   		for (row2 = 1; row2 < ds1.countrow; row2++) {
   				if (ds1.namevalue(row2,"cust_sid") == arrParam[0]) {
   					alert("인원을 중복 등록할수 없습니다!");
		   			ds1.namevalue(ds1.rowposition,"cust_sid") = "";
			   		ds1.namevalue(ds1.rowposition,"cust_nm") = "";
			   		ds1.namevalue(ds1.rowposition, "manage_no") = "";
	   		
   					return;
   				}
   			}
		} else {
   			ds1.namevalue(ds1.rowposition,"cust_sid") = "";
	   		ds1.namevalue(ds1.rowposition,"cust_nm") = "";
	   		ds1.namevalue(ds1.rowposition, "manage_no") = "";
		}				
	}			 	 

	<%// Description :  입력값 체크 --------------------------------------------%>
	function fnCheck() {
	}
	<%// Description :  화일명 체크 --------------------------------------------%>
	function fnDivide(str, delim){
	}

	<%// Description :  협력업체코드 Help --------------------------------------------%>
    function fnClientSidPopup() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
            
        strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=2";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");        
            txt_client_sid.value= arrParam[0];
            txt_client_nm.value= arrParam[1];
            txt_client_cd.value = arrParam[2];
          	fnSelectDs13();
        } else {

        }       
    }
    
	<%//2010-04-16 재발급 신청서 업로드창 ------------------------------------------%>
	function fnUploadPop_again(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/again_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
    
    
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
==============================ㅇ===============================================*/
%>

<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	if (Row != 0 && Colid=="cust_nm") {
		fnCustPopup();
	}
	
    if(Row==0) {	//제목줄을 클릭했을때.
    
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        
        //교육유무							작업구분									목적구분
        if(Colid=="n_educ_yn" || Colid=="visit_object_cd" || Colid=="n_job_gu"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        gr1.Redraw = "True";
        return;
    }
	
//	if (colid=="n_card_no") {
//		fnNcardPopup();
//	}		                              
//    if (colid=="room_type_cd") {		
//		fnRoomTypePopup();
//	}
/*
	var flag = ds1.namevalue(Row,"n_educ_yn");
	//선택을 체크하면 세팅 값으로 입력되게
	if(Colid=="job_sel") {
		if(ds1.namevalue(Row,"job_sel")=="T") {	//선택이면
			ds1.namevalue(Row,"req_dt")=txt_req_dt.text;	//신청일자
			ds1.namevalue(Row,"educ_plan_dt")=txt_educ_plan_dt.ValueOfIndex("title_nm",txt_educ_plan_dt.Index);//교육예정일자
			ds1.namevalue(Row,"saup_sid")=drp_saup_sid.ValueOfIndex ("saup_sid", drp_saup_sid.Index);//지역
			ds1.namevalue(Row,"n_job_gu")=drp_n_job_gu.ValueOfIndex ("detail", drp_n_job_gu.Index);//작업구분
			ds1.namevalue(Row,"n_educ_yn")="2";	//교육유무(==2)
			ds1.namevalue(Row,"visit_object_cd")="01";	//방북목적구분
			ds1.namevalue(Row,"visit_object")= getObjectFirst("txt_visit_object").value ;	//방북목적구분
		} else {
			if (ds1.namevalue(Row,"n_educ_yn")=="2") {
				ds1.namevalue(Row,"educ_plan_dt")="";
				ds1.namevalue(Row,"saup_sid")="";
				ds1.namevalue(Row,"req_dt")="";
				ds1.namevalue(Row,"n_job_gu")="";
				ds1.namevalue(Row,"n_educ_yn")="1";	//미교육(==1)
				ds1.namevalue(Row,"visit_object_cd")="";	//방북목적구분
				ds1.namevalue(Row,"visit_object")="";
			} else {
				 ds1.Undo(ds1.RowPosition);
			}
		};
	};*/
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<script language="javascript" for="tr1" event="OnSuccess()">
    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);        
</script>
<script language="javascript" for="tr1" event="OnFail()">
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert("서버로부터 다음과 같은 오류 메시지를 출력했습니다.\n\n" + error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>
<script language="javascript" for="tr2" event="OnSuccess()">
    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr2.SrvErrMsg("INFO", i);
    }
    if(info_msg!="") 
        window.status="============= 안내 메시지=============" + info_msg;
</script>
<script language="javascript" for="tr2" event="OnFail()">
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        window.status="서버로부터 다음과 같은 오류 메시지를 출력했습니다." + error_msg;
    else
        window.status="Error Code : " + tr2.ErrorCode + ", Error Message : " + tr2.ErrorMsg;
</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	
	</script> 
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();    
	    if(v_job == "H") return; //fnInit();
	    if( row < 1){
	       window.status = "조회할 내용이 없습니다."; 
	    }
	    else
	    	window.status="조회가 완료되었습니다.";
	    gr1.ReDraw = "True";
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
	</script>
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
        photo.src  = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO_FULL").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO_FULL")+"_재발급.JPG";

	</script>
	
	
	<script language=JavaScript  for=ds2 event="OnLoadStarted()">
	    window.status="조회중입니다. 잠시만 기다려 주십시오...";
	</script> 
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "조회가 완료되었습니다.";
	</script>
	<script language=JavaScript  for=ds2 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="조회 중에 오류가 발생했습니다.";
	</script>    
	<script language=JavaScript  for=ds3 event="OnLoadStarted()">
	    window.status="조회중입니다. 잠시만 기다려 주십시오...";
	</script> 
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "조회가 완료되었습니다.";
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="조회 중에 오류가 발생했습니다.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadStarted()">
	    window.status="조회중입니다. 잠시만 기다려 주십시오...";
	</script> 
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "조회가 완료되었습니다.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="조회 중에 오류가 발생했습니다.";
	</script>
	<script language=JavaScript  for=ds5 event="OnLoadStarted()">
	    window.status="조회중입니다. 잠시만 기다려 주십시오...";
	</script> 
	<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
	    if(ds5.namevalue(ds5.rowposition,"client_nm")!=undefined) {
	    	txt_client_sid.value=ds5.namevalue(ds5.rowposition,"client_sid");
	    	txt_client_nm.value=ds5.namevalue(ds5.rowposition,"client_nm");
	    }
	    fnOnProgressEnd();
		window.status = "조회가 완료되었습니다.";
		fnSelectDs13();
	</script>
	<script language=JavaScript  for=ds5 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="조회 중에 오류가 발생했습니다.";
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
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- 협력업체코드 키보드검색 -->
	<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- 협력업체코드 검색 -->
	<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- 방북목적구분 -->
	<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- 지역(그리드용) -->
	<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><!-- 방북교육 신청일 -->
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

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width=845 align="right" height="25px">
			<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">					<!-- 조회 -->
			<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" align=absmiddle onClick="fnAddRow()" >				<!-- 행추가 -->
			<img src="<%=dirPath%>/Sales/images/minus.gif" 	style="cursor:hand" align=absmiddle onClick="fnDeleteRow()" >		<!-- 행삭제 -->
			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">					<!-- 저장 -->
			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">&nbsp;&nbsp;<td>			<!-- 취소 -->
	</tr>
	<tr>
		<td>
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="840px">
				<tr height=25px>
					<td width=20px align=center rowspan=2 bgcolor="#303030" style="color:#ffffff;weight:heavy;">검<br>색</td>
					<td align="center" width="100px" class="text">협력업체코드</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input id="txt_client_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:1px;width:40px; height:18px" maxlength="10" onchange="txt_client_sid.value='',txt_client_nm.value=''" onblur="fnSelectDs11()" onkeyup="this.value=this.value.toUpperCase()">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="협력업체를 검색합니다" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="fnClientSidPopup();">
						<input id="txt_client_nm" type="text" class="boardt04"  style= "position:relative;left:0px;top:3px;color:black;width:100px; height:20px;" maxlength="50" readonly>
						<input id="txt_client_sid" type="hidden">
					</td>
					<td align="center" width="100px" class="text">목적구분</td>
					<td bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_visit_object classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
						<param name=ComboDataID     value=ds8>
						<param name=SearchColumn    value="detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^140">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>					
				</tr>
				<tr height="25px">
					<td align="center" width="100px" class="text">성명</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input type="text" name="txt_cust_nm" size="15" maxlength="30" class="textbox"></td>
					<td align="center" width="100px" class="text">주민/여권번호</td>
					<td align="left" bgcolor="#ffffff" colspan=3>&nbsp;
						<input type="text" name="txt_manage_no" size="15" maxlength="20" class="textbox" onkeyup="this.value=this.value.toUpperCase()"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="5px">
		<td></td>										
	</tr>
	<tr>
		<td valign="top">
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="840px">
				<tr height=25px>
					<td width=20px align=center rowspan=2 bgcolor="#303030" style="color:#ffffff;weight:heavy;">세<br>팅</td>
					<td align="center" width="100px" class="text">신청일자</td>
					<td bgcolor="#ffffff">&nbsp;
					<%=HDConstant.COMMENT_START%>
 					<object id=txt_req_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style= "position:relative;left:0px;top:1px;width:70px; height:18px"  align='absmiddle' class='textbox'>            
  						<param name=Format      value="YYYY-MM-DD">
   						<PARAM NAME=InputFormat value="YYYYMMDD">
   						<param name=Alignment   value=1>
   						<param name=ClipMode    value=true>
 						<param name=Border      value=false>
 						<param name=readonly   value=true>
 					</object>
 					<%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text" >방북작업구분</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_n_job_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
	                        <param name=ComboDataID     value=ds2>
	                        <param name=SearchColumn    value="detail_nm">
	                        <param name=ListExprFormat  value="detail_nm^0^100">
	                        <param name=Enable  value="true">
	                    </object>
	                    <%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text">지역</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds9>
                        	<param name=SearchColumn    value="saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^150">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr height='25px'>
					<td align="center" width="100px" class="text">목적구분</td>
					<td bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
	                    <object id=drp_visit_object1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
						<param name=ComboDataID     value=ds8>
						<param name=SearchColumn    value="detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^140">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>					
	    			<td align="center" width="100px" class="text">방북목적</td>
					<td bgcolor='#ffffff' colspan=3>&nbsp;
	                    <input type=text id=txt_visit_object maxlength=32 class="textbox" OnKeyUp="cfLengthCheck(this, 32);" style="width:150px">
	                </td>
				</tr>		
			</table>
		</td>
	</tr>
	<tr height="5px">
		<td></td>										
	</tr>
	<tr>
		<td width="100%">
			<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
				<tr>
					<td  valign="top">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width=710>
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=710px; height:300px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
									    <param name=UsingOneClick  		value="1">
									    <param name=ViewSummary  		value="1">
                                        <param name="Format"            value=" 
                                            <FC> name='업체명'			ID='client_nm'      Width=60 align=left edit=none</FC>
                                            <FC> name='성명'			ID='cust_nm'        Width=60 align=left editstyle=popup sumtext=계 BgColor=#fefec0</FC>
									        <FC> name='주민/여권번호'	ID='manage_no'      Width=80  align=left edit=none sumtext=@cnt</FC>
                                            <C> name='신청일자'			ID='req_dt'         Width=80 	align=center mask=XXXX-XX-XX edit=none</C>
									        <C> name='지역'           	ID='saup_sid'       Width=50  align=left editstyle=lookup data='ds9:saup_sid:saup_nm' BgColor=#fefec0</C>
									        <C> name='작업구분'			ID='n_job_gu'    	Width=90  align=center editstyle=lookup data='ds2:detail:detail_nm' edit=none</C>
                                            <C> name='목적구분√'		ID='visit_object_cd'	Width=100  align=center editstyle=Lookup data='ds8:detail:detail_nm' BgColor=#fefec0</C>
                                            <C> name='방북목적'			ID='visit_object'	Width=120  	align=Left edit=true BgColor=#fefec0</C>
                                            <C> name='참고'				ID='remarks'		Width=120  	align=Left edit=true BgColor=#fefec0</C>
                                            <C> name='educ_card_sid'	ID='educ_card_sid'	Width=120  	align=Left edit=true show=false</C>
                                            <C> name='cust_sid'			ID='cust_sid'		Width=120  	align=Left edit=true show=false</C>
									    ">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
								<td valign=top width=130 align=center><!-- 추가표 2010-04-16 -->
								
					<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_again()" style="cursor:hand">재발급<br>신청서</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="113px"></td>
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
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>