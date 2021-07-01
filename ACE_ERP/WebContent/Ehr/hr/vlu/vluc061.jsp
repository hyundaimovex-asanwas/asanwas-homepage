<!--
    ************************************************************************************
    * @Source         : vluc061.jsp                                                    *
    * @Description    : 면담상세관리.                                                  *
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
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>면담상세관리(vluc061)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String T_MODE        = request.getParameter("T_MODE");                    //모드구분
    String GUBUN         = request.getParameter("GUBUN");                     //업무구분
    String EVL_YY        = request.getParameter("EVL_YY");                    //해당년도
    String EVL_FRQ       = request.getParameter("EVL_FRQ");                   //회차
    String ENO_NO        = request.getParameter("ENO_NO");                    //피면담자사번
    String ENO_NM        = request.getParameter("ENO_NM");                    //피면담자성명
    String EVLENO_NO     = request.getParameter("EVLENO_NO");                 //면담자사번
    String EVLENO_NM     = request.getParameter("EVLENO_NM");                 //면담자성명
    String INTERVIEW_YMD = request.getParameter("INTERVIEW_YMD");             //면담일자
    String AIM_YMD       = request.getParameter("AIM_YMD");                   //면담일자
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';
        var opener = window.dialogArguments;

        var GUBUN = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList( searchDiv ) {

            if( searchDiv == '1' ) {

                if( '<%=T_MODE%>' == 'I' ) {
                    //데이터셋 전송
                    dsT_EV_INTERVIEW.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR=<%=EVL_YY%>&txtEVL_FRQ_SHR=<%=EVL_FRQ%>&txtENO_NO_SHR=<%=ENO_NO%>&txtEVLENO_NO_SHR=<%=EVLENO_NO%>&txtINTERVIEW_YMD_SHR="+document.getElementById("txtINTERVIEW_YMD_SHR").value+"&txtAIM_YMD_SHR=<%=AIM_YMD%>";
                    dsT_EV_INTERVIEW.Reset();
                } else if( '<%=T_MODE%>' == 'U' || '<%=T_MODE%>' == 'S' ) {
                    //데이터셋 전송
                    dsT_EV_INTERVIEW.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR=<%=EVL_YY%>&txtEVL_FRQ_SHR=<%=EVL_FRQ%>&txtENO_NO_SHR=<%=ENO_NO%>&txtEVLENO_NO_SHR=<%=EVLENO_NO%>&txtINTERVIEW_YMD_SHR=<%=INTERVIEW_YMD%>&txtAIM_YMD_SHR=<%=AIM_YMD%>";
                    dsT_EV_INTERVIEW.Reset();
                }

            }

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( '<%=T_MODE%>' != 'S' ) {

                if( !fnc_SaveItemCheck() ) {
                    return;
                }

                for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
                    if( dsT_EV_INTERVIEW.RowStatus(i) == 1 || dsT_EV_INTERVIEW.RowStatus(i) == 3 ) {        //Update상태
                        if( dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") == 'I' ) {        //입력데이터
                            dsT_EV_INTERVIEW.NameValue(i,"INTERVIEW_YMD")=document.getElementById("txtINTERVIEW_YMD_SHR").value;
                            dsT_EV_INTERVIEW.UserStatus(i)=1;
                        } else {    //수정데이터
                            dsT_EV_INTERVIEW.NameValue(i,"INTERVIEW_YMD")=document.getElementById("txtINTERVIEW_YMD_SHR").value;
                            dsT_EV_INTERVIEW.UserStatus(i)=3;
                        }
                    }
                }

                //트랜잭션 전송
                trT_EV_INTERVIEW.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc061.cmd.VLUC061CMD&S_MODE=SAV";
                trT_EV_INTERVIEW.Post();
            }
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

            //이곳에 해당 코딩을 입력 하세요

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_INTERVIEW.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            window.close();

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

            if ( dsT_EV_INTERVIEW.isUpdated ) {
                if( document.getElementById("txtINTERVIEW_YMD_SHR").value == '' ) {
                    alert("면담일자는 필수입력사항입니다..");
                    document.getElementById("txtINTERVIEW_YMD_SHR").focus();
                    return false;
                }

                if( cfDateExpr(document.getElementById("txtINTERVIEW_YMD_SHR").value) == false || document.getElementById("txtINTERVIEW_YMD_SHR").value.length != 10 ) {
                    alert("면담일자가 날짜형식에 맞지않습니다.");
                    document.getElementById("txtINTERVIEW_YMD_SHR").focus();
                    return false;
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 내용이 없습니다!");
                return false;
            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            if( '<%=T_MODE%>' == 'I' || '<%=T_MODE%>' == 'U' ) {        //입력모드
                //Grid Style 적용
                cfStyleGrid(form1.grdT_EV_INTERVIEW, 15, "true", "false");
            } else if( '<%=T_MODE%>' == 'S' ) {                         //현황모드
                //Grid Style 적용
                cfStyleGrid(form1.grdT_EV_INTERVIEW, 15, "false", "false");
            }

            if( '<%=T_MODE%>' == 'I' )  {       //입력모드
                document.getElementById("txtINTERVIEW_YMD_SHR").value = getToday();
            }
            else if( '<%=T_MODE%>' == 'U' || '<%=T_MODE%>' == 'S' ) {
                document.getElementById("txtINTERVIEW_YMD_SHR").value = '<%=INTERVIEW_YMD%>';
            }

            // 업무구분
            if ("<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

            }
            else {
                // 직무평가
                GUBUN = "02";

            }

            document.getElementById("txtEVLENO_NO_SHR").value = '<%=EVLENO_NO%>';
            document.getElementById("txtEVLENO_NM_SHR").value = '<%=EVLENO_NM%>';
            document.getElementById("txtENO_NO_SHR").value    = '<%=ENO_NO%>';
            document.getElementById("txtENO_NM_SHR").value    = '<%=ENO_NM%>';

            fnc_DisableSet();        //입력여부처리
            fnc_SearchList('1');     //면담내용조회
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 목표승인 여부에 따른,        *
         *        면담상세관리의 입력 disable,                            *
         *******************************************/
        function fnc_DisableSet() {

            if( '<%=T_MODE%>' == 'I'  || '<%=T_MODE%>' == 'U' ) {    //입력모드, 수정모드
                form1.grdT_EV_INTERVIEW.Editable = true;
                document.getElementById("image1").disabled = false;

                if ('<%=T_MODE%>' == 'I') {

                    document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = false;
                    document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'FFFFFF';
                }
                else {

                    document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = true;
                    document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'EEEEEE';
                }

            } else if( '<%=T_MODE%>' == 'S' ) {    //현황모드
                form1.grdT_EV_INTERVIEW.Editable = false;
                document.getElementById("txtINTERVIEW_YMD_SHR").readOnly = true;
                document.getElementById("txtINTERVIEW_YMD_SHR").style.backgroundColor = 'EEEEEE';
            }

        }

        /********************
         * 16. 단축키 처리  *
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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_INTERVIEW" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_INTERVIEW)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_INTERVIEW Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");

        } else {
            for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
                if( dsT_EV_INTERVIEW.NameValue(i,"RESULT_WRT") == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"CUR_LEVEL")  == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"CAUSE_CTS")  == '' &&
                    dsT_EV_INTERVIEW.NameValue(i,"ADVICE_CTS") == '' ) {
                    dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") = 'I';
                }
            }

            dsT_EV_INTERVIEW.ResetStatus();
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_INTERVIEW.CountRow);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_INTERVIEW Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = '1 ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_INTERVIEW Event="OnDataError()">

        document.getElementById("resultMessage").innerText = '2 ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_INTERVIEW event="OnSuccess()">
        for( i=1; i<=dsT_EV_INTERVIEW.CountRow; i++ ) {
            if( !(dsT_EV_INTERVIEW.NameValue(i,"RESULT_WRT") == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"CUR_LEVEL")  == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"CAUSE_CTS")  == '' &&
                  dsT_EV_INTERVIEW.NameValue(i,"ADVICE_CTS") == '') )  {
                dsT_EV_INTERVIEW.NameValue(i,"DATA_STATUS") = '';
            }
        }

        dsT_EV_INTERVIEW.ResetStatus();

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        opener.fnc_SearchList('2');

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_INTERVIEW event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        dsT_EV_INTERVIEW.ResetUserStatus();
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">
                        <% if( T_MODE.equals("I") || T_MODE.equals("U") )
                                out.print("면담상세관리");
                             else if( T_MODE.equals("S") )
                                 out.println("면담상세관리(현황)");
                        %>
                        </td>
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
                <% if( T_MODE.equals("I") || T_MODE.equals("U")) { %>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <% } %>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',2)">  <img src="/images/button/btn_ExitOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="70"></col>
                                    <col width="80"></col>
                                    <col width="*"></col>
                                  </colgroup>
                                <tr>
                                    <td align="right" class="searchState">면담일자</td>
                                    <td class="padding2423"><input id=txtINTERVIEW_YMD_SHR size="10" maxlength="10" style="ime-mode:disabled;text-align:center;" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    </td>
                                    <td align="right" class="searchState">면담자</td>
                                    <td class="padding2423"><input id=txtEVLENO_NO_SHR size="10"  style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td class="padding2423"><input id=txtEVLENO_NM_SHR  size="10"  style="text-align:center" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">피면담자</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR size="10"  style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR  size="10"  style="text-align:center" class="input_ReadOnly" readonly>
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
                            <object    id="grdT_EV_INTERVIEW" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                                <param name="DataID"                  value="dsT_EV_INTERVIEW">
                                <param name="EdiTABLE"                value="true">
                                <param name="DragDropEnable"          value="true">
                                <param name="AutoReSizing"            value="true">
                                <param name=ColSizing                 value="true">
                                <param name="Format"                  value="

                                    <C> id='TASK_AIM'         width=128        name='주요핵심과제'     align=left        edit=none     suppress=1</C>
									<C> id='BASIC_PAR'        width=128        name='KPI(측정방법)'    align=left        edit=none     suppress=2</C>
                                    <C> id='RESULT_WRT'       width=127        name='성과기록'         align=left        editlimit=100 </C>
                                    <G>name='면담내용' HeadBgColor='#F7DCBB'
                                        <C> id='CUR_LEVEL'    width=127        name='현수준/진행사항'           align=left        editlimit=100 </C>
                                        <C> id='CAUSE_CTS'    width=127        name='사유/원인'        align=left        editlimit=100 </C>
                                        <C> id='ADVICE_CTS'   width=127        name='지도/조언내용'    align=left        editlimit=100 </C>
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