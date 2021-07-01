<!--
***********************************************************************
* @source      : vlua010.jsp
* @description : 평가구조설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/20      오대성        최초작성.
* 2007/03/15      박인이        수정. (직무평가업무내용 추가)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>평가구조설정(vlua010)</title>
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
        var year    = getToday().substring(0,4);
        var GUBUN   = '';
        var frameid = window.external.GetFrame(window).FrameId;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_EV_TYPE.ClearAll();
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SHR&GUBUN="+document.getElementById('txtGUBUN').value+"&EVL_YY="+document.getElementById('selEVL_YY').value;
            dsT_EV_TYPE.Reset();

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

            if(!fnc_SaveItemCheck()){
                return;
            } else {
                trT_EV_TYPE.KeyValue = "tr01(I:dsT_EV_TYPE=dsT_EV_TYPE)";
                trT_EV_TYPE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SAV";
                trT_EV_TYPE.post();
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

            //이곳에 해당 코딩을 입력 하세요

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_TYPE.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            var form = document.form1;

            if (form.selEVL_YY.value != year) {
                alert("현재년도 이외의 자료는 저장 및 수정할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                form.selEVL_YY.focus();
                return false;
            }

            if (!dsT_EV_TYPE.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            //CheckBox의 Check여부를 DateSet에 Setting
            if (form.chkDOWN_YN.checked == true) {

                dsT_EV_TYPE.NameValue(1,"DOWN_YN") = '1';

                if(100 != eval(form.txtSubDown.value)){
                    alert("하향 평정비율의 합은 100이 되어야 합니다.");
                    form1.txtDOWN_RATE1.focus();//set focus
                    return false;
                }
            } else {
                dsT_EV_TYPE.NameValue(1,"DOWN_YN") = '0';
            }

            if(form.chkUP_YN.checked == true) {
                dsT_EV_TYPE.NameValue(1,"UP_YN") = '1';
                if(100 != eval(form.txtSubUp.value)){
                    alert("상향 평정비율의 합은 100이 되어야 합니다.");
                    form1.txtUP_RATE1.focus();//set focus
                    return false;
                }
            } else {
                dsT_EV_TYPE.NameValue(1,"UP_YN") = '0';
            }

            if(100 != eval(form.txtSubAch.value)){
                alert("성과 평정비율의 합은 100이 되어야 합니다.");
                form1.txtACH_RATE1.focus();//set focus
                return false;
            }

            if(form.chkHEAD_YN.checked == true) {
                dsT_EV_TYPE.NameValue(1,"HEAD_YN") = '1';
            } else {
                dsT_EV_TYPE.NameValue(1,"HEAD_YN") = '0';
            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //SelectBox년도 Setting
            getSelYy2('selEVL_YY');

            if (frameid == "vlua010") {
                // 인사평가
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";
            }
            else {
                // 직무평가
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua010.cmd.VLUA010CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+getToday().substring(0,4);
            dsT_EV_TYPE.Reset();
            form1.txtDOWN_RATE1.focus();                               // 처음 항목에 Focus

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /****************************************************
         * 16. 하향평가 차수 설정에 따른 비율 설정란 변경    *
         ***************************************************/
        function checkDownRate() {

            var form = document.form1;

            if(form.chkDOWN_YN.checked == true) {
                form.selDOWN_CNT.readOnly = false;

                switch (form.selDOWN_CNT.value) {
                    case '1':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = true;
                        form.txtDOWN_RATE3.readOnly = true;
                        form.txtDOWN_RATE2.value = 0;
                        form.txtDOWN_RATE3.value = 0;
                        form.txtDOWN_RATE1.className='';
                        form.txtDOWN_RATE2.className="input_ReadOnly";
                        form.txtDOWN_RATE3.className="input_ReadOnly";
                        break;

                    case '2':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = false;
                        form.txtDOWN_RATE3.readOnly = true;
                        form.txtDOWN_RATE3.value = 0;
                        form.txtDOWN_RATE1.className = '';
                        form.txtDOWN_RATE2.className = '';
                        form.txtDOWN_RATE3.className="input_ReadOnly";
                        break;

                    case '3':
                        form.txtDOWN_RATE1.readOnly = false;
                        form.txtDOWN_RATE2.readOnly = false;
                        form.txtDOWN_RATE3.readOnly = false;
                        form.txtDOWN_RATE1.className = '';
                        form.txtDOWN_RATE2.className = '';
                        form.txtDOWN_RATE3.className = '';
                        break;

                }
            } else {
                form.selDOWN_CNT.readOnly = true;
                form.txtDOWN_RATE1.readOnly = true;
                form.txtDOWN_RATE2.readOnly = true;
                form.txtDOWN_RATE3.readOnly = true;
                form.txtDOWN_RATE1.value = 0;
                form.txtDOWN_RATE2.value = 0;
                form.txtDOWN_RATE3.value = 0;
                form.txtDOWN_RATE1.className="input_ReadOnly";
                form.txtDOWN_RATE2.className="input_ReadOnly";
                form.txtDOWN_RATE3.className="input_ReadOnly";
            }

            form.txtSubDown.value = eval(form.txtDOWN_RATE1.value)+eval(form.txtDOWN_RATE2.value)+eval(form.txtDOWN_RATE3.value);
        }

        /****************************************************
         * 17. 상향평가 차수 설정에 따른 비율 설정란 변경    *
         ***************************************************/
        function checkUpRate() {

            var form = document.form1;

            if(form.chkUP_YN.checked == true) {
                form.selUP_CNT.readOnly = false;

                switch (form.selUP_CNT.value) {

                    case '1':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = true;
                        form.txtUP_RATE3.readOnly = true;
                        form.txtUP_RATE2.value = 0;
                        form.txtUP_RATE3.value = 0;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className="input_ReadOnly";
                        form.txtUP_RATE3.className="input_ReadOnly";
                        break;

                    case '2':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = false;
                        form.txtUP_RATE3.readOnly = true;
                        form.txtUP_RATE3.value = 0;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className = '';
                        form.txtUP_RATE3.className="input_ReadOnly";
                        break;

                    case '3':
                        form.txtUP_RATE1.readOnly = false;
                        form.txtUP_RATE2.readOnly = false;
                        form.txtUP_RATE3.readOnly = false;
                        form.txtUP_RATE1.className = '';
                        form.txtUP_RATE2.className = '';
                        form.txtUP_RATE3.className = '';
                        break;

                }
            } else {

                form.selUP_CNT.readOnly = true;
                form.txtUP_RATE1.readOnly = true;
                form.txtUP_RATE2.readOnly = true;
                form.txtUP_RATE3.readOnly = true;
                form.txtUP_RATE1.value = 0;
                form.txtUP_RATE2.value = 0;
                form.txtUP_RATE3.value = 0;
                form.txtUP_RATE1.className="input_ReadOnly";
                form.txtUP_RATE2.className="input_ReadOnly";
                form.txtUP_RATE3.className="input_ReadOnly";

            }

            form.txtSubUp.value = eval(form.txtUP_RATE1.value)+eval(form.txtUP_RATE2.value)+eval(form.txtUP_RATE3.value);
        }


        /************************************************
         * 18. 평정비율설정란의 변경시 합계 내용 표시    *
         ***********************************************/
        function showTotal(object) {
            var form = document.form1;
            var obj  = object.id;
            var down_rate1 = Number(form.txtDOWN_RATE1.value);
            var down_rate2 = Number(form.txtDOWN_RATE2.value);
            var down_rate3 = Number(form.txtDOWN_RATE3.value);
            var up_rate1   = Number(form.txtUP_RATE1.value);
            var up_rate2   = Number(form.txtUP_RATE2.value);
            var up_rate3   = Number(form.txtUP_RATE3.value);
            var ach_rate1  = Number(form.txtACH_RATE1.value);

            if((obj == 'txtDOWN_RATE1')||(obj == 'txtDOWN_RATE2')||(obj == 'txtDOWN_RATE3')) {
                form.txtSubDown.value = down_rate1 + down_rate2 + down_rate3;
                form.txtDOWN_RATE1.value = down_rate1;
                form.txtDOWN_RATE2.value = down_rate2;
                form.txtDOWN_RATE3.value = down_rate3;
            }
            else if((obj == 'txtUP_RATE1')||(obj == 'txtUP_RATE2')||(obj == 'txtUP_RATE3')) {
                form.txtSubUp.value = up_rate1 + up_rate2 + up_rate3;
                form.txtUP_RATE1.value = up_rate1;
                form.txtUP_RATE2.value = up_rate2;
                form.txtUP_RATE3.value = up_rate3;
            }
            else if((obj == 'txtACH_RATE1')) {
                form.txtSubAch.value = ach_rate1;
                form.txtACH_RATE1.value = ach_rate1;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_TYPE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:VLUA010=dsT_EV_TYPE">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 하였을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var form = document.form1;
        if (iCount < 1)    {

            dsT_EV_TYPE.addRow();

            //default setting
            dsT_EV_TYPE.NameValue(1,"GUBUN")    = GUBUN;
            dsT_EV_TYPE.NameValue(1,"EVL_YY")   = form.selEVL_YY.value;    //해당년도 = 올해년도
            dsT_EV_TYPE.NameValue(1,"ABL_CNT")  = 1;                       //역량평가회수 1
            dsT_EV_TYPE.NameValue(1,"DOWN_CNT") = 1;                       //역량하향평가차수 1
            dsT_EV_TYPE.NameValue(1,"UP_CNT")   = 1;                       //역량상향평가차수 1
            dsT_EV_TYPE.NameValue(1,"ACH_CNT")  = 1;                       //성과평가회수 1

            form.chkDOWN_YN.checked = false;            //하향평가 checked
            document.getElementById("resultMessage").innerText = '* ' + form.selEVL_YY.value+"년도 자료는 없습니다.";

            checkDownRate();
            checkUpRate();

        } else {
            form.chkDOWN_YN.checked = false;

            if(dsT_EV_TYPE.NameValue(1,"DOWN_YN") == 1) {
                form.chkDOWN_YN.checked = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"UP_YN") == 1) {
                form.chkUP_YN.checked = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"HEAD_YN") == 1) {
                form.chkHEAD_YN.checked = true;
            }

            document.getElementById("resultMessage").innerText = '* ' + form.selEVL_YY.value+ '년도 자료가 조회되었습니다.';
            checkDownRate();
            checkUpRate();

        }

        //합계 Setting
        form.txtSubDown.value = dsT_EV_TYPE.NameValue(1,"DOWN_RATE1")+dsT_EV_TYPE.NameValue(1,"DOWN_RATE2")+dsT_EV_TYPE.NameValue(1,"DOWN_RATE3");
        form.txtSubUp.value   = dsT_EV_TYPE.NameValue(1,"UP_RATE1")+dsT_EV_TYPE.NameValue(1,"UP_RATE2")+dsT_EV_TYPE.NameValue(1,"UP_RATE3");
        form.txtSubAch.value  = dsT_EV_TYPE.NameValue(1,"ACH_RATE1");

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터를 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_TYPE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_TYPE event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가구조설정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평가구조설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>평가구조설정 </strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="50"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                    <col width="80"></col>
                    <col width="30"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">해당년도</td>
                    <td class="padding2423" colspan="6">
                        <select id="selEVL_YY" name="selEVL_YY" onChange="fnc_SearchList(this.value)">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">역량평가</td>
                    <td align="center" class="creamBold">평가주기(년)</td>
                    <td class="padding2423">
                        <select name=selABL_CNT id=selABL_CNT>
                            <option value="1">1회</option>
                            <option value="2">2회</option>
                            <option value="3">3회</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">
                        <input type="checkbox" name="chkDOWN_YN" id=chkDOWN_YN style="border:0" align="absmiddle" onclick="checkDownRate()">역량평가(평가자)</td>
                    <td class="padding2423">
                        <select name="selDOWN_CNT" id=selDOWN_CNT onChange="checkDownRate()">
                            <option value="1">1차</option>
                            <option value="2">2차</option>
                            <option value="3">3차</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">
                        <input type="checkbox" name="chkUP_YN" id=chkUP_YN style="border:0" align="absmiddle" onclick="checkUpRate()">다면평가실시</td>
                    <td class="padding2423">
                        <select name="selUP_CNT" id=selUP_CNT onChange="checkUpRate()">
                            <option value="1">1차</option>
                            <option value="2">2차</option>
                            <option value="3">3차</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">성과평가</td>
                    <td align="center" class="creamBold">평가주기(년)</td>
                    <td class="padding2423">
                        <select name=selACH_CNT id=selACH_CNT>
                            <option value="1">1회</option>
                            <option value="2">2회</option>
                            <option value="3">3회</option>
                        </select>
                    </td>
                    <td class="padding2423" colspan="4">
                        <input type="hidden" name="chkHEAD_YN" id=chkHEAD_YN value="yes" style="border:0" align="absmiddle"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 1 -->

<!-- 조건 입력 테이블 시작 2 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>평정비율설정 </strong></td>
    </tr>
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                <colgroup>
                    <col width="100"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" colspan="2">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td align="center" class="creamBold">1차</td>
                    <td align="center" class="creamBold">2차</td>
                    <td align="center" class="creamBold">3차</td>
                    <td align="center" class="creamBold">합계</td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">역 량<br>평 가</td>
                    <td align="center" class="creamBold">하향평가</td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE1 id=txtDOWN_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE2 id=txtDOWN_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtDOWN_RATE3 id=txtDOWN_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423"><input name=txtSubDown readonly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">다면평가</td>
                    <td class="padding2423">
                        <input name=txtUP_RATE1 id=txtUP_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtUP_RATE2 id=txtUP_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <input name=txtUP_RATE3 id=txtUP_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423"><input name=txtSubUp readOnly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">성과평가</td>
                    <td class="padding2423">
                        <input name=txtACH_RATE1 id=txtACH_RATE1 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()" onkeyup="showTotal(this);">
                    </td>
                    <td class="padding2423">
                        <!-- <input name=txtACH_RATE2 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"> -->
                    </td>
                    <td class="padding2423">
                        <!-- <input name=txtACH_RATE3 size="18" maxlength="3" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"> -->
                    </td>
                    <td class="padding2423"><input name=txtSubAch readOnly class="input_ReadOnly" style="width 75px; font-color:#DDDDDD; font-weight: bold; text-align:right">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
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
<!-- 조건 입력 테이블 끝 2 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가 기준 정보 설정 테이블 -->
<object id="bndT_EV_TYPE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_TYPE">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN            Param=value            Disable=disabled</C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY           Param=value            Disable=disabled</C>
        <C>Col=ABL_CNT      Ctrl=selABL_CNT          Param=value</C>
        <C>Col=DOWN_YN      Ctrl=chkDOWN_YN          Param=value</C>
        <C>Col=DOWN_CNT     Ctrl=selDOWN_CNT         Param=value</C>
        <C>Col=UP_YN        Ctrl=chkUP_YN            Param=value</C>
        <C>Col=UP_CNT       Ctrl=selUP_CNT           Param=value</C>
        <C>Col=ACH_CNT      Ctrl=selACH_CNT          Param=value</C>
        <C>Col=HEAD_YN      Ctrl=chkHEAD_YN          Param=value</C>
        <C>Col=UP_RATE1     Ctrl=txtUP_RATE1         Param=value</C>
        <C>Col=UP_RATE2     Ctrl=txtUP_RATE2         Param=value</C>
        <C>Col=UP_RATE3     Ctrl=txtUP_RATE3         Param=value</C>
        <C>Col=DOWN_RATE1   Ctrl=txtDOWN_RATE1       Param=value</C>
        <C>Col=DOWN_RATE2   Ctrl=txtDOWN_RATE2       Param=value</C>
        <C>Col=DOWN_RATE3   Ctrl=txtDOWN_RATE3       Param=value</C>
        <C>Col=ACH_RATE1    Ctrl=txtACH_RATE1        Param=value</C>
        <C>Col=ACH_RATE2    Ctrl=txtACH_RATE2        Param=value</C>
        <C>Col=ACH_RATE3    Ctrl=txtACH_RATE3        Param=value</C>
    '>
</object>