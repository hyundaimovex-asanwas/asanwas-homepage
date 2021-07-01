<!--
    ************************************************************************************
    * @Source         : pira029.jsp                                                    *
    * @Description    : 기술경력관리 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>기술경력관리</title>
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

            dsT_CM_CAREER.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_CAREER.Reset();

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

                trT_CM_CAREER.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=SAV";
                trT_CM_CAREER.post();

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
            if (dsT_CM_CAREER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_CAREER.RowStatus(dsT_CM_CAREER.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_CAREER.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("행사일자[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"STR_YMD") + "] 참여사업명[" + dsT_CM_CAREER.NameValue(dsT_CM_CAREER.RowPosition,"PJT_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_CAREER.DeleteRow(dsT_CM_CAREER.RowPosition);

            if (status != 1) {
                trT_CM_CAREER.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira029.cmd.PIRA029CMD&S_MODE=DEL";
                trT_CM_CAREER.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_CAREER.SetColumn(form1.grdT_CM_CAREER.GetColumnID(0));
            form1.grdT_CM_CAREER.Focus();

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

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_CAREER.CountColumn == 0) {
                dsT_CM_CAREER.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, PJT_NM:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, ODR_NM:STRING, CMP_NM:STRING, JOB_NM:STRING, CHG_CD1:STRING, CHG_CD2:STRING, CHG_CD3:STRING, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_CAREER.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_CAREER.setColumn(form1.grdT_CM_CAREER.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtPJT_NM").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

            document.getElementById("txtSTR_YMD").focus();
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

			dsT_CM_CAREER.ClearData();
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

            //DataSet의 변경 여부 확인
            if (!dsT_CM_CAREER.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_CAREER.CountRow; i++ ) {
                if ( dsT_CM_CAREER.RowStatus(i) == 1 ||
                     dsT_CM_CAREER.RowStatus(i) == 3 ) {


                    // 시작일자
                    if( dsT_CM_CAREER.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일자는 필수 입력사항입니다.");
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_CAREER.NameValue(i, "STR_YMD"), "시작일자") && dsT_CM_CAREER.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 참여사업명
                    if( dsT_CM_CAREER.NameValue(i, "PJT_NM") == '' ) {
                        alert("참여사업명은 필수 입력사항입니다.");
                        dsT_CM_CAREER.RowPosition = i;
                        document.getElementById("txtPJT_NM").focus();
                        return false;
                    }

                    if ( dsT_CM_CAREER.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = true;
                       document.getElementById("txtPJT_NM").disabled = true;
                       document.getElementById("ImgStrYmd").disabled  = true;
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
			//alert(document.getElementById("ENO_NO").value)
            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_CAREER, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_PERSON.IsUpdated)  {
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
         /**
         * T_CM_COMMON(공통코드) 조회용 팝업 (부서 및 본부는 제외)
         * @param - ctrl_01 : 리턴받을 코드명
         * @param - ctrl_02 : 리턴받을 코드네임명
         * @param - ctrl_03 : 타이틀명
         * @param - ctrl_04 : cd_gbn 코드명
         * @param - ctrl_05 : 기준코드 gbn2_tag 사용 유무(Y/N)(20070313추가)
         * @param - ctrl_06 : 근로구분에 따른 코드구분(20070704추가)
         */
        function fnc_careerCodePopup(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

            var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
            obj.title   = ctrl_03;
            obj.cd_gbn  = ctrl_04;

            //값이 없으면 N으로 셋팅
            if(ctrl_05 == undefined || ctrl_05.trim() == ""){
                obj.gbn2_tag = "N";
            }else{
                obj.gbn2_tag = document.getElementById(ctrl_05).value;
            }

            //값이 없거나 공백이면 전체
            if(ctrl_06 == undefined){
                obj.occ_cd = "";
            }else{
                obj.occ_cd = ctrl_06;
            }

            window.showModalDialog("/common/popup/career.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.comm_cd != '' && obj.comm_nm != ''){
                document.getElementById(ctrl_01).value = obj.comm_cd;
                document.getElementById(ctrl_02).value = obj.comm_nm;
            }

        }

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtPJT_NM").disabled = false;
                document.getElementById("txtCMP_NM").disabled  = false;
                document.getElementById("txtODR_NM").disabled = false;

                document.getElementById("ImgStrYmd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtPJT_NM").disabled = true;
                document.getElementById("txtCMP_NM").disabled  = true;
                document.getElementById("txtODR_NM").disabled = true;

                document.getElementById("ImgStrYmd").disabled  = true;

            }
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
    | 2. 이름 : dsT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_CAREER                       |
    | 3. Table List : T_CM_CAREER                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_CAREER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_CAREER)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_CAREER.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtPJT_NM").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_CAREER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_CAREER Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[행사일자/참여사업명] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("행사일자/참여사업명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_CAREER event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_CAREER event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_CAREER Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_CAREER.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtPJT_NM").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtPJT_NM").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>기술 경력 사항</strong>
        </td>
        <td height="25" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">  <img src="/images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif"  name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="85 "></col>
                    <col width="175"></col>
                    <col width="97 "></col>
                    <col width="175"></col>
                    <col width="91 "></col>
                    <col width="175"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">참여사업명</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtPJT_NM" size="30" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="creamBold" rowspan="3">수행업무코드</td>
                    <td class="padding2423" >
                        <input  id="txtCHG_CD1" name="txtCHG_CD1" maxlength="1" style="width:17%" onChange="fnc_GetCommNm('S1', 'txtCHG_CD1','txtCHG_NM1')";>
                        <input  id="txtCHG_NM1" name="txtCHG_NM1" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd1" name="ImgCHG_Cd1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCHG_CD1','txtCHG_NM1','기술경력 대분류','S1')"></a>
                    </td>

                </tr>
                <tr>
                    <input type=hidden id="ENO_NO" size="10">
                    <td align="center" class="creamBold">시작일</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','70','52');"></a>
                    </td>
                    <td align="center" class="creamBold">종료일</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgENDYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgENDYmd" name="ImgENDYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','70','52');"></a>
                    </td>
<!--                     <td align="center" class="creamBold">수행업무코드2</td> -->
                    <td class="padding2423" >
                        <input  id="txtCHG_CD2" name="txtCHG_CD2" maxlength="2" style="width:17%" onChange="fnc_GetCommNm('S2', 'txtCHG_CD2','txtCHG_NM2')";>
                        <input  id="txtCHG_NM2" name="txtCHG_NM2" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd2" name="ImgCHG_Cd2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCHG_CD2','txtCHG_NM2','기술경력 중분류','S2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">발주처</td>
                    <td class="padding2423" >
                        <input id="txtODR_NM" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">소속사</td>
                    <td class="padding2423" >
                        <input id="txtCMP_NM" maxlength="20" style="width:100%">
                    </td>
<!--                     <td align="center" class="creamBold">수행업무코드3</td> -->
                    <td class="padding2423" >
                        <input  id="txtCHG_CD3" name="txtCHG_CD3" maxlength="4" style="width:17%" onChange="fnc_GetCommNm('S3', 'txtCHG_CD3','txtCHG_NM3')";>
                        <input  id="txtCHG_NM3" name="txtCHG_NM3" style="width:60%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCHG_Cd3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCHG_Cd3" name="ImgCHG_Cd3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_careerCodePopup('txtCHG_CD3','txtCHG_NM3','기술경력 소분류','S3','txtCHG_CD2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO" maxlength="10" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_NM" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">비고</td>
                    <td class="padding2423" >
                        <input id="txtREMARK" size="20" maxlength="60" style="width:100%">
                    </td>
                </tr>

            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_CAREER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:188px;">
                            <param name="DataID"                  value="dsT_CM_CAREER">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center    	</C>
                                <C> id=PJT_NM          width=300  name='참여사업명'                  	</C>
                                <C> id=STR_YMD         width=80   name='시작일자'     align=center 		</C>
                                <C> id=END_YMD         width=80   name='종료일자'     align=center	 	</C>
                                <C> id=ODR_NM          width=150  name='발주처'                     	</C>
                                <C> id=CMP_NM          width=150  name='소속사'                    		</C>
                                <C> id=JOB_NM          width=100  name='직위'                    		</C>
                                <C> id=CHG_CD1         width=40	  name='CD1'          align=center    	</C>
                                <C> id=CHG_NM1         width=100  name='직무 대분류'                  	</C>
                                <C> id=CHG_CD2         width=40	  name='CD2'          align=center     	</C>
                                <C> id=CHG_NM2         width=100  name='직무 중분류'                   	</C>
                                <C> id=CHG_CD3         width=40	  name='CD3'          align=center     	</C>
                                <C> id=CHG_NM3         width=150  name='직무 소분류'                   	</C>
                                <C> id=REMARK          width=300  name='비고'                    		</C>

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

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
"ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, ODR_NM:STRING, ATT_SBJ:STRING:KEYVALUETYPE,  CMP_NM:STRING"
**************************************************************
-->
<!-- 기술경력관리 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_CAREER">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=PJT_NM        Ctrl=txtPJT_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=ODR_NM        Ctrl=txtODR_NM       Param=value </C>
        <C> Col=CMP_NM        Ctrl=txtCMP_NM       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=CHG_CD1       Ctrl=txtCHG_CD1      Param=value </C>
        <C> Col=CHG_NM1       Ctrl=txtCHG_NM1      Param=value </C>
        <C> Col=CHG_CD2       Ctrl=txtCHG_CD2      Param=value </C>
        <C> Col=CHG_NM2       Ctrl=txtCHG_NM2      Param=value </C>
        <C> Col=CHG_CD3       Ctrl=txtCHG_CD3      Param=value </C>
        <C> Col=CHG_NM3       Ctrl=txtCHG_NM3      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>