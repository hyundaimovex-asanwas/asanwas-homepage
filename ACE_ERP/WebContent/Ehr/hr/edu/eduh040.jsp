<!--
    ************************************************************************************
    * @Source         : eduh040.jsp                                                    *
    * @Description    : 훈련실시신고서 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/22  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>훈련실시신고서(eduh040)</title>
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

        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var EDU_STR_YMD  = document.getElementById("txtEDU_STR_YMD_SHR").value;
            var EDU_END_YMD  = document.getElementById("txtEDU_END_YMD_SHR").value;
            var EDU_CD       = document.getElementById("txtEDU_CD_SHR").value;

            if (EDU_STR_YMD == "") {
                alert("시작일을 입력하세요.");
                document.getElementById("txtEDU_STR_YMD_SHR").focus();
                return;
            }
            if (EDU_END_YMD == "") {
                alert("종료일을 입력하세요.");
                document.getElementById("txtEDU_END_YMD_SHR").focus();
                return;
            }

            // 시작일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEDU_STR_YMD_SHR"), "시작일") && document.getElementById("txtEDU_STR_YMD_SHR").value != "") {
                document.getElementById("txtEDU_STR_YMD_SHR").focus();
                return false;
            }

            dsT_ED_COURSELIST.ClearData();

            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh040.cmd.EDUH040CMD&S_MODE=SHR&EDU_STR_YMD="+EDU_STR_YMD+"&EDU_END_YMD="+EDU_END_YMD+"&EDU_CD="+EDU_CD;
            dsT_ED_COURSELIST.Reset();

            form1.grdT_ED_COURSELIST.Focus();

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
            
            if(dsT_ED_COURSELIST.CountRow == 0) {
                alert("대상 건이 없습니다.");
                return;
            }
            
            
            //출력 선택한 ROW가 하나라도 있는지 검증
            var isChk = false;
            for(var i=1; i<=dsT_ED_COURSELIST.CountRow; i++) {
                if(dsT_ED_COURSELIST.NameString(i, "CHK_YN") == "T") {
                    isChk = true;
                }
            }
            if(!isChk) {
                alert("출력을 하기위해 출력선택을 하나라도 선택해 주세요.");
                return;
            }
            
            
            //모두 insert 처리
            dsT_ED_COURSELIST.UseChangeInfo = "false";
            
            trT_ED_COURSELIST.KeyValue = "service_tr06(I:dsT_ED_COURSELIST=dsT_ED_COURSELIST)";
            trT_ED_COURSELIST.action   = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh040.cmd.EDUH040CMD"
                                       + "&S_MODE=SAV";
            trT_ED_COURSELIST.post();


            var url = "eduh040_PV.jsp";
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

            document.getElementById("txtEDU_STR_YMD_SHR").value = '';
            document.getElementById("txtEDU_CD_SHR").value = '';
            document.getElementById("txtEDU_NM_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_ED_COURSELIST.ClearData();

            //검색 조건 초기화
            document.getElementById("txtEDU_STR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtEDU_END_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-"+fnc_Lastday(getTodayArray()[0], getTodayArray()[1]);
            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
            cfStyleGrid(form1.grdT_ED_COURSELIST,0,"true","false");

            //검색 조건 초기화
            document.getElementById("txtEDU_STR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtEDU_END_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-"+fnc_Lastday(getTodayArray()[0], getTodayArray()[1]);
            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST) |
    | 3. 사용되는 Table List(T_ED_COURSELIST)        |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ED_COURSELIST                    |
    | 3. Table List : T_ED_COURSELIST                |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_COURSELIST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ED_COURSELIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">훈련실시신고서</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">훈련실시신고서</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="70"></col>
                                <col width="110"></col>
                                <col width="70"></col>
                                <col width="110"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">시작일 </td>
                                <td class="padding2423">
                                    <input id="txtEDU_STR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD_SHR','','20','120');"></a>
                                </td>
                                <td align="right" class="searchState">종료일 </td>
                                <td class="padding2423">
                                    <input id="txtEDU_END_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD_SHR','','20','120');"></a>
                                </td>
                                <td align="right" class="searchState">교육과정 </td>
                                <td class="padding2423">
                                    <input id=txtEDU_CD_SHR name=txtEDU_CD_SHR size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('Q1', 'txtEDU_CD_SHR','txtEDU_NM_SHR');"> <input id=txtEDU_NM_SHR name=txtEDU_NM_SHR size="20" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd1" name="ImgEduCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtEDU_CD_SHR','txtEDU_NM_SHR','교육과정','Q1')"></a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=79    name='순번'         align=center Edit='None' </C>
                                <C> id='EDU_STR_YMD'  width=100   name='훈련개시일'   align=center Edit='None' </C>
                                <C> id='EDU_END_YMD'  width=100   name='훈련종료일'   align=center Edit='None' </C>
                                <C> id='EDU_CD'       width=70   name='과정코드'     align=center Edit='None' </C>
                                <C> id='EDU_NM'       width=220   name='과정명'       align=left   Edit='None' </C>
                                <C> id='FIX_NO'       width=70   name='모집인원'         align=center Edit='None' </C>
                                <C> id='APP_NO'       width=70   name='참여인원'         align=center Edit='None' </C>
                                <C> id='CHK_YN'       width=70   name='출력선택'     align=center EditStyle='CheckBox' </C>
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

