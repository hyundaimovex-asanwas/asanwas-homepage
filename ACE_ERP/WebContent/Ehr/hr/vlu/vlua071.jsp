<!--
    ************************************************************************************
    * @Source         : vlua071.jsp                                                    *
    * @Description    : 개인별 역량평가대상자 설정 PAGE                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/22  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>개인별 역량평가대상자 설정(vlua071)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //업무구분
    String EVL_YY     = request.getParameter("EVL_YY");         //해당년도
    String EVL_GBN    = request.getParameter("EVL_GBN");        //구분(성과/역량)
    String EVL_FRQ    = request.getParameter("EVL_FRQ");        //회차
    String ENO_NO     = request.getParameter("ENO_NO");         //사번
    String DOWN_RATE  = request.getParameter("DOWN_RATE");      //비율
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var GUBUN      = "<%=GUBUN%>";
            var EVL_YY     = "<%=EVL_YY%>";
            var EVL_GBN    = "<%=EVL_GBN%>";
            var EVL_FRQ    = "<%=EVL_FRQ%>";
            var ENO_NO     = "<%=ENO_NO%>";
            var DEGREE_GBN = form1.txtDEGREE_GBN.value.trim();

            form1.txtFLAG.value = "1"; // 조회FLAG

            trT_EV_EVLIST_DT.KeyValue = "tr01(O:SHR=dsT_EV_EVLIST_DT,O:SHR2=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_DT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua071.cmd.VLUA071CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DEGREE_GBN="+DEGREE_GBN;
            trT_EV_EVLIST_DT.post();

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
            var CountRow = 0;

            // 순번을 DATASET Row 순서대로 매김
            for (CountRow = 1; CountRow <= dsT_EV_EVLIST_DT.CountRow; CountRow++) {
                dsT_EV_EVLIST_DT.NameValue(CountRow, "SEQ_NO") = CountRow;
            }

            if (!fnc_SaveItemCheck()) {
                return;
            }

            form1.txtFLAG.value = "2"; // 저장FLAG

            trT_EV_EVLIST_DT.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_DT,I:SAV2=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_DT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua071.cmd.VLUA071CMD&S_MODE=SAV";
            trT_EV_EVLIST_DT.post();

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

           //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
            if (dsT_EV_EVLIST_DT.CountColumn == 0) {
                dsT_EV_EVLIST_DT.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_GBN:STRING, EVL_FRQ:INT, ENO_NO:STRING, DEGREE_GBN:STRING, EVLENO_NO:STRING:NOTNULL, SEQ_NO:INT, APPLY_RATE:DECIMAL, DPT_NM:STRING, JOB_NM:STRING, EVLENO_NM:STRING:NOTNULL, HEAD_NM:STRING");
            }

            // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
            dsT_EV_EVLIST_DT.InsertRow(dsT_EV_EVLIST_DT.RowPosition+1);
            form1.grdT_EV_EVLIST_DT.SetColumn(form1.grdT_EV_EVLIST_DT.GetColumnID(3));
            form1.grdT_EV_EVLIST_DT.Focus();

            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "GUBUN")      = form1.txtGUBUN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_YY")     = form1.txtEVL_YY.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_GBN")    = form1.cmbEVL_GBN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "EVL_FRQ")    = form1.cmbEVL_FRQ.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "ENO_NO")     = form1.txtENO_NO.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "DEGREE_GBN") = form1.txtDEGREE_GBN.value.trim();
            dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition, "APPLY_RATE") = form1.txtDOWN_RATE.value.trim();

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_EVLIST_DT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition,"EVLENO_NO") + "][" + dsT_EV_EVLIST_DT.NameValue(dsT_EV_EVLIST_DT.RowPosition,"EVLENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_EVLIST_DT.DeleteRow(dsT_EV_EVLIST_DT.RowPosition);

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_EVLIST_DT.SetColumn(form1.grdT_EV_EVLIST_DT.GetColumnID(0));
            form1.grdT_EV_EVLIST_DT.Focus();

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

            if (dsT_EV_EVLIST_HD.NameValue(1, "GROUP_CD").trim() == '') {
                alert("평가그룹은 필수 입력사항입니다.");
                form1.cmbGROUP_CD.focus();
                return false;
            }

            if (!dsT_EV_EVLIST_DT.IsUpdated) {

                // DataSet의 변경 여부 확인
                if (!dsT_EV_EVLIST_HD.IsUpdated ) {
                    fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                    return false;
                }

            }


            if ( dsT_EV_EVLIST_DT.isUpdated ) {
                for( i = 1; i <= dsT_EV_EVLIST_DT.CountRow; i++ ) {
                    if( dsT_EV_EVLIST_DT.RowStatus(i) == 1 ||
                        dsT_EV_EVLIST_DT.RowStatus(i) == 3 ) {
                        // 사번
                        if( dsT_EV_EVLIST_DT.NameValue(i, "EVLENO_NO") == '' ) {
                            alert("사번은 필수 입력사항입니다.");
                            dsT_EV_EVLIST_DT.RowPosition = i;
                            form1.grdT_EV_EVLIST_DT.SetColumn("EVLENO_NO");
                            form1.grdT_EV_EVLIST_DT.focus();
                            return false;
                        }

                        // 반영비율
                        if( dsT_EV_EVLIST_DT.NameValue(i, "APPLY_RATE") <= 0 ) {
                            alert("반영비율은 필수 입력사항입니다.");
                            dsT_EV_EVLIST_DT.RowPosition = i;
                            form1.grdT_EV_EVLIST_DT.SetColumn("APPLY_RATE");
                            form1.grdT_EV_EVLIST_DT.focus();
                            return false;
                        }
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var DEGREE_GBN = null;
            form1.txtDOWN_RATE.value   = "<%=DOWN_RATE%>";

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_EVLIST_DT,15,"true","right");

            Colid = window.dialogArguments;

            if (Colid == 'EVLENO_NO11') {
                DEGREE_GBN = '1';
            }
            else if (Colid == 'EVLENO_NO12') {
                DEGREE_GBN = '2';
            }
            else if (Colid == 'EVLENO_NO13') {
                DEGREE_GBN = '3';
            }
            else {
                DEGREE_GBN = '1';
            }

            form1.txtDEGREE_GBN.value = DEGREE_GBN;
            txtEVL_FRQ.innerText      = DEGREE_GBN + " 차 평가자 List";

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

            form1.txtGUBUN.value = "<%=GUBUN%>";

            // 그리드에 개인별역량평가대상자설정 데이터 조회
            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_EVLIST_DT.IsUpdated || dsT_EV_EVLIST_HD.IsUpdated)
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


    </script>

    </head>



    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_DT) |
    | 3. 사용되는 Table List(T_EV_EVLIST_DT)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

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
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_EVLIST_DT) |
    | 3. 사용되는 Table List(T_EV_EVLIST_DT)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_DT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_EVLIST_DT,I:SAV2=dsT_EV_EVLIST_HD)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script  for=grdT_EV_EVLIST_DT event=OnClick(row,colid)>

        // 상태가 'insert'인 경우
        if( dsT_EV_EVLIST_DT.RowStatus(row) == 1 ) {

            // 입력시 사번에 관한 키 입력 가능
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NO', 'Edit') = 'true';
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NM', 'Edit') = 'true';

        } else {

            // 사번에 관한 키 입력 불가
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NO', 'Edit') = 'None';
            form1.grdT_EV_EVLIST_DT.ColumnProp('EVLENO_NM', 'Edit') = 'None';
        }

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //alert("검색하신 조건의 자료가 없습니다..");

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

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
    <script for=trT_EV_EVLIST_DT event="OnSuccess()">

        if (form1.txtFLAG.value == "1") {
            dsT_EV_EVLIST_HD.RowPosition = 1;
        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");


            if (dsT_EV_EVLIST_DT.CountRow != 0) {
                window.returnValue = dsT_EV_EVLIST_HD.NameString(1, "GROUP_CD")+';'+dsT_EV_EVLIST_DT.NameString(1, "EVLENO_NM");
            }
            else {
                window.returnValue = dsT_EV_EVLIST_HD.NameString(1, "GROUP_CD")+';';
            }
        }

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_EVLIST_DT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-- 그리드의 팝업필드 클릭시 -->
    <script language="javascript" for=grdT_EV_EVLIST_DT event=OnPopup(Row,Colid,data)>

        // 사번, 성명 조회
        if ( Colid == 'EVLENO_NO' ||
             Colid == 'EVLENO_NM' ) {

            var obj = new String();

            obj.shr_kind = "SHR_01";

            obj.eno_nm = '';

            window.showModalDialog("/common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (form1.txtENO_NO.value == obj.eno_no) {
                alert("입력하고자 하는 사번/이름이 피평가자와 동일합니다.");
                return;
            }


            for(var i = 1; i <= dsT_EV_EVLIST_DT.CountRow; i++) {

                if (obj.eno_no != '' && dsT_EV_EVLIST_DT.NameValue(i, 'EVLENO_NO') == obj.eno_no) {
                    alert('이미 지정한 평가자사번입니다.');
                    return;
                }
            }

            dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO') = obj.eno_no;
            dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NM') = obj.eno_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'DPT_NM')    = obj.dpt_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'JOB_NM')    = obj.job_nm;
            dsT_EV_EVLIST_DT.NameValue(Row,'HEAD_NM')   = obj.head_nm;

        }

    </script>

    <!-- 사번 또는  성명을 지웠을 때 본부, 소속, 직위도 함께 지워지도록 함 -->
    <script language="javascript"  for=grdT_EV_EVLIST_DT event=OnExit(Row,Colid,olddata)>

        if (Colid == 'EVLENO_NO' || Colid == 'EVLENO_NM') {
            if (dsT_EV_EVLIST_DT.NameValue(Row, Colid) == "") {
                dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NO') = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'EVLENO_NM') = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'DPT_NM')    = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'JOB_NM')    = "";
                dsT_EV_EVLIST_DT.NameValue(Row,'HEAD_NM')   = "";
            }

        }

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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별 역량평가대상자 설정</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>피평가자 정보 </strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                <td align="right" class="searchState">해당년도</td>
                                <td class="padding2423"><input id=txtEVL_YY name=txtEVL_YY size="4" class="input_ReadOnly" readOnly></td>
                                <td align="right" class="searchState">구분</td>
                                <td class="padding2423" class="input_ReadOnly" readOnly>
                                    <select id=cmbEVL_GBN name=cmbEVL_GBN disabled="true">
                                        <option value="1">역량</option>
                                        <option value="2">성과</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423" class="input_ReadOnly" readOnly>
                                    <select id=cmbEVL_FRQ name=cmbEVL_FRQ disabled="true">
                                        <option value="1">1회</option>
                                        <option value="2">2회</option>
                                        <option value="3">3회</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">평가그룹</td>
                                <td class="padding2423">
                                    <select id=cmbGROUP_CD name=cmbGROUP_CD >
                                        <option vlaue=""></option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input id=txtDPT_NM name=txtDPT_NM   size="16" class="input_ReadOnly" readOnly></td>
                                <td align="right" class="searchState">성명</td>
                                <td class="padding2423"><input id=txtENO_NM name=txtENO_NM size="10" class="input_ReadOnly" readOnly></td>
                                <!-- Hidden Filed -->
                                <input type=hidden id=txtENO_NO><input type=hidden id=txtDEGREE_GBN><input type=hidden name=txtDOWN_RATE>
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

<!-- 버튼 테이블2 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong><span id="txtEVL_FRQ">XX차 평가자 List</span></strong></td>
        <td align="right" valign="bottom">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="Image11" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="Image12" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블2 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_EVLIST_DT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_DT">
                            <param name="EdiTABLE"                value="true">
                            <param name="IndWidth"                value="0">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='HEAD_NM'        width=130    name='본부'      align=left   Edit='None' </C>
                                <C> id='DPT_NM'         width=130    name='소속'      align=left   Edit='None' </C>
                                <C> id='JOB_NM'         width=130    name='직위'      align=center Edit='None' </C>
                                <C> id='EVLENO_NO'      width=130    name='사번'      align=center Edit='Numeric' EditStyle=Popup EditLimit=10 </C>
                                <C> id='EVLENO_NM'      width=130    name='성명'      align=center                EditStyle=Popup EditLimit=20 </C>
                                <C> id='APPLY_RATE'     width=110    name='반영비율'  EditLimit=6  </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
        <C>Col=EVL_FRQ      Ctrl=cmbEVL_FRQ    Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM     Param=value </C>
        <C>Col=GROUP_CD     Ctrl=cmbGROUP_CD   Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM     Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO     Param=value </C>
    '>
</object>