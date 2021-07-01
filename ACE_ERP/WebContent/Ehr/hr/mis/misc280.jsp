<!--
    ************************************************************************************
    * @Source         : misc280.jsp                                                    *
    * @Description    : 업무별예산(부문별) PAGE                                        *
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
    <title>업무별예산(부문별)(misc280)</title>
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
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var ITEM_CD  = document.getElementById("cmbITEM_CD_SHR").value;
            var PIS_YY2  = new Number(PIS_YY) - 1;

            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }

            dsT_MI_BUDGETMST.ClearData();

            dsT_MI_BUDGETMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc280.cmd.MISC280CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&OCC_CD="+OCC_CD+"&ITEM_CD="+ITEM_CD+"&PIS_YY2="+PIS_YY2;
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

            var ITEM_CD  = document.getElementById("cmbITEM_CD_SHR").value;
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var PLN_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var CUR_YY   = new Number(PLN_YY) - 1;

            var url = "misc280_PV.jsp?item_cd="+ITEM_CD+"&occ_cd="+OCC_CD+"&cur_yy="+CUR_YY+"&pln_yy="+PLN_YY;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_MI_BUDGETMST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_MI_BUDGETMST.GridToExcel("업무별예산(부문별)", '', 225);

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

            document.getElementById('cmbOCC_CD_SHR').selectedIndex  = 0;
            document.getElementById('cmbITEM_CD_SHR').selectedIndex = 0;

            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value);

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

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc280.cmd.MISC280CMD&S_MODE=SHR_01";
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

       function fnc_setHirYm(pis_yy) {

            var Row     = dsT_CP_WORKLOG.NameValueRow("PIS_YY", pis_yy);
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(Row, "PAY_YMD");
            var bef_yy  = new Number(pis_yy) - 1;

            // 그리드의 컬럼명
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP','Name') = bef_yy + "년도 예산";
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP2','Name') = bef_yy + "년도 추정실적";
            form1.grdT_MI_BUDGETMST.ColumnProp('AFT_GRP','Name') = pis_yy + "년도 예산";

            // 계획년월
            // 사업년도가 전년도인 경우
            if (PAY_YM.substr(0,4) != pis_yy) {

                var bef_month = new Number(PAY_YM.substr(4,2)) - 1
                form1.grdT_MI_BUDGETMST.ColumnProp('BEF1_SUM','Name') = "1월 ~ " + bef_month + "월;실 적";

                if (PAY_YM.substr(4,2) != '12') {
                    form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = PAY_YM.substr(4,2) + "월 ~ 12월;추정실적";
                }
                else {
                    form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = "12월 추정실적";
                }

            }

            // 사업년도가 당해년도인 경우
            if (PAY_YM.substr(0,4) == pis_yy) {

                form1.grdT_MI_BUDGETMST.ColumnProp('BEF1_SUM','Name') = "1월 ~ 12월;실 적";
                form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = "추정실적";

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
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_BUDGETMST) |
    | 3. 사용되는 Table List(T_MI_BUDGETMST)        |
    +----------------------------------------------->
    <Object ID="dsT_MI_BUDGETMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
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
            var bef_yy = new Number(getToday().substr(0,4)) - 1;

            // 그리드의 컬럼명
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP','Name') = bef_yy + "년도 예산";
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP2','Name') = bef_yy + "년도 추정실적";
            form1.grdT_MI_BUDGETMST.ColumnProp('AFT_GRP','Name') = getToday().substr(0,4) + "년도 예산";

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

            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">업무별예산(부문별)</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">업무별예산(부문별)</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">    <img src="/images/button/btn_PrintOn.gif"  name="Image6"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                                <col width="90"></col>
                                <col width="100 "></col>
                                <col width="90 "></col>
                                <col width="100"></col>
                                <col width="90 "></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사업년도&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR"  onChange="fnc_setHirYm(this.value);" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">근로구분&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbOCC_CD_SHR" style="width:100%" >
                                        <option value="">모  두</option>
                                        <option value="A">사무직</option>
                                        <option value="M">택배직</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">항목&nbsp;</td>
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
                                <td>&nbsp;</td>
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
                    <td valign="top" class="searchState" align="right" width="100">(단위 : 천원)</span></td>
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
                                <C>  id='HEAD_NM'         width=100  name='구분'                  align=center SubBgColor='#99FFCC' subsumtext='합  계'</C>
                                <G>  id='BEF_GRP'         name='2006년도 예산' HeadBgColor='#F7DCBB'
                                     <C> id='BEF_AVG'     width=85   name='월간평균'              align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF_SUM'     width=85   name='년 간'                 align=right  SubBgColor='#99FFCC' </C>
                                </G>
                                <G>  id='BEF_GRP2'        name='2006년도 추정실적' HeadBgColor='#F7DCBB'
                                     <C> id='BEF1_SUM'    width=85   name='1월~9월;실적'          align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF2_SUM'    width=85   name='10월~12월;추정실적'    align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF3_SUM'    width=85   name='계'                    align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF_RATE'    width=85   name='계획비;달성율'         align=right  SubBgColor='#99FFCC' subsumtext={SubAvg(BEF_RATE)}</C>
                                </G>
                                <G>  id='AFT_GRP'         name='2007년도 예산' HeadBgColor='#F7DCBB'
                                     <C> id='AFT_AVG'     width=85   name='월간평균'              align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='AFT_SUM'     width=85   name='년 간'                 align=right  SubBgColor='#99FFCC' </C>
                                </G>
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

