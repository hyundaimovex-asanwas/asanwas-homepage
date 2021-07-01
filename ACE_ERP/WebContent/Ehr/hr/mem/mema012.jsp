<!--
    ************************************************************************************
    * @Source         : mema012.jsp                                                    *
    * @Description    : 인사기본3 PAGE                                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>인사기본3</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_PERSON.ClearData();
                dsT_ME_ARMY.ClearData();

                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            trT_ME_PERSON.KeyValue = "SVL(O:dsT_ME_PERSON=dsT_ME_PERSON, O:dsT_ME_ARMY=dsT_ME_ARMY)";
            trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema012.cmd.MEMA012CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            trT_ME_PERSON.post();

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

            //DataSet의 변경 여부 확인
            if (!dsT_ME_PERSON.IsUpdated && !dsT_ME_ARMY.IsUpdated) {
//                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

                trT_ME_PERSON2.KeyValue = "SVL(I:dsT_ME_PERSON=dsT_ME_PERSON, I:dsT_ME_ARMY=dsT_ME_ARMY)";
                trT_ME_PERSON2.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema012.cmd.MEMA012CMD&S_MODE=SAV";
                trT_ME_PERSON2.post();

            } else {

                return false;

            }

            return true;
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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_PERSON.ClearData();
			dsT_ME_ARMY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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

            // 우편번호 미존재하고, 주소 입력한 경우
            if (document.getElementById("txtRZI_NO").value == "" && document.getElementById("txtRADR").value != "") {
                alert("우편번호를 입력하지 않으셨습니다. 확인바랍니다.");
                document.getElementById("txtRADR").focus();
                return false;
            }

            // 이메일 CHECK
            if (!fnc_ChgEmail()) {
                document.getElementById("txtE_MAIL").focus();
                return false;
            }

            // 실시일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPRO_YMD"), "실시일") && document.getElementById("txtPRO_YMD").value != "") {
                document.getElementById("txtPRO_YMD").focus();
                return false;
            }

            // 색맹
            if (document.getElementById("txtCBLD_CD").value != "" &&
                document.getElementById("txtCBLD_NM").value == "") {
                alert("색맹코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtCBLD_CD").focus();
                return false;
            }
            
            // 특기
            if (document.getElementById("txtSPEC_CD").value != "" &&
                document.getElementById("txtSPEC_NM").value == "") {
                alert("특기코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtSPEC_CD").focus();
                return false;
            }

            // 결혼일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtWED_YMD"), "결혼일") && document.getElementById("txtWED_YMD").value != "") {
                document.getElementById("txtWED_YMD").focus();
                return false;
            }
            
            // 종교
            if (document.getElementById("txtREL_CD").value != "" &&
                document.getElementById("txtREL_NM").value == "") {
                alert("종교코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtREL_CD").focus();
                return false;
            }
            
            for ( i = 1; i <= dsT_ME_ARMY.CountRow; i++ ) {
                if ( dsT_ME_ARMY.RowStatus(i) == 1 ||
                     dsT_ME_ARMY.RowStatus(i) == 3 ) {
                     
                    // 병무구분
                    if( dsT_ME_ARMY.NameValue(i, "GUB_CD") == '' ) {
                        alert("병무구분은 필수 입력사항입니다.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return false;
                    }
                    
                    // 병무구분
                    if (dsT_ME_ARMY.NameValue(i, "GUB_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GUB_NM") == "") {
                        alert("병무구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return;
                    }
                    
                    // 복무기간의 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "ENL_YMD"), "복무시작일자") && dsT_ME_ARMY.NameValue(i, "ENL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtENL_YMD").focus();
                        return false;
                    }
                    
                    // 복무기간의 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "MIL_YMD"), "복무종료일자") && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_YMD").focus();
                        return false;
                    }

                    // 복무기간의 시작일자와 종료일자 비교
                    if( dsT_ME_ARMY.NameValue(i, "ENL_YMD") != '' && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_ARMY.NameValue(i, "ENL_YMD").replace(/\-/g,''),dsT_ME_ARMY.NameValue(i, "MIL_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("시작일자가 종료일자보다 큽니다.");
                            dsT_ME_ARMY.RowPosition = i;
                            document.getElementById("txtENL_YMD").focus();
                            return false;
                        }
                    }

                    // 군별
                    if (dsT_ME_ARMY.NameValue(i, "MIL_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MIL_NM") == "") {
                        alert("군별코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_CD").focus();
                        return;
                    }

                    // 병과
                    if (dsT_ME_ARMY.NameValue(i, "MBK_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MBK_NM") == "") {
                        alert("병과코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMBK_CD").focus();
                        return;
                    }

                    // 계급
                    if (dsT_ME_ARMY.NameValue(i, "GRADE") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GRADE_NM") == "") {
                        alert("계급코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGRADE").focus();
                        return;
                    }
                     
                }  
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";
            document.getElementById("txtENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //이곳에 해당 코딩을 입력 하세요
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

                document.getElementById("txtRADR").disabled      = false;
                document.getElementById("txtPHN_NO").disabled    = false;
                document.getElementById("txtEM_PHN_NO").disabled = false;
                document.getElementById("txtE_MAIL").disabled    = false;
                document.getElementById("txtPRO_YMD").disabled   = false;
                document.getElementById("txtEYE_LEF").disabled   = false;
                document.getElementById("txtEYE_RHT").disabled   = false;
                document.getElementById("txtHEIGHT").disabled    = false;
                document.getElementById("txtWEIGHT").disabled    = false;
                document.getElementById("txtAB_HGT").disabled    = false;
                document.getElementById("txtCBLD_CD").disabled   = false;
                document.getElementById("txtCBLD_NM").disabled   = false;
                document.getElementById("txtBLD_TYP").disabled   = false;
                
                document.getElementById("txtHOBBY").disabled       = false;
                document.getElementById("txtSPEC_CD").disabled     = false;
                document.getElementById("txtWED_YMD").disabled     = false;
                document.getElementById("txtREL_CD").disabled      = false;
                
                document.getElementById("txtGUB_CD").disabled   = false;
                document.getElementById("txtENL_YMD").disabled  = false;
                document.getElementById("txtMIL_YMD").disabled  = false;
                document.getElementById("txtMIL_CD").disabled   = false;
                document.getElementById("txtMBK_CD").disabled   = false;
                document.getElementById("txtGRADE").disabled    = false;
                
                document.getElementById("ImgRziNo").disabled     = false;
                document.getElementById("ImgProYmd").disabled    = false;
                document.getElementById("ImgCbldCd").disabled    = false;
                
                document.getElementById("ImgSpecCd").disabled      = false;
                document.getElementById("ImgWedYmd").disabled      = false;
                document.getElementById("ImgRelCd").disabled       = false;
                
                document.getElementById("ImgGubCd").disabled    = false;
                document.getElementById("ImgEnlYmd").disabled   = false;
                document.getElementById("ImgMilYmd").disabled   = false;
                document.getElementById("ImgMilCd").disabled    = false;
                document.getElementById("ImgMbkCd").disabled    = false;
                document.getElementById("ImgGrade").disabled    = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtRADR").disabled      = true;
                document.getElementById("txtPHN_NO").disabled    = true;
                document.getElementById("txtEM_PHN_NO").disabled = true;
                document.getElementById("txtE_MAIL").disabled    = true;
                document.getElementById("txtPRO_YMD").disabled   = true;
                document.getElementById("txtEYE_LEF").disabled   = true;
                document.getElementById("txtEYE_RHT").disabled   = true;
                document.getElementById("txtHEIGHT").disabled    = true;
                document.getElementById("txtWEIGHT").disabled    = true;
                document.getElementById("txtAB_HGT").disabled    = true;
                document.getElementById("txtCBLD_CD").disabled   = true;
                document.getElementById("txtCBLD_NM").disabled   = true;
                document.getElementById("txtBLD_TYP").disabled   = true;
                
                document.getElementById("txtHOBBY").disabled       = true;
                document.getElementById("txtSPEC_CD").disabled     = true;
                document.getElementById("txtWED_YMD").disabled     = true;
                document.getElementById("txtREL_CD").disabled      = true;
                
                document.getElementById("txtGUB_CD").disabled   = true;
                document.getElementById("txtENL_YMD").disabled  = true;
                document.getElementById("txtMIL_YMD").disabled  = true;
                document.getElementById("txtMIL_CD").disabled   = true;
                document.getElementById("txtMBK_CD").disabled   = true;
                document.getElementById("txtGRADE").disabled    = true;

                document.getElementById("ImgRziNo").disabled     = true;
                document.getElementById("ImgProYmd").disabled    = true;
                document.getElementById("ImgCbldCd").disabled    = true;
                
                document.getElementById("ImgSpecCd").disabled      = true;
                document.getElementById("ImgWedYmd").disabled      = true;
                document.getElementById("ImgRelCd").disabled       = true;
                
                document.getElementById("ImgGubCd").disabled    = true;
                document.getElementById("ImgEnlYmd").disabled   = true;
                document.getElementById("ImgMilYmd").disabled   = true;
                document.getElementById("ImgMilCd").disabled    = true;
                document.getElementById("ImgMbkCd").disabled    = true;
                document.getElementById("ImgGrade").disabled    = true;

            }
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';
                }
            }
        }

        function fnc_ChgEmail() {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

            if (document.getElementById("txtE_MAIL").value == "") {
                return true;
            }

            if (document.getElementById("txtE_MAIL").value.search(format) == -1) {
                alert("유효한 이메일 주소가 아닙니다.");
                document.getElementById("txtE_MAIL").focus();

                return false;
            }

            return true;
        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_ARMY                       |
    | 3. Table List : T_ME_ARMY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_ARMY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON2                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>
    
    <Script For=dsT_ME_ARMY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {
        
            if (dsT_ME_ARMY.CountColumn == 0) {
                dsT_ME_ARMY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, GUB_CD:STRING, GUB_NM:STRING, MIC_CD:STRING, MIC_NM:STRING, LOC_CD:STRING, LOC_NM:STRING, MIL_CD:STRING, MIL_NM:STRING, ENL_YMD:STRING, MIL_YMD:STRING, YSE_CD:STRING, YSE_NM:STRING, GRADE:STRING, GRADE_NM:STRING, MIL_NO:STRING, MBK_CD:STRING, MBK_NM:STRING, MIL_DES:STRING, REMARK:STRING");
            }

            if (dsT_ME_ARMY.CountRow > 0) {
                return;
            }
            
            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_ARMY.AddRow();
            dsT_ME_ARMY.NameValue(dsT_ME_ARMY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;

        } else {

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_ME_ARMY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>
    
    <Script For=dsT_ME_ARMY Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>
    
    <script for=trT_ME_PERSON2 event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script for=trT_ME_PERSON2 event="OnFail()">

        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>인사기본3</strong>
        </td>
        <td height="20" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>-->
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="72 "></col>
                    <col width="64 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">실거주지</td>
                    <td align="center" class="creamBold">우편번호</td>                    
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRziNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRziNo" name="ImgRziNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtRZI_NO','txtRADR_CT','txtRADR')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="60" style="width:46%"></td>
                </tr>                
            </table>
            
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="78 "></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >연락번호</td>
                    <td align="center" class="creamBold">전화번호</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="creamBold">휴 대 폰</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="creamBold">E-mail</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtE_MAIL" maxlength="40" style="width:100%" onChange="fnc_ChgEmail();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">신체사항</td>
                    <input type=hidden id="txtENO_NO">
                    <input type=hidden id="txtOCC_CD" size="1">
                    <td align="center" class="creamBold">실 시 일</td>
                    <td class="padding2423" >
                        <input id="txtPRO_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '실시일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgProYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgProYmd" name="ImgProYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPRO_YMD','','10','52');"></a>
                    </td>
                    <td align="center" class="creamBold">시력(좌)</td>
                    <td class="padding2423" >
                        <input id="txtEYE_LEF" maxlength="4" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">시력(우)</td>
                    <td class="padding2423" >
                        <input id="txtEYE_RHT" maxlength="4" style="width:100%;text-align:right;"onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">신&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td class="padding2423" >
                        <input id="txtHEIGHT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">체&nbsp;&nbsp;&nbsp;&nbsp;중</td>
                    <td class="padding2423" >
                        <input id="txtWEIGHT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">흉&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtAB_HGT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">색&nbsp;&nbsp;&nbsp;&nbsp;맹</td>
                    <td class="padding2423">
                        <input id="txtCBLD_CD" style="width:17%" maxlength="2"  onChange="fnc_GetCommNm('D4', 'txtCBLD_CD','txtCBLD_NM');"> <input id="txtCBLD_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCbldCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCbldCd" name="ImgCbldCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCBLD_CD','txtCBLD_NM','색맹','D4')"></a>
                    </td>
                    <td align="center" class="creamBold">혈 액 형</td>
                    <td class="padding2423" >
                        <input id="txtBLD_TYP" maxlength="5" style="width:100%">
                    </td>
                </tr>
            </table>

            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="72"></col>
                    <col width="64"></col>
                    <col width="165"></col>
                    <col width="64"></col>
                    <col width="165"></col>
                    <col width="64"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">병무사항</td>
                    <td align="center" class="creamBold">병무구분</td>                    
                    <td class="padding2423">
                        <input id="txtGUB_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F1', 'txtGUB_CD','txtGUB_NM');"> <input id="txtGUB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGubCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGubCd" name="ImgGubCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGUB_CD','txtGUB_NM','병무구분','F1')"></a>
                    </td>
                    <td align="center" class="creamBold">복무기간</td>                    
                    <td class="padding2423" colspan="3">
                        <input id="txtENL_YMD" style="width:20%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnlYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnlYmd" name="ImgEnlYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtENL_YMD','','420','0');"></a>
                        ~
                        <input id="txtMIL_YMD" style="width:20%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilYmd" name="ImgMilYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMIL_YMD','','535','0');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">군&nbsp;&nbsp;&nbsp;&nbsp;별</td>                    
                    <td class="padding2423">
                        <input id="txtMIL_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F4', 'txtMIL_CD','txtMIL_NM');"> <input id="txtMIL_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilCd" name="ImgMilCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMIL_CD','txtMIL_NM','군별','F4')"></a>
                    </td>
                    <td align="center" class="creamBold">병&nbsp;&nbsp;&nbsp;&nbsp;과</td>                    
                    <td class="padding2423">
                        <input id="txtMBK_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F7', 'txtMBK_CD','txtMBK_NM');"> <input id="txtMBK_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMbkCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMbkCd" name="ImgMbkCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMBK_CD','txtMBK_NM','병과','F7')"></a>
                    </td>
                    <td align="center" class="creamBold">계&nbsp;&nbsp;&nbsp;&nbsp;급</td>                    
                    <td class="padding2423">
                        <input id="txtGRADE" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F6', 'txtGRADE','txtGRADE_NM');"> <input id="txtGRADE_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrade','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGrade" name="ImgGrade" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRADE','txtGRADE_NM','계급','F6')"></a>
                    </td>
                </tr>
            </table>
                
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="72 "></col>
                    <col width="64 "></col>
                    <col width="106"></col>
                    <col width="64 "></col>
                    <col width="105"></col>
                    <col width="64 "></col>
                    <col width="106"></col>
                    <col width="64 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">기타정보</td>
                    <td align="center" class="creamBold">취&nbsp;&nbsp;&nbsp;&nbsp;미</td>
                    <td class="padding2423"><input id="txtHOBBY" maxlength="20" style="width:100%"></td>
                    <td align="center" class="creamBold">특&nbsp;&nbsp;&nbsp;&nbsp;기</td>
                    <td class="padding2423">
                        <input id="txtSPEC_CD" style="width:18%" maxlength="3" onChange="fnc_GetCommNm('D1', 'txtSPEC_CD','txtSPEC_NM');"> <input id="txtSPEC_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSpecCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSpecCd" name="ImgSpecCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSPEC_CD','txtSPEC_NM','특기','D1')"></a>
                    </td>
                    <td align="center" class="creamBold">결 혼 일</td>
                    <td class="padding2423">
                        <input id="txtWED_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '결혼일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgWedYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgWedYmd" name="ImgWedYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtWED_YMD','','120','80');"></a>
                    </td>
                    <td align="center" class="creamBold">종&nbsp;&nbsp;&nbsp;&nbsp;교</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:18%" maxlength="2" onChange="fnc_GetCommNm('D2', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','종교','D2')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO          Param=value Disable=disabled</C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO       Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR         Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT      Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO       Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO    Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL       Param=value </C>
        <C> Col=PRO_YMD       Ctrl=txtPRO_YMD      Param=value </C>
        <C> Col=EYE_LEF       Ctrl=txtEYE_LEF      Param=value </C>
        <C> Col=EYE_RHT       Ctrl=txtEYE_RHT      Param=value </C>
        <C> Col=HEIGHT        Ctrl=txtHEIGHT       Param=value </C>
        <C> Col=WEIGHT        Ctrl=txtWEIGHT       Param=value </C>
        <C> Col=AB_HGT        Ctrl=txtAB_HGT       Param=value </C>
        <C> Col=CBLD_CD       Ctrl=txtCBLD_CD      Param=value </C>
        <C> Col=CBLD_NM       Ctrl=txtCBLD_NM      Param=value </C>
        <C> Col=BLD_TYP       Ctrl=txtBLD_TYP      Param=value </C>
        
        <C> Col=HOBBY         Ctrl=txtHOBBY          Param=value </C>
        <C> Col=SPEC_CD       Ctrl=txtSPEC_CD        Param=value </C>
        <C> Col=SPEC_NM       Ctrl=txtSPEC_NM        Param=value </C>
        <C> Col=WED_YMD       Ctrl=txtWED_YMD        Param=value </C>
        <C> Col=REL_CD        Ctrl=txtREL_CD         Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM         Param=value </C>
    '>
</object>

<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_ARMY">
    <Param Name="BindInfo", Value='
        <C> Col=GUB_CD        Ctrl=txtGUB_CD       Param=value </C>
        <C> Col=GUB_NM        Ctrl=txtGUB_NM       Param=value </C>
        <C> Col=ENL_YMD       Ctrl=txtENL_YMD      Param=value </C>
        <C> Col=MIL_YMD       Ctrl=txtMIL_YMD      Param=value </C>        
        <C> Col=MIL_CD        Ctrl=txtMIL_CD       Param=value </C>
        <C> Col=MIL_NM        Ctrl=txtMIL_NM       Param=value </C>
        <C> Col=MBK_CD        Ctrl=txtMBK_CD       Param=value </C>
        <C> Col=MBK_NM        Ctrl=txtMBK_NM       Param=value </C>
        <C> Col=GRADE         Ctrl=txtGRADE        Param=value </C>
        <C> Col=GRADE_NM      Ctrl=txtGRADE_NM     Param=value </C>
    '>
</object>