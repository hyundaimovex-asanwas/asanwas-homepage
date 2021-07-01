<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 상품권결재
 * 프로그램ID   : AC730I
 * J  S  P      : ac730i
 * 서 블 릿        : Ac730I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-16
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

            ds_bill_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC017";
            ds_bill_gu.Reset();
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
                        + ",dsType=1";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac730I",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
            
        }
        
        function fnSelect(){
            v_flag = "S";
            
            if(ds_master.IsUpdated){
                alert("수정중인 데이터가 있습니다.");
                return;
            }
            
            if(getObjectFirst("s_fr_date").Text.trim()=="" 
                || getObjectFirst("s_fr_date").Text.trim().length!=8){
                alert("회수일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("s_fr_date").Focus();
                return;
            }
            if(getObjectFirst("s_to_date").Text.trim()=="" 
                || getObjectFirst("s_to_date").Text.trim().length!=8){
                alert("회수일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("s_to_date").Focus();
                return;
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_fr_date="+getObjectFirst("s_fr_date").Text
                        + ",v_to_date="+getObjectFirst("s_to_date").Text
                        + ",v_vend_cd="+ getObjectFirst("s_vend_cd").value;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac730I",
                "JSP(O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSave(){
            if(!ds_master.IsUpdated){
                alert("변경된 내역이 없습니다.");
                return;
            }
            
            for(var i=1; i<=ds_master.CountRow; i++){
                if(ds_master.NameValue(i, "BILL_DATE")==""){
                    alert("결제일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_bill_date").Focus();
                    return;
                }
                if(ds_master.NameValue(i, "VEND_CD")==""){
                    alert("거래처<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    return;
                }
                if(ds_master.NameValue(i, "BILL_AMT")=="" || ds_master.NameValue(i, "BILL_AMT")=="0"){
                    alert("결제금액<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_bill_amt").focus();
                    return;
                }
                
                var gubn = ds_master.NameValue(i, "BILL_GU");
                if(gubn=='1'){//현금
                    if(ds_master.NameValue(i, "BANK_ACC_NO")==""){
                        alert("계좌번호<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds_master.RowPosition = i;
                        getObjectFirst("v_bank_acc_no").focus();
                        return;
                    }
                    if(ds_master.NameValue(i, "BANCOD")==""){
                        alert("계좌번호<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds_master.RowPosition = i;
                        getObjectFirst("v_bank_acc_no").focus();
                        return;
                    }
                } else if(gubn=='2'){//카드
                    if(ds_master.NameValue(i, "PAY_MANAGE_NO")==""){
                        alert("카드결제를 먼저 하시길 바랍니다.");
                        ds_master.RowPosition = i;
                        return;
                    }
                } else {
                    alert("입금방법<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_bill_gu").Focus();
                    return;
                }
                
                if(ds_master.NameValue(i, "BILL_EMPNO")==""){
                    alert("회수자<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds_master.RowPosition = i;
                    getObjectFirst("v_bill_empno").focus();
                    return;
                }
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1";
                        
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac730I",
                "JSP(I:MASTER=ds_master,O:RESULT=ds_master_result)",
                v_param);
            tr_post(tr_save);
        }

        function fnCancel(){
            ds_master.UndoAll();
            fnDisplay();
        }
        
        function fnAdd(){
            ds_master.AddRow();
            fnDisplay();
            v_bill_date.Text = "<%=firstday%>";
        }
        
        function fnDelete(){
            ds_master.DeleteRow(ds_master.RowPosition);
            fnDisplay();
        }

        /**
         * 화면 Control
         */
        function fnDisplay(){
            if(ds_master.CountRow==0){
                getObjectFirst("v_bill_date").Enable        = "false";
                getObjectFirst("v_bank_acc_no").Enable      = "false";
                getObjectFirst("v_bill_amt").Enable         = "false";
                getObjectFirst("v_bill_gu").Enable          = "false";
                getObjectFirst("vend_btn").style.display    = "none";
                getObjectFirst("account_btn").style.display = "none";
                getObjectFirst("bank_btn").style.display    = "none";
                getObjectFirst("v_bill_empno").readOnly     = true;
            } else {
                getObjectFirst("v_bill_date").Enable        = "true";
                getObjectFirst("v_bank_acc_no").Enable      = "false";
                getObjectFirst("v_bill_amt").Enable         = "true";
                getObjectFirst("v_bill_empno").readOnly     = false;

                if(ds_master.RowStatus(ds_master.RowPosition)=='1'){
                    getObjectFirst("v_bill_gu").Enable          = "true";
                } else {
                    getObjectFirst("v_bill_gu").Enable          = "false";
                }
                getObjectFirst("vend_btn").style.display    = "inline";
                
                if(ds_master.NameValue(ds_master.RowPosition, "BILL_GU")=="1"){
                    getObjectFirst("account_btn").style.display = "none";
                    getObjectFirst("bank_btn").style.display    = "inline";
                } else if(ds_master.NameValue(ds_master.RowPosition, "BILL_GU")=="2"){
                    if(ds_master.RowStatus(ds_master.RowPosition)==1)
                        getObjectFirst("account_btn").style.display = "inline";
                    else {
                        getObjectFirst("account_btn").style.display = "none";
                        getObjectFirst("v_bill_amt").Enable = "false";
                    }
                    getObjectFirst("bank_btn").style.display    = "none";
                } else {
                    getObjectFirst("account_btn").style.display = "none";
                    getObjectFirst("bank_btn").style.display    = "none";
                }
            }
        }
        
        /**
         * 입금방법에 따른 화면  Control
         */
        function fnBillGu(bill_gu){
            if(ds_master.CountRow==0) return;
            if(bill_gu=='1'){           //현금
                getObjectFirst("account_btn").style.display = "none";
                getObjectFirst("bank_btn").style.display    = "inline";
            } else if(bill_gu=='2'){    //카드
                getObjectFirst("v_bank_acc_no").value       = "";
                getObjectFirst("v_bancod").value            = "";
                getObjectFirst("v_bannam").value            = "";
                getObjectFirst("account_btn").style.display = "inline";
                getObjectFirst("bank_btn").style.display    = "none";
            } else {
                getObjectFirst("account_btn").style.display = "none";
                getObjectFirst("bank_btn").style.display    = "none";
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
                v_bill_empno.value = arrParam[0];
                v_bill_empnmk.value = arrParam[1];
            } else {
                v_bill_empno.value = "";
                v_bill_empnmk.value  = "";
            }               
        }

        /**
         * 거래처  팝업 
         */
        function fnClientPopup(v_gubn) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            var strURL = "<%=dirPath%>/Sales/help/cu004h.jsp";
            var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            var arrResult = showModalDialog(strURL,arrParam,strPos); 
        
            if (arrResult!=undefined) {
                arrParam = arrResult.split(";");
                
                if(v_gubn=="1") {
                    s_vend_cd.value = arrParam[0];
                    s_vend_nm.value = arrParam[1];
                } else if(v_gubn=="2"){
                    v_vend_cd.value = arrParam[0];
                    v_vend_nm.value = arrParam[1];
                }
            } else {
                if(v_gubn=="1") {
                    s_vend_cd.value = "";
                    s_vend_nm.value = "";
                } else if(v_gubn=="2"){
                    v_vend_cd.value = "";
                    v_vend_nm.value = "";
                }
            }               
        }
        
        function fnBankAccountPopup(){
            var arrParam    = new Array();

            var strURL = "<%=dirPath%>/Sales/help/ac003h.jsp";
            var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            var arrResult = showModalDialog(strURL,arrParam,strPos); 

            if(arrResult!=null && arrResult!=undefined){
                arrParam = arrResult.split(";");
                getObjectFirst("v_bank_acc_no").value = arrParam[0];
                getObjectFirst("v_bancod").value = arrParam[1];
                getObjectFirst("v_bannam").value = arrParam[2];
            } else {
                getObjectFirst("v_bank_acc_no").value = "";
                getObjectFirst("v_bancod").value = "";
                getObjectFirst("v_bannam").value = "";
            }
        }

        /**
         * 신용카드 결제
         */
        function fnAccount() {
            var v_sel_cnt = 0;
            var v_account_amt = 0;
            var v_client_cd = "";
            
            if(getObjectFirst("ds_master").CountRow==0){
                alert("먼저 조회후 클릭하시길 바랍니다.");
                return;
            }
            
            if(ds_master.NameValue(ds_master.RowPosition, "VEND_CD")==""){
                alert("거래처<%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            
            if(ds_master.NameValue(ds_master.RowPosition, "BILL_AMT")=="" || ds_master.NameValue(ds_master.RowPosition, "BILL_AMT")=="0"){
                alert("결제금액<%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            
            if(ds_master.NameValue(ds_master.RowPosition, "BILL_AMT")<"1000"){
                alert("결제금액은 1,000원 이상을 입력하셔야 합니다.");
                return;
            }

            var arrParam    = new Array();
            var arrResult   = new Array();
            var v_pay_manage_no ="";
            var v_pay_date = "<%=firstday%>";
            var v_pay_cd = "";
            var v_plan_pay_date = "";   //입금예정일자
            
            arrParam[0] = "0010";   //결재 항목을 표시할 내용만 표시... 꼭 4자리만 사용 0:미사용, 1:사용
            arrParam[1] = ds_master.NameValue(i, "VEND_CD");
            arrParam[2] = ds_master.NameValue(ds_master.RowPosition, "BILL_AMT");
            arrParam[3] = "";
            
            arrParam[4] = "<%=HDConstant.KCP_CAT_ID%>";     //단말기번호
            arrParam[5] = "<%=HDConstant.KCP_TERM_ID%>";    //계좌이체 및 가상계좌 터미널 ID
            arrParam[6] = "<%=HDConstant.KCP_MIDBY_KCP%>";  //계좌이체 및 가상계좌 가맹점 번호
            arrParam[7] = "0";                              //대리점 Sid
            
            arrResult = fnCreditPop("<%=dirPath%>", arrParam);
            if(arrResult!=null && arrResult!=undefined){
                arrParam = arrResult.split(":");
                getObjectFirst("v_pay_manage_no").Text = arrParam[1];
            }
        }
    </script>

<script language=javascript for=ds_master event="OnLoadCompleted(Row)">
    if(v_flag=="H") return;
    fnDisplay();
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=javascript for=ds_master_result event="OnLoadCompleted(Row)">
    if(ds_master_result.CountRow>0){
        var v_result_msg = "";
        for(var i=1, j=1; i<=ds_master.CountRow; i++){
            if(ds_master.RowStatus(i)==1){
                ds_master.NameValue(i, "BILL_NO")=ds_master_result.NameValue(j, "BILL_NO");
            }
            j++;
        }
        
        for(var i=1; i<=ds_master_result.CountRow; i++){
            if(ds_master_result.NameValue(i, "MSG_CD")!="0000")
                v_result_msg += ds_master_result.NameValue(i, "MSG")+"\n";
        }

        ds_master.ResetStatus();

        if(v_result_msg!="")
            alert(v_result_msg);
            
        fnDisplay();
    }
</script>

<script language=JavaScript for=ds_master event=OnRowPosChanged(Row)>
    fnDisplay();
</script>

<script language=JavaScript for=v_bill_gu event=onSelChange()>
    fnBillGu(v_bill_gu.ValueOfIndex("detail", v_bill_gu.Index));
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

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_bill_gu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 결제구분 -->
    <param name="SyncLoad"  value="true">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                        <td class="text"  width="70">결재일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=s_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                            <object id=s_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                        <td class="text" width="100">거래처</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name='s_vend_cd' value='' size='11' readonly='readonly'  class='input01'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand" onclick="javascript:fnClientPopup(1);" align='absmiddle'>
                            <input type="text" name='s_vend_nm' value='' size='11' readonly='readonly'  class='input01'>
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
                                     <C> name='결재일자'    ID='BILL_DATE'      width=80  align=center Edit=None EditLimit=8 mask='XXXX-XX-XX' suppress=1</C>
                                     <C> name='결재번호'    ID='BILL_NO'  width=120 align=left   Edit=None</C>
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
                                                <td class="text" width="100">결재일자</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_bill_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                                <td class="text" width="100">결재번호</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_bill_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                                <td class="text" width="100">거래처</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name='v_vend_cd' id='v_vend_cd' value='' size='11' readonly='readonly'  class='input01'>
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand" id="vend_btn" onclick="javascript:fnClientPopup(2);" align='absmiddle'>
                                                    <input type="text" name='v_vend_nm' id='v_vend_nm' value='' size='11' readonly='readonly'  class='input01'>
                                                </td>
                                                <td class="text" width="100">입금방법</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_bill_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_bill_gu>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=ListExprFormat  value="detail_nm^0^140">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr height=25>
                                                <td class="text" width="100">결제금액</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_bill_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">            
                                                        <param name=Alignment   value=2>
                                                        <!-- param name=Format      value="000000000"-->
                                                        <param name=Cursor      value="iBeam">
                                                        <param name=Border      value="false">
                                                        <param name=InheritColor      value="true">
                                                        <param name=Enable      value="true">
                                                        <param name=IsComma     value="true">
                                                        <param name=MaxLength   value=9>
                                                        <param name=SelectAll   value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny   value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td class="text" width="100">신용카드결제번호</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=v_pay_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=90 align=center class="textbox">            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="000000-0000">
                                                        <param name=Cursor      value="iBeam">
                                                        <param name=Border      value="false">
                                                        <param name=InheritColor      value="true">
                                                        <param name=Enable      value="false">
                                                        <param name=SelectAll   value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny   value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                    &nbsp;<img src="<%=dirPath%>/Sales/images/account.gif" id=account_btn style="cursor:hand;display:none" onClick="fnAccount()" align=absmiddle>
                                                </td>
                                            </tr>
                                            <tr height=25>
                                                <td class="text" width="100">계좌번호</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name='v_bank_acc_no' id='v_bank_acc_no' value='' size='15' readonly='readonly'  class='input01'>
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand" id="bank_btn" onclick="javascript:fnBankAccountPopup();" align='absmiddle'>
                                                </td>
                                                <td class="text" width="100">은행코드</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name='v_bancod' id='v_bancod' value='' size='11' readonly='readonly'  class='input01'>
                                                    <input type="text" name='v_bannam' id='v_bannam' value='' size='11' readonly='readonly'  class='input01'>
                                                </td>
                                            </tr>
                                            <tr height=25>
                                                <td class="text" width="100">입금자</td>
                                                <td align=left bgcolor="#ffffff" colspan="3">&nbsp;<input type="text" name='v_bill_empno' id='v_bill_empno' value='' size='11' class='textbox'></td>
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
<%=HDConstant.COMMENT_START%>
<object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
    <param name="DataId" value="ds_master">
    <param name=BindInfo    value="
        <C>Col=BILL_NO        Ctrl=v_bill_no        Param=Text</C>
        <C>Col=BILL_DATE      Ctrl=v_bill_date      Param=Text</C>
        <C>Col=VEND_CD        Ctrl=v_vend_cd        Param=value</C>
        <C>Col=VEND_NM        Ctrl=v_vend_nm        Param=value</C>
        <C>Col=BILL_GU        Ctrl=v_bill_gu        Param=BindColVal</C>
        <C>Col=BANCOD         Ctrl=v_bancod         Param=value</C>
        <C>Col=BANK_ACC_NO    Ctrl=v_bank_acc_no    Param=value</C>
        <C>Col=BANNAM         Ctrl=v_bannam         Param=value</C>
        <C>Col=PAY_MANAGE_NO  Ctrl=v_pay_manage_no  Param=Text</C>
        <C>Col=BILL_AMT       Ctrl=v_bill_amt       Param=Text</C>
        <C>Col=BILL_EMPNO     Ctrl=v_bill_empno     Param=value</C>
        <C>Col=EMPNMK         Ctrl=v_bill_empnmk    Param=value</C>
    ">
</object>
<%=HDConstant.COMMENT_END%>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

