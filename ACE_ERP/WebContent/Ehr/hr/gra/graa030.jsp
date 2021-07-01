<!--
***********************************************************************
* @source      : graa030.jsp
* @description : 승급심사개인별입력 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/11      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>승급심사개인별입력(graa030)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TFTTFFFT';
        var rai_ymd = getToday().substring(0,5)+"03-01";
        var compFlag = "false";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var rai_ymd = document.getElementById('txtRAI_YMD_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;

            if(!fnc_SearchItemCheck()) return;

            trT_PM_GRADE_SHR.KeyValue   = "tr01"
                                        + "(O:dsT_PM_GRADE=dsT_PM_GRADE"
                                        + ",O:dsT_CP_WORKLOG=dsT_CP_WORKLOG"
                                        + ")";
            trT_PM_GRADE_SHR.action     = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa030.cmd.GRAA030CMD&S_MODE=SHR&RAI_YMD="+rai_ymd+"&ENO_NO="+eno_no;
            trT_PM_GRADE_SHR.post();

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

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			trT_PM_GRADE.KeyValue = "tr01(I:dsT_PM_GRADE=dsT_PM_GRADE)";
			trT_PM_GRADE.action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa030.cmd.GRAA030CMD&S_MODE=SAV";
			trT_PM_GRADE.post();
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

			//document.getElementById('txtRAI_YMD_SHR').value = rai_ymd;
			document.getElementById('txtENO_NO_SHR').value = '';
			document.getElementById('txtENO_NM_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_GRADE.ClearData();
            dsT_CP_WORKLOG.ClearData();
            dsT_CP_PAYMASTER.ClearData();

            document.getElementById('txtFIN_HOB').className = "input_ReadOnly";
            document.getElementById('txtFIN_HOB').readOnly = true;
            form1.medFIN_SAL.Enable = "false";
            document.getElementById('txtREMARK').className = "input_ReadOnly";
            document.getElementById('txtREMARK').readOnly = true;

            document.getElementById("imgInputcomplete").style.display = "";

            document.getElementById('txtRAI_YMD_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_PM_GRADE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var rai_ymd = document.getElementById("txtRAI_YMD_SHR");
            var eno_no = document.getElementById("txtENO_NO_SHR");

            if(rai_ymd.value == ""){
                alert("승급예정일은 반드시 입력하셔야 합니다!");
                rai_ymd.focus();
                return false;
            }

            /*
            if(eno_no.value == "") {
                alert("사번은 반드시 입력하셔야 합니다.");
                eno_no.focus();
                return false;
            }
            */

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_PM_GRADE.IsUpdated ) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_PM_GRADE,0,"true","true");      // Grid Style 적용

            document.getElementById('txtRAI_YMD_SHR').value = rai_ymd;

            document.getElementById('txtFIN_HOB').className = "input_ReadOnly";
            document.getElementById('txtFIN_HOB').readOnly = true;
            form1.medFIN_SAL.Enable = "false";
            document.getElementById('txtREMARK').className = "input_ReadOnly";
            document.getElementById('txtREMARK').readOnly = true;

            document.getElementById("imgInputcomplete").style.display = "";

            document.getElementById('txtRAI_YMD_SHR').focus();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        /**
         * 신규호봉과 확정호봉 비교 (강급시 확인 메시지)
         */
        function checkHob() {
            var vConHob = Number(document.getElementById("txtCON_HOB").value);//조정호봉
            var vFinHob = Number(document.getElementById("txtFIN_HOB").value);//확정호봉

            if(vConHob > vFinHob) {
                if(!confirm("확정호봉이 강급 되었습니다.\n계속하시겠습니까?")) {
                    //document.getElementById("txtFIN_HOB").focus();
                    return;
                }
            }

            var vOCC_CD     = document.getElementById("txtOCC_CD").value;
            var vSTTJ_CD    = document.getElementById("txtSTTJ_CD").value;
            var vFIN_HOB    = document.getElementById("txtFIN_HOB").value;

            //해당 호봉의 급여를 가져오기
            dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa030.cmd.GRAA030CMD"
                                    + "&S_MODE=SHR_PAY"
                                    + "&OCC_CD="+vOCC_CD
                                    + "&JOB_CD="+vSTTJ_CD
                                    + "&HOB_CD="+vFIN_HOB;

            dsT_CP_PAYMASTER.reset();
        }


        /**
         * 승급심사개인별입력 완료
         */
        function fnc_ProcessComplete() {
            var rai_ymd = document.getElementById('txtRAI_YMD_SHR').value;

            if(dsT_CP_WORKLOG.CountRow == 0) {
                alert("조회를 먼저 해주세요.");
                return;
            }

            if(!confirm("승급심사개인별입력을 완료하시겠습니까?")) {
                return;
            }

            dsT_CP_WORKLOG.UseChangeInfo = false;

            trT_PM_GRADE.KeyValue = "tr01(I:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_GRADE.action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa030.cmd.GRAA030CMD&S_MODE=SAV_LOG&RAI_YMD="+rai_ymd;
            trT_PM_GRADE.post();
        }

	</script>


 </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_PM_GRADE)    |
    | 3. 사용되는 Table List(T_PM_GRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_PM_GRADE)	    |
    | 3. 사용되는 Table List(T_PM_GRADE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_PM_GRADE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_PM_GRADE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            //alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if(iCount == 1) {
            form1.medFIN_SAL.Text = dsT_CP_PAYMASTER.NameValue(1, "STMT_AMT");
        } else {
            form1.medFIN_SAL.Text = "0";
        }
    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        if(dsT_CP_WORKLOG.CountRow == 1){ // 저장
            if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                document.getElementById('txtFIN_HOB').className = "";
                document.getElementById('txtFIN_HOB').readOnly = false;
                //form1.medFIN_SAL.Enable = "true";
                document.getElementById('txtREMARK').className = "";
                document.getElementById('txtREMARK').readOnly = false;

                document.getElementById("imgInputcomplete").style.display = "";

            } else if(Number(dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) >= 2) {
                document.getElementById('txtFIN_HOB').className = "input_ReadOnly";
	            document.getElementById('txtFIN_HOB').readOnly = true;
	            form1.medFIN_SAL.Enable = "false";
	            document.getElementById('txtREMARK').className = "input_ReadOnly";
	            document.getElementById('txtREMARK').readOnly = true;

	            document.getElementById("imgInputcomplete").style.display = "none";

	            if(compFlag == "false"){
                    alert("이미 승급심사개인별입력 처리가 되었습니다.");
                }

            }

        }else{
            document.getElementById('txtFIN_HOB').className = "input_ReadOnly";
            document.getElementById('txtFIN_HOB').readOnly = true;
            form1.medFIN_SAL.Enable = "false";
            document.getElementById('txtREMARK').className = "input_ReadOnly";
            document.getElementById('txtREMARK').readOnly = true;

            document.getElementById("imgInputcomplete").style.display = "none";

            alert("승급대상자선정이 완료되지 않았습니다.");
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_PM_GRADE event="OnSuccess()">

        compFlag = "true";//조회시 메세지 문제 관련

        fnc_SearchList();

        compFlag = "false";
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_PM_GRADE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script language=JavaScript for=dsT_PM_GRADE event=OnRowPosChanged(row)>

        document.getElementById('txtFIN_HOB').className = "";
        document.getElementById('txtFIN_HOB').readOnly = false;
        //form1.medFIN_SAL.Enable = "true";
        document.getElementById('txtREMARK').className = "";
        document.getElementById('txtREMARK').readOnly = false;

        if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2" || dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
	        document.getElementById('txtFIN_HOB').className = "input_ReadOnly";
	        document.getElementById('txtFIN_HOB').readOnly = true;
	        form1.medFIN_SAL.Enable = "false";
	        document.getElementById('txtREMARK').className = "input_ReadOnly";
	        document.getElementById('txtREMARK').readOnly = true;
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">승급심사개인별입력</td>
                    <td align="right" class="navigator">HOME/인사관리/승급/<font color="#000000">승급심사개인별입력</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="100"></col>
                                <col width="120"></col>
                                <col width="100"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">승급예정일&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtRAI_YMD_SHR" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','75','110');"></a>
                                </td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">승급예정일</td>
                    <td class="padding2423">
                        <input id="txtRAI_YMD" size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">사 번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">성 명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">소 속</td>
                    <td class="padding2423" colspan="3"><input id="txtDPT_CD" size="4" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">기준직위</td>
                    <td class="padding2423"><input id="txtSTTJ_CD" size="4" class="input_ReadOnly" readonly>
                        <input id="txtSTTJ_NM" size="8" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">개인직위</td>
                    <td class="padding2423"><input id="txtPJOB_CD" size="4" class="input_ReadOnly" readonly>
                        <input id="txtPJOB_NM" size="8" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">입사일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">그룹입사일</td>
                    <td class="padding2423">
                        <input id="txtGHI_YMD" size="20" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">최종승진일</td>
                    <td class="padding2423">
                        <input id="txtFPRO_YMD" size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">최종승급일</td>
                    <td class="padding2423">
                        <input id="txtHBA_YMD" size="15" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">근로구분</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" type="hidden">
                        <input id="txtOCC_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">승급구분코드</td>
                    <td class="padding2423">
                        <input id="txtRAI_CD" size="20" class="input_ReadOnly" readonly>
                    </td>
                <tr>
                    <td align="center" class="creamBold" colspan="2">년차수(기준일현재)</td>
                    <td class="padding2423">
                        <input id="txtYRP_CNT" size="11" style="text-align:right" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">비 고</td>
                    <td class="padding2423" colspan="4">
                        <input id="txtREMARK" size="65" maxlength="60">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">현행호봉기준</td>
                    <td align="center" class="creamBold">현재호봉</td>
                    <td class="padding2423">
                        <input id="txtHOB" size="4" class="input_ReadOnly" readonly style="ime-mode:disabled;text-align:center;"> 호봉
                    </td>
                    <td align="center" class="creamBold">현재급여</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=false>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">기준호봉</td>
                    <td class="padding2423">
                        <input id="txtBAS_HOB" size="4" class="input_ReadOnly" readonly style="ime-mode:disabled;text-align:center;"> 호봉
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">신규호봉기준</td>
                    <td align="center" class="creamBold">조정호봉</td>
                    <td class="padding2423">
                        <input id="txtCON_HOB" size="4"class="input_ReadOnly" readonly style="ime-mode:disabled;text-align:center;"> 호봉
                    </td>
                    <td align="center" class="creamBold">조정급여</td>
                    <td class="padding2423" colspan="3">
                        <comment id="__NSID__"><object id="medCON_SAL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=false>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" colspan="2">최종확정사항</td>
                    <td align="center" class="creamBold">확정호봉</td>
                    <td class="padding2423">
                        <input id="txtFIN_HOB" size="4" maxLength="2" onkeypress="cfCheckNumber2();" style="ime-mode:disabled;text-align:center;" onfocusout="this.value = lpad(this.value, 2, 0);checkHob();"> 호봉
                    </td>
                    <td align="center" class="creamBold">확정급여</td>
                    <td class="padding2423" colspan="3">
                        <comment id="__NSID__"><object id="medFIN_SAL" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=9>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td class="searchState" align="right" height="20">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInputcomplete','','/images/button/btn_InputcompleteOver.gif',1)"> <img src="/images/button/btn_InputcompleteOn.gif" name="imgInputcomplete"  width="80" height="20" border="0" align="absmiddle" onClick="fnc_ProcessComplete()"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object	id="grdT_PM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                            <param name="DataID"					value="dsT_PM_GRADE">
                            <param name="SortView"                value="right">
                            <param name="Format"					value="
                                <C> id={currow}		width=29    name='NO'			    align=center </C>
                                <C> id='RAI_YMD'	width=70	name='승급예정일'	    align=center </C>
                                <C> id='DPT_CD'		width=35	name='코드'			    align=center show='false' </C>
                                <C> id='DPT_NM'		width=100	name='소속'             align=center </C>
                                <C> id='PJOB_CD'	width=35	name='코드'			    align=center show='false' </C>
                                <C> id='PJOB_NM'	width=50	name='직위'             align=center </C>
                                <C> id='ENO_NO'     width=70    name='사번'             align=center </C>
                                <C> id='ENO_NM'     width=70    name='성명'             align=center </C>
                                <C> id='OCC_CD'     width=35    name='코드'             align=center show='false' </C>
                                <C> id='OCC_NM'     width=50    name='근로구분'             align=center </C>
                                <C> id='STTJ_CD'    width=35    name='코드'             align=center show='false' </C>
                                <C> id='STTJ_NM'    width=50    name='기준;직위'        align=center </C>
                                <C> id='HIR_YMD'	width=70	name='입사일'		    align=center </C>
                                <C> id='GHI_YMD'	width=70	name='그룹입사일'	    align=center </C>
                                <C> id='FPRO_YMD'	width=70	name='최종승진일'	    align=center </C>
                                <C> id='HBA_YMD'	width=70	name='최종승급일'       align=center </C>
                                <C> id='YRP_CNT'	width=40	name='현직위;년차수'    align=right  </C>
                                <C> id='RAI_CD'	    width=40	name='승급;구분'	    align=center show='false' </C>
                                <C> id='BAS_HOB'	width=40	name='기준;호봉'	    align=center </C>
                                <C> id='HOB'    	width=40	name='현재;호봉'	    align=center </C>
                                <C> id='SAL_AMT'	width=70	name='현재급여'	        align=right  </C>
                                <C> id='CON_HOB'	width=40	name='조정;호봉'	    align=center </C>
                                <C> id='CON_SAL'	width=70	name='조정급여'	        align=right  </C>
                                <C> id='FIN_HOB'	width=40	name='확정;호봉'	    align=center </C>
                                <C> id='FIN_SAL'	width=70	name='확정급여'	        align=right  </C>
                                <C> id='REMARK'	    width=200	name='비고'	            align=left   </C>
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
<!-- ***** 설정 테이블 -->
<object id="bndT_PM_GRADE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_PM_GRADE">
	<Param Name="BindInfo", Value='
        <C>Col=RAI_YMD	Ctrl=txtRAI_YMD         Param=value     </C>
        <C>Col=RAI_CD	Ctrl=txtRAI_CD          Param=value     </C>
        <C>Col=ENO_NO	Ctrl=txtENO_NO          Param=value     </C>
        <C>Col=ENO_NM	Ctrl=txtENO_NM          Param=value     </C>
        <C>Col=DPT_CD	Ctrl=txtDPT_CD          Param=value     </C>
        <C>Col=DPT_NM	Ctrl=txtDPT_NM          Param=value     </C>
        <C>Col=STTJ_CD	Ctrl=txtSTTJ_CD         Param=value     </C>
        <C>Col=STTJ_NM	Ctrl=txtSTTJ_NM         Param=value     </C>
        <C>Col=PJOB_CD	Ctrl=txtPJOB_CD         Param=value     </C>
        <C>Col=PJOB_NM	Ctrl=txtPJOB_NM         Param=value     </C>
        <C>Col=HIR_YMD	Ctrl=txtHIR_YMD         Param=value     </C>
        <C>Col=GHI_YMD  Ctrl=txtGHI_YMD         Param=value     </C>
        <C>Col=FPRO_YMD Ctrl=txtFPRO_YMD        Param=value     </C>
        <C>Col=HBA_YMD  Ctrl=txtHBA_YMD         Param=value     </C>
        <C>Col=YRP_CNT  Ctrl=txtYRP_CNT         Param=value     </C>
        <C>Col=OCC_CD   Ctrl=txtOCC_CD          Param=value     </C>
        <C>Col=OCC_NM   Ctrl=txtOCC_NM          Param=value     </C>
        <C>Col=BAS_HOB  Ctrl=txtBAS_HOB         Param=value     </C>
        <C>Col=HOB      Ctrl=txtHOB             Param=value     </C>
        <C>Col=SAL_AMT  Ctrl=medSAL_AMT         Param=text      </C>
        <C>Col=CON_HOB  Ctrl=txtCON_HOB         Param=value     </C>
        <C>Col=CON_SAL  Ctrl=medCON_SAL         Param=text      </C>
        <C>Col=FIN_HOB  Ctrl=txtFIN_HOB         Param=value     </C>
        <C>Col=FIN_SAL  Ctrl=medFIN_SAL         Param=text      </C>
        <C>Col=REMARK   Ctrl=txtREMARK          Param=value     </C>
    '>
</object>