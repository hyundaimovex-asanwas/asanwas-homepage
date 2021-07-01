<!--
    ************************************************************************************
    * @Source         : misc260.jsp                                                    *
    * @Description    : 사업구분별항목별집계 PAGE                                      *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>사업구분별항목별집계(misc260)</title>
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

        var btnList  = 'TFFTTTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var HIRS_MM  = document.getElementById("cmbHIRS_MM_SHR").value;
            var HIRE_MM  = document.getElementById("cmbHIRE_MM_SHR").value;
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var ITEM_CD  = document.getElementById("cmbITEM_CD_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;

            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }

            if (HIRS_MM > HIRE_MM) {
                alert("FROM 계획월이 TO 계획월보다 큽니다.");
                return;
            }

            dsT_MI_BUDGETMST.ClearData();

            dsT_MI_BUDGETMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc260.cmd.MISC260CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&HIRS_MM="+HIRS_MM+"&HIRE_MM="+HIRE_MM+"&OCC_CD="+OCC_CD+"&ITEM_CD="+ITEM_CD+"&ENO_NO="+ENO_NO;
            dsT_MI_BUDGETMST.Reset();

            form1.grdT_MI_BUDGETMST.Focus();

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

            if (dsT_MI_BUDGETMST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_MI_BUDGETMST.GridToExcel("사업구분별항목별집계", '', 225);

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

            document.getElementById("cmbPIS_YY_SHR").selectedIndex = 0;
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';

            document.getElementById('cmbHIRS_MM_SHR').selectedIndex = 0;
            document.getElementById('cmbHIRE_MM_SHR').selectedIndex = 11;

            document.getElementById('cmbOCC_CD_SHR').selectedIndex  = 0;
            document.getElementById('cmbITEM_CD_SHR').selectedIndex = 0;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_MI_BUDGETMST.ClearData();

            form1.cmbPIS_YY_SHR.value = PlanYear;
            document.getElementById("cmbPIS_YY_SHR").focus();

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
            cfStyleGrid(form1.grdT_MI_BUDGETMST,0,"false","false");

            // 사업년도 및 대상기간 추출
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc260.cmd.MISC260CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();


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
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_BUDGETMST) |
    | 3. 사용되는 Table List(T_MI_BUDGETMST)        |
    +----------------------------------------------->
    <Object ID="dsT_MI_BUDGETMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)   |
    | 3. 사용되는 Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_MI_BUDGETMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_MI_BUDGETMST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_MI_BUDGETMST Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_BUDGETMST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        var oOption;
        var Index  = document.getElementById("cmbPIS_YY_SHR").length;

        if (iCount == 0)    {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = getToday().substr(0,4);
            oOption.text  = getToday().substr(0,4);
            document.getElementById("cmbPIS_YY_SHR").add(oOption);

        }
        else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            //사업년도
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text  = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                document.getElementById("cmbPIS_YY_SHR").add(oOption);

            }

            var obj    = document.getElementById("cmbPIS_YY_SHR");
            var idx    = obj.selectedIndex;
            var PIS_YY = obj.options[idx].text;


            document.getElementById('cmbHIRS_MM_SHR').selectedIndex = 0;
            document.getElementById('cmbHIRE_MM_SHR').selectedIndex = 11;

            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

        }

        document.getElementById("cmbPIS_YY_SHR").focus();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사업구분별항목별집계</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">사업구분별항목별집계</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="65"></col>
                                <col width="60 "></col>
                                <col width="45 "></col>
                                <col width="100"></col>
                                <col width="45 "></col>
                                <col width="75"></col>
                                <col width="45 "></col>
                                <col width="75"></col>
                                <col width="45 "></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사업년도 </td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onChange="document.getElementById('cmbHIRS_MM_SHR').selectedIndex = 0;document.getElementById('cmbHIRE_MM_SHR').selectedIndex = 11;" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">계획월</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbHIRS_MM_SHR" style="width:38%" >
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select> ~
                                    <select id="cmbHIRE_MM_SHR" style="width:38%" >
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">근로구분</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbOCC_CD_SHR" style="width:100%" >
                                        <option value="">모  두</option>
                                        <option value="A">사무직</option>
                                        <option value="M">택배직</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">항목</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbITEM_CD_SHR" style="width:100%" >
                                        <option value="1">급여</option>
                                        <option value="2">상여</option>
                                        <option value="3">중식대</option>
                                        <option value="4">휴일근무</option>
                                        <option value="5">연차수당</option>
                                        <option value="6">국민연금</option>
                                        <option value="7">고용보험</option>
                                        <option value="8">건강검진</option>
                                        <option value="9">건강보험</option>
                                        <option value="10">학자금</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">사번 </td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10"  maxlength="10" style="ime-mode:disabled" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_MI_BUDGETMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"                  value="dsT_MI_BUDGETMST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=60    name='순번'               align=center </C>
                                <C> id='HEAD_NM'      width=160   name='본부'               align=left   </C>
                                <C> id='DPT_NM'       width=160   name='부서'               align=left   </C>
                                <C> id='JOB_NM'       width=100   name='직위'               align=center </C>
                                <C> id='ENO_NO'       width=100   name='사번'               align=center </C>
                                <C> id='ENO_NM'       width=100   name='성명'               align=center </C>
                                <C> id='AMT'          width=100   name='합계'               align=rigth  </C>
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

