<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 입금/미입금자 조회
 * 프로그램ID       : RV330I
 * J  S  P      : Rv330i
 * 서 블 릿        : Rv330i
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-06-28
 * 기능정의     : 입금/미입금자 조회
 * 수정내용     : 
 * 수 정 자        : 김영민
 * 최종수정일자   : 2006-06-28 
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-02-20][심동현] 출발일자 복사 스크립팅 
 *										예약 확인증 팝.. 넣기.
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
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
    String firstday = m_today.format(date.getTime());           
    date.add(java.util.Calendar.DATE, +2);
    String endDay = m_today.format(date.getTime());

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
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
        var v_default_row = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

        fnInit(); 
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        cfStyleGrid(getObjectFirst("gr2"), "comn1");
        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        getObjectFirst("ds_goods").Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
    function fnSelect() {
        /*if(getObjectFirst("v_client_cd").value==""){
            alert("대리점을 먼저 선택하시길 바랍니다.");
            return;
        }*/
        
        if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
            alert("출발일자(From)를 입력하시길 바랍니다.");
            getObjectFirst("v_depart_date1").Focus();
            return;
        }
        
        if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
            alert("출발일자(To)를 입력하시길 바랍니다.");
            getObjectFirst("v_depart_date2").Focus();
            return;
        }
        
        getObjectFirst("ds_detail").DeleteAll();
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_client_sid="+getObjectFirst("v_client_sid").value
                    + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                    + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                    + ",v_depart_date2="+getObjectFirst("v_depart_date2").Text
                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                    + ",v_ipkum_gu="+ getObjectFirst("v_ipkum_gu").value
                    + ",v_pay_gubn="+ getObjectFirst("v_pay_gubn").value
                    + ",v_cust_nm="+getObjectFirst("v_cust_nm").value;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv330S",
            "JSP(O:DEFAULT=ds_main)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  Detail 조회
