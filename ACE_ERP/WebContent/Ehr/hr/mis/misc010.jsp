<!--
    ************************************************************************************
    * @Source         : misc010.jsp                                                    *
    * @Description    : 사업계획작업관리 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/02  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>사업계획작업관리(misc010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList  = 'TFTFFFFT';
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var Month    = getToday().substr(0,7);

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY = document.getElementById("txtPIS_YY_SHR").value;

            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("txtPIS_YY_SHR").focus();
                return;
            }


            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=SHR&PIS_YY="+PIS_YY;
            dsT_CP_WORKLOG.Reset();

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

            //이곳에 해당 코딩을 입력 하세요

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

            //모든 개체 비활성화
            fnc_DisableElementAll(elementList);

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CP_WORKLOG.ClearData();

            document.getElementById("txtPIS_YY_SHR").focus();

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
            //모든 개체 비활성화
            fnc_DisableElementAll(elementList);


            document.getElementById("txtPIS_YY_SHR").value = PlanYear;
            document.getElementById("txtPIS_YY_SHR").focus();

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



        /**
         * 작업상태의 값을 검증한다.
         */
        function fnc_check() {
            var PIS_YY      = document.getElementById("txtPIS_YY").value;
            var PAY_YMD     = document.getElementById("txtPAY_YMD").value;
            var APY_YMD     = document.getElementById("txtAPY_YMD").value;
            var PAY_YY      = PAY_YMD.substr(0,4);// 사업연도와 시작년월,종료년월 비교용

            if (PIS_YY == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YY").focus();
                return false;
            }

            if (PAY_YMD == "") {
                alert("대상기간 시작일자는 필수입력항목입니다.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            // 시작일자 CHECK
            if (!fnc_CheckDate2(PAY_YMD, "대상기간 시작일자") && PAY_YMD != "") {
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            if (PAY_YMD < Month) {
                alert("대상기간 시작년월는 현재년월보다 커야 합니다.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }
            else if (PAY_YY < PIS_YY - 1 || PAY_YMD > PIS_YY+'-01') {
                alert("대상기간 시작년월은 사업년도 1월이거나 이전 년월이어야 합니다.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }

            if (APY_YMD == "") {
                alert("대상기간 종료일자는 필수입력항목입니다.");
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            // 종료일자 CHECK
            if (!fnc_CheckDate2(APY_YMD, "대상기간 종료일자") && APY_YMD != "") {
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            if (APY_YMD != PIS_YY+'-12') {
                alert("대상기간 종료년월은 사업년도의 마지막달이어야 합니다.");
                document.getElementById("txtAPY_YMD").focus();
                return false;
            }

            // 시작일자와 종료일자 비교
            if( cfDateDiff(document.getElementById("txtPAY_YMD").value.replace(/\-/g,''),document.getElementById("txtAPY_YMD").value.replace(/\-/g,'')) < 0 ) {
                alert("시작일자가 종료일자보다 큽니다.");
                document.getElementById("txtPAY_YMD").focus();
                return false;
            }
            
            return true;
        }
        

        
        /**
         * 작업OPEN 을 시작합시다.
         * @param - sel_sts (PRO_STS  1:작업 open, 2:인원계획완료, 3:대상자선정, 4:승진완료, 5:승급완료, 6:급상여작업완료, 7:작업 close)
         */
        function fnc_PROSTS(sel_sts) {

            //유효성 검증
            if(sel_sts == 1 && !fnc_check()) {
                return;
            }
            
            var msg = " 작업을 하시겠습니까?";
            switch(sel_sts) {
                case 1: msg = "작업 OPEN"+msg; break;
                case 2: msg = "인원계획완료"+msg; break;
                case 3: msg = "대상자선정"+msg; break;
                case 4: msg = "승진완료"+msg; break;
                case 5: msg = "승급완료"+msg; break;
                case 6: msg = "급상여작업완료"+msg; break;
                case 7: msg = "작업 CLOSE"+msg; break;
            }
            
            if(!confirm(msg)) {
                return;
            }
            
            
            dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = sel_sts;

			trT_CP_WORKLOG.KeyValue = "SVL(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=PROC";
            trT_CP_WORKLOG.post();
        }


        /**
         * 재작업 처리
         */
        function fnc_PROSTS_RESET() {

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1, "PRO_STS")
            
            
            var msg = " 재작업하시겠습니까?";
            switch(PRO_STS) {
                case 2: msg = "인원계획완료"+msg; break;
                case 3: msg = "대상자선정"+msg; break;
                case 4: msg = "승진완료"+msg; break;
                case 5: msg = "승급완료"+msg; break;
                case 6: msg = "급상여작업완료"+msg; break;
            }
            
            if(!confirm(msg)) {
                return;
            }
            
            dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = fnc_covNumber(PRO_STS)-1;
            
            trT_CP_WORKLOG.KeyValue = "SVL(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_CP_WORKLOG.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc010.cmd.MISC010CMD&S_MODE=RESET";
            trT_CP_WORKLOG.post();

        }
        
        
        //입력 개체들
        var elementList = new Array(    "btnMISC01" 
                                       ,"btnMISC02" 
                                       ,"btnMISC03" 
                                       ,"btnMISC04" 
                                       ,"btnMISC05" 
                                       ,"btnMISC06" 
                                       ,"btnMISC07" 
                                       ,"btnMISC08" 
                                       ,"txtPIS_YY"
                                       ,"txtPAY_YMD"
                                       ,"txtAPY_YMD"
                                       ,"ImgPayYmd" 
                                       ,"ImgApyYmd"
                                       ,"img_spinup"
                                       ,"img_spindown" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CP_WORKLOG                      |
    | 3. Table List : T_CP_WORKLOG                  |
    +----------------------------------------------->
    <Object ID ="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CP_WORKLOG)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        fnc_DisableElementAll(elementList);
        
        document.getElementById("resultMessage").innerText = '';

        if (iCount == 0) {
            dsT_CP_WORKLOG.AddRow();
        
            //작업오픈이 가능하게        
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        
            fnc_ChangeStateElement(true, "txtPIS_YY");
            fnc_ChangeStateElement(true, "txtPAY_YMD");
            fnc_ChangeStateElement(true, "txtAPY_YMD");
            fnc_ChangeStateElement(true, "ImgPayYmd");
            fnc_ChangeStateElement(true, "ImgApyYmd");
            
            fnc_ChangeStateElement(true, "btnMISC01");
            
            document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;

        } else {


            switch (dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) {
                case "1" :  // 작업OPEN 완료상태
                    // 인원계획완료 버튼 활성화
                    fnc_ChangeStateElement(true, "btnMISC02");
                    
                    document.getElementById("resultMessage").innerText = '작업을 OPEN 하였습니다. ';

                    break;
                case "2" :  // 인원계획완료 완료상태
                    // 대상자선정 버튼 활성화
                    fnc_ChangeStateElement(true, "btnMISC03");
                    
                    //재작업
                    fnc_ChangeStateElement(true, "btnMISC08");
                    
                    document.getElementById("resultMessage").innerText = '인원계획을 완료하였습니다. ';

                    break;
                case "3" :  // 대상자선정 완료상태
                    // 승진완료 버튼 활성화
                    fnc_ChangeStateElement(true, "btnMISC04");
                    
                    //재작업
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;
                case "4" :  // 승진완료상태
                    // 승급완료 버튼 활성화
                    fnc_ChangeStateElement(true, "btnMISC05");
                    
                    //재작업
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "5" :  // 승급완료 상태
                    // 급상여작업완료 활성화
                    fnc_ChangeStateElement(true, "btnMISC06");
                    
                    //재작업
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "6" :  // 급상여작업완료 상태
                    // 작업CLOSE 비활성화
                    fnc_ChangeStateElement(true, "btnMISC07");
                    
                    //재작업
                    fnc_ChangeStateElement(true, "btnMISC08");

                    break;

                case "7" :  // 작업완료상태

                    break;
            }

        }

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

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
    
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_WORKLOG event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사업계획작업관리</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">사업계획작업관리</font></td>
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
                                <col width="100"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">사업년도&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup_shr" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown_shr" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>     
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="200"></col>
                    <col width="120"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                
                    <td class="creamBold" align="center">사업년도</td>
                    <td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </tr>
                        </table>     
                        
                        <input type=hidden id="txtSAL_GBN">
                        <input type=hidden id="txtPRO_STS">
                                    
                    </td> 
                    
                    
                    <td align="center" class="creamBold">대상기간</td>
                    <td class="padding2423">
                        <input id="txtPAY_YMD" name="txtPAY_YMD" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '대상기간 FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPayYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPayYmd" name="ImgPayYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPAY_YMD','','340','110');"></a> ~
                        <input id="txtAPY_YMD" name="txtAPY_YMD" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '대상기간 TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgApyYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgApyYmd" name="ImgApyYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtAPY_YMD','','457','110');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<table>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="194"></col>
	                            <col width="194"></col>
	                            <col width="194"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC01"  style="cursor:hand;width:110pt;height:25pt;" value=" 작업 OPEN "      onclick="fnc_PROSTS(1)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC02"  style="cursor:hand;width:110pt;height:25pt;" value=" 인원계획완료 "   onclick="fnc_PROSTS(2)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC03"  style="cursor:hand;width:110pt;height:25pt;" value=" 대상자선정 "     onclick="fnc_PROSTS(3)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC04"  style="cursor:hand;width:110pt;height:25pt;" value=" 승진완료 "       onclick="fnc_PROSTS(4)">
                                </td>
                            </tr>
                            <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC05"  style="cursor:hand;width:110pt;height:25pt;" value=" 승급완료"        onclick="fnc_PROSTS(5)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC06"  style="cursor:hand;width:110pt;height:25pt;" value=" 급상여작업완료 " onclick="fnc_PROSTS(6)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC07"  style="cursor:hand;width:110pt;height:25pt;" value=" 작업 CLOSE "     onclick="fnc_PROSTS(7)">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMISC08"  style="cursor:hand;width:110pt;height:25pt;" value=" 재작업 "         onclick="fnc_PROSTS_RESET()">
                                </td>
	                        </tr>
	                    </table>
	                <td>
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


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_WORKLOG">
    <Param Name="BindInfo", Value='
        <C> Col=SAL_GBN       Ctrl=txtSAL_GBN       Param=value </C>
        <C> Col=PRO_STS       Ctrl=txtPRO_STS       Param=value </C>
        <C> Col=PIS_YY        Ctrl=txtPIS_YY        Param=value </C>
        <C> Col=PAY_YMD       Ctrl=txtPAY_YMD       Param=value </C>
        <C> Col=APY_YMD       Ctrl=txtAPY_YMD       Param=value </C>
    '>
</object>