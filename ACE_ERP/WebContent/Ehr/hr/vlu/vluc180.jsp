<!--
*****************************************************
* @source       : vluc180.jsp
* @description : 본부장조정_성과 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/11      오대성        최초작성.
* 2007/03/18      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>본부장조정_성과(vluc180)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var CHG_CHK  = "0";

            if(form1.chkCHG_CHK_SHR.checked){
                CHG_CHK = "1";
            } else {
                CHG_CHK = "0";
            }

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

            //데이터셋 전송
            dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&EVL_GBN=2&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbHEAD_CD_SHR="+document.getElementById("cmbHEAD_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value+"&CHG_CHK="+CHG_CHK;
            dsT_EV_ABLRST.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //현재 평가적용기간에 해당하는 년도,회차 정보
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //트랜잭션 전송
            trT_EV_ABLRST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SAV";
            trT_EV_ABLRST.Post();

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("본부장등급조정", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("삭제 할 자료가 없습니다.");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_ABLRST.NameValue(dsT_EV_ABLRST.RowPosition,'ENO_NO') + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_ABLRST.DeleteRow(dsT_EV_ABLRST.RowPosition);

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_ABLRST.SetColumn("ENO_NO");
            form1.grdT_EV_ABLRST.Focus();

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM_SHR.value = '';
            f.cmbHEAD_CD_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

            dsT_EV_ABLRST.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("btnReflect").disabled=false;

            f.txtENO_NO_SHR.focus();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
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

            if ( dsT_EV_ABLRST.isUpdated ) {

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

            cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","false");      // Grid Style 적용

            //본부 콤보
            var oOption;
            for( i=1; i<=dsCOMMON_B2.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text = dsCOMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);
            }

            // 업무구분
            if (frameid == "vluc180") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

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

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";

            }

            //평가 기준 구조 설정 정보 조회
            fnc_SearchItem();

            document.form1.txtENO_NO_SHR.focus();

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 일괄반영 작업 처리 부분  *
         *******************************************/
        function fnc_Reflect() {

            if(confirm("기존에 적용된 본부장 조정 자료는 모두 초기화 됩니다.\n\n그래도 적용 하시겠습니까?")) {

                dsT_EV_ABLRST_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,'EVL_YY')+"&EVL_GBN=2&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,'EVL_FRQ');
                dsT_EV_ABLRST_02.Reset();

            } else {
                return;
            }

        }

        /********************************************
         * 16. 조건에 따른 enable/disable 처리    *
         *******************************************/
        function fnc_EnableDisableSet( div ) {

            //Enable처리
            if( div == '1' ) {
                document.getElementById("image3").disabled=false;
                document.getElementById("btnReflect").disabled=false;
                form1.grdT_EV_ABLRST.Editable='true';
            }
            //Disable처리
            if( div == '2' ) {
                document.getElementById("image3").disabled=true;
                document.getElementById("btnReflect").disabled=true;
                form1.grdT_EV_ABLRST.Editable='false';
            }

        }

        /********************
         * 17. 단축키 처리  *
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

    <Object ID="dsT_EV_ABLRST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

    <Object ID ="trT_EV_ABLRST_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST_01)">
    </Object>

    <!-- 본부 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"  value="B2"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
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
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ABLRST.CountRow);

            if( dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") == 'T' ) {
                //버튼 불가처리
                fnc_EnableDisableSet('2');
                document.getElementById("resultMessage").innerText = '* 본부장 등급 조정이 확정되었으므로 수정 불가합니다.';
                alert("본부장 등급 조정이 확정되었으므로 수정 불가합니다.");
            } else {
                //버튼 가능처리
                fnc_EnableDisableSet('1');
            }

        }

           grdT_EV_ABLRST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_ABLRST_02 Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

            // 수정데이터가 존재하지 않는 경우
            if (dsT_EV_ABLRST_02.NameValue(1, "CNT") == "0") {
                document.getElementById("resultMessage").innerText = '* 일괄반영 대상이 존재하지 않습니다.';
                alert("일괄반영 대상이 존재하지 않습니다.");

                return;
            }

            // FEED BACK 여부 체크하여 FEED BACK 되었다면 일괄생성하지 않음
            if (dsT_EV_ABLRST_02.NameValue(2, "CNT") != "0") {
                document.getElementById("resultMessage").innerText = '* 본부장 등급 조정이 확정되었으므로 수정 불가합니다.';
                alert("본부장 등급 조정이 확정되었으므로 수정 불가합니다.");

                return;
            }

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_ABLRST_01.CountColumn == 0) {
                dsT_EV_ABLRST_01.setDataHeader("EVL_YY:STRING");
            }
            dsT_EV_ABLRST_01.AddRow();
            //일괄 적용을 위해 DateSet의 UserStatus를 임의로 변경한다.
            dsT_EV_ABLRST_01.UserStatus(1) = 1;

            trT_EV_ABLRST_01.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,'EVL_YY')+"&EVL_GBN=2&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,'EVL_FRQ');
            trT_EV_ABLRST_01.post();
            fnc_SearchList();
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("평가적용기간이 아닙니다.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST_02 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST_02 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST_01 event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST_01 event="OnFail()">

        if (trT_EV_ABLRST_01.ErrorCode != 50015) {
            document.getElementById("resultMessage").innerText = ' ';
            cfErrorMsg(this);
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">본부장조정_성과</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">본부장조정_성과</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="50"></col>
                                    <col width="50"></col>
                                    <col width="30"></col>
                                    <col width="90"></col>
                                    <col width="100"></col>
                                    <col width="60"></col>
                                    <col width="110"></col>
                                    <col width="70"></col>
                                    <col width="170"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도&nbsp;</td>
                                    <td><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR style="width 100%;text-align:center;" size="4" class="input_ReadOnly" readonly valid="key=true" field="해당년도"></td>
                                    <td align="right" class="searchState">회차&nbsp;</td>
                                    <td class=""><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="4" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchState">평가그룹&nbsp;</td>
                                    <td class="">
                                        <input type="hidden" id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR">
                                        <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>전 체</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">본부&nbsp;</td>
                                    <td class="">
                                        <select id="cmbHEAD_CD_SHR" name="cmbHEAD_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>전 체</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">사번&nbsp;</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right" class="searchState">
                            <input type="checkbox" name="chkCHG_CHK_SHR" id=chkCHG_CHK_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()">조정인원
                        </td>
                        <td align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnReflect','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btnReflect" name="btnReflect" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <!--
        <tr>
            <td class="paddingTop8" style="padding-top:1">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>
            </td>
        </tr>
         -->

        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                            value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                        value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"              value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                            value="
                                    <C> id='EVL_YY'     width=40   name='EVL_YY'    align=center    show=false </C>
                                    <C> id='EVL_GBN'    width=40   name='EVL_GBN'   align=center    show=false </C>
                                    <C> id='EVL_FRQ'    width=40   name='EVL_FRQ'   align=center    show=false </C>
                                    <C> id='GROUP_NM'   width=100  name='평가그룹'  align=left      edit=none </C>
                                    <C> id='HEAD_NM'    width=104  name='본부'      align=left      edit=none </C>
                                    <C> id='DPT_NM'     width=100  name='소속'      align=left      edit=none </C>
                                    <C> id='JOB_NM'     width=100  name='직위'      align=left      edit=none </C>
                                    <C> id='ENO_NO'     width=80   name='사번'      align=center    edit=none </C>
                                    <C> id='ENO_NM'     width=80   name='성명'      align=center    edit=none </C>
                                    <C> id='RNUM'       width=40   name='순위'      align=center    edit=none </C>
                                    <C> id='CHANGE_GRD' width=60   name='최초등급'  align=center    edit=none </C>
                                    <C> id='CHIEP_GRD'  width=100  name='본부장조정등급'  align=center    editstyle=combo    data='S:S,A:A,B:B,C:C,D:D' bgcolor={Decode(CHIEP_GRD,CHANGE_GRD,'#FFFFFF',NULL,'#FFFFFF','#F2AC47')}</C>
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