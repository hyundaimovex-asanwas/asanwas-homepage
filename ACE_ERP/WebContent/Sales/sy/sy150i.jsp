<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 월력관리
 * 프로그램ID 	 : SY150I
 * J  S  P		 : sy150i
 * 서 블 릿		 : Sy150I
 * 작 성 자		 : 심동현
 * 작 성 일		 : 2010-05-19
 * 기능정의		 : 월력, 휴일관
 * [ 수정일자 ][수정자] 내용
 * [2010-05-19][심동현] 신규
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
   String startday = m_today.format(date.getTime());           
   date.add(java.util.Calendar.DATE, +10);         
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
    
    var v_master_row = 0;

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

        //휴일여부
        init_holiDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY010&s_item1=Y";
        init_holiDs.Reset();
	}
	
	/*
	 * 메인조회
	 */
    function fnSelect() {
		if (ds_master.isUpdated) { 
			alert("수정중인 행이 있습니다.");
            return;
		} else {        
            if ( v_fr_date.text.trim() == '' || v_fr_date.text.trim().length!=8) {
                alert("출발일자(From)를 입력해주세요.");
                v_fr_date.Focus();
                return;
            }
            if ( v_to_date.text.trim() == '' || v_to_date.text.trim().length!=8) {
                alert("출발일자(To)를 입력해주세요.");
                v_to_date.Focus();
                return;
            }
            
	        v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";
	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	            + "v_fr_date=" + v_fr_date.text.trim() + ","
        	         	+ "v_to_date=" + v_to_date.text.trim();
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy150I",
	            "JSP(O:MASTER=ds_master)",
	            v_param);
	        tr_post(tr1);
	    }
    }
    
	/*
	 * 적용
	 */
	function fnApply() {
        var v_apply_cnt = 0;
		if (ds_master.IsUpdated) {
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_depart_date="+ ds_master.NameValue(ds_master.RowPosition, "CALN_DATE");
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy150I",
                "JSP(I:MASTER=ds_master,O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
            window.status="<%=HDConstant.A_MSG_SAVE_DONE%>";
		}
	}

	/*
	 * 취소
	 */
	function fnCancel() {
        ds_master.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}

</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	
     
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

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr2.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= 안내 메시지=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
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

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    ds_master.ResetStatus();
    
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

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
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
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=init_holiDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
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
                        <table border="0"  cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <table width="303" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr bgcolor="#6f7f8d" height=26>
                                            <td align="center" width="80px" class="text">일자</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    <param name=Text        value="<%=startday%>">
                                                    <param name=SelectAll   value=true>
                                                    <param name=SelectAllOnClick      value=true>
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                                &nbsp;
                                                ~
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='70px' align='absmiddle' class='textbox'>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                    <param name=Text        value="<%=endday%>">
                                                    <param name=SelectAll   value=true>
                                                    <param name=SelectAllOnClick      value=true>
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="right" height="30px">        
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
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
                                <td align="left" width="845" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=845px; height:400px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <C> name='날짜'     	ID='CALN_DATE'      Width=80  align=center mask=XXXX-XX-XX Edit=none BgColor={IF(HOLIDAY_YN='Y','#FFCCFF','' )}</C>
                                            <C> name='요일'       	ID='YOIL_NM'        Width=60  align=center Edit=none BgColor={IF(HOLIDAY_YN='Y','#FFCCFF','' )} </C>
                                            <C> name='휴일 여부'   	ID='HOLIDAY_YN'		Width=80  align=center EditStyle=Lookup Data='init_holiDs:DETAIL:DETAIL_NM' BgColor={IF(HOLIDAY_YN='Y','#FFCCFF','' )}</C>
                                            <C> name='휴일 명'   	ID='HOLIDAY_NM'     Width=200 align=center Editlimit=18 BgColor={IF(HOLIDAY_YN='Y','#FFCCFF','' )}</C>
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

