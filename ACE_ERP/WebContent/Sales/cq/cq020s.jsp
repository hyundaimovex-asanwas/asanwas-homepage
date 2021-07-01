<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 사진명단
 * 프로그램ID 	: CQ020S
 * J  S  P		: cq020s
 * 서 블 릿		: Cq020S
 * 작 성 자		: 구자헌
 * 작 성 일		: 2006-06-22
 * 기능정의		: 사진명단 조회,저장
 * 수정내용		: 검색조건변경
 * 수 정 자		: 심동현
 * 최종수정일자 	: 2006-10-23
 * TODO			: 그리드에 상태값 추가
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-12-04][심동현] 개성 사진명단 액셀 출력 부분 추가..ㅠ_ㅠ;; 
 * [2008-09-04][심동현] 개성 사진명단 액셀 출력 겁내 수정
 * [2008-11-05][심동현] 개성 사진명단 액셀 출력 : 사진경로 서버 변경으로 42번 서버로 수정. 휴우..
 *						ASP에서 받은 파일은 멋지게 표시는 되나 이미지를 개체로 저장하지 못함..
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
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
        var v_job = "H";
        var div='';

		get_cookdata();
	/*
	 * Description 	:  페이지 로딩 
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		txt_depart_date.text='<%=firstday%>';
		fnInit();
	}

	/*
	 * Description : 초기화
	 * 고객정보를 얻어온다
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //지역코드
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        //예약상태
          ds8.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU001&s_item1=Y";
          ds8.Reset();

		drp_cust.style.display="none";
		bizChk.style.display="none";          
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  메인조회
// Parameter 	: 
%>
	function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
		} else {        
			if ( txt_depart_date.text.trim() == '' ) {
				alert("출발일자를 입력해주세요.");
				return;
			}			
	        v_job = "S";
	      
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
			       	+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
					+ "sDepartDate=" + txt_depart_date.text + ","
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
					+ "sPageNo=" + txt_page_no.value + ","
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index);
					
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq020S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
	}

	/*
	 * 출경시간, 상품조회
	 */		
	function fnSelectDs3() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
	 * 반조회
	 */		
	function fnSelectDs6() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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
	 * 조 조회
	 */		
	function fnSelectDs7() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
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

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 (그리드별)
// Parameter 	: 
%>
	function fnAddRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행삭제 (그리드별)
// Parameter 	: 
%>
	function fnDeleteRow() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>
	function fnApply() {

	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
	function fnCancel() {

	}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  인쇄(금강산만)
%>
	function fnPrint() {
		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//금강산이면
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
				+ "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + ","
				+ "sDepartDate=" + txt_depart_date.text + ","
				+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + ","
				+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + ","
				+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + ","
				+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + ","
				+ "sPageNo=" + txt_page_no.value;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq020S",
	            "JSP(O:DEFAULT=ds9)",
	            param);
			 fnOnProgressStart();
	        tr_post(tr1);
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//개성이면
			alert("개성 사진명단은 인쇄되지 않습니다.");		
			return;
		}
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description : 파일복사 (개성만)
%>
	function fnCopy() {
		if(ds1.RowCount==0){
			alert("데이터를 먼저 조회하시길 바랍니다.");
			return;
		}

		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//금강산이면
			alert("개성 상품만 복사 가능합니다.");
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//개성이면
		  //사진 경로 바뀌면서 42번 서버 asp로 변경
	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked	//true||false
					+ "&UID=" + GetCookie("vusrid");	
		
		  var url = "http://203.242.32.42/pic_copy.asp?"
					+ param;
	
//			windows.open window.location= url;	//이렇게 하면 xml로 해서 액셀을 받을 수 있습니다.~

		  sw = screen.width;  // to center: use desired width
		  sh = screen.height;  // to center: use desired height
		  cx = (sw-300) * 0.5  // to center: (.5*sw) - (w*.5)
		  cy = (sh-80) * 0.5  // to center: (.5*sh) - (h*.5)
		  window.open(url,"fotoCopy","width=300,height=80,top="+cy+",left="+cx+",titlebar=0");
		}
	}


