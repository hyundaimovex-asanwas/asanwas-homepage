<!--
    ************************************************************************************
    * @Source         : cdpa010.jsp                                                    *
    * @Description    : 유사직무등록 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/29 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>유사직무등록(cdpa010)</title>
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

            if(fnc_SaveItemCheck()) {

                trT_EV_DUTYSAME.KeyValue = "tr01(I:SAV=dsT_EV_DUTYSAME)";
                trT_EV_DUTYSAME.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SAV";
                trT_EV_DUTYSAME.post();
                
            }            
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_DUTYSAME.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            
            status = dsT_EV_DUTYSAME.RowStatus(dsT_EV_DUTYSAME.RowPosition);
            
            //DataSet의 변경 여부 확인
            if (dsT_EV_DUTYSAME.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }
            
            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("직무코드 [" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"DUTY_CD") + "][" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"DUTY_NM") + "], 유사직무 [" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"SDUTY_CD") + "][" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"SDUTY_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_DUTYSAME.DeleteRow(dsT_EV_DUTYSAME.RowPosition);

            if (status != 1) {
                trT_EV_DUTYSAME.KeyValue = "tr01(I:SAV=dsT_EV_DUTYSAME)";
                trT_EV_DUTYSAME.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=DEL";
                trT_EV_DUTYSAME.post();
            }

            bnd.ActiveBind = false;
            
            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_DUTYSAME.SetColumn(form1.grdT_EV_DUTYSAME.GetColumnID(0));
            form1.grdT_EV_DUTYSAME.Focus();
            
            bnd.ActiveBind = true;

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

            if(document.tvT_CM_DUTYMST.ItemText.trim() == ""){
                alert("트리 아이템을 먼저 선택해주세요.");
                return false;
            }
            
            //현재 선택된 트리의 정보를 가져온다.
            var overNm = document.tvT_CM_DUTYMST.ItemText;
            var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
            var oDUTY_CD = dsT_CM_DUTYMST.NameValue(Row,"DUTY_CD");
            var oDUTY_NM = dsT_CM_DUTYMST.NameValue(Row,"DUTY_NM");

            var oDUTY_LBL= dsT_CM_DUTYMST.NameValue(Row,"DUTY_LBL");

            if (oDUTY_LBL != '4') {
                alert("유사직무코드를 등록하고자 하는 직무코드를 선택하여 주십시오");
                return;
            }
            
            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_DUTYSAME.CountColumn == 0) {
                dsT_EV_DUTYSAME.setDataHeader("DUTY_CD:STRING:KEYVALUETYPE, DUTY_NM:STRING, SDUTY_CD:STRING:KEYVALUETYPE, SDUTY_NM:STRING, SEM_RATE:INT");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_DUTYSAME.AddRow();
            
            fnc_ColEnabled('E');

            form1.grdT_EV_DUTYSAME.setColumn(form1.grdT_EV_DUTYSAME.getColumnID(0));
            
            document.getElementById("txtDUTY_CD").disabled  = false;
            document.getElementById("ImgDutyCd").disabled   = false;
            document.getElementById("txtSDUTY_CD").disabled = false;
            document.getElementById("ImgSDutyCd").disabled  = false;
            
            document.getElementById("txtDUTY_CD").value  = oDUTY_CD;
            document.getElementById("txtDUTY_NM").value  = oDUTY_NM;            
            document.getElementById("txtDUTY_CD").focus();

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

            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_EV_DUTYSAME.ClearData();
            
            fnc_ColEnabled('D');

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
            if (!dsT_EV_DUTYSAME.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }  
            
            for ( i = 1; i <= dsT_EV_DUTYSAME.CountRow; i++ ) {
                if ( dsT_EV_DUTYSAME.RowStatus(i) == 1 || 
                     dsT_EV_DUTYSAME.RowStatus(i) == 3 ) {
                
                    // 직무코드
                    if( dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") == '' ) {
                        alert("직무코드는 필수 입력사항입니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return false;
                    }   
                    
                    // 직무코드 CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") != "" &&
                        dsT_EV_DUTYSAME.NameValue(i, "DUTY_NM") == "") {
                        alert("직무코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtMENO_NO").focus();
                        return;
                    }   
                    
                    // 유사직무코드
                    if( dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD") == '' ) {
                        alert("유사직무코드는 필수 입력사항입니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return false;
                    }   
                    
                    // 유사직무코드 CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD") != "" &&
                        dsT_EV_DUTYSAME.NameValue(i, "SDUTY_NM") == "") {
                        alert("유사직무코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return;
                    }   
                    
                    // 직무코드와 유사직무코드가 동일한지 CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") == dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD")) {
                        alert("직무코드와 유사직무코드가 동일합니다. 확인바랍니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return false;
                    } 
                    
                    // 유사율
                    if( dsT_EV_DUTYSAME.NameValue(i, "SEM_RATE") <= 0 ) {
                        alert("유사율은 필수 입력사항입니다.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSEM_RATE").focus();
                        return false;
                    }
                    
                    if (dsT_EV_DUTYSAME.NameValue(i, "SEM_RATE") > 100) {
                        alert("유사율은 100 이하의 값을 입력하여 주십시오.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSEM_RATE").focus();
                        return false;
                    }
                        
                    if ( dsT_EV_DUTYSAME.RowStatus(i) == 1) {
                       document.getElementById("txtDUTY_CD").disabled  = true;
                       document.getElementById("ImgDutyCd").disabled   = true;
                       document.getElementById("txtSDUTY_CD").disabled = true;
                       document.getElementById("ImgSDutyCd").disabled  = true;
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
            cfStyleGrid(form1.grdT_EV_DUTYSAME,0,"false","false");
            
            fnc_ColEnabled('D');
            
            // form load시 무조건 직무코드 트리형태로 조회
            try {
                dsT_CM_DUTYMST.ClearData();
                dsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SHR";
                dsT_CM_DUTYMST.Reset();

            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
            
        }
        
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_EV_DUTYSAME.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            
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
               
                document.getElementById("txtDUTY_CD").disabled  = false;
                document.getElementById("txtDUTY_NM").disabled  = false;
                document.getElementById("txtSDUTY_CD").disabled = false;
                document.getElementById("txtSDUTY_NM").disabled = false;
                document.getElementById("txtSEM_RATE").disabled = false;

                document.getElementById("ImgDutyCd").disabled   = false;
                document.getElementById("ImgSDutyCd").disabled  = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtDUTY_CD").disabled  = true;
                document.getElementById("txtDUTY_NM").disabled  = true;
                document.getElementById("txtSDUTY_CD").disabled = true;
                document.getElementById("txtSDUTY_NM").disabled = true;
                document.getElementById("txtSEM_RATE").disabled = true;

                document.getElementById("ImgDutyCd").disabled   = true;
                document.getElementById("ImgSDutyCd").disabled  = true;
                
            }
            
        }
         

        /*************************************************
         * 직군, 직렬, 직무 및 직무코드 조회용 팝업      *
         ************************************************/
        function fnc_dutyPopup(ctrl_01, ctrl_02) {

            var obj = new String();

            window.showModalDialog("/common/popup/duty.jsp", obj, "dialogWidth:368px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.duty_cd != ''){

                document.getElementById(ctrl_01).value = obj.duty_cd;
                document.getElementById(ctrl_02).value = obj.duty_nm;
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
    | 1. 트리구성용 DataSet                         |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_DUTYMST)   |
    | 3. 사용되는 Table List(T_CM_DUTYMST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_DUTYSAME)  |
    | 3. 사용되는 Table List(T_EV_DUTYSAME)         |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYSAME" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_EV_DUTYSAME                     |
    | 3. Table List : T_EV_DUTYSAME                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_DUTYSAME" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_DUTYSAME)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->
    
    <!-------------------------------+
    | treeview에서 item를 클릭했을때 |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CM_DUTYMST event=OnItemClick()>
        var overId1 = "DUTY_CD";
        var overId2 = "DUTY_LBL";
        var overNm = tvT_CM_DUTYMST.ItemText;
        var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
        var overValue1 = dsT_CM_DUTYMST.NameValue(Row,overId1);
        var overValue2 = dsT_CM_DUTYMST.NameValue(Row,overId2);
        
        // 직무레벨이 4인 경우 유사직무등록을 조회해온다.
        if (overValue2 != "4") {
            return;
        }
        
        try {
            dsT_EV_DUTYSAME.ClearData();
            dsT_EV_DUTYSAME.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SHR_01&"+overId1+"="+overValue1;
            dsT_EV_DUTYSAME.Reset();

        } catch ( exception ) {
            fcWindowsXpSp2Notice(false);
            return;
        }
        
    </script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYSAME Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_DUTYSAME.CountRow );
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtDUTY_CD").disabled  = true;
            document.getElementById("ImgDutyCd").disabled   = true;
            document.getElementById("txtSDUTY_CD").disabled = true;
            document.getElementById("ImgSDutyCd").disabled  = true;
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYSAME Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYSAME Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_DUTYSAME event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_DUTYSAME event="OnFail()">
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">유사직무등록</td>
                    <td align="right" class="navigator">HOME/교육관리/CDP/직무관리/<font color="#000000">유사직무등록</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="290"></col>
                    <col width="100"></col>
                    <col width="210"></col>
                    <col width="50 "></col>
                    <col width="40 "></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">직무코드</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" maxlength="10" style="width:90%;ime-mode:disabled" onChange="fnc_GetCommNm('DUTY', 'txtDUTY_CD','txtDUTY_NM')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtDUTY_CD','txtDUTY_NM')"></a>
                    </td>
                    <td align="center" class="creamBold">직무명</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtDUTY_NM" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">유사직무코드</td>
                    <td class="padding2423">
                        <input id="txtSDUTY_CD" maxlength="10" style="width:90%;ime-mode:disabled" onChange="fnc_GetCommNm('DUTY', 'txtSDUTY_CD','txtSDUTY_NM')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSDutyCd" name="ImgSDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtSDUTY_CD','txtSDUTY_NM')"></a>
                    </td>
                    <td align="center" class="creamBold">유사직무명</td>
                    <td class="padding2423" >
                        <input id="txtSDUTY_NM" style="width:100%;"  class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">유사율</td>
                    <td class="padding2423">
                        <input id="txtSEM_RATE" maxlength="3" style="width:70%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">%
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

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
                        <!-- 내용 조회 트리 시작-->
                        <comment id="__NSID__">
                        <object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:340px">
                            <param name=DataID        value="dsT_CM_DUTYMST">
                            <param name=TextColumn    value="DUTY_NM">
                            <param name=LevelColumn    value="DUTY_LBL">
                            <param name=ExpandLevel    value="1">
                            <param name=BorderStyle  value="2">
                            <param name=UseImage      value="false">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                        <!-- 내용 조회 트리 끝-->
                    </td>
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSAME" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:340px;">
                            <param name="DataID"             value="dsT_EV_DUTYSAME">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=40    name='순번'         align=center </C>
                                <C> id='SDUTY_CD'            width=120   name='유사직무코드' align=center </C>
                                <C> id='SDUTY_NM'            width=220   name='유사직무명'   align=left   </C>
                                <C> id='SEM_RATE'            width=100   name='유사율'       align=right  </C>
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
<!-- 유사직무등록 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_DUTYSAME">
    <Param Name="BindInfo", Value='
        <C> Col=DUTY_CD     Ctrl=txtDUTY_CD        Param=value </C>
        <C> Col=DUTY_NM     Ctrl=txtDUTY_NM        Param=value </C>
        <C> Col=SDUTY_CD    Ctrl=txtSDUTY_CD       Param=value </C>
        <C> Col=SDUTY_NM    Ctrl=txtSDUTY_NM       Param=value </C>
        <C> Col=SEM_RATE    Ctrl=txtSEM_RATE       Param=value </C>
    '>
</object>
