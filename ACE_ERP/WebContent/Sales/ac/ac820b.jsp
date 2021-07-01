<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 관광예약현황
 * 프로그램ID   : RV200S
 * J  S  P      : rv200s
 * 서 블 릿        : Rv200S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-07-14
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2011-02-21][심동현] 조회조건에 [가맹구분] 추가
 *						조회시에만 사용 가능. 생성시에는 강제 선택 스크립트 처
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

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

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());
    date.add(Calendar.DATE, +1);
    String lastday = m_today.format(date.getTime());
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
    <script language="javascript">
        var v_default_row = 1;
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

            cfStyleGrid(getObjectFirst("gr_default"), "comn");
            cfStyleGrid(getObjectFirst("gr_master"), "comn");
            fnInit(); 
        } 
        
        /*
         * 초기작업
         * Header 설정 
         * 지역
         */
        function fnInit() {
            fnDateSelect()
        }
        
        function fnDateSelect(){
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_req_date="+ getObjectFirst("v_req_date").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:DATE=ds_date)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSelect(){
            if(getObjectFirst("v_req_date").Text.trim()=="" 
                || getObjectFirst("v_req_date").Text.trim().length!=8){
                alert("청구일자<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_req_date").Focus();
                return;
            }
            
            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_req_date="+ getObjectFirst("v_req_date").Text
   			          	+ ",sJob_seq=" + sJob_seq.value;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:DEFAULT=ds_default,O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }

        function fnApply() {
			if(sJob_seq.value==""){
				alert("파일 생성을 위해 가맹구분을 꼭 선택해야 합니다.");
				return;
			}
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_req_date="+getObjectFirst("v_req_date").Text
   			          	+ ",sJob_seq=" + sJob_seq.value;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        }
        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr_master").SetExcelTitle(0, "");
            getObjectFirst("gr_master").SetExcelTitle(1, "value:신용카드매입확정; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_master").GridToExcel("신용카드매입확정 (집계)", "신용카드매입확정.xls", 32);

            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:신용카드매입확정; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("신용카드매입확정", "신용카드매입확정.xls", 32);
        }
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr_default.ReDraw = "True";
</script>

<script language=javascript for=v_req_date event="OnKillFocus()">
    if(v_req_date.Modified)
        fnDateSelect();
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

	
	var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_CARD%>"+ds_result.NameValue(row, "FILE_NAME")
                + "&realName="+ds_result.NameValue(row, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
</script>


<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_date classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/n_create.gif" style="cursor:pointer" align=absmiddle onClick="fnApply()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="100">청구일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;
                            <object id=v_req_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
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
                                                                                                         
                        </td>                                                                                           
                        <td class="text"  width="100">승인일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=Enable      value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object> ~ 
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=Enable      value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                                                                                                         
                        </td>
					 	<td align=center class="text" width="70">가맹구분</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<select name="sJob_seq">
								<option value=""> 전 체 </option>
								<option value="1"> 관 광 </option>
								<option value="2"> 옵 션 </option>
							</select>
						</td>	
                    </tr>
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=495>
                            
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='495px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='카드사'    ID='CARD_COMPANY_NM'      width=80 align=center Edit=None SumText='합계'</C>
                                     <G> name='승인내역'
                                     <C> name='건수'      ID='Y_CNT'        width=95 align=right Edit=None SumText=@sum</C>
                                     <C> name='금액'      ID='Y_AMT'          width=100 align=right Edit=None dec=0 SumText=@sum</C>
                                     </G>
                                     <G> name='취소내역'
                                     <C> name='건수'      ID='N_CNT'        width=95 align=right Edit=None SumText=@sum</C>
                                     <C> name='금액'      ID='N_AMT'          width=100 align=right Edit=None dec=0 SumText=@sum</C>
                                     </G>
                             ">                             
                            </object>   
                            
                        </td>
                        <td width=10>&nbsp;</td>
                        <td width=340 valign=top>
                            
                            <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='340px' height='420px' border='1'>
                                <param name="DataID"            value="ds_master">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="Format"            value="
                                     <C> name='구분'          ID='NAME'       width=120 align=center Edit=None</C>
                                     <C> name='건수'          ID='TOT_CNT'        width=100 align=right Edit=None</C>
                                     <C> name='금액'          ID='TOT_AMT'        width=100 align=right Edit=None dec=0</C>
                             ">
                            </object>
                            
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <object id=Bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
        <param name="DataId" value="ds_date">
        <param name=BindInfo    value="
            <C>Col=FR_DATE     Ctrl=v_fr_date          Param=Text</C>
            <C>Col=TO_DATE      Ctrl=v_to_date          Param=Text</C>
        ">
    </object>


<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

