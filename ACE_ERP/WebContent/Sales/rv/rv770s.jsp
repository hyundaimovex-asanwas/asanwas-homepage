<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명           : 신용카드매입
 * 프로그램ID   : RV770S
 * J  S  P     : rv770
 * 서 블 릿            : Rv770S
 * 작 성 자            : 김영민
 * 작 성 일            : 2006-08-1
 * 기능정의           : 대관명단 출력
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2007-12-03][심동현] 금강산/개성분리. 조회/출력/
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
    
    String startDay = m_today.format(date.getTime());
    
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
        var v_depart_date = "";
        var v_gubn = "";
        var v_gubn_name = "";
        
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출
            fnInit(); 
        }
        
        function fnInit(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            
            ds_gubn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV028";
            ds_gubn.Reset();

			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드	        
        }
        
        function fnSelect() {
            if(getObjectFirst("v_depart_date").Text.trim()=="" || getObjectFirst("v_depart_date").Text.trim().length!=8){
                alert("출발일자  <%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_depart_date").Focus();
                return;
            }
            
            v_depart_date = getObjectFirst("v_depart_date").Text;
            v_gubn = getObjectFirst("v_gubn").ValueOfIndex("detail", getObjectFirst("v_gubn").Index);
            v_gubn_name = getObjectFirst("v_gubn").Text;
            
            if(v_gubn=="4"){
                getObjectFirst("btn_apply").style.display = "none";
                getObjectFirst("btn_excel").style.display = "inline";
            } else {
                getObjectFirst("btn_apply").style.display = "inline";
                getObjectFirst("btn_excel").style.display = "inline";
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)            
                        + ",v_depart_date="+v_depart_date
                        + ",v_gubn="+v_gubn;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv770S",
                "JSP(O:DEFAULT=ds1)",
                v_param);
            tr_post(tr1);
        }
        
        function fnApply() {
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
	                    + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)                        
                        + ",v_depart_date="+v_depart_date
                        + ",v_gubn="+v_gubn;
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv770S",
                "JSP(I:DEFAULT=ds1, O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        }
        
        function fnExcel(){
            if(ds1.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:대관명단출력 출발일자 ("+v_depart_date +") 용도 ("+ v_gubn_name +"); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("대관명단출력", "대관명단출력.xls", 8);        
        }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds1" event="OnLoadCompleted(row)">
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

<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    if(row==0) return;
    
    var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_POLICE%>"+ds_result.NameValue(row, "FILE_NAME")
                + "&realName="+ds_result.NameValue(row, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
</script>

<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gubn classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
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
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align=right>
                                    <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/n_create.gif" style="cursor:hand;display:none" id=btn_apply onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand;display:none" id=btn_excel onClick="fnExcel()">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr><td height="10"></td></tr>
                <tr>
                    <td width=845>
                        <table width=845 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr height="25px">
                                <td width="100px" class="text">출발일자</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=startDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td class="text" width="100">지역</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_saup>
                                        <param name=ListExprFormat  value="saup_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" class="text">출력구분</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_gubn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=130 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_gubn>
                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                        <param name=ListExprFormat  value="detail_nm^0^130">
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
                <tr>
                    <td>
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:420px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="True">
                        <param name="SuppressOption"    value="1">
                        <Param Name="UsingOneClick"     value="1">
                        <Param Name="AllShowEdit"       value="True">
                        <param name="ViewSummary"       value="1">
                        <param name="Format"            value=" 
                            <C> name='번호'    ID='{CURROW}'    Width=40   Edit=none align=Center</C>
                            <C> name='구분'    ID='DAYS'    Width=30   Edit=none align=Center</C>
                            <C> name='바코드구분'          ID='H1'     Width=70   Edit=none align=Center</C>
                            <C> name='증명서번호'    ID='UNITY_NO'     Width=100   Edit=none align=Left SumText='총건수'</C>
                            <C> name='주민등록번호'     ID='MANAGE_NO'  Width=120   Edit=none align=Center SumText=@count </C>
                            <C> name='여권번호'         ID='PASS_NO'  Width=100   Edit=none align=Center</C>
                            <C> name='성명'         ID='CUST_NM' Width=70   Edit=none align=Left</C>
                            <C> name='직업'         ID='COMPANY_NM'       Width=120 Edit=none align=Left</C>
                            <C> name='직장명'         ID='COMPANY_NM'  Width=120    Edit=none align=Left/C>
                            <C> name='직위'         ID='POSITIONS'     Width=80   Edit=none align=Left</C>
                            <C> name='국적'          ID='COUNTRY_CD'        Width=40  Edit=none align=Center</C>
                            <C> name='주소'         ID='ADDRESS' Width=200   Edit=none align=Left</C>
                            <C> name='전화번호'  ID='TEL_NO'  Width=100   Edit=none Dec=0 align=Left</C>
                            <C> name='관광목적'  ID='OBJECT'  Width=60   Edit=none Dec=0 align=Center</C>
                            <C> name='출발지→도착지'  ID='START_END'  Width=120   Edit=none Dec=0 align=Center</C>
                            <C> name='출입경경로'  ID='GOODS_NM'  Width=80   Edit=none Dec=0 align=Center</C>
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

