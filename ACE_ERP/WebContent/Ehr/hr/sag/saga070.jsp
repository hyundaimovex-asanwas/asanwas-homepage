<!--
    ************************************************************************************
    * @source         : saga070.jsp 				                                                                                     *
    * @description   : 개인별급여지급현황 PAGE.                                                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/17  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인별급여지급현황</title>
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
		var btnList = 'TFFTTTFT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 지급년도
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사원번호

			//지급년도가 없으면 조회못함.
			if(PIS_YY_SHR.trim().length == 0){
					alert("지급년도를 입력하세요.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}
			//지급년도가 잘못되었으면 조회못함.
			if(PIS_YY_SHR.trim().length != 4){
					alert("지급년도가 잘못되었습니다.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}

			//사원번호가 없으면 조회못함.
			if(ENO_NO_SHR.trim().length == 0){
					alert("사원번호를 입력하세요.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
			}

            //트랜잭션 전송
			trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CM_PERSON=dsT_CM_PERSON, O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
			trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga070.cmd.SAGA070CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			trT_CP_PAYMASTER.Post();

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


        	var OCC_CD = dsT_CP_PAYMASTER.NameValue(1,'OCC_CD');

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 지급년도
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사원번호

			//지급년도가 없으면 조회못함.
			if(PIS_YY_SHR.trim().length == 0){
					alert("지급년도를 입력하세요.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}
			//지급년도가 잘못되었으면 조회못함.
			if(PIS_YY_SHR.trim().length != 4){
					alert("지급년도가 잘못되었습니다.");
					document.getElementById("txtPIS_YY_SHR").focus();
					return false;
			}

			//사원번호가 없으면 조회못함.
			if(ENO_NO_SHR.trim().length == 0){
					alert("사원번호를 입력하세요.");
					document.getElementById("txtENO_NO_SHR").focus();
					return false;
			}


			var url = "saga070_PV.jsp?PIS_YY_SHR="+PIS_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&OCC_CD="+OCC_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("개인별급여지급현황", '', 225);

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
			dsT_CP_PAYMASTER.ClearData();
			dsT_CM_PERSON.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

            if(dsTemp != "Modal"){
				document.getElementById("txtENO_NO_SHR").value = ""; // 사원번호
				document.getElementById("txtENO_NM_SHR").value = ""; // 사원번호
			}

			document.form1.txtPIS_YY_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
		        if (dsT_CP_PAYMASTER.IsUpdated)  {
		            if (!fnc_ExitQuestion()) return;
		        }

		        frame = window.external.GetFrame(window);
		        frame.CloseFrame();

            }else{
                window.close();

            }

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

			fnc_ChangeGrid();      //그리드 변경 처리

			//최근 저장한 해당년월 조회 - 개인별급여사항관리 클레스 재사용
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

			//팝업일결우 자동조회(pirc020에서 사용)
            if(dsTemp == "Modal"){

				document.getElementById('txtENO_NO_SHR').value = "<%=request.getParameter("ENO_NO")%>";
				document.getElementById('txtENO_NM_SHR').value = "<%=request.getParameter("ENO_NM")%>";

	  			document.getElementById("txtENO_NO_SHR").readOnly = true;
				document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
	  			document.getElementById("txtENO_NM_SHR").readOnly = true;
				document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";
	            document.getElementById("imgENO_NO_SHR").style.display = "none";

				fnc_SearchList();

            }

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid(occ_cd) {

			if(occ_cd == undefined || occ_cd == "A"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'			width=40		name='NO'						align=center		value={String(Currow)}					</FC>" +
																		"<FC> id='PIS_MM'				width=50		name='월'							align=center																</FC>" +
																		"<FC> id='SAL_GBN_NM'			width=50		name='구분'					align=center		value={DECODE(SAL_GBN,'0','급여','1','상여',2,'소급','4','연차')}		SubSumText={decode(curlevel,9999,'합계')}	</FC>" +
																		"<C> id='SALT_AMT'				width=85		name='급여계'					align=right		BgColor='#EEEEEE'								</C>" +
																		"<C> id='BAS_AMT'				width=85		name='기본급' 					align=right																</C>" +
																		"<C> id='DUTY_AMT'				width=85		name='직무수당'				align=right																</C>" +
																		"<C> id='LAW_AMT'				width=85		name='시간외수당'			align=right																</C>" +
																		"<C> id='BNS_AMT'				width=85		name='상여금'				align=right																</C>" +
																		"<C> id='PPEN_AMT'				width=85		name='개인연금'				align=right																</C>" +
																		"<C> id='LSEV_AMT'				width=85		name='근속수당'				align=right																</C>" +
																		"<C> id='ETC_AMT'				width=85		name='차량유지비'			align=right																</C>" +
																		"<C> id='ETC_AMT2'				width=85		name='지역근무수당'			align=right																</C>" +
																		"<C> id='ETC_AMT3'				width=85		name='식대'			align=right																</C>" +
																		"<C> id='ETC_AMT4'				width=85		name='가족부양비'			align=right																</C>" +
																		"<C> id='OTH_AMT'				width=85		name='기타지불 '				align=right																</C>" +
																		"<C> id='INCM_TAX'				width=85		name='소득세'				align=right																</C>" +
																		"<C> id='CITI_TAX'				width=85		name='주민세'				align=right																</C>" +
																		"<C> id='NPEN_AMT'				width=85		name='국민연금'				align=right																</C>" +
																		"<C> id='HINU_AMT'				width=85		name='건강보험'				align=right																</C>" +
																		"<C> id='OLD_AMT'				width=85		name='장기요양보험'				align=right															</C>" +
																		"<C> id='HINS_AMT'				width=85		name='고용보험'				align=right																</C>" +
																		"<C> id='DHLP_AMT'				width=85		name='공조회비'				align=right																</C>" +
																		"<C> id='PPED_AMT'				width=85		name='개인연금'				align=right																</C>" +
																		"<C> id='LAB_AMT'				width=85		name='보증보험'				align=right																</C>" +
																		"<C> id='LON_AMT'				width=85		name='대출상환'		align=right																</C>" +
																		"<C> id='OTHD_AMT'				width=85		name='기타공제 '				align=right															</C>" +
																		"<C> id='DDTT_AMT'				width=85		name='공제 계 '				align=right			BgColor='#EEEEEE'									</C>" +
																		"<C> id='PAY_AMT'				width=85		name='실수령액'				align=right			BgColor='#EEEEEE'									</C>";

            }else if(occ_cd == "M"){
				form1.grdT_CP_PAYMASTER.Format = "<FC> id='{CUROW}'			width=40		name='NO'						align=center		value={String(Currow)}					</FC>" +
																		"<FC> id='PIS_MM'				width=50		name='월'							align=center																</FC>" +
																		"<FC> id='SAL_GBN'				width=50		name='구분'						align=center		value={DECODE(SAL_GBN,'0','급여','1','상여','4','연차')}		SubSumText={decode(curlevel,9999,'합계')}	</FC>" +
																		"<C> id='SALT_AMT'				width=85		name='급여계'					align=right		BgColor='#EEEEEE'							</C>" +
																		"<C> id='BAS_AMT'				width=85		name='기본급' 					align=right																</C>" +
																		"<C> id='DUTY_AMT'				width=85		name='복지수당'				align=right																</C>" +
																		"<C> id='OT_AMT'				width=85		name='기술수당'				align=right																</C>" +
																		"<C> id='OSE_AMT'				width=85		name='택배수당'				align=right																</C>" +
																		"<C> id='RUN_AMT'				width=85		name='운행/작업수당'		align=right																</C>" +
																		"<C> id='MH_AMT'				width=85		name='자기개발비'			align=right																</C>" +
																		"<C> id='LSEV_AMT'				width=85		name='근속수당'				align=right																</C>" +
																		"<C> id='ETC_AMT'				width=85		name='기타수당'				align=right		value={TB3_AMT+ SGF_AMT+OTH_AMT}	</C>";

            }

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","right");

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
        <param name="SubsumExpr"	value="total">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CP_PAYMASTER                          |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CM_PERSON                                       |
    | 3. Table List : T_CM_PERSON                                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_PAYMASTER                                    |
    | 3. Table List : T_CP_PAYMASTER                             |
    +----------------------------------------------->
    <Object ID ="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oPIS_YYMM = ds01T_CP_PAYMASTER.NameValue(1,"PIS_YYMM").trim();
			document.getElementById("txtPIS_YY_SHR").value = oPIS_YYMM.substring(0,4); // 지급년도
			document.getElementById("txtPIS_YY_SHR").focus();
        }
    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
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

    <Script For=ds01T_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
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

    <Script For=ds01T_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">

		fnc_ChangeGrid(dsT_CM_PERSON.NameValue(iCount1,"OCC_CD"));

   		var iCount1 = dsT_CM_PERSON.CountRow;
		if (iCount1 != 0) {
			document.getElementById("txtENO_NM_SHR").value = dsT_CM_PERSON.NameValue(iCount1,"ENO_NM");
		}

   		var iCount2 = dsT_CP_PAYMASTER.CountRow;
		if (iCount2 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount2);
        }

		document.getElementById("txtENO_NO_SHR").focus();

    </script>


    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별급여지급현황</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">개인별급여지급현황</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>  -->
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width="80"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">지급년도</td>
								<td>
									<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">사원번호</td>
								<td>
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
								</td>
								<td align="center" class="searchState">&nbsp;</td>
								<td>&nbsp;</td>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
					<td class="padding2423">
						<input id="txtDPT_CD" style="text-align:center;width:26%" class="input_ReadOnly"  readonly>&nbsp;<input id="txtDPT_NM" style="width:70%" class="input_ReadOnly" readOnly>
					</td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423">
						<input id="txtJOB_CD" style="text-align:center;width:26%" class="input_ReadOnly"  readonly>&nbsp;<input id="txtJOB_NM" style="width:70%" class="input_ReadOnly" readOnly>
					</td>
					<td align="center" class="creamBold">입사일자</td>
					<td class="padding2423"><input id="txtHIRG_YMD"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">지급은행</td>
					<td class="padding2423"><input id="txtABA_NM"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				    <td align="center" class="creamBold">계좌번호</td>
					<td class="padding2423"><input id="txtACC_NO"  maxlength="10"  class="input_ReadOnly" style="width:100%" readonly></td>
				</tr>

			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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
<!-- -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
		<C>Col=OCC_CD     		 	Ctrl=txtOCC_CD     		 	Param=value 		</C>
		<C>Col=OCC_NM     		 	Ctrl=txtOCC_NM    			 	Param=value 		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			 	Param=value 		</C>
		<C>Col=DPT_NM     		 	Ctrl=txtDPT_NM    			 	Param=value 		</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			 	Param=value 		</C>
		<C>Col=JOB_NM     		 	Ctrl=txtJOB_NM    			 	Param=value 		</C>
		<C>Col=ABA_CD     		 	Ctrl=txtABA_CD     		 	Param=value 		</C>
		<C>Col=ABA_NM     		 	Ctrl=txtABA_NM     		 	Param=value 		</C>
		<C>Col=ACC_NO    		 	Ctrl=txtACC_NO     		 	Param=value 		</C>
		<C>Col=HIRG_YMD     		Ctrl=txtHIRG_YMD     		 	Param=value 		</C>
    '>
</object>