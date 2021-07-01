<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명           : 신용카드매입
 * 프로그램ID   : AC810B
 * J  S  P     : Ac810b
 * 서 블 릿            : Ac810B
 * 작 성 자            : 김영민
 * 작 성 일            : 2006-08-1
 * 기능정의           : 신용카드매입
 * 수정내용           : 
 * 수 정 자            : 
 * 최종수정일자     : 
 * TODO        : 
 * TODO        : 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  자바코드


    // ContextPath
    String dirPath = request.getContextPath(); //HDASan
     
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    
    String startDay = "";
    String endDay = "";
    
    //월요일이면 토요일 부터 일요일까지 거래에 대해서만 지정해주며,
    //기타 요일인 경우는 전일자에 대해서만 셋팅해준다.
    if(java.util.Calendar.DAY_OF_WEEK == java.util.Calendar.MONDAY){
        date.add(java.util.Calendar.DATE, -2);
        startDay = m_today.format(date.getTime());
        date.add(java.util.Calendar.DATE, +1);
        endDay = m_today.format(date.getTime());
    } else {
        date.add(java.util.Calendar.DATE, -1);
        startDay = m_today.format(date.getTime());
        endDay = m_today.format(date.getTime());
    }

%>

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
        var v_fr_date = "";
        var v_to_date = "";
        
        function fnOnLoad(){
            fnInit(); 
        }
        
        function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
        }
        
        function fnSelect() {
            if(getObjectFirst("v_fr_date").Text.trim()=="" || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("출발일자 (From) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            
            if(getObjectFirst("v_to_date").Text.trim()=="" || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("출발일자 (To) <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            v_fr_date = getObjectFirst("v_fr_date").Text;
            v_to_date = getObjectFirst("v_to_date").Text;
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac810B",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
        }
        
        function fnApply() {
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac810B",
                "JSP(I:DEFAULT=ds1, O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        }
        
        function fnExcel(){
            if(ds1.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:신용카드매입("+v_fr_date + " ~ " + v_to_date +"); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("신용카드매입", "신용카드매입.xls", 8);        
        }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
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

    var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_CARD%>"+ds_result.NameValue(row, "FILE_NAME")
                + "&realName="+ds_result.NameValue(row, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
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

<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->
<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/n_create.gif" style="cursor:hand" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">거래발생일자</td>
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
                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td>
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
                            <!-- FC> name='거래구분'        ID='TRAN_CODE'  Width=100  Edit=none align=Left suppress=1</FC-->
                            <C> name='단말기번호'    ID='TERM_ID'    Width=90   Edit=none align=Left suppress=1</C>
                            <C> name='매입사'          ID='ACQHID'     Width=60   Edit=none align=Left suppress=2</C>
                            <C> name='가맹점번호'    ID='MCHTNO'     Width=80   Edit=none align=Center suppress=3</C>
                            <C> name='거래발생일자'     ID='TRAN_DATE'  Width=80   Edit=none align=Center suppress=4</C>
                            <C> name='매출일자'         ID='SELL_DATE'  Width=80   Edit=none align=Center Dec=0 suppress=5</C>
                            <C> name='승인구분'         ID='INST_MONTH' Width=60   Edit=none align=Center value={DECODE(TRAN_CODE,'1', '승인', '취소')}</C>
                            <C> name='카드번호'         ID='CDNO'       Width=130   SumText=@count Edit=none align=Left mask='XXXX-XXXX-XXXX-XXXX'</C>
                            <C> name='유효기간'         ID='EXPR_DATE'  Width=60    Edit=none align=Center Dec=0/C>
                            <C> name='승인번호'         ID='AUTHNO'     Width=80   Edit=none align=Left Dec=0</C>
                            <C> name='매출액'          ID='AMT'        Width=80  SumText=@sum Edit=none align=Right Dec=0</C>
                            <C> name='할부기간'         ID='INST_MONTH' Width=60   Edit=none align=Center Dec=0</C>
                            <C> name='KCP거래고유번호'  ID='KCPX_NUMB'  Width=120   Edit=none Dec=0 align=Left</C>
                        ">
                    </object>
                    <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- 코딩 부분 끝    ------------------------------->
<jsp:include page="/Sales/common/include/body_e.jsp"/>