// Parameter    : 
%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rsv_sid="+getObjectFirst("ds_main").NameValue(row, "RSV_SID")
                    + ",v_pay_gubn="+getObjectFirst("ds_main").NameValue(row, "OPTION_YN");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv330S",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  엑셀 파일 출력 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_main.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:입금/미입금자 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("입금미입금자 조회", "입금 미입금자 조회.xls", 32);

        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:입금내역 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("입금내역 조회", "입금 미입금자 조회.xls", 32);

    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체팝업
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            v_client_sid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          v_client_sid.value = "";
        }               
    }
    
    /**
     * 신청서 번호 조회
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
        }
    }

<%
////////////////////////////////////////////////////////////////////////////////
// Description 입금방법 구분 팝업

%>    

 function fnConfirmView(dir) {
	var arrParam    = new Array();
    var arrResult   = new Array();
	
	var accept_no = ds_main.namevalue(ds_main.rowposition,"ACCEPT_NO");
	var rsv_sid = ds_main.namevalue(ds_main.rowposition,"RSV_SID");	

	var pay_sid = ds_detail.namevalue(ds_detail.rowposition, "PAY_SID1");
	var pay_manage_no = ds_detail.namevalue(ds_detail.rowposition, "PAY_MANAGE_NO");
	var pay_cd = ds_detail.namevalue(ds_detail.rowposition,"PAY_CD");
	var pay_date = ds_detail.namevalue(ds_detail.rowposition,"PAY_DATE");
	

			        
		if (pay_sid == "020") { // 가상계좌
			var strURL = dir+"/Sales/help/rv007h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "030") { // 계좌이체
			var strURL = dir+"/Sales/help/rv008h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "040") { // 신용카드
			var strURL = dir+"/Sales/help/rv009h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "060") { // 상품권
			var strURL = dir+"/Sales/help/rv010h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "080") { // 무통장입금
			var strURL = dir+"/Sales/help/rv014h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "090") { // 기타대체
			var strURL = dir+"/Sales/help/rv015h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else {
			return;
		}

    var strPos = "dialogWidth:500px;dialogHeight:585px;status:no;scroll:no;resizable:no";
    
    arrResult =  showModalDialog(strURL,arrParam,strPos); 
        
    }
    
    
	//예약확인증  팝업(입금자)
	function popConfirm(rsv_sid){
		var receiptURL ="http://www.mtkumgang.com/preserv/res_print.jsp?rsv_sid=" + rsv_sid;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=670,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	}
	//예약확인증  팝업(미입금자)
	function popConfirm2(rsv_sid){
		var receiptURL ="http://www.mtkumgang.com/preserv/res_print2.jsp?rsv_sid=" + rsv_sid;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=300,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	}	
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=JavaScript for=v_depart_date1 event=OnKillFocus()>
   if( v_depart_date1.Modified == true )
		v_depart_date2.text = v_depart_date1.text;
</script>	


<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//왼쪽버튼 클릭하면 디테일 보이기
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>
<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
//우측버튼 클릭하면 확인증 출력
	if(ds_main.namevalue(Row, "GOODS_SID")==57||ds_main.namevalue(Row, "GOODS_SID")==58||ds_main.namevalue(Row, "GOODS_SID")==59){
	 	if(ds_main.namevalue(Row, "TOT_TOUR_AMT") - ds_main.namevalue(Row, "TOT_PAY_AMT") == 0) {
		 	popConfirm(ds_main.namevalue(Row, "RSV_SID"));	//입금자
	 	}else{
		 	popConfirm2(ds_main.namevalue(Row, "RSV_SID"));	//미입금
	 	};
	}else{
		alert("예약판매 상품만 확인증을 뽑을 수 있습니다.");
	};
</script>

<script language=javascript for="ds_main" event="OnLoadCompleted(row)">
    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    fnSelectDetail(v_default_row);
</script>


<script language=javascript for="gr2" event="OnClick(Row, Colid)">
    if(Row<1) return;
    fnConfirmView('<%=dirPath%>');
</script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>
<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">대리점코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td width="100px" height="25px" class="text">작업구분</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_ipkum_gu class="text">
                                        <option value="">전체
                                        <option value="T">입금자
                                        <option value="F">미입금자
                                    </select>
                                    <select name=v_pay_gubn class="text">
                                        <option value="N">관광요금
                                        <option value="Y">OPTION요금
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">상품코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=180 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^150">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td width="100px" height="25px" class="text">출발일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">신청서번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
                                <td width="100px" height="25px" class="text">성명</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=580; height:380px" border="1">
                            <param name="DataID"            value="ds_main">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <FC> name='출발일자'       ID='DEPART_DATE'    Width=70   Edit=none align=Left suppress=1</FC>
                                <C> name='신청번호'       ID='VIEW_ACCEPT_NO'      Width=110   SumText='결제예정금액' Edit=none align=Left suppress=3</C>
                                <C> name='성명'           ID='CUST_NM'        Width=60   Edit=none align=Left suppress=4</C>
                                <C> name='예약상태'    	ID='STATUS_CD'      width=60 	align=left 		Edit=None</C>
                                <C> name='객실\\코드'     ID='ROOM_TYPE'   Width=50   Edit=none align=Left suppress=5</C>
                                <C> name='할인\\코드'     ID='CUST_TYPE'   Width=50   Edit=none align=Left suppress=6</C>
                                <C> name='판매가'         ID='TOT_TOUR_AMT'   Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
                                <C> name='입금액'         ID='TOT_PAY_AMT'    Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
                                <C> name='상품'          ID='GOODS_NM'       Width=100  Edit=none align=Left suppress=2</C>
                                <C> name='주민/여권번호'  ID='MANAGE_NO'      Width=100   Edit=none align=Left</C>
                                
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                    <td width="10">&nbsp;</td>
                    <td>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=255; height:380px" border="1">
                            <param name="DataID"            value="ds_detail">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <C> name='입금일자'        ID='VIEW_PAY_DATE'   Width=65   Edit=none align=Left suppress=1</C>
                                <C> name='입금\\방법'      ID='PAY_CD_NM'       Width=40   Edit=none align=Left</C>
                                <C> name='입금\\여부'      ID='PAY_YN'          Width=35   Edit=none align=Center</C>
                                <C> name='회계\\구분'      ID='ACCT_GUBN_NM'    Width=40   Edit=none align=Center</C>
                                <C> name='입금액'          ID='PAY_AMT'         Width=60   SumText=@sum  Edit=none align=Right dec=0</C>
                                <C> name='관리번호'        ID='PAY_MANAGE_NO'   Width=100  Edit=none align=Left Dec=0</C>
                                <C> name='PAY_SID'        ID='PAY_SID1'   	Width=100  Edit=none align=Left show=false</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
	  <tr>
		<td>　※ 좌측 GRID의 행을 <b>왼</b> 클릭하면 우측 GRID에 <b><font color="blue">세부정보</font>가 표시</b>됩니다.<br>
				　※ 좌측 GRID의 행을 <b>오른</b> 클릭하면 <b><font color="blue">예약확인증</font>을 출력</b>합니다.<br>
		</td>
	  </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

