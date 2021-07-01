<!--
    ************************************************************************************
    * @Source         : vluc070.jsp                                                    *
    * @Description    : 면담내용현황(개인).                                            *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/16  |  안준성   | 최초작성                                               *
    * 2007/03/17  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>면담내용확인(vluc070)</title>
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

        var btnList = 'FFFFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

            if( searchDiv == '1' ) {
                //데이터셋 전송(면담일자 조회)
                dsT_EV_INTERVIEW.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc070.cmd.VLUC070CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
                dsT_EV_INTERVIEW.Reset();
            }
            if( searchDiv == '2' ) {
                //데이터셋 전송(면담내용 조회)
                dsT_EV_INTERVIEW_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc070.cmd.VLUC070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"EVL_FRQ")+"&txtENO_NO_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"EVLENO_NO")+"&txtINTERVIEW_YMD_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"INTERVIEW_YMD")+"&txtAIM_YMD_SHR="+dsT_EV_INTERVIEW.NameValue(dsT_EV_INTERVIEW.RowPosition,"AIM_YMD");
                dsT_EV_INTERVIEW_01.Reset();
            }

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

             //현재 평가적용기간에 해당하는 년도,회차 정보
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

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

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_INTERVIEW.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_INTERVIEW, 15, "false", "false");
            cfStyleGrid(form1.grdT_EV_INTERVIEW_01, 15, "false", "false");

            // 업무구분
            if (frameid == "vluc070") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            //년도별 평가회차관리 조회
            fnc_SearchItem();

        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <Object ID="dsT_EV_INTERVIEW" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_INTERVIEW_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script language=JavaScript for=grdT_EV_INTERVIEW event=OnClick(row,colid)>
        if( row > 0 )
            fnc_SearchList('2');        //면담내용조회
    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_INTERVIEW Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

        }

           grdT_EV_INTERVIEW.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_INTERVIEW_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //alert("검색하신 조건의 자료가 없습니다..");

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩

        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("평가적용기간이 아닙니다.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value  = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            document.getElementById("txtENO_NO_SHR").value  = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value  = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NM_SHR").value  = '<%=box.get("SESSION_DPTNM")%>';

            //면담일자,면담자조회
            fnc_SearchList('1');

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>

    <Script For=dsT_EV_INTERVIEW Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_INTERVIEW_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>

    <Script For=dsT_EV_INTERVIEW Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_INTERVIEW_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);
           alert("OnDataError()");

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->


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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">면담내용확인</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">면담내용확인</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="75"></col>
                                    <col width="75"></col>
                                    <col width="75"></col>
                                    <col width="75"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><input id=txtEVL_YY_SHR size="10" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">회차</td>
                                    <td class="padding2423"><input id=txtEVL_FRQ_SHR size="10" maxlength="3" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">소속</td>
                                    <td class="padding2423"><input id=txtDPT_NM_SHR size="15" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">사번</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">성명</td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
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
                            <object    id="grdT_EV_INTERVIEW" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:196px;height:340px;">
                                <param name="DataID"                  value="dsT_EV_INTERVIEW">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id='INTERVIEW_YMD'    width=80    name='면담일자'  align=center </C>
                                    <C> id='EVLENO_NM'        width=80    name='면담자'    align=center </C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
            <td align="right">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_INTERVIEW_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:594px;height:340px;">
                                <param name="DataID"                  value="dsT_EV_INTERVIEW_01">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id='TASK_AIM'         width=120        name='주요핵심과제'     align=left  edit=none  suppress=1 </C>
                                    <C> id='BASIC_PAR'        width=120        name='성과평가지표'     align=left  edit=none  suppress=2 </C>
                                    <C> id='RESULT_WRT'       width=120        name='성과기록'         align=left </C>
                                    <G>name='면담내용' HeadBgColor='#F7DCBB'
                                        <C> id='CUR_LEVEL'    width=120        name='현수준'           align=left </C>
                                        <C> id='CAUSE_CTS'    width=120        name='사유/원인'        align=left </C>
                                        <C> id='ADVICE_CTS'   width=120        name='지도/조언내용'    align=left </C>
                                    <G>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 내용 조회 그리드 데이블 끝-->

    </form>
    <!-- form 끝 -->

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>