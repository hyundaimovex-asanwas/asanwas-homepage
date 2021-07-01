	<!--*************************************************************************
	* @source      : scha020.jsp												*
	* @description : 해외 주재원 학자금신청서 PAGE 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/19            채갑병          	        최초작성									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>해외 주재원 학자금신청서(scha020)</title>
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

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
		var file_flag = "0";    // 첨부파일 삭제용

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	var tmpST = document.form1.txtPIS_YY_SHR.value;
        	if( tmpST.length != 0 ){
        		if( tmpST.substr(4,1) != "/" || tmpST.length < 6 ){
	        		alert("검색하려는 지원년도/분기 를 바르게 입력하십시오. \n예)2007/1");
	        		return;
        		}
        		if( tmpST.substr(5,1) > 4 || tmpST.substr(5,1) < 1){
	        		alert("검색하려는 분기를 바르게 입력하십시오. \n예)1-4");
	        		return;
        		}
        	}

			//해외주재원 학자금신청서 조회
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR;
			dsT_SC_SCHLBOOK.reset();

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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_SC_SCHLBOOK.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK, I:FILE=oFileListGDS)";
			trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SAV";
			trT_SC_SCHLBOOK.post();
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_SC_SCHLBOOK.CountColumn == 0) {
				dsT_SC_SCHLBOOK.setDataHeader("IOC_GBN:STRING, PIS_YY:STRING, PIS_MM:STRING, ENO_NO:STRING, ENO_NM:STRING, OCC_CD:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, HIR_YMD:STRING, CHI_AMT:STRING, TEL_NO:STRING, BIR_YMD:STRING, SEL_NM:STRING, MF_TAG:STRING, OLD_AGE:STRING, FSCH_CD:STRING, SCH_CD:STRING, SCH_NM:STRING, MAJ_NM:STRING, RET_AMT:INT, EDU_AMT:INT, END_AMT:INT, SCO_AMT:INT, OTH_AMT:INT, TOT_AMT:INT, PAY_AMT:INT, IMG_YN:STRING, OFILE_NM:STRING, UFILE_NM:STRING");
			}

			enableInput();

			dsT_SC_SCHLBOOK.AddRow();

            //로그인한 사용자의 사용자정보 조회
            fnc_SearchInfo();

			// EMEdit default 값
			document.medRET_AMT.Text = "";
			document.medEDU_AMT.Text = "";
			document.medEND_AMT.Text = "";
			document.medTOT_AMT.Text = "";
			document.form1.cmbFSCH_CD.selectedIndex = 0;

			// 국내/외 구분 지정
			document.form1.hidIOC_GBN.value = "2"; // 국외
			spnSSN.innerText  = "주민번호";          // 신규일경우 "생년월일" -> "주민번호"

			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","width") = "120";
			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","name")  = "주민번호";
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
	        if (dsT_SC_SCHLBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "사원명     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "지원년월  = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YY")+"/ "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_MM")+"\n";
            	tmpMSG += "대상자     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM")+"\n";

	            if( confirm(tmpMSG) ){
					var IOC_GBN = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "IOC_GBN");
					var ENO_NO  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NO");
					var PIS_YY  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YY");
					var PIS_MM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_MM");
					var BIR_YMD = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "BIR_YMD");
					var SEL_NM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM");

					dsT_SC_SCHLBOOK.DeleteRow(dsT_SC_SCHLBOOK.RowPosition);
					// 파라미터 추가
					trT_SC_SCHLBOOK.Parameters = "IOC_GBN="+IOC_GBN+",ENO_NO="+ENO_NO+",PIS_YY="+PIS_YY+",PIS_MM="+PIS_MM+",BIR_YMD="+BIR_YMD+",SEL_NM="+SEL_NM;

					trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
					trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=DEL";
					trT_SC_SCHLBOOK.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
  			document.form1.txtPIS_YY_SHR.value = "";

  			disableInput();
	        document.getElementById("resultMessage").innerText = ' ';
	        spnSSN.innerText  = "생년월일";

			// 콤보박스 기본 선택
			document.form1.cmbFSCH_CD.selectedIndex = 0;

        	dsT_SC_SCHLBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_SC_SCHLBOOK.IsUpdated)  {
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
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			if( document.form1.txtBIR_YMD.value.length < 14){
				alert("잘못된 주민번호입니다.");
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	// 학년 구분 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_E9.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_E9.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_E9.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFSCH_CD").add(oOption);
			}

			// 파일 첨부용 데이터셋의 헤더 정보 설정.
	        oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

			cfStyleGrid(form1.grdT_SC_SCHLBOOK,15,"false","false");      // Grid Style 적용
			disableInput();
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
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	for(var i=10; i<24; i++){
	  		 	if(i==17){continue;}  // 이미지첨부 필드 수정 불가
  		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = true;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}

  			document.getElementById("cmbFSCH_CD").disabled  = false;   // 학년 콤보
 			document.form1.FileAdd.disabled  = false;                  // 첨부파일
  			document.form1.FileDel.disabled  = false;                  // 파일삭제
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	for(var i=0; i<24; i++){
 		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = false;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.getElementById("cmbFSCH_CD").disabled  = true;   // 학년 콤보
  			document.form1.FileAdd.disabled  = true;                  // 첨부파일
  			document.form1.FileDel.disabled  = true;                  // 파일삭제
  		}

		/********************************************
         * 사원 검색 후 필드값 매핑(extends common.js - 배열을 인자로)*
         ********************************************/
        function fnc_emplPopupArr1(arr){
        	var obj = new String();

        	obj.eno_nm = "";

			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(arr[0] != "" && obj.eno_no.trim() != ""){
	  			document.getElementById(arr[0]).value = obj.eno_no;
 			}
			if(arr[1] != "" && obj.eno_nm.trim() != ""){
 				document.getElementById(arr[1]).value = obj.eno_nm;
			}
			if(arr[2] != "" && obj.dpt_cd.trim() != ""){
 				document.getElementById(arr[2]).value = obj.dpt_cd;
			}
			if(arr[3] != ""  && obj.dpt_nm.trim() != ""){
 	 			document.getElementById(arr[3]).value = obj.dpt_nm;
 			}
			if(arr[4] != "" && obj.job_cd.trim() != ""){
 				document.getElementById(arr[4]).value = obj.job_cd;
			}
			if(arr[5] != "" && obj.job_nm.trim() != ""){
  				document.getElementById(arr[5]).value = obj.job_nm;
 			}
			if(arr[6] != ""){
				// [6]에 지정된 함수명으로 스크립트 함수 실행
				var fn = "document.Script."+arr[6];
				eval(fn);
			}
        }

 		/********************************************
         * 선택된 사원에 해당하는 사원정보 조회          		*
         ********************************************/
        function fnc_SearchInfo(){
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SHR_01";
			dsVI_T_PERSON.reset();
        }

  		/********************************************
         * 주민등록번호 입력시 자동 하이픈(-) 넣기 			*
         ********************************************/
		function cfCheckNumber5(){
			if((event.keyCode < 48)||(event.keyCode > 57)){
				if(event.keyCode != 45){
					event.returnValue=false;
				}
			}
			if( document.form1.txtBIR_YMD.value.length == 6 ){
				document.form1.txtBIR_YMD.value += "-";
			}
		}

  		/********************************************
         * 검색조건 입력시 자동 슬러시(/) 넣기 				*
         ********************************************/
		function cfCheckNumber6(){
			if((event.keyCode < 48)||(event.keyCode > 57)){
				if(event.keyCode != 47){
					event.returnValue=false;
				}
			}
			if( document.form1.txtPIS_YY_SHR.value.length == 4 ){
				document.form1.txtPIS_YY_SHR.value += "/";
			}
		}

  		/********************************************
         * 주민등록번호 필드에서 포커스 떠날때 유효한지 검사      *
         ********************************************/
		function checkSSN(){
			// 하이픈 제거
			var ssn = removeChar( document.form1.txtBIR_YMD.value, "-" ) ;
			if( document.form1.txtBIR_YMD.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){
				alert("잘못된 주민번호입니다.");
				document.form1.txtBIR_YMD.value = "";
				document.form1.txtBIR_YMD.focus();
			}
		}

		/********************************************
         * 지원년도 필드에서 포커스 떠날때 처리                          *
         ********************************************/
		function checkPISYY(){
			var pisYY = document.form1.txtPIS_YY.value;
			if( pisYY != "" && pisYY.length < 3){
				alert("지원년도를 올바르게 입력하십시오. \n예)2007");
				document.form1.txtPIS_YY.focus();
				return false;
			}
		}

		/********************************************
         * 월 필드에서 포커스 떠날때 처리                                    *
         ********************************************/
		function checkPISMM(){
			var pisMM = document.form1.txtPIS_MM.value;
			if( pisMM != "" && ( pisMM < 1 || pisMM > 12) ){
				alert("지원월을 올바르게 입력하십시오. \n예)1");
				document.form1.txtPIS_MM.focus();
				return false;
			}
		}

		/********************************************
         * 그리드 클릭시 해당 행의 지급여부에 따라 활성화 처리   *
         ********************************************/
        function checkPayStatus(row, colid){

            // 지급 됨
        	if( dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "T" ){
        		for(var i=12; i<15; i++){
		  			document.form1.elements[i].readOnly  = true;                // 학교명, 학과, 학년콤보
		  			document.form1.elements[i].className = "input_ReadOnly";
        		}
        		for(var i=20; i<24; i++){
		  			document.form1.elements[i].Enable = false;                 // 입학금, 수업료, 기성회비
        		}
	  			document.getElementById("cmbFSCH_CD").disabled  = true;        // 학년 콤보
  				document.form1.FileAdd.disabled  = true;                       // 첨부파일
	  			document.form1.FileDel.disabled  = true;                       // 파일삭제

	  		// 지급 안됨
        	}else{
        		for(var i=12; i<15; i++){
		  			document.form1.elements[i].readOnly  = false;               // 학교명, 학과, 학년콤보
		  			document.form1.elements[i].className = "";
        		}
        		for(var i=20; i<24; i++){
		  			document.form1.elements[i].Enable = true;                  // 입학금, 수업료, 기성회비
        		}
	  			document.getElementById("cmbFSCH_CD").disabled  = false;       // 학년 콤보
  				document.form1.FileAdd.disabled  = false;                      // 첨부파일
		  		document.form1.FileDel.disabled  = false;                      // 파일삭제
        	}
		}

		/********************************************
         * 첨부파일 처리								*
         ********************************************/
		function fnc_FileUpload() {
			if( document.form1.txtENO_NO.value == "" ){
				alert("사번을 먼저 입력 하십시오.");
				return;
			}

            oFileListGDS.addrow();
	        oFileListGDS.NameValue(oFileListGDS.RowPosition, "ENO_NO") = form1.txtENO_NO.value;

	        oFileGF.OpenFileName = form1.txtFILE_NAME.value;

	        oFileGF.open();

	        if(oFileGF.SelectState == true){
				form1.txtFILE_NAME.value = oFileGF.value;
			} else {
				oFileListGDS.deleterow(oFileListGDS.RowPosition);
			}
		}

		/********************************************
         * 첨부파일 삭제								*
         ********************************************/
		function fnc_FileDelete() {
			// 등록되어있는 첨부파일을 삭제한다.
			if ( form1.hidFILE_URL.value != "" && form1.txtFILE_NAME.value != "" ) {
				if( confirm("첨부된 파일을 삭제하시겠습니까?") ){

					// 삭제실행(FLAG첨부 실행)
					file_flag = "1";
					var FILE_URL = form1.hidFILE_URL.value;

					trT_SC_SCHLBOOK.Parameters = "FILE_URL="+FILE_URL+",FLAG="+file_flag;

					trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK, I:FILE=oFileListGDS)";
					trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=DEL";
					trT_SC_SCHLBOOK.post();

					// 초기화
					file_flag = "0";
					form1.txtFILE_NAME.value = "";
					form1.hidFILE_URL.value  = "";
				}
			}
			else {
				alert("삭제할 파일이 존재하지 않습니다.");
			}
		}

		/********************************************
         * 합계구해서 넣기	 							*
         ********************************************/
		function fnc_sum(){
			var ret_amt = form1.medRET_AMT.Text;
			var edu_amt = form1.medEDU_AMT.Text;
			var end_amt = form1.medEND_AMT.Text;

			if( ret_amt == "" ){ ret_amt = 0; }
			if( edu_amt == "" ){ edu_amt = 0; }
			if( end_amt == "" ){ end_amt = 0; }
			var sum = eval( ret_amt+"+"+edu_amt+"+"+end_amt )+"";

			form1.medTOT_AMT.Text = sum;

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_SC_SCHLBOOK)			   |
    | 3. 사용되는 Table List(T_SC_SCHLBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet								       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_SC_SCHLBOOK)		       |
    | 3. 사용되는 Table List(T_SC_SCHLBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 학년 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E9"/>
       <jsp:param name="CODE_GUBUN"    value="E9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
	<object id="oFileListGDS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<param name="Syncload" value="true">
	</object>

 	<!-- 가우스 파일 오브젝트 -->
	<object id=oFileGF classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
		<param name="Text"		value='첨부파일'>
		<param name="Enable"	value="true">
	</object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.CountRow);

			disableInput();
			for(var i=12; i<24; i++){  // 학교명 ~ 계
				//  성명,    주민번호, 첨부파일명 수정 불가
				if( i==15 || i==16 || i==17 ){ continue; }
                //  입학금,   수업료,  기성회비,    계 수정 가능
  		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = true;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.getElementById("cmbFSCH_CD").disabled  = false;   // 학년 콤보
  			spnSSN.innerText  = "생년월일";                              // 조회일경우 "주민번호" -> "생년월일"

			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","width") = "70";
			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","name")  = "생년월일";

			// 첫행의 지급여부에 따라 필드 활성화
			checkPayStatus(0, "PAY_YN");
        }
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("해당사원의 정보가 없습니다.");
		} else {
			// 사원 정보 매핑
            document.form1.txtENO_NO.value   = dsVI_T_PERSON.NameValue(0,"ENO_NO");
            document.form1.txtENO_NM.value   = dsVI_T_PERSON.NameValue(0,"ENO_NM");
            document.form1.txtDPT_NM.value   = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            document.form1.txtJOB_NM.value   = dsVI_T_PERSON.NameValue(0,"JOB_NM");
			document.form1.txtHIR_YMD.value   = dsVI_T_PERSON.NameValue(0,"HIR_YMD");
			document.form1.txtEM_PHN_NO.value = dsVI_T_PERSON.NameValue(0,"EM_PHN_NO");
			document.form1.hidOCC_CD.value    = dsVI_T_PERSON.NameValue(0,"OCC_CD");
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnSuccess()">
		//첨부파일 삭제시
		if( file_flag == "1" ){
			fnc_Message(document.getElementById("resultMessage"), '* 첨부파일이 삭제되었습니다.');
	    	file_flag == "0";
		}else{
			fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
			fnc_SearchList();
		}
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_SC_SCHLBOOK event=OnClick(row,colid)>
		checkPayStatus(row, colid);
	</script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_SC_SCHLBOOK event=CanRowPosChange(row)>
		if( dsT_SC_SCHLBOOK.RowStatus(row) == 1 && document.form1.txtBIR_YMD.value.length < 14){
			alert("잘못된 주민번호입니다.");
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"PIS_YY") == "" ) {
			alert("[ 지원년도 ]는 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"PIS_MM") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','PIS_MM') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"SEL_NM") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','SEL_NM') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"BIR_YMD") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','BIR_YMD') + " ]는 필수 입력사항입니다");
			return false;
		}
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외 주재원 학자금 신청서</td>
					<td align="right" class="navigator">HOME/복리후생/학자금지원/<font color="#000000">해외 주재원 학자금 신청서</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="70"></col>
			<col width="25"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">사번</td>
			<td class="padding2423"><input id="txtENO_NO" name="txtENO_NO" size="15" maxlength="8" style="ime-mode:disabled" onKeypress="cfNumberCheck()">
			</td>
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtENO_NM" size="12"></td>
			<td align="center" class="creamBold">소속</td>
			<td class="padding2423">
				<input id="txtDPT_NM" size="15">
				<input type="hidden" id="hidDPT_CD" size="10">
				<input type="hidden" id="hidIOC_GBN" size="10">
			</td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423" colspan="3">
				<input id="txtJOB_NM" size="7">
				<input type="hidden" id="hidOCC_CD" size="10">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">입사일</td>
			<td class="padding2423"><input id="txtHIR_YMD" size="15" maxLength="3"></td>
			<td align="center" class="creamBold">자녀수</td>
			<td class="padding2423"><input id="txtCHI_AMT" size="12" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber2()"></td>
			<td align="center" class="creamBold">전화번호</td>
			<td class="padding2423"><input id="txtEM_PHN_NO" size="15" maxLength="13" style="ime-mode:disabled" onKeypress="cfCheckNumber()"></td>
			<td align="center" class="creamBold">지원년도</td>
			<td class="padding2423"><input id="txtPIS_YY" size="7" maxLength="4" style="ime-mode:disabled" onFocusOut="checkPISYY()" onKeypress="cfCheckNumber2()"></td>
			<td align="center" class="creamBold">월</td>
			<td class="padding2423"><input id="txtPIS_MM" size="5" maxLength="2" style="ime-mode:disabled" onFocusOut="checkPISMM()" onKeypress="cfCheckNumber2()"></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 수혜자녀에 대한 정보입력</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">학교명</td>
			<td class="padding2423"><input id="txtSCH_NM" size="12" maxLength="10"></td>
			<td align="center" class="creamBold">학과</td>
			<td class="padding2423"><input id="txtMAJ_NM" size="14" maxLength="10"></td>
			<td align="center" class="creamBold">학년</td>
			<td class="padding2423" colspan="3">
				<select id="cmbFSCH_CD" style="width:20%"></select>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">성명</td>
			<td class="padding2423"><input id="txtSEL_NM" size="12" maxLength="12"></td>
			<td align="center" class="creamBold"><span id="spnSSN">주민번호</span></td>
			<td class="padding2423"><input id="txtBIR_YMD" size="14" maxLength="14" style="ime-mode:disabled" onblur="checkSSN();" onKeypress="cfCheckNumber5();"></td>
			<td align="center" class="creamBold">이미지첨부</td>
			<td class="padding2423" colspan="3">
				<input id=txtFILE_NAME name=txtFILE_NAME size="18" valid='maxlength=255' readonly>&nbsp;
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
				<input type=hidden id=hidFILE_URL name=hidFILE_URL length="255" size="60">
				<input type=hidden id=hidFILE_URL2 name=hidFILE_URL2 size="60" length="255">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">입학금</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">수업료</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">학교운영지원비</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">계</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=9>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="90"></col>
							<col width="600"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">지원년도/분기</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="10" maxlength="6" onkeypress="if(event.keyCode == 13)fnc_SearchList(); cfCheckNumber6();">
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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width="30"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="IOC_GBN"	width="100"		name="국내외구분"			align="center"	Edit=none	Show="false"</C>
							<C> id="PIS_YY"		width="50"		name="지원;년도"			align="center"	Edit=none</C>
							<C> id="PIS_MM"		width="25"		name="월"				align="center"	Edit=none</C>
							<C> id="ENO_NO"		width="60"		name="사번"				align="center"	Edit=none</C>
							<C> id="ENO_NM"		width="50"		name="성명"				align="center"	Edit=none</C>
							<C> id="DPT_CD"		width="80"		name="부서코드"			align="left"	Edit=none	Show="false"</C>
							<C> id="DPT_NM"		width="100"		name="소속"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="OCC_CD"		width="70"		name="근로구분구분"			align="center"	Edit=none	Show="false"</C>
							<C> id="JOB_NM"		width="40"		name="직위"				align="center"	Edit=none</C>
							<C> id="HIR_YMD"	width="70"		name="입사일"				align="center"	Edit=none</C>
							<C> id="CHI_AMT"	width="30"		name="자녀;수"			align="center"	Edit=none</C>
							<C> id="EM_PHN_NO"	width="100"		name="전화번호"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="BIR_YMD"	width="90"		name="생년월일"			align="center"	Edit=none</C>
							<C> id="SEL_NM"		width="50"		name="성명"				align="center"	Edit=none</C>
							<C> id="MF_TAG"		width="30"		name="성별"				align="center"	Edit=none	EditStyle=Combo		Data="F:여자,M:남자"</C>
							<C> id="OLD_AGE"	width="30"		name="나이"				align="center"	Edit=none</C>
							<C> id="FSCH_CD"	width="40"		name="학력구분"			align="center"	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_E9:CODE:CODE_NAME"	Show="false"</C>
							<C> id="SCH_CD"		width="40"		name="학교구분"			align="center"	Edit=none	Show="false"</C>
							<C> id="SCH_NM"		width="100"		name="학교명"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="MAJ_NM"		width="100"		name="학과명"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="RET_AMT"	width="90"		name="입학금"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="EDU_AMT"	width="90"		name="수업료"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="END_AMT"	width="90"		name="학교운영지원비"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SCO_AMT"	width="90"		name="장학금"				align="right"	Edit=none	RightMargin="10"	Show="false"</C>
							<C> id="OTH_AMT"	width="90"		name="기타"				align="right"	Edit=none	RightMargin="10"	Show="false"</C>
							<C> id="TOT_AMT"	width="90"		name="합계"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="PAY_AMT"	width="90"		name="지급금액"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="IMG_YN"		width="50"		name="이미지;유무"		align="center"	Edit=none	EditStyle=CheckBox</C>
							<C> id="PAY_YN"		width="50"		name="지급;여부"			align="center"	Edit=none	EditStyle=CheckBox</C>
							<C> id="OFILE_NM"	width="100"		name="원래이미지파일명"	align="center"	Edit=none	Show="false"</C>
							<C> id="UFILE_NM"	width="100"		name="등록된이미지파일명"	align="right"	Edit=none	Show="false"</C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_SC_SCHLBOOK 설정 테이블 -->
	<object id="bndT_SC_SCHLBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_SC_SCHLBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=IOC_GBN		Ctrl=hidIOC_GBN		Param=value</C>
			<C>Col=PIS_YY		Ctrl=txtPIS_YY		Param=value</C>
			<C>Col=PIS_MM		Ctrl=txtPIS_MM		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=CHI_AMT		Ctrl=hidCHI_AMT		Param=value</C>
			<C>Col=EM_PHN_NO	Ctrl=txtEM_PHN_NO	Param=value</C>
			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=SEL_NM		Ctrl=txtSEL_NM		Param=value</C>
			<C>Col=OLD_AGE		Ctrl=txtOLD_AGE		Param=value</C>
			<C>Col=FSCH_CD		Ctrl=cmbFSCH_CD		Param=value</C>
			<C>Col=SCH_NM		Ctrl=txtSCH_NM		Param=value</C>
			<C>Col=MAJ_NM		Ctrl=txtMAJ_NM		Param=value</C>
			<C>Col=RET_AMT		Ctrl=medRET_AMT		Param=Text</C>
			<C>Col=EDU_AMT		Ctrl=medEDU_AMT		Param=text</C>
			<C>Col=END_AMT		Ctrl=medEND_AMT		Param=text</C>
			<C>Col=SCO_AMT		Ctrl=medSCO_AMT		Param=text</C>
			<C>Col=OTH_AMT		Ctrl=medOTH_AMT		Param=text</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=text</C>
			<C>Col=OFILE_NM		Ctrl=txtFILE_NAME	Param=value</C>
			<C>Col=UFILE_NM		Ctrl=hidFILE_URL	Param=value</C>
		">
	</object>


    <!-- 첨부파일용 바인딩 오브젝트 -->
    <object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	    <Param Name="DataID",   Value="oFileListGDS">
	    <Param Name="BindInfo", Value='
		    <C>Col=FILE_NAME		Ctrl=oFileGF            Param=Value</C>
		    <C>Col=FILE_URL			Ctrl=oFileGF            Param=Value</C>'>
    </object>