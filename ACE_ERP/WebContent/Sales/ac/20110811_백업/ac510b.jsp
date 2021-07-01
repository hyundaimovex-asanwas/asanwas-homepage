<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명          : 일별세부내역
 * 프로그램ID    : AC520B
 * J  S  P       : ac520b
 * 서 블 릿         : Ac520B
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-24
 * 기능정의      : 일별세부내역
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

        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
        
        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
        ds_cust_gu.Reset();//고객구분

        ds_age.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV014&s_item=Y";
        ds_age.Reset(); //연령

        ds_cust_type.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV003&s_item=Y";
        ds_cust_type.Reset();  //할인유형
        
    }
    //상품조회
	function fnSelectLcGoods() {
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
		    + ",sSaupSid=" + v_saup.ValueOfIndex("saup_sid", v_saup.Index)
			+ ",sDepartDate=";
		ln_TRSetting(tr1, 
		    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
		    "JSP(O:S_GOODS_DS=ds_goods)",
		    param);
		tr_post(tr1);
	};
    /*
     * 메인조회
     */
    function fnSelect() {
        v_job = "S";
        
        gr_master.ReDraw = "false";
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_saup_sid   = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);
        v_upjang_sid = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+v_saup_sid
                    + ",v_job_yymm=" + v_job_yymm.Text
                    + ",v_upjang_sid="+v_upjang_sid
                    + ",v_fr_date="+v_fr_date.Text
                    + ",v_to_date="+v_to_date.Text
                    + ",v_goods="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
                    + ",v_accept_no="+v_accept_no.Text;
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac510B",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    
    /*
     * 저장
     */
    function fnApply() {
        if(ds_master.CountRow==0){
            alert("저장할 내역이 없습니다.");
            return;
        }
        
        if(ds_master.IsUpdated==false){
            alert("변경된 내역이 없습니다.");
            return;
        }

/*        
        gr_master.ReDraw = "false";
        for(i=1; i<=ds_master.CountRow; i++) {
            if(ds_master.NameValue(i, "TOT_ROOM_AMT")=="" || ds_master.NameValue(i, "TOT_ROOM_AMT")=="0"){
                alert("총숙박비 <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("TOT_ROOM_AMT");
                ds_master.RowPosition = i;
                return;
            }
        }
        gr_master.ReDraw = "true";
*/
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac510B",
            "JSP(I:SAVE=ds_master,O:RESULT=ds_result)",
            v_param);
        tr_post(tr_save);
    }

    /*
     * 생성
     */
    function fnCreate() {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                    + ",v_job_yymm=" + v_job_yymm.Text;
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac510B",
            "JSP(I:CREATE=ds_master,O:RESULT=ds_result)",
            v_param);
        tr_post(tr_save);
    }
    /*
     * 삭제
     */
    function fnDelete() {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                    + ",v_job_yymm=" + v_job_yymm.Text;
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac510B",
            "JSP(I:DELETE=ds_master,O:RESULT=ds_result)",
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

    /**
     *  신청서 번호로 조회시
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

    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr_master").SetExcelTitle(0, "");
        getObjectFirst("gr_master").SetExcelTitle(1, "value:일별세부내역 ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("일별세부내역", "일별세부내역.xls", 8);
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

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";

    fnSelect();
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
    
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
	fnSelectLcGoods();
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
<object  id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_age classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_cust_type classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                                    <img src="<%=dirPath%>/Sales/images/n_create.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCreate()">
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                                    <img src="<%=dirPath%>/Sales/images/delete.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDelete()">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnExcel()">
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr>
                                            <td class="text" width="100">지역</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^100">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text width="100">업장명</td>
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
                                            <td class="text" width="100">작업년월</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_job_yymm classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                                    <param name=Text        value="<%=firstday%>">
                                                    <param name=Alignment   value=1>
                                                    <param name=Format      value="YYYY-MM">
                                                    <param name=InputFormat value="YYYYMMDD">
                                                    <param name=Cursor      value="iBeam">
                                                    <param name=Border      value="false">
                                                    <param name=InheritColor      value="true">
                                                    <param name=ReadOnly        value="false">
                                                    <param name=SelectAll       value="true">
                                                    <param name=SelectAllOnClick    value="true">
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                        <tr bgcolor="#6f7f8d" height=25>
                                            <td class="text">출발일자</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                            <td class=text>상품명</td>
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
                                            <td class=text>신청서번호</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox">            
                                                    <param name=Alignment   value=1>
                                                    <param name=Format      value="00000-000000000">
                                                    <param name=Cursor      value="iBeam">
                                                    <param name=Border      value="false">      
                                                    <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                                    <param name=ReadOnly    value="false">
                                                    <param name=SelectAll   value="true">
                                                    <param name=SelectAllOnClick    value="true">
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                                <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()">
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
                                        <Param Name="SuppressOption"    value="1">
                                        <param name=ViewSummary     value=1>
                                        <param name="Format"            value=" 
                                            <FC> name=''            ID='{CURROW}'       Width=35    align=center edit=none SumText='합계'</FC>
                                            <FC> name='출발일자'    ID='DEPART_DATE'    Width=80    align=center edit=none suppress=1</C>
                                            <FC> name='시즌구분'		ID='SEASON_NM'		width=80 	align=left edit=none suppress=4</C>
                                            <FC> name='상품'          ID='GOODS_SID'      Width=120   align=left   edit=none editstyle=Lookup Data='ds_goods:goods_sid:goods_nm' suppress=2</FC>
                                            <C> name='신청서번호'   ID='ACCEPT_NO'      Width=120    align=left   edit=none suppress=3</C>
                                            <C> name='이름'         ID='CUST_NM'          Width=100   align=left   edit=none</C>
                                            <C> name='주민/여권번호' ID='MANAGE_NO'      Width=100  align=left   edit=none</C>
                                            <C> name='고객구분'     ID='CUST_GU'        Width=80    align=center edit=none editstyle=Lookup Data='ds_cust_gu:DETAIL:DETAIL_NM'</C>
                                            <C> name='연령구분'     ID='AGE_CD'         Width=120   align=center edit=none editstyle=Lookup Data='ds_age:DETAIL:DETAIL_NM'</C>
                                            <C> name='할인유형'     ID='CUST_TYPE'      Width=80    align=center edit=none editstyle=Lookup Data='ds_cust_type:DETAIL:DETAIL_NM'</C>
                                            <C> name='신청등급'     ID='A_ROOM_TYPE_CD' Width=80    align=center edit=none</C>
                                            <C> name='확정등급'     ID='ROOM_TYPE_CD'   Width=80    align=center edit=none</C>
                                            <C> name='이용호실'     ID='ROOM_NO'        Width=80    align=center edit=none</C>
                                            <C> name='관광요금'     ID='TOUR_AMT'       Width=80    align=right  edit=none dec=0 SumText=@sum SumTextAlign=right</C>
                                            <C> name='기준요금'     ID='TOUR_BASE_AMT'  Width=80    align=right  edit=none dec=0 SumText=@sum SumTextAlign=right</C>
                                            <C> name='조정율(%)'      ID='CONT_RATE'      Width=80    align=right  edit=none </C>
                                            <C> name='기준숙박비'   ID='BASE_ROOM_AMT'  Width=80 align=right  edit=none dec=0</C>
                                            <C> name='조정숙박비'   ID='CONT_BASE_AMT'  Width=80 align=right  edit=none dec=0 </C>
                                            <C> name='일수'       ID='NIGHTS'         Width=80    align=center edit=none </C>
                                            <C> name='총숙박비'     ID='TOT_ROOM_AMT'   Width=80    align=right  dec=0 SumText=@sum SumTextAlign=right</C>
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

