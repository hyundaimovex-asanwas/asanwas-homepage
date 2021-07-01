<!--
    ************************************************************************************
    * @Source         : eduh061.jsp                                                    *
    * @Description    : 사내강사관리_신규등록 PAGE                                     *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/28  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>사내강사관리_신규등록(eduh061)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_LCTRLIST.ClearData();
            
            dsT_ED_LCTRLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh061.cmd.EDUH061CMD&S_MODE=SHR&CET_NO="+opener.cet_no;
            dsT_ED_LCTRLIST.Reset();
            
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
            
            trT_ED_LCTRLIST.KeyValue = "tr01(I:SAV=dsT_ED_LCTRLIST)";
            trT_ED_LCTRLIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh061.cmd.EDUH061CMD&S_MODE=SAV";
            trT_ED_LCTRLIST.post();
            
            
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
            var LCT_Q5_GBN = '';
            
            for( i = 1; i <= dsT_ED_LCTRLIST.CountRow; i++ ) {
                // 강의분야
                for (var j = 0; j < document.getElementById('cmbLCT_Q5_GBN').options.length; j++) {
                    if (document.getElementById('cmbLCT_Q5_GBN').options[j].selected == true) {
                        LCT_Q5_GBN = LCT_Q5_GBN + document.getElementById('cmbLCT_Q5_GBN').options[j].value + '|';
                    }
                }
                
                dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_GBN") = LCT_Q5_GBN.substr(0, LCT_Q5_GBN.length - 1);
            }
                        
            if (!dsT_ED_LCTRLIST.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_LCTRLIST.isUpdated) {
                for( i = 1; i <= dsT_ED_LCTRLIST.CountRow; i++ ) {
                    if( dsT_ED_LCTRLIST.RowStatus(i) == 1 || 
                        dsT_ED_LCTRLIST.RowStatus(i) == 3 ) {
                        
                        // 강사구분
                        if( dsT_ED_LCTRLIST.NameValue(i, "LCT_CD") == '' ) {
                            alert("강사구분은 필수 입력사항입니다.");
                            document.getElementById("cmbLCT_CD").focus();
                            return false;
                        }
                        
                        // 강의분야
                        if( dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_GBN") == '' ) {
                            alert("강의분야는 필수 입력사항입니다.");
                            document.getElementById("cmbLCT_Q5_GBN").focus();
                            return false;
                        }
                        
                        // 강사명
                        if( dsT_ED_LCTRLIST.NameValue(i, "ENO_NM") == '' ) {
                            alert("교육주관은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NM").focus();
                            return false;
                        }
                        
                        // 주민번호
                        if( dsT_ED_LCTRLIST.NameValue(i, "CET_NO") == '' ) {
                            alert("주민번호는 필수 입력사항입니다.");
                            document.getElementById("txtCET_NO").focus();
                            return false;
                        }
                        
                        // 주민번호 CHECK
                        if (!fnc_SsnValid(document.getElementById("txtCET_NO"))) {
                            document.getElementById("txtCET_NO").focus();
                            return false;
                        }
                        
                        if (document.getElementById('txtE_MAIL1').value != '') {
                            // 이메일 CHECK
                            if (!fnc_ChgEmail('txtE_MAIL1')) {
                                document.getElementById('txtE_MAIL1').focus();
                                return false;
                            }
                        }
                        
                        if (document.getElementById('txtE_MAIL2').value != '') {
                            // 이메일 CHECK
                            if (!fnc_ChgEmail('txtE_MAIL2')) {
                                document.getElementById('txtE_MAIL2').focus();
                                return false;
                            }
                        }
                        
                        if ( dsT_ED_LCTRLIST.RowStatus(i) == 1) {
                            document.getElementById("txtCET_NO").disabled = true;
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

            fnc_ComboSet();            

            // 구분이 수정이면
            if (opener.gbn == "2") {

                document.getElementById('txtCET_NO').value = opener.cet_no;
            
                // 공지사항 데이터 조회
                fnc_SearchList();
            }
            else {
            
                fnc_ColEnabled('E');
                
                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_LCTRLIST.CountColumn == 0) {
                    dsT_ED_LCTRLIST.setDataHeader("LCT_CD:STRING, LCT_Q5_GBN:STRING, ENO_NM:STRING, ENO_NO:STRING, DPT_NM:STRING, JOB_NM:STRING, CET_NO:STRING:KEYVALUETYPE, HIR_YMD:STRING, LCT_TXT:STRING, SCH_TXT:STRING, LIC_TXT:STRING, ETC_TXT:STRING, ADDR_TXT:STRING, PHN_NO:STRING, EM_PHN_NO:STRING, E_MAIL1:STRING, E_MAIL2:STRING, BANK_TAG:STRING, CAR_TAG:STRING");
                }
                
                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_LCTRLIST.AddRow();
                
                document.getElementById('cmbLCT_CD').focus();
            }
            
        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_LCTRLIST.IsUpdated)
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
        
        
        /********************
         * 콤보박스 값 SET  *
         ********************/
        function fnc_ComboSet() {
            var oOption = null;        

            //강사구분
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_CD").add(oOption);
                
            }
            
            //교육분야
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_Q5_GBN").add(oOption);
                
            }
            
        }

        
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("cmbLCT_CD").disabled     = false;
                document.getElementById("cmbLCT_Q5_GBN").disabled = false;
                document.getElementById("txtENO_NM").disabled     = false;
                document.getElementById("txtENO_NO").disabled     = false;
                document.getElementById("txtDPT_NM").disabled     = false;
                document.getElementById("txtJOB_NM").disabled     = false;
                document.getElementById("txtCET_NO").disabled     = false;
                document.getElementById("txtHIR_YMD").disabled    = false;
                document.getElementById("txtLCT_TXT").disabled    = false;
                document.getElementById("txtSCH_TXT").disabled    = false;
                document.getElementById("txtLIC_TXT").disabled    = false;
                document.getElementById("txtETC_TXT").disabled    = false;
                document.getElementById("txtADDR_TXT").disabled   = false;
                document.getElementById("txtPHN_NO").disabled     = false;
                document.getElementById("txtEM_PHN_NO").disabled  = false;
                document.getElementById("txtE_MAIL1").disabled    = false;
                document.getElementById("txtE_MAIL2").disabled    = false;
                document.getElementById("txtBANK_TAG").disabled   = false;
                document.getElementById("txtCAR_TAG").disabled    = false;
                
                document.getElementById("ImgEnoNo").disabled      = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("cmbLCT_CD").disabled     = true;
                document.getElementById("cmbLCT_Q5_GBN").disabled = true;
                document.getElementById("txtENO_NM").disabled     = true;
                document.getElementById("txtENO_NO").disabled     = true;
                document.getElementById("txtDPT_NM").disabled     = true;
                document.getElementById("txtJOB_NM").disabled     = true;
                document.getElementById("txtCET_NO").disabled     = true;
                document.getElementById("txtHIR_YMD").disabled    = true;
                document.getElementById("txtLCT_TXT").disabled    = true;
                document.getElementById("txtSCH_TXT").disabled    = true;
                document.getElementById("txtLIC_TXT").disabled    = true;
                document.getElementById("txtETC_TXT").disabled    = true;
                document.getElementById("txtADDR_TXT").disabled   = true;
                document.getElementById("txtPHN_NO").disabled     = true;
                document.getElementById("txtEM_PHN_NO").disabled  = true;
                document.getElementById("txtE_MAIL1").disabled    = true;
                document.getElementById("txtE_MAIL2").disabled    = true;
                document.getElementById("txtBANK_TAG").disabled   = true;
                document.getElementById("txtCAR_TAG").disabled    = true;
                
                document.getElementById("ImgEnoNo").disabled      = true;
                
            }
            
            if (opener.gbn == '2') {
                document.getElementById("txtCET_NO").disabled     = true;
                document.getElementById("ImgEnoNo").disabled      = true;
            }
            
        }
        
        /***************************************
         * 임직원검색 버튼 클릭시 처리 루틴    *
         ***************************************/
        function fnc_Popup() {
            var obj = new String();
            
            obj.eno_nm = "";

            window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        
            document.getElementById("txtENO_NO").value  = obj.eno_no; 
            document.getElementById("txtENO_NM").value  = obj.eno_nm; 
            document.getElementById("txtDPT_NM").value  = obj.dpt_nm; 
            document.getElementById("txtJOB_NM").value  = obj.job_nm; 
            document.getElementById("txtHIR_YMD").value = obj.hir_ymd;
            
            if (opener.gbn != '2') {
                document.getElementById("txtCET_NO").value  = obj.cet_no;
            }
        }
        
        function fnc_ChangeFld() {
            if (document.getElementById("txtENO_NM").value == "") {
                document.getElementById("txtENO_NO").value  = "";
                document.getElementById("txtDPT_NM").value  = "";            
                document.getElementById("txtJOB_NM").value  = "";            
                document.getElementById("txtHIR_YMD").value = "";            
            }
            else if (document.getElementById("txtENO_NO").value == "") {
                document.getElementById("txtDPT_NM").value  = "";            
                document.getElementById("txtJOB_NM").value  = "";            
                document.getElementById("txtHIR_YMD").value = ""; 
            }
        }
        
        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    return false;
                }
            }
            
            return true;
        }
        
        function fnc_ChgEmail(fld) {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
        
            if (document.getElementById(fld).value.search(format) == -1) {
                alert("유효한 이메일 주소가 아닙니다.");
                document.getElementById(fld).focus();
                
                return false;
            }
        
            return true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_LCTRLIST)|
    | 3. 사용되는 Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
   
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_LCTRLIST)|
    | 3. 사용되는 Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_LCTRLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_LCTRLIST)">
    </Object>
    
    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 강사구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 강의분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
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
    <Script For=dsT_ED_LCTRLIST Event="OnLoadCompleted(iCount)">
        var LCT_Q5_GBN = '';
        var Index = 0;

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            // 버튼이 보이지 않음.
            document.getElementById("view_1").style.display='none';
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_LCTRLIST.CountRow );
            
            if (dsT_ED_LCTRLIST.NameValue(1, "IPT_MAN") == '<%=box.get("SESSION_ENONO")%>') {
        
                // 버튼이 보임
                document.getElementById("view_1").style.display='inline';
                
                fnc_ColEnabled('E');
            }
            else {
                
                // 버튼이 보이지 않음.
                document.getElementById("view_1").style.display='none';
            
                fnc_ColEnabled('D');
            }
            
            LCT_Q5_GBN = dsT_ED_LCTRLIST.NameValue(1, "LCT_Q5_GBN");

            while (LCT_Q5_GBN != "") {

                index = LCT_Q5_GBN.indexOf("|");

                for (var i = 0; i <  document.getElementById('cmbLCT_Q5_GBN').options.length; i++) {

                    if (index != -1) {
                        if (document.getElementById('cmbLCT_Q5_GBN').options[i].value == LCT_Q5_GBN.substr(0, LCT_Q5_GBN.indexOf("|"))) {
                            document.getElementById('cmbLCT_Q5_GBN').options[i].selected = true;
                            break;
                        }
                    }
                    else {
                        if (document.getElementById('cmbLCT_Q5_GBN').options[i].value == LCT_Q5_GBN) {
                            document.getElementById('cmbLCT_Q5_GBN').options[i].selected = true;
                            break;
                        }
                    }
                }
                
                LCT_Q5_GBN = LCT_Q5_GBN.substr(LCT_Q5_GBN.indexOf("|") + 1, LCT_Q5_GBN.length - LCT_Q5_GBN.indexOf("|"));

                if (index == -1) {
                    break;
                }
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
   
    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_LCTRLIST event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
        window.close();
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_ED_LCTRLIST event="OnFail()">
    
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사내강사관리_신규등록</td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="280"></col>
                    <col width="120"></col>
                    <col width="280"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">강사구분</td>
                    <td class="padding2423" >
                        <select id="cmbLCT_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">강의분야</td>
                    <td class="padding2423" >
                        <select id="cmbLCT_Q5_GBN" multiple style="height:50;width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">강 사 명</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" name="txtENO_NM" size="16" onChange="fnc_ChangeFld();">
                        <input type=button id='ImgEnoNo' value="임직원검색" onclick="fnc_Popup();">
                    </td>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" style="width:100%" maxlength="8" onKeyPress="cfNumberCheck();" onChange="fnc_ChangeFld();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423" >
                        <input id="txtDPT_NM" name="txtDPT_NM" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_NM" name="txtJOB_NM" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">주민번호</td>
                    <td class="padding2423">
                        <input id="txtCET_NO"  name="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onChange="fnc_SsnValid(this);">
                    </td>
                    <td align="center" class="creamBold">입 사 일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD"  name="txtHIR_YMD" style="width:100%;ime-mode:disabled" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">주요강의분야</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtLCT_TXT"  name="txtLCT_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">학력/전공사항</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtSCH_TXT"  name="txtSCH_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">자격/수상경력</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtLIC_TXT"  name="txtLIC_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">저서/기타</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtETC_TXT"  name="txtETC_TXT" cols="110" rows="4" maxlength="600" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtADDR_TXT"  name="txtADDR_TXT" style="width:100%;" maxlength="120" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">전화번호</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO"  name="txtPHN_NO" style="width:100%;" maxlength="16" >
                    </td>
                    <td align="center" class="creamBold">휴 대 폰</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO"  name="txtEM_PHN_NO" style="width:100%;" maxlength="16" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">E-Mail 1</td>
                    <td class="padding2423" >
                        <input id="txtE_MAIL1" name="txtE_MAIL1" style="width:100%"  onChange="fnc_ChgEmail('txtE_MAIL1');">
                    </td>
                    <td align="center" class="creamBold">E-Mail 2</td>
                    <td class="padding2423" >
                        <input id="txtE_MAIL2" name="txtE_MAIL2" style="width:100%"  onChange="fnc_ChgEmail('txtE_MAIL1');">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">입금계좌</td>
                    <td class="padding2423" >
                        <input id="txtBANK_TAG" name="txtBANK_TAG" style="width:100%" >
                    </td>
                    <td align="center" class="creamBold">차량정보</td>
                    <td class="padding2423" >
                        <input id="txtCAR_TAG" name="txtCAR_TAG" style="width:100%" >
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
<object id="bndT_ED_LCTRLIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_LCTRLIST">
    <Param Name="BindInfo", Value='
        <C>Col=LCT_CD       Ctrl=cmbLCT_CD      Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=CET_NO       Ctrl=txtCET_NO      Param=value </C>
        <C>Col=HIR_YMD      Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=LCT_TXT      Ctrl=txtLCT_TXT     Param=value </C>
        <C>Col=SCH_TXT      Ctrl=txtSCH_TXT     Param=value </C>
        <C>Col=LIC_TXT      Ctrl=txtLIC_TXT     Param=value </C>
        <C>Col=ETC_TXT      Ctrl=txtETC_TXT     Param=value </C>
        <C>Col=ADDR_TXT     Ctrl=txtADDR_TXT    Param=value </C>
        <C>Col=PHN_NO       Ctrl=txtPHN_NO      Param=value </C>
        <C>Col=EM_PHN_NO    Ctrl=txtEM_PHN_NO   Param=value </C>
        <C>Col=E_MAIL1      Ctrl=txtE_MAIL1     Param=value </C>
        <C>Col=E_MAIL2      Ctrl=txtE_MAIL2     Param=value </C>
        <C>Col=BANK_TAG     Ctrl=txtBANK_TAG    Param=value </C>
        <C>Col=CAR_TAG      Ctrl=txtCAR_TAG     Param=value </C>
    '>                                         
</object>