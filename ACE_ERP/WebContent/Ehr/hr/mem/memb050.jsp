<!--
    ************************************************************************************
    * @Source         : memb050.jsp                                                    *
    * @Description    : 용역비지급기준 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/12  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>용역비지급기준(memb050)</title>
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
    
        var btnList = 'TFFTFTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var DISJOB_CD  = document.getElementById("txtDISJOB_CD_SHR").value;
            var KIJUN_YMD  = document.getElementById("txtKIJUN_YMD_SHR").value;
            
            if (KIJUN_YMD == "") {
                alert("기준년월일은 필수입력항목입니다.");
                document.getElementById("txtKIJUN_YMD_SHR").focus();
                return;
            }

            // 기준년월일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtKIJUN_YMD_SHR"), '기준년월일')) {
                document.getElementById("txtKIJUN_YMD_SHR").focus();
                return;
            }
            
            dsT_ME_DISBASMST.ClearData();
            
            dsT_ME_DISBASMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb050.cmd.MEMB050CMD&S_MODE=SHR&DISJOB_CD="+DISJOB_CD+"&KIJUN_YMD="+KIJUN_YMD;
            dsT_ME_DISBASMST.Reset();
            
            form1.grdT_ME_DISBASMST.Focus();
            
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

                trT_ME_DISBASMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb050.cmd.MEMB050CMD&S_MODE=SAV";
                trT_ME_DISBASMST.post();
                
            } else {
                
                return;
                
            }
            
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ME_DISBASMST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            
            status = dsT_ME_DISBASMST.RowStatus(dsT_ME_DISBASMST.RowPosition);
            
            //DataSet의 변경 여부 확인
            if (dsT_ME_DISBASMST.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }
            
            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일자[" + dsT_ME_DISBASMST.NameValue(dsT_ME_DISBASMST.RowPosition,"STR_YMD") + "] [" + dsT_ME_DISBASMST.NameValue(dsT_ME_DISBASMST.RowPosition,"DISJOB_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_DISBASMST.DeleteRow(dsT_ME_DISBASMST.RowPosition);

            if (status != 1) {
                trT_ME_DISBASMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb050.cmd.MEMB050CMD&S_MODE=DEL";
                trT_ME_DISBASMST.post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_DISBASMST.SetColumn(form1.grdT_ME_DISBASMST.GetColumnID(0));
            form1.grdT_ME_DISBASMST.Focus();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            alert("개발중입니다");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_ME_DISBASMST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ME_DISBASMST.GridToExcel("용역비지급기준", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ME_DISBASMST.CountColumn == 0) {
                dsT_ME_DISBASMST.setDataHeader("DISJOB_CD:STRING:KEYVALUETYPE, DISJOB_NM:STRING, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, LSEV1_AMT:INT, LSEV2_AMT:INT, LSEV3_AMT:INT, WEL_AMT:INT, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_DISBASMST.AddRow();
            
            fnc_ColEnabled('E');
            
            form1.grdT_ME_DISBASMST.setColumn(form1.grdT_ME_DISBASMST.getColumnID(0));
            
            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtDISJOB_CD").disabled = false;
            document.getElementById("txtSTR_YMD").disabled   = false;
            document.getElementById("ImgDisJobCd").disabled  = false;
            document.getElementById("ImgStrYmd").disabled    = false;
            
            document.getElementById("txtDISJOB_CD").focus();
            

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

            document.getElementById("txtKIJUN_YMD_SHR").value = '';
            document.getElementById("txtDISJOB_CD_SHR").value = '';
            document.getElementById("txtDISJOB_NM_SHR").value = '';
            document.getElementById("ImgDisjobCd1").disabled  = true;
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_ME_DISBASMST.ClearData();
            
            fnc_ColEnabled('D');
            
            document.getElementById("txtKIJUN_YMD_SHR").value = getToday();
            document.getElementById("txtKIJUN_YMD_SHR").focus();

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

            var f = document.form1;
        
            //DataSet의 변경 여부 확인
            if (!dsT_ME_DISBASMST.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }  
            
            for ( i = 1; i <= dsT_ME_DISBASMST.CountRow; i++ ) {
                if ( dsT_ME_DISBASMST.RowStatus(i) == 1 || 
                     dsT_ME_DISBASMST.RowStatus(i) == 3 ) {
                
                    // 담당업무
                    if( dsT_ME_DISBASMST.NameValue(i, "DISJOB_CD") == '' ) {
                        alert("담당업무는 필수 입력사항입니다.");
                        dsT_ME_DISBASMST.RowPosition = i;
                        document.getElementById("txtDISJOB_CD").focus();
                        return false;
                    }   
                    
                    // 담당업무코드
                    if (dsT_ME_DISBASMST.NameValue(i, "DISJOB_CD") != "" &&
                        dsT_ME_DISBASMST.NameValue(i, "DISJOB_NM") == "") {
                        alert("담당업무코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_DISBASMST.RowPosition = i;
                        document.getElementById("txtDISJOB_CD").focus();
                        return;
                    }
                    
                    // 시작일자
                    if( dsT_ME_DISBASMST.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일은 필수 입력사항입니다.");
                        dsT_ME_DISBASMST.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    } 
                    
                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_DISBASMST.NameValue(i, "STR_YMD"), "시작일") && dsT_ME_DISBASMST.NameValue(i, "STR_YMD") != "") {
                        dsT_ME_DISBASMST.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    } 
                    
                    // 폐기일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_DISBASMST.NameValue(i, "END_YMD"), "폐기일") && dsT_ME_DISBASMST.NameValue(i, "END_YMD") != "") {
                        dsT_ME_DISBASMST.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }
                    
                    // 시작일자와 폐기일자  비교
                    if( dsT_ME_DISBASMST.NameValue(i, "STR_YMD") != '' && dsT_ME_DISBASMST.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_DISBASMST.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_ME_DISBASMST.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("폐기일자가 시작일자보다 작습니다.");
                            dsT_ME_DISBASMST.RowPosition = i;
                            document.getElementById("txtEND_YMD").focus();
                            return false;
                        }
                    } 
                    
                    if ( dsT_ME_DISBASMST.RowStatus(i) == 1) {
                        document.getElementById("txtDISJOB_CD").disabled = true;
                        document.getElementById("txtSTR_YMD").disabled   = true;
                        document.getElementById("ImgDisJobCd").disabled  = true;
                        document.getElementById("ImgStrYmd").disabled    = true;

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
            cfStyleGrid(form1.grdT_ME_DISBASMST,0,"false","false");
            
            fnc_ColEnabled('D');
            
            document.getElementById("txtKIJUN_YMD_SHR").value = getToday();
            document.getElementById("txtKIJUN_YMD_SHR").focus();
            
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
         
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
               
                document.getElementById("txtDISJOB_CD").disabled = false;
                document.getElementById("txtSTR_YMD").disabled   = false;
                document.getElementById("txtEND_YMD").disabled   = false;
                form1.medLSEV1_AMT.enable                        = true; 
                form1.medLSEV2_AMT.enable                        = true; 
                form1.medLSEV3_AMT.enable                        = true; 
                form1.medWEL_AMT.enable                          = true; 
                document.getElementById("txtREMARK").disabled    = false;
                                                                 
                document.getElementById("ImgDisjobCd").disabled  = false;
                document.getElementById("ImgStrYmd").disabled    = false;
                document.getElementById("ImgEndYmd").disabled    = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtDISJOB_CD").disabled = true;
                document.getElementById("txtSTR_YMD").disabled   = true;
                document.getElementById("txtEND_YMD").disabled   = true;
                form1.medLSEV1_AMT.enable                        = false; 
                form1.medLSEV2_AMT.enable                        = false; 
                form1.medLSEV3_AMT.enable                        = false; 
                form1.medWEL_AMT.enable                          = false; 
                document.getElementById("txtREMARK").disabled    = true;
                                                                 
                document.getElementById("ImgDisjobCd").disabled  = true;
                document.getElementById("ImgStrYmd").disabled    = true;
                document.getElementById("ImgEndYmd").disabled    = true;
                
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ME_DISBASMST) |
    | 3. 사용되는 Table List(T_ME_DISBASMST)        |
    +----------------------------------------------->
    <Object ID="dsT_ME_DISBASMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_DISBASMST                    |
    | 3. Table List : T_ME_DISBASMST                |
    +----------------------------------------------->
    <Object ID ="trT_ME_DISBASMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_DISBASMST)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_DISBASMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_DISBASMST.CountRow );
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtDISJOB_CD").disabled = true;
            document.getElementById("txtSTR_YMD").disabled   = true;
            document.getElementById("ImgDisJobCd").disabled  = true;
            document.getElementById("ImgStrYmd").disabled    = true;
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ME_DISBASMST Event="OnLoadError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[담당업무/시작일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("담당업무/시작일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_DISBASMST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_DISBASMST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_DISBASMST event="OnFail()">
    
        cfErrorMsg(this);
    
    </script>
    
    <script language=JavaScript for=dsT_ME_DISBASMST Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_DISBASMST.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtDISJOB_CD").disabled = false;
            document.getElementById("txtSTR_YMD").disabled   = false;
            document.getElementById("ImgDisJobCd").disabled  = false;
            document.getElementById("ImgStrYmd").disabled    = false;

        }
        else {
            document.getElementById("txtDISJOB_CD").disabled = true;
            document.getElementById("txtSTR_YMD").disabled   = true;
            document.getElementById("ImgDisJobCd").disabled  = true;
            document.getElementById("ImgStrYmd").disabled    = true;

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">용역비지급기준</td>
                    <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">용역비지급기준</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
                                <col width="70"></col>
                                <col width="100"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">기준년월일 </td>
                                <td class="padding2423">
                                    <input id="txtKIJUN_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '기준년월일');"  onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgKijunYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgKijunYmd" name="ImgKijunYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtKIJUN_YMD_SHR','','20','120');"></a>
                                </td>
                                <td align="right" class="searchState">담당업무 </td>
                                <td class="padding2423">
                                    <input name=txtDISJOB_CD_SHR size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('C9', 'txtDISJOB_CD_SHR','txtDISJOB_NM_SHR');"> <input name=txtDISJOB_NM_SHR size="20" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisjobCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisjobCd1" name="ImgDisjobCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtDISJOB_CD_SHR','txtDISJOB_NM_SHR','담당업무','C9')"></a>
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="120"></col>
                    <col width="80"></col>
                    <col width="120"></col>
                    <col width="80"></col>
                    <col width="120"></col>
                    <col width="80"></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" colspan="3">
                        <input id=txtDISJOB_CD name=txtDISJOB_CD size="5"  maxlength="2" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('C9', 'txtDISJOB_CD','txtDISJOB_NM');"> <input id=txtDISJOB_NM name=txtDISJOB_NM size="39" class="input_ReadOnly"  readOnly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisjobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisjobCd" name="ImgDisjobCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtDISJOB_CD','txtDISJOB_NM','담당업무','C9')"></a>
                    </td>
                    <td align="center" class="creamBold">시 작 일</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','430','177');"></a>
                    </td>
                    <td align="center" class="creamBold">폐 기 일</td>
                    <td class="padding2423">
                        <input id="txtEND_YMD" name="txtEND_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '폐기일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','625','177');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">근속장려금</td>
                    <td align="center" class="creamBold" >6 개월</td>
                    <td class="padding2423" align="left">
                        <comment id="__NSID__"><object id="medLSEV1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold" >12 개월</td>
                    <td class="padding2423" align="left">
                        <comment id="__NSID__"><object id="medLSEV2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold" >18 개월</td>
                    <td class="padding2423" align="left">
                        <comment id="__NSID__"><object id="medLSEV3_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
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
                    <td align="center" class="creamBold">기타수당</td>
                    <td class="padding2423" >
                                    <comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            value=2>
                                        <param name=Border               value=true>
                                        <param name=ClipMode             value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=9>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtREMARK" name="txtREMARK" maxlength="60" style="width:100%">
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
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ME_DISBASMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ME_DISBASMST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'       width=40    name='순번'         align=center </C>
                                <C> id='DISJOB_NM'      width=120   name='담당업무'     align=left   </C>
                                <C> id='STR_YMD'        width=90    name='시작일'       align=center </C>
                                <C> id='END_YMD'        width=90    name='폐기일'       align=center </C>
                                <G> name='근속장려금'   HeadBgColor='#F7DCBB' 
                                    <C> id='LSEV1_AMT'  width=80    name='6개월'        align=right  </C>
                                    <C> id='LSEV2_AMT'  width=80    name='12개월'       align=right  </C>
                                    <C> id='LSEV3_AMT'  width=80    name='18개월'       align=right  </C>
                                </G>
                                <C> id='WEL_AMT'        width=80    name='기타수당'     align=right  </C>
                                <C> id='REMARK'         width=120   name='비고'         align=left   </C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_DISBASMST">
    <Param Name="BindInfo", Value='
        <C> Col=DISJOB_CD   Ctrl=txtDISJOB_CD   Param=value </C>
        <C> Col=DISJOB_NM   Ctrl=txtDISJOB_NM   Param=value </C>
        <C> Col=STR_YMD     Ctrl=txtSTR_YMD     Param=value </C>
        <C> Col=END_YMD     Ctrl=txtEND_YMD     Param=value </C>
        <C> Col=LSEV1_AMT   Ctrl=medLSEV1_AMT   Param=text  </C>
        <C> Col=LSEV2_AMT   Ctrl=medLSEV2_AMT   Param=text  </C>
        <C> Col=LSEV3_AMT   Ctrl=medLSEV3_AMT   Param=text  </C>
        <C> Col=WEL_AMT     Ctrl=medWEL_AMT     Param=text  </C>
        <C> Col=REMARK      Ctrl=txtREMARK      Param=value </C>
    '>
</object>
