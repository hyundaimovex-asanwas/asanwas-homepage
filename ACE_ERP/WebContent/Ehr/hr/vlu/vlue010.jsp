<!--
*****************************************************
* @source       : vlue010.jsp
* @description : 성과급반영 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/27      안준성        최초작성.
* 2007/03/19      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>성과급반영(vlue010)</title>
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

        var saveDiv = false;    //save상태 구분
        var btnList = 'TFTTFTFT';
        var year = getToday().substr(0, 4);

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송(성과급반영조회)
            dsT_EV_EVLAPPLY.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SHR&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value;
            dsT_EV_EVLAPPLY.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //데이터셋 전송(평가구조설정정보 조회)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck('0') )    return;

            //트랜잭션 전송
            trT_EV_EVLAPPLY.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SAV";
            trT_EV_EVLAPPLY.Post();

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

            if (dsT_EV_EVLAPPLY.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_EVLAPPLY.GridToExcel("성과급반영", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_EVLAPPLY_01.CountColumn == 0) {
                dsT_EV_EVLAPPLY_01.setDataHeader("EVL_YY:STRING, ENO_NO:STRING, DPT_CD:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_EVLAPPLY_01.AddRow();
            dsT_EV_EVLAPPLY_01.NameValue(1,"EVL_YY") = document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_EVLAPPLY_01.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_EVLAPPLY_01.NameValue(1,"DPT_CD") = document.getElementById("txtDPT_CD_SHR").value;
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

            form1.txtENO_NO_SHR.value = '';
            form1.txtENO_NM_SHR.value = '';
            form1.txtDPT_CD_SHR.value = '';
            form1.txtDPT_NM_SHR.value = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_EVLAPPLY.ClearData();

            document.form1.txtDPT_CD_SHR.focus();
        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_EVLAPPLY.IsUpdated)  {

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
        function fnc_SaveItemCheck(saveDiv) {

            //저장시 유효성 체크
            if( saveDiv == '0' ) {
                if ( dsT_EV_EVLAPPLY.isUpdated ) {
                    if (new Number(form1.cmbEVL_YY_SHR.value) < new Number(year) - 1) {
                        alert("해당 년도 이외의 자료는 저장 및 수정이 불가합니다!");
                        fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                        document.form1.cmbEVL_YY_SHR.focus();
                        return false;
                    }
                } else {
                    fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                    alert("저장 할 자료가 없습니다!");
                    return false;
                }
                return true;
            }
            //성과급반영시 유효성 체크
            else if( saveDiv == '1' ) {
                if( document.getElementById("cmbEVL_YY_SHR").value == '' ) {
                    alert("해당년도는 필수 입력사항입니다.");
                    document.getElementById("cmbEVL_YY_SHR").focus();
                    return false;
                }
                return true;
            }

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_EVLAPPLY,15,"true","false");      // Grid Style 적용
            getSelYy2('cmbEVL_YY_SHR');                                  //해당 년도 AddItem

            // 업무구분
            if (frameid == "vlue010") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가반영/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가반영/";
            }

            //평가구조설정정보 조회
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

        /******************
         * 16. 성과급 반영  *
         ******************/
        function fnc_EvlApply() {

            if( !fnc_SaveItemCheck('1') ) return;

            // 성과급반영 여부를 물어 본다.
            if (confirm(document.getElementById("cmbEVL_YY_SHR").value+"년도 에 대한 성과급 반영을 하시겠습니까?\n기존에 반영한 자료는 삭제됩니다.") == false) return;

            dsT_EV_DEPTRATE.ClearData();

            //본부별배분율, 평가반영비율 및 등급별배분율 존재여부 확인
            dsT_EV_DEPTRATE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
            dsT_EV_DEPTRATE.Reset();

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

    <Object ID="dsT_EV_EVLAPPLY_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_DEPTRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_EVLAPPLY)  |
    | 3. 사용되는 Table List(T_EV_EVLAPPLY)         |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLAPPLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_EVLAPPLY)">
    </Object>

    <Object ID ="trT_EV_EVLAPPLY_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_EVLAPPLY_01,O:SHR=dsT_EV_EVLAPPLY)">
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

        if( saveDiv == false ) {
            if (iCount == 0)    {

                fnc_Message(document.getElementById("resultMessage"),"MSG_02");
                alert("검색하신 조건의 자료가 없습니다!");

            } else {

                fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_EVLAPPLY.CountRow);

            }
        }
        else  {

            document.getElementById("resultMessage").innerText = '* 성과급 반영이 완료 되었습니다.';

        }

        if (new Number(form1.cmbEVL_YY_SHR.value) < new Number(year) - 1) {
            form1.grdT_EV_EVLAPPLY.Editable = "false";
            form1.btn.disabled = true;
        }
        else {
            form1.grdT_EV_EVLAPPLY.Editable = "true";
            form1.btn.disabled = false;
        }

        saveDiv = false;
        grdT_EV_EVLAPPLY.SetColumn("APPLY_RATE");//set focus

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //해당년도에 역량,성과 hidden처리
            for( i=1; i<=4; i++ ) {
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'false';
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'false';
            }

        } else {

            //해당년도에 따른 역량,성과 show,hidden처리
            for( i=1; i<=4; i++ ) {
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'true';
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'true';
            }

            for( i=4; i>dsT_EV_TYPE.NameValue(1,"ABL_CNT"); i-- )
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_1_"+i, "show") = 'false';

            for( i=4; i>dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i-- )
                grdT_EV_EVLAPPLY.ColumnProp("EVL_GBN_2_"+i, "show") = 'false';

        }

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnLoadCompleted(iCount)">


        if (iCount > 0) {
            for (var i = 1; i <= iCount; i++) {
                // 구분 '1'(본부별배분율)이면
                if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "1") {
                    alert("평가대상자설정에 존재하는 본부가 본부별배분율입력 데이터에 미존재합니다.\n본부별배분율입력 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
                // 구분 '3'(성과급에 대한 등급별비율 여부)이면
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "3" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("성과급에 대한 등급별배분율이 미존재합니다.\n등급별배분율설정 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
                // 구분 '4'(평가반영비율)이면  존재하면
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "4") {
                    alert("평가대상자설정에 존재하는 평가그룹이 평가반영비율 데이터에 미존재합니다.\n평가반영비율설정 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
                // 구분 '5'(역량평가최종등급)이면
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "5" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("역량평가등급최종확정된 데이터가 미존재합니다.\n역량평가등급최종확정 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
                // 구분 '6'(성과평가최종등급)이면
                else if (dsT_EV_DEPTRATE.NameValue(i, "GBN") == "5" && dsT_EV_DEPTRATE.NameValue(i, "VAL") == "0") {
                    alert("성과평가등급최종확정된 데이터가 미존재합니다.\n성과평가등급최종확정 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
            }

            dsT_EV_EVLAPPLY.ClearData();

            saveDiv = true;

            //데이터셋 전송(성과급반영조회)
            dsT_EV_EVLAPPLY.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.e.vlue010.cmd.VLUE010CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value;
            dsT_EV_EVLAPPLY.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_DEPTRATE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_EVLAPPLY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_EVLAPPLY event="OnFail()">

        saveDiv = false;
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <script for=trT_EV_EVLAPPLY_01 event="OnSuccess()">

        document.getElementById("resultMessage").innerText = '* 성과급 반영이 완료 되었습니다.';
        dsT_EV_EVLAPPLY_01.ClearAll();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_EVLAPPLY_01 event="OnFail()">

        saveDiv = false;
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);
        dsT_EV_EVLAPPLY_01.ClearAll();

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">성과급반영</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">성과급반영</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif" name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="60"></col>
                                    <col width="40"></col>
                                    <col width="60"></col>
                                    <col width="160"></col>
                                    <col width="60"></col>
                                    <col width="180"></col>
                                    <col width="200"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR name=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                        <td align="right" class="searchState">부서&nbsp;</td>
                                        <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="8" maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input id=txtDPT_NM_SHR size="8" class="input_ReadOnly" readOnly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                        </td>
                                        <td align="right" class="searchState">사번&nbsp;</td>
                                        <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                        <input id=txtENO_NM_SHR size="8" class="input_ReadOnly" readOnly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                        </td>
                                    <td align="left" width="200"></td>
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
                            <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                            <td align="right">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btn" name="btn" width="80" height="20" border="0" align="absmiddle"  onClick="fnc_EvlApply();"></a>
                            </td>
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
                            <object    id="grdT_EV_EVLAPPLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                                <param name="DataID"                  value="dsT_EV_EVLAPPLY">
                                <param name="Editable"                value="true">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id='{String(currow)}'    width=50    name='순번'      align=center </C>
                                    <C> id='HEAD_NM'             width=100   name='본부'      align=left    edit=none </C>
                                    <C> id='DPT_NM'              width=100   name='부서'      align=left    edit=none </C>
                                    <C> id='JOB_NM'              width=100   name='직위'      align=left    edit=none </C>
                                    <C> id='ENO_NO'              width=100   name='사번'      align=center  edit=none </C>
                                    <C> id='ENO_NM'              width=100   name='성명'      align=center  edit=none </C>
                                    <G> name='역량' HeadBgColor='#F7DCBB'
                                    <C> id='EVL_GBN_1_1'         width=45    name='1회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_2'         width=45    name='2회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_3'         width=45    name='3회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_1_4'         width=45    name='4회'       align=center  edit=none </C>
                                    </G>
                                    <G> name='성과' HeadBgColor='#F7DCBB'
                                    <C> id='EVL_GBN_2_1'         width=45    name='1회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_2'         width=45    name='2회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_3'         width=45    name='3회'       align=center  edit=none </C>
                                    <C> id='EVL_GBN_2_4'         width=45    name='4회'       align=center  edit=none </C>
                                    </G>
                                    <C> id='APPLY_RATE'          width=77    name='지급율(%)'     align=right </C>

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