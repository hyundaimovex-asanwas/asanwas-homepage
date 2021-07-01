<!--
    ************************************************************************************
    * @Source         : eisd020.jsp                                                    *
    * @Description    : 회의보고자료현황 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>회의보고자료현황(eisd020)</title>
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

        var btnList = 'TTFTFFFT';

        var bbs_gbn = "";              // 게시판구분 : 5: 회의보고자료현황(주간)
                                       //              6: 회의보고자료현황(월간)
                                       //              7: 회의보고자료현황(전략)
        var vGbn    = '';              // 검색조건 (1: 제목, 2: 내용, 3: 작성자)
        var vText   = '';              // 검색조건 내용

        var gbn     =  '';
        var title   =  '';
        var seq_no  =  '';
        var ref_no  =  '';
        var step_no =  '';
        var dept_no =  '';
        var eno_no  =  '';
        var eno_nm  =  '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var SUBJECT_TAG    = document.getElementById("txtSUBJECT_TAG_SHR").value;

            // 전체 조회
            if (bbs_gbn == "") {

                trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR_01&SUBJECT_TAG="+SUBJECT_TAG;
                trT_ED_BOARD.post();
            }
            // 신규 또는 수정창 닫을 시 해당 게시판구분으로 초기화
            // 주간
            else if (bbs_gbn == "5")  {

                dsT_ED_BOARD01.ClearData();

                dsT_ED_BOARD01.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=5&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD01.Reset();
            }
            // 월간
            else if (bbs_gbn == "6")  {

                dsT_ED_BOARD02.ClearData();

                dsT_ED_BOARD02.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=6&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD02.Reset();
            }
            // 전략
            else if (bbs_gbn == "7")  {

                dsT_ED_BOARD03.ClearData();

                dsT_ED_BOARD03.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.d.eisd020.cmd.EISD020CMD&S_MODE=SHR&BBS_GBN=7&SUBJECT_TAG="+SUBJECT_TAG;
                dsT_ED_BOARD03.Reset();
            }

            bbs_gbn = "";

            document.getElementById("txtSUBJECT_TAG_SHR").focus();

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

            var obj = new String();

            vGbn    = '';                     // 검색조건 (1: 제목, 2: 내용, 3: 작성자)
            vText   = '';                     // 검색조건 내용

            gbn     = "1";                    // 1: 등록, 2: 수정, 3: 답변
            title   = "등록";
            bbs_gbn = "";
            seq_no  = "";
            ref_no  = "";
            step_no = "0";
            dept_no = "0";
            eno_no  = '<%=box.get("SESSION_ENONO")%>';
            eno_nm  = '<%=box.get("SESSION_ENONM")%>';

            window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("txtSUBJECT_TAG_SHR").value = getToday().substr(0,4);

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_BOARD01.ClearData();
            dsT_ED_BOARD02.ClearData();
            dsT_ED_BOARD03.ClearData();

            document.getElementById("txtSUBJECT_TAG_SHR").focus();

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
            cfStyleGridEis(form1.grdT_ED_BOARD01,0,"false","false");
            cfStyleGridEis(form1.grdT_ED_BOARD02,0,"false","false");
            cfStyleGridEis(form1.grdT_ED_BOARD03,0,"false","false");

            document.getElementById("txtSUBJECT_TAG_SHR").value = getToday().substr(0,4);
<%
    if(box.getString("SESSION_SEL_AUTHO").equals("A")
            || box.getString("SESSION_SEL_AUTHO").equals("S")) {
%>
            document.getElementById("view_1").style.display='inline';
<%
    } else {
%>
            document.getElementById("view_1").style.display='none';
<%
    }
