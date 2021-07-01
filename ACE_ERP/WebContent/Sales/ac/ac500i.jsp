<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명          : 숙박비 기초 관리
 * 프로그램ID    : AC500I
 * J  S  P       : ac500i
 * 서 블 릿         : Ac500I
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-21
 * 기능정의      : 숙박비 기초 관리
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
    var v_job = "H";
    var v_saup_sid = "";
    var v_upjang_sid = "";
    
    /*
     * 페이지로딩
     */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		fnInit();
	}
    /*
     * 선조회
     */
    function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr_master"), "comn");

        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
        
        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
        ds_cust_gu.Reset();//고객구분

        ds_age.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV014&s_item=Y";
        ds_age.Reset(); //연령
        ds_season.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM006&s_item=Y";
        ds_season.Reset(); //시즌
       
        ds_cust_type.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV003&s_item=Y";
        ds_cust_type.Reset();  //할인유형
        
        ds_method_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AC018&s_item=Y";
        ds_method_gu.Reset();  //적용방법
        
        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item2=Y";
        ds_status.Reset();  //취소구분
        
    }
    //상품조회
	function fnSelectLcGoods() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
		    + ",sSaupSid=" + v_saup.ValueOfIndex("saup_sid", v_saup.Index)
			+ ",sDepartDate=";
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_GOODS_DS=ds_goods0)",
		    param);
		tr_post(tr1);
	};
    /*
     * 메인조회
     */
    function fnSelect() {
        v_job = "S";
        
        gr_master.ReDraw = "false";
        
        if(ds_master.IsUpdated){
            alert("변경중인 내역이 있습니다.");
            return;
        }
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        var v_param = "dsType=1"
                    + "&proType=S"
                    + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + "&s_UpjangType=10"
                    + "&s_use_yn=Y";
        ds_upjang1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
        ds_upjang1.Reset(); //업장
    
        v_param = "proType=S"
                + "&dsType=2"
                + "&s_UpjangSid="+v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);
        ds_room1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm001H?"+v_param;
        ds_room1.Reset(); //객실
    
        v_saup_sid   = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);
        v_upjang_sid = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+v_saup_sid
                    + ",v_upjang_sid="+v_upjang_sid
                    + ",v_season="+v_season.ValueOfIndex("DETAIL", v_season.Index)
                    + ",v_room="+v_room.ValueOfIndex("ROOM_TYPE_SID", v_room.Index)
                    + ",v_age="+v_age.ValueOfIndex("DETAIL", v_age.Index)
                    + ",v_goods="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
                    + ",v_cust_gu="+ v_cust_gu.ValueOfIndex("DETAIL", v_cust_gu.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac500I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    
    function fnAddRow(){
        ds_master.AddRow();
        
        if(ds_master.CountRow==0){
            alert("먼저 조회후 추가하시길 바랍니다.");
            return;
        }
        
        ds_master.NameValue(ds_master.CountRow, "SAUP_SID") = v_saup_sid;
    }
    
    function fnDeleteRow(){
        if(ds_master.RowPosition==0) return;
        
        ds_master.DeleteRow(ds_master.RowPosition);
    }
    
    /*
     * 적용
     */
    function fnApply() {
        var v_apply_cnt = 0;
        if (ds_master.IsUpdated==false) {
            alert("변경된 내역이 없습니다.");
            return;
        }
        
        for(i=1; i<=ds_master.CountRow; i++) {
            if(ds_master.NameValue(i, "ROOM_TYPE_SID")=="" || ds_master.NameValue(i, "ROOM_TYPE_SID")=="0"){
                alert("객실타입 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("ROOM_TYPE_SID");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "UPJANG_SID")=="" || ds_master.NameValue(i, "UPJANG_SID")=="0"){
                alert("영업장 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("UPJANG_SID");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "GOODS_SID")=="" || ds_master.NameValue(i, "GOODS_SID")=="0"){
                alert("상품 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("GOODS_SID");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "SEASON_CD")=="" || ds_master.NameValue(i, "SEASON_CD")=="0"){
                alert("시즌 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("SEASON_CD");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "CUST_GU")=="" || ds_master.NameValue(i, "CUST_GU")=="0"){
                alert("고객구분 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("CUST_GU");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "AGE_CD")=="" || ds_master.NameValue(i, "AGE_CD")=="0"){
                alert("연령 구분<%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("AGE_CD");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "CUST_TYPE")=="" || ds_master.NameValue(i, "CUST_TYPE")=="0"){
                alert("할인유형 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("CUST_TYPE");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "METHOD_GU")=="" || ds_master.NameValue(i, "METHOD_GU")=="0"){
                alert("적용방법 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("METHOD_GU");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "TOUR_BASE_AMT")=="" || ds_master.NameValue(i, "TOUR_BASE_AMT")=="0"){
                alert("숙박기준가 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("TOUR_BASE_AMT");
                ds_master.RowPosition = i;
                return;
            }
            
            if(ds_master.NameValue(i, "STATUS_CD")=="" || ds_master.NameValue(i, "STATUS_CD")=="0"){
                alert("취소구분 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("STATUS_CD");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "FR_DATE")=="" || ds_master.NameValue(i, "FR_DATE")=="0"){
                alert("시작일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("FR_DATE");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "TO_DATE")=="" || ds_master.NameValue(i, "TO_DATE")=="0"){
                alert("종료일자 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("TO_DATE");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "USE_YN")=="" || ds_master.NameValue(i, "USE_YN")=="0"){
                alert("사용여부 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("USE_YN");
                ds_master.RowPosition = i;
                return;
            }
        }

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac500I",
            "JSP(I:MASTER=ds_master,O:RESULT=ds_result)",
            v_param);
        tr_post(tr_save);
    }

    /*
     * 취소
     */
    function fnCancel() {
        ds_master.undoall();
        window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
    }
	function fnExcel() {
        if(ds_master.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_master").SetExcelTitle(0, "");
        getObjectFirst("gr_master").SetExcelTitle(1, "value:숙박비기초관리 ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("숙박비기초관리", "숙박비기초관리.xls", 8);
    }
</script>

<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
	fnSelectLcGoods();
</script>
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
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    
    for(var i=1,j=1; i<=ds_master.CountRow; i++){
        if(ds_master.RowStatus(i)==1){
//alert(ds_result.NameValue(j, "BASE_ROOM_SID"));
            ds_master.NameValue(i, "BASE_ROOM_SID") = ds_result.NameValue(j, "BASE_ROOM_SID");
            j++;
        }
    }
    ds_master.ResetStatus();
    
    if(v_msg!=""){
        alert(v_msg);
    }
</script>

<script language=JavaScript for=v_saup event=OnSelChange()>
    fnSelectLcGoods();//상품 재검색
    var v_param = "dsType=1"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=10"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //업장
</script>

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)" >
    gr_master.ReDraw = "true";
</script>

<script language=JavaScript for=v_upjang event=OnSelChange()>
    var v_param = "proType=S"
                + "&dsType=2"
                + "&s_UpjangSid="+v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);
    ds_room.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm001H?"+v_param;
    ds_room.Reset(); //객실
</script>

<script language=JavaScript for=gr_master event=OnCloseUp(Row,Colid)>
    if(Row==0) return;
    if(Colid == "ROOM_TYPE_SID"){
        var nameIndex = getObjectFirst("ds_room1").NameValueRow('ROOM_TYPE_SID', getObjectFirst("ds_master").NameValue(Row, Colid));
                
        getObjectFirst("ds_master").NameValue(Row, "UPJANG_SID") = getObjectFirst("ds_room1").NameValue(nameIndex, "UPJANG_SID");
    }
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_upjang1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_season classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_room classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_room1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_age classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods0 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id=ds_cust_type classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_method_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
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
    <param name="StatusResetType"  value="2">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
                                    
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <table border="0" width="845px"  cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" colspan="2">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr bgcolor="#ffffff">
                                <td align="right" height="30px">        
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/plus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnAddRow()">
                                    <img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()">
                                    <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                                	<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnExcel()">
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr>
                                            <td class="text">지역</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^100">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text>업장명</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_upjang>
                                                    <param name=SearchColumn        value="upjang_nm">
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="upjang_nm^0^130">
                                                    <param name=BindColumn          value="upjang_sid">
                                                </object>
                                                <%=HDConstant.COMMENT_END%> 
                                            </td>
                                            <td class=text>시즌</td>
                                            <td bgcolor="#ffffff" colspan=3>&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_season classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_season>
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="DETAIL_NM^0^130">
                                                    <param name=BindColumn          value="DETAIL">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                        <tr bgcolor="#6f7f8d" height=25>
                                            <td class=text>객실</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_room classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_room>
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="ROOM_TYPE_NM^0^130">
                                                    <param name=BindColumn          value="ROOM_TYPE_SID">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text">고객구분</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_cust_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_cust_gu>
                                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text>연령</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_age classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_age>
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="DETAIL_NM^0^130">
                                                    <param name=BindColumn          value="DETAIL">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text>상품명</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_goods0>
                                                    <param name=SearchColumn        value="GOODS_NM">
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="GOODS_NM^0^130">
                                                    <param name=BindColumn          value="GOODS_SID">
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
                    <td height='5px'></td>
                </tr>
                <tr>
                    <td width="845px" colspan='2'>
                        <table  border="0" cellpadding="0" cellspacing="0" >
                            <tr valign="top"">
                                <td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=845px; height:420px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <FC> name='객실등급'     ID='ROOM_TYPE_SID'  Width=100  align=center editstyle=Lookup Data='ds_room1:ROOM_TYPE_SID:ROOM_TYPE_NM'</FC>
                                            <C> name='영업장'       ID='UPJANG_SID'     Width=120  align=center edit=none editstyle=Lookup Data='ds_upjang1:upjang_sid:upjang_nm' bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C> name='상품코드'     ID='GOODS_SID'      Width=120  align=center editstyle=Lookup Data='ds_goods:goods_sid:goods_nm'</C>
                                            <C> name='시즌'           ID='SEASON_CD'      Width=120  align=center editstyle=Lookup Data='ds_season:DETAIL:DETAIL_NM'</C>
                                            <C> name='고객구분'     ID='CUST_GU'        Width=80  align=center editstyle=Lookup Data='ds_cust_gu:DETAIL:DETAIL_NM'</C>
                                            <C> name='연령구분'     ID='AGE_CD'         Width=80  align=center editstyle=Lookup Data='ds_age:DETAIL:DETAIL_NM'</C>
                                            <C> name='할인유형'     ID='CUST_TYPE'      Width=120  align=center editstyle=Lookup Data='ds_cust_type:DETAIL:DETAIL_NM'</C>
                                            <C> name='적용방법'     ID='METHOD_GU'      Width=80  align=center editstyle=Lookup Data='ds_method_gu:DETAIL:DETAIL_NM'</C>
                                            <C> name='숙박기준가'   ID='TOUR_BASE_AMT'  Width=80  align=right edit=Numeric dec=0</C>
                                            <C> name='기준숙박비'   ID='BASE_ROOM_AMT'  Width=80  align=right edit=Numeric dec=0</C>
                                            <C> name='취소구분'     ID='STATUS_CD'      Width=80  align=center editstyle=Lookup Data='ds_status:DETAIL:DETAIL_NM'</C>
                                            <C> name='시작인원'     ID='BGN_PERSONS'    Width=80  align=right edit=Numeric editlimit=2</C>
                                            <C> name='종료인원'     ID='END_PERSONS'    Width=80  align=right edit=Numeric editlimit=2</C>
                                            <C> name='시작일자'     ID='FR_DATE'        Width=80  align=center edit=Numeric mask='XXXX-XX-XX'</C>
                                            <C> name='종료일자'     ID='TO_DATE'        Width=80  align=center edit=Numeric mask='XXXX-XX-XX'</C>
                                            <C> name='사용여부'     ID='USE_YN'         Width=80  align=center EditStyle=Combo Data='Y:Y,N:N'</C>
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


