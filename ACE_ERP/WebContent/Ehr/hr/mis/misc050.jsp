<!--
    ************************************************************************************
    * @Source         : misc050.jsp                                                    *
    * @Description    : 승진시뮬레이션 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/05 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>승진시뮬레이션(misc050)</title>
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

        var btnList  = 'TFFTTTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY  = document.getElementById("cmbPIS_YY_SHR").value;

            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }

            dsT_MI_PMTBASE.ClearData();

            dsT_MI_PMTBASE.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc050.cmd.MISC050CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY;
            dsT_MI_PMTBASE.Reset();

            form1.grdT_MI_PMTBASE.Focus();

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

            document.getElementById("cmbPIS_YY_SHR").selectedIndex = 0;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_MI_PMTBASE.ClearData();

            form1.cmbPIS_YY_SHR.value = PlanYear;
            document.getElementById("cmbPIS_YY_SHR").focus();

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
            cfStyleGrid(form1.grdT_MI_PMTBASE,0,"true","false");

            // 사업년도 및 대상기간 추출
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc050.cmd.MISC050CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();


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

        function fnc_BatchAdjust() {
            var PIS_YY  = document.getElementById("cmbPIS_YY_SHR").value;

            if (document.getElementById("cmbPIS_YY_SHR").value != PlanYear) {
                alert("사업년도가 익년 이외의 자료인 경우는 일괄반영처리를 할 수 없습니다!");
                return;
            }

            if (ProSts != "3") {
                alert("승진작업에 대한 일괄반영처리를 하실 수 없습니다.");
                return;
            }
            
            if(dsT_MI_PMTBASE.CountRow == 0) {
                alert("저장 할 자료가 없습니다.");
                return;
            }
            
            if(!confirm("승진대상자 일괄처리를 하시겠습니까?")) {
                return;
            }            


            dsT_MI_PMTBASE.UseChangeInfo = false;

            // 승진작업
            trT_MI_PMTBASE.KeyValue = "tr01(I:SAV=dsT_MI_PMTBASE, O:RELOAD=dsT_MI_PMTBASE_02)";
            trT_MI_PMTBASE.action = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc050.cmd.MISC050CMD&S_MODE=SAV&PIS_YY="+PIS_YY;
            trT_MI_PMTBASE.post();

            dsT_MI_PMTBASE.UseChangeInfo = true;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_PMTBASE)  |
    | 3. 사용되는 Table List(T_MI_PMTBASE)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_PMTBASE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_PMTBASE)  |
    | 3. 사용되는 Table List(T_MI_PMTBASE)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_PMTBASE_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


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
    | 2. 이름 : trT_MI_LEVYPLAN                     |
    | 3. Table List : T_MI_LEVYPLAN                 |
    +----------------------------------------------->
    <Object ID ="trT_MI_PMTBASE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_MI_PMTBASE)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_MI_PMTBASE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_MI_PMTBASE.CountRow );

            ProSts = dsT_MI_PMTBASE.NameValue(1, "PRO_STS");

            if (ProSts != '3') {
                document.form1.grdT_MI_PMTBASE.Editable = false;
            }
            else {
                document.form1.grdT_MI_PMTBASE.Editable = true;
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_MI_PMTBASE Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_PMTBASE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_MI_PMTBASE_02 Event="OnLoadCompleted(iCount)">

        /** 데이터셋 복사 **/
        cfCopyDataSet(dsT_MI_PMTBASE_02, dsT_MI_PMTBASE, "copyHeader=yes");

        ProSts = dsT_MI_PMTBASE.NameValue(1, "PRO_STS");

        if (ProSts != '3') {
            document.form1.grdT_MI_PMTBASE.Editable = false;
        }
        else {
            document.form1.grdT_MI_PMTBASE.Editable = true;
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_MI_PMTBASE_02 Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_PMTBASE_02 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        var oOption;
        var Index  = document.getElementById("cmbPIS_YY_SHR").length;

        if (iCount == 0)    {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = getToday().substr(0,4);
            oOption.text  = getToday().substr(0,4);
            document.getElementById("cmbPIS_YY_SHR").add(oOption);

        }
        else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 사업년도 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            //사업년도
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text  = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                document.getElementById("cmbPIS_YY_SHR").add(oOption);

            }

            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

            if (ProSts != '3') {
                document.form1.grdT_MI_PMTBASE.Editable = false;
            }
            else {
                document.form1.grdT_MI_PMTBASE.Editable = true;
            }

        }

        document.getElementById("cmbPIS_YY_SHR").focus();

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
    <script for=trT_MI_PMTBASE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_MI_PMTBASE event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    
    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script language=JavaScript for=grdT_MI_PMTBASE event=CanColumnPosChange(row,colid)>
        if(row > 0 && colid == "PMTPCT_NO") {
            var cnt     = parseInt(     dsT_MI_PMTBASE.NameValue(row, "T_CNT")       );
            var pct_no	= parseFloat (  dsT_MI_PMTBASE.NameValue(row, "PMTPCT_NO")   );
            
            dsT_MI_PMTBASE.NameValue(row, "P_CNT")   = Math.round(cnt * pct_no / 100);
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승진시뮬레이션</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">승진시뮬레이션</font></td>
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
                                <col width="65"></col>
                                <col width="60 "></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사업년도 </td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td>&nbsp;</td>
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
                    <td valign="bottom" class="searchState" width="700"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBatchAdjust','','/images/button/BatchAdjustOver.gif',1)">  <input type="image" style="border:0" src="/images/button/BatchAdjustOn.gif"  id="imgBatchAdjust"  name="imgBatchAdjust" width="80" height="20" border="0" align="absmiddle" onClick="fnc_BatchAdjust();return false;"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop5">
                         <comment id="__NSID__">
                         <object    id="grdT_MI_PMTBASE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                             <param name="DataID"                  value="dsT_MI_PMTBASE">
                             <param name="EdiTABLE"                value="true">
                             <param name="DragDropEnable"          value="true">
                             <param name="SortView"                value="Left">
                             <param name="VIEWSUMMARY"             value=0>
                             <param name="AutoReSizing"            value="true">
                             <param name="ColSizing"               value="true">
                             <param name="Format"                  value="
                                 <C> id='{currow}'          width=55         name='순번'            align=center    Edit='None'   </C>
                                 <C> id='PJOB_NM'           width=125        name='현직위'            align=center    Edit='None'   </C>
                                 <C> id='FJOB_NM'           width=125        name='대상직위'          align=center    Edit='None'   </C>
                                 <C> id='PMTPCT_NO'         width=95         name='승진율'          align=center    Dec=1         </C>
                                 <C> id='JOB_CNT'           width=95         name='현직위총인원'          align=center    Edit='None'   </C>
                                 <C> id='T_CNT'             width=95         name='대상자총인원'          align=center    Edit='None'   </C>
                                 <C> id='P_CNT'             width=95         name='대상인원'        align=center    Edit='None'   </C>
                                 <C> id='F_CNT'             width=95         name='승진인원'        align=center    Edit='None'   </C>
                             ">
                         </object>
                         </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


</form>
<!-- form 끝 -->

</body>
</html>