%>

            fnc_SearchList();

            document.getElementById("txtSUBJECT_TAG_SHR").focus();
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
         
        function fnc_DownloadFile() {
            var obj;
            type = document.getElementById("hidFILE_TYPE_CD").value;
            
            if(type == "1")
                obj = dsT_ED_BOARD01;
            else if(type == "2")
                obj = dsT_ED_BOARD02;
            else if(type == "3")
                obj = dsT_ED_BOARD03;
            else
                return;
            
            cfDownload(obj.NameValue(obj.RowPosition, "SRCFILE_NM"), obj.NameValue(obj.RowPosition, "TGTFILE_NM"));
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_BOARD)     |
    | 3. 사용되는 Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID ="trT_ED_BOARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(O:SHR_01=dsT_ED_BOARD01,O:SHR_02=dsT_ED_BOARD02,O:SHR_03=dsT_ED_BOARD03)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_BOARD01 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: 등록, 2: 수정, 3: 답변
        bbs_gbn = dsT_ED_BOARD01.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD01.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD01.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD01.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD01.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD01.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD01.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <Script For=grdT_ED_BOARD02 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: 등록, 2: 수정, 3: 답변
        bbs_gbn = dsT_ED_BOARD02.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD02.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD02.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD02.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD02.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD02.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD02.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <Script For=grdT_ED_BOARD03 Event="OnDblClick(row, col)">

        var obj = new String();

        gbn     = "2";                // 1: 등록, 2: 수정, 3: 답변
        bbs_gbn = dsT_ED_BOARD03.NameValue(row, "BBS_GBN");
        seq_no  = dsT_ED_BOARD03.NameValue(row, "SEQ_NO");
        ref_no  = dsT_ED_BOARD03.NameValue(row, "REF_NO");
        step_no = dsT_ED_BOARD03.NameValue(row, "STEP_NO");
        dept_no = dsT_ED_BOARD03.NameValue(row, "DEPT_NO");
        eno_no  = dsT_ED_BOARD03.NameValue(row, "ENO_NO");
        eno_nm  = dsT_ED_BOARD03.NameValue(row, "ENO_NM");

        window.showModalDialog("/hr/eis/eisd021.jsp", self, "dialogHeight:370px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD01 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* 자료가 조회되었습니다.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD02 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* 자료가 조회되었습니다.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD02 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD02 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD03 Event="OnLoadCompleted(iCount)">

        if (dsT_ED_BOARD01.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0 || dsT_ED_BOARD02.CountRow != 0)    {

            document.getElementById("resultMessage").innerText = '* 자료가 조회되었습니다.';

        }
        else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD03 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD03 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD01 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value    = "1";
            document.getElementById("txtFILE_TYPE").value       = "주 간";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD01.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=dsT_ED_BOARD02 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "2";
            document.getElementById("txtFILE_TYPE").value       = "월 간";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD02.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=dsT_ED_BOARD03 Event=OnRowPosChanged(row)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "3";
            document.getElementById("txtFILE_TYPE").value       = "전 략";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD03.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>
    
    
    
    <!-----------------------------------------------------+
    | Row 선택 후
    +------------------------------------------------------>
    <Script For=grdT_ED_BOARD01 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value    = "1";
            document.getElementById("txtFILE_TYPE").value       = "주 간";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD01.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=grdT_ED_BOARD02 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "2";
            document.getElementById("txtFILE_TYPE").value       = "월 간";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD02.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
    </Script>

    <Script For=grdT_ED_BOARD03 Event=OnClick(row,colid)>
        if(row > 0) {
            document.getElementById("hidFILE_TYPE_CD").value = "3";
            document.getElementById("txtFILE_TYPE").value       = "전 략";
            document.getElementById("txtFILE_NAME").value       = dsT_ED_BOARD03.NameValue(row, "SRCFILE_NM");
        } else {
            document.getElementById("hidFILE_TYPE_CD").value    = "";
            document.getElementById("txtFILE_TYPE").value       = "";
            document.getElementById("txtFILE_NAME").value       = "";
        }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">회의보고자료현황</td>
                    <td align="right" class="navigator">HOME/경영정보/기타현황/<font color="#000000">회의보고자료현황</font></td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            </div>
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
                    <td><img src="/images/common/eis_menu_bg_01.gif" width="7" height="7"></td>
                    <td height="7" background="/images/common/eis_menu_bg_02.gif"></td>
                    <td><img src="/images/common/eis_menu_bg_03.gif" width="7" height="7"></td>
                </tr>
                <tr>
                    <td width="7" background="/images/common/eis_menu_bg_04.gif">&nbsp;</td>
                    <td height="20">
                    
                    
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState" width="80">
                                    &nbsp;&nbsp;조회년&nbsp;
                                </td>
                                <td align="left" class="searchState">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtSUBJECT_TAG_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtSUBJECT_TAG_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtSUBJECT_TAG_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table> 
                                </td>
                            </tr>
                        </table>
                    
                    
                    </td>
                    <td width="7" background="/images/common/eis_menu_bg_04.gif">&nbsp;</td>
                </tr>
                <tr>
                    <td><img src="/images/common/eis_menu_bg_05.gif" width="7" height="7"></td>
                    <td height="7" background="/images/common/eis_menu_bg_02.gif"></td>
                    <td><img src="/images/common/eis_menu_bg_06.gif" width="7" height="7"></td>
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
        <td class="paddingTop8" align="right">
            <b>다운로드 :</b>
            <input id=txtFILE_TYPE name=txtFILE_TYPE size="5" class="input_ReadOnly" readonly>
            <input id=txtFILE_NAME name=txtFILE_NAME size="30" class="input_ReadOnly" readonly>
            <input type="hidden" id="hidFILE_TYPE_CD">
            <img src="/images/button/FileOpenOn.gif" id="btnFILE_OPEN" name="btnFILEOPEN" width="80" height="20" border="0" align="absmiddle" onClick="fnc_DownloadFile()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnFILEOPEN','','/images/button/FileOpenOver.gif',3)" style="cursor:hand;">
        </td>
    </tr>
    <tr>
        <td colspan="2" height="5"></td>
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
                        <object    id="grdT_ED_BOARD01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD01">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='주 간'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=100   name='날 짜'          align=center Suppress=1</C>
                                    <C> id='SEQ_NO'       width=39    name='SEQ'          align=center   </C>
                                    <C> id='SRCFILE_NM'   width=105   name='첨부문서'       align=left   </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD02">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='월 간'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=100   name='날 짜'          align=center Suppress=1</C>
                                    <C> id='SEQ_NO'       width=39    name='SEQ'          align=center   </C>
                                    <C> id='SRCFILE_NM'   width=105   name='첨부문서'       align=left   </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_BOARD03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:265px;height:400px;">
                            <param name="DataID"                  value="dsT_ED_BOARD03">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <G> name='전 략'  HeadBgColor='#f0f0f0'   HeadFontStyle=bold
                                    <C> id='SUBJECT_TAG'  width=140   name='날 짜'          align=center Suppress=1</C>
                                    <C> id='SRCFILE_NM'   width=105   name='첨부문서'       align=left   </C>
                                </G>
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