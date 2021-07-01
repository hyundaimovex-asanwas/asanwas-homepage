<!--
    ************************************************************************************
    * @Source         : vlua073.jsp                                                    *
    * @Description    : 평가대상자등록및수정 PAGE                                       *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/01  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>평가대상자등록및수정(vlua073)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String T_MODE     = request.getParameter("T_MODE");         //신규/수정구분
    String GUBUN      = request.getParameter("GUBUN");          //업무구분
    String EVL_YY     = request.getParameter("EVL_YY");         //해당년도
    String EVL_GBN    = request.getParameter("EVL_GBN");        //구분(성과/역량)
    String EVL_FRQ    = request.getParameter("EVL_FRQ");        //회차
    String ENO_NO     = request.getParameter("ENO_NO");         //사번
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';
        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var GUBUN      = "<%=GUBUN%>";
            var EVL_YY     = "<%=EVL_YY%>";
            var EVL_GBN    = "<%=EVL_GBN%>";
            var EVL_FRQ    = "<%=EVL_FRQ%>";
            var ENO_NO     = "<%=ENO_NO%>";

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua073.cmd.VLUA073CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
            dsT_EV_EVLIST_HD.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua073.cmd.VLUA073CMD&S_MODE=SAV";
            trT_EV_EVLIST_HD.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_EVLIST_HD.CountColumn == 0) {
                dsT_EV_EVLIST_HD.setDataHeader("GUBUN:STRING, EVL_YY:STRING:KEYVALUETYPE,  EVL_GBN:STRING:KEYVALUETYPE, EVL_FRQ:INT:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE,  ENO_NM:STRING,  COMM_CD:STRING, GROUP_CD:STRING, GROUP_NM:STRING, HIRG_YMD:STRING, DPA_YMD:STRING, OCC_CD:STRING, OCC_NM:STRING, HEAD_CD:STRING, HEAD_NM:STRING, DPT_CD:STRING,  DPT_NM:STRING,  JOB_CD:STRING,  JOB_NM:STRING,  HOB_CD:STRING,  HOB_NM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_EVLIST_HD.AddRow();
            dsT_EV_EVLIST_HD.RowPosition = 1;

            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "GUBUN")   = "<%=GUBUN%>";
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "EVL_YY")  = "<%=EVL_YY%>";
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "EVL_GBN") = "<%=EVL_GBN%>";
            dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "EVL_FRQ") = "<%=EVL_FRQ%>";

            if ("<%=GUBUN%>" == "01") {
                dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "COMM_CD") = "EG";
            }
            else if ("<%=GUBUN%>" == "02") {
                dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition, "COMM_CD") = "4";
            }

            form1.txtENO_NO.focus();

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (dsT_EV_EVLIST_HD.NameValue(1, "ENO_NO").trim() == '') {
                alert("사번은 필수 입력사항입니다.");
                form1.txtENO_NO.focus();
                return false;
            }

            if (dsT_EV_EVLIST_HD.NameValue(1, "OCC_CD").trim() == '') {
                alert("근로구분은 필수 입력사항입니다.");
                form1.txtOCC_CD.focus();
                return false;
            }

            if (dsT_EV_EVLIST_HD.NameValue(1, "HEAD_CD").trim() == '') {
                alert("본부는 필수 입력사항입니다.");
                form1.cmbHEAD_CD.focus();
                return false;
            }

            if (dsT_EV_EVLIST_HD.NameValue(1, "DPT_CD").trim() == '') {
                alert("소속는 필수 입력사항입니다.");
                form1.txtDPT_CD.focus();
                return false;
            }

            if (dsT_EV_EVLIST_HD.NameValue(1, "JOB_CD").trim() == '') {
                alert("직위는 필수 입력사항입니다.");
                form1.txtJOB_CD.focus();
                return false;
            }

            if (dsT_EV_EVLIST_HD.NameValue(1, "DPA_YMD").trim() != '') {
                if (dsT_EV_EVLIST_HD.NameValue(1, "HOB_CD").trim() == '') {
                    alert("호봉은 필수 입력사항입니다.");
                    form1.txtHOB_CD.focus();
                    return false;
                }
            }

            if (!dsT_EV_EVLIST_HD.IsUpdated) {

                // DataSet의 변경 여부 확인
                if (!dsT_EV_EVLIST_HD.IsUpdated ) {
                    fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                    return false;
                }

            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            Colid = window.dialogArguments;

            if ("<%=GUBUN%>" == "01") {
                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD").add(oOption);

                }

            }
            else if ("<%=GUBUN%>" == "02") {
                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD").add(oOption);
                }

            }

            //본부코드
            for( var i = 1; i <= dsCOMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD").add(oOption);

            }



            // 신규/수정모드가 'I'(입력)인 경우
            if ("<%=T_MODE%>" == 'I') {

                form1.txtGUBUN.value = "<%=GUBUN%>";

                fnc_AddNew();
            }
            // 신규/수정모드가 'U'(수정)인 경우
            else if ("<%=T_MODE%>" == 'U') {

                form1.txtENO_NO.disabled = true;
                document.getElementById("Image20").disabled = true;

                // 해당 평가대상자설정 데이터 조회
                fnc_SearchList();
            }

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_EVLIST_HD.IsUpdated && "<%=T_MODE%>" == "U")
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        function fnc_emplpop() {
            var obj = new String();

            obj.shr_kind = "SHR_01";

            obj.eno_nm = '';

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            dsT_EV_EVLIST_HD.NameValue(1, 'ENO_NO')   = obj.eno_no   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'ENO_NM')   = obj.eno_nm   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'HIRG_YMD') = obj.hirg_ymd ;
            dsT_EV_EVLIST_HD.NameValue(1, 'DPA_YMD')  = obj.dpa_ymd  ;
            dsT_EV_EVLIST_HD.NameValue(1, 'OCC_CD')   = obj.occ_cd   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'OCC_NM')   = obj.occ_nm   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'HEAD_CD')  = obj.head_cd  ;
            dsT_EV_EVLIST_HD.NameValue(1, 'HEAD_NM')  = obj.head_nm  ;
            dsT_EV_EVLIST_HD.NameValue(1, 'DPT_CD')   = obj.dpt_cd   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'DPT_NM')   = obj.dpt_nm   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'JOB_CD')   = obj.job_cd   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'JOB_NM')   = obj.job_nm   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'HOB_CD')   = obj.hob_cd   ;
            dsT_EV_EVLIST_HD.NameValue(1, 'HOB_NM')   = obj.hob_nm   ;

            dsT_EV_EVLIST_HD.RowPosition = 1;

            if (obj.dpa_ymd == '') {
                document.getElementById("txtDPA_YMD").disabled = true;
                document.getElementById("image19").disabled = true;
            }
            else {
                document.getElementById("txtDPA_YMD").disabled = false;
                document.getElementById("image19").disabled = false;
            }
        }

        function fnc_FldChange() {

            if (document.getElementById("txtENO_NO").value == '') {
                document.getElementById("txtENO_NM").value = '';
            }
            else if (document.getElementById("txtDPT_CD").value == '') {
                document.getElementById("txtDPT_NM").value = '';
            }
            else if (document.getElementById("txtJOB_CD").value == '') {
                document.getElementById("txtJOB_NM").value = '';
            }
            else if (document.getElementById("txtHOB_CD").value == '') {
                document.getElementById("txtHOB_NM").value = '';
            }

        }

        /*****************************************************
         * 날짜 형식 유효성 체크                             *
         ****************************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;

            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
                return;
            }

            if (obj.value.length != 10) {
                alert('유효한 날짜가 아닙니다. YYYY-MM-DD 형식으로 입력하여 주십시오.');
                obj.focus();
                return;
            }
        }

        function fnc_UsrGetEnoNm() {
            var obj = new String();

            obj = fnc_GetEnoNm('txtENO_NO');

            // 재직자인 경우만 보여짐
            if (obj.eno_no != "" && obj.ret_ymd == "") {
                dsT_EV_EVLIST_HD.NameValue(1, 'ENO_NO')   = obj.eno_no   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'ENO_NM')   = obj.eno_nm   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'HIRG_YMD') = obj.hirg_ymd ;
                dsT_EV_EVLIST_HD.NameValue(1, 'DPA_YMD')  = obj.dpa_ymd  ;
                dsT_EV_EVLIST_HD.NameValue(1, 'OCC_CD')   = obj.occ_cd   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'OCC_NM')   = obj.occ_nm   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'HEAD_CD')  = obj.head_cd  ;
                dsT_EV_EVLIST_HD.NameValue(1, 'HEAD_NM')  = obj.head_nm  ;
                dsT_EV_EVLIST_HD.NameValue(1, 'DPT_CD')   = obj.dpt_cd   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'DPT_NM')   = obj.dpt_nm   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'JOB_CD')   = obj.job_cd   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'JOB_NM')   = obj.job_nm   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'HOB_CD')   = obj.hob_cd   ;
                dsT_EV_EVLIST_HD.NameValue(1, 'HOB_NM')   = obj.hob_nm   ;
            }
        }


    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_HD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_EVLIST_HD)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 본부코드 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_HD.CountRow);

            if (document.getElementById("txtDPA_YMD").value == '') {
                document.getElementById("txtDPA_YMD").disabled = true;
                document.getElementById("image19").disabled = true;
            }
            else {
                document.getElementById("txtDPA_YMD").disabled = false;
                document.getElementById("image19").disabled = false;
            }
        }



    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[사번/성명] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("사번/성명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_EVLIST_HD event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        <% T_MODE = "U"; %>
        form1.txtENO_NO.disabled = true;
        document.getElementById("Image20").disabled = true;

        opener.fnc_SearchList();

        var Row = opener.dsT_EV_EVLIST_HD.NameValueRow("ENO_NO", dsT_EV_EVLIST_HD.NameValue(1, "ENO_NO"));
        opener.dsT_EV_EVLIST_HD.RowPosition = Row;

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_EVLIST_HD event="OnFail()">

        cfErrorMsg(this);

    </script>




<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가대상자등록및수정</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="550">
        <table width="550" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="70 "></col>
                            <col width="190"></col>
                            <col width="70 "></col>
                            <col width="190"></col>
                        </colgroup>
                        <tr>
                            <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                            <td align="center" height="25" class="creamBold">평가구분</td>
                            <td class="padding2423">
                                <input id=txtEVL_YY  name=txtEVL_YY size="4" class="input_ReadOnly" readonly> 년&nbsp;
                                <select id=cmbEVL_GBN name=cmbEVL_GBN disabled="true">
                                    <option value="1">역량</option>
                                    <option value="2">성과</option>
                                </select>&nbsp;
                                <input id=txtEVL_FRQ name=txtEVL_FRQ size="2" class="input_ReadOnly" readonly> 회차
                            </td>
                            <td align="center" height="25" class="creamBold">사번</td>
                            <td class="padding2423">
                                <input id=txtENO_NO name=txtENO_NO size="8" onChange="fnc_UsrGetEnoNm();">
                                <input id=txtENO_NM name=txtENO_NM size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplpop()"></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="creamBold">그룹입사일</td>
                            <td class="padding2423"><input id=txtHIRG_YMD name=txtHIRG_YMD style="width:100%" class="input_ReadOnly" readonly>
                            </td>
                            <td align="center" class="creamBold">소속발령일</td>
                            <td class="padding2423"><input id=txtDPA_YMD name=txtDPA_YMD style="width:81%" style="ime-mode:disabled" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image19','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="Image19" name="Image19" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDPA_YMD','','348','100');"></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">근로구분</td>
                            <td class="padding2423">
                                <select id=cmbOCC_CD name=cmbOCC_CD  style="width:100%">
                                    <option value=""></option>
                                    <option value="A">사무직</option>
                                    <option value="M">택배직</option>
                                </select>
                            </td>
                            <td align="center" height="25" class="creamBold">평가그룹</td>
                            <td class="padding2423">
                                <select id=cmbGROUP_CD name=cmbGROUP_CD style="width:100%">
                                    <option value=" "></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">본부</td>
                            <td class="padding2423">
                                <select id=cmbHEAD_CD name=cmbHEAD_CD  style="width:100%">
                                    <option value=""></option>
                                </select>
                            </td>
                            <td align="center" class="creamBold">소속</td>
                            <td class="padding2423">
                                <input id=txtDPT_CD name=txtDPT_CD size="8" onChange="fnc_FldChange()">
                                <input id=txtDPT_NM name=txtDPT_NM size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image21" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','소속','DEPT')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">직위</td>
                            <td class="padding2423">
                                <input id=txtJOB_CD name=txtJOB_CD size="8" onChange="fnc_FldChange()">
                                <input id=txtJOB_NM name=txtJOB_NM size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image22" name="Image22" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD','txtJOB_NM','직위','A2');"></a>
                            </td>
                            <td align="center" height="25" class="creamBold">호봉</td>
                            <td class="padding2423" colspan="3">
                                <input id=txtHOB_CD name=txtHOB_CD size="8" onChange="fnc_FldChange()">
                                <input id=txtHOB_NM name=txtHOB_NM size="14" class="input_ReadOnly" readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image23" name="Image23" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHOB_CD','txtHOB_NM','호봉','A3');"></a>
                            </td>
                            <!-- Hidden Filed -->
                            <input type=hidden id=txtEVL_GBN   name=txtEVL_GBN>
                            <input type=hidden id=txtEVLENO_NO name=txtEVLENO_NO>
                            <input type=hidden id=txtUPDN_GBN  name=txtUPDN_GBN>
                            <input type=hidden name=txtFLAG>
                        </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><br><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_EV_EVLIST_HD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_EVLIST_HD">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN      Param=value </C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY     Param=value </C>
        <C>Col=EVL_GBN      Ctrl=cmbEVL_GBN    Param=value </C>
        <C>Col=EVL_FRQ      Ctrl=txtEVL_FRQ    Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO     Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM     Param=value </C>
        <C>Col=HIRG_YMD     Ctrl=txtHIRG_YMD   Param=value </C>
        <C>Col=DPA_YMD      Ctrl=txtDPA_YMD    Param=value </C>
        <C>Col=OCC_CD       Ctrl=cmbOCC_CD     Param=value </C>
        <C>Col=GROUP_CD     Ctrl=cmbGROUP_CD   Param=value </C>
        <C>Col=HEAD_CD      Ctrl=cmbHEAD_CD    Param=value </C>
        <C>Col=DPT_CD       Ctrl=txtDPT_CD     Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM     Param=value </C>
        <C>Col=JOB_CD       Ctrl=txtJOB_CD     Param=value </C>
        <C>Col=JOB_NM       Ctrl=txtJOB_NM     Param=value </C>
        <C>Col=HOB_CD       Ctrl=txtHOB_CD     Param=value </C>
        <C>Col=HOB_NM       Ctrl=txtHOB_NM     Param=value </C>
    '>
</object>