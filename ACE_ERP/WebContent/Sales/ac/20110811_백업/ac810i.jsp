<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 카드승인취소
 * 프로그램ID       : AC810I
 * J  S  P      : ac810i
 * 서 블 릿        : Ac810I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-21
 * 기능정의     : 카드승인취소
 * 수정내용     : 
 * 수 정 자        : 김영민
 * 최종수정일자   : 2006-08-21
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
    
    date.add(java.util.Calendar.DATE, -2);
    String startDay = m_today.format(date.getTime());           
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

	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

            fnInit(); 
        }

        function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");            
        }

        function fnSelect() {
            /*
            if(getObjectFirst("v_client_sid").value==""){
                alert("대리점을 먼저 검색하시길 바랍니다.");
                return;
            }
            */
            
            if(getObjectFirst("v_bgn_pay_date").Text.trim()=="" || getObjectFirst("v_bgn_pay_date").Text.trim().length!=8){
                alert("결제일자 (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_bgn_pay_date").Focus();
                return;
            }
            
            if(getObjectFirst("v_end_pay_date").Text.trim()=="" || getObjectFirst("v_end_pay_date").Text.trim().length!=8){
                alert("결제일자 (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_end_pay_date").Focus();
                return;
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_client_sid="+getObjectFirst("v_client_sid").value
                        + ",v_bgn_pay_date="+getObjectFirst("v_bgn_pay_date").Text
                        + ",v_end_pay_date="+getObjectFirst("v_end_pay_date").Text
                        + ",v_pay_manage_no="+getObjectFirst("v_pay_manage_no").Text
                        + ",v_card_no="+getObjectFirst("v_card_no").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac810I",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
        }

        function fnApply() {
        }

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
    
        function fnAccount() {
            var v_sel_cnt = 0;
            var v_sel_row = 0;
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
                    v_sel_row = i;
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
            
            /**
             * 기 매입된 자료는 van사를 통한 승인 취소가 안됨.
             * 별도의 매입취소 자료를 생성하여 전송한다.
             */
            if(getObjectFirst("ds1").NameValue(v_sel_row, "CARD_BUY_YN")=="Y"){
                if(confirm("기 매입된 자료입니다. 매입취소 자료를 생성하시겠습니까?")==true){
                    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                                + ",v_pay_manage_no="+getObjectFirst("ds1").NameValue(v_sel_row, "PAY_MANAGE_NO")
                                + ",v_card_buy_yn=Y";
                    ln_TRSetting(tr_save, 
                        "<%=dirPath%><%=HDConstant.PATH_AC%>Ac810I",
                        "JSP(I:DEFAULT=ds1,O:RESULT=ds_result)",
                        v_param);
                    tr_post(tr_save);
                }
                
                return;
            }
            
            var arrParam    = new Array();
            var arrResult   = new Array();
            var v_pay_manage_no ="";
            var v_pay_date = "<%=DateUtil.getCurrentDate(8)%>";
            var v_pay_cd = "";
            var v_plan_pay_date = "";   //입금예정일자
            
            arrParam[0] = "0010";   //결재 항목을 표시할 내용만 표시... 꼭 4자리만 사용 0:미사용, 1:사용
            arrParam[1] = v_client_cd;
            arrParam[2] = v_account_amt;
            arrParam[3] = ds1.NameValue(v_sel_row, "GOODS_NM");
            
            arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //단말기번호
            arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //계좌이체 및 가상계좌 터미널 ID
            arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //계좌이체 및 가상계좌 가맹점 번호
            arrParam[7] = v_client_sid;                     //대리점 Sid
            
            //승인취소
            arrParam[8] = "1102";   //승인취소
            arrParam[9] = ds1.NameValue(v_sel_row, "CARD_NO");        //카드번호
            arrParam[10]= ds1.NameValue(v_sel_row, "VALID_TERMS");    //유효기간
            arrParam[11]= ds1.NameValue(v_sel_row, "HALBU_TERMS");    //할부기간
            arrParam[12]= ds1.NameValue(v_sel_row, "AGREE_NO");       //승인번호
            arrParam[13]= ds1.NameValue(v_sel_row, "PAY_DATE");       //승인일자
            arrParam[14]= ds1.NameValue(v_sel_row, "PAY_MANAGE_NO");  //결제관리번호
//alert(ds1.NameValue(ds1.RowPosition, "PAY_MANAGE_NO"));
            arrResult = fnCreditPop("<%=dirPath%>", arrParam);
            if(arrResult!=null && arrResult!=undefined){
                arrParam = arrResult.split(":");
                v_pay_cd = arrParam[0];
                v_pay_manage_no = arrParam[1];
                if(arrParam.length>2)
                    v_plan_pay_date = arrParam[2];
                
                var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                            + ",v_pay_manage_no="+v_pay_manage_no;
                
                ln_TRSetting(tr_save, 
                    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac810I",
                    "JSP(I:DEFAULT=ds1,O:RESULT=ds_result)",
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
<script language=JavaScript for=v_bgn_pay_date event=OnKillFocus()>
        if( v_bgn_pay_date.Modified == true )
			v_end_pay_date.text = v_bgn_pay_date.text;
</script>
	
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row,Colid)">
    if(Row==0)
        return;
    
    if(Colid=="JOB_SEL"){
        gr1.ReDraw = "False";
        if(ds1.NameValue(Row, Colid)=="T"){
            for(var i=1; i<=ds1.CountRow; i++){
                if(i!=Row){
                    ds1.NameValue(i, Colid)="F";
                }
            }
        }
        gr1.ReDraw = "True";
    }
    if(Colid=="JOB_SEL" || Colid=="REQ_DATE" || Colid=="ACCEPT_NO" || Colid=="PAY_DATE" || Colid=="CARD_COMPANY_NM" || Colid=="CARD_NO" || Colid=="AGREE_NO" || Colid=="PAY_AMT" || Colid=="PAY_MANAGE_NO"){
    	 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
						+ ",v_pay_manage_no="+ds1.NameValue(ds1.RowPosition,"PAY_MANAGE_NO");
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(O:DS2=ds2)",
                v_param);
            tr_post(tr1);
    }    
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

    fnSelect();
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

<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(ds_result.CountRow>0){
        var v_result_msg = "";
        for(var i=1; i<=ds_result.CountRow; i++){
            if(ds_result.NameValue(i, "MSG_CD")!="0000")
                v_result_msg += ds_result.NameValue(i, "MSG")+"\n";
        }

        if(v_result_msg!="")
            alert(v_result_msg);
    }
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="2">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/account.gif" style="cursor:hand" onClick="fnAccount()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10" colspan="2"></td></tr>
                <tr>
                    <td width=845 colspan="2">
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
                                <td width="100px" class="text">결제일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_bgn_pay_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
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
                                    <object id=v_end_pay_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
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
                            <tr height="25px">
                                <td width="100px" class="text">결제관리번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_pay_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="000000-0000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text">카드번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_card_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='140px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="0000-0000-0000-0000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
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
                <tr>
                    <td height="10" colspan="2"></td>
                </tr>             
                <tr>
                    <td>
		                <table border=0 cellspacing=0 cellpadding=0 width="100%">
						  <tr>
	                        <td width=630>
			                    <%=HDConstant.COMMENT_START%>
			                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=630; height:420" border="1">
			                        <param name="DataID"            value="ds1">
			                        <param name="BorderStyle"       value="0">
			                        <param name="ColSizing"         value="true">
			                        <param name="editable"          value="True">
			                        <param name="SuppressOption"    value="1">
			                        <Param Name="UsingOneClick"     value="1">
			                        <Param Name="AllShowEdit"       value="True">
			                        <param name="ViewSummary"       value="1">
			                        <param name="Format"            value=" 
			                            <FC> name='선택√'          ID='JOB_SEL'        Width=35   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</FC>
			                            <FC> name='대리점명'         ID='CLIENT_NM'        Width=100   Edit=none align=Left suppress=1 SumText='건수'</FC>
			                            <FC> name='결제일자'        ID='PAY_DATE'       Width=80  Edit=none align=Center suppress=2 Mask='XXXX-XX-XX' SumText=@count </FC>
			                            <C> name='승인여부'        ID='AGREE_YN'       Width=80  Edit=none align=Center suppress=3</C>
			                            <C> name='결제관리번호'      ID='PAY_MANAGE_NO'      Width=90   Edit=none align=Left Mask='XXXXXX-XXXX'</C>
			                            <C> name='카드사명'         ID='CARD_COMPANY_NM'   Width=80   Edit=none align=Center</C>
			                            <C> name='카드번호'         ID='CARD_NO'   Width=140   Edit=none align=Center Mask='XXXX-XXXX-XXXX-XXXX'</C>
			                            <C> name='승인번호'         ID='AGREE_NO'   Width=80  Edit=none align=Left</C>
			                            <C> name='입금액'          ID='PAY_AMT'   Width=80   Edit=none align=Right Dec=0</C>
			                        ">
			                    </object>
			                    <%=HDConstant.COMMENT_END%>	                        
	                        </td>
	                        <td width=207>
	                            <%=HDConstant.COMMENT_START%>
	                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width="207" height="420" border="1">
			                        <param name="DataID"            value="ds2">
			                        <param name="BorderStyle"       value="0">
			                        <param name="ColSizing"         value="true">
			                        <param name="editable"          value="False">
			                        <param name="SuppressOption"    value="1">
			                        <Param Name="UsingOneClick"     value="1">
			                        <Param Name="AllShowEdit"       value="True">
			                        <param name="ViewSummary"       value="1">	                                
	                                <param name="Format"            value="
										<C> name='이름'     	 ID='CUST_NM'       width=60 align=center  SumText='합계' </C>
										<C> name='주민/여권번호' ID='MANAGE_NO'		width=90 align=center </C>
										<C> name='결제액'  		 ID='PAY_AMT'       width=60 align=right dec=0 SumText=@sum</C>
										<C> name='회계구분'    	 ID='ACCT_GUBN_NM'  Width=60 align=Center</C>
										<C> name='신청서번호'	 ID='ACCEPT_NO'     width=120 align=center show=True </C>
										<C> name='출발일자'		 ID='DEPART_DATE'   width=80 align=center show=True </C>
										<C> name='입금\\방법'    ID='PAY_CD_NM'     Width=40 align=Left   show=false </C>
										<C> name='입금\\여부'    ID='PAY_YN'        Width=35 align=Center show=false </C>
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

