<!--
    ************************************************************************************
    * @Source         : pird080.jsp                                                    *
    * @Description    : 사원증발급 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/10  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>사원증발급(pird080)</title>
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

        var btnList = 'FFFTFTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

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
	var PRT_TYPE = "";
			var DPT_CD_SHR;
			var HIRS_YMD_SHR;
            var HIRD_YMD_SHR;
            var ENO_NO;
            // 부서별인쇄
            if (form1.rdoGBN_SHR[0].checked == true) {
                if (document.getElementById("txtDPT_CD_SHR").value == "") {
                    alert("부서코드는 필수입력항목입니다.");
                    document.getElementById("txtDPT_CD_SHR").focus();
                    return;
                }
               DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
               PRT_TYPE = "BUSOR";
             }
            // 입사일별인쇄
            else if (form1.rdoGBN_SHR[1].checked == true) {
                if (document.getElementById("txtHIRS_YMD_SHR").value == "") {
                    alert("입사시작일자는 필수입력항목입니다.");
                    document.getElementById("txtHIRS_YMD_SHR").focus();
                    return;
                }
                else if (document.getElementById("txtHIRD_YMD_SHR").value == "") {
                    alert("입사종료일자는 필수입력항목입니다.");
                    document.getElementById("txtHIRD_YMD_SHR").focus();
                    return;
                }

                // 해당년월의 시작일자와 종료일자 비교
                if( cfDateDiff(document.getElementById("txtHIRS_YMD_SHR").value.replace(/\-/g,''),document.getElementById("txtHIRD_YMD_SHR").value.replace(/\-/g,'')) < 0 ) {
                    alert("시작일자가 종료일자보다 큽니다.");
                    document.getElementById("txtHIRS_YMD_SHR").focus();
                    return;
                }
                HIRS_YMD_SHR = document.getElementById("txtHIRS_YMD_SHR").value;
                HIRD_YMD_SHR = document.getElementById("txtHIRD_YMD_SHR").value;
                PRT_TYPE = "INDAY";
            }
            // 개인별인쇄
            else {
                if (document.getElementById("txtENO_NO1_SHR").value == "" &&
                    document.getElementById("txtENO_NO2_SHR").value == "" &&
                    document.getElementById("txtENO_NO3_SHR").value == "" &&
                    document.getElementById("txtENO_NO4_SHR").value == "" &&
                    document.getElementById("txtENO_NO5_SHR").value == "" &&
                    document.getElementById("txtENO_NO6_SHR").value == "" &&
                    document.getElementById("txtENO_NO7_SHR").value == "" &&
                    document.getElementById("txtENO_NO8_SHR").value == "" &&
                    document.getElementById("txtENO_NO9_SHR").value == "" ) {
                    alert("사번은 필수입력항목입니다.");
                    return;
                    document.getElementById("txtENO_NO1_SHR").focus();
                    }

                    ENO_NO = "";

                 if (document.getElementById("txtENO_NO1_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO1_SHR").value;}
                if (document.getElementById("txtENO_NO2_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO2_SHR").value;}
                if (document.getElementById("txtENO_NO3_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO3_SHR").value;}
                if (document.getElementById("txtENO_NO4_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO4_SHR").value;}
                if (document.getElementById("txtENO_NO5_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO5_SHR").value;}
                if (document.getElementById("txtENO_NO6_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO6_SHR").value;}
                if (document.getElementById("txtENO_NO7_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO7_SHR").value;}
                if (document.getElementById("txtENO_NO8_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO8_SHR").value;}
                if (document.getElementById("txtENO_NO9_SHR").value != ""){ENO_NO =  ENO_NO + "," + document.getElementById("txtENO_NO9_SHR").value;}
                ENO_NO = ENO_NO.substring(1, ENO_NO.length);
                PRT_TYPE = "";
            }

			var url = "pird080_PV.jsp?PRT_TYPE="+PRT_TYPE+"&ENO_NO="+ENO_NO+"&HIRS_YMD_SHR="+HIRS_YMD_SHR+"&HIRD_YMD_SHR="+HIRD_YMD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

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

            form1.rdoGBN_SHR[0].checked = true;

            fnc_FldChange();

            document.getElementById("txtDPT_CD_SHR").focus();

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

            fnc_FldChange();

            document.getElementById("txtDPT_CD_SHR").focus();

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

        function fnc_FldChange() {
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";

            document.getElementById("txtHIRS_YMD_SHR").value = "";
            document.getElementById("txtHIRD_YMD_SHR").value = "";

            document.getElementById("txtENO_NO1_SHR").value = "";
            document.getElementById("txtENO_NM1_SHR").value = "";
            document.getElementById("txtENO_NO2_SHR").value = "";
            document.getElementById("txtENO_NM2_SHR").value = "";
            document.getElementById("txtENO_NO3_SHR").value = "";
            document.getElementById("txtENO_NM3_SHR").value = "";
            document.getElementById("txtENO_NO4_SHR").value = "";
            document.getElementById("txtENO_NM4_SHR").value = "";
            document.getElementById("txtENO_NO5_SHR").value = "";
            document.getElementById("txtENO_NM5_SHR").value = "";
            document.getElementById("txtENO_NO6_SHR").value = "";
            document.getElementById("txtENO_NM6_SHR").value = "";
            document.getElementById("txtENO_NO7_SHR").value = "";
            document.getElementById("txtENO_NM7_SHR").value = "";
            document.getElementById("txtENO_NO8_SHR").value = "";
            document.getElementById("txtENO_NM8_SHR").value = "";
            document.getElementById("txtENO_NO9_SHR").value = "";
            document.getElementById("txtENO_NM9_SHR").value = "";

            // 부서별인쇄
            if (form1.rdoGBN_SHR[0].checked == true) {

                document.getElementById("txtDPT_CD_SHR").disabled = false;
                document.getElementById("ImgDptCd").disabled = false;
            }
            else {
                document.getElementById("txtDPT_CD_SHR").disabled = true;
                document.getElementById("ImgDptCd").disabled = true;
            }

            // 입사일별인쇄
            if (form1.rdoGBN_SHR[1].checked == true) {
                document.getElementById("txtHIRS_YMD_SHR").disabled = false;
                document.getElementById("txtHIRD_YMD_SHR").disabled = false;
                document.getElementById("ImgHirsYmd").disabled = false;
                document.getElementById("ImgHirdYmd").disabled = false;
            }
            else {
                document.getElementById("txtHIRS_YMD_SHR").disabled = true;
                document.getElementById("txtHIRD_YMD_SHR").disabled = true;
                document.getElementById("ImgHirsYmd").disabled = true;
                document.getElementById("ImgHirdYmd").disabled = true;
            }

            // 개인별인쇄
            if (form1.rdoGBN_SHR[2].checked == true) {

                document.getElementById("txtENO_NO1_SHR").disabled = false;
                document.getElementById("txtENO_NM1_SHR").disabled = false;
                document.getElementById("ImgEnoNo1").disabled      = false;
                document.getElementById("txtENO_NO2_SHR").disabled = false;
                document.getElementById("txtENO_NM2_SHR").disabled = false;
                document.getElementById("ImgEnoNo2").disabled      = false;
                document.getElementById("txtENO_NO3_SHR").disabled = false;
                document.getElementById("txtENO_NM3_SHR").disabled = false;
                document.getElementById("ImgEnoNo3").disabled      = false;
                document.getElementById("txtENO_NO4_SHR").disabled = false;
                document.getElementById("txtENO_NM4_SHR").disabled = false;
                document.getElementById("ImgEnoNo4").disabled      = false;
                document.getElementById("txtENO_NO5_SHR").disabled = false;
                document.getElementById("txtENO_NM5_SHR").disabled = false;
                document.getElementById("ImgEnoNo5").disabled      = false;
                document.getElementById("txtENO_NO6_SHR").disabled = false;
                document.getElementById("txtENO_NM6_SHR").disabled = false;
                document.getElementById("ImgEnoNo6").disabled      = false;
                document.getElementById("txtENO_NO7_SHR").disabled = false;
                document.getElementById("txtENO_NM7_SHR").disabled = false;
                document.getElementById("ImgEnoNo7").disabled      = false;
                document.getElementById("txtENO_NO8_SHR").disabled = false;
                document.getElementById("txtENO_NM8_SHR").disabled = false;
                document.getElementById("ImgEnoNo8").disabled      = false;
                document.getElementById("txtENO_NO9_SHR").disabled = false;
                document.getElementById("txtENO_NM9_SHR").disabled = false;
                document.getElementById("ImgEnoNo9").disabled      = false;
            }
            else {
                document.getElementById("txtENO_NO1_SHR").disabled = true;
                document.getElementById("txtENO_NM1_SHR").disabled = true;
                document.getElementById("ImgEnoNo1").disabled      = true;
                document.getElementById("txtENO_NO2_SHR").disabled = true;
                document.getElementById("txtENO_NM2_SHR").disabled = true;
                document.getElementById("ImgEnoNo2").disabled      = true;
                document.getElementById("txtENO_NO3_SHR").disabled = true;
                document.getElementById("txtENO_NM3_SHR").disabled = true;
                document.getElementById("ImgEnoNo3").disabled      = true;
                document.getElementById("txtENO_NO4_SHR").disabled = true;
                document.getElementById("txtENO_NM4_SHR").disabled = true;
                document.getElementById("ImgEnoNo4").disabled      = true;
                document.getElementById("txtENO_NO5_SHR").disabled = true;
                document.getElementById("txtENO_NM5_SHR").disabled = true;
                document.getElementById("ImgEnoNo5").disabled      = true;
                document.getElementById("txtENO_NO6_SHR").disabled = true;
                document.getElementById("txtENO_NM6_SHR").disabled = true;
                document.getElementById("ImgEnoNo6").disabled      = true;
                document.getElementById("txtENO_NO7_SHR").disabled = true;
                document.getElementById("txtENO_NM7_SHR").disabled = true;
                document.getElementById("ImgEnoNo7").disabled      = true;
                document.getElementById("txtENO_NO8_SHR").disabled = true;
                document.getElementById("txtENO_NM8_SHR").disabled = true;
                document.getElementById("ImgEnoNo8").disabled      = true;
                document.getElementById("txtENO_NO9_SHR").disabled = true;
                document.getElementById("txtENO_NM9_SHR").disabled = true;
                document.getElementById("ImgEnoNo9").disabled      = true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)    |
    | 3. 사용되는 Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사원증발급</td>
                    <td align="right" class="navigator">HOME/인사관리/인사정보출력/<font color="#000000">사원증발급</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="6">사원증발급</td>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="100"></col>
                            <col width="70"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="padding2423" >
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" onClick="fnc_FldChange()">부서별 인쇄
                            </td>
                            <td class="padding2423" colspan="2">
                                <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="4"  maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="22" class="input_ReadOnly"  readOnly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" onClick="fnc_FldChange()">입사일별인쇄
                            </td>
                            <td class="padding2423" colspan="2">
                                <input id="txtHIRS_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '입사시작일자');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirsYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirsYmd" name="ImgHirsYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRS_YMD_SHR','','145','125');"></a> -
                                <input id="txtHIRD_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '입사종료일자');"   onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirdYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirdYmd" name="ImgHirdYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRD_YMD_SHR','','260','125');"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423"  valign="top" rowspan="10">
                                <input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;"  onClick="fnc_FldChange()">개인별 인쇄
                            </td>
                            <td class="paddingTop5">&nbsp;&nbsp;&nbsp;사&nbsp;&nbsp;번
                            </td>
                            <td class="paddingTop5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성&nbsp;&nbsp;명
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO1_SHR  name=txtENO_NO1_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO1_SHR', 'txtENO_NM1_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM1_SHR name=txtENO_NM1_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM1_SHR','txtENO_NO1_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO1_SHR','txtENO_NM1_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO1_SHR  name=txtENO_NO2_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO2_SHR', 'txtENO_NM2_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM1_SHR name=txtENO_NM2_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM2_SHR','txtENO_NO2_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo2" name="ImgEnoNo2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO2_SHR','txtENO_NM2_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO3_SHR  name=txtENO_NO3_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO3_SHR', 'txtENO_NM3_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM3_SHR name=txtENO_NM3_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM3_SHR','txtENO_NO3_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo3" name="ImgEnoNo3" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO3_SHR','txtENO_NM3_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO4_SHR  name=txtENO_NO4_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO4_SHR', 'txtENO_NM4_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM4_SHR name=txtENO_NM4_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM4_SHR','txtENO_NO4_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo4" name="ImgEnoNo4" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO4_SHR','txtENO_NM4_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO5_SHR  name=txtENO_NO5_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO5_SHR', 'txtENO_NM5_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM5_SHR name=txtENO_NM5_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM5_SHR','txtENO_NO5_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo5','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo5" name="ImgEnoNo5" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO5_SHR','txtENO_NM5_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO6_SHR  name=txtENO_NO6_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO6_SHR', 'txtENO_NM6_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM6_SHR name=txtENO_NM6_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM6_SHR','txtENO_NO6_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo6" name="ImgEnoNo6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO6_SHR','txtENO_NM6_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO7_SHR  name=txtENO_NO7_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO7_SHR', 'txtENO_NM7_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM7_SHR name=txtENO_NM7_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM7_SHR','txtENO_NO7_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo7','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo7" name="ImgEnoNo7" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO7_SHR','txtENO_NM7_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO8_SHR  name=txtENO_NO8_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO8_SHR', 'txtENO_NM8_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM8_SHR name=txtENO_NM8_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM8_SHR','txtENO_NO8_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo8','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo8" name="ImgEnoNo8" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO8_SHR','txtENO_NM8_SHR')"></a>
                            </td>
                        </tr>
                        <tr>
                            <td class="padding2423">
                                <input id=txtENO_NO9_SHR  name=txtENO_NO9_SHR size="10"  maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO9_SHR', 'txtENO_NM9_SHR');">
                            </td>
                            <td class="padding2423">
                                <input id=txtENO_NM9_SHR name=txtENO_NM9_SHR size="16" onChange="fnc_GetEnoNo('txtENO_NM9_SHR','txtENO_NO9_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo9','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo9" name="ImgEnoNo9" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO9_SHR','txtENO_NM9_SHR')"></a>
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

</form>
<!-- form 끝 -->

</body>
</html>