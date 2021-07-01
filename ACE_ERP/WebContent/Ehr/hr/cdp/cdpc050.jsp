<!--
    ************************************************************************************
    * @Source         : cdpc050.jsp                                                    *
    * @Description    : 후견인보고서현황 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/26 |  박인이   | 최초작성                                                *
    * 2007/04/17 |  김학수   | 인쇄추가                                                *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>후견인보고서현황(cdpc050)</title>
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
    
        var btnList = 'TTTTTTFT';
        var role_cd = '';
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var MENO_NO  = document.getElementById("txtMENO_NO_SHR").value;
            var MENO_NM  = document.getElementById("txtMENO_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            if (role_cd != "1001"
                    && rolce_cd != "1002") {
                alert("조회권한이 없습니다.");
                return;
            }
            
            // 후견인사번
            if( MENO_NO == '' ) {
                alert("후견인사번은 필수 입력사항입니다.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            if( MENO_NM == '' ) {
                alert("후견인사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            // 후견시작일자
            if( STR_YMD == '' ) {
                alert("후견기간 FROM일자는 필수 입력사항입니다.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            } 
            
            // 후견시작일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "후견기긴 FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }
            
            // 후견기간 TO일자
            if( END_YMD == '' ) {
                alert("후견기간 TO일자는 필수 입력사항입니다.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            } 
            
            // 후견기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "후견기간 TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }
            
            // 후견기간 FROM일자와 TO일자 비교
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("후견기간 FROM일자는 반드시 후견기간 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }
                    
            dsT_CD_MENTO.ClearData();
            
            dsT_CD_MENTO.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc050.cmd.CDPC050CMD&S_MODE=SHR&MENO_NO="+MENO_NO+"&ENO_NO="+ENO_NO+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD;
            dsT_CD_MENTO.Reset();
            
            form1.grdT_CD_MENTO.Focus();
            
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
            var MENO_NO  = document.getElementById("txtMENO_NO_SHR").value;
            var MENO_NM  = document.getElementById("txtMENO_NM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD  = document.getElementById("txtEND_YMD_SHR").value;
            
            if (role_cd != "1001"
                    && rolce_cd != "1002") {
                alert("조회권한이 없습니다.");
                return;
            }
            
            // 후견인사번
            if( MENO_NO == '' ) {
                alert("후견인사번은 필수 입력사항입니다.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            if( MENO_NM == '' ) {
                alert("후견인사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                document.getElementById("txtMENO_NO_SHR").focus();
                return false;
            }
            
            // 후견시작일자
            if( STR_YMD == '' ) {
                alert("후견기간 FROM일자는 필수 입력사항입니다.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            } 
            
            // 후견시작일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "후견기긴 FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }
            
            // 후견기간 TO일자
            if( END_YMD == '' ) {
                alert("후견기간 TO일자는 필수 입력사항입니다.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            } 
            
            // 후견기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "후견기간 TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }
            
            // 후견기간 FROM일자와 TO일자 비교
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("후견기간 FROM일자는 반드시 후견기간 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD").focus();
                    return false;
                }
            }
            var url = "cdpc050_PV.jsp?MENO_NO="+MENO_NO+"&ENO_NO="+ENO_NO+"&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");


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

            document.getElementById("txtMENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtMENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtENO_NO_SHR").value   = '';
            document.getElementById("txtENO_NM_SHR").value   = '';
            
            fnc_SetDateTerm();
            
            document.getElementById("resultMessage").innerText = ' ';
            
            dsT_CD_MENTO.ClearData();
            
            document.getElementById("txtMENO_NO_SHR").focus();

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
            cfStyleGrid(form1.grdT_CD_MENTO,0,"false","false");
            
            document.getElementById("txtMENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtMENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            
            fnc_SetDateTerm();
            
            // 로그인사번이 시스템권한을 가지고 있는지 확인
            dsT_CM_EMPLIST.ClearData();
            
            dsT_CM_EMPLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc050.cmd.CDPC050CMD&S_MODE=SHR_00&ENO_NO="+'<%=box.get("SESSION_ENONO")%>';
            dsT_CM_EMPLIST.Reset();
            
            document.getElementById("txtENO_NO_SHR").focus();
            
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
        
        // 후견기간 SET
        function fnc_SetDateTerm() {
            var dateinfo = getToday().split("-");
                
            //from - to 날짜값 설정하기
            var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);  
            var fromDate = null;
            var toDate   = null;
            
            fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));
            
            // FROM 일자
            document.getElementById("txtSTR_YMD_SHR").value = fnc_MakeDateString(fromDate);
            
            // TO 일자
            document.getElementById("txtEND_YMD_SHR").value = fnc_MakeDateString(toDate);

        }
         
        // DATE형을 STRING(YYYY-MM-DD)형태 일자로 변환
        function fnc_MakeDateString(date) {
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }
            
            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month + "-" + date
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)     |
    | 3. 사용되는 Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EMPLIST)   |
    | 3. 사용되는 Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CD_MENTO                        |
    | 3. Table List : T_CD_MENTO                    |
    +----------------------------------------------->
    <Object ID ="trT_CD_MENTO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_MENTO)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_MENTO.CountRow );
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

            // 시스템권한에 따른 후견인사번 enable 여부
            role_cd = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
           
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">후견인보고서현황</td>
                    <td align="right" class="navigator">HOME/교육관리/CDP/멘토링관리/<font color="#000000">후견인보고서현황</font></td>
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
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState">후견인사번</td>
                                <td class="padding2423"><input id=txtMENO_NO_SHR name=txtMENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtMENO_NO_SHR','txtMENO_NM_SHR','1','1');"> <input id=txtMENO_NM_SHR name=txtMENO_NM_SHR size="8" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMenoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMenoNo1" name="ImgMenoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtMENO_NO_SHR','txtMENO_NM_SHR','','','','','2')"></a>
                                </td> 
                                <td align="right" class="searchState">피후견인사번</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo1" name="ImgEnoNo1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','2')"></a>
                                </td>
                                <td align="right" class="searchState">후견기간</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '후견기간 FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~ 
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '후견기간 TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
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
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CD_MENTO" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"             value="dsT_CD_MENTO">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=40    name='순번'       align=center </C>
                                <G> name='피후견인' HeadBgColor='#F7DCBB'
                                    <C> id='DPT_NM'          width=80    name='소속'       align=left   </C>
                                    <C> id='JOB_NM'          width=60    name='직위'       align=center </C>
                                    <C> id='ENO_NO'          width=60    name='사번'       align=center </C>
                                    <C> id='ENO_NM'          width=60    name='성명'       align=center </C>
                                </G>
                                <G> name='후견인' HeadBgColor='#F7DCBB'
                                    <C> id='MDPT_NM'         width=80    name='소속'       align=left   </C>
                                    <C> id='MJOB_NM'         width=60    name='직위'       align=center </C>
                                    <C> id='MENO_NO'         width=60    name='사번'       align=center </C>
                                    <C> id='MENO_NM'         width=60    name='성명'       align=center </C>
                                </G>
                                <G> name='후견기간' HeadBgColor='#F7DCBB'
                                    <C> id='STR_YMD'         width=80    name='시작일자'   align=center </C>
                                    <C> id='END_YMD'         width=80    name='종료일자'   align=center </C>
                                </G>
                                <C> id='IPT_YMD'             width=80    name='작성일자'   align=center </C>
                                <C> id='OBJ_TXT'             width=220   name='목적'       align=left   </C>
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

