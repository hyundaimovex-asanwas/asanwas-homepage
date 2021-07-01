<!--
    ************************************************************************************
    * @Source         : vlub100.jsp                                                    *
    * @Description    : 이의신청(답변)_역량.                                                *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/27  |  안준성   | 최초작성                                               *
    * 2007/03/16  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>이의신청(답변)_역량(vlub100)</title>
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

        var btnList = 'TFTTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            if( document.getElementById("cmbGROUP_CD_SHR").value != '' ) {
                if (GUBUN == "01") {
                    document.getElementById("txtCOMM_CD_SHR").value = 'EG';
                }
                else if (GUBUN == "02") {
                    document.getElementById("txtCOMM_CD_SHR").value = '4';
                }
            }
            else {
                document.getElementById("txtCOMM_CD_SHR").value = '';
            }

            //데이터셋 전송(이의신청(답변)_역량)
            dsT_EV_PROTEST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub100.cmd.VLUB100CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=1&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value;
            dsT_EV_PROTEST.Reset();

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
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //트랜잭션 전송
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub100.cmd.VLUB100CMD&S_MODE=SAV";
            trT_EV_PROTEST.Post();

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

            if (dsT_EV_PROTEST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_PROTEST.GridToExcel("이의신청(답변)_역량", '', 227);

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_PROTEST.ClearAll();

            document.getElementById("txtPROTEST_YMD").value = '';
            document.getElementById("txtPROTEST_TIT").value = '';
            document.getElementById("txtPROTEST_DEC").value = '';
            document.getElementById("txtANSWER_YMD").value = '';
            document.getElementById("txtANSWER_DEC").value = '';

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_PROTEST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( form1.txtEVL_YY_SHR.value == '') {
                alert("해당년도는 필수 입력사항입니다.");
                form1.txtEVL_YY_SHR.focus();
                return false;
            }
            if( form1.txtEVL_FRQ_SHR.value == '') {
                alert("회차는 필수 입력사항입니다.");
                form1.txtEVL_FRQ_SHR.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if ( dsT_EV_PROTEST.isUpdated ) {
                for( i=1; i<=dsT_EV_PROTEST.CountRow; i++ ) {
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD") != ''
                        && ( cfDateExpr(dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD")) == false || dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD").length !=10 ) ) {
                        alert("답변일자가 날짜형식에 맞지않습니다.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD") == '' && dsT_EV_PROTEST.NameValue(i,"ANSWER_DEC") !='' ) {
                        alert("답변일자를 입력해 주세요.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_DEC") == '' && dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD")!='' ) {
                        alert("답변내용을 입력해 주세요.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_DEC");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 자료가 없습니다!");
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_PROTEST, 15, "false", "false");

            // 업무구분
            if (frameid == "vlub100") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/역량평가/";

            }

            //개인별 평가 일정 조정 정보 혹은 평가회차정보   (조회)
            fnc_SearchItem();

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 접수여부에 따른 답변불가여부  처리 부분  *
         *******************************************/

        function fnc_EnableDisableSet( ableDiv ) {

            //enable처리
            if( ableDiv == '1' ) {
                document.getElementById("txtANSWER_DEC").readOnly=false;
                document.getElementById("txtANSWER_DEC").style.backgroundColor = 'FFFFFF';
            }
            //disable처리
            if( ableDiv == '2' ) {
                alert('이의 신청 접수 후 답변이 가능합니다!');
                document.getElementById("txtANSWER_DEC").readOnly=true;
                document.getElementById("txtANSWER_DEC").style.backgroundColor = 'EEEEEE';
            }

        }

        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /*********************
         * 파일열기          *
         *********************/
        function fnc_FileOpen() {
            if (dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME") != "" ) {    // 첨부 파일이 존재하는 경우만 수행하게~
                cfDownload(dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME"), form1.txtFILE_URL.value);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Object ID ="trT_EV_PROTEST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_PROTEST)">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"  value="EG"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script language=JavaScript for=grdT_EV_PROTEST event=OnClick(row,colid)>

        if( dsT_EV_PROTEST.NameValue(row,"ACCEPT_GBN") == 'F' )
            fnc_EnableDisableSet('2');
        else
            fnc_EnableDisableSet('1');

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");

        } else {

            if( dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,"ACCEPT_GBN") == 'F' )
                fnc_EnableDisableSet('2');
            else {
                fnc_EnableDisableSet('1');
                   form1.txtANSWER_DEC.focus();//set focus
               }

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_PROTEST.CountRow);

        }

    </Script>

   <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';
            alert("평가적용기간이 아닙니다.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_PROTEST event="OnSuccess()">

            fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_PROTEST event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
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

    <!-- 타이틀 바 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이의신청(답변)_역량</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">이의신청(답변)_역량</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="40"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="160"></col>
                                    <col width="25"></col>
                                    <col width="150"></col>
                                    <col width="25"></col>
                                    <col width="200"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchBold">해당년도&nbsp;</td>
                                    <td><input id="txtEVL_YY_SHR" name="txtEVL_YY_SHR" style="width 100%;text-align: center" size="4" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">회차&nbsp;</td>
                                    <td><input id="txtEVL_FRQ_SHR" name="txtEVL_FRQ_SHR" style="width 100%;text-align: center" size="2" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">평가그룹&nbsp;</td>
                                    <td class="">
                                        <input type=hidden name="txtCOMM_CD_SHR" value="EG">
                                        <select name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>전 체</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchBold">소속&nbsp;</td>
                                    <td class="padding2423"><input name=txtDPT_CD_SHR size="3"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <input id=txtDPT_NM_SHR size="8" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                    </td>
                                    <td align="right" class="searchBold">사번&nbsp;</td>
                                    <td class="padding2423"><input name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();">
                                        <input id=txtENO_NM_SHR style="text-align: center" size="8" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                        <td align="right">&nbsp;</td>
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
                            <object    id="grdT_EV_PROTEST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:115px;">
                                <param name="DataID"                            value="dsT_EV_PROTEST">
                                <param name="EdiTABLE"                    value="false">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                        value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"              value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                            value="
                                    <C> id='EVL_YY'       width=40        name='년도'     align=center     show=false </C>
                                    <C> id='EVL_GBN'       width=40        name='구분'     align=center        show=false </C>
                                    <C> id='EVL_FRQ'       width=40        name='회차'     align=center    show=false </C>
                                    <C> id='GROUP_NM'       width=80        name='평가그룹'     align=left    edit=none </C>
                                    <C> id='HEAD_NM'       width=80        name='본부'     align=left    edit=none </C>
                                    <C> id='DPT_NM'       width=70        name='소속'     align=left    edit=none </C>
                                    <C> id='JOB_NM'       width=60        name='직위'     align=left    edit=none </C>
                                    <C> id='ENO_NO'       width=60        name='사번'     align=center    edit=none </C>
                                    <C> id='ENO_NAME'       width=60        name='성명'     align=center    edit=none </C>
                                    <C> id='PROTEST_TIT'       width=90        name='신청제목'     align=left    edit=none </C>
                                    <C> id='PROTEST_YMD'       width=70        name='신청일'     align=center    edit=none </C>
                                    <C> id='PROTEST_DEC'       width=300        name='신청내용'     align=left    edit=none show=false </C>
                                    <C> id='ACCEPT_YMD'       width=70        name='접수일자'     align=center     edit=none </C>
                                    <C> id='ACCEPT_DEC'       width=300        name='접수내용'     align=left show=false </C>
                                    <C> id='ANSWER_YMD'       width=70        name='답변일자'     align=center show=false </C>
                                    <C> id='ANSWER_DEC'       width=300        name='답변내용'     align=left show=false </C>
                                    <C> id='CHIEP_GRD'       width=30        name='등급'     align=center        edit=none </C>
                                    <C> id='FILE_GBN'         width=30        name='첨부'    align=center    editstyle=checkbox    edit=none value={IF(FILE_NAME='','F','T')} </C>
                                    <C> id='ACCEPT_GBN'       width=30        name='접수'    align=center    editstyle=checkbox    edit=none </C>
                                    <C> id='ANSWER_GBN'       width=30        name='답변'    align=center   editstyle=checkbox    edit=none </C>
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

    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr><td height="5"></td></tr>
    </table>

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" height="160" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="25"></col>
                        <col width="30"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold" rowspan="3">이<BR><BR>의<BR><BR>신<BR><BR>청</td>
                        <td align="center" class="creamBold">일자</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_YMD name=txtPROTEST_YMD style="text-align:center" size="15" class="input_ReadOnly" readonly>
                            &nbsp;&nbsp;<B>첨부파일명</B>&nbsp;<input id=txtFILE_NAME name=txtFILE_NAME size="74" class="input_ReadOnly" readonly>&nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnFILEOPEN','','/images/button/FileOpenOver.gif',3)">  <img src="/images/button/FileOpenOn.gif"   id="btnDEL" name="btnFILEOPEN" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileOpen()"></a>
                            <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">제목</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_TIT name=txtPROTEST_TIT size="121" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">내<BR><BR>용</td>
                        <td align="center">
                            <textarea id=txtPROTEST_DEC name=txtPROTEST_DEC rows="9" cols="120" class="input_ReadOnly" readonly></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" rowspan="2">답<BR><BR><BR>변</td>
                        <td align="center" class="creamBold">일자</td>
                        <td class="padding2423">
                            <input id=txtANSWER_YMD name=txtANSWER_YMD style="text-align:center" size="15" maxlength=10 onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">내<BR><BR>용</td>
                        <td align="center">
                            <textarea id=txtANSWER_DEC name=txtANSWER_DEC rows="9" cols="120" onBlur="cfCheckLength('txtANSWER_DEC','답변내용','4000');" onChange="javascript:if( document.getElementById('txtANSWER_YMD').value == '' ) { if( this.value.length == 0 ) document.getElementById('txtANSWER_YMD').value=''; else document.getElementById('txtANSWER_YMD').value=getToday(); } else { if( this.value.length == 0 ) document.getElementById('txtANSWER_YMD').value=''; } " class="input_ReadOnly" ></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    </form>
    <!-- form 끝 -->

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>

    <!--
    **************************************************************
    * 바인딩 컴포넌트
    **************************************************************
    -->
    <!-- 이의신청(답변)_역량 테이블 -->
    <comment id="__NSID__">
    <object id="bndT_EV_PROTEST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_EV_PROTEST">
        <Param Name="ActiveBind"        Value=true>
        <Param Name="BindInfo", Value='
            <C>Col=PROTEST_YMD       Ctrl=txtPROTEST_YMD     Param=value</C>
            <C>Col=PROTEST_TIT       Ctrl=txtPROTEST_TIT     Param=value</C>
            <C>Col=PROTEST_DEC       Ctrl=txtPROTEST_DEC     Param=value</C>
            <C>Col=ANSWER_YMD        Ctrl=txtANSWER_YMD      Param=value</C>
            <C>Col=ANSWER_DEC        Ctrl=txtANSWER_DEC      Param=value</C>
            <C>Col=FILE_NAME         Ctrl=txtFILE_NAME       Param=value</C>
            <C>Col=FILE_URL          Ctrl=txtFILE_URL        Param=value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>
