<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명      	: 객실사용현황
 * 프로그램ID    	: RV852S
 * J  S  P   	: rv852s
 * 서 블 릿         : Rv852S
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-24
 * 기능정의      : 일별세부내역
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-10-11][심동현] rv851s 복사해서 검색조건만 다른 rv852s 생성.
                       향후에 객실 카운트 하는 로직을 변경하게 되면 이것만 살아남을 듯.
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
    date.add(java.util.Calendar.DATE, 0);
    String firstday = m_today.format(date.getTime());
    date.add(java.util.Calendar.DATE, +7);
    String endday = m_today.format(date.getTime());   
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
    }
    
    /*
     * Grid Format ReDraw
     */
    function fnFomat(){
        var loop_cnt = ds_master.CountColumn;
        var temp_day = "";
        
        if(loop_cnt==0) loop_cnt = 31*7;
        
        for(var i=1; i<=loop_cnt; i++){
            if(i<10) temp_day = "0"+i;
            else temp_day = i;
            
            if((i+6)%7==0)
                gr_master.Format += "<G>name="+temp_day+"";
            gr_master.Format += "<C> name='계'      ID='TOTAL_01' Width=90    align=right  edit=none </C>";
        }
    }
    
    /*
     * 메인조회 
     */
    function fnSelect() {
        v_job = "S";

        if(getObjectFirst("v_bgn_date").Text.trim()=="" 
            || getObjectFirst("v_bgn_date").Text.trim().length!=8){
            alert("일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
            getObjectFirst("v_bgn_date").Focus();
            return;
        }
        if(getObjectFirst("v_end_date").Text.trim()=="" 
            || getObjectFirst("v_end_date").Text.trim().length!=8){
            alert("일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
            getObjectFirst("v_end_date").Focus();
            return;
        }
        
        gr_master.ReDraw = "false";
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                     + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + ",v_bgn_date="+v_bgn_date.Text
                    + ",v_end_date="+v_end_date.Text;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv852S",
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
        getObjectFirst("gr_master").SetExcelTitle(1, "value:객실이용현황(세부) ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_master").GridToExcel("객실이용현황(세부)", "객실이용현황(세부).xls", 8);
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

<script language=JavaScript  for=v_bgn_date event="OnKillFocus()" >
    if(v_bgn_date.Modified)
        v_end_date.Text = v_bgn_date.Text
</script>

<script language=JavaScript for=v_bgn_date event=onKeyDown(kcode,scode)>
//엔터키 치면 조회펑션 호출
	if (kcode == 13) fnSelect();
</script>
<script language=JavaScript for=v_end_date event=onKeyDown(kcode,scode)>
//엔터키 치면 조회펑션 호출
	if (kcode == 13) fnSelect();
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name=SortExpr	value="+SEQ1+SEQ2+ROOM_TYPE_CD+CALN_DATE">
</object>
<object id=ds_master2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name=Logical     value="true">
    <param name=DataId     value="ds_master">
    <param name=SubsumExpr  value="UPJANG_NM">
    <param name=GroupExpr   value="UPJANG_NM:ROOM_TYPE_CD:ROOM_TYPE_NM,CALN_DATE,TOT_CNT:STY_CNT:NA1_CNT:NB1_CNT:NT2_CNT:NT2N_CNT:NT2G_CNT:SN1_CNT:SN2_CNT">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
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
                                            <td class="text" width="100">지역</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^70">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text" width="100">일자</td>
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
                                                    <param name=Text        value="<%=endday%>">
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
                                                　※ Enter키를 치면 바로 조회합니다.
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
                                <td align="left" width="845px" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=845px; height:420px" border="1">
                                        <param name="DataID"            value="ds_master2">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="SuppressOption"    value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <FC> name='구분'           ID='UPJANG_NM'    Width=100    align=left edit=none suppress=1 SubSumText=''</FC>
                                            <FC> name='객실코드'        ID='ROOM_TYPE_CD' Width=70    align=center edit=none suppress=2 SubSumText=''</FC>
                                            <FC> name='객실타입명'      ID='ROOM_TYPE_NM' Width=80    align=left   edit=none suppress=3 SubSumText=''</FC>
                                            <R>
                                                <G>name=$xkeyname_$$ mask='XX/XX'
                                                    <C> name='계'   	 ID=TOT_CNT_$$ Width=30    align=right   edit=none fontstyle=bold</C>
                                                    <C> name='PRE'   ID=STY_CNT_$$ Width=30    align=right   edit=none </C>
                                                    <C> name='1N'    ID=NA1_CNT_$$ Width=30    align=right   edit=none</C>
                                                    <C> name='1N-B'  ID=NB1_CNT_$$ Width=32    align=right   edit=none</C>
                                                    <C> name='2N'    ID=NT2_CNT_$$ Width=30    align=right   edit=none</C>
                                                    <C> name='2N(N)' ID=NT2N_CNT_$$ Width=40    align=right   edit=none</C>
                                                    <C> name='2N(G)' ID=NT2G_CNT_$$ Width=40    align=right   edit=none</C>
                                                    <C> name='S1'    ID=SN1_CNT_$$ Width=30    align=right   edit=none</C>
                                                    <C> name='S2'    ID=SN2_CNT_$$ Width=30    align=right   edit=none</C>
                                                </G>
                                            </R>
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