<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀(금강산=그리드 다운, 개성=사진명단 파일 작성)
%>
	function fnExcel() {
		if(ds1.RowCount==0){
			alert("데이터를 먼저 조회하시길 바랍니다.");
			return;
		}

		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){//금강산이면
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:사진명단; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("사진명단", "사진명단.xls", 8);
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){//개성이면
		  //사진 경로 바뀌면서 42번 서버 asp로 변경
/*	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked	//true||false
					+ "&i=1";	
		
		  var url = "http://203.242.32.42/ks_pic_list.asp?"
					+ param;
			window.location= url;	//이렇게 하면 xml로 해서 액셀을 받을 수 있습니다.~*/
		
	      var param = "sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index) + "&"
					+ "sDepartDate=" + txt_depart_date.text + "&"
					+ "sDepartTime=" + drp_depart_time.ValueOfIndex("depart_time",drp_depart_time.Index) + "&"
					+ "sGoodsSid=" + drp_goods_sid.ValueOfIndex("goods_sid",drp_goods_sid.Index) + "&"
					+ "sClass=" + drp_class.ValueOfIndex("class",drp_class.Index) + "&"
					+ "sTeams=" + drp_teams.ValueOfIndex("teams",drp_teams.Index) + "&"
					+ "sPageNo=" + txt_page_no.value + "&"
					+ "sCustGu=" + drp_cust.ValueOfIndex("detail",drp_cust.Index) + "&"
					+ "sBizChk=" + bizChk.checked;	//true||false			
	        var stat = "resizable=yes,scrollbars=yes,status=no,toolbar=no,personalbar=yes,menubar=no,locationbar=yes,top=10,left=172,width=720,height=700";
	        var url =  "cq021s.jsp?"+param;	        
			window.open(url,'PSN', stat );
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  분류명 팝업 (사용안함)
%>
	function fnPopup() {
		
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  입력값 체크 
%>
	function fnCheck() {
	
	}	
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  화일명 체크
%>
	function fnDivide(str, delim){

	}

<%
//////////////////////////////////////////////////////////////////////////////
//	Description : Dataset Head 설정
%>
	function fnSetDataHeader() {

	}


	//지역선택시 추가 검색조건 보이기
	function fnShow(){
		if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==1){
			drp_cust.style.display="none";
			bizChk.style.display="none";          
		}else if(drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)==2){
			drp_cust.style.display="";
			bizChk.style.display="";          
		}
	}
	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=txt_depart_date event=OnKillFocus()>
		if ( div != 'init' ) {	//출발일자
			if ( txt_depart_date.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for=drp_saup_sid event=OnSelChange()>
		if ( div != 'init' ) {	//지역
			div = 'init';			
			fnSelectDs3();
			fnShow();		//개성추가 검색조건 보이기.
		}
	</script>	
	<script language=JavaScript for=drp_goods_sid event=OnSelChange()>
		if ( div != 'init' ) {	//상품 
			div = 'init';
			fnSelectDs6();		
		}
	</script>	
	<script language=JavaScript for=drp_depart_time event=OnSelChange()>
		//if ( div != 'init' ) {	//출경시간
		//	div = 'init';
		//	fnSelectDs6();		
	//	}
	</script>	

	<script language=JavaScript for=drp_class event=OnSelChange()>
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
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr3" event="onsuccess()">
         document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr3" event="onfail()">
         document.all.LowerFrame.style.visibility="hidden";	                	
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        document.all.LowerFrame.style.visibility="hidden";	                	
        if(v_job=="I") {
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        document.all.LowerFrame.style.visibility="hidden";	                	
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
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
</object><%--레포트--%>

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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="840px"  cellpadding="0" cellspacing="0">
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:pointer" align=absmiddle onclick="fnPrint()">
									<img src="<%=dirPath%>/Sales/images/download_no.gif"	style="cursor:pointer" align=absmiddle onClick="fnCopy();">
									<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:pointer" align=absmiddle onClick="fnExcel();">&nbsp;&nbsp;
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
											<td align="center" width="80px" class="text">지역</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
		                             			<%=HDConstant.COMMENT_START%>
												<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
		                                        	<param name=SearchColumn    value="saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">출발일자</td>
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
													<param name=ListExprFormat  value="depart_time_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text" >상품정보</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_goods_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
          							              	<param name=SearchColumn    value="goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">반/조</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
                						        	<param name=SearchColumn    value="class_nm">
													<param name=ListExprFormat  value="class_nm^0^60">
												</object>
												<object id=drp_teams classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
          							              	<param name=SearchColumn    value="teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^60">
												</object>
												<%=HDConstant.COMMENT_END%>
												&nbsp;</nobr>
											</td>																				
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
											<td align="center" width="80px" class="text">Page</td>
											<td align="left" bgcolor="#ffffff" colspan="3"><nobr>&nbsp;
												<input type="text" name="txt_page_no" size="11" maxlength="20" class="textbox">
												&nbsp;</nobr>
											</td>
											<td align="center" width="80px" class="text">보장성원</td>
											<td align="center" bgcolor="#ffffff"><input type=checkbox name=bizChk id=bizChk></td>
											<td align="center" width="80px" class="text">고객구분</td>
											<td align="left" bgcolor="#ffffff"><nobr>&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=drp_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=50 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
                						        	<param name=SearchColumn    value="detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80">
												</object>
												<%=HDConstant.COMMENT_END%>
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
										<param name="Format"            value=" 
                                            <C> name='순번'         ID='{CURROW}'            Width=40  align=center edit=none</C>
                                            <C> name='반'           ID='class'              Width=50  align=center edit=none</C>
									        <C> name='조'           ID='teams'          	Width=50  align=center edit=none</C>
									         <C> name='관광증'         ID='tour_no'            Width=40  align=center edit=none</C>
									         <C> name='Page'         ID='page_no'            Width=40  align=center edit=none</C>
									        <C> name='상태'         ID='STATUS_CD'        	Width=40  align=center edit=none</C> 
									        <C> name='성명'         ID='cust_nm'        	Width=70  align=left edit=none</C>
									        <C> name='성별'      	ID='sex'            	Width=45  align=center edit=none</C>
									        <C> name='생년월일'     ID='birthday'       	Width=75  align=center edit=none mask=XXXX.XX.XX</C>
									        <C> name='직장/직위'    ID='comp_nm'            Width=100  align=left edit=none</C>
                                            <C> name='사는곳'       ID='address1'           Width=120  align=Left edit=none</C>
									        <C> name='국적/민족'    ID='country_cd'       	Width=80  align=left edit=none</C>
									        <C> name='여권번호'     ID='pass_no'        	Width=95  align=left edit=none</C>
									        <C> name='관광번호'     ID='tour_code'       	Width=95  align=left edit=none</C>
									        <C> name='신청서번호'     ID='ACCEPT_NO'       	Width=120  align=left edit=none mask=XXXXX-XXXXXXXXX</C>
									        <C> name='대리점명'     ID='CLIENT_NM'       	Width=120  align=left edit=none</C>
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
		<td><br>
		※ 보장성원, 고객구분 선택항목은 지역=개성일 때에만 나타납니다.<br>
		※ 조=전체 + 고객구분=선택 : 전체 명단이 출력됩니다. [개성 당일 관광 명단 (YYYY.MM.DD)]<br>
		※ 조=선택 : 해당 조만 출력됩니다. [개성 당일 관광객 명단 반명 xx조 (YYYY.MM.DD)]<br>
		※ 보장성원 선택 + 고객구분=사업자 : 보장성원만 전원 출력됩니다. [개성 당일 보장성원 명단 (YYYY.MM.DD)]<br>
		</td>
	</tr>
	
</table>

<!-----------------------------------------------------------------------------
					출력물 정의부분
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=154 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='doc_title' ,left=705 ,top=11 ,right=1344 ,bottom=92 ,face='굴림' ,size=16 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=175 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1958 ,top=16 ,right=24 ,bottom=16 </L>
	<L> left=1958 ,top=95 ,right=24 ,bottom=95 </L>
	<L> left=1961 ,top=175 ,right=26 ,bottom=175 </L>
	<L> left=688 ,top=16 ,right=688 ,bottom=175 </L>
	<L> left=26 ,top=16 ,right=26 ,bottom=175 </L>
	<L> left=1958 ,top=16 ,right=1958 ,bottom=175 </L>
	<T>id='관  광  기  간' ,left=185 ,top=108 ,right=532 ,bottom=164 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='~' ,left=1217 ,top=106 ,right=1246 ,bottom=161 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='arrive_date', left=1244, top=106, right=1458, bottom=161 ,mask='XXXX.XX.XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='depart_date', left=1005, top=106, right=1220, bottom=161 ,mask='XXXX.XX.XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='관  광  단  체  명' ,left=185 ,top=29 ,right=532 ,bottom=85 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='nights_days', left=1455, top=106, right=1643, bottom=161, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='team_nm1', left=826, top=29, right=1892, bottom=85, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1958 ,top=476 ,right=24 ,bottom=476 </L>
	<L> left=344 ,top=397 ,right=26 ,bottom=397 </L>
	<L> left=1958 ,top=357 ,right=341 ,bottom=357 </L>
	<L> left=1961 ,top=238 ,right=344 ,bottom=238 </L>
	<L> left=344 ,top=0 ,right=344 ,bottom=479 </L>
	<L> left=609 ,top=0 ,right=609 ,bottom=479 </L>
	<L> left=26 ,top=0 ,right=26 ,bottom=476 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=479 </L>
	<L> left=1958 ,top=119 ,right=344 ,bottom=119 </L>
	<L> left=1588 ,top=241 ,right=1588 ,bottom=479 </L>
	<L> left=1588 ,top=0 ,right=1588 ,bottom=119 </L>
	<T>id='성명' ,left=384 ,top=32 ,right=572 ,bottom=87 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=1360 ,top=32 ,right=1553 ,bottom=87 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='birthday', left=1614, top=32, right=1934, bottom=87 ,mask='XXXX.XX.XX', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직장/직위' ,left=384 ,top=151 ,right=572 ,bottom=209 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1323 ,top=241 ,right=1323 ,bottom=479 </L>
	<T>id='사는곳' ,left=386 ,top=270 ,right=574 ,bottom=328 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='address1', left=635, top=270, right=1299, bottom=325, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='국적/민족' ,left=1363 ,top=270 ,right=1550 ,bottom=331 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='country_cd', left=1614, top=270, right=2134, bottom=325, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='여권종류' ,left=384 ,top=392 ,right=572 ,bottom=447 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='pass_type', left=635, top=392, right=955, bottom=447, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='여권번호' ,left=1363 ,top=389 ,right=1550 ,bottom=447 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='pass_no', left=1614, top=392, right=1934, bottom=447, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1323 ,top=0 ,right=1323 ,bottom=119 </L>
	<C>id='cust_enm', left=635, top=58, right=1299, bottom=114, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm2', left=635, top=5, right=1299, bottom=61, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='cust_nm1', left=635, top=32, right=1299, bottom=87, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_nm2', left=635, top=127, right=1299, bottom=183, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='comp_enm', left=635, top=180, right=1599, bottom=235, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='tour_no', left=26, top=410, right=347, bottom=466, face='굴림', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='picture_info' ,left=40 ,top=13 ,right=336 ,bottom=389</I>
	<C>id='comp_nm1', left=635, top=153, right=1299, bottom=209, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='skip', left=1318, top=151, right=1929, bottom=206, supplevel=1, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#FFFFFF, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=2815 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='page_no', left=712, top=0, right=1323, bottom=56, supplevel=2, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
	</object> 

<%=HDConstant.COMMENT_END%>      

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

