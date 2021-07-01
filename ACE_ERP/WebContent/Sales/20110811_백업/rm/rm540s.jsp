<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명          : 예약블록조회
 * 프로그램ID    : RM540S
 * J  S  P       : rm540s
 * 서 블 릿         : Rm540S
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-28
 * 기능정의      : 예약블록조회
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

	//날짜 기본값
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());   
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

        ds_goods.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?proType=S&dsType=2";
        ds_goods.Reset();   //상품정보
    }
    
    /*
     * 메인조회
     */
    function fnSelect() {
        v_job = "S";

        if(getObjectFirst("v_depart_bgn_date").Text.trim()=="" 
            || getObjectFirst("v_depart_bgn_date").Text.trim().length!=8){
            alert("출발일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
            getObjectFirst("v_depart_bgn_date").Focus();
            return;
        }
        if(getObjectFirst("v_depart_end_date").Text.trim()=="" 
            || getObjectFirst("v_depart_end_date").Text.trim().length!=8){
            alert("출발일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
            getObjectFirst("v_depart_end_date").Focus();
            return;
        }
        
        gr_master.ReDraw = "false";
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_bgn_date="+v_bgn_date.Text
                    + ",v_end_date="+v_end_date.Text
                    + ",v_depart_bgn_date="+v_depart_bgn_date.Text
                    + ",v_depart_end_date="+v_depart_end_date.Text
                    + ",v_goods="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm540S",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }

    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_master").SetExcelTitle(0, "");
        getObjectFirst("gr_master").SetExcelTitle(1, "value:예약블록조회 ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("예약블록조회", "예약블록조회.xls", 8);
    }
    
</script>

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

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)" >
    gr_master.ReDraw = "true";
</script>

<script language=JavaScript  for=v_depart_bgn_date event="OnKillFocus()" >
    if(v_depart_bgn_date.Modified)
        v_depart_end_date.Text = v_depart_bgn_date.Text
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
    <param name=SubsumExpr  value="1:CLIENT_NM">
</object>
<object  id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnExcel()">&nbsp;
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr bgcolor="#6f7f8d" height=25>
                                            <td class="text" width="100">확정일자</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_bgn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                                <object id=v_end_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                            <td class="text" width="100">출발일자</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_depart_bgn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">
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
                                                <object id=v_depart_end_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text width="100">상품명</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_goods>
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
                                        <Param Name="SuppressOption"    value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <FC> name='대리점명'     ID='CLIENT_NM'          Width=120   align=left   edit=none suppress=1 SubSumText=''</FC>
                                            <FC> name='출발일자'     ID='DEPART_DATE'        Width=80    align=center edit=none suppress=2 SubSumText=''</FC>
                                            <FC> name='상품명'          ID='GOODS_NM'           Width=120   align=left   edit=none suppress=3</FC>
                                            <C> name='확정일시'     ID='Q_DATE'             Width=80    align=center edit=none</C>
                                            <C> name='블록NO'     ID='BLOCK_NO'           Width=80   align=center   edit=none</C>
                                            <C> name='타입'       ID='A_ROOM_TYPE_CD'     Width=120    align=left edit=none</C>
                                            <C> name='객실수'       ID='A_ROOM_CNT'        Width=60   align=center   edit=none</C>
                                            <C> name='인원'           ID='ACCEPT_PERSONS'     Width=50   align=center   edit=none</C>
                                            <C> name='단체명'      ID='GROUP_NM'           Width=90    align=left   edit=none</C>
                                            <C> name='요청사항'     ID='A_REMARKS'          Width=120   align=left   edit=none</C>
                                            <C> name='블록상태'     ID='BLOCK_STATUS_CD'    Width=60    align=center edit=none</C>
                                            <C> name='타입'           ID='C_ROOM_TYPE'        Width=60    align=center edit=none</C>
                                            <C> name='객실수'          ID='C_ROOM_CNT'         Width=60    align=center edit=none</C>
                                            <C> name='인원'       ID='CONFIRM_PERSONS'    Width=50    align=center edit=none</C>
                                            <C> name='T/L'          ID='TL_DATE'            Width=60    align=center edit=none</C>
                                            <C> name='기재사항'     ID='C_REMARKS'          Width=80    align=left  edit=none dec=0</C>
                                            <C> name='입금예정일자' ID='PLAN_PAY_DATE'      Width=80   align=center edit=none</C>
                                            <C> name='모객율타입'    ID='CUST_RATE_TYPE'     Width=80   align=center edit=none</C>
                                            <C> name='보증금율'     ID='DEPOSIT_RATE'       Width=60   align=right edit=none dec=2</C>
                                            <C> name='보증금'      ID='DEPOSIT_AMT'        Width=60   align=right edit=none dec=0</C>
                                            <C> name='실적객실수'    ID='ACTUAL_ROOM_CNT'    Width=80   align=left edit=none</C>
                                            <C> name='인원'       ID='ACTUAL_PERSONS'     Width=60   align=center edit=none</C>
                                            <C> name='비율'       ID='ACTUAL_RATE'        Width=60   align=right edit=none dec=2</C>
                                            <C> name='신청일자'     ID='I_DATE'             Width=80   align=left edit=none</C>
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

