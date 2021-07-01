<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명          : 취소인원조회
 * 프로그램ID    : RV841S
 * J  S  P       : rv841s
 * 서 블 릿         : Rv841S
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-24
 * 기능정의      : 취소인원조회
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
                     + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + ",v_bgn_date="+v_bgn_date.Text
                    + ",v_end_date="+v_end_date.Text
                    + ",v_depart_bgn_date="+v_depart_bgn_date.Text
                    + ",v_depart_end_date="+v_depart_end_date.Text
                    + ",v_goods="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv841S",
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
        getObjectFirst("gr_master").SetExcelTitle(1, "value:취소인원조회 ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("취소인원조회", "취소인원조회.xls", 8);
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
    <param name=SubsumExpr  value="2:DEPART_DATE,1:GOODS_NM">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
                                    <img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnExcel()">&nbsp;
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr bgcolor="#6f7f8d" height=25>
                                            <td class="text" width="60">지역</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^70">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text" width="80">취소일자</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_bgn_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                                <object id=v_end_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
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
                                            <td class="text" width="80">출발일자</td>
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
                                            <td class=text width="60">상품명</td>
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
                                            <C> name='출발일'    ID='DEPART_DATE'    Width=45    align=center edit=none suppress=1 SubSumText=''</C>
                                            <C> name='상품명'      ID='GOODS_NM'          Width=85   align=left   edit=none suppress=2 SubSumText=''</C>
                                            <C> name='대리점명'     ID='CLIENT_NM'      Width=100   align=left   edit=none suppress=3 SubSumText=''</C>
                                            <C> name='인원'         ID='PERSONS'        Width=40    align=center edit=none</C>
                                            <C> name='신청서번호'    ID='ACCEPT_NO'      Width=100   align=left   edit=none</C>
                                            <C> name='취소일시'     ID='RSV_DATE'       Width=80    align=center edit=none</C>
                                            <C> name='성명'       ID='CUST_NM'        Width=60   align=left   edit=none</C>
                                            <C> name='직장/직위'    ID='COMPANY_NM'     Width=150   align=left   edit=none</C>
                                            <C> name='주민/여권번호' ID='MANAGE_NO'   Width=100    align=left   edit=none</C>
                                            <C> name='주소'       ID='ADDRESS1'       Width=150   align=left   edit=none</C>
                                            <C> name='동행자'      ID='M_CUST_NM'      Width=60    align=left edit=none</C>
                                            <C> name='관계'       ID='JOIN_NM'        Width=60    align=center edit=none</C>
                                            <C> name='반/조'      ID='CLASS'          Width=60    align=center edit=none</C>
                                            <C> name='객실등급'     ID='ROOM_TYPE_CD'   Width=80    align=center edit=none</C>
                                            <C> name='방번호'          ID='ROOM_NO'        Width=60    align=center edit=none</C>
                                            <C> name='판매액'      ID='USE_AMT'        Width=80    align=right  edit=none dec=0</C>
                                            <C> name='연락처(자택)' ID='TEL_NO'          Width=110   align=left edit=none</C>
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

