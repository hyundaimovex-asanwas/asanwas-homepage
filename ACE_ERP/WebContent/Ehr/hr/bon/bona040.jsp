<!--
    ************************************************************************************
    * @source         : bona040.jsp 				                                                                                     *
    * @description   : 월별급상여지급현황 PAGE.                                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>월별급상여지급현황</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // 시작년월
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // 종료년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var SORT_SHR = document.getElementById("cmb_SORT_SHR").value; // 정렬구분

			//시작년월이 없으면 조회못함.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}

            if(SORT_SHR == "1"){//프로시저 조회 예제용으로 만듬
            //트랜잭션 전송
				trT_CP_PAYMASTER.KeyValue = "SVL(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
				trT_CP_PAYMASTER.Action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona040.cmd.BONA040CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+
													            "&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
				trT_CP_PAYMASTER.Post();
            }else{
	            //데이터셋 전송
	            dsT_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona040.cmd.BONA040CMD&S_MODE=SHR&STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+
													            "&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
	            dsT_CP_PAYMASTER.Reset();
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

			var STR_YYMM_SHR = document.getElementById("txtSTR_YYMM_SHR").value; // 시작년월
			var END_YYMM_SHR = document.getElementById("txtEND_YYMM_SHR").value; // 종료년월
			var OCC_CD_SHR   = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var SORT_SHR     = document.getElementById("cmb_SORT_SHR").value; // 정렬구분


			//시작년월이 없으면 조회못함.
			if(STR_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(STR_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(END_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(END_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(END_YYMM_SHR.replaceStr("-","")) < parseInt(STR_YYMM_SHR.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YYMM_SHR").focus();
					return false;
			}

			var url = "bona040_PV.jsp?STR_YYMM_SHR="+STR_YYMM_SHR+"&END_YYMM_SHR="+END_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&SORT_SHR="+SORT_SHR;
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

            form1.grdT_CP_PAYMASTER.GridToExcel("월별급상여지급현황", '', 225);

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

			dsT_CP_PAYMASTER.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = ""; // 근로구분구분
			document.getElementById("cmb_SORT_SHR").value = "1";
			document.form1.txtSTR_YYMM_SHR.focus();

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
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");

			//최근 저장한 해당년월 조회 - 개인별급여사항관리 클레스 재사용
			ds01T_CP_PAYMASTER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga020.cmd.SAGA020CMD&S_MODE=SHR_01";
			ds01T_CP_PAYMASTER.Reset();

			//값이 없어서 하이픈만 나오는거 방지
			var STR_YYMM_SHR = (document.getElementById("txtSTR_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(STR_YYMM_SHR.trim() == ""){
				document.getElementById("txtSTR_YYMM_SHR").value = "";
			}

			var END_YYMM_SHR = (document.getElementById("txtEND_YYMM_SHR").value).replace("-", "").replace("-", "");
			if(END_YYMM_SHR.trim() == ""){
				document.getElementById("txtEND_YYMM_SHR").value = "";
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
			document.getElementById("txtSTR_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 시작년월
			document.getElementById("txtEND_YYMM_SHR").value = oPIS_YYMM.substring(0,4)+"-"+oPIS_YYMM.substring(4,6); // 종료년월

			document.getElementById("txtSTR_YYMM_SHR").focus();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">월별급상여지급현황</td>
					<td align="right" class="navigator">HOME/보상관리/상여관리/<font color="#000000">월별급상여지급현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
								<col width="250"></col>
								<col width="80"></col>
								<col width="140"></col>
								<col width="80"></col>
								<col width="130"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">기&nbsp;&nbsp;&nbsp;간</td>
								<td>
									<input id="txtSTR_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM_SHR','','75','112');"></a>
									&nbsp;~&nbsp;
									<input id="txtEND_YYMM_SHR" size="9" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM_SHR','','190','112');"></a>
								</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="" >전체</option>
									</select>
								</td>
								<td align="center" class="searchState">정렬구분</td>
								<td>
									<select id="cmb_SORT_SHR" style="width:100" onChange="fnc_SearchList();">
										<option value="1" >전체</option>
										<option value="2" >소속별</option>
	                                    <option value="3" >직위별</option>
	                                    <option value="4" >기준직위별</option>
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=39			name='NO'					align=center			value={String(Currow)}																</C>
								<C> id='PIS_YYMM'			width=80			name='년월'				align=center																													</C>
								<C> id='COMM_NM'			width=120			name='구분'				align=center				subsumtext='합계'																		</C>
								<C> id='ENO_CNT'			width=60			name='인원'					align=right																												</C>
								<G>name=급여		HeadBgColor=#F7DCBB
									<C> id='PAY_AMT'				width=105			name='급여'					align=right																										</C>
									<C> id='OTH_AMT'				width=105			name='기타'					align=right																										</C>
									<C> id='SUM_AMT'				width=105			name='계'				align=right																												</C>
								</G>
								<G>name=상여		HeadBgColor=#F7DCBB
									<C> id='BON_AMT'				width=105			name='금액'					align=right																										</C>
									<C> id='PAY_PCT'				width=60			name='%'					align=right			Value={Decode(CurLevel,9999,SubAvg(PAY_PCT),PAY_PCT)}		</C>
								</G>
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