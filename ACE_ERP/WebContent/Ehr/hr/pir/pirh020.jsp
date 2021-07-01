	<!--*************************************************************************
	* @source      : pirh020.jsp												*
	* @description : 출신교별인원현황 PAGE 									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/03      채갑병        최초작성			 						*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>출신교별인원현황(pirh020)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
		var today = getToday();

		// default grid ID & NAME
		var arrId   = new Array("JOB_NM","CNT_TOT","SCH_01","SCH_02","SCH_03","SCH_04","SCH_05","SCH_06","SCH_07","SCH_08","SCH_09","SCH_10","SCH_11","SCH_12","SCH_13","SCH_14","CNT_ETC");
       	var arrName = new Array("구분","총원","고려","동국","서울","건국","중앙","연세","국민","한양","경희","단국","부산","전북","울산","수원","기타");

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// 기준일자 입력 필수
        	if( document.form1.txtHIR_YMD_SHR.value=="" ){
        		alert("기준일자를 입력하십시오. 예)"+today);
        		return;
        	}
			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var EDGR_CD_SHR = document.getElementById("cmbEDGR_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;

			dsVI_T_CM_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.h.pirh020.cmd.PIRH020CMD&S_MODE=SHR&HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&EDGR_CD_SHR="+EDGR_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
			dsVI_T_CM_PERSON.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
        	// 기준일자 입력 필수
        	if( document.form1.txtHIR_YMD_SHR.value=="" ){
        		alert("기준일자를 입력하십시오. 예)"+today);
        		return;
        	}
			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var EDGR_CD_SHR = document.getElementById("cmbEDGR_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;

			var url = "pirh020_PV.jsp?HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&EDGR_CD_SHR="+EDGR_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("출신교별인원현황", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
        	// 초기화
        	document.form1.txtHIR_YMD_SHR.value    = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	document.form1.cmbEDGR_CD_SHR.selectedIndex = 5;
        	//document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';
        	document.form1.txtHIR_YMD_SHR.value = today;

        	dsVI_T_CM_PERSON.ClearData();
			setDefaultTitle();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
		//		if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style 적용

            // 근로구분 구분 검색 콤보박스 생성
			/*
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			*/
            // 학력 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_E1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_E1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_E1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbEDGR_CD_SHR").add(oOption);
			}

			document.form1.txtHIR_YMD_SHR.value = today;
			document.form1.cmbEDGR_CD_SHR.selectedIndex = 5;

			setDefaultTitle();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        /********************************************
         * Default GirdTitle               			*
         ********************************************/
        function setDefaultTitle(){
        	for(var i=0; i<arrId.length; i++){
				document.grdVI_T_CM_PERSON.ColumnProp( arrId[i],"Name") = arrName[i];
				document.grdVI_T_CM_PERSON.ColumnProp( arrId[i],"Show") = "true";
        	}
        }

 		/********************************************
         * 결과에 따른 그리드 타이틀 매핑                   			*
         ********************************************/
        function setGridTitle(){

        	// 첫번째 행은 그리드 타이틀(상위 14위권 내의 학교명)로 리턴됨 - 배열로 저장
        	var arrTitle = new Array(17); // 17개 칼럼을 순서대로
        	for(var i=0;i<arrTitle.length; i++){
        		arrTitle[i] = dsVI_T_CM_PERSON.NameValue(1, arrId[i]);
        	}

        	// 그리드의 모든 칼럼 숨김
        	for(var j=0; j<arrId.length; j++){
				document.grdVI_T_CM_PERSON.ColumnProp( arrId[j],"Show") = "false";
        	}
			var SCH_01 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_01").trim()  ;
			var SCH_02 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_02").trim()  ;
			var SCH_03 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_03").trim()  ;
			var SCH_04 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_04").trim()  ;
			var SCH_05 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_05").trim()  ;
			var SCH_06 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_06").trim()  ;
			var SCH_07 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_07").trim()  ;
			var SCH_08 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_08").trim()  ;
			var SCH_09 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_09").trim()  ;
			var SCH_10 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_10").trim()  ;
			var SCH_11 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_11").trim()  ;
			var SCH_12 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_12").trim()  ;
			var SCH_13 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_13").trim()  ;
			var SCH_14 =		dsVI_T_CM_PERSON.NameValue(1, "SCH_14").trim()  ;
/*
			alert("["+SCH_01+"] ["+SCH_01.length+"]");
			alert("["+SCH_02+"] ["+SCH_02.length+"]");
            alert("["+SCH_03+"] ["+SCH_03.length+"]");
            alert("["+SCH_04+"] ["+SCH_04.length+"]");
            alert("["+SCH_05+"] ["+SCH_05.length+"]");
            alert("["+SCH_06+"] ["+SCH_06.length+"]");
            alert("["+SCH_07+"] ["+SCH_07.length+"]");
            alert("["+SCH_08+"] ["+SCH_08.length+"]");
            alert("["+SCH_09+"] ["+SCH_09.length+"]");
            alert("["+SCH_10+"] ["+SCH_10.length+"]");
            alert("["+SCH_11+"] ["+SCH_11.length+"]");
            alert("["+SCH_12+"] ["+SCH_12.length+"]");
            alert("["+SCH_13+"] ["+SCH_13.length+"]");
            alert("["+SCH_14+"] ["+SCH_14.length+"]");
*/
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_01", "width") = ""+(SCH_01.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_02", "width") = ""+(SCH_02.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_03", "width") = ""+(SCH_03.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_04", "width") = ""+(SCH_04.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_05", "width") = ""+(SCH_05.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_06", "width") = ""+(SCH_06.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_07", "width") = ""+(SCH_07.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_08", "width") = ""+(SCH_08.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_09", "width") = ""+(SCH_09.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_10", "width") = ""+(SCH_10.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_11", "width") = ""+(SCH_11.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_12", "width") = ""+(SCH_12.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_13", "width") = ""+(SCH_13.length*10+20);
             document.grdVI_T_CM_PERSON.ColumnProp( "SCH_14", "width") = ""+(SCH_14.length*10+20);

        	// 값이 들어있는 칼럼에 한해 표시
        	for(var k=0; k<arrTitle.length; k++){
        		if( arrTitle[k] != "" ){
	        		if( k != (arrTitle.length-1) ){ // 마지막 칼럼(CNT_ETC) 아니면

	        			document.grdVI_T_CM_PERSON.ColumnProp( arrId[k], "Show") = "true";
	        			//document.grdVI_T_CM_PERSON.ColumnProp( arrId[k], "width") = "70";
		        		document.grdVI_T_CM_PERSON.ColumnProp( arrId[k], "Name") = arrTitle[k];
			        }else{                          // 마지막 칼럼(CNT_ETC) 이면
		        		// '기타'칼럼 - 모든 Row에 값이 하나라도 있으면 표시
			        	var isExist = false;
			        	for(var m=2; m<dsVI_T_CM_PERSON.CountRow; m++){
				        	if(dsVI_T_CM_PERSON.NameValue( m, arrId[k]) != ""){
				        	 isExist = true;
				        	}
			        	}
			        	if( isExist ){
					       	document.grdVI_T_CM_PERSON.ColumnProp( arrId[k], "Show") = "true";
					       	document.grdVI_T_CM_PERSON.ColumnProp( arrId[k], "Name")  = arrTitle[k];
			        	}
			        }


        		}
        	}

        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON,I:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 학력 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E1"/>
       <jsp:param name="CODE_GUBUN"    value="E1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			setDefaultTitle();
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			if(iCount > 1){
				setGridTitle();
				dsVI_T_CM_PERSON.DeleteRow(1);
				/*
				grdVI_T_CM_PERSON.Redraw = "true";
        		dsVI_T_CM_PERSON.SetDataHeader(
        	        			"JOB_NM:STRING(20),"+			// 시작일자
								"CNT_TOT:DECIMAL(10),"+			// 시작일자
	        					"SCH_01:DECIMAL(10),"+			// 등록번호
	                            "SCH_02:DECIMAL(10),"+			// 소속
	                            "SCH_03:DECIMAL(10),"+			// 소속
								"SCH_04:DECIMAL(10),"+			// 직위
								"SCH_05:DECIMAL(10),"+			// 성명
								"SCH_06:DECIMAL(10),"+			// 근태항목
								"SCH_07:DECIMAL(10),"+			// 근태항목
								"SCH_08:DECIMAL(10),"+			// 근태항목
								"SCH_09:DECIMAL(10),"+			// 근태항목
								"SCH_10:DECIMAL(10),"+			// 근태항목
								"SCH_11:DECIMAL(10),"+			// 근태항목
								"SCH_12:DECIMAL(10),"+			// 근태항목
								"SCH_13:DECIMAL(10),"+			// 근태항목
								"SCH_14:DECIMAL(10),"+			// 근태항목
								"CNT_ETC:DECIMAL(10)"			// 근태항목
								);
				*/

				if(dsVI_T_CM_PERSON.CountRow == 0){
					fnc_Message(document.getElementById("resultMessage"),"MSG_02");
					setDefaultTitle();
					alert("검색하신 조건의 자료가 없습니다!");
				}else{
					fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow-1);
				}
			}
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">출신교별인원현황</td>
					<td align="right" class="navigator">HOME/인사관리/내역별인원현황/<font color="#000000">출신교별인원현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준일자</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','104','108');"></a>
					</td>
					<td class="searchState" align="right" >학력구분</td>
					<td class="padding2423" align="left" >
						<select id="cmbEDGR_CD_SHR" style="WIDTH: 80%" onChange="fnc_SearchList()">
						</select>
					</td>
					<input type="hidden" id="cmbGBN_CD_SHR" value="0">
					<input type="hidden" id="cmbOCC_CD_SHR" value="0">
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<Param Name="ViewSummary"   value="1" >
						<param name="Format" value='
							<FC> id="{CUROW}"	width=29	name="NO"		align=center	value={String(Currow)}</C>
							<FC> id="JOB_NM"		width=62	name="구분"		align=center	Edit=none	SumText="합 계" suppress=1</FC>
							<FC> id="CNT_TOT"	width=43	name="총원"		align=center	Edit=none	sumtext="{sum(integer(CNT_TOT))}" </FC>
							<C> id="SCH_01"		width=43	name="고려"		align=center	Edit=none	sumtext="{sum(integer(SCH_01))}" </FC>
							<C> id="SCH_02"		width=43	name="동국"		align=center	Edit=none	sumtext="{sum(integer(SCH_02))}" </C>
							<C> id="SCH_03"		width=43	name="서울"		align=center	Edit=none	sumtext="{sum(integer(SCH_03))}" </C>
							<C> id="SCH_04"		width=43	name="건국"		align=center	Edit=none	sumtext="{sum(integer(SCH_04))}" </C>
							<C> id="SCH_05"		width=43	name="중앙"		align=center	Edit=none	sumtext="{sum(integer(SCH_05))}" </C>
							<C> id="SCH_06"		width=43	name="연세"		align=center	Edit=none	sumtext="{sum(integer(SCH_06))}" </C>
							<C> id="SCH_07"		width=43	name="국민"		align=center	Edit=none	sumtext="{sum(integer(SCH_07))}" </C>
							<C> id="SCH_08"		width=43	name="한양"		align=center	Edit=none	sumtext="{sum(integer(SCH_08))}" </C>
							<C> id="SCH_09"		width=43	name="경희"		align=center	Edit=none	sumtext="{sum(integer(SCH_09))}" </C>
							<C> id="SCH_10"		width=43	name="단국"		align=center	Edit=none	sumtext="{sum(integer(SCH_10))}" </C>
							<C> id="SCH_11"		width=43	name="부산"		align=center	Edit=none	sumtext="{sum(integer(SCH_11))}" </C>
							<C> id="SCH_12"		width=43	name="전북"		align=center	Edit=none	sumtext="{sum(integer(SCH_12))}" </C>
							<C> id="SCH_13"		width=43	name="울산"		align=center	Edit=none	sumtext="{sum(integer(SCH_13))}" </C>
							<C> id="SCH_14"		width=43	name="수원"		align=center	Edit=none	sumtext="{sum(integer(SCH_14))}" </C>
							<C> id="CNT_ETC"	width=43	name="기타"		align=center	Edit=none	sumtext="{sum(integer(CNT_ETC))}" </C>
						'>
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

