<!--
    ************************************************************************************
    * @source         : bona030.jsp 				                                                                                     *
    * @description   : 상여지급현황 PAGE.                                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/16  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>상여지급현황</title>
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
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			//var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SAL_GBN_SHR = document.getElementById("txtSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호

			//해당년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월을 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}
			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

            //데이터셋 전송
			if(document.tabBONA030.ActiveIndex==1){
	            dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_01.Reset();
			}else if(document.tabBONA030.ActiveIndex==3){
	            dsT_CP_PAYMASTER_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_02.Reset();
			}else if(document.tabBONA030.ActiveIndex==5){
	            dsT_CP_PAYMASTER_03.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_03.Reset();
			}else if(document.tabBONA030.ActiveIndex==7){
	            dsT_CP_PAYMASTER_04.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_04&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_04.Reset();
			}else if(document.tabBONA030.ActiveIndex==2){
	            dsT_CP_PAYMASTER_05.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_05&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_05.Reset();
			}else if(document.tabBONA030.ActiveIndex==4){
	            dsT_CP_PAYMASTER_06.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_06.Reset();
			}else if(document.tabBONA030.ActiveIndex==6){
	            dsT_CP_PAYMASTER_07.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona030.cmd.BONA030CMD&S_MODE=SHR_07&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_07.Reset();
            }

        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

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

			if(document.tabBONA030.ActiveIndex==1){
	            if (dsT_CP_PAYMASTER_01.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_01.GridToExcel("직위별상여지급현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==3){
	            if (dsT_CP_PAYMASTER_02.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_02.GridToExcel("중도입사자현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==5){
	            if (dsT_CP_PAYMASTER_03.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_03.GridToExcel("근태감액자현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==7){
	            if (dsT_CP_PAYMASTER_04.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_04.GridToExcel("징계감액자현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==2){
	            if (dsT_CP_PAYMASTER_05.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_05.GridToExcel("부서별상여지급현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==4){
	            if (dsT_CP_PAYMASTER_06.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_06.GridToExcel("지급제외자현황", '', 225);

			}else if(document.tabBONA030.ActiveIndex==6){
	            if (dsT_CP_PAYMASTER_07.CountRow < 1) {
	                alert("엑셀로 변환할 자료가 없습니다!");
	                return;
	            }
	            form1.grdT_CP_PAYMASTER_07.GridToExcel("휴직감액자현황", '', 225);
			}

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

			//화면겹침버그 임시 해결
			document.tabBONA030.ActiveIndex=2;
			document.tabBONA030.ActiveIndex=1;

			dsT_CP_PAYMASTER_01.ClearData();
			dsT_CP_PAYMASTER_02.ClearData();
			dsT_CP_PAYMASTER_03.ClearData();
			dsT_CP_PAYMASTER_04.ClearData();
			dsT_CP_PAYMASTER_05.ClearData();
			dsT_CP_PAYMASTER_06.ClearData();
			dsT_CP_PAYMASTER_07.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // 근로구분구분
			//document.getElementById("cmbSAL_GBN_SHR").value = "";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_CP_PAYMASTER_02.IsUpdated || dsT_CP_PAYMASTER_03.IsUpdated || dsT_CP_PAYMASTER_04.IsUpdated ||
	            dsT_CP_PAYMASTER_05.IsUpdated || dsT_CP_PAYMASTER_06.IsUpdated || dsT_CP_PAYMASTER_07.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

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

        	if (!dsT_CP_PAYMASTER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//최근 저장한 해당년월 조회 - 개인별급여사항관리 클레스 재사용
			dsT_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			dsT_CP_PAYMASTER.Reset();

			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

			//근로구분
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			//화면겹침버그 임시 해결
			document.tabBONA030.ActiveIndex=2;
			document.tabBONA030.ActiveIndex=1;

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_02,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_03,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_04,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_05,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_06,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_07,0,"false","false");

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. 이름 : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_01                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_02                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_03                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_04                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_05                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_06                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_07                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = dsT_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 해당년월

			document.getElementById("txtPIS_YYMM_SHR").focus();
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
        //alert(dsT_CP_PAYMASTER_01.ExportData(1, dsT_CP_PAYMASTER_01.CountRow, true));
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_02 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_03 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_04 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_05 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_06 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CP_PAYMASTER_07 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">상여지급현황</td>
					<td align="right" class="navigator">HOME/보상관리/상여관리/<font color="#000000">상여지급현황</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
								<col width="30"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">해당년월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList();">
										<option value="" >전체</option>
									</select>
								</td>
								<!--
								<td align="center" class="searchState">급상여구분</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="0" >급여</option>
	                                    <option value="1" >상여</option>
									</select>
								</td>
								-->
								<input type="hidden" id="txtSAL_GBN_SHR" value="1">
								<td align="center" class="searchState">일련번호</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center">&nbsp;</td>
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

<!-- 탭 사용 컴퍼넌트 시작 -->
<comment id="__NSID__">
<object id=tabBONA030 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">

	<param name="Format"			value='
		<T>divid="tabBONA030_01"	title="직위별"</T>
		<T>divid="tabBONA030_05"	title="부서별"</T>
		<T>divid="tabBONA030_02"	title="중도입사자"</T>
		<T>divid="tabBONA030_06"	title="지급제외자"</T>
		<T>divid="tabBONA030_03"	title="근태감액자"</T>
		<T>divid="tabBONA030_07"	title="휴직감액자"</T>
		<T>divid="tabBONA030_04"	title="징계감액자"</T>
		'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- 탭 사용 컴퍼넌트 끝 -->

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:5;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="JOB_NM"				width=120		name="직위"				align=center		subsumtext="합계"								</C>
						<C> id="ENO_CNT"			width=120		name="인원"				align=right		</C>
						<C> id="BAS_AMT"			width=120		name="지급기준액"	align=right		</C>
						<C> id="SALT_AMT"			width=120		name="지급총액"		align=right		</C>
						<C> id="PAY_PCT"				width=120		name="지급률"			align=right		Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=129		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="소속"				align=center		subsumtext="합계"								</C>
						<C> id="JOB_NM"				width=100		name="직위"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=100		name="성명"				align=center		</C>
						<C> id="HIR_YMD"				width=100		name="입사일"			align=center		</C>
						<C> id="BAS_PCT"			width=100		name="지급률"			align=right		Value={Decode(CurLevel,9999,SubAvg(BAS_PCT),BAS_PCT)}		Dec=2</C>
						<C> id="SALT_AMT"			width=115		name="상여금액"		align=right		</C>
						<C> id="REMARK"				width=114		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭2 조건 입력 테이블 끝 -->

<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=50		name="NO"			align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="소속"			align=center		subsumtext="합계"								</C>
						<C> id="JOB_NM"				width=95		name="직위"			align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=95		name="성명"			align=center	</C>
						<C> id="ATT_A"				width=85		name="유결"			align=right		</C>
						<C> id="ATT_B"				width=85		name="무결"			align=right		</C>
						<C> id="ATT_C"				width=85		name="지각"			align=right		</C>
						<C> id="ATTD_PCT"			width=85		name="감액율"		align=right		Value={Decode(CurLevel,9999,SubAvg(ATTD_PCT),ATTD_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=98		name="비고"			align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭3 조건 입력 테이블 끝 -->

<!-- 탭4 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_04" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_04">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=100		name="소속"				align=center		subsumtext="합계"								</C>
						<C> id="JOB_NM"				width=100		name="직위"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  									</C>
						<C> id="ENO_NM"				width=100		name="성명"				align=center		</C>
						<C> id="PUD_PCT"			width=100		name="감액율"			align=right		Value={Decode(CurLevel,9999,SubAvg(PUD_PCT),PUD_PCT)}		Dec=2						</C>
						<C> id="JCD_CD"				width=114		name="징계종류"		align=center		Value={Decode(JCD_CD,0,"~외",1,"견책,출근정지",2,"감봉",3,"강급",4,"정직/강격")}				</C>
						<C> id="JCD_CNT"				width=100		name="횟수"				align=right		</C>
						<C> id="REMARK"				width=115		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭4 조건 입력 테이블 끝 -->

<!-- 탭5 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_05" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_05">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=120		name="소속"				align=center		subsumtext="합계"								</C>
						<C> id="ENO_CNT"			width=120		name="인원"				align=right		</C>
						<C> id="BAS_AMT"			width=120		name="지급기준액"	align=right		</C>
						<C> id="SALT_AMT"			width=120		name="지급총액"		align=right		</C>
						<C> id="PAY_PCT"				width=120		name="지급률"			align=right		Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		Dec=2	</C>
						<C> id="REMARK"				width=129		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭5 조건 입력 테이블 끝 -->

<!-- 탭6 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_06" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_06">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=145		name="소속"				align=center		subsumtext="합계"								</C>
						<C> id="JOB_NM"				width=145		name="직위"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)} 			</C>
						<C> id="ENO_NM"				width=145		name="성명"				align=center		</C>
						<C> id="HIR_YMD"				width=145		name="입사일"			align=center		</C>
						<C> id="REMARK"				width=149		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭6 조건 입력 테이블 끝 -->

<!-- 탭7 조건 입력 테이블 시작 -->
<div class=page id="tabBONA030_07" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_07">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=50		name="NO"				align=center		value={String(Currow)}						</C>
						<C> id="DPT_NM"				width=105		name="소속"				align=center		subsumtext="합계"								</C>
						<C> id="JOB_NM"				width=104		name="직위"				align=center		Value={Decode(CurLevel,9999,SubRealCount(level=0),JOB_NM)}  			</C>
						<C> id="ENO_NM"				width=105		name="성명"				align=center		</C>
						<C> id="TMR_YMD"			width=105		name="휴직일자"		align=center		</C>
						<C> id="TMR_DD"				width=105		name="휴직일수"		align=right		</C>
						<C> id="TRD_PCT"			width=100		name="감액율"			align=right		Value={Decode(CurLevel,9999,SubAvg(TRD_PCT),TRD_PCT)} Dec=2</C>
						<C> id="REMARK"				width=105		name="비고"				align=left		</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭7 조건 입력 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>