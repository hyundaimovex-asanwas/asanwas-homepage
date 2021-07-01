<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 서비스 요청서 조회
 * 프로그램ID   : RV270S
 * J  S  P      : rv270s
 * 서 블 릿        : Rv270S
 * 작 성 자        : 김영민
 * 작 성 일        : 2006-08-31
 * 기능정의     :
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [ 수정일자 ][수정자] 내용
 * [2009-11-30][심동현] plz 스키장 옵션 추가
 *					  달러 단일에서 통화 컬럼 추가로
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
         var div='';
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		fnInit();
	}

        function fnInit() {
            // 지역
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //지역코드
        }


        /*
         * 메인 조회
         */
        function fnSelect() {
            if(getObjectFirst("v_fr_date").Text.trim()==""
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("출발일자(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()==""
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("출발일자(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }

            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_saup.ValueOfIndex("saup_sid", v_saup.Index)
                      + ",v_upjang_sid=" + v_upjang.ValueOfIndex("upjang_sid", v_upjang.Index)
                      + ",v_client_sid="+getObjectFirst("v_client_sid").value
                      + ",v_fr_date=" + v_fr_date.Text
                      + ",v_to_date=" + v_fr_date.Text
                      + ",v_cust_nm=" + v_cust_nm.value;
			alert(param);
            ln_TRSetting(tr1,
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270S",
                "JSP(O:MASTER=ds1)",
                param);

            tr_post(tr1);
        }

        /*
         * 엑셀
         */
        function fnExcel() {
            if(ds1.countrow==0){
                alert("데이터를 먼저 조회하시길 바랍니다.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:서비스요청서조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("서비스요청서조회","서비스요청서조회.xls", 8);
        }
        /**
         * 검색조건 대리점  팝업
         */
        function fnSelClientPopup(dirPath, servletPath) {
            v_cust_row = 0;
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;

            arrResult = fnClientPop(dirPath,'1');

            if (arrResult != null && arrResult!=undefined) {
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
<%
/****************************************************************************
            가우스 이벤트 스크립트
******************************************************************************/
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

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)" >
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=2"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=99"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //업장
</script>

<script language=JavaScript  for=v_fr_date event="OnKillFocus()" >
    if(v_fr_date.Modified)
        v_to_date.Text = v_fr_date.Text
</script>

<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메인  -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=true>
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  영업장-->
    <param name="SyncLoad"  value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		



    <table border='0' cellpadding='0' cellspacing='0' width='845'>
        <tr>
            <td width='845px'>
                <table  border='0' cellpadding='0' cellspacing='0' width='845'>
                    <tr>
                        <td align=right>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:hand" align=absmiddle onclick="fnSelect()">       <!-- 조회 -->
                            <img src="<%=dirPath%>/Sales/images/excel.gif"      style="cursor:hand" align=absmiddle onClick="fnExcel()">        <!-- 엑셀 -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px">
            <td></td>
        </tr>
        <tr height="30px">
            <td width='845px'>
                <table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
                    <tr height='30px'>
                        <td align=left class="text" width="80">지역</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^80">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td align=left class="text" width="80">영업장</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^180">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text" width="70">대리점</td>
                        <td align=left bgcolor="#FFFFFF">&nbsp;<input type="text" value="<%=c_cd%>" name='v_client_cd' id='v_client_cd' style="width:60px;" class='input01' readOnly>
                            <input type="hidden" value="<%=c_sid%>" name='v_client_sid' id='v_client_sid'>
                            <%if(v_ut.equals("")){%>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                            <%}%>
                            <input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:100px;" class='input01' readOnly>
                        </td>
                    </tr>
                    <tr height='25px'>
                        <td align=left class="text" width="80">출발일자</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
                                <param name=Text                  value="<%=firstday%>">
                                <param name=Alignment             value=1>
                                <param name=Format                value="YYYY-MM-DD">
                                <param name=InputFormat           value="YYYYMMDD">
                                <param name=Cursor                value="iBeam">
                                <param name=Border                value="false">
                                <param name=InheritColor          value="true">
                                <param name=ReadOnly              value="false">
                                <param name=SelectAll             value="true">
                                <param name=SelectAllOnClick      value="true">
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=66 align=center class="textbox">
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
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text">성명</td>
                        <td align=left bgcolor="#ffffff" colspan="3">&nbsp;<input type="text" name="v_cust_nm" size="10" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='400px' border='1'>
                                <param name="DataID"              value="ds1">
                                <param name="ColSizing"           value="true">
                                <param name="Fillarea"            value="false">
                                <param name="Editable"            value="false">
                                <param name="BorderStyle"         value="0">
                                <param name=SortView              value="Left">
                                <param name="SuppressOption"      value="1">
                                <param name="ViewSummary"         value="1">
                                <param name="Format"              value="
                                    <C> name='No'              ID='{CURROW}'     width=35     align=center                             </C>
                                    <C> name='출발일'          ID='DEPART_DATE'  width=50     align=center suppress=1                  </C>
                                    <C> name='상품'            ID='GOODS_NM'     width=80     align=left   suppress=2 SumText='합계'   </C>
                                    <C> name='예약자'          ID='CUST_NM'      width=50     align=left                               </C>
                                    <C> name='주민/여권번호'   ID='MANAGE_NO'    width=90     align=left                               </C>
                                    <C> name='반/조'           ID='TEAMS'        width=50     align=center                             </C>
                                    <C> name='총 입금액\\(옵션)' ID='PAY_AMT'    width=60     align=right  decao=0 suppress=3          </C>
                                    <C> name='업장'            ID='UPJANG_NM'    width=90     align=left                               </C>
                                    <C> name='메뉴'            ID='MENU_NM'      width=100    align=left                               </C>
                                    <C> name='단가'            ID='UNIT_AMT'  	 width=40     align=center decao=0 </C>
                                    <C> name='통화'            ID='SALE_QTY'     width=40     align=right  decao=0 </C>
                                    <C> name='환율'            ID='EXCH_AMT'     width=40     align=right  decao=0 </C>
                                    <C> name='수량'            ID='SALE_QTY'     width=40     align=right  decao=0 </C>
                                    <C> name='합계\\(￦)'        ID='TOT_USE_AMT'  width=60     align=right  decao=0 SumText=@sum          </C>
                                    <C> name='예약시\\결제여부'  ID='RSV_PAY_YN'   width=60     align=center show=false                </C>
                                    <C> name='요청사항'        ID='REMARKS'      width=200    align=left                               </C>
                                    <C> name='신청서번호'      ID='ACCEPT_NO'    width=100    align=left                               </C>
                                ">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
                <br>
                ※ 총 입금액 = 해당 관광객의 옵션요금 입금액 합<br>
                ※ 예약시 결제 여부 = 입금여부가 아닙니다.
            </td>
        </tr>
    </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

