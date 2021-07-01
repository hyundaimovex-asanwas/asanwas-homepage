<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명         : 온라인 예약자 및 예약관광객 조회
 * 프로그램ID  : RV910s
 * J  S  P   : Rv910s
 * 서 블 릿        : Rv910s
 * 작 성 자        : 심동현
 * 작 성 일        : 2006-11-15
 * 기능정의     : 온라인 예약자 및 예약관광객 조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2009-02-20][심동현] 예약자 그리드에 비밀번호 표시(콜센터 안내용)
 * [2009-04-23][심동현] 예약자 그리드에 상태 저장가능하도록 수정. 컬럼순서 변
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
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
    String firstday = m_today.format(date.getTime());           
    date.add(java.util.Calendar.DATE, +0);
    String endDay = m_today.format(date.getTime());

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
    c_cd = "99000";
    c_nm = "현대아산 온라인";    
    c_sid = "982";

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
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        cfStyleGrid(getObjectFirst("gr2"), "comn1");
//        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//       getObjectFirst("ds_goods").Reset();

		//2007-05-30 온라인예약 상태  by 심동현 
		//자차여부 (자차=Y, 버스=N)
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV032&s_item1=Y";
        codeDs1.Reset();

    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  메인조회
// Parameter    : 
%>
    function fnSelect() {
        if(getObjectFirst("v_client_cd").value==""){
            alert("대리점을 먼저 선택하시길 바랍니다.");
            return;
        }
        
        if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
            alert("검색일자(From)를 입력하시길 바랍니다.");
            getObjectFirst("v_depart_date1").Focus();
            return;
        }
        
        if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
            alert("검색일자(To)를 입력하시길 바랍니다.");
            getObjectFirst("v_depart_date2").Focus();
            return;
        }
        
        getObjectFirst("ds_detail").DeleteAll();
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_client_sid="+getObjectFirst("v_client_sid").value
                    + ",v_cond_gu="+ getObjectFirst("v_cond_gu").value
                    + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                    + ",v_depart_date2="+getObjectFirst("v_depart_date2").Text
                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                    + ",v_cust_nm="+getObjectFirst("v_cust_nm").value;
//		alert(v_param);
//		return;                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
            "JSP(O:DEFAULT=ds_main)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  Detail 조회
// Parameter    : 
%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_accept_sid="+getObjectFirst("ds_main").NameValue(row, "ACCEPT_SID");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
    
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : Master 상태 저장
%>

    function fnApply() {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
                	
        if (ds_main.IsUpdated) {
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
                "JSP(I:MAIN=ds_main,O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        } else {
            alert("변경 내역이 없습니다.");
        }
        
        
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  엑셀 파일 출력 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_main.CountRow==0){
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:온라인 예약현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("온라인예약자현황", "온라인예약현황.xls", 8);

		/*
        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:입금내역 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("입금내역 조회", "입금 미입금자 조회.xls", 32);
        */

    }
    </script>


<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//마스터 클릭하면 디테일 호출
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>

<script language=javascript for="gr2" event="OnDblClick(Row, Colid)">
//디테일 더블클릭 
//http://www.mtkumgang.com/asanway/upload/reservationUserUpload/주민번호.jpg
    if(Row==0) return;
	window.open("http://www.mtkumgang.com/asanway/upload/reservationUserUpload/"+getObjectFirst("ds_detail").NameValue(Row, "REGI_NO")+".jpg","pic","width=300,height=400");
</script>

<script language=javascript for="ds_main" event="OnLoadCompleted(row)">
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    } else {
	    fnSelectDetail(v_default_row);
	};
</script>

<script language=javascript for="ds_detail" event="OnLoadCompleted(row)">
    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=JavaScript for=v_depart_date1 event=OnKillFocus()>
// 검색일자1에서 포커스아웃하면 검색일자2도 같은 날짜로 세팅
	v_depart_date2.text = v_depart_date1.text;
</script>
<script language=JavaScript for=v_depart_date1 event=onKeyDown(kcode,scode)>
// (검색일자1 란에서)엔터키 누르면 일자2로 이동하면서 날짜세팅
	if(kcode == 13) {
		v_depart_date2.text = v_depart_date1.text;	
		v_depart_date2.focus();
	}
