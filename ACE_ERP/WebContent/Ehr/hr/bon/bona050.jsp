<!--
    ************************************************************************************
    * @source         : bona050.jsp 				                                   *
    * @description   : 개인별상여지급현황 PAGE.                                        *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/23  |  한학현   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인별상여지급현황</title>
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 시작년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var SORT_SHR = document.getElementById("cmb_SORT_SHR").value; // 정렬구분
			var SEQ_SHR = document.getElementById("cmb_SEQ_SHR").value; // 차수
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 소속
			var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위

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
            dsT_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona050.cmd.BONA050CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR+
															"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&SEQ_SHR="+SEQ_SHR;
            dsT_CP_PAYMASTER.Reset();

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

            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.mgrdT_CP_PAYMASTER.GridToExcel("개인별상여지급현황", "", 2);


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

			//정렬구분 변경
			fnc_changeSort();

			dsT_CP_PAYMASTER.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // 근로구분구분
			document.getElementById("cmb_SORT_SHR").value = "1";
			document.getElementById("txtDPT_CD_SHR").value = ""; // 소속코드
			document.getElementById("txtDPT_NM_SHR").value = ""; // 소속명
			document.getElementById("txtJOB_CD_SHR").value = ""; // 직위코드
			document.getElementById("txtJOB_NM_SHR").value = ""; // 직위명
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYMASTER.IsUpdated)  {

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

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.mgrdT_CP_PAYMASTER,0,"false","");//mgrd사용으로 주석처리

			//최근 저장한 해당년월 조회 - 개인별급여사항관리 클레스 재사용
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

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

			//정렬구분 변경
			fnc_changeSort();

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************
         * 정렬구분 변경         *
         *******************/
		function fnc_changeSort() {

			var SORT_SHR = document.getElementById("cmb_SORT_SHR").value; // 정렬구분

			if(SORT_SHR == "1"){
				document.getElementById("divBONA050_01").style.display = "";
				document.getElementById("divBONA050_02").style.display = "none";
			}else if(SORT_SHR == "2"){
				document.getElementById("divBONA050_01").style.display = "none";
				document.getElementById("divBONA050_02").style.display = "";
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
    | 2. 이름 : dsT_CP_PAYMASTER                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
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

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CP_PAYMASTER                    |
    | 3. Table List : T_CP_PAYMASTER                |
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
			document.getElementById("txtPIS_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 해당년월

			document.getElementById("txtPIS_YYMM_SHR").focus();
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

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">

   		var iCount = dsT_CP_PAYMASTER.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_CP_PAYMASTER.ExportData(1, dsT_CP_PAYMASTER.CountRow, true));

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_PAYMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>


<!-- 	<script language=JavaScript for=mgrdT_CP_PAYMASTER event=OnLButtonDblClk(type,index,colid,x,y)>
		mgrdT_CP_PAYMASTER.Draw = false;
		mgrdT_CP_PAYMASTER.BlockSelect('init')="init";
		mgrdT_CP_PAYMASTER.BlockSelect('top')=index;
		mgrdT_CP_PAYMASTER.BlockSelect('bottom')=index;
		mgrdT_CP_PAYMASTER.BlockSelect('left')="NO";
		mgrdT_CP_PAYMASTER.BlockSelect('right')="SALT_AMT";
		mgrdT_CP_PAYMASTER.Draw = true;
	</script>

	<script language=JavaScript for=mgrdT_CP_PAYMASTER event=OnLButtonDown(type,index,colid,x,y)>
		mgrdT_CP_PAYMASTER.Draw = false;
		mgrdT_CP_PAYMASTER.BlockSelect('init')="init";
		mgrdT_CP_PAYMASTER.BlockSelect('top')=index;
		mgrdT_CP_PAYMASTER.BlockSelect('bottom')=index;
		mgrdT_CP_PAYMASTER.BlockSelect('left')="NO";
		mgrdT_CP_PAYMASTER.BlockSelect('right')="SALT_AMT";
		mgrdT_CP_PAYMASTER.Draw = true;
	</script>   -->

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별상여지급현황</td>
					<td align="right" class="navigator">HOME/보상관리/상여관리/<font color="#000000">개인별상여지급현황</font></td>
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
								<col width="70"></col>
								<col width="90"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width="70"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">해당년월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;종</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:60" onChange="fnc_SearchList();">
										<option value="" >전체</option>
									</select>
								</td>
								<td align="center" class="searchState">차&nbsp;&nbsp;수</td>
								<td>
									<select id="cmb_SEQ_SHR" style="width:50">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center" class="searchState">정렬구분</td>
								<td>
									<select id="cmb_SORT_SHR" style="width:60" onChange="fnc_changeSort();">
	                                    <option value="1" >직위별</option>
										<option value="2" >소속별</option>
									</select>
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

<!-- 조건에 따른 DISPLAY 시작 -->
<div id="divBONA050_01" style="position:absolute; left:615; top:93; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
			<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
				<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
			</a>
		</td>
	</tr>
	</table>
</div>

<div id="divBONA050_02" style="position:absolute; left:615; top:93; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A2', 'txtJOB_CD_SHR','txtJOB_NM_SHR')">
			<input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
				<img src="/images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')">
			</a>
		</td>
	</tr>
	</table>
</div>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                            <object id="mgrdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
                                <param name="DataID"            value="dsT_CP_PAYMASTER">
                                <param name="EdiTABLE"          value="true">
                                <param name="DragDropEnable"    value="false">
                                <param name="Format"            value="
                                    <FC> id={currow}    width=20    name='NO'          align=center  value={String(Currow)}</FC>

                                    <FC> id='AVTA_SAL'  width=80    name='확인용'      align=center   </FC>
                                    <FC> id='itdd_amt'  width=80    name='itdd_amt'      align=center   </FC>


                                    <FC> id='DPT_NM'    width=80    name='소속'        align=center   </FC>
                                    <FC> id='JOB_NM'    width=50    name='직위'        align=center   </FC>
                                    <FC> id='ENO_NO'    width=60    name='사번'        align=center   </FC>
                                    <FC> id='ENO_NM'    width=60    name='성명'        align=center   </FC>


                                    <G> name='지불' 	BgColor='#F7DCBB'
									<C> id='BAS_AMT'    width=70    name='기본급'      align=right    </C>
									<C> id='DUTY_AMT'   width=70    name='직책수당'    align=right    </C>
									<C> id='LAW_AMT'    width=70    name='시간외'      align=right    </C>
									<C> id='LSEV_AMT'   width=70    name='근속수당'    align=right    </C>
									<C> id='OSE_AMT'    width=70    name='자기계발비'  align=right    </C>
									<C> id='ETC_AMT_12' width=70    name='남북경협'    align=right    </C>
                                    <FC>id='SALT_AMT'   width=75    name='지급합계'    align=right    BgColor='#99FF99'     </FC>
									</G>

									<G> name='공제' 	BgColor='#F7DCBB'
									<C> id='INCM_TAX'   width=70    name='소득세'      align=right    </C>
                                    <C> id='CITI_TAX'   width=70    name='주민세'      align=right    </C>
									<C> id='DDTT_AMT'   width=75    name='공제액계'    align=right    BgColor='#FFFF99'     </C>
                                    </G>


									<C> id='PAY_AMT'    width=80    name='실수령액'    align=right    BgColor='#BB99AA'		</C>

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