<!--
    ************************************************************************************
    * @Source         : pira020.jsp                                                    *
    * @Description    : 자격면허 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>자격면허</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
    String p_mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >
    
        var p_mode = "<%=p_mode %>";
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_QUALIFICATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_QUALIFICATION.Reset();
            
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

                trT_CM_QUALIFICATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SAV";
                trT_CM_QUALIFICATION.post();

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
            if (dsT_CM_QUALIFICATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_QUALIFICATION.RowStatus(dsT_CM_QUALIFICATION.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_QUALIFICATION.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("자격면허[" + dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"QUA_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_QUALIFICATION.DeleteRow(dsT_CM_QUALIFICATION.RowPosition);

            if (status != 1) {
                trT_CM_QUALIFICATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=DEL";
                trT_CM_QUALIFICATION.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_QUALIFICATION.SetColumn(form1.grdT_CM_QUALIFICATION.GetColumnID(0));
            form1.grdT_CM_QUALIFICATION.Focus();

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
            if (dsT_CM_QUALIFICATION.CountColumn == 0) {
                dsT_CM_QUALIFICATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE,QUA_CD:STRING:KEYVALUETYPE,QUA_NM:STRING,GAN_YMD:STRING:KEYVALUETYPE,QUA_NO:STRING,APP_ADM:STRING,ETG_YN:STRING,QUA_AMT:DECIMAL");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_QUALIFICATION.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_QUALIFICATION.setColumn(form1.grdT_CM_QUALIFICATION.getColumnID(0));    
            
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"QUA_CD") = ' ';            
            dsT_CM_QUALIFICATION.NameValue(dsT_CM_QUALIFICATION.RowPosition,"GAN_YMD") = ' ';            

            
            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtQUA_CD").disabled  = false;
            document.getElementById("ImgQuaCd").disabled   = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;
            document.getElementById("cmbETG_YN").value = "X";
            document.getElementById("txtQUA_CD").focus();
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

			dsT_CM_QUALIFICATION.ClearData();
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
            if (!dsT_CM_QUALIFICATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_QUALIFICATION.CountRow; i++ ) {
                if ( dsT_CM_QUALIFICATION.RowStatus(i) == 1 ||
                     dsT_CM_QUALIFICATION.RowStatus(i) == 3 ) {


                    // 자격면허
                    if( dsT_CM_QUALIFICATION.NameValue(i, "QUA_CD") == '' ) {
                        alert("자격면허는 필수 입력사항입니다.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return false;
                    }

                    // 자격면허
                    if (dsT_CM_QUALIFICATION.NameValue(i, "QUA_CD") != "" &&
                        dsT_CM_QUALIFICATION.NameValue(i, "QUA_NM") == "") {
                        alert("자격면허코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtQUA_CD").focus();
                        return;
                    }

                    // 취득일자
                    if( dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD") == '' ) {
                        alert("취득일자는 필수 입력사항입니다.");
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }

                    // 취득일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD"), "취득일자") && dsT_CM_QUALIFICATION.NameValue(i, "GAN_YMD") != "") {
                        dsT_CM_QUALIFICATION.RowPosition = i;
                        document.getElementById("txtGAN_YMD").focus();
                        return false;
                    }


                    if ( dsT_CM_QUALIFICATION.RowStatus(i) == 1) {
                       document.getElementById("txtQUA_CD").disabled   = true;
                       document.getElementById("ImgQuaCd").disabled    = true;
                       document.getElementById("txtGAN_YMD").disabled  = true;
                       document.getElementById("ImgGanYmd").disabled   = true;
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

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_CM_QUALIFICATION, 0,"false","false");

            fnc_SearchList();

            //개인정보 조회시 처리
            if(p_mode == "read" || p_srcid == 'pirc010'){
                document.getElementById("txtGAN_YMD").className = "input_ReadOnly";
                document.getElementById("txtGAN_YMD").readOnly     = true;
                document.getElementById("txtQUA_NO").className = "input_ReadOnly";
                document.getElementById("txtQUA_NO").readOnly     = true;
                document.getElementById("txtAPP_ADM").className = "input_ReadOnly";
                document.getElementById("txtAPP_ADM").readOnly     = true;
                document.getElementById("cmbETG_YN").disabled  = true;

                document.getElementById("ImgQuaCd").style.display = "none";
                document.getElementById("ImgGanYmd").style.display = "none";
                document.getElementById("ImgAdd").style.display = "none";
                document.getElementById("imgSave").style.display = "none";
                document.getElementById("imgClear").style.display = "none";
                document.getElementById("imgDelete").style.display = "none";

				//수당지급 숨기기
                document.getElementById("cmbETG_YN").style.display = "none";
                document.getElementById("txtETG_YN").style.display = "none";
                //form1.grdT_CM_QUALIFICATION.ColumnProp("ETG_YN1","Show") = false;
            }

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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtQUA_CD").disabled  = false;
                document.getElementById("txtQUA_NM").disabled  = false;
                document.getElementById("txtGAN_YMD").disabled = false;
                document.getElementById("txtQUA_NO").disabled  = false;
                document.getElementById("txtAPP_ADM").disabled = false;
                document.getElementById("cmbETG_YN").disabled  = false;
                document.getElementById("ImgQuaCd").disabled    = false;
                document.getElementById("ImgGanYmd").disabled   = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtQUA_CD").disabled  = true;
                document.getElementById("txtQUA_NM").disabled  = true;
                document.getElementById("txtGAN_YMD").disabled = true;
                document.getElementById("txtQUA_NO").disabled  = true;
                document.getElementById("txtAPP_ADM").disabled = true;
                document.getElementById("cmbETG_YN").disabled  = true;
                document.getElementById("ImgQuaCd").disabled    = true;
                document.getElementById("ImgGanYmd").disabled   = true;

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
    | 2. 이름 : dsT_CM_QUALIFICATION                |
    | 3. Table List : T_CM_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_QUALIFICATION                |
    | 3. Table List : T_CM_QUALIFICATION            |
    +----------------------------------------------->
    <Object ID ="trT_CM_QUALIFICATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_QUALIFICATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_QUALIFICATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_QUALIFICATION.CountRow);

            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_QUALIFICATION Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_QUALIFICATION Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            //alert("해당 필수입력항목[자격면허코드/취득일] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019 ) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

            alert("자격면허코드/취득일에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("자격면허코드/취득일에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_QUALIFICATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_QUALIFICATION event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language=JavaScript for=dsT_CM_QUALIFICATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_QUALIFICATION.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtQUA_CD").disabled   = false;
            document.getElementById("ImgQuaCd").disabled    = false;
            document.getElementById("txtGAN_YMD").disabled  = false;
            document.getElementById("ImgGanYmd").disabled   = false;

        }
        else {
            document.getElementById("txtQUA_CD").disabled   = true;
            document.getElementById("ImgQuaCd").disabled    = true;
            document.getElementById("txtGAN_YMD").disabled  = true;
            document.getElementById("ImgGanYmd").disabled   = true;

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
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>자격면허</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                    <col width="100 "></col>
                    <col width="200"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">자격면허</td>
                    <td class="padding2423">
                        <input id="txtQUA_CD" style="width:22%" maxlength="3" onChange="fnc_GetCommNm('H1', 'txtQUA_CD','txtQUA_NM');"> <input id="txtQUA_NM" style="width:58%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgQuaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgQuaCd" name="ImgQuaCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtQUA_CD','txtQUA_NM','자격면허','H1')"></a>
                    </td>
                    <td align="center" class="blueBold">취 득 일</td>
                    <td class="padding2423" >
                        <input id="txtGAN_YMD" style="width:83%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '취득일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGanYmd" name="ImgGanYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGAN_YMD','','340','52');"></a>
                    </td>
                    <td align="center" class="blueBold">발 행 처</td>
                    <td class="padding2423" >
                        <input id="txtAPP_ADM" maxlength="50" style="width:100%">
                    </td>                    
                </tr>
                <tr>
                    <td align="center" class="blueBold">증서번호</td>
                    <td class="padding2423" >
                        <input id="txtQUA_NO" maxlength="50" style="width:100%">
                    </td>                
                    <td align="center" class="blueBold"><span id="txtETG_YN">수당지급</span></td>
                    <td class="padding2423">
                        <select id="cmbETG_YN" style="width:100%" >
                            <option value="" ></option>
                            <option value="0" >무</option>
                            <option value="3" >유</option>
                            <option value="1" >1급</option>
                            <option value="2" >2급</option>
                            <option value="6" >특정</option>
                            <option value="4" >전문</option>
                            <option value="5" >일반</option>
                        </select>
                    </td>                
                    <td align="center" class="blueBold">수 당 금 액</td>
                    <td class="padding2423" >
                        <input id="txtQUA_AMT" style="width:83%;ime-mode:disabled" maxlength="10" >
                    </td>
                </tr>

            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:290px;">
                            <param name="DataID"                  value="dsT_CM_QUALIFICATION">
                            <param name="ViewSummary"  		value="1">
                            <param name="Format"                  value="
                                <C> id={currow}           width=42   	name='순번'         	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_CD           width=80   	name='자격면허코드' 	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_NM          width=150   name='자격면허'        align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=GAN_YMD         width=90   	name='취득일'       	align=center 	SumBgColor=#C3D0DB</C>
                                <C> id=QUA_NO           width=180   name='증서번호'       align=center     SumBgColor=#C3D0DB</C>
                                <C> id=APP_ADM          width=250   name='발행처'          align=center    SumBgColor=#C3D0DB</C>
                                <C> id=ETG_YN           width=100    name='수당지급'     	align=center     SumBgColor=#C3D0DB SumText='총계' value={Decode(ETG_YN,'0','미지급','1','1급','2','2급','3','지급','4','전문','5','일반','6','특정',ETG_YN)} </C>
                                <C> id=QUA_AMT         width=100    name='금액'     		align=right 	    SumBgColor=#C3D0DB SumText=@sum</C>                                
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
**************************************************************
-->
<!-- 자격면허 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_QUALIFICATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=QUA_CD       Ctrl=txtQUA_CD       Param=value </C>
        <C> Col=QUA_NM       Ctrl=txtQUA_NM       Param=value </C>
        <C> Col=GAN_YMD      Ctrl=txtGAN_YMD      Param=value </C>
        <C> Col=APP_ADM,      Ctrl=txtAPP_ADM      Param=value </C>        
        <C> Col=QUA_NO       Ctrl=txtQUA_NO       Param=value </C>
        <C> Col=ETG_YN         Ctrl=cmbETG_YN       Param=value </C>
        <C> Col=QUA_AMT      Ctrl=txtQUA_AMT       Param=value </C>
    '>
</object>