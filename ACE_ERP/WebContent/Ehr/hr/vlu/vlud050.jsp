<!--
    ************************************************************************************
    * @Source         : vlud050.jsp                                                    *
    * @Description    : 평가반영현황 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/03  |  박인이   | 최초작성                                               *
    * 2007/03/19  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>평가반영현황(vlud050)</title>
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

        var EVL_YY = new Array();
        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var APPLY_GBN = form1.cmbAPPLY_GBN_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var DPT_CD    = form1.txtDPT_CD_SHR.value;
            var CountRow = 0;

            // 시작년도와 종료년도 체크
            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY2_SHR)) {
                    return;
                }
            }
            else {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY1_SHR)) {
                    return;
                }
            }

            EVL_YY1 = EVL_YY[0];
            EVL_YY2 = EVL_YY[1];
            EVL_YY3 = EVL_YY[2];
            EVL_YY4 = EVL_YY[3];
            EVL_YY5 = EVL_YY[4];

            dsT_EV_EVLAPPLY.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud050.cmd.VLUD050CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2+"&EVL_YY3="+EVL_YY3+"&EVL_YY4="+EVL_YY4+"&EVL_YY5="+EVL_YY5+"&APPLY_GBN="+APPLY_GBN+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
            dsT_EV_EVLAPPLY.Reset();

            CountRow = dsGT_EV_EVLAPPLY.CountRow;

            // GroupExpr용 DATASET Load
            if (CountRow == 0)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", CountRow);

            }

            form1.grdGT_EV_EVLAPPLY.Focus();

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
 			var APPLY_GBN = form1.cmbAPPLY_GBN_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var DPT_CD    = form1.txtDPT_CD_SHR.value;

            // 시작년도와 종료년도 체크
            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY2_SHR)) {
                    return;
                }
            }
            else {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY1_SHR)) {
                    return;
                }
            }

            EVL_YY1 = EVL_YY[0];
            EVL_YY2 = EVL_YY[1];
            EVL_YY3 = EVL_YY[2];
            EVL_YY4 = EVL_YY[3];
            EVL_YY5 = EVL_YY[4];

            params = "APPLY_GBN="+APPLY_GBN
                   + "&ENO_NO="+ENO_NO
                   + "&DPT_CD="+DPT_CD
                   + "&EVL_YY1="+EVL_YY1
                   + "&EVL_YY2="+EVL_YY2
                   + "&EVL_YY3="+EVL_YY3
                   + "&EVL_YY4="+EVL_YY4
                   + "&EVL_YY5="+EVL_YY5
                   ;

			var url = "vlud050_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");


        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsGT_EV_EVLAPPLY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdGT_EV_EVLAPPLY.GridToExcel("평가반영현황", '', 225)

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_EVLAPPLY.ClearData();
            dsGT_EV_EVLAPPLY.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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
            cfStyleGrid(form1.grdGT_EV_EVLAPPLY,0,"false","false");

            getSelYy2('cmbEVL_YY1_SHR');
            getSelYy2('cmbEVL_YY2_SHR');

            // 업무구분
            if (frameid == "vlud050") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가정보/";
            }

            // 초기화
            for (var i = 0; i < 5; i++) {

                EVL_YY[i] = '';

            }

            EVL_YY[0] = form1.cmbEVL_YY1_SHR.value;

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

        /*****************************************************
         * 년도필드 값 변경시 시작년도와 종료년도 check      *
         ****************************************************/
        function fnc_ChkEvlyy(target) {

            var CNT = new Number(form1.cmbEVL_YY2_SHR.value) -  new Number(form1.cmbEVL_YY1_SHR.value);

            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                alert("시작년도가 종료년도보다 큽니다.");
                target.focus();
                return false;
            }

            if (CNT >= 5) {
                alert("최대 5년간 데이터만 조회할 수 있습니다.");
                target.focus();
                return false;
            }

            // 초기화
            for (var i = 0; i < 5; i++) {

                EVL_YY[i] = '';

            }

            for (i = 0; i <= CNT; i++) {

                EVL_YY[i] = Number(form1.cmbEVL_YY1_SHR.value) + i;

            }

            return true;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLAPPLY)  |
    | 3. 사용되는 Table List(T_EV_EVLAPPLY)         |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLAPPLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. GroupExpr용 DataSet                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_QSTANS)    |
    | 3. 사용되는 Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsGT_EV_EVLAPPLY" Classid="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Logical"        Value="true">
        <Param Name="DataID"         Value="dsT_EV_EVLAPPLY">
        <Param Name="GroupExpr"      Value="HEAD_SEQ:DPT_SEQ:JOB_SEQ:ENO_NO:HEAD_NM:DPT_NM:JOB_NM:ENO_NM:TOT_APPLY_RATE,EVL_YY,APPLY_RATE">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가반영현황</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평가반영현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <colgroup>
                                <col width="50"></col>
                                <col width="130"></col>
                                <col width="25"></col>
                                <col width="30"></col>
                                <col width="25"></col>
                                <col width="160"></col>
                                <col width="25"></col>
                                <col width="160"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">조회기간</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY1_SHR" name="cmbEVL_YY1_SHR" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="javascript:if (fnc_ChkEvlyy(this)) { fnc_SearchList(); }"></select>년 ~
                                    <select id="cmbEVL_YY2_SHR" name="cmbEVL_YY2_SHR" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="javascript:if (fnc_ChkEvlyy(this)) { fnc_SearchList(); }"></select>년
                                </td>
                                <td align="right" class="searchState">구분</td>
                                <td class="padding2423">
                                    <select id="cmbAPPLY_GBN_SHR" name="cmbAPPLY_GBN_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()"  onChange="fnc_SearchList()">
                                        <option value="1">성과급</option>
                                        <option value="2">상여금</option>
                                        <!--option>승진점수</option-->
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="10"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                        <object    id="grdGT_EV_EVLAPPLY" classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"            value="dsGT_EV_EVLAPPLY">
                            <param name="EdiTABLE"          value="false">
                            <param name="DragDropEnable"    value="true">
                            <param name="SortView"          value="Left">
                            <param name="GTitleHeight"      value=0>
                            <param name="VIEWSUMMARY"       value=0>
                            <param name="Format"            value="
                                <C> id='{currow}'           width=60    name='순번'    align=center HeadBgColor='#F7DCBB' </C>
                                <C> id='HEAD_NM'            width=100   name='본부'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='DPT_NM'             width=100   name='소속'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='JOB_NM'             width=100   name='직위'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='ENO_NO'             width=100   name='사번'    align=center HeadBgColor='#F7DCBB' </C>
                                <C> id='ENO_NM'             width=100   name='성명'    align=center HeadBgColor='#F7DCBB' </C>
                                <R>
                                    <G> name=$xkeyname_$$  HeadBgColor='#F7DCBB'
                                        <C> id='APPLY_RATE_$$'  width=50  name='지급율'  align=right HeadBgColor='#F7DCBB' </C>
                                    </G>
                                </R>
                                <C> id='TOT_APPLY_RATE'     width=50    name='합계'    align=right  HeadBgColor='#F7DCBB' </C>
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