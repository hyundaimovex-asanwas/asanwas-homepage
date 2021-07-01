	<!--*************************************************************************
	* @source      : pirh010.jsp												*
	* @description : 연령별인원현황 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/04            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>연령별인원현황(pirh010)</title>
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
		var arrId   = new Array("AGE_01","AGE_02","AGE_03","AGE_04","AGE_05","AGE_06","AGE_07","AGE_08","AGE_09","AGE_10");

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// 기준일자 입력 필수
        	if( document.form1.txtBIR_YMD_SHR.value=="" ){
        		alert("기준일자를 입력하십시오. 예)"+today);
        		return;
        	}

        	for( var i=5; i<16; i++){
        		if(i==11){continue;}  // 입력필드 아님
	   	    	// 연령필드의 중간에 공백필드가 존재하는지 체크
	   	    	if(document.form1.elements[i].value == ""){
			       	for( var j=i+1; j<16; j++){
		        		if(j==11){continue;} // 입력필드 아님
		    	   		if(document.form1.elements[j].value != ""){
		       				document.form1.elements[j-1].focus();
		       				alert("조회하고자 하는 연령을 올바르게 입력하십시오.\n(*공백필드가 존재합니다.)");
	        				return;
		       			}
		       		}
        		}
        	}

		   	// 연령필드의 중간값이 이후에 오는 값들보다 큰지 체크
        	for( var k=5; k<15; k++){
        		var a = k;
        		var b = k+1;
        		if(k==10){	b = k+2; } // 다음필드값과 비교
        		if(j==11){continue;} // 입력필드 아님
		       	if( parseInt(document.form1.elements[a].value) >= parseInt(document.form1.elements[b].value) ){
		       		document.form1.elements[b].focus();
		       		alert("조회하고자 하는 연령을 올바르게 입력하십시오.\n(*연령 구분이 올바르지 않습니다.)");
	       			return;
		       	}
        	}
        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "JOB";  // 직위별
        	}
        	if( document.form1.rdoGBN_SHR[1].checked ){
        		FLAG_SHR = "BCT";  // 출신도
        	}
        	if( document.form1.rdoGBN_SHR[2].checked ){
        		FLAG_SHR = "ADR";  // 거주지별
        	}

        	// 연령 조건에 맞게 그리드 타이틀 매핑
			setGridTitle();

        	var AGE_SHR  = document.form1.txtAGE_SHR_01.value
        	              	+"|"+ document.form1.txtAGE_SHR_02.value
        					+"|"+ document.form1.txtAGE_SHR_03.value
							+"|"+ document.form1.txtAGE_SHR_04.value
							+"|"+ document.form1.txtAGE_SHR_05.value
							+"|"+ document.form1.txtAGE_SHR_06.value
							+"|"+ document.form1.txtAGE_SHR_07.value
							+"|"+ document.form1.txtAGE_SHR_08.value
							+"|"+ document.form1.txtAGE_SHR_09.value
							+"|"+ document.form1.txtAGE_SHR_10.value;

			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;


			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.h.pirh010.cmd.PIRH010CMD&S_MODE=SHR&BIR_YMD_SHR="+BIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&AGE_SHR="+AGE_SHR;
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
        	if( document.form1.txtBIR_YMD_SHR.value=="" ){
        		alert("기준일자를 입력하십시오. 예)"+today);
        		return;
        	}

        	for( var i=5; i<16; i++){
        		if(i==11){continue;}  // 입력필드 아님
	   	    	// 연령필드의 중간에 공백필드가 존재하는지 체크
	   	    	if(document.form1.elements[i].value == ""){
			       	for( var j=i+1; j<16; j++){
		        		if(j==11){continue;} // 입력필드 아님
		    	   		if(document.form1.elements[j].value != ""){
		       				document.form1.elements[j-1].focus();
		       				alert("조회하고자 하는 연령을 올바르게 입력하십시오.\n(*공백필드가 존재합니다.)");
	        				return;
		       			}
		       		}
        		}
        	}

		   	// 연령필드의 중간값이 이후에 오는 값들보다 큰지 체크
        	for( var k=5; k<15; k++){
        		var a = k;
        		var b = k+1;
        		if(k==10){	b = k+2; } // 다음필드값과 비교
        		if(j==11){continue;} // 입력필드 아님
		       	if( parseInt(document.form1.elements[a].value) >= parseInt(document.form1.elements[b].value) ){
		       		document.form1.elements[b].focus();
		       		alert("조회하고자 하는 연령을 올바르게 입력하십시오.\n(*연령 구분이 올바르지 않습니다.)");
	       			return;
		       	}
        	}
        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "JOB";  // 직위별
        	}
        	if( document.form1.rdoGBN_SHR[1].checked ){
        		FLAG_SHR = "BCT";  // 출신도
        	}
        	if( document.form1.rdoGBN_SHR[2].checked ){
        		FLAG_SHR = "ADR";  // 거주지별
        	}

         	var AGE_SHR  = document.form1.txtAGE_SHR_01.value
        	              	+","+ document.form1.txtAGE_SHR_02.value
        					+","+ document.form1.txtAGE_SHR_03.value
							+","+ document.form1.txtAGE_SHR_04.value
							+","+ document.form1.txtAGE_SHR_05.value
							+","+ document.form1.txtAGE_SHR_06.value
							+","+ document.form1.txtAGE_SHR_07.value
							+","+ document.form1.txtAGE_SHR_08.value
							+","+ document.form1.txtAGE_SHR_09.value
							+","+ document.form1.txtAGE_SHR_10.value;

			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;

			var url = "pirh010_PV.jsp?BIR_YMD_SHR="+BIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&AGE_SHR="+AGE_SHR;
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

            form1.grdVI_T_CM_PERSON.GridToExcel("직급별,연령별인원현황", '', 225)
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
        	document.form1.txtBIR_YMD_SHR.value  = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	//document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.form1.rdoGBN_SHR[0].checked = true;
        	document.getElementById("resultMessage").innerText = ' ';
        	document.form1.txtBIR_YMD_SHR.value = today;

        	dsVI_T_CM_PERSON.ClearData();
        	setDefaultAge();
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
			document.form1.txtBIR_YMD_SHR.value = today;
			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style 적용

			setDefaultAge();
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
        function setDefaultAge(){
        	document.form1.txtAGE_SHR_01.value = "20";
        	document.form1.txtAGE_SHR_02.value = "21";
        	document.form1.txtAGE_SHR_03.value = "26";
        	document.form1.txtAGE_SHR_04.value = "31";
        	document.form1.txtAGE_SHR_05.value = "36";
        	document.form1.txtAGE_SHR_06.value = "41";
        	document.form1.txtAGE_SHR_07.value = "46";
        	document.form1.txtAGE_SHR_08.value = "51";
        	document.form1.txtAGE_SHR_09.value = "56";
        	document.form1.txtAGE_SHR_10.value = "61";

        	setGridTitle();
        }

		/********************************************
         * 조건에 따른 그리드 타이틀 매핑                   			*
         ********************************************/
        function setGridTitle(){
	        var arrVal = new Array("","","","","","","","","","");
	        for(var i=0; i<arrVal.length; i++){
	       		var a = i+6;
	       		//var a = i+5;
	        	//if(i>=6){a = a+1;} // 엘리먼트 중간에 '지역별' 들어있어서 순서를 하나씩 증가시킴
	        	arrVal[i] = document.form1.elements[a].value;
	        }

			// 칼럼 모두 숨김
        	for(var i=0; i<arrId.length ; i++){
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show") = "false";
        	}

			for(var i=0; i<arrVal.length; i++){
				if( arrVal[i] != "" ){
        	 		document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show") = "true";
        	 		if( i==0 ){ // 첫 칼럼
			        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"이하";
			        }else if( i == (arrVal.length-1) ){// 마지막 칼럼
			        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"이상";
        	 		}else{ // 그외
        	 			if( arrVal[i+1] != "" ){
				        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"~"+eval(arrVal[i+1]+"-"+1);
				        }else{
				        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"이상";
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
			//alert("검색하신 조건의 자료가 없습니다!");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연령별인원현황</td>
					<td align="right" class="navigator">HOME/인사관리/내역별인원현황/<font color="#000000">연령별인원현황</font></td>
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
					<col width="70"></col>
					<col width="110"></col>
					<col width="70"></col>
					<col width="185"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기준일자</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtBIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgBIR_YMD_SHR" name="imgBIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBIR_YMD_SHR','','134','108');"></a>
					</td>
					<td class="searchState" align="right">출력조건</td>
					<td class="padding2423" align="left">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;">직위별
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">출신도
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">거주지
					</td>
					<input type="hidden" id="cmbOCC_CD_SHR" value="0">
					<!--
					<td class="searchState" align="right">근로구분별</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
							<option value="0">모두</option>
						</select>
					</td>
					-->
                    <td class="searchState" align="right">지역별</td>
                    <td class="padding2423" align="left">
                        <select id="cmbGBN_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
                            <option value="0">모두</option>
                            <option value="1">본사</option>
                            <option value="2">지방</option>
                        </select>
                    </td>
				</tr>
				<tr>
					<td align="right" class="searchState">연령기준</td>
					<td class="padding2423" align="left" colspan="5">
						<input id="txtAGE_SHR_01" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()"  onFocusout="document.form1.txtAGE_SHR_02.value=eval(this.value+'+'+1)">
						이하&nbsp;
						<input id="txtAGE_SHR_02" size="4" maxLength="2" class="input_ReadOnly" readonly onKeypress="cfCheckNumber()">
						이상&nbsp;
						<input id="txtAGE_SHR_03" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_04" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_05" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_06" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_07" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_08" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_09" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_10" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						이상
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:315px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name=Numeric					value=true>
						<param name=SuppressOption 		value="1">
						<param name=MaxDecimalPlace     value=2>
						<param name="Format" value='
							<C> id="RN"			width=29	name="NO"			align=center	value="{decode(RN,0,"",RN)}"	suppress=2	BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="GBN_NM"		width=75	name="구분"			align=left		LeftMargin="10"	Edit=none	 	suppress=1	BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_TOT"	width=55	name="총원"			align=center	Edit=none	Value={Decode(AGE_TOT,0,"",AGE_TOT)}					BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_AVG"	width=60	name="평균연령"		align=center	Edit=none	 Value={Decode(AGE_AVG,0,"",AGE_AVG)}					BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}	</C>
							<C> id="AGE_01"		width=56	name="20이하"		align=center	Edit=none	 Value={Decode(AGE_01,0,"",AGE_01)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_02"		width=56	name="21-25"		align=center	Edit=none	 Value={Decode(AGE_02,0,"",AGE_02)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_03"		width=56	name="26-30"		align=center	Edit=none	 Value={Decode(AGE_03,0,"",AGE_03)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_04"		width=56	name="31-35"		align=center	Edit=none	 Value={Decode(AGE_04,0,"",AGE_04)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_05"		width=56	name="36-40"		align=center	Edit=none	 Value={Decode(AGE_05,0,"",AGE_05)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_06"		width=56	name="41-45"		align=center	Edit=none	 Value={Decode(AGE_06,0,"",AGE_06)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_07"		width=56	name="46-50"		align=center	Edit=none	 Value={Decode(AGE_07,0,"",AGE_07)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_08"		width=56	name="51-55"		align=center	Edit=none	 Value={Decode(AGE_08,0,"",AGE_08)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_09"		width=56	name="56-60"		align=center	Edit=none	 Value={Decode(AGE_09,0,"",AGE_09)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_10"		width=56	name="61이상"		align=center	Edit=none	 Value={Decode(AGE_10,0,"",AGE_10)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
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

