<!--
    ************************************************************************************
    * @source         : guna110.jsp
    * @description   : 기간별근태현황 PAGE.
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION
    *-------------+-----------+--------------------------------------------------------+
* 2007/02/23      김학수        최초작성.
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>기간별근태현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
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

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;//시작일자
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;//종료일자
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value;  //근로구분구분
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;  //소속
            var GBN_TAG_SHR = document.getElementById("cmbGBN_TAG").value;     //휴가구분

			//시작일자가 없으면 조회못함.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작일자를 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//시작일자가 잘못되었으면 조회못함.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작일자가 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//종료일자가 없으면 조회못함.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료일자를 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료일자가 잘못되었으면 조회못함.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료일자가 잘못되었습니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//종료일자가 시작일자보다 크면 않된다.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("종료일자가 시작일자보다 빠릅니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}

			//소속이 없으면
			/*
			if(DPT_CD_SHR.trim().length == 0){
					alert("소속을 입력하세요.");
					document.getElementById("txtDPT_CD_SHR").focus();
					return false;
			}*/

            //데이터셋 전송
            trT_DI_DILIGENCE.KeyValue = "SVL(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE, O:dsT_DI_DILIGENCE_01=dsT_DI_DILIGENCE_01)";
            trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna110.cmd.GUNA110CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&GBN_TAG_SHR="+GBN_TAG_SHR;
            trT_DI_DILIGENCE.post();

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

            if (dsT_DI_DILIGENCE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_DILIGENCE.GridToExcel("기간별근태현황", '', 225);

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

			dsT_DI_DILIGENCE.ClearData();
			dsT_DI_DILIGENCE_01.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtSTR_YMD_SHR.value = getToday().substring(0,8)+"01";// 시작일자(검색)
			//document.form1.txtEND_YMD_SHR.value = getToday();                    // 종료일자(검색)
			document.getElementById("cmbOCC_CD_SHR").value = "";
			document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// 소속코드
			document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// 소속명
			document.form1.txtSTR_YMD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_DI_DILIGENCE.IsUpdated)  {

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

        	if (!dsT_DI_DILIGENCE.isUpdated ) {
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
			cfStyleGrid(form1.grdT_DI_DILIGENCE,0,"false","true");

			//누계 그리드
			cfStyleGrid(form1.grdT_DI_DILIGENCE_01,0,"false","false");      // Grid Style 적용
			//form1.grdT_DI_DILIGENCE_01.HiddenHScroll  = true;
			form1.grdT_DI_DILIGENCE_01.HiddenVScroll  = true;
			//form1.grdT_DI_DILIGENCE_01.DisableNoHScroll = false;
			form1.grdT_DI_DILIGENCE_01.DisableNoVScroll = false;
			form1.grdT_DI_DILIGENCE_01.ViewHeader = false;
			//form1.grdT_DI_DILIGENCE_01.Enable = false;
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditCol', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row의 선택된 Column의 Color(#F3FED2)
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusEditRow', BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
		    form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurCol',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row의 선택된 Column의 Color(#F3FED2)
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='FocusCurRow',  BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(有) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditCol',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row의 선택된 Column의 Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='EditRow',      BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(O) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurCol',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row의 선택된 Column의 Color
			form1.grdT_DI_DILIGENCE_01.SelectionColor += "<SC>Type='CurRow',       BgColor='#FFFFFF', TextColor='#000000'</SC>";  // Focus(無) Editable(X) 선택된 Row에서 선택된 Cell을 제외한 나머지 셀


			document.form1.txtSTR_YMD_SHR.value = getToday().substring(0,8)+"01";// 시작일자(검색)
			document.form1.txtEND_YMD_SHR.value = getToday();                    // 종료일자(검색)

			//근로구분
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")&&
        !box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>

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
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_DILIGENCE                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name=TimeOut           Value=100000>
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_DILIGENCE_01                       |
    | 3. Table List : T_DI_DILIGENCE                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name=TimeOut           Value=100000>
    </Object>

    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_DI_DILIGENCE                  |
    | 3. Table List : T_DI_DILIGENCE              |
    +----------------------------------------------->
    <Object ID ="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
        <param Name=TimeOut     Value=1000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_DILIGENCE_01 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_DI_DILIGENCE event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-- 스크롤 동기화 -->
	<script language="JavaScript" for=grdT_DI_DILIGENCE event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE_01.SetScrolling(row, col);
	</script>

	<script language="JavaScript" for= grdT_DI_DILIGENCE_01 event="OnScrolling(row, col, bymethod)">
		if(!bymethod)
			grdT_DI_DILIGENCE.SetScrolling(row, col);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기간별근태현황</td>
					<td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">기간별근태현황</font></td>
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
								<col width="230"></col>
								<col width="50"></col>
								<col width="70"></col>
								<col width="50"></col>
							    <col width="160"></col>
                                <col width="60"></col>
        					</colgroup>
							<tr>
								<td align="center" class="searchState">해당일자</td>
								<td>
									<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
									 ~
									<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
								</td>
								<td align="center" class="searchState">근로구분</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:60">
		                                <option value="">전체</option>
									</select>
								</td>
								<td align="center" class="searchState">소&nbsp;속</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
								</td>
                                <td align="center" class="searchState">구&nbsp;분</td>
                                <td>
                                    <select id="cmbGBN_TAG" style="WIDTH:100">
                                        <option value="">전체</option>
                                        <option value="1" >기념일휴가</option>
                                        <option value="2" >Refresh휴가</option>
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:329px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=29			name='NO'				align=center			value={String(Currow)}		</FC>
								<FC> id='DPT_NM'			width=100			name='소속'				align=center			         					</FC>
								<FC> id='JOB_NM'			width=50			name='직위'				align=center										</FC>
								<FC> id='ENO_NO'			width=60			name='사번'				align=center										</FC>
								<FC> id='ENO_NM'			width=60			name='성명'				align=center										</FC>
								<FC> id='MF_TAG'			width=50			name='성별'				align=center			Value={Decode(MF_TAG,'M','남자','여자')}			  </FC>
								<FC> id='YRP_CNT'			width=50			name='발생;연차'		align=right				Value={Decode(YRP_CNT,'0',' ',YRP_CNT)}	               </FC>
								<C> id='ATT_F'				width=50			name='교육'				align=right				Value={Decode(ATT_F,'0',' ',ATT_F)}		               </C>
								<G>name=휴가		HeadBgColor=#F7DCBB
									<C> id='ATT_Q'			width=50			name='기념'				align=right				Value={Decode(ATT_Q,'0',' ',ATT_Q)}		show=false               </C>
									<C> id='ATT_H'			width=50			name='연차'				align=right				Value={Decode(ATT_H,'0',' ',ATT_H)}		DECAO=1        </C>
									<C> id='ATT_Z'			width=50			name='Refresh'			align=right				Value={Decode(ATT_Z,'0',' ',ATT_Z)}		show=false               </C>
									<C> id='ATT_I'			width=50			name='특별'				align=right				Value={Decode(ATT_I,'0',' ',ATT_I)}		               </C>
								</G>
								<G>name=결근		HeadBgColor=#F7DCBB
									<C> id='ATT_A'			width=50			name='유결'				align=right				Value={Decode(ATT_A,'0',' ',ATT_A)}		               </C>
									<C> id='ATT_B'			width=50			name='무결'				align=right				Value={Decode(ATT_B,'0',' ',ATT_B)}		               </C>
								</G>
								<C> id='ATT_C'				width=50			name='지각'				align=right				Value={Decode(ATT_C,'0',' ',ATT_C)}		               </C>
								<C> id='ATT_D'				width=50			name='조퇴'				align=right				Value={Decode(ATT_D,'0',' ',ATT_D)}		               </C>
								<C> id='ATT_E'				width=50			name='출장'				align=right				Value={Decode(ATT_E,'0',' ',ATT_E)}		               </C>
								<C> id='ATT_T'				width=50			name='대체;휴가'		align=right				Value={Decode(ATT_T,'0',' ',ATT_T)}		DECAO=1        </C>
								<C> id='ATT_L'				width=50			name='기타'				align=right				Value={Decode(ATT_L,'0',' ',ATT_L)}		               </C>
								<G>name=누적		HeadBgColor=#F7DCBB
									<C> id='ATT_C_NU'		width=50			name='지각'				align=right				Value={Decode(ATT_C_NU,'0',' ',ATT_C_NU)}	           </C>
									<C> id='ATT_H_NU'		width=50			name='연차'				align=right				Value={Decode(ATT_H_NU,'0',' ',ATT_H_NU)}	DECAO=1    </C>
								</G>
								<C> id='NYRP_CNT'			width=50			name='미사용;연차'		align=right				Value={Decode(NYRP_CNT,'0',' ',NYRP_CNT)}	DECAO=1    </C>

							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:43px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE_01">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=29			name='NO'				align=center			</FC>
								<FC> id='DPT_NM'			width=100			name='소속'				align=center			Suppress=1					</FC>
								<FC> id='JOB_NM'			width=50			name='직위'				align=center										</FC>
								<FC> id='ENO_NO'			width=60			name='사번'				align=center										</FC>
								<FC> id='ENO_NM'			width=60			name='성명'				align=center										</FC>
								<FC> id='MF_TAG'			width=50			name='성별'				align=right											</FC>

								<FC> id='YRP_CNT'			width=50			name='발생;연차'		align=right											</FC>
								<C> id='ATT_F'				width=50			name='교육'				align=right											</C>
								<G>name=휴가		HeadBgColor=#F7DCBB
									<C> id='ATT_Q'			width=50			name='기념'				align=right				show=false							</C>
									<C> id='ATT_H'			width=50			name='연차'				align=right				DECAO=1 					</C>
									<C> id='ATT_Z'			width=50			name='Refresh'			align=right				sho=false							</C>
									<C> id='ATT_I'			width=50			name='특별'				align=right											</C>
								</G>
								<G>name=결근		HeadBgColor=#F7DCBB
									<C> id='ATT_A'			width=50			name='유결'				align=right											</C>
									<C> id='ATT_B'			width=50			name='무결'				align=right											</C>
								</G>
								<C> id='ATT_C'				width=50			name='지각'				align=right											</C>
								<C> id='ATT_D'				width=50			name='조퇴'				align=right											</C>
								<C> id='ATT_E'				width=50			name='출장'				align=right											</C>
								<C> id='ATT_T'				width=50			name='대체;휴가'		align=right				DECAO=1 					</C>
								<C> id='ATT_L'				width=50			name='기타'				align=right											</C>
								<G>name=누적		HeadBgColor=#F7DCBB
									<C> id='ATT_C_NU'		width=50			name='지각'				align=right											</C>
									<C> id='ATT_H_NU'		width=50			name='연차'				align=right				DECAO=1 					</C>
								</G>
								<C> id='NYRP_CNT'			width=50			name='미사용;연차'		align=right				DECAO=1 					</C>

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