<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 지역별 인원 현황
 * 프로그램ID       : MI120S
 * J  S  P      : Mi120s
 * 서 블 릿        : Mi120S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-18
 * 기능정의     : 지역별 인원 현황
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
        var v_default_row = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  페이지 로딩 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

        fnInit(); 
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : 선조회 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //지역코드
        
        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
        ds_cust_gu.Reset(); //연령
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
    function fnSelect() {
        if(getObjectFirst("v_job_yymm").Text.trim()=="" || getObjectFirst("v_job_yymm").Text.trim().length!=6){
            alert("작업년월를 입력하시길 바랍니다.");
            getObjectFirst("v_job_yymm").Focus();
            return;
        }
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",sSaup_Sid="+v_saup.ValueOfIndex ("SAUP_SID", v_saup.Index)
                    + ",sJob_Date="+getObjectFirst("v_job_yymm").Text
                    + ",sCust_Gu="+v_cust.ValueOfIndex ("DETAIL", v_cust.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MI%>Mi120S",
            "JSP(O:DS1=ds_master)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  엑셀 파일 출력 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:지역별 인원현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("지역별 인원현황", "지역별 인원현황.xls", 8);
    }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_master" event="OnLoadCompleted(row)">
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

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
    <param name="SubsumExpr" value="">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">지역</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_saup>
                                        <param name=ListExprFormat  value="saup_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" height="25px" class="text">작업년월</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_job_yymm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" height="25px" class="text">고객구분</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_cust_gu>
                                        <param name=ListExprFormat  value="detail_nm^0^100">
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
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:450px" border="1">
                            <param name="DataID"            value="ds_master">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                             <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
	                            <C> name='구분'     ID='DEPART_DATE'      Width=100   Edit=none align=Left   SumText=합계</C>
                                <C> name='계'       ID='QTY_TT'      Width=60   Edit=none align=Right  	 SumText=@sum</C>
                                <C> name='서울'      ID='QTY_01'         Width=60   Edit=none align=Right    SumText=@sum</C>
                                <C> name='경기'      ID='QTY_51'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='부산'      ID='QTY_02'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='울산'      ID='QTY_07'         Width=60   Edit=none align=Right  SumText=@sum</C>
                                <C> name='강원'      ID='QTY_52'         Width=60   Edit=none align=Right    SumText=@sum</C>
                                <C> name='경남'      ID='QTY_56'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='전북'      ID='QTY_57'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='전남'      ID='QTY_58'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='광주'      ID='QTY_05'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='경북'     ID='QTY_55'         Width=60   Edit=none align=Right    SumText=@sum</C>
                                <C> name='인천'     ID='QTY_04'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='대구'     ID='QTY_03'         Width=60   Edit=none align=Right  SumText=@sum </C>
                                <C> name='충남'     ID='QTY_54'         Width=60   Edit=none align=Right   SumText=@sum</C>
                                <C> name='충북'     ID='QTY_53'         Width=60   Edit=none align=Right  SumText=@sum </C>
                                <C> name='대전'     ID='QTY_06'         Width=60   Edit=none align=Right  SumText=@sum </C>
                                <C> name='제주'     ID='QTY_59'         Width=60   Edit=none align=Right  SumText=@sum</C>
                                <C> name='외국인'     ID='QTY_90'         Width=60   Edit=none align=Right   SumText=@sum </C>
                                <C> name='기타'     ID='QTY_99'         Width=60   Edit=none align=Right   SumText=@sum </C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

