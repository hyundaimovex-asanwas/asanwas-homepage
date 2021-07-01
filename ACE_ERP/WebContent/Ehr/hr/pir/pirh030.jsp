	<!--*************************************************************************
	* @source      : pirh030.jsp												*
	* @description : 근속년수별인원현황 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/04            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>근속년수별인원현황(pirh030)</title>
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
		var arrId   = new Array("HIR_01","HIR_02","HIR_03","HIR_04","HIR_05","HIR_06","HIR_07","HIR_08","HIR_09","HIR_10","HIR_11","HIR_12","HIR_13","HIR_14","HIR_15","HIR_16","HIR_17","HIR_18","HIR_19","HIR_20","HIR_21");

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// 기준일자 입력 필수
        	if( document.form1.txtHIR_YMD_SHR.value=="" ){
        		alert("기준일자를 입력하십시오. 예)"+today);
        		return;
        	}

        	// 년도별, 입력별
        	var CON_SHR = "";
        	if( document.form1.rdoHIR_SHR[0].checked ){
        		CON_SHR = "ToDefault";
        	}else{
        		CON_SHR = "ToManual";
        	}

        	// 입력별 일 경우에만 유효성 체크
			if( CON_SHR == "ToManual"){

				if(  document.form1.txtHIR_SHR_01.value == "" ){
					alert("조회 기준 년을 입력하십시오.");
					return;
				}
	        	for( var i=8; i<14; i++){
		   	    	// 근속년수필드의 중간에 공백필드가 존재하는지 체크
		   	    	if(document.form1.elements[i].value == ""){
				       	for( var j=i+1; j<14; j++){
			    	   		if(document.form1.elements[j].value != ""){
			       				document.form1.elements[j-1].focus();
			       				alert("조회하고자 하는 근속년수를 올바르게 입력하십시오.\n(*공백필드가 존재합니다.)");
		        				return;
			       			}
			       		}
	        		}
	        	}

			   	// 근속년수필드의 중간값이 이후에 오는 값들보다 큰지 체크
	        	for( var k=8; k<13; k++){
			       	if( parseInt(document.form1.elements[k].value) >= parseInt(document.form1.elements[k+1].value) ){
			       		document.form1.elements[k+1].focus();
			       		alert("조회하고자 하는 근속년수를 올바르게 입력하십시오.\n(*근속년수 구분이 올바르지 않습니다.)");
		       			return;
			       	}
	        	}

	        	// 근속년수 조건에 맞게 그리드 타이틀 매핑
				setGridTitle();
        	}

        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "HIR";  // 당사
        	}else{
        		FLAG_SHR = "HIRG"; // GROUP
        	}

        	var HIR_SHR  = document.form1.txtHIR_SHR_01.value
        	              	+"|"+ document.form1.txtHIR_SHR_02.value
        					+"|"+ document.form1.txtHIR_SHR_03.value
							+"|"+ document.form1.txtHIR_SHR_04.value
							+"|"+ document.form1.txtHIR_SHR_05.value
							+"|"+ document.form1.txtHIR_SHR_06.value
							+"|"+ document.form1.txtHIR_SHR_07.value;

			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;  // 지역(본사, 지방)

