<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명          : 현황[달력 형식]
 * 프로그램ID    : RM130S
 * J  S  P       : rm130s
 * 서 블 릿         : Rm130S
 * 작 성 자         : 김영민
 * 작 성 일         : 2006-08-29
 * 기능정의      : 현황[달력 형식]
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

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
	
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
 
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds_saup.Reset(); //지역코드        
    }
    
    /*
     * 메인조회
     */
    function fnSelect() {
        v_job = "S";
    <%
        if(!v_ut.equals("")){
    %>
        if(getObjectFirst("v_client_sid").value=="" ){
            alert("대리점코드<%=HDConstant.A_MSG_MUST_INPUT%>");
            return;
        }
    <%
        }
    %>
        if(getObjectFirst("v_std_date").Text.trim()=="" 
            || getObjectFirst("v_std_date").Text.trim().length!=6){
            alert("조회년월<%=HDConstant.A_MSG_MUST_INPUT%>");
            getObjectFirst("v_std_date").Focus();
            return;
        }
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + ",v_client_sid="+v_client_sid.value
                    + ",v_std_date="+v_std_date.Text;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm130S",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }

    function fnClientPopup() {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnClientPop("<%=dirPath%>",'1');
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_sid.value = arrParam[0];
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
        } else {
            v_client_sid.value = "";
            v_client_nm.value  = "";
            v_client_cd.value = "";
        }               
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
    if(row==0){
        for(var i=1; i<=6; i++)
            getObjectFirst("tr_"+i).style.display = "none";
        
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }

    var v_weeks = "";
    var v_dayofweek = "";
    var v_temp = "";
    
    var v_total_cnt = 0;
    
    for(var i=1; i<=6; i++){
        for(var j=1; j<=7; j++){
            v_temp = i + "_" + j;
            getObjectFirst("tr_"+ i).style.display = "none";
            getObjectFirst("title_"+v_temp).innerHTML = "";
            getObjectFirst("day_"+v_temp).innerHTML = "0";
            getObjectFirst("na1_"+v_temp).innerHTML = "0";
            getObjectFirst("nb1_"+v_temp).innerHTML = "0";
            getObjectFirst("nt2_"+v_temp).innerHTML = "0";
            getObjectFirst("sn1_"+v_temp).innerHTML = "0";
            getObjectFirst("sn2_"+v_temp).innerHTML = "0";
            getObjectFirst("total_"+v_temp).innerHTML = "0";
        }
    }

    for(var i=1; i<=row; i++){
        v_weeks     = ds_master.NameValue(i, "WEEKS");
        v_dayofweek = ds_master.NameValue(i, "DAYOFWEEK");
        v_temp      = v_weeks + "_" + v_dayofweek;
        
        v_total_cnt = Number(ds_master.NameValue(i, "DAY_CNT"))
                    + Number(ds_master.NameValue(i, "NA1_CNT"))
                    + Number(ds_master.NameValue(i, "NB1_CNT"))
                    + Number(ds_master.NameValue(i, "NT2_CNT"))
                    + Number(ds_master.NameValue(i, "SN1_CNT"))
                    + Number(ds_master.NameValue(i, "SN2_CNT"));
                    
        if(getObjectFirst("tr_"+ v_weeks)!=undefined)
            getObjectFirst("tr_"+ v_weeks).style.display = "inline";

        getObjectFirst("title_"+v_temp).innerHTML = ds_master.NameValue(i, "DEPART_DATE");
        getObjectFirst("day_"+v_temp).innerHTML = ds_master.NameValue(i, "DAY_CNT");
        getObjectFirst("na1_"+v_temp).innerHTML = ds_master.NameValue(i, "NA1_CNT");
        getObjectFirst("nb1_"+v_temp).innerHTML = ds_master.NameValue(i, "NB1_CNT");
        getObjectFirst("nt2_"+v_temp).innerHTML = ds_master.NameValue(i, "NT2_CNT");
        getObjectFirst("sn1_"+v_temp).innerHTML = ds_master.NameValue(i, "SN1_CNT");
        getObjectFirst("sn2_"+v_temp).innerHTML = ds_master.NameValue(i, "SN2_CNT");
        getObjectFirst("total_"+v_temp).innerHTML = v_total_cnt;
        
        getObjectFirst("week_total_"+v_weeks).innerHTML = Number(getObjectFirst("week_total_"+v_weeks).innerHTML) + Number(getObjectFirst("total_"+v_temp).innerHTML);
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
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr bgcolor="#6f7f8d" height=25>
                                            <td class="text" width="100">대리점</td>
                                            <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" value="<%=c_cd%>" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
                                                <input type="hidden" value="<%=c_sid%>" name='v_client_sid' id='v_client_sid'>
                                                <%if(v_ut.equals("")){%>
                                                <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnClientPopup();">
                                                <%}%>
                                                <input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:120px;" class='input01' readOnly>
                                            </td>
                                            <td class="text" width="100">지역</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^70">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text" width="100">조회년월</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_std_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                                    <param name=Text        value="<%=firstday%>">
                                                    <param name=Alignment   value=1>
                                                    <param name=Format      value="YYYY-MM">
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
                        </table>
                    </td>
                </tr>
                <tr> 
                    <td height='5px'></td>
                </tr>
                <tr>
                    <td width="845px" colspan='2'>
                        
                        <!-------------------- 달력 html Start ----------------------------->
                        <table width="845" border="1" cellspacing="0" cellpadding="0" bordercolor="#7a7a7a">
                            <tr>
                                <td>
                                    <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF" bgcolor="#EEEEEE">
                                    
                                        <tr>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg01.jpg" align="center"><font color="#FFFFFF"><strong>상&nbsp;품</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg02.jpg" align="center"><font color="#FFFFFF"><strong>일요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>월요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>화요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>수요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>목요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>금요일</strong></font></td>
                                            <td width="105" height="30" background="<%=dirPath%>/Sales/images/cal_bg.jpg" align="center"><font color="#FFFFFF"><strong>토요일</strong></font></td>
                                        </tr>
                                        
                            <%
                                for(int i=1; i<=6; i++){
                            %>
                                        <!--<%=i%>ND WEEK-->
                                        <tr id=tr_<%=i%> style="display:none">
                                            <td align="center">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td class="cal01">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="1" cellspacing="0" cellpadding="0"  style="border-collapse:collapse;" bordercolor="#969696">
                                                                <tr>
                                                                    <td width="34" height="20" align="center"><strong>D</strong></td>
                                                                    <td width="34" align="center"><strong>1NA</strong></td>
                                                                    <td width="34" align="center"><strong>1NB</strong></td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="20" align="center"><strong>2N</strong></td>
                                                                    <td align="center"><strong>S1</strong></td>
                                                                    <td align="center"><strong>S2</strong></td>
                                                                </tr>
                                                                <tr>
                                                                     <td colspan="3" width="105" id="week_total_<%=i%>" class="cal_total"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                     </tr>
                                                </table>
                                            </td>
                                        <%
                                            for(int j=1; j<=7; j++){
                                        %>
                                            <td align="center" class="cal_day">
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td class="cal" id="title_<%=i%>_<%=j%>" align=center></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#b3b3b3"  style="border-collapse:collapse;">
                                                                <tr height="20">
                                                    <!-- D -->      <td width="34" align="center" id=day_<%=i%>_<%=j%> align=right></td>
                                                    <!--1NA-->      <td width="34" align="center" id=na1_<%=i%>_<%=j%> align=right></td>
                                                    <!--1NB-->      <td width="34" align="center" id=nb1_<%=i%>_<%=j%> align=right></td>
                                                                </tr>
                                                                <tr height="20">
                                                    <!--2N-->       <td align="center" id=nt2_<%=i%>_<%=j%> align=right></td>
                                                    <!--S1-->       <td align="center" id=sn1_<%=i%>_<%=j%> align=right></td>
                                                    <!--S2-->       <td align="center" id=sn2_<%=i%>_<%=j%> align=right></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3" class="cal_total" id=total_<%=i%>_<%=j%> align=right></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        <%
                                            } //for(int j=1; j<=7; j++) the end...
                                        %>
                                        </tr>
                                    <%
                                        }//for(int i=1; i<=6; i++) the end...
                                    %>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <!-------------------- 달력 html End ----------------------------->
                        
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

