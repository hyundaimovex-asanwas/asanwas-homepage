<!--
    ************************************************************************************
    * @Source         : eduh053.jsp                                                    *
    * @Description    : 담당과정운영_실적현황관리 PAGE                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/07  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>

    <head>
    <title>담당과정운영_실적현황관리(eduh053)</title>
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

        var opener = window.dialogArguments;
        var flag   = '';                       // 0: 조회, 1: 저장

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var JOB_CD  = document.getElementById("txtJOB_CD_SHR").value;


            dsT_CM_EDUCATION.ClearData();
            dsT_ED_CHASULIST.ClearData();

            trT_CM_EDUCATION_SHR.KeyValue = "SVL(O:SHR=dsT_ED_CHASULIST, O:SHR2=dsT_CM_EDUCATION)";
            trT_CM_EDUCATION_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD"
                                        + "&S_MODE=SHR"
                                        + "&EDU_CD="+opener.edu_cd
                                        + "&SEQ_NO="+opener.seq_no
                                        + "&ENO_NO="+ENO_NO
                                        + "&DPT_CD="+DPT_CD
                                        + "&JOB_CD="+JOB_CD
                                        + "&COMM_NO="+opener.comm_no;
            trT_CM_EDUCATION_SHR.post();

            form1.grdT_CM_EDUCATION.Focus();

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

            if(fnc_SaveItemCheck()) {
                dsT_CM_EDUCATION.UseChangeInfo = false;

                trT_CM_EDUCATION.KeyValue = "SVL(I:dsT_CM_EDUCATION=dsT_CM_EDUCATION)";
                trT_CM_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD&S_MODE=SAV"+"&COMM_NO="+opener.comm_no;
                trT_CM_EDUCATION.post();

                dsT_CM_EDUCATION.UseChangeInfo = true;

            } else {

                return;
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

            if (dsT_CM_EDUCATION.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("실적현황관리", '', 225);

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
            if (dsT_CM_EDUCATION.IsUpdated) {
                if (!fnc_ClearQuestion()) return;
            }

            document.getElementById("txtEDU_CD").value      = "";
            document.getElementById("txtEDU_NM").value      = "";
            document.getElementById("txtSEQ_NO").value   = "";
            document.getElementById("txtPLACE_NM").value    = "";
            document.getElementById("txtEDU_STR_YMD").value = "";
            document.getElementById("txtEDU_END_YMD").value = "";
            document.getElementById("txtINT_NAM").value     = "";
            form1.medCOST_AMT.text                          = "";
            document.getElementById("txtFIX_NO").value      = "";
            document.getElementById("txtINS_NM").value      = "";
            form1.medSUM_AMT.text                           = "";
            document.getElementById("txtCONTENT_TXT").value = "";

            dsT_CM_EDUCATION.ClearData();
            dsT_ED_CHASULIST.ClearData();

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("txtJOB_CD_SHR").value = "";
            document.getElementById("txtJOB_NM_SHR").value = "";

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

   /*         if (!dsT_CM_EDUCATION.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
   */

            if ( dsT_CM_EDUCATION.isUpdated) {
                for( i = 1; i <= dsT_CM_EDUCATION.CountRow; i++ ) {
                    if( dsT_CM_EDUCATION.RowStatus(i) == 1 ||
                        dsT_CM_EDUCATION.RowStatus(i) == 3 ) {

                        // 점수
                        /*
                        if( dsT_CM_EDUCATION.NameValue(i, "APP_VAL") == ''  && dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == 'Y') {
                            alert("점수는 필수 입력사항입니다.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("APP_VAL");
                            return false;
                        }
                        */

                        // 수료여부
                        if( dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == '' ) {
                            alert("수료여부는 필수 입력사항입니다.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("EDU_TAG");
                            return false;
                        }

                        // 미수료사유
                        /*
                        if( dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == 'N' && dsT_CM_EDUCATION.NameValue(i, "REASON_TAG") == '' ) {
                            alert("수료여부가 미수료이면 미수료사유는 필수입력항목입니다.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("REASON_TAG");
                            return false;
                        }
                        */

                        if (dsT_CM_EDUCATION.NameValue(i, 'EDU_TAG') == 'Y') {
                            dsT_CM_EDUCATION.NameValue(i, 'REASON_TAG') = '';
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

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_EDUCATION,0,"true","false");

            form1.grdT_CM_EDUCATION.DragDropEnable  = "false";


            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CM_EDUCATION.IsUpdated)
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


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /**
         * EXCEL 파일 업로드
         */
        function fnc_FileUpload() {
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var JOB_CD  = document.getElementById("txtJOB_CD_SHR").value;

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
                dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){
                dsT_CM_EDUCATION.ClearData();

                trFILE_UPLOAD.KeyValue  = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_CM_EDUCATION=dsT_CM_EDUCATION, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action    = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD"
                                        + "&S_MODE=ULD"
                                        + "&EDU_CD="+opener.edu_cd
                                        + "&SEQ_NO="+opener.seq_no
                                        + "&COMM_NO="+opener.comm_no
                                        + "&ENO_NO="+ENO_NO
                                        + "&DPT_CD="+DPT_CD
                                        + "&JOB_CD="+JOB_CD;
                trFILE_UPLOAD.post();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION) |
    | 3. 사용되는 Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 결과 DS -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_EDUCATION                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_CM_EDUCATION_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!-------------------------------------------------+
    | 수료여부 값 변경시 미수료사유 값 SET             |
    +-------------------------------------------------->
    <script language=JavaScript for=dsT_CM_EDUCATION event=onColumnChanged(row,colid)>

        if (colid == 'EDU_TAG') {

            dsT_CM_EDUCATION.NameValue(row, 'REASON_TAG') = '';

        }

    </script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow );

        }

    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
        if (iCount > 0) {
            document.getElementById("txtEDU_CD").value      = dsT_ED_CHASULIST.NameValue(1, "EDU_CD");
            document.getElementById("txtEDU_NM").value      = dsT_ED_CHASULIST.NameValue(1, "EDU_NM");
            document.getElementById("txtSEQ_NO").value      = dsT_ED_CHASULIST.NameValue(1, "SEQ_NO");
            document.getElementById("txtPLACE_NM").value    = dsT_ED_CHASULIST.NameValue(1, "PLACE_NM");
            document.getElementById("txtEDU_STR_YMD").value = dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD");
            document.getElementById("txtEDU_END_YMD").value = dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD");
            document.getElementById("txtINT_NAM").value     = dsT_ED_CHASULIST.NameValue(1, "INT_NAM");
            form1.medCOST_AMT.text                          = dsT_ED_CHASULIST.NameValue(1, "COST_AMT");
            document.getElementById("txtFIX_NO").value      = dsT_ED_CHASULIST.NameValue(1, "FIX_NO");
            document.getElementById("txtINS_NM").value      = dsT_ED_CHASULIST.NameValue(1, "INS_NM");
            form1.medSUM_AMT.text                           = dsT_ED_CHASULIST.NameValue(1, "SUM_AMT");
            document.getElementById("txtCONTENT_TXT").value = dsT_ED_CHASULIST.NameValue(1, "CONTENT_TXT");
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EDUCATION event="OnSuccess()">

        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EDUCATION event="OnFail()">

        cfErrorMsg(this);

    </script>


    <!-------------------------+
    | Grid 의 CheckBox 클릭시  |
    +-------------------------->
	<script language="javascript"  for=grdT_CM_EDUCATION event=OnClick(row,colid)>

		if(colid == 'CONFIRM' && row != '0'){
            if(!(dsT_CM_EDUCATION.NameValue(row,colid) == "T" && dsT_CM_EDUCATION.RowStatus(row) == "1")) {
    			if(dsT_CM_EDUCATION.NameValue(row,colid) == "T") {
    				dsT_CM_EDUCATION.NameValue(row,'EDU_TAG') = 'Y';
    	    	} else if(dsT_CM_EDUCATION.NameValue(row,colid) == "F") {
    				dsT_CM_EDUCATION.NameValue(row,'EDU_TAG') = 'N';
    	    	}
            }
    	}
	</script>

    <!-----------------------------------------------------+
    | Grid Head Check event 처리                           |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_CM_EDUCATION event=OnHeadCheckClick(Col,Colid,bCheck)>

        var bCheckValue = "";
        if(bCheck == 1){
            bCheckValue = "T";
        }else{
            bCheckValue = "F";
        }

        for(var i=1; i<=dsT_CM_EDUCATION.CountRow; i++) {
            if(!(dsT_CM_EDUCATION.NameValue(i, "CONFIRM") == "T"
                    && dsT_CM_EDUCATION.RowStatus(i) == "1")) {

                dsT_CM_EDUCATION.NameValue(i, "CONFIRM") = bCheckValue;

                if(dsT_CM_EDUCATION.NameValue(i, "CONFIRM") == "T") {
                    dsT_CM_EDUCATION.NameValue(i,'EDU_TAG') = 'Y';
                } else if(dsT_CM_EDUCATION.NameValue(i,"CONFIRM") == "F") {
                    dsT_CM_EDUCATION.NameValue(i,'EDU_TAG') = 'N';
                }

                    dsT_CM_EDUCATION.NameValue(i, "CONFIRM") = bCheckValue;
            }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">담당과정운영_실적현황관리</td>
                    <td align="right" class="navigator"></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="ImgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
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
                                <col width="80"></col>
                                <col width="180"></col>
                                <col width="80"></col>
                                <col width="140"></col>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td class="searchState" align="right">소속별&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" size="3" maxlength="2"> <input id="txtDPT_NM_SHR" size="10" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                                <td class="searchState" align="right">직위별&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtJOB_CD_SHR" size="3" maxlength="2"> <input id="txtJOB_NM_SHR" size="10" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
                                </td>
                            </tr>
                            <input type=hidden id="txtCHK" name="txtCHK">
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
                    <td width="80" style="padding-right:5px; padding-top:1px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('eduh053.xls', '<%=FILEURL %>/eduh053.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:1px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
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
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <col width="80 "></col>
                    <col width="188"></col>
                    <col width="80 "></col>
                    <col width="186"></col>
                    <col width="80 "></col>
                    <col width="186"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >교육과정</td>
                    <td class="padding2423" align="left">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="5"  class="input_ReadOnly" readonly> <input id="txtEDU_NM" name="txtEDU_NM" size="21" class="input_ReadOnly"  readOnly>
                        <input type=hidden id="hidCOMM_NO">
                    </td>
                    <td align="center" class="creamBold" >차&nbsp;&nbsp;&nbsp;&nbsp;수</td>
                    <td class="padding2423" align="left">
                        <input id="txtSEQ_NO" name="txtSEQ_NO" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">교육구분</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_NM" name="txtPLACE_NM" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육일정</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">교육기관</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM" name="txtINT_NAM" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">교육비용</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">인&nbsp;&nbsp;&nbsp;&nbsp;원</td>
                    <td class="padding2423">
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="60" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">환급여부</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">실 비 용</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육내용</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="115" rows="5" maxlength="300" readonly></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object  id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'           align=center Edit='None' </C>
                                <C> id='ENO_NO'       width=70    name='사번'           align=center Edit='None' </C>
                                <C> id='ENO_NM'       width=65    name='성명'           align=center Edit='None' </C>
                                <C> id='DPT_NM'       width=90    name='소속'           align=left   Edit='None' </C>
                                <C> id='JOB_NM'       width=50    name='직위'           align=center Edit='None' </C>
                                <C> id='CET_NO'       width=100   name='주민번호'       align=center Edit='None' </C>
                                <C> id='APP_VAL'      width=60    name='점수'           align=center   </C>
                                <C> id='CONFIRM'      width=50    name='수료;확인'      align=center HeadCheckShow=true EditStyle=CheckBox Pointer=Hand </C>
                                <C> id='EDU_TAG'      width=70    name='수료여부'       align=center Value={DECODE(EDU_TAG,'Y','수료','미수료')}  </C>
                                <C> id='REASON_TAG'   width=180   name='미수료사유'     align=left   </C>
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