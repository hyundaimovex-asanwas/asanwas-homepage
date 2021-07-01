<!--
    ************************************************************************************
    * @source         : saga021.jsp 				                                                                                     *
    * @description   : 상여계산처리(상여지급기준) PAGE.                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/22  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>상여계산처리(상여지급기준)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'FFTFFFFT';

        var dsT_CP_WORKLOG = window.dialogArguments;//opener에서 받아온다.

        /********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {
			var i = 1;

			var PIS_YY = dsT_CP_WORKLOG.NameValue(i,"PIS_YY");
			var PIS_MM = dsT_CP_WORKLOG.NameValue(i,"PIS_MM");
			var OCC_CD = dsT_CP_WORKLOG.NameValue(i,"OCC_CD");
			var SAL_GBN = dsT_CP_WORKLOG.NameValue(i,"SAL_GBN");
			var SEQ = dsT_CP_WORKLOG.NameValue(i,"SEQ");

            //데이터셋 전송
            dsT_CP_BOUNS_BASIS.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona021.cmd.BONA021CMD&S_MODE=SHR&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN+"&SEQ="+SEQ;
            dsT_CP_BOUNS_BASIS.Reset();
        }

   		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

   			if( !fnc_SaveItemCheck() )	return;

			var i = 1;

			var PIS_YY = dsT_CP_WORKLOG.NameValue(i,"PIS_YY");
			var PIS_MM = dsT_CP_WORKLOG.NameValue(i,"PIS_MM");
			var OCC_CD = dsT_CP_WORKLOG.NameValue(i,"OCC_CD");
			var SAL_GBN = dsT_CP_WORKLOG.NameValue(i,"SAL_GBN");
			var SEQ = dsT_CP_WORKLOG.NameValue(i,"SEQ");
			var PRO_STS = "7";//대상자추가

			var ATT_C1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C1_PCT");
			var ATT_C2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C2_PCT");
			var ATT_A1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A1_PCT");
			var ATT_A2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A2_PCT");
			var ATT_B1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B1_PCT");
			var ATT_B2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B2_PCT");
			var APPLY_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT");
			var APPLY_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT");
			var L31_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_1_PCT");
			var L31_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_2_PCT");
			var L31_3_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_3_PCT");
			var L58_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L58_1_PCT");
			var L58_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L58_2_PCT");
			var L55_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L55_1_PCT");
			var L51_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L51_1_PCT");

			//저장된 값이 없을때 작업상태값 미변경
			if(ATT_C1_PCT== "0" && ATT_C2_PCT== "0" && ATT_A1_PCT== "0" && ATT_A2_PCT== "0" && ATT_B1_PCT== "0" && ATT_B2_PCT== "0" &&
                    (APPLY_1_PCT == "" || APPLY_1_PCT == "F") && (APPLY_2_PCT == "" || APPLY_2_PCT == "F") &&
                    L31_1_PCT== "0" && L31_2_PCT== "0" && L31_3_PCT== "0" && L58_1_PCT== "0" && L58_2_PCT== "0" && L55_1_PCT== "0" && L51_1_PCT == "0"){

            	PRO_STS = "1";//대상자추가

			}

			dsT_CP_BOUNS_BASIS.NameValue(i,"PIS_YY") = PIS_YY;
			dsT_CP_BOUNS_BASIS.NameValue(i,"PIS_MM") = PIS_MM;
			dsT_CP_BOUNS_BASIS.NameValue(i,"OCC_CD") = OCC_CD;
			dsT_CP_BOUNS_BASIS.NameValue(i,"SAL_GBN") = SAL_GBN;
			dsT_CP_BOUNS_BASIS.NameValue(i,"SEQ") = SEQ;

			//트랜잭션 전송
			trT_CP_BOUNS_BASIS.KeyValue = "SVL(I:SAV=dsT_CP_BOUNS_BASIS)";
			trT_CP_BOUNS_BASIS.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona021.cmd.BONA021CMD&S_MODE=SAV&PRO_STS="+PRO_STS;
			trT_CP_BOUNS_BASIS.Post();

        }

		/******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			fnc_OnLoadProcess();
			dsT_CP_BOUNS_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_BOUNS_BASIS.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CP_BOUNS_BASIS.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oPIS_YYMM;

			/*
			oPIS_YYMM = dsT_CP_BOUNS_BASIS.NameValue(i,"PIS_YYMM");
			if(oPIS_YYMM.trim().length == 0){
				alert("적용일이 잘못되었습니다.");
				dsT_CP_BOUNS_BASIS.RowPosition = i;
				return false;
			}
			*/

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			fnc_SearchList();

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

		function fnc_APPLY() {

			var i = 1;

			if(document.getElementById("chkAPPLY_1_PCT").checked == true){
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT") = "T";
			}else{
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT") = "F";
			}

			if(document.getElementById("chkAPPLY_2_PCT").checked == true){
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT") = "T";
			}else{
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT") = "F";
			}

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_BOUNS_BASIS                                 |
    | 3. Table List : T_CP_BOUNS_BASIS                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_BOUNS_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_BOUNS_BASIS                                    |
    | 3. Table List : T_CP_BOUNS_BASIS                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_BOUNS_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_BOUNS_BASIS Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
	        dsT_CP_BOUNS_BASIS.AddRow();
            var i = 1;

	        if (confirm("현재 설정된 상여적용기준이 없습니다. 기본값을 입력하시겠습니까?") == false) return;

           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C1_PCT") = "9.9";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C2_PCT") = "3.3";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A1_PCT") = "9.9";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A2_PCT") = "3.3";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B1_PCT") = "9.9";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B2_PCT") = "5";
           	document.getElementById("chkAPPLY_1_PCT").checked = true;
           	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT") = "T";
           	document.getElementById("chkAPPLY_2_PCT").checked = true;
           	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT") = "T";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_1_PCT") = "5";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_2_PCT") = "10";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_3_PCT") = "20";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L58_1_PCT") = "20";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L58_2_PCT") = "40";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L55_1_PCT") = "50";
           	dsT_CP_BOUNS_BASIS.NameValue(i,"L51_1_PCT") = "100";

			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
            var i = 1;
			var ATT_C1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C1_PCT");
			var ATT_C2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C2_PCT");
			var ATT_A1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A1_PCT");
			var ATT_A2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A2_PCT");
			var ATT_B1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B1_PCT");
			var ATT_B2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B2_PCT");
			var APPLY_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT");
			var APPLY_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT");
			var L31_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_1_PCT");
			var L31_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_2_PCT");
			var L31_3_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L31_3_PCT");
			var L58_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L58_1_PCT");
			var L58_2_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L58_2_PCT");
			var L55_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L55_1_PCT");
			var L51_1_PCT = dsT_CP_BOUNS_BASIS.NameValue(i,"L51_1_PCT");

	        //저장된 값이 없을때 기본값 셋팅
			if(ATT_C1_PCT== "0" && ATT_C2_PCT== "0" && ATT_A1_PCT== "0" && ATT_A2_PCT== "0" && ATT_B1_PCT== "0" && ATT_B2_PCT== "0" &&
                    (APPLY_1_PCT == "" || APPLY_1_PCT == "F") && (APPLY_2_PCT == "" || APPLY_2_PCT == "F") &&
                    L31_1_PCT== "0" && L31_2_PCT== "0" && L31_3_PCT== "0" && L58_1_PCT== "0" && L58_2_PCT== "0" && L55_1_PCT== "0" && L51_1_PCT == "0"){

	            if (confirm("현재 설정된 상여적용기준이 없습니다. 기본값을 입력하시겠습니까?") == false) return;

            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C1_PCT") = "9.9";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_C2_PCT") = "3.3";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A1_PCT") = "9.9";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_A2_PCT") = "3.3";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B1_PCT") = "9.9";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"ATT_B2_PCT") = "5";
            	document.getElementById("chkAPPLY_1_PCT").checked = true;
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_1_PCT") = "T";
            	document.getElementById("chkAPPLY_2_PCT").checked = true;
            	dsT_CP_BOUNS_BASIS.NameValue(i,"APPLY_2_PCT") = "T";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_1_PCT") = "5";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_2_PCT") = "10";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L31_3_PCT") = "20";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L58_1_PCT") = "20";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L58_2_PCT") = "40";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L55_1_PCT") = "50";
            	dsT_CP_BOUNS_BASIS.NameValue(i,"L51_1_PCT") = "100";

            }else{
				if(APPLY_1_PCT == "T"){
	            	document.getElementById("chkAPPLY_1_PCT").checked = true;
				}else{
	            	document.getElementById("chkAPPLY_1_PCT").checked = false;
				}

				if(APPLY_2_PCT == "T"){
	            	document.getElementById("chkAPPLY_2_PCT").checked = true;
	            }else{
	            	document.getElementById("chkAPPLY_2_PCT").checked = false;
				}

            }

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_BOUNS_BASIS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_BOUNS_BASIS Event="OnDataError()">
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
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_BOUNS_BASIS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_BOUNS_BASIS event="OnFail()">
        cfErrorMsg(this);
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
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">상여지급기준</td>
					<td align="right" class="navigator">HOME/보상관리/상여관리/상여계산처리/<font color="#000000">상여지급기준</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInsert','','/images/button/btn_InsertOver.gif',1)">    <img src="/images/button/btn_InsertOn.gif"   name="imgInsert"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)">    <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a> -->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>근태적용율(%)</strong></td>
        <td class="paddingTop8" align="right">대상기간 : 1월 1일 ~ 12월 31일</td>
    </tr>
    <tr>
        <td class="paddingTop5" colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">지각</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="100"></col>
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*9회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_C1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;추가 3회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_C2_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">유계결근</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="100"></col>
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*3회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_A1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;추가 1회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_A2_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">무계결근</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="100"></col>
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*2회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_B1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;추가 1회</td>
								<td>
									<comment id="__NSID__"><object id="medATT_B2_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>고과적용</strong></td>
        <td class="paddingTop15">&nbsp;</td>
    </tr>
    <tr>
        <td class="paddingTop5" colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">반영여부</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="70"></col>
								<col width="88"></col>
								<col width="75"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*성과반영</td>
								<td><input type="checkbox" id="chkAPPLY_1_PCT" style="border:0" align="absmiddle" onclick="fnc_APPLY();"></td>
								<td>&nbsp;&nbsp;&nbsp;*상여반영</td>
								<td><input type="checkbox" id="chkAPPLY_2_PCT" style="border:0" align="absmiddle" onclick="fnc_APPLY();"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="550" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>징계적용율(%)</strong></td>
        <td class="paddingTop15">&nbsp;</td>
    </tr>
    <tr>
        <td class="paddingTop5" colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">견책/출근정지</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="65"></col>
								<col width="70"></col>
								<col width="65"></col>
								<col width="70"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*1회</td>
								<td>
									<comment id="__NSID__"><object id="medL31_1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*2회</td>
								<td>
									<comment id="__NSID__"><object id="medL31_2_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*3회</td>
								<td>
									<comment id="__NSID__"><object id="medL31_3_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
							<tr>
								<td colspan="6">&nbsp;&nbsp;*4회이상 제외</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">감봉</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="65"></col>
								<col width="70"></col>
								<col width="65"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*1회</td>
								<td>
									<comment id="__NSID__"><object id="medL58_1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*2회</td>
								<td>
									<comment id="__NSID__"><object id="medL58_2_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*3회이상 제외</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">강급</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="65"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*1회</td>
								<td>
									<comment id="__NSID__"><object id="medL55_1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*2회이상 제외</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">정직/강격</td>
					<td class="padding2423">
						<table width="100%" border="0" >
							<colgroup>
								<col width="50"></col>
								<col width="65"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td>&nbsp;&nbsp;*1회</td>
								<td>
									<comment id="__NSID__"><object id="medL51_1_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:65">
										<param name=Alignment					value=2>
										<param name=Border						value=true>
										<param name=ClipMode					value=true>
										<param name=DisabledBackColor	value="#EEEEEE">
										<param name=Enable						value=true>
										<param name=IsComma					value=true>
										<param name=Language					value=0>
										<param name=MaxLength				value=3>
										<param name=Numeric					value=true>
										<param name=ShowLiteral				value="false">
										<param name=Visible						value="true">
										<param name=MaxDecimalPlace     value=2>
										<param name=VisibleMaxDecimal   value="true">
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*2회이상 제외</td>
							</tr>
						</table>
					</td>
				</tr>

			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="550" border="0" cellspacing="0" cellpadding="0">
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

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_CP_BOUNS_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_BOUNS_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=ATT_C1_PCT     		 	Ctrl=medATT_C1_PCT     		 	Param=text	 		</C>
		<C>Col=ATT_C2_PCT     		 	Ctrl=medATT_C2_PCT     		 	Param=text	 		</C>
		<C>Col=ATT_A1_PCT     		 	Ctrl=medATT_A1_PCT     		 	Param=text	 		</C>
		<C>Col=ATT_A2_PCT     		 	Ctrl=medATT_A2_PCT     		 	Param=text	 		</C>
		<C>Col=ATT_B1_PCT     		 	Ctrl=medATT_B1_PCT     		 	Param=text	 		</C>
		<C>Col=ATT_B2_PCT     		 	Ctrl=medATT_B2_PCT     		 	Param=text	 		</C>
		<C>Col=APPLY_1_PCT     		 	Ctrl=chkAPPLY_1_PCT     		 	Param=value 		</C>
		<C>Col=APPLY_2_PCT     		 	Ctrl=chkAPPLY_2_PCT     		 	Param=value 		</C>
		<C>Col=L31_1_PCT     			 	Ctrl=medL31_1_PCT     			 	Param=text	 		</C>
		<C>Col=L31_2_PCT     			 	Ctrl=medL31_2_PCT     			 	Param=text	 		</C>
		<C>Col=L31_3_PCT     		 		Ctrl=medL31_3_PCT     			 	Param=text	 		</C>
		<C>Col=L58_1_PCT     			 	Ctrl=medL58_1_PCT     			 	Param=text	 		</C>
		<C>Col=L58_2_PCT     			 	Ctrl=medL58_2_PCT     			 	Param=text	 		</C>
		<C>Col=L55_1_PCT   	  		 	Ctrl=medL55_1_PCT     			 	Param=text	 		</C>
		<C>Col=L51_1_PCT 	    		 	Ctrl=medL51_1_PCT     			 	Param=text	 		</C>
    '>
</object>
