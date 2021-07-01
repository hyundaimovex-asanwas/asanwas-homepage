<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 상품권회수
 * 프로그램ID   : AC740I
 * J  S  P      : ac740i
 * 서 블 릿        : Ac740I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-14
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
	date.add(Calendar.DATE, +1);
	String lastday = m_today.format(date.getTime());

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
        var v_default_row = 1;
        var v_flag = "";
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

            fnDisplay();
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            v_flag = "H";
            cfStyleGrid(getObjectFirst("gr_master"), "comn");
            cfStyleGrid(getObjectFirst("gr_detail"), "comn");
            
            ds_giftType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC003";
            ds_giftType.Reset();

            ds_pay_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC016";
            ds_pay_gu.Reset();

            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
                        + ",dsType=1";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(O:MASTER=ds_master, O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSelect(){
            v_flag = "S";
            
            if(ds_master.IsUpdated){
                alert("수정중인 데이터가 있습니다.");
                return;
            }
            
            if(getObjectFirst("v_fr_date").Text.trim()=="" 
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("회수일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()=="" 
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("회수일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSelectDetail(Row){
            if(ds_detail.IsUpdated){
                ds_master.RowPosition = v_default_row;
                alert("수정중인 데이터가 있습니다.");
                return;
            }
            
            v_default_row = Row;
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_gift_cd="+ ds_master.NameValue(Row, "GIFT_CD");
                        
            ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr2);
        }
        
        function fnSave(){
            var v_gift_cnt = 0;
            var v_gift_amt = 0;
            
            if(ds_master.IsUpdated==false && ds_detail.IsUpdated==false){
                alert("변경된 내역이 없습니다.");
                return;
            }
            
            for(var i=1; i<=ds_master.CountRow; i++){
                if(ds_master.NameValue(i, "PAY_DATE")==""){
                    alert("회수일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_pay_date").Focus();
                    return;
                }
                if(ds_master.NameValue(i, "PAY_GU")==""){
                    alert("회수구분<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_pay_gu").Focus();
                    return;
                }
                if(ds_master.NameValue(i, "PAY_EMPNO")==""){
                    alert("회수자<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_pay_empno").focus();
                    return;
                }
            }
            
            for(var i=1; i<=ds_detail.CountRow; i++){
                if(ds_detail.NameValue(i, "GIFT_TYPE")==0){
                    alert("권종<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_detail.RowPosition = i;
                    gr_detail.SetColumn("GIFT_TYPE");
                    return;
                }

                if(ds_detail.NameValue(i, "FR_GIFT_SEQ")==0){
                    alert("상품권 시작번호<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_detail.RowPosition = i;
                    gr_detail.SetColumn("FR_GIFT_SEQ");
                    return;
                }
                if(ds_detail.NameValue(i, "TO_GIFT_SEQ")==0){
                    alert("상품권 종료번호<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_detail.RowPosition = i;
                    gr_detail.SetColumn("TO_GIFT_SEQ");
                    return;
                }
                if(ds_detail.NameValue(i, "PAY_QTY")==0){
                    alert("잘못된 상품권 일련번호입니다.");
                    ds_detail.RowPosition = i;
                    gr_detail.SetColumn("FR_GIFT_SEQ");
                    return;
                }
                v_gift_cnt += ds_detail.NameValue(i, "PAY_QTY");
                v_gift_amt += ds_detail.NameValue(i, "PAY_AMT");
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1"
                        + ",v_gift_cnt=" + v_gift_cnt
                        + ",v_gift_amt=" + v_gift_amt;
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(I:MASTER=ds_master,O:RESULT=ds_master_result)",
                v_param);
            tr_post(tr_save);
        }

        function fnSaveDetail(){
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1";
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(I:DETAIL=ds_detail,O:RESULT=ds_detail_result)",
                v_param);
            tr_post(tr1);
        }

        function fnCancel(){
            ds_master.UndoAll();
            ds_detail.UndoAll();
            
            fnDisplay();
        }
        
        function fnAdd(){
            for(var i=1; i<=ds_master.CountRow; i++){
                if(ds_master.RowStatus(i)==1){
                    if(ds_detail.CountRow==0){
                        alert("상품권 회수정보(상세)를 먼저 등록하시길 바랍니다.");
                        return;
                    }
                }
            }
            
            if(ds_master.IsUpdated || ds_detail.IsUpdated){
                alert("먼저 저장하시길 바랍니다.");
                return;
            }
            
            ds_master.AddRow();
            
            v_pay_date.Text = "<%=firstday%>";
            
            v_pay_gu.Index = 0;
            
/*
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
                        + ",dsType=1";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac740I",
                "JSP(O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr1);
*/

            fnDisplay();
        }
        
        function fnDelete(){
            ds_master.DeleteRow(ds_master.RowPosition);
            fnDisplay();
        }
        
        function fnAddRow(){
            ds_detail.AddRow();
            ds_detail.NameValue(ds_detail.RowPosition, "GIFT_CD") = ds_master.NameValue(ds_master.RowPosition, "GIFT_CD");
            
            fnDisplay();
        }
        
        function fnDeleteRow(){
            ds_detail.DeleteRow(ds_detail.RowPosition);
            fnDisplay();
        }
        
        /**
         * 화면 Control
         */
        function fnDisplay(){
            if(ds_master.CountRow>0){
                if(ds_master.RowStatus(ds_master.RowPosition)==1)
                    getObjectFirst("v_pay_date").Enable= "true";
                else
                    getObjectFirst("v_pay_date").Enable= "false";
                getObjectFirst("v_pay_gu").Enable = "true";
                getObjectFirst("empno_btn").style.display = "inline";
                getObjectFirst("plus_btn").style.display = "inline";
                getObjectFirst("minus_btn").style.display = "inline";
            } else {
                getObjectFirst("v_pay_date").Enable= "false";
                getObjectFirst("v_pay_gu").Enable = "false";
                getObjectFirst("empno_btn").style.display = "none";
                getObjectFirst("plus_btn").style.display = "none";
                getObjectFirst("minus_btn").style.display = "none";
                getObjectFirst("v_pay_empno").value = "";
                getObjectFirst("v_pay_empnmk").value = "";
            }
        }
        
        /**
         * 사원정보  팝업 
         */
        function fnEmpPopup() {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            arrResult = fnEmpPop("<%=dirPath%>");
        
            if (arrResult != null && arrResult!=undefined) {
                arrParam = arrResult.split(";");
                v_pay_empno.value = arrParam[0];
                v_pay_empnmk.value = arrParam[1];
            } else {
                v_pay_empno.value = "";
                v_pay_empnmk.value  = "";
            }               
        }

        function fnGiftSelect(Row, Colid, OldData){
            if(Colid=="GIFT_TYPE" || Colid=="FR_GIFT_SEQ" || Colid=="TO_GIFT_SEQ"){
                if(getObjectFirst("ds_detail").NameValue(Row, "GIFT_TYPE")!=""
                    && getObjectFirst("ds_detail").NameValue(Row, "FR_GIFT_SEQ")!=""
                    && getObjectFirst("ds_detail").NameValue(Row, "TO_GIFT_SEQ")!="")
                {
                    if(OldData != getObjectFirst("ds_detail").NameValue(Row, Colid)){
                        for(var i=getObjectFirst("ds_detail").NameValue(Row, "FR_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds_detail").NameValue(Row, "FR_GIFT_SEQ") = "0"+getObjectFirst("ds_detail").NameValue(Row, "FR_GIFT_SEQ");
            
                        for(var i=getObjectFirst("ds_detail").NameValue(Row, "TO_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds_detail").NameValue(Row, "TO_GIFT_SEQ") = "0"+getObjectFirst("ds_detail").NameValue(Row, "TO_GIFT_SEQ");
            
                        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                                    + ",v_gift_type="+getObjectFirst("ds_detail").NameValue(Row, "GIFT_TYPE")
                                    + ",v_fr_gift_seq="+getObjectFirst("ds_detail").NameValue(Row, "FR_GIFT_SEQ")
                                    + ",v_to_gift_seq="+getObjectFirst("ds_detail").NameValue(Row, "TO_GIFT_SEQ");
                        
                        ln_TRSetting(tr1, 
                            "<%=dirPath%><%=HDConstant.PATH_HELP%>Rv005H",
                            "JSP(O:GIFTAMT=ds_giftAmt)",
                            v_param);
                        tr_post(tr1);
                    }
                }
            }
        }
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language="javascript" for="tr2" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr2" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language=javascript for=ds_master event="OnLoadCompleted(Row)">
    if(v_flag=="H") return;
    fnDisplay();
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        ds_detail.ClearAll();
    }
    fnSelectDetail(v_default_row);
    
</script>

<script language=javascript for=ds_pay_gu event="OnLoadCompleted(Row)">
    if(Row==0) return;
    ds_pay_gu.DeleteRow(1);
</script>

<script language=javascript for=ds_master_result event="OnLoadCompleted(Row)">
    if(ds_master_result.CountRow>0){
        for(var i=1, j=1; i<=ds_master.CountRow; i++){
            if(ds_master.RowStatus(i)==1){
                ds_master.NameValue(i, "GIFT_CD") = ds_master_result.NameValue(j, "GIFT_CD");
                
                for(var k=1; k<=ds_detail.CountRow; k++){
                    if(ds_detail.NameValue(k, "GIFT_CD")=="")
                        ds_detail.NameValue(k, "GIFT_CD") = ds_master.NameValue(i, "GIFT_CD")
                }
                j++;
            }
        }
    }
    ds_master.ResetStatus();
    
    fnSaveDetail();
</script>

<script language=javascript for=ds_detail_result event="OnLoadCompleted(Row)">
    var v_result_msg = "";
    if(ds_detail_result.CountRow>0){
        for(var i=1; i<=ds_detail_result.CountRow; i++){
            if(ds_detail_result.NameValue(i, "MSG_CD")!="0000")
                v_result_msg = ds_detail_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
</script>

<script language=javascript for=ds_master event="OnRowPosChanged(Row)">
    if(Row==0) return;
    if(v_default_row==Row) return;

    if(ds_master.RowStatus(Row)!=1){
        if(ds_master.IsUpdated || ds_detail.IsUpdated){
            ds_master.RowPosition = v_default_row;
            return;
        }
    }
    fnSelectDetail(Row);

    if(ds_master.RowStatus(Row) == 1)
        v_pay_date.Enable = "true";
    else
        v_pay_date.Enable = "false";
</script>

<script language="javascript" for="gr_detail" event="OnCloseUp(Row, Colid)">
    if(Row==0) return;
    fnGiftSelect(Row, Colid, ds_detail.OrgNameValue(Row, Colid));
</script>

<script language="javascript" for="gr_detail" event="OnExit(Row, Colid, OldData)">
    if(Row==0) return;
    fnGiftSelect(Row, Colid, OldData);
</script>

<script language="javascript" for="ds_giftAmt" event="OnLoadCompleted(row)">
    getObjectFirst("ds_detail").NameValue(getObjectFirst("ds_detail").RowPosition, "PAY_QTY") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_QTY");
    getObjectFirst("ds_detail").NameValue(getObjectFirst("ds_detail").RowPosition, "PAY_AMT") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_AMT")*1000;
</script>

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_giftAmt classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_master_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_giftType classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  권종코드 -->
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_pay_gu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 결제구분 -->
    <param name="SyncLoad"  value="true">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/new.gif"   style="cursor:hand" align=absmiddle onClick="fnAdd()">
                            <img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDelete()">
                            <img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:hand" align=absmiddle onclick="fnSave()">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand" align=absmiddle onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="70">회수일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                <param name=Text        value="<%=firstday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object> ~ 
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                <param name=Text        value="<%=lastday%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>                                                                                           
                    </tr>
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=220>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='220px' height='420px' border='1'>
                                <param name="DataID"            value="ds_master">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name=UsingOneClick       value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="Format"            value="
                                     <C> name='회수일자'    ID='PAY_DATE'      width=80 align=center Edit=Numeric EditLimit=8 mask='XXXX-XX-XX' suppress=1</C>
                                     <C> name='회수번호'    ID='GIFT_CD'     width=120 align=left Edit=None</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=10>&nbsp;</td>
                        <td width=615 valign=top>
                            <table border=0 cellspacing=0 cellpadding=0 width="100%">
                                <tr>
                                    <td>
                                        <table border=0 cellspacing="1" bgcolor="#666666" cellpadding=0 width="100%">
                                            <tr height=25>
                                                <td class="text" width="100">회수일자</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_pay_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="YYYY-MM-DD">
                                                        <param name=InputFormat value="YYYYMMDD">
                                                        <param name=Cursor      value="iBeam">
                                                        <param name=Border      value="false">
                                                        <param name=InheritColor      value="true">
                                                        <param name=ReadOnly    value="false">
                                                        <param name=SelectAll   value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny   value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td class="text" width="100">회수번호</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_gift_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="000000-000">
                                                        <param name=Cursor      value="iBeam">
                                                        <param name=Border      value="false">
                                                        <param name=InheritColor      value="true">
                                                        <param name=Enable      value="false">
                                                        <param name=SelectAll   value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny   value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr height=25>
                                                <td class="text" width="100">구분</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_pay_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_pay_gu>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=ListExprFormat  value="detail_nm^0^140">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td class="text" width="100">회수자</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name='v_pay_empno' id='v_pay_empno' value='' size='11' readonly='readonly'  class='input01'>
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand" id="empno_btn" onclick="javascript:fnEmpPopup();" align='absmiddle'>
                                                    <input type="text" name='v_pay_empnmk' id='v_pay_empnmk' value='' size='11' readonly='readonly'  class='input01'>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr height=37 valign=middle align=right>
                                    <td>
                                        <img src="<%=dirPath%>/Sales/images/plus.gif"  id="plus_btn"  style="cursor:hand" align=absmiddle onClick="fnAddRow()">
                                        <img src="<%=dirPath%>/Sales/images/minus.gif" id="minus_btn" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='615px' height='330px' border='1'>
                                            <param name="DataID"            value="ds_detail">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name=UsingOneClick       value="1">
                                            <Param Name="AllShowEdit"       value="True">
                                            <param name="ViewSummary"       value="1">
                                            <param name="Format"            value="
                                                 <C> name=''            ID='{CURROW}'       Width=35    align=center edit=none</C>
                                                 <C> name='권종'            ID='GIFT_TYPE'      SumText='금액' width=120 align=left EditStyle=Lookup Data='ds_giftType:detail:detail_nm'</C>
                                                 <C> name='상품권시작번호'    ID='FR_GIFT_SEQ'    width=100 align=center Edit=Numeric</C>
                                                 <C> name='상품권종료번호'    ID='TO_GIFT_SEQ'    width=100 align=center Edit=Numeric</C>
                                                 <C> name='매수'            ID='PAY_QTY'        SumText=@sum width=60  align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
                                                 <C> name='금액'            ID='PAY_AMT'        SumText=@sum width=115 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
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
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
    <param name="DataId" value="ds_master">
    <param name=BindInfo    value="
        <C>Col=PAY_DATE       Ctrl=v_pay_date      Param=Text</C>
        <C>Col=GIFT_CD        Ctrl=v_gift_cd       Param=Text</C>
        <C>Col=PAY_GU         Ctrl=v_pay_gu        Param=BindColVal</C>
        <C>Col=PAY_EMPNO      Ctrl=v_pay_empno     Param=value</C>
        <C>Col=EMPNMK         Ctrl=v_pay_empnmk    Param=value</C>
    ">
</object>
<%=HDConstant.COMMENT_END%>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