</script>
<script language=JavaScript for=v_depart_date2 event=onKeyDown(kcode,scode)>
// (검색일자2 란에서)엔터키 누르면 조회 호출
	if(kcode == 13) fnSelect();
</script>
<script language=JavaScript for=v_accept_no event=onKeyDown(kcode,scode)>
// (신청서번호 란에서)엔터키 누르면 조회 호출
	if(kcode == 13) fnSelect();
</script>


<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    ds_main.ResetStatus();
    ds_detail.ResetStatus();
    
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
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
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
</script>

<script language="javascript" for="tr2" event="OnFail()">
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
<%
/*=============================================================================
            DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- 기본정보 -->
<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<!-- 온라인예약상태 -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                          	<td align=left width=300></td>
                          	<td align=right><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
	                          	<img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply()">
		                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()"></td>
                          </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">대리점코드</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td width="100px" height="25px" class="text">검색일 조건</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_cond_gu class="text">
                                        <option value="RESERVE">예약일자
                                        <option value="CLOSE">마감일자
                                        <option value="DEPART">출발일자                                        
                                    </select>
									&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>                                    
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">신청서번호</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                </td>
                                <td width="100px" height="25px" class="text">예약자명</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);" onkeydown="if(event.keyCode==13) fnSelect();"></td>
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
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=430; height:440px" border="1">
                            <param name="DataID"            value="ds_main">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <FC>name='신청서번호' ID='RACCEPT_NO' Width=100 SumText=@cnt  Edit=none align=RIGHT</FC>
                                <C> name='출발일자'   ID='RSTDT'    Width=60   SumText='건' Edit=none align=CENTER</C>
                                <C> name='상품'       ID='RSCOD'   Width=50  Edit=none align=CENTER</C>
                                <C> name='상태'       ID='RSTAT'   Width=80  editstyle=lookup data='codeDs1:detail:detail_nm'</C>
                                <C> name='예약자'     ID='RNAME'   Width=60   Edit=none align=CENTER</C>
                                <C> name='연락처'     ID='RMOB'    Width=85     Edit=none align=CENTER</C>
                                <C> name='이메일'     ID='RMAIL'   Width=100   Edit=none align=Left </C>
                                <C> name='비밀번호'   ID='RPASS'   Width=60    Edit=none align=Left </C>
                                <C> name='예약일시'   ID='RDATE'   Width=100   Edit=none align=LEFT</C>
                                <C> name='도착일자'   ID='REDT'    Width=70   Edit=none align=center</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                    <td width="10">&nbsp;</td>
                    <td>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=385; height:440px" border="1">
                            <param name="DataID"            value="ds_detail">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <C> name='성명' ID='CUST_NM'    Width=60  Edit=none align=Center sumtext=@cnt</C>
                                <C> name='주민번호' ID='REGI_NO'  Width=70  Edit=none align=left sumtext=명</C>
                                <C> name='판매가' ID='USE_AMT'    Width=60  Edit=none align=right DECAO=0 sumtext=@sum</C>
                                <C> name='입금액' ID='PAY_AMT'    Width=60  Edit=none align=right DECAO=0 sumtext=@sum</C>

                                <C> name='직장' ID='COMPANY_NM' Width=80  Edit=none align=LEFT</C>
                                <C> name='직위' ID='POSITIONS'  Width=50  Edit=none align=LEFT</C>
                                <C> name='주소1' ID='ADDRESS1'   Width=70  Edit=none align=LEFT</C>
                                <C> name='주소2' ID='ADDRESS2'   Width=50  Edit=none align=LEFT</C>
                                <C> name='상태' ID='STATUS_CD'  Width=40  Edit=none align=Center</C>
                                <C> name='핸드폰' ID='MOBILE_NO'  Width=40  Edit=none align=LEFT</C>
                                <C> name='예약\\번호' ID='RSV_SID'    Width=40  Edit=none align=Center</C>
                                <C> name='고객\\번호' ID='CUST_SID'   Width=40  Edit=none align=Center</C>
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

