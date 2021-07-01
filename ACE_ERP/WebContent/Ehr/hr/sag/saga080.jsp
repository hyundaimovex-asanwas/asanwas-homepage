<!--
    ************************************************************************************
    * @source         : saga080.jsp 				                                                                                     *
    * @description   : 급여대비표 PAGE.                                                                             *
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
<title>급여대비표</title>
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; 	// 해당년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; 		// 근로구분
			var CD_GBN_SHR = document.getElementById("cmbCD_GBN_SHR").value; 		//소속,직위 구분
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; 		// 소속구분
			var TOTAL_SHR = document.getElementById("chkTOTAL_SHR").checked; 		// 전체구분

			//해당년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
					alert("해당년월를 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}
			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}

            //데이터셋 전송

			if(document.tabSAGA080.ActiveIndex==1){
			    dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&CD_GBN_SHR="+CD_GBN_SHR;
	            dsT_CP_PAYMASTER_01.Reset();

	        }else if(document.tabSAGA080.ActiveIndex==2){
	            dsT_CP_PAYMASTER_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR;
	            dsT_CP_PAYMASTER_02.Reset();
			}else{
	            dsT_CP_PAYMASTER_03.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga080.cmd.SAGA080CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&CD_GBN_SHR="+CD_GBN_SHR;
	            dsT_CP_PAYMASTER_03.Reset();
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분
			var CD_GBN_SHR = document.getElementById("cmbCD_GBN_SHR").value; //소속,직위 구분
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 소속구분
			var TOTAL_SHR = document.getElementById("chkTOTAL_SHR").checked; // 전체구분

			//해당년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
					alert("해당년월를 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}
			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
			}

            //데이터셋 전송
			if(document.tabSAGA080.ActiveIndex==2){
	            var url = "saga081_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR+"&GUBUN=1"+"&CD_GBN_SHR="+CD_GBN_SHR;
			}else if(document.tabSAGA080.ActiveIndex==3){

	            var url = "saga082_PV.jsp?PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+
													            "&DPT_CD_SHR="+DPT_CD_SHR+"&TOTAL_SHR="+TOTAL_SHR+"&GUBUN=2"+ "&CD_GBN_SHR=" + CD_GBN_SHR;
            }
   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if(document.tabSAGA080.ActiveIndex==1){
               if (dsT_CP_PAYMASTER_01.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_01.GridToExcel("급여대비표(지금내역)", '', 225)
            }else if (document.tabSAGA080.ActiveIndex==2){
			   if (dsT_CP_PAYMASTER_02.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("급여대비표(급여변경자)", '', 225)
            }else if (document.tabSAGA080.ActiveIndex==3){
			   if (dsT_CP_PAYMASTER_03.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("급여대비표(급여변경자)", '', 225)
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

		 	dsT_CP_PAYMASTER_01.ClearData();
		  	dsT_CP_PAYMASTER_02.ClearData();
		 	dsT_CP_PAYMASTER_03.ClearData();

            document.tabSAGA080.ActiveIndex=1;
		 	document.getElementById("cmbOCC_CD_SHR").value = "";
			document.getElementById("txtDPT_CD_SHR").value = "";
			document.getElementById("txtDPT_NM_SHR").value = "";
			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtPIS_YYMM_SHR.focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_CP_PAYMASTER_02.IsUpdated)  {

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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//근로구분
			if(document.getElementById("cmbOCC_CD_SHR").length == 1){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7); // 해당년월

			//화면겹침버그 임시 해결
			document.tabSAGA080.ActiveIndex=3;
			document.tabSAGA080.ActiveIndex=2;
			document.tabSAGA080.ActiveIndex=1;

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_02,0,"false","false");
			cfStyleGrid(form1.grdT_CP_PAYMASTER_03,0,"false","false");

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
    | 2. 이름 : dsT_CP_PAYMASTER_01                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_02                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

     <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_PAYMASTER_03                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_PAYMASTER_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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


    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
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

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
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

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
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

    <script language=JavaScript for=tabSAGA080 event=OnSelChanged(index)>

		if(document.tabSAGA080.ActiveIndex==1){
		    document.getElementById("tabSAGA080_TOTAL").style.display = "none";
  			document.getElementById("cmbCD_GBN_SHR").disabled = false;
			document.form1.txtDPT_CD_SHR.readOnly = true;
  			document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";
  			document.getElementById("imgDPT_CD_SHR").disabled = true;
  			document.form1.txtDPT_CD_SHR.value = "";
  			document.form1.txtDPT_NM_SHR.value = "";
            document.getElementById("imgPrint").style.display = "none";

           }else if (document.tabSAGA080.ActiveIndex==2){
			document.getElementById("tabSAGA080_TOTAL").style.display = "";
			document.getElementById("cmbCD_GBN_SHR").value = "0";
  			document.getElementById("cmbCD_GBN_SHR").disabled = true;
			document.form1.txtDPT_CD_SHR.readOnly = false;
  			document.form1.txtDPT_CD_SHR.className = "";
  			document.getElementById("imgDPT_CD_SHR").disabled = false;
            document.getElementById("imgPrint").style.display = "";

           }else if (document.tabSAGA080.ActiveIndex==3){
			document.getElementById("tabSAGA080_TOTAL").style.display = "none";
  			document.getElementById("cmbCD_GBN_SHR").disabled = false;
			document.form1.txtDPT_CD_SHR.readOnly = true;
  			document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";
  			document.getElementById("imgDPT_CD_SHR").disabled = true;
  			document.form1.txtDPT_CD_SHR.value = "";
  			document.form1.txtDPT_NM_SHR.value = "";
            document.getElementById("imgPrint").style.display = "";

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급여대비표</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">급여대비표</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="120"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="300"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="right" class="searchState">해당년월&nbsp;</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="right" class="searchState">근로구분&nbsp;</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">전체</option>
									</select>
								</td>
								<td align="center" class="searchState">&nbsp;</td>
								<td>
									<select id="cmbCD_GBN_SHR" style="width:80" onChange="fnc_SearchList();">
										<option value="0" >소속별</option>
	                                    <option value="1" >직위별</option>
									</select>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
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

<!-- 탭에 따른 DISPLAY 시작 -->
<div id="tabSAGA080_TOTAL" style="position:absolute; left:617; top:137; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
			<input type="checkbox" id="chkTOTAL_SHR" style="border:0" align="absmiddle" checked="checked" onClick="fnc_SearchList();">전체리스트
		</td>
	</tr>
	</table>
</div>
<!-- 탭에 따른 DISPLAY 끝 -->

<!-- 탭 사용 컴퍼넌트 시작 -->
<comment id="__NSID__">
<object id=tabSAGA080 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:140; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"	value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 				value="1">

	<param name="Format"			value='
	    <T>divid="tabSAGA080_01"	title="지급내역"</T>
		<T>divid="tabSAGA080_02"	title="급여변경자"</T>
		<T>divid="tabSAGA080_03"	title="총괄표"</T>'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- 탭 사용 컴퍼넌트 끝 -->


<!-- 탭0 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA080_01" style="position:absolute; left:20; top:160; width:800; height:300; z-index:3; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=43		name="NO"			    align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"		    width=90		name="소속"	            align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"	        width=45		name="직위"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"		    width=75		name="사번"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"	        width=65		name="성명"		        align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMT_0"		width=80		name="급여액"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMT_1"	    width=80		name="상여액"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FREE_TAX"		width=67		name="중식대"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NPEN_AMT"		width=67		name="국민연금"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HINU_AMT"	    width=67		name="건강보험"		    align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OLD_AMT"		width=100		name="노인장기요양보험"		align=right	   Edit=none	    SubBgColor="#99FFCC"</C>
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
<!-- 탭0 조건 입력 테이블 끝 -->




<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA080_02" style="position:absolute; left:20; top:160; width:800; height:300; z-index:5;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=44		name="NO"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"			width=105		name="소속"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"			width=105		name="직위"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"			width=105		name="사번"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"			width=105		name="성명"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_AMT"		width=105		name="전월급여"		align=right	    	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_AMT"		width=105		name="당월급여"		align=right		    Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BALANCE"		width=105		name="차액"			align=right		    Edit=none		SubBgColor="#99FFCC"	value={AFT_AMT - BEF_AMT}	</C>
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
<div class=page id="tabSAGA080_03" style="position:absolute; left:20; top:160; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"		width=44		name="NO"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_NM"		width=105		name="소속/직위"	align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_PERSONS"	width=80		name="전월인원"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BEF_AMT"		width=130		name="전월금액"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_PERSONS"	width=80		name="당월인원"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AFT_AMT"		width=130		name="당월금액"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CHANGE_PERSONS"	width=80		name="변경인원"		align=right		Edit=none		SubBgColor="#99FFCC"	value={AFT_PERSONS - BEF_PERSONS}</C>
						<C> id="BALANCE"		width=130		name="차액"			align=right		Edit=none		SubBgColor="#99FFCC"	value={AFT_AMT - BEF_AMT}		 </C>
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


</form>
<!-- form 끝 -->

</body>
</html>
