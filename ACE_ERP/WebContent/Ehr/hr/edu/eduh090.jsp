<!--
    ************************************************************************************
    * @Source         : eduh090.jsp                                                    *
    * @Description    : 고용보험관리 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/08  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>고용보험관리(eduh090)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TTFTFFFT';

        var gbn      = '';
        var edu_cd   = '';
        var seq_no   = '';
        var edu_nm   = '';
        var edu_term = '';


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var FIELD_CD = document.getElementById("cmbFIELD_CD_SHR").value;
            var SHAPE_CD = document.getElementById("cmbSHAPE_CD_SHR").value;
            var YEAR     = document.getElementById("txtYEAR_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            var EDU_CD   = document.getElementById("txtEDU_CD_SHR").value;

            if (YEAR == "") {
                alert("년도는 필수입력항목입니다.");
                document.getElementById("txtYEAR_SHR").focus();
                return;
            }

            // 교육기간 FROM일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "교육기간 FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // 교육기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "교육기간 TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // 교육시작일의 FROM ~ TO일자 비교
            if (STR_YMD != "" && END_YMD != "") {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("교육시작일 FROM일자는 반드시 교육시작일 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            if (STR_YMD != "") {
                if (STR_YMD.substr(0,4) != YEAR) {
                    alert("교육일자는 조건년도의 범위내에서 입력하셔야 합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }

                if (END_YMD == "") {
                    alert("교육일자의 TO일자를 입력하십시오.");
                    document.getElementById("txtEND_YMD_SHR").focus();
                    return;
                }
            }

            if (END_YMD != "") {
                if (END_YMD.substr(0,4) != YEAR) {
                    alert("교육일자는 조건년도의 범위내에서 입력하셔야 합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }

                if (STR_YMD == "") {
                    alert("교육일자의 FROM일자를 입력하십시오.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return;
                }
            }

            dsT_ED_INSURANCE.ClearData();

            dsT_ED_INSURANCE.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh090.cmd.EDUH090CMD&S_MODE=SHR&FIELD_CD="+FIELD_CD+"&SHAPE_CD="+SHAPE_CD+"&YEAR="+YEAR+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EDU_CD="+EDU_CD;
            dsT_ED_INSURANCE.Reset();

            form1.grdT_ED_INSURANCE.Focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_INSURANCE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("과정코드[" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_CD") + "] 과정명[" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_NM")  + "] 교육기간 [" + dsT_ED_INSURANCE.NameValue(dsT_ED_INSURANCE.RowPosition,"EDU_TERM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ED_INSURANCE.DeleteRow(dsT_ED_INSURANCE.RowPosition);

            trT_ED_INSURANCE.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh090.cmd.EDUH090CMD&S_MODE=DEL";
            trT_ED_INSURANCE.post();


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

            if (dsT_ED_INSURANCE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_INSURANCE.GridToExcel("고용보험관리", '', 225);
        }



        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            gbn     = "1";        // 1: 신규, 2: 수정
            edu_cd  = "";
            seq_no  = "";
            edu_nm   = '';
            edu_term = '';

            window.showModalDialog("/hr/edu/eduh091.jsp", self, "dialogHeight:640px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("cmbFIELD_CD_SHR").value = '';
            document.getElementById("cmbSHAPE_CD_SHR").value = '';
            document.getElementById("txtYEAR_SHR").value     = getToday().substr(0,4);
            document.getElementById("txtSTR_YMD_SHR").value  = '';
            document.getElementById("txtEND_YMD_SHR").value  = '';
            document.getElementById("txtENO_NM_SHR").value   = '';
            document.getElementById("txtEDU_CD_SHR").value   = '';
            document.getElementById("txtEDU_NM_SHR").value   = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_INSURANCE.ClearData();

            document.getElementById("txtYEAR_SHR").focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_ED_INSURANCE,0,"false","false");

            //교육분야
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }

            //교육형태
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }

            document.getElementById("txtYEAR_SHR").value = getToday().substr(0, 4);

            document.getElementById("txtYEAR_SHR").focus();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_INSURANCE)  |
    | 3. 사용되는 Table List(T_ED_INSURANCE)         |
    +----------------------------------------------->
    <Object ID="dsT_ED_INSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_INSURANCE)  |
    | 3. 사용되는 Table List(T_ED_INSURANCE)         |
    +----------------------------------------------->
    <Object ID ="trT_ED_INSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_INSURANCE)">
    </Object>

    <!-- 교육분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_INSURANCE Event="OnDblClick(row, col)">

        gbn      = "2";        // 1: 신규, 2: 수정
        edu_cd   = dsT_ED_INSURANCE.NameValue(row, "EDU_CD");
        seq_no   = dsT_ED_INSURANCE.NameValue(row, "SEQ_NO");
        edu_nm   = dsT_ED_INSURANCE.NameValue(row, "EDU_NM");
        edu_term = dsT_ED_INSURANCE.NameValue(row, "EDU_TERM");

        if (col == 'FUNC') {

            // 수료명부
            if (dsT_ED_INSURANCE.NameValue(row, "PAS_CNT") > 0) {

                window.showModalDialog("/hr/edu/eduh092.jsp", self, "dialogHeight:460px; dialogWidth:570px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            }
            else {
                alert("해당 교육과정에 대한 수료자가 미존재합니다.");
                return;
            }
        }
        else {

            // 고용보험관리 수정
            window.showModalDialog("/hr/edu/eduh091.jsp", self, "dialogHeight:640px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        }


    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_INSURANCE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_INSURANCE.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_INSURANCE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_INSURANCE event="OnFail()">

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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고용보험관리</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">고용보험관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState">년도</td>
                                <td class="padding2423" align="left">
                                    <input id="txtYEAR_SHR" style="ime-mode:disabled" size="4" maxlength="4" onkeypress="cfCheckNumber();">
                                </td>
                                <td align="right" class="searchState">교육기간</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '교육기간 FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '교육기간 TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
                                </td>
                            </tr>
                            <tr>

                                <td align="right" class="searchState">교육분야</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbFIELD_CD_SHR">
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">교육형태</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbSHAPE_CD_SHR">
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">교육과정</td>
                                <td class="padding2423">
                                    <input id="txtEDU_CD_SHR" name="txtEDU_CD_SHR" size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('Q1', 'txtEDU_CD_SHR','txtEDU_NM_SHR');"> <input id="txtEDU_NM_SHR" name="txtEDU_NM_SHR" size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd1" name="ImgEduCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtEDU_CD_SHR','txtEDU_NM_SHR','교육과정','Q1')"></a>
                                </td>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_INSURANCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_INSURANCE">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=60    name='순번'           align=center </C>
                                <C> id='EDU_NM'       width=120   name='과정명'         align=left   </C>
                                <C> id='EDU_TERM'     width=200   name='교육기간'       align=center </C>
                                <C> id='PAS_CNT'      width=80    name='수료'           align=center </C>
                                <C> id='RTN_EXPT_AMT' width=80    name='환급예상'       align=right  </C>
                                <C> id='RTN_RQST_AMT' width=80    name='환급요청'       align=right  </C>
                                <C> id='INS_E_AMT'    width=80    name='환급실행'       align=right  </C>
                                <C> id='FUNC'         width=80    name='수료명부'       align=center Color='Blue' </C>
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

</form>
<!-- form 끝 -->

</body>
</html>