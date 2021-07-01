<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 보증금 결재
 * 프로그램ID       : RM610I
 * J  S  P      : Rm610i 
 * 서 블 릿        : Rm610i
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-26
 * 기능정의     : 보증금 결재
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
	
	String toDay     = m_today.format(date.getTime());
	
	date.add(java.util.Calendar.DATE, -15);
	String startDay = m_today.format(date.getTime());           
	date.add(java.util.Calendar.DATE, +30);
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
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
            getObjectFirst("ds_goods").Reset();
        }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
        function fnSelect() {
            if(getObjectFirst("v_client_sid").value==""){
                alert("대리점을 먼저 검색하시길 바랍니다.");
                return;
            }
            
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

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                        + ",v_block_no="+getObjectFirst("v_block_no").Text
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_job_sel="+getObjectFirst("v_job_sel").value;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm610I",
                "JSP(O:DEFAULT=ds1)",
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
          v_client_sid.value = "";
        }               
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  관광요금 결제팝업
%>
    function fnAccount() {
        var v_sel_cnt = 0;
        var v_account_amt = 0;
        var v_client_cd = "";
        var v_client_sid = "";

        if(getObjectFirst("ds1").CountRow==0){
            alert("먼저 조회후 클릭하시길 바랍니다.");
            return;
        }
        
        for(var i=1; i<=getObjectFirst("ds1").CountRow; i++){
            if(getObjectFirst("ds1").NameValue(i, "JOB_SEL")=="T"){
                v_sel_cnt++;
                v_account_amt += getObjectFirst("ds1").NameValue(i, "PAY_AMT");
                v_client_cd = getObjectFirst("ds1").NameValue(i, "CLIENT_CD");
                v_client_sid = getObjectFirst("ds1").NameValue(i, "CLIENT_SID");
                if(getObjectFirst("ds1").NameValue(i, "PAY_AMT")==0){
                    alert("결재할 금액을 입력하시길 바랍니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
                
                if(eval(getObjectFirst("ds1").NameValue(i, "PAY_AMT"))>eval(getObjectFirst("ds1").NameValue(i, "ARREARS_AMT"))){
                    alert("결재할 금액이 현재 미납액 보다 더 많은 금액입니다.");
                    getObjectFirst("ds1").RowPosition = i;
                    getObjectFirst("gr1").SetColumn("PAY_AMT");
                    return;
                }
            }
        }
        
        if(v_sel_cnt==0){
            alert("선택된 내역이 없습니다.");
            return;
        }
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var v_pay_manage_no ="";
        var v_pay_date = "<%=toDay%>";
        var v_pay_cd = "";
        var v_plan_pay_date = "";   //입금예정일자
        
        //결재 항목을 표시할 내용만 표시... 꼭 4자리만 사용 0:미사용, 1:사용 (가상계좌, 계좌이체, 신용카드, 상품권)
        arrParam[0] = "1000";
        arrParam[1] = v_client_cd;
        arrParam[2] = v_account_amt;
        arrParam[3] = ds1.NameValue(ds1.RowPosition, "GOODS_NM");
        
        arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";   //단말기번호
        arrParam[5] = "<%=HDConstant.KCP_TERM_ID1%>";   //계좌이체 및 가상계좌 터미널 ID
        arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP1%>";   //계좌이체 및 가상계좌 가맹점 번호
        arrParam[7] = v_client_sid;                     //대리점 Sid

//alert(arrParam);
        arrResult = fnCreditPop("<%=dirPath%>", arrParam);
//alert("arrResult : " + arrResult);
        if(arrResult!=null && arrResult!=undefined){
            arrParam = arrResult.split(":");
            v_pay_cd = arrParam[0];
            v_pay_manage_no = arrParam[1];
            if(arrParam.length>2)	//여기가 
                v_plan_pay_date = arrParam[2];

            
//alert("arrParam : " + arrParam + " v_pay_cd : " +  v_pay_cd + " v_pay_manage_no : " + v_pay_manage_no);
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_pay_date="+v_pay_date
                        + ",v_pay_cd="+v_pay_cd
                        + ",v_pay_manage_no="+v_pay_manage_no
                        + ",v_plan_pay_date="+v_plan_pay_date;

            
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm610I",
                "JSP(I:DEFAULT=ds1, O:RESULT=ds_result)",
                v_param);
            tr_post(tr_save);
        }
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

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row,Colid)">
    if(Row<1) return;
    
    if(Colid=="JOB_SEL"){
        if(getObjectFirst("ds1").NameValue(Row, Colid)=="T")
            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=getObjectFirst("ds1").NameValue(Row, "ARREARS_AMT");
        else
            getObjectFirst("ds1").NameValue(Row, "PAY_AMT")=0;
    }
</script>

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
    
    fnSelect();
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

<script language="javascript" for="tr_save" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr_save.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_save.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr_save" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align=right>
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/account.gif" style="cursor:hand" onClick="fnAccount()">
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">대리점</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="협력업체코드를 조회합니다." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
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
                                        <option value="1">신청일자
                                        <option value="2">출발일자
                                    </select>
                                </td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
                    <td colspan="2">
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:420px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <param name="Format"            value=" 
                            <FC>name='선택'           ID='JOB_SEL'          Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </FC>
                            <FC>name='출발일자'     ID='DEPART_DATE'             Width=80   SumText='결제예정금액' Edit=none align=Left mask='XXXX-XX-XX' suppress=1</FC>
                            <C> name='블록번호'     ID='BLOCK_NO'           Width=70   Edit=none align=Left suppress=2</C>
                            <C> name='상품'           ID='GOODS_NM'           Width=120  Edit=none align=Left suppress=3</C>
                            <C> name='객실타입'     ID='C_ROOM_TYPE_SID'    Width=60   Edit=none align=Left suppress=4</C>
                            <C> name='객실수'      ID='C_ROOM_CNT'         Width=50   Edit=none align=Center suppress=5</C>
                            <C> name='인원'           ID='CONFIRM_PERSONS'    Width=50   Edit=none align=Center suppress=6</C>
                            <C> name='블록요금'     ID='BLOCK_AMT'          Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                            <C> name='보증금'      ID='DEPOSIT_AMT'        Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                            <G> name='입금액'
                                <C> name='입금액'   ID='TOT_AMT'           Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                <C> name='미입금액' ID='MI_PAY_AMT'         Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                            </G>
                            <C> name='미납액'      ID='ARREARS_AMT'        Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                            <C> name='결제액'      ID='PAY_AMT'            Width=60   SumText=@sum Edit=Numeric Dec=0 align=Right dec=0</C>
                            <C> name='T/L'			 ID='TL_DATE'      Width=60   SumText=@sum Edit=none align=Right</C>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


