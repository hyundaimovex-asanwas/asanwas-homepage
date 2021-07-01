<!--
    ************************************************************************************
    * @Source         : vlub070.jsp                                                    *
    * @Description    : 본부장조정확정_역량.                                           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/28  |  안준성   | 최초작성                                               *
    * 2007/03/16  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>본부장조정확정_역량(vlub070)</title>
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
        var flag= false;        //본부장 조정확정 기간체크

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //년도별 평가회차정보 조회
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save(p_gbn) {

            if (dsT_EV_ABLRST.CountRow == 0) {
                alert("조정 확정 또는 조정 취소를 할 평가자료가 존재하지 않습니다.");
                return;
            }

            if( p_gbn != undefined ) {
                //본부장 조정확정
                if( p_gbn == 'T') {
                    //유효성체크
                    if( !fnc_SaveItemCheck() )    return;
                    // 본부장조정 확정 여부를 물어 본다.
                    if (confirm(document.getElementById("EVL_YY").innerText+"년도 "+document.getElementById("EVL_FRQ").innerText+"회차의 본부장 조정 확정을 하시겠습니까?") == false) return;
                }

                //본부장 조정확정 취소
                if( p_gbn == 'F') {
                    // 본부장조정 확정 취소 여부를 물어 본다.
                    if (confirm(document.getElementById("EVL_YY").innerText+"년도 "+document.getElementById("EVL_FRQ").innerText+"회차의 본부장 조정 확정 취소를 하시겠습니까?") == false) return;
                }

                //신규함수
                fnc_AddNew(p_gbn);

                //트랜잭션 전송
                trT_EV_ABLRST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SAV";
                trT_EV_ABLRST.Post();
            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew(p_gbn) {

            dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") = p_gbn;

            if( p_gbn == 'T' )        //본부장 조정 확정
                dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD") = getToday();
            else
                dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD") = '';

            dsT_EV_ABLRST.NameValue(1,"GUBUN")   = GUBUN;
            dsT_EV_ABLRST.NameValue(1,"EVL_YY")  = (document.getElementById("EVL_YY").innerText).trim();
            dsT_EV_ABLRST.NameValue(1,"EVL_GBN") = '1';    //역량
            dsT_EV_ABLRST.NameValue(1,"EVL_FRQ") = (document.getElementById("EVL_FRQ").innerText).trim();

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

            if (dsT_EV_ABLRST.IsUpdated)  {

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

            if( document.getElementById("txtFEDDBK_YMD").value == '') {
                alert("적용일자는 필수 입력사항입니다.");
                document.getElementById("txtFEDDBK_YMD").focus();
                return false;
            }
            if( (document.getElementById("txtFEDDBK_YMD").value != ''
                && ( cfDateExpr(document.getElementById("txtFEDDBK_YMD").value) == false || document.getElementById("txtFEDDBK_YMD").value.length != 10 ) ) ) {
                alert("적용일자가 날짜형식에 맞지않습니다.");
                document.getElementById("txtFEDDBK_YMD").focus();
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtFEDDBK_YMD").value = getToday();

            // 업무구분
            if (frameid == "vlub070") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/역량평가/";
            }

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
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0) {
            alert("조정 확정 또는 조정 취소를 할 평가자료가 존재하지 않습니다.");
            return;
        }
        else {

            if (dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") == 'T') {
                document.getElementById("FEEDBK_YYYY").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(0,4)+" ";
                document.getElementById("FEEDBK_MM").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(5,7)+" ";
                document.getElementById("FEEDBK_DD").innerText = dsT_EV_ABLRST.NameValue(1,"FEDDBK_YMD").substring(8,10)+" ";
            }
            else {
                document.getElementById("FEEDBK_YYYY").innerText = " ";
                document.getElementById("FEEDBK_MM").innerText   = " ";
                document.getElementById("FEEDBK_DD").innerText   = " ";
            }

        }

    </Script>

       <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

           alert("평가적용기간이 아닙니다.");

        } else {

            document.getElementById("EVL_YY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+" ";
            document.getElementById("EVL_FRQ").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+" ";
            document.getElementById("EVL_STDT_YYYY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(0,4)+" ";
            document.getElementById("EVL_STDT_MM").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(5,7)+" ";
            document.getElementById("EVL_STDT_DD").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_STDT").substring(8,10)+" ";
            document.getElementById("EVL_ENDT_YYYY").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(0,4)+" ";
            document.getElementById("EVL_ENDT_MM").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(5,7)+" ";
            document.getElementById("EVL_ENDT_DD").innerText = dsT_EV_ESTINFO.NameValue(1,"EVL_ENDT").substring(8,10)+" ";

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("EVL_YY").innerText+"&EVL_GBN=1&EVL_FRQ="+document.getElementById("EVL_FRQ").innerText;
            dsT_EV_ABLRST.Reset();

        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //dsT_EV_ABLRST.ClearAll();
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">

        alert('작업을 완료 하였습니다!');

        dsT_EV_ABLRST.ClearData();

        dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub070.cmd.VLUB070CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("EVL_YY").innerText+"&EVL_GBN=1&EVL_FRQ="+document.getElementById("EVL_FRQ").innerText;
        dsT_EV_ABLRST.Reset();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">

        //dsT_EV_ABLRST.ClearAll();
        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- 켈린더 프레임-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

<!-- form 시작 -->
<form name="form1">
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <!-- 타이틀 바 테이블 시작 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">본부장조정확정_역량</td>
          <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">본부장조정확정_역량</font></td>
        </tr>
      </table>
      <!-- 타이틀 바 테이블 끝 -->
    </td>
  </tr>
  <tr>
    <!-- 버튼 -->
    <td height="35" align="right" class="paddingTop5">
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/over_decision.gif',1)"><img src="/images/button/decision.gif" name="Image1" width="90" height="20" border="0" align="absmiddle" onclick="fnc_Save('T');"></a>
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/over_decisionCancel.gif',1)"><img src="/images/button/decisionCancel.gif" name="Image2" width="80" height="20" border="0" align="absmiddle" onclick="fnc_Save('F');"></a>
        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onclick="fnc_Exit();"></a>
    </td>
  </tr>
  <tr>
    <td height="125" background="/images/specialHr/gridGreen.gif">
      <!--개인정보테이블 끝 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10"><img src="/images/specialHr/gridWhiteL2.gif" width="10" height="205"></td>
          <td width="780" align="center" valign="middle">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="hrWtable" style="padding:0 26 0 14">
                    <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74" style="padding:0 19 0 0"><img src="/images/specialHr/hr3Icon.gif" width="74" height="52"></td>
                      <td><table width="400" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/info1.gif" width="21" height="15" align="absmiddle">
                              <span id="EVL_YY">
                              </span><img src="/images/specialHr/info2.gif" width="20" height="15" align="absmiddle"></td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/hr3T01.gif" width="21" height="13" align="absmiddle">
                              <span id="EVL_FRQ"></span>
                              <img src="/images/specialHr/info3.gif" width="20" height="15" align="absmiddle">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                              <img src="/images/specialHr/hr3T02.gif" width="41" height="13" align="absmiddle">
                              <span id="EVL_STDT_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_STDT_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_STDT_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                              <img src="/images/specialHr/hr3wave.gif" width="10" height="5" align="absmiddle">
                              <span id="EVL_ENDT_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_ENDT_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="EVL_ENDT_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
                                <img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                <img src="/images/specialHr/hr3T06.gif" width="41" height="13" align="absmiddle">
                              <span id="FEEDBK_YYYY"></span>
                              <img src="/images/specialHr/hr3T03.gif" width="9" height="13" align="absmiddle">
                              <span id="FEEDBK_MM"></span>
                              <img src="/images/specialHr/hr3T04.gif" width="9" height="13" align="absmiddle">
                              <span id="FEEDBK_DD"></span>
                              <img src="/images/specialHr/hr3T05.gif" width="9" height="13" align="absmiddle">
                                <input type=hidden id=txtFEDDBK_YMD name=txtFEDDBK_YMD value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" valid='key=true' field='적용일자'>
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
                <td align="left" style="padding:3 0 0 25"><img src="/images/specialHr/hr3Img.gif" width="178" height="158"></td>
              </tr>
            </table> </td>
          <td width="10"><img src="/images/specialHr/gridWhiteR2.gif" width="10" height="205"></td>
        </tr>
      </table>
      <!--개인정보테이블 끝 -->
    </td>
  </tr>
</table>
</form>
</body>
</html>