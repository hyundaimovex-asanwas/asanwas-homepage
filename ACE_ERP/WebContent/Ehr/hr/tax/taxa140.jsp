<!--
    ************************************************************************************
    * @source         : taxa140.jsp 				                                                                                     *
    * @description   : 출자금/대출금관리 PAGE.                                                                               *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/30  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>출자금/대출금관리</title>
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
		var btnList = 'TFFTTTTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var GMK_TAG_SHR = document.getElementById("cmbGMK_TAG_SHR").value; // 대출/출자종류
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호 - 급상여구분이 전체이면 미사용
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 소속

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
            dsT_AC_LOAN.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa140.cmd.TAXA140CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&GMK_TAG_SHR="+GMK_TAG_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+
															"&SEQ_SHR="+SEQ_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            dsT_AC_LOAN.Reset();

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


            // 삭제 할 자료가 있는지 체크하고
            if (dsT_AC_LOAN.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_AC_LOAN.ColumnString(dsT_AC_LOAN.RowPosition,1)+"-"+dsT_AC_LOAN.ColumnString(dsT_AC_LOAN.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_AC_LOAN.DeleteRow(dsT_AC_LOAN.RowPosition);

			trT_AC_LOAN.KeyValue = "SVL(I:dsT_AC_LOAN=dsT_AC_LOAN)";
			trT_AC_LOAN.Action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa140.cmd.TAXA140CMD&S_MODE=DEL";
			trT_AC_LOAN.post();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var GMK_TAG_SHR  = document.getElementById("cmbGMK_TAG_SHR").value; // 대출/출자종류
			var SAL_GBN_SHR  = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR      = document.getElementById("cmbSEQ_SHR").value; // 일련번호 - 급상여구분이 전체이면 미사용
			var OCC_CD_SHR   = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value; // 소속

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


			//var hnwparm = "[:PIS_YYMM_SHR]="+PIS_YYMM_SHR+"[:GMK_TAG_SHR]="+GMK_TAG_SHR+"[:SAL_GBN_SHR]="+SAL_GBN_SHR+"[:SEQ_SHR]="+SEQ_SHR+"[:OCC_CD_SHR]="+OCC_CD_SHR+"[:DPT_CD_SHR]="+DPT_CD_SHR;

            //document.form1.rptObject.SetValues(hnwparm);
//            document.form1.rptObject.RunButton("Print");

			var url = "taxa140_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&GMK_TAG_SHR="+GMK_TAG_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+
													"&SEQ_SHR="+SEQ_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_AC_LOAN.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AC_LOAN.GridToExcel("출자금/대출금관리", '', 225)

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
			dsT_AC_LOAN.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbGMK_TAG_SHR").value = "0"; // 대출/출자종류
			document.getElementById("cmbSAL_GBN_SHR").value = "0"; // 급상여구분
			document.getElementById("cmbSEQ_SHR").value = "1"; // 일련번호
			document.getElementById("cmbOCC_CD_SHR").value = ""; // 근로구분구분
			document.getElementById("txtDPT_CD_SHR").value = ""; // 소속코드
			document.getElementById("txtDPT_NM_SHR").value = ""; // 소속명
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_AC_LOAN.IsUpdated)  {

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

        	if (!dsT_AC_LOAN.isUpdated ) {
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

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);

			//대출/출자종류
			if(document.getElementById("cmbGMK_TAG_SHR").length == 0){
				for( var i = 1; i <= dsCOMMON_V3.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_V3.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_V3.NameValue(i,"CODE_NAME");
					document.getElementById("cmbGMK_TAG_SHR").add(oOption);
				}
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
			fnc_changeGMK_TAG();

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
		function fnc_changeGMK_TAG() {

			var GMK_TAG_SHR = document.getElementById("cmbGMK_TAG_SHR").value; // 정렬구분

			if(GMK_TAG_SHR == "3"){//제일은행 대출금
				document.getElementById("divBONA050_01").style.display = "";
			}else{
				document.getElementById("divBONA050_01").style.display = "none";
			}

		}

        /*************************
         * 그리드 변경 처리               *
         ************************/
		function fnc_ChangeGrid(obj) {

			if(obj == undefined || obj.value == "0"){
				form1.grdT_AC_LOAN.Format = "<C> id='{currow}'			width=44		name='NO'				align=center				value={String(Currow)}											</C>" +
																"<C> id='OCC_NM'				width=80		name='근로구분'				align=center					subsumtext='합계' </C>" +
																"<C> id='DPT_NM'				width=100		name='소속'				align=center																								</C>" +
																"<C> id='JOB_NM'				width=80		name='직위'				align=center																								</C>" +
																"<C> id='ENO_NO'				width=80		name='사번'				align=center																								</C>" +
																"<C> id='ENO_NM'				width=80		name='성명'				align=center																								</C>" +
																"<C> id='GMK_AMT'			width=100		name='출자금'			align=right    rightmargin=10																					</C>";

            }else{
				form1.grdT_AC_LOAN.Format = "<C> id='{currow}'			width=44		name='NO'				align=center				value={String(Currow)}											</C>" +
																"<C> id='OCC_NM'				width=55		name='근로구분'				align=center					subsumtext='합계' </C>" +
																"<C> id='DPT_NM'				width=120		name='소속'				align=center																								</C>" +
																"<C> id='JOB_NM'				width=60		name='직위'				align=center																								</C>" +
																"<C> id='ENO_NO'				width=70		name='사번'				align=center																								</C>" +
																"<C> id='ENO_NM'				width=70		name='성명'				align=center																								</C>" +
																"<C> id='GMK_AMT'			width=90		name='원금상환액'	    align=right    rightmargin=10																					</C>" +
																"<C> id='GMK_INT'			width=90		name='이자상환액'	    align=right    rightmargin=10																				    </C>" +
																"<C> id='SUM_AMT'			width=90		name='합계'				align=right    rightmargin=10				value={GMK_AMT+GMK_INT}									            </C>" +
															    "<C> id='GMK_BAK'			width=90		name='대출금잔액'	    align=right    rightmargin=10																					</C>";

            }

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_AC_LOAN,0,"false","right");//mgrd사용으로 주석처리

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
    | 2. 이름 : dsT_AC_LOAN                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
        <param Name=TimeOut           Value="360000">
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 대출/출자종류 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_V3"/>
       <jsp:param name="CODE_GUBUN"    value="V3"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_LOAN                                    |
    | 3. Table List : T_AC_LOAN                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_LOAN Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_AC_LOAN Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_AC_LOAN Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_AC_LOAN event="OnSuccess()">

   		var iCount = dsT_AC_LOAN.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_AC_LOAN.ExportData(1, dsT_AC_LOAN.CountRow, true));

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_AC_LOAN event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">출자금/대출금관리</td>
					<td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">출자금/대출금관리</font></td>
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
								<col width="150"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">해당년월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">구&nbsp;&nbsp;&nbsp;분</td>
								<td>
									<select id="cmbGMK_TAG_SHR" style="width:90" onChange="fnc_ChangeGrid(this);fnc_changeGMK_TAG();fnc_SearchList();">
									</select>
								</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:90" onChange="fnc_SearchList();">
										<option value="" >전체</option>
									</select>
								</td>
								<td align="center">&nbsp;</td>
							</tr>
							<tr class="paddingTop5">
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">급상여구분</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="width:90" onChange="fnc_SearchList();">
										<option value="0" >급여</option>
	                                    <option value="1" >상여</option>
									</select>
								</td>
								<td align="center" class="searchState">일련번호</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:90" onChange="fnc_SearchList();">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
								</td>
								<td align="center" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
									</a>
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
		<td class="paddingTop15">
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
<div id="divBONA050_01" style="position:absolute; left:619; top:155; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
		</td>
	</tr>
	</table>
</div>
<!-- 조건에 따른 DISPLAY 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN">
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