<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 미출경자 입력
 * 프로그램ID   : CQ620I
 * J  S  P      : cq620i
 * 서 블 릿        : Cq620I
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-24
 * 기능정의     : 입경자 체류변경
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
	
	date.set(java.util.Calendar.HOUR_OF_DAY, 0);
	String startDay = m_today.format(date.getTime());           
	date.set(java.util.Calendar.HOUR_OF_DAY, 0);
	String endDay = m_today.format(date.getTime());
   
   
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
    var v_flag = "";
    var v_saup_sid = "";
    
    var v_today = "<%=toDay%>";
    
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		fnInit(); 
	}
    
    function fnInit(){
        v_flag = "H";
        
        cfStyleGrid(getObjectFirst("gr_master"), "comn");
        cfStyleGrid(getObjectFirst("gr_detail"), "comn");
        cfStyleTab(getObjectFirst("mxTab"), "comnOnTab");
        
        fnScreenDisplay(0);

        ds_trn_code.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ002&s_item1=Y";
        ds_trn_code.Reset();
        ds_cust_gu.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CU001&s_item1=Y";
        ds_cust_gu.Reset();
        ds_trn_gu.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ003&s_item1=Y";
        ds_trn_gu.Reset();
        ds_goods2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_goods2.Reset();
        ds_goods.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_goods.Reset();

        ds3.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
        ds3.Reset();

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=ds_saup)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);


        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ", v_saup_sid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ", v_fr_trn_date=" + v_fr_trn_date.Text
                    + ", v_to_trn_date=" + v_to_trn_date.Text
                    + ", v_fr_arrive_date="+ v_fr_arrive_date.Text
                    + ", v_to_arrive_date="+ v_to_arrive_date.Text
                    + ", v_cust_nm="+ v_cust_nm.value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq620I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);        
    }

    function fnSelect() {
        if(v_fr_trn_date.Text.trim()=="" || v_fr_trn_date.Text.trim().length!=8){
            alert("신청일자<%=HDConstant.A_MSG_MUST_INPUT%>");
            return;
        }
        
        v_flag = "S";
        
        v_saup_sid = ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID");
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ", v_saup_sid=" + v_saup_sid
                    + ", v_fr_trn_date=" + v_fr_trn_date.Text
                    + ", v_to_trn_date=" + v_to_trn_date.Text
                    + ", v_fr_arrive_date="+ v_fr_arrive_date.Text
                    + ", v_to_arrive_date="+ v_to_arrive_date.Text
                    + ", v_cust_nm="+ v_cust_nm.value
                    + ", v_manage_no="+ v_manage_no.Text;
    //alert(v_param);
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq620I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    
    function fnAdd(){
        ds_master.AddRow();
        
        if(ds_master.CountRow==0){
            alert("먼저 조회후 추가하시길 바랍니다.");
            return;
        }
		fnScreenDisplay(0);
        ds_master.NameValue(ds_master.RowPosition, "TRN_DATE") = v_today;
        ds_master.NameValue(ds_master.RowPosition, "TRN_GU") = "1";
    }
    
    function fnDel(){
        ds_master.DeleteRow(ds_master.RowPosition);
    }
    
    function fnCancel(){
        ds_master.UndoAll();
    }

    function fnApply() {
        if (ds_master.IsUpdated) {
            if(fnCheck()==false) return;
                    
            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq620I",
                "JSP(I:MASTER=ds_master, O:RESULT=ds_result)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr_save);
        }
    }
    
    function fnCheck(){
        for(var i=1; i<=ds_master.CountRow; i++){
            if(ds_master.NameValue(i, "TRN_GU")==""){
                alert("변경시점<%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds_master.NameValue(i, "CUST_NM")==""){
                alert("고객 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds_master.NameValue(i, "L_ARRIVE_DATE")==""){
                alert("예정변경일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds_master.NameValue(i, "L_ARRIVE_TIME")==""){
                alert("예정변경시간 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            if(ds_master.NameValue(i, "TRN_CODE")==""){
                alert("변경사유코드 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }
            /*if(ds_master.NameValue(i, "TRN_DESC")==""){
                alert("변경사유 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return false;
            }*/
        }
    }
    
    function fnCustInoutPopup(){
		if(ds_master.CountRow<1){
			alert("[행추가] 후 조회해 주세요.");
			return false;
		}
    
        var arrParam    = new Array();
        var arrResult   = new Array();
        v_saup_sid = ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID");//검색조건의 지역
        
        arrParam[0] = ds_trn_gu.NameValue(ds_trn_gu.RowPosition, "DETAIL");     //변경시점에 따라... 사용자 조회가 다르다...
        arrParam[1] = v_saup_sid;                                               //지역 SID
        arrParam[2] = d_depart_date.Text.trim();                                //출발일자
        arrParam[3] = ds_goods.NameValue(ds_goods.RowPosition, "GOODS_SID");    //상품 SID
        
        if(arrParam[0]=="1"){
            if(arrParam[2]=="" || arrParam[2].length!=8){
                alert("출발일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
            
            if(arrParam[3]=="0"){
                alert("상품정보 <%=HDConstant.A_MSG_MUST_INPUT%>");
                return;
            }
        } else {
            arrParam[2]=d_fr_trn_date.Text.trim();	//2009-08-21 추가 심동현. 출경후 팝업일 대는 신청일자
        };
        
        
        arrResult = fnCustInoutPop("<%=dirPath%>", arrParam);
        
        if(arrResult!=undefined){
            arrParam = arrResult.split(";");
            
            ds_master.NameValue(ds_master.RowPosition, "CLASS")         = arrParam[0];
            ds_master.NameValue(ds_master.RowPosition, "TEAMS")         = arrParam[1];
            ds_master.NameValue(ds_master.RowPosition, "CUST_NM")       = arrParam[2];
            ds_master.NameValue(ds_master.RowPosition, "CUST_GU")       = arrParam[3];
            ds_master.NameValue(ds_master.RowPosition, "F_ARRIVE_DATE") = arrParam[4];
            ds_master.NameValue(ds_master.RowPosition, "F_ARRIVE_TIME") = arrParam[5];
            ds_master.NameValue(ds_master.RowPosition, "DEPART_DATE")   = arrParam[6];
            ds_master.NameValue(ds_master.RowPosition, "DEPART_TIME")   = arrParam[7];
            ds_master.NameValue(ds_master.RowPosition, "GOODS_SID")     = arrParam[8];
            ds_master.NameValue(ds_master.RowPosition, "MANAGE_NO")     = arrParam[10];
            ds_master.NameValue(ds_master.RowPosition, "RSV_SID")       = arrParam[11];
            ds_master.NameValue(ds_master.RowPosition, "INOUT_SID")     = arrParam[12];
            
            fnScreenDisplay(ds_master.RowPosition);
        }
    }
    
    //화면 Control
    function fnScreenDisplay(row){
        if(row==0){
            getObjectFirst("d_fr_trn_date").Enable      = "False";
            getObjectFirst("d_trn_gu").Enable           = "True";
            getObjectFirst("d_depart_date").Enable      = "True";
            getObjectFirst("d_goods").Enable            = "True";
            getObjectFirst("d_cust_btn").style.display  = "inline";
            getObjectFirst("d_l_arrive_date").Enable    = "True";
            getObjectFirst("d_l_arrive_time").Enable    = "True";
            getObjectFirst("d_trn_code").Enable         = "True";
            getObjectFirst("d_trn_desc").readOnly       = true;
        } else {
            if(ds_master.RowStatus(row) == 1){
                getObjectFirst("d_fr_trn_date").Enable      = "False";
                
                if(ds_master.NameValue(row, "CUST_NM")==""){
                    getObjectFirst("d_trn_gu").Enable           = "True";
                    getObjectFirst("d_depart_date").Enable      = "True";
                    getObjectFirst("d_goods").Enable            = "True";
                    getObjectFirst("d_cust_btn").style.display  = "inline";
                } else {
                    getObjectFirst("d_trn_gu").Enable           = "False";
                    getObjectFirst("d_depart_date").Enable      = "False";
                    getObjectFirst("d_goods").Enable            = "False";
                    getObjectFirst("d_cust_btn").style.display  = "none";
                }
                getObjectFirst("d_l_arrive_date").Enable    = "True";
                getObjectFirst("d_l_arrive_time").Enable    = "True";
                getObjectFirst("d_trn_code").Enable         = "True";
                getObjectFirst("d_trn_desc").readOnly       = false;
            } else {
                getObjectFirst("d_fr_trn_date").Enable      = "False";
                getObjectFirst("d_trn_gu").Enable           = "False";
                getObjectFirst("d_depart_date").Enable      = "False";
                getObjectFirst("d_goods").Enable            = "False";
                getObjectFirst("d_cust_btn").style.display  = "none";
                getObjectFirst("d_l_arrive_date").Enable    = "True";
                getObjectFirst("d_l_arrive_time").Enable    = "True";
                getObjectFirst("d_trn_code").Enable         = "True";
                getObjectFirst("d_trn_desc").readOnly       = false;
            }
        }
    }

    /*
     * 시간, 상품정보 조회
     */     
    function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate=" + d_depart_date.Text;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods)",
            v_param);
        tr_post(tr1);
    }

	// 지역별입경시간 조회
	function fnSelectDs2() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            	  + "sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID") +","
	              + "sArriveDate=" + d_l_arrive_date.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_ARRIVE_TIME_DS=ds3)",
            param);
        tr_post(tr2);
	}	


    function fnDetailSelect(){
        if(ds_master.RowStatus(ds_master.RowPosition)!="1"){
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                        + ", v_saup_sid=" + v_saup_sid
                        + ", v_cust_sid=" + ds_master.NameValue(ds_master.RowPosition, "CUST_SID");
                        
            ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq620I",
                "JSP(O:DETAIL=ds_detail)",
                v_param);
            tr_post(tr2);
        }
    }
</script>
        
<script language="javascript" for="tr1" event="onsuccess()">
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr1" event="onfail()">
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

<script language="javascript" for="tr2" event="onsuccess()">
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr2" event="onfail()">
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

<script language="javascript" for="tr_save" event="onsuccess()">
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr_save" event="onfail()">
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

<script language=JavaScript  for=ds_master event="OnLoadStarted()" >
    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>
<script language=JavaScript  for=ds_detail event="OnLoadStarted()" >
    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>
<script language=JavaScript  for=ds_trn_gu event="OnLoadStarted()" >
    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>
<script language=JavaScript  for=ds_trn_gu2 event="OnLoadStarted()" >
    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
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

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)"> <!-- Main -->
    if(v_flag!="H" && row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=JavaScript for=d_depart_date event=OnKillFocus()> <!-- 출경시간 변경 -->
    if ( d_depart_date.Modified ) {
        fnSelectDs3();          
    }
</script>

<script language=JavaScript for=d_l_arrive_date event=OnKillFocus()> <!-- 예정입경시간 변경 -->
    if ( d_l_arrive_date.Modified ) {
        fnSelectDs2();
    }
</script>


<script language=JavaScript for=gr_master event=OnClick(Row,Colid)>
    if(Row==0) return;
    
    fnDetailSelect();
</script>

<script language=JavaScript for=gr_master event=onKeyPress(keycode)>
    if(ds_master.CountRow==0) return;
    if (keycode == 40 || keycode == 38) {
        getObjectFirst("ds_detail").ClearAll();
        fnScreenDisplay(ds_master.RowPosition);
        fnDetailSelect();
    }
</script>

<script language=JavaScript for=ds_trn_gu event=OnRowPosChanged(Row)> <!-- Grid Event -->
    if(Row==0) return;
    
    if(ds_trn_gu.NameValue(Row, "DETAIL")==1){
        getObjectFirst("tr_trn_code1").style.display = "inline";
        getObjectFirst("tr_trn_code2").style.display = "none";
    } else {
        getObjectFirst("tr_trn_code1").style.display = "none";
        getObjectFirst("tr_trn_code2").style.display = "inline";
    }
    
    
</script>

<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 입경시 -->
    <param name="SyncLoad"  value="true">
</object>

<!-- 지역 정보 -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 고객구분 정보 -->
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 변경시점 CQ003 -->
<object id=ds_trn_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 변경코드 CQ002 -->
<object id=ds_trn_code classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 출발일자에 따른 상품정보 -->
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- 상품정보 -->
<object id=ds_goods2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td>
                <table border='0' cellpadding="0" cellspacing="0" width="845"> 
                    <tr>
                        <td align=right>
                            <table width='845'>
                                <tr>
                                    <td align=right>
                                        <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:hand" onclick="fnSelect()">       <!-- 조회 -->
                                        <img src="<%=dirPath%>/Sales/images/plus.gif"        style="cursor:hand" onClick="fnAdd()">
                                        <img src="<%=dirPath%>/Sales/images/minus.gif"     style="cursor:hand" onClick="fnDel()">
                                        <img src="<%=dirPath%>/Sales/images/save.gif"       style="cursor:hand" onClick="fnApply()">        <!-- 저장 -->
                                        <img src="<%=dirPath%>/Sales/images/cancel.gif"     style="cursor:hand" onClick="fnCancel()">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr height="10px">
                        <td></td>
                    </tr>
                    <tr height="30px">
                        <td width=845>
                            <table border='0' cellpadding="0" cellspacing="1" width="845" bgcolor="#666666">
                                <tr height='25'>
                                    <td align=left class="text">지역</td>
                                    <td align=left bgcolor="#ffffff" colspan=3>&nbsp;                                                                                                     
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=BindColumn      value="saup_sid">
                                            <param name=BindColVal      value="saup_sid">
                                            <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                            <param name=ListExprFormat  value="saup_nm^0^80">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                                <tr height="25">
                                    <td align=left class="text">신청일자</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_fr_trn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=Text                value="<%=endDay%>">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>&nbsp;~&nbsp;
                                        <object id=v_to_trn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=Text                value="<%=startDay%>">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>
                                        <%=HDConstant.COMMENT_END%>                                                                             
                                    </td>
                                    <td align=left class="text">입경예정일자</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_fr_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Text                value="">
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=ReadOnly            value="false">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>&nbsp;~&nbsp;
                                        <object id=v_to_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                            <param name=Text                value="">
                                            <param name=Alignment           value=1>
                                            <param name=Format              value="YYYY-MM-DD">
                                            <param name=InputFormat         value="YYYYMMDD">
                                            <param name=Cursor              value="iBeam">
                                            <param name=Border              value="false">      
                                            <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                            <param name=ReadOnly            value="false">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
                                        </object>
                                        <%=HDConstant.COMMENT_END%>                                                                             
                                    </td>
                                </tr>
                                <tr height="25">
                                    <td align=left class="text">이름</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <input type=text name="v_cust_nm" id="v_cust_nm" size=13 MaxLength="18" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                    </td>
                                    <td align=left class="text">주민/여권번호</td>
                                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                            <param name=Format      value="0000000000000">
                                            <param name=Alignment   value=1>
                                            <param name=ClipMode    value=true>
                                            <param name=Border      value=false>
                                            <param name=MaxLength   value="13">
                                            <param name=SelectAll           value="true">
                                            <param name=SelectAllOnClick    value="true">
                                            <param name=SelectAllOnClickAny value=false>
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
        <tr height="10px"><td></td></tr>
        <tr>
            <td colspan=2>
                <table border='0' cellpadding="0" cellspacing="0" width="845"> 
                    <tr>
                        <td width='390'>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='390px' height='380px' border='1'>
                                <param name="DataID"        value="ds_master">
                                <param name="ColSizing"     value="true">
                                <param name="Fillarea"      value="false">
                                <param name="Editable"      value="true">
                                <param name="BorderStyle"   value="0">
                                <param name=SortView        value="Left">
                                <param name="SuppressOption"    value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <Param Name="UsingOneClick"   value="1">
                                <param name="Format"            value="
                                    <C> name='신청일'       ID='TRN_DATE'          width=90 align=Center Edit=None</C>
                                    <C> name='입경예정일'    ID='F_ARRIVE_DATE'     width=90 align=Center Edit=None</C>
                                    <C> name='변경일'       ID='L_ARRIVE_DATE'     width=80 align=Center Edit=None</C>
                                    <C> name='성명'         ID='CUST_NM'           width=110 align=Center Edit=None</C>
                                    <C> name='예정입경'     ID='L_ARRIVE_TIME'     width=110 align=Center </C>
                                    
                                 ">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=10></td>
                        <td width=445>
                            <table width="100%" border=0 cellspacing=0 cellpadding=0>
                                <tr>
                                    <td>
                                        <table width="100%" border=0 cellspacing=1 cellpadding=0 bgcolor="#666666">
                                            <tr>
                                                <td align=left class="text">신청일</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_fr_trn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="YYYY-MM-DD">
                                                        <param name=InputFormat         value="YYYYMMDD">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=ReadOnly            value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td align=left class="text">변경시점</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_trn_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_trn_gu>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%;detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^80">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr id="tr_trn_code1" style="display:inline">
                                                <td align=left class="text">출발일자</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="YYYY-MM-DD">
                                                        <param name=InputFormat         value="YYYYMMDD">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=ReadOnly            value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td align=left class="text">상품</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_goods>
                                                        <param name=BindColumn      value="goods_sid">
                                                        <param name=BindColVal      value="goods_sid">
                                                        <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                                        <param name=ListExprFormat  value="goods_nm^0^130">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">성명</td>
                                                <td bgcolor="#ffffff">&nbsp;<input type=text name=d_cust_nm id=d_cust_nm size=13 MaxLength="18" class="input01" readOnly>
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" id="d_cust_btn" align="absmiddle" style="cursor:hand;style:inline" onClick="fnCustInoutPopup()">
                                                </td>
                                                <td align=left class="text">주민등록번호</td>
                                                <td align=left bgcolor="#ffffff">&nbsp;<input type=text name=d_manage_no id=d_manage_no size=15 class="input01" readOnly></td>
                                            </tr>
                                            <tr id="tr_trn_code2" style="display:none">
                                                <td align=left class="text">출발일자</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="YYYY-MM-DD">
                                                        <param name=InputFormat         value="YYYYMMDD">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=Enable              value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td align=left class="text">상품</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_goods2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_goods2>
                                                        <param name=BindColumn      value="goods_sid">
                                                        <param name=BindColVal      value="goods_sid">
                                                        <param name=Enable          value="false">
                                                        <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                                        <param name=ListExprFormat  value="goods_nm^0^130">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">출경시간</td>
                                                <td bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_depart_time classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=40 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="00:00">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=Enable              value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">반</td>
                                                <td bgcolor="#ffffff">&nbsp;<input type=text name="d_class" id="d_class" size=8 class="input01" readOnly></td>
                                                <td align=left class="text">조</td>
                                                <td bgcolor="#ffffff">&nbsp;<input type=text name="d_teams" id="d_teams" size=8 class="input01" readOnly></td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">고객구분</td>
                                                <td bgcolor="#ffffff" colspan="3">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_cust_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_cust_gu>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=Enable          value="false">
                                                        <param name=EditExprFormat  value="%,%;detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">입경예정일</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_f_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="YYYY-MM-DD">
                                                        <param name=InputFormat         value="YYYYMMDD">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=Enable              value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>&nbsp;
                                                    <object id=d_f_arrive_time classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=40 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="00:00">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=Enable              value="false">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td align=left class="text">예정변경일</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_l_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox">
                                                        <param name=Text                value="">
                                                        <param name=Alignment           value=1>
                                                        <param name=Format              value="YYYY-MM-DD">
                                                        <param name=InputFormat         value="YYYYMMDD">
                                                        <param name=Cursor              value="iBeam">
                                                        <param name=Border              value="false">      
                                                        <param name=InheritColor        value="true">                                                                                                                                                                                                               
                                                        <param name=Enable              value="true">
                                                        <param name=SelectAll           value="true">
                                                        <param name=SelectAllOnClick    value="true">
                                                        <param name=SelectAllOnClickAny value=false>
                                                    </object>&nbsp;
							                        <object id=d_l_arrive_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle >
														<param name=ComboDataID		value=ds3>
														<param name=BindColumn      value="detail">
							                            <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%;detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^40">
													</object>

                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align=left class="text">변경사유코드</td>
                                                <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                    <object id=d_trn_code classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=ds_trn_code>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td align=left class="text">변경사유</td>
                                                <td bgcolor="#ffffff">&nbsp;<input type=text name=d_trn_desc id=d_trn_desc size=15 class="textbox" OnKeyUp="cfLengthCheck(this, 20);" readOnly></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr><td height=10></td></tr>
                                <tr>
                                    <td>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> style="width:445; height:20">
                                            <param name="BackColor"         value="#00ffff">
                                            <param name="DisableBackColor"  value="#ffffee">
                                            <param name="Format"            value='
                                                <T>divid="mxTab_page1"  title="체류변경내역"</T>'>
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                        <div id="mxTab_page1">
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='445px' height='140px' border='1'>
                                                <param name="DataID"        value="ds_detail">
                                                <param name="ColSizing"     value="true">
                                                <param name="Fillarea"      value="false">
                                                <param name="Editable"      value="true">
                                                <param name="BorderStyle"   value="0">
                                                <param name="Format"            value="
                                                    <C> name=''         ID='{CURROW}'           width=25 align=Center Edit=None</C>
                                                    <C> name='신청일자'       ID='TRN_DATE'        width=80 align=Center Edit=None</C>
                                                    <C> name='입경예정일'    ID='F_ARRIVE_DATE'    width=80 align=Center Edit=None</C>
                                                    <C> name='입경변경일'    ID='L_ARRIVE_DATE'    width=80 align=Center Edit=None</C>
                                                    <C> name='변경사유코드'  ID='TRN_NM'            width=80 align=Center Edit=None</C>
                                                    <C> name='변경사유'     ID='TRN_DESC'          width=120 align=left Edit=None</C>
                                                 ">
                                            </object>
                                            <%=HDConstant.COMMENT_END%>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
						<td colspan=3>-. 변경시점="출경후"일 때, 대상자 조회하면 현재 체류중인 대상중에서 조회합니다.<BR>
						</td>
					</tr>                                                    
                </table>
            </td>
        </tr>
    </table>
    
    <%
    /*=============================================================================
                Bind 선언
    =============================================================================*/
    %>
    <%=HDConstant.COMMENT_START%>
    <object id=mstBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
        <param name="DataId" value="ds_master">
        <param name=BindInfo    value="
            <C>Col=TRN_DATE         Ctrl=d_fr_trn_date          Param=Text</C>          <!-- 신청일자   -->
            <C>Col=TRN_GU           Ctrl=d_trn_gu               Param=BindColVal</C>    <!-- 변경시점   -->
            <C>Col=DEPART_DATE      Ctrl=d_depart_date          Param=Text</C>          <!-- 출발일자   -->
            <C>Col=GOODS_SID        Ctrl=d_goods                Param=BindColVal</C>    <!-- 상품          -->
            <C>Col=DEPART_DATE      Ctrl=d_depart_date2         Param=Text</C>          <!-- 출발일자2 -->
            <C>Col=GOODS_SID        Ctrl=d_goods2               Param=BindColVal</C>    <!-- 상품2    -->
            <C>Col=CUST_NM          Ctrl=d_cust_nm              Param=value</C>         <!-- 성명          -->
            <C>Col=MANAGE_NO        Ctrl=d_manage_no            Param=value</C>         <!-- 주민등록번호-->
            <C>Col=DEPART_TIME      Ctrl=d_depart_time          Param=Text</C>          <!-- 출경시간-->
            <C>Col=CLASS            Ctrl=d_class                Param=value</C>         <!-- 반-->
            <C>Col=TEAMS            Ctrl=d_teams                Param=value</C>         <!-- 조-->
            <C>Col=CUST_GU          Ctrl=d_cust_gu              Param=BindColVal</C>         <!-- 고객구분-->
            <C>Col=F_ARRIVE_DATE    Ctrl=d_f_arrive_date        Param=Text</C>          <!-- 입경예정일-->
            <C>Col=F_ARRIVE_TIME    Ctrl=d_f_arrive_time        Param=Text</C>          <!-- 입경예정시간-->
            <C>Col=L_ARRIVE_DATE    Ctrl=d_l_arrive_date        Param=Text</C>          <!-- 예정변경일-->
            <C>Col=L_ARRIVE_TIME    Ctrl=d_l_arrive_time        Param=BindColVal</C>          <!-- 예정변경시간-->
            <C>Col=TRN_CODE         Ctrl=d_trn_code             Param=BindColVal</C>    <!-- 변경사유코드-->
            <C>Col=TRN_DESC         Ctrl=d_trn_desc             Param=value</C>         <!-- 변경사유-->
            
        ">
    </object>
    <%=HDConstant.COMMENT_END%>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