//alert(FLAG_SHR);
			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.h.pirh030.cmd.PIRH030CMD&S_MODE=SHR&HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&HIR_SHR="+HIR_SHR+"&CON_SHR="+CON_SHR;
			trVI_T_CM_PERSON.post();

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

        	// 년도별, 입력별
        	var CON_SHR = "";
        	if( document.form1.rdoHIR_SHR[0].checked ){
        		CON_SHR = "ToDefault";
        	}else{
        		CON_SHR = "ToManual";
        	}

        	// 입력별 일 경우에만 유효성 체크
			if( CON_SHR == "ToManual"){

				if(  document.form1.txtHIR_SHR_01.value == "" ){
					alert("조회 기준 년을 입력하십시오.");
					return;
				}
	        	for( var i=8; i<14; i++){
		   	    	// 근속년수필드의 중간에 공백필드가 존재하는지 체크
		   	    	if(document.form1.elements[i].value == ""){
				       	for( var j=i+1; j<14; j++){
			    	   		if(document.form1.elements[j].value != ""){
			       				document.form1.elements[j-1].focus();
			       				alert("조회하고자 하는 근속년수를 올바르게 입력하십시오.\n(*공백필드가 존재합니다.)");
		        				return;
			       			}
			       		}
	        		}
	        	}

			   	// 근속년수필드의 중간값이 이후에 오는 값들보다 큰지 체크
	        	for( var k=8; k<13; k++){
			       	if( parseInt(document.form1.elements[k].value) >= parseInt(document.form1.elements[k+1].value) ){
			       		document.form1.elements[k+1].focus();
			       		alert("조회하고자 하는 근속년수를 올바르게 입력하십시오.\n(*근속년수 구분이 올바르지 않습니다.)");
		       			return;
			       	}
	        	}

	        	// 근속년수 조건에 맞게 그리드 타이틀 매핑
				setGridTitle();
        	}

        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "HIR";  // 당사
        	}else{
        		FLAG_SHR = "HIRG"; // GROUP
        	}


        	var HIR_SHR  = document.form1.txtHIR_SHR_01.value
        	              	+"|"+ document.form1.txtHIR_SHR_02.value
        					+"|"+ document.form1.txtHIR_SHR_03.value
							+"|"+ document.form1.txtHIR_SHR_04.value
							+"|"+ document.form1.txtHIR_SHR_05.value
							+"|"+ document.form1.txtHIR_SHR_06.value
							+"|"+ document.form1.txtHIR_SHR_07.value;

			var HIR_YMD_SHR = document.getElementById("txtHIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;  // 지역(본사, 지방)

			if(CON_SHR == "ToDefault"){
				// 년도별 검색
				var url = "pirh030_PV.jsp?HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&HIR_SHR="+HIR_SHR+"&CON_SHR="+CON_SHR;
			}else{
				// 입력별 검색
				var url = "pirh031_PV.jsp?HIR_YMD_SHR="+HIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&HIR_SHR="+HIR_SHR;
	        }
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

            form1.grdVI_T_CM_PERSON.GridToExcel("근속년수별인원현황", '', 225)
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
        	document.form1.txtHIR_YMD_SHR.value = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	//document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	//document.form1.rdoGBN_SHR[1].checked = true;
        	document.getElementById("resultMessage").innerText = ' ';
        	document.form1.txtHIR_YMD_SHR.value = today;

        	dsVI_T_CM_PERSON.ClearData();
        	setDefaultYmd();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
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

            // 근로구분 구분 검색 콤보박스 생성
			/*
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			*/
			document.form1.txtHIR_YMD_SHR.value = today;
			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style 적용

			setDefaultYmd();
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
         * Default 연령 조회값 입력                         			*
         ********************************************/
        function setDefaultYmd(){
        	document.form1.txtHIR_SHR_01.value = "1";
        	document.form1.txtHIR_SHR_02.value = "1";
        	document.form1.txtHIR_SHR_03.value = "3";
        	document.form1.txtHIR_SHR_04.value = "5";
        	document.form1.txtHIR_SHR_05.value = "10";
        	document.form1.txtHIR_SHR_06.value = "15";
        	document.form1.txtHIR_SHR_07.value = "20";

        	setGridTitle();
        }

		/********************************************
         * 조건(입력별)에 따른 그리드 타이틀 매핑     			*
         ********************************************/
        function setGridTitle(){
        	var HIR_SHR_01 = document.form1.txtHIR_SHR_01.value;
        	var HIR_SHR_02 = document.form1.txtHIR_SHR_02.value;
        	var HIR_SHR_03 = document.form1.txtHIR_SHR_03.value;
        	var HIR_SHR_04 = document.form1.txtHIR_SHR_04.value;
        	var HIR_SHR_05 = document.form1.txtHIR_SHR_05.value;
        	var HIR_SHR_06 = document.form1.txtHIR_SHR_06.value;
        	var HIR_SHR_07 = document.form1.txtHIR_SHR_07.value;

        	for(var i=0; i<arrId.length ; i++){
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show") = "false";
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "width") = "78";
        	}

        	if( HIR_SHR_01 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_01", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_01', "Name") = HIR_SHR_01+"년미만";
	        }
        	if( HIR_SHR_02 != "" ){
		       	document.grdVI_T_CM_PERSON.ColumnProp("HIR_02", "Show") = "true";
		       	document.grdVI_T_CM_PERSON.ColumnProp('HIR_02', "Name") = HIR_SHR_02+"년이상";
	        }
        	if( HIR_SHR_03 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_03", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_03', "Name") = HIR_SHR_03+"년이상";
	        }
        	if( HIR_SHR_04 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_04", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_04', "Name") = HIR_SHR_04+"년이상";
	        }
        	if( HIR_SHR_05 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_05", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_05', "Name") = HIR_SHR_05+"년이상";
	        }
        	if( HIR_SHR_06 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_06", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_06', "Name") = HIR_SHR_06+"년이상";
	        }
        	if( HIR_SHR_07 != "" ){
	        	document.grdVI_T_CM_PERSON.ColumnProp("HIR_07", "Show") = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp('HIR_07', "Name") = HIR_SHR_07+"년이상";
	        }
        }

		/********************************************
         * 조건(년도별)에 따른 그리드 타이틀 매핑     			*
         ********************************************/
        function setGridTitle2(){
        	for(var i=0; i<arrId.length ; i++){
        		if( i<7 ){
		        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Name")  = i+"년이상";
        		}
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show")  = "true";
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "width") = "60";
        	}
        }

		/********************************************
         * 검색필드 활성화 처리                           			*
         ********************************************/
        function changeInput() {
            // 년도별
        	if( document.form1.rdoHIR_SHR[0].checked ){
        		for(var i=7; i<14; i++){
	        		document.form1.elements[i].value     = "";
    	    		document.form1.elements[i].readOnly  = true;
		  			document.form1.elements[i].className = "input_ReadOnly";
        		}
        		setGridTitle2();

        	// 입력별
        	}else{
        		for(var i=7; i<14; i++){
        			if(i==8){continue;}
    	    		document.form1.elements[i].readOnly  = false;
		  			document.form1.elements[i].className = "";
        		}
        		setDefaultYmd();
        	}

        	// 조회
        	fnc_SearchList();
        }

		/********************************************
         * 검색필드 활성화 처리                           			*
         ********************************************/
        function setNextbox() {
	        if( document.form1.txtHIR_SHR_01.value == 0 ){
	        	document.form1.txtHIR_SHR_01.value = "";
	        	alert("0은 입력할 수 없습니다.");
	        }else{
	        	document.form1.txtHIR_SHR_02.value = document.form1.txtHIR_SHR_01.value;
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
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsVI_T_CM_PERSON)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자3434료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
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
		// 트랜젝션을 이용한 조회이므로  "**건의 자료가 조회되었습니다."  표시
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow/2-1);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근속년수별인원현황</td>
					<td align="right" class="navigator">HOME/인사관리/내역별인원현황/<font color="#000000">근속년수별인원현황</font></td>
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
					<col width="240"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준일자</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtHIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgHIR_YMD_SHR" name="imgHIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtHIR_YMD_SHR','','114','108');"></a>
					</td>
					<td class="searchState" align="right">입사기준일</td>
					<td class="padding2423" align="left">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;" onClick="fnc_SearchList()">당사
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;" onClick="fnc_SearchList()">GROUP
					</td>

					<input type="hidden" id="cmbOCC_CD_SHR" value="0">
					<!--
					<td class="searchState" align="right">근로구분별</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 70%" onChange="fnc_SearchList()">
							<option value="0">모두</option>
						</select>
					</td>
					-->
				</tr>
				<tr>
					<td align="right" class="searchState">근속년수</td>
					<td align="left" class="padding2423" ><b>&nbsp;&nbsp;TO : </b>
						<input type="radio" name="rdoHIR_SHR" id="rdoHIR_SHR" checked style="margin-bottom:-2px;border:0;" onClick="changeInput()">년도별&nbsp;&nbsp;(0,1,2,3...20)
					</td>
					<td class="searchState" align="right">지역별</td>
					<td class="padding2423" align="left">
						<select id="cmbGBN_CD_SHR" style="WIDTH: 70%" onChange="fnc_SearchList()">
							<option value="0">모두</option>
							<option value="1">본사</option>
							<option value="2">지방</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="searchState">&nbsp;</td>
					<td class="padding2423" colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="rdoHIR_SHR" id="rdoHIR_SHR" checked style="margin-left:7px;margin-bottom:-2px;border:0;" onClick="changeInput()">입력별
						<input id="txtHIR_SHR_01" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()" onFocusout="setNextbox();">미만
						<input id="txtHIR_SHR_02" size="4" maxLength="2" class="input_ReadOnly" readonly onKeypress="cfCheckNumber()">이상
						<input id="txtHIR_SHR_03" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						<input id="txtHIR_SHR_04" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						<input id="txtHIR_SHR_05" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						<input id="txtHIR_SHR_06" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						<input id="txtHIR_SHR_07" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
					</td>
					<td>&nbsp;</td>
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
						<param name="SortView" value="Left">
						<param name=SuppressOption 		value="1">
						<param name="Format" value='
							<C> id="RN"			width=30	name="NO"			align=center	value="{decode(RN,0,"",RN)}"	suppress=2		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="JOB_NM"		width=60	name="구분"			align=left		Edit=none	LeftMargin="10"		suppress=1		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_TOT"	width=65	name="총원"			align=right		Edit=none	 RightMargin="10"			BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_AVG"	width=78	name="평균"			align=center	Edit=none								BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_01"		width=78	name="1년미만"		align=center	Edit=none	 Value={Decode(HIR_01,0,"",HIR_01)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_02"		width=78	name="1년이상"		align=center	Edit=none	 Value={Decode(HIR_02,0,"",HIR_02)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_03"		width=78	name="3년이상"		align=center	Edit=none	 Value={Decode(HIR_03,0,"",HIR_03)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_04"		width=78	name="5년이상"		align=center	Edit=none	 Value={Decode(HIR_04,0,"",HIR_04)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_05"		width=78	name="10년이상"		align=center	Edit=none	 Value={Decode(HIR_05,0,"",HIR_05)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_06"		width=78	name="15년이상"		align=center	Edit=none	 Value={Decode(HIR_06,0,"",HIR_06)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_07"		width=78	name="20년이상"		align=center	Edit=none	 Value={Decode(HIR_07,0,"",HIR_07)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="HIR_08"		width=78	name="7년이상"		align=center	Edit=none	 Value={Decode(HIR_08,0,"",HIR_08)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_09"		width=78	name="8년이상"		align=center	Edit=none	 Value={Decode(HIR_09,0,"",HIR_09)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_10"		width=78	name="9년이상"		align=center	Edit=none	 Value={Decode(HIR_10,0,"",HIR_10)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_11"		width=78	name="10년이상"		align=center	Edit=none	 Value={Decode(HIR_11,0,"",HIR_11)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_12"		width=78	name="11년이상"		align=center	Edit=none	 Value={Decode(HIR_12,0,"",HIR_12)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_13"		width=78	name="12년이상"		align=center	Edit=none	 Value={Decode(HIR_13,0,"",HIR_13)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_14"		width=78	name="13년이상"		align=center	Edit=none	 Value={Decode(HIR_14,0,"",HIR_14)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_15"		width=78	name="14년이상"		align=center	Edit=none	 Value={Decode(HIR_15,0,"",HIR_15)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_16"		width=78	name="15년이상"		align=center	Edit=none	 Value={Decode(HIR_16,0,"",HIR_16)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_17"		width=78	name="16년이상"		align=center	Edit=none	 Value={Decode(HIR_17,0,"",HIR_17)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_18"		width=78	name="17년이상"		align=center	Edit=none	 Value={Decode(HIR_18,0,"",HIR_18)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_19"		width=78	name="18년이상"		align=center	Edit=none	 Value={Decode(HIR_19,0,"",HIR_19)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_20"		width=78	name="19년이상"		align=center	Edit=none	 Value={Decode(HIR_20,0,"",HIR_20)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
							<C> id="HIR_21"		width=78	name="20년이상"		align=center	Edit=none	 Value={Decode(HIR_21,0,"",HIR_21)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}		Show="false"</C>
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

