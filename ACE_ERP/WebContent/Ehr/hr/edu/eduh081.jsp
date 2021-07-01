<!--
    ************************************************************************************
    * @Source         : eduh081.jsp                                                    *
    * @Description    : 예외자관리_신규등록 PAGE                                       *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>예외자관리_신규등록(eduh081)</title>
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

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_EXCEPTER.ClearData();

            dsT_ED_EXCEPTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh081.cmd.EDUH081CMD&S_MODE=SHR&STR_YMD="+opener.str_ymd+"&ENO_NO="+opener.eno_no;
            dsT_ED_EXCEPTER.Reset();

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

            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_ED_EXCEPTER.KeyValue = "tr01(I:SAV=dsT_ED_EXCEPTER)";
            trT_ED_EXCEPTER.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh081.cmd.EDUH081CMD&S_MODE=SAV";
            trT_ED_EXCEPTER.post();


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

            //이곳에 해당 코딩을 입력 하세요

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

            if (!dsT_ED_EXCEPTER.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_EXCEPTER.isUpdated) {
                for( i = 1; i <= dsT_ED_EXCEPTER.CountRow; i++ ) {
                    if( dsT_ED_EXCEPTER.RowStatus(i) == 1 ||
                        dsT_ED_EXCEPTER.RowStatus(i) == 3 ) {

                        // 시작일
                        if( dsT_ED_EXCEPTER.NameValue(i, "STR_YMD") == '' ) {
                            alert("시작일은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // 예외구분
                        if( dsT_ED_EXCEPTER.NameValue(i, "EXC_CD") == '' ) {
                            alert("예외구분는 필수 입력사항입니다.");
                            document.getElementById("cmbEXC_CD").focus();
                            return false;
                        }

                        // 사번
                        if( dsT_ED_EXCEPTER.NameValue(i, "ENO_NO") == '' ) {
                            alert("사번은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // 사번 CHECK
                        if (dsT_ED_EXCEPTER.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_EXCEPTER.NameValue(i, "ENO_NM") == "") {
                            alert("사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
                            dsT_ED_EXCEPTER.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }

                        // 이수점수
                        if( dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") == ''  ||
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") == 0) {
                            alert("이수점수는 필수 입력사항입니다.");
                            document.getElementById("txtCPT_PNT").focus();
                            return false;
                        }

                        // 이수점수
                        // 이수점수가 4점 이하이면 최하 입력 가능값인 4점으로 등록
                        if (dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") < 4) {
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") = 4;
                        }
                        // 이수점수가 6점보다 크면 최상 입력 가능값인 6점으로 등록
                        else if (dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") > 6) {
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") = 6;
                        }

                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oOption = null;

            //예외구분
            for( var i = 1; i <= dsCOMMON_QD.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QD.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QD.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEXC_CD").add(oOption);

            }

            // 구분이 수정이면
            if (opener.gbn == "2") {

                document.getElementById('txtSTR_YMD').value = opener.str_ymd;
                document.getElementById('txtEND_YMD').value = opener.end_ymd;
                document.getElementById('cmbEXC_CD').value = opener.exc_cd;

                document.getElementById('txtENO_NO').value = opener.eno_no;
                document.getElementById('txtENO_NM').value = opener.eno_nm;

                document.getElementById('txtREMARK').value = opener.remark;

                // 공지사항 데이터 조회
                fnc_SearchList();
            }
            else {

                fnc_ColEnabled('E');

                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_EXCEPTER.CountColumn == 0) {
                    dsT_ED_EXCEPTER.setDataHeader("STR_YMD:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, ENO_NM:STRING, EXC_CD:STRING, CPT_PNT:INT, END_YMD:STRING, REMARK:STRING");
                }

                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_EXCEPTER.AddRow();

                //dsT_ED_EXCEPTER.NameValue(1, "STR_YMD")  = getToday();

                ///////////////////////////////////////////////////////////////
                // 해당년도 예외자에 대한 이수점수는 최하 4점을 기준으로 입력
                // 최대 6점까지 입력 가능함...
                ///////////////////////////////////////////////////////////////
                dsT_ED_EXCEPTER.NameValue(1, "CPT_PNT") = 4;

                document.getElementById('txtSTR_YMD').focus();
            }

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_EXCEPTER.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("cmbEXC_CD").disabled  = false;
                document.getElementById("txtENO_NO").disabled  = false;
                document.getElementById("txtENO_NM").disabled  = false;
                document.getElementById("txtCPT_PNT").disabled = false;
                document.getElementById("txtREMARK").disabled = false;

                document.getElementById("ImgEnoNo").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("cmbEXC_CD").disabled  = true;
                document.getElementById("txtENO_NO").disabled  = true;
                document.getElementById("txtENO_NM").disabled  = true;
                document.getElementById("txtCPT_PNT").disabled = true;
                document.getElementById("txtREMARK").disabled = true;

                document.getElementById("ImgEnoNo").disabled   = true;

            }
        }

        //지나간 날짜인지 체크
        function fnc_ChkDate() {

            var STR_YMD = document.getElementById("txtSTR_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(STR_YMD != ""){
                if(STR_YMD <= today){
                    alert("이미 지나간 일자는 등록할수 없습니다.");
                    document.getElementById("txtSTR_YMD").value = "";
                    document.getElementById("txtSTR_YMD").focus();
                    return false;
                }
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_EXCEPTER)|
    | 3. 사용되는 Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_EXCEPTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_EXCEPTER)|
    | 3. 사용되는 Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_EXCEPTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_EXCEPTER)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 예외구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QD"/>
       <jsp:param name="CODE_GUBUN"    value="QD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_EXCEPTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_EXCEPTER.CountRow );

            fnc_ColEnabled('E');

            document.getElementById("txtSTR_YMD").disabled  = true;
            document.getElementById("txtENO_NO").disabled  = true;

            document.getElementById("ImgEnoNo").disabled   = true;
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnDataError()">

        cfErrorMsg(this);

    </Script>



    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_EXCEPTER event="OnSuccess()">
        fnc_Exit();
    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_EXCEPTER event="OnFail()">
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
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">예외자관리_신규등록</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="240"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">해당기간</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','20','100');"></a> ~
                        <input id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','160','100');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">예외구분</td>
                    <td class="padding2423" >
                        <select id="cmbEXC_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">비고</td>
                    <td class="padding2423" >
                        <input id="txtREMARK"  name="txtREMARK" style="ime-mode:disabled;text-align:left;" size="39" maxlength="100">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">대 상 자</td>
                    <td class="padding2423">
                        <input id="txtENO_NO"  name="txtENO_NO" style="ime-mode:disabled;" size="10"  maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM','1');"  onChange="fnc_GetEnoNm('txtENO_NO','txtENO_NM','1','1');">
                        <input id="txtENO_NM" name="txtENO_NM" size="20" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO','1');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO','1');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">이수점수</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="ime-mode:disabled;text-align:right;" size="5" maxlength="2" onKeyPress="cfNumberCheck();" > 점
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
<!-- 평가대상자설정 테이블 -->
<object id="bndT_ED_EXCEPTER"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_EXCEPTER">
    <Param Name="BindInfo", Value='
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value </C>
        <C>Col=END_YMD      Ctrl=txtEND_YMD      Param=value </C>
        <C>Col=EXC_CD       Ctrl=cmbEXC_CD       Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=REMARK       Ctrl=txtREMARK       Param=value </C>
    '>
</object>