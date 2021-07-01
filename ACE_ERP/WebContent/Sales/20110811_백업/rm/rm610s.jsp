<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 보증금 조회
 * 프로그램ID       : RM610S
 * J  S  P      	: Rm610s
 * 서 블 릿         : Rm610S
 * 작 성 자         : 김영민 
 * 작 성 일         : 2006-07-28
 * 기능정의     	: 보증금 조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-10-15][심동현] 블럭 보증금 내용에 상세정보들 추가
 * [2007-12-27][심동현] 검색조건 : 대리점 전체로 풀기
 * [2009-03-04][박경국] 입금상세정보 팝업띄우기 추가 
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
	
	String toDay     = m_today.format(date.getTime());
	
	date.set(java.util.Calendar.HOUR_OF_DAY, -24*15);
	String startDay = m_today.format(date.getTime());           
	date.add(java.util.Calendar.DATE, +3);
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
            cfStyleGrid(getObjectFirst("gr_master"), "comn1");
            cfStyleGrid(getObjectFirst("gr_detail"), "comn");
            getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            getObjectFirst("ds_goods").Reset();

			//대리점 선조회          
	        ds_agent.Dataid ="<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds_agent.Reset();            
        }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
        function fnSelect() {
            /*if(getObjectFirst("v_client_sid").value==""){
                alert("대리점을 먼저 검색하시길 바랍니다.");
                return;
            }*/
            
            if(getObjectFirst("v_fr_date").Text.trim()=="" || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("일자 (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            
            if(getObjectFirst("v_to_date").Text.trim()=="" || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("일자 (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            gr_master.ReDraw = "False";

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_block_no="+getObjectFirst("v_block_no").Text
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_job_sel="+getObjectFirst("v_job_sel").value
                        + ",v_mi_ipkum_gu="+getObjectFirst("v_mi_ipkum_gu").value;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm610S",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  협력업체팝업
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "1");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            v_client_sid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          v_client_sid.value = "0";
        }               
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  엑셀 파일 출력 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_detail").SetExcelTitle(0, "");
        getObjectFirst("gr_detail").SetExcelTitle(1, "value:보증금 조회 상세; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_detail").GridToExcel("보증금 조회 상세", "보증금 조회.xls", 32);

        getObjectFirst("gr_master").SetExcelTitle(0, "");
        getObjectFirst("gr_master").SetExcelTitle(1, "value:보증금 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("보증금 조회", "보증금 조회.xls", 32);
    }

	/*
	 * 대리점, 상품정보 자동셋팅(조건)
	 */
	function fnSetting(dataSet) {
		var exit=false;
		if ( dataSet == 'ds_agent' ) {	//대리점
			for ( i=1; i<=ds_agent.CountRow; i++ ) {
				if (ds_agent.namevalue(i,"client_cd") == v_client_cd.value ) {
					v_client_sid.value = ds_agent.namevalue(i,"client_sid");
					v_client_nm.value = ds_agent.namevalue(i,"client_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				v_client_sid.value = 0;
				v_client_nm.value = "";
			}
		}
	}
	
	
<%
////////////////////////////////////////////////////////////////////////////////
// Description 입금방법 구분 팝업

%>    

 function fnConfirmView(dir) {
	var arrParam    = new Array();
    var arrResult   = new Array();
	
	var block_no  = ds_master.namevalue(ds_master.rowposition,"BLOCK_NO");
	var block_sid = ds_master.namevalue(ds_master.rowposition,"BLOCK_SID");	

	var block_pay_sid = ds_detail.namevalue(ds_detail.rowposition, "BLOCK_PAY_SID");
	var pay_manage_no = ds_detail.namevalue(ds_detail.rowposition, "PAY_MANAGE_NO");
	var pay_cd = ds_detail.namevalue(ds_detail.rowposition,"PAY_CD");
	var pay_date = ds_detail.namevalue(ds_detail.rowposition,"PAY_DATE");
				    
		if (pay_cd == "가상계좌") { // 가상계좌
			var strURL = dir+"/Sales/help/rv007h_01.jsp?block_no="+block_no+"&block_sid="+block_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
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
    </script>
    
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("상품정보 <%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=javascript for="ds_master" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
    
    gr_master.ReDraw = "True";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_master" event="OnRowPosChanged(Row)">
    if(Row<1) return;
    
    ds_detail.ClearAll();
    
    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                + ",v_block_sid="+ds_master.NameValue(Row, "BLOCK_SID");
    ln_TRSetting(tr2, 
        "<%=dirPath%><%=HDConstant.PATH_RM%>Rm610S",
        "JSP(O:DETAIL=ds_detail)",
        v_param);
    tr_post(tr2);
</script>

<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
</script>

<script language=javascript for="gr_detail" event="OnClick(Row, Colid)">
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

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
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

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr2.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
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
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<!--  대리점  -->
<object id=ds_agent classid='clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbData.cab#version=1,1,1,51'>
   <param name="SyncLoad" value="False">
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
                    <td align=right>
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">대리점</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" size="6" maxlength="5" class="textbox" onBlur="fnSetting('ds_agent')">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" value="0">
                                </td>
                                <td width="100px" class="text">상품코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=200 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^180">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text">작업구분</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_mi_ipkum_gu class=textbox>
                                    <option value="T">전체
                                    <option value="F">미입금
                                    </select>
                                </td>
                            </tr>
                            <tr height="25px">
                                <td width="100px" class="text">블록번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_block_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text"><select name="v_job_sel" class=textbox>
                                        <option value="2">출발일자
                                        <option value="3">입금일자                                        
                                        <option value="1">신청일자
                                    </select>
                                </td>
                                <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
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
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td>
                        <table border=0 cellspacing=0 cellpadding=0 width="100%">
                            <tr>
                                <td>
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=535; height:420px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="True">
                                        <param name="SuppressOption"    value="1">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="ViewSummary"       value="1">
                                        <param name="Format"            value=" 
                                            <FC>name='출발일자'	ID='DEPART_DATE'        Width=70    Edit=none align=CENTER mask='XXXX-XX-XX' suppress=1</FC>
                                            <C> name='블록번호'	ID='BLOCK_NO'           Width=70   Edit=none align=Left suppress=2</C>
                                            <C> name='대리점'		ID='CLIENT_CD'          Width=50   Edit=none align=CENTER suppress=3</C>
                                            <C> name='대리점명'	ID='CLIENT_NM'          Width=70   Edit=none align=Left suppress=4</C>
                                            <C> name='상품'   	ID='GOODS_NM'           Width=80 	SumText='결제예정금액' Edit=none align=Left suppress=5</C>
                                            <C> name='상태'		ID='BLOCK_STATUS_CD'    Width=40   Edit=none align=center suppress=6</C>
                                            <C> name='객실타입'	ID='C_ROOM_TYPE_SID'    Width=60   Edit=none align=Left suppress=7</C>
                                            <C> name='블록요금\\①'	ID='BLOCK_AMT'      Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='보증금\\②=①*0.2'		ID='DEPOSIT_AMT'        Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='입금액\\③'		ID='TOT_AMT'       	Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='모객타입'	ID='CUST_RATE_TYPE'    	Width=50   Edit=none align=Center</C>
                                            <C> name='모객율'		ID='CUST_RATE'	     	Width=50   Edit=none align=Center align=Right dec=0 MASK=XXXXX</C>
                                            <C> name='환불율\\④'		ID='REFUND_RATE'	   	Width=50   Edit=none align=Center align=Right dec=0</C>
                                            <C> name='대체가능액\\⑤=③*④'	ID='REFUND_AMT'        	Width=70   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='환입액'		ID='EARNING_AMT'       	Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                            <C> name='대체완료액'		ID='PAY_AMT'        Width=70   SumText=@sum Edit=none align=Right dec=0</C>

                                            <C> name='객실수'		ID='C_ROOM_CNT'     	Width=50   Edit=none align=Center</C>
                                            <C> name='인원'   	ID='CONFIRM_PERSONS' 	Width=50   Edit=none align=Center</C>
                                            <C> name='T/L'    	ID='TL_DATE'     	 	Width=60   Edit=none align=Right</C>
                                        ">
                                    </object>                                    
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="10"></td>
                                <td>
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_detail  style="width=300; height:420px" border="1">
                                        <param name="DataID"            value="ds_detail">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="True">
                                        <param name="SuppressOption"    value="1">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <FC>name='입금일자'     ID='PAY_DATE'           Width=80   Edit=none align=Center suppress=1</FC>
                                            <C> name='입금액'      ID='PAY_AMT'            Width=60   Edit=none align=Right suppress=2 dec=0</C>
                                            <C> name='관리번호'     ID='PAY_MANAGE_NO'      Width=90  Edit=none align=Left    suppress=3</C>
                                            <C> name='입금방법'     ID='PAY_CD'             Width=60   Edit=none align=Center suppress=4</C>
                                            <C> name='입금여부'      ID='PAY_YN'            Width=60   Edit=none align=Center suppress=5</C>
                                        	<C> name='BLOCK_PAY_SID'    ID='BLOCK_PAY_SID'   	Width=100  Edit=none align=Left show=false</C>
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

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


