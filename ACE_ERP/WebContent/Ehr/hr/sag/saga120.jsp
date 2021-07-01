<!--
    ***********************************************************************************
    * @source         : saga120.jsp 				                                  *                                                  *
    * @description   : 자료UP/DOWN PAGE.                                              *
    ***********************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                           *
    *-------------+-----------+-------------------------------------------------------+
    * 2007/03/26  |  한학현   | 최초작성                                              *
    ***********************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>자료UP/DOWN</title>
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
		var btnList = 'TFTTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호

			if(document.form1.radCHULJA_TYPE[0].checked == true){
				RADIO_OPTION = 0;
			}
			else if(document.form1.radCHULJA_TYPE[1].checked == true){
				RADIO_OPTION = 1;
			}
			else{
				RADIO_OPTION = 2;
			}

			fnc_SetGridFormat(RADIO_OPTION);


			if(document.getElementById("searchMessage_01").innerText == "해당년월"){
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
			}else{
				//해당년도가 없으면 조회못함.
				if(PIS_YY_SHR.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("해당년도를 입력하세요.");
						document.getElementById("txtPIS_YY_SHR").focus();
						return false;
					}
				}

				//해당년도가 잘못되었으면 조회못함.
				if(PIS_YY_SHR.trim().length != 4){
					if(event.type == "change"){
						return false;
					}else{
						alert("해당년도가 잘못되었습니다.");
						document.getElementById("txtPIS_YY_SHR").focus();
						return false;
					}
				}
			}

            //데이터셋 전송
			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
	            dsT_CP_PAYMASTER_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_01&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CP_PAYMASTER_01.Reset();

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금

				if(RADIO_OPTION == 0)
				{
					dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
	            else if(RADIO_OPTION == 1)
	            {
	            	dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02_1&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
	            else if(RADIO_OPTION == 2)
	            {
	            	dsT_AC_LOAN_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_02_2&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            	dsT_AC_LOAN_02.Reset();
	            }
			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				trT_AC_RETACC_04.KeyValue = "SVL(O:dsT_AC_RETACC_04=dsT_AC_RETACC_04)";
				trT_AC_RETACC_04.Action = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_04&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				trT_AC_RETACC_04.Post();

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
	            dsT_AC_RETTABLE_05.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_05&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_RETTABLE_05.Reset();

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득_2
	            dsT_AC_RETTABLE_09.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_09&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_RETTABLE_09.Reset();

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
				//없음

			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
	            dsT_AC_MEDICAL_07.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_07&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_MEDICAL_07.Reset();

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
	            dsT_AC_DONATION_08.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_08&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_AC_DONATION_08.Reset();

			}else if(document.tabSAGA120.ActiveIndex==10){//일용직
	            dsT_CA_PAYMASTER_10.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_10&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            dsT_CA_PAYMASTER_10.Reset();
	            
            }

        }

        function fnc_SetGridFormat(radioOption){

        	if(radioOption == 0){
	        	form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "true";
	        	form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD",   "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "false";
			}
        	else if(radioOption == 1){
        		form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "true";
        	}
        	else{
        		form1.grdT_AC_LOAN_02.ColumnProp("DPT_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("JOB_NM", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NO", "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("ENO_NM", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("CET_NO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("GMK_AMT","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("EMAENO", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("OCC_CD", "Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("TAG",    "Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("PAY_YMD","Show") = "false";
				form1.grdT_AC_LOAN_02.ColumnProp("HIR_YMD","Show") = "true";
				form1.grdT_AC_LOAN_02.ColumnProp("EM_PHN_NO", "Show") = "false";
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호

			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금
				//tr을 태우기 위해여 강제적으로 변경
				for(var i=1; i<= dsT_AC_LOAN_03.CountRow; i++){
					dsT_AC_LOAN_03.UserStatus(i)="1";
				}

	            trT_AC_LOAN_03.KeyValue = "SVL(I:dsT_AC_LOAN_03=dsT_AC_LOAN_03)";
	            trT_AC_LOAN_03.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SAV_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trT_AC_LOAN_03.post();

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				//없음

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
				//없음

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득_2
				//없음

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
				//tr을 태우기 위해여 강제적으로 변경
				for(var i=1; i<= dsT_AC_LOAN_06.CountRow; i++){
					dsT_AC_LOAN_06.UserStatus(i)="1";
				}

	            trT_AC_LOAN_06.KeyValue = "SVL(I:dsT_AC_LOAN_06=dsT_AC_LOAN_06, O:dsRESULT=dsRESULT)";
	            trT_AC_LOAN_06.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SAV_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trT_AC_LOAN_06.post();


			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
				//없음

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
				//없음

			}else if(document.tabSAGA120.ActiveIndex==10){//일용직
				//없음				
				
            }

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

			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
				if (dsT_CP_PAYMASTER_01.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CP_PAYMASTER_02.GridToExcel("급상여입금", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금
				if (dsT_AC_LOAN_02.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}

				if(RADIO_OPTION == 1){
	            	form1.grdT_AC_LOAN_02.GridToExcel("출자금", '', 225)
	            }
	            else if(RADIO_OPTION == 1){
	            	form1.grdT_AC_LOAN_02.GridToExcel("신규생성자", '', 225)
	            }
	            if(RADIO_OPTION == 2){
   	            	form1.grdT_AC_LOAN_02.GridToExcel("근로구분변경", '', 225)
	            }

			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금
				if (dsT_AC_LOAN_03.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_LOAN_03.GridToExcel("대출상환금", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				if (dsT_AC_RETACC_04.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_RETACC_04.GridToExcel("연말정산", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
				if (dsT_AC_RETTABLE_05.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_RETTABLE_05.GridToExcel("퇴직소득_1", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득_2
				if (dsT_AC_RETTABLE_09.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_RETTABLE_09.GridToExcel("퇴직소득_2", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
				if (dsT_AC_LOAN_06.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_LOAN_06.GridToExcel("제일은행", '', 225)


			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
				if (dsT_AC_MEDICAL_07.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_MEDICAL_07.GridToExcel("의료비신고", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
				if (dsT_AC_DONATION_08.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_AC_DONATION_08.GridToExcel("기부금신고", '', 225)

			}else if(document.tabSAGA120.ActiveIndex==10){//일용직
				if (dsT_CA_PAYMASTER_10.CountRow < 1) {
            	    alert("엑셀로 변환할 자료가 없습니다!");
                	return;
				}
            	form1.grdT_CA_PAYMASTER_10.GridToExcel("일용직신고", '', 225)
            	
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

			//화면겹침버그 임시 해결
			document.tabSAGA120.ActiveIndex=2;
			document.tabSAGA120.ActiveIndex=1;

			dsT_CP_PAYMASTER_01.ClearData();
			dsT_AC_LOAN_02.ClearData();
			dsT_AC_LOAN_03.ClearData();
			dsT_AC_RETACC_04.ClearData();
			dsT_AC_RETTABLE_05.ClearData();
			dsT_AC_LOAN_06.ClearData();
			dsT_AC_MEDICAL_07.ClearData();
			dsT_AC_DONATION_08.ClearData();
			dsT_AC_RETTABLE_09.ClearData();
			dsT_CA_PAYMASTER_10.ClearData();			
			
			
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("cmbSAL_GBN_SHR").value = "0";
			document.getElementById("cmbSEQ_SHR").value = "1";
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_PAYMASTER_01.IsUpdated || dsT_AC_LOAN_02.IsUpdated || dsT_AC_LOAN_03.IsUpdated || dsT_AC_RETACC_04.IsUpdated ||
				dsT_AC_RETTABLE_05.IsUpdated || dsT_AC_LOAN_06.IsUpdated || dsT_AC_MEDICAL_07.IsUpdated || dsT_AC_DONATION_08.IsUpdated ||
				dsT_AC_RETTABLE_09.IsUpdated || dsT_CA_PAYMASTER_10.IsUpdated)  {

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

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7); // 해당년월
			document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4); // 해당년도
			document.getElementById("txtPIS_YMD").value = getToday(); // 해당일자

			//화면겹침버그 임시 해결
			document.tabSAGA120.ActiveIndex=2;
			document.tabSAGA120.ActiveIndex=1;

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_CP_PAYMASTER_01,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_02,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_03,0,"false","false");
			cfStyleGrid(form1.grdT_AC_RETACC_04,0,"false","true");
			cfStyleGrid(form1.grdT_AC_RETTABLE_05,0,"false","false");
			cfStyleGrid(form1.grdT_AC_LOAN_06,0,"false","false");
			cfStyleGrid(form1.grdT_AC_MEDICAL_07,0,"false","true");
			cfStyleGrid(form1.grdT_AC_DONATION_08,0,"false","true");
			cfStyleGrid(form1.grdT_AC_RETTABLE_09,0,"false","false");
			cfStyleGrid(form1.grdT_CA_PAYMASTER_10,0,"false","true");
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/**
         * 첨부파일 처리
         */
        function fnc_FileUpload() {

        	var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn == 0) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금

	            trFILE_UPLOAD_03.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_AC_LOAN_03=dsT_AC_LOAN_03)";
	            trFILE_UPLOAD_03.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_03&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trFILE_UPLOAD_03.post();

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				//없음

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
				//없음

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득_2
				//없음

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
	            trFILE_UPLOAD_06.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_AC_LOAN_06=dsT_AC_LOAN_06)";
	            trFILE_UPLOAD_06.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD&S_MODE=SHR_06&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            trFILE_UPLOAD_06.post();

			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
				//없음

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
				//없음

            }
        }

        /**
         * 파일로 저장
         */
        function fnc_ToFile() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // 해당년도
			var PIS_YMD = document.getElementById("txtPIS_YMD").value; // 해당년도
			var SAL_GBN_SHR = document.getElementById("cmbSAL_GBN_SHR").value; // 급상여구분
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호
			var FILE_NAME = "";//파일명

			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
	            if (dsT_CP_PAYMASTER_01.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_CP_PAYMASTER_01.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

				if(SAL_GBN_SHR == "0"){//급여
		            FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"paya.dat";
	            }else if(SAL_GBN_SHR == "1"){//상여
		            FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"bona.dat";
	            }else if(SAL_GBN_SHR == "4"){//연차
	    	        FILE_NAME = document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"cpsa.dat";
    	        }else{
    	        	alert("오류");return false;
    	        }

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_01&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금


	            if (dsT_AC_LOAN_02.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_LOAN_02.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }


	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";

	            if(form.radCHULJA_TYPE[0].checked == true){
		            FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+".txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}
				else if(form.radCHULJA_TYPE[1].checked == true){
					FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"_신규생성자.txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02_1&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}
				else{
					FILE_NAME = "g"+document.getElementById("txtPIS_YYMM_SHR").value.replaceStr("-","")+"_근로구분변경.txt";
					form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_02_2&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
				}


	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금
				//없음

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				/*
	            if (dsT_AC_RETACC_04.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_RETACC_04.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }
				*/
    	        FILE_NAME = "C2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_04&FILE_NAME="+FILE_NAME+"&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
	            if (dsT_AC_RETTABLE_05.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_RETTABLE_05.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

    	        FILE_NAME = "E2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_05&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득
	            if (dsT_AC_RETTABLE_09.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_RETTABLE_09.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

    	        FILE_NAME = "EA028123.012";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_09&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
				//없음

			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
	            if (dsT_AC_MEDICAL_07.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_MEDICAL_07.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

	            //제출일자가 없으면 조회못함.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자를 입력하세요.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//제출일자가 잘못되었으면 조회못함.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자가 잘못되었습니다.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "CA2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_07&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
	            if (dsT_AC_DONATION_08.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_AC_DONATION_08.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

	            //제출일자가 없으면 조회못함.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자를 입력하세요.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//제출일자가 잘못되었으면 조회못함.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자가 잘못되었습니다.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "H2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_08&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD+"&SAL_GBN_SHR="+SAL_GBN_SHR+"&SEQ_SHR="+SEQ_SHR;
	            form.submit();

			}else if(document.tabSAGA120.ActiveIndex==10){//일용직
	            if (dsT_CA_PAYMASTER_10.CountColumn == 0) {
	                alert("리스트를 조회하지 않았습니다.");
	                return;
	            }

	            if (dsT_CA_PAYMASTER_10.CountRow < 1) {
	                alert("저장할 데이타가 없습니다.");
	                return;
	            }

	            //제출일자가 없으면 조회못함.
				if(PIS_YMD.trim().length == 0){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자를 입력하세요.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

				//제출일자가 잘못되었으면 조회못함.
				if(PIS_YMD.trim().length != 10){
					if(event.type == "change"){
						return false;
					}else{
						alert("제출일자가 잘못되었습니다.");
						document.getElementById("txtPIS_YMD").focus();
						return false;
					}
				}

    	        FILE_NAME = "I2218113.834";

	            var form = document.form1;
	            form.method = "post";
	            form.target = "file_down";
	            form.action = "/servlet/JspChannelSVL?cmd=hr.sag.a.saga120.cmd.SAGA120CMD_FILE&S_MODE=FILE_10&FILE_NAME="+FILE_NAME+"&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_YMD="+PIS_YMD;
	            form.submit();
	            
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
    | 2. 이름 : dsT_AC_LOAN_02                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_LOAN_03                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_RETACC_04                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETACC_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_RETTABLE_05                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETTABLE_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_LOAN_06                             |
    | 3. Table List : T_AC_LOAN                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_LOAN_06" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_MEDICAL_07                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_MEDICAL_07" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=SubsumExpr          value="total">        
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_DONATION_08                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_DONATION_08" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_AC_RETTABLE_09                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_AC_RETTABLE_09" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CA_PAYMASTER_10                             |
    | 3. Table List : T_CP_PAYMASTER                         |
    +----------------------------------------------->
    <Object ID="dsT_CA_PAYMASTER_10" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton                             |
    | 2. 이름 : trFILE_UPLOAD_03                                       |
    | 3. Table List :                                                            |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD_03" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton                             |
    | 2. 이름 : trFILE_UPLOAD_06                                       |
    | 3. Table List :                                                            |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD_06" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_LOAN_03                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN_03" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_RETACC_04                                           |
    | 3. Table List :                                                             |
    +----------------------------------------------->
    <Object ID ="trT_AC_RETACC_04" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_AC_LOAN_06                                           |
    | 3. Table List : T_AC_LOAN                                         |
    +----------------------------------------------->
    <Object ID ="trT_AC_LOAN_06" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

	<!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

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

    <Script For=dsT_AC_LOAN_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETTABLE_05 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_MEDICAL_07 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_DONATION_08 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
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

    <Script For=dsT_AC_LOAN_02 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_RETTABLE_05 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_MEDICAL_07 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_DONATION_08 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnLoadError()">
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

    <Script For=dsT_AC_LOAN_02 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_LOAN_03 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETACC_04 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_RETTABLE_05 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_LOAN_06 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_MEDICAL_07 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

	<Script For=dsT_AC_DONATION_08 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_AC_RETTABLE_09 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

    <Script For=dsT_CA_PAYMASTER_10 Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>
    
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_AC_LOAN_03 event="OnSuccess()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </script>

    <script for=trFILE_UPLOAD_03 event="OnSuccess()">

   		var iCount1 = dsT_AC_LOAN_03.CountRow;

		if (iCount1 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
        }

    </script>

    <script for=trT_AC_RETACC_04 event="OnSuccess()">

   		var iCount = dsT_AC_RETACC_04.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </script>

    <script for=trT_AC_LOAN_06 event="OnSuccess()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </script>

    <script for=trFILE_UPLOAD_06 event="OnSuccess()">

   		var iCount1 = dsT_AC_LOAN_06.CountRow;

		if (iCount1 == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount1);
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trFILE_UPLOAD_03 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_LOAN_03 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_RETACC_04 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trFILE_UPLOAD_06 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_AC_LOAN_06 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!----------------------+
    | 탭 변경시 생기는 이벤트  |
    +----------------------->
    <script language=JavaScript for=tabSAGA120 event=OnSelChanged(index)>
			if(document.tabSAGA120.ActiveIndex==1){//급상여입금
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==2){//출자금
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==3){//대출상환금
				document.getElementById("changeButton_01").style.display = "none";
				document.getElementById("changeButton_02").style.display = "";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==4){//연말정산
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==5){//퇴직소득_1
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년도";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==6){//퇴직소득_2
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년도";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==7){//제일은행
				document.getElementById("changeButton_01").style.display = "none";
				document.getElementById("changeButton_02").style.display = "";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "none";
				document.getElementById("divSAGA120_file_01").style.display = "";
				document.getElementById("divSAGA120_file_02").style.display = "none";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = false;
	  			document.getElementById("cmbSEQ_SHR").disabled = false;

			}else if(document.tabSAGA120.ActiveIndex==8){//의료비신고
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년도";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==9){//기부금신고
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년도";
				document.getElementById("changeDate_01").style.display = "none";
				document.getElementById("changeDate_02").style.display = "";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
				//document.getElementById("cmbSAL_GBN_SHR").value = "0";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;

			}else if(document.tabSAGA120.ActiveIndex==10){//일용직
				document.getElementById("changeButton_01").style.display = "";
				document.getElementById("changeButton_02").style.display = "none";
				document.getElementById("searchMessage_01").innerText = "해당년월";
				document.getElementById("changeDate_01").style.display = "";
				document.getElementById("changeDate_02").style.display = "none";
				document.getElementById("divSAGA120_file").style.display = "";
				document.getElementById("divSAGA120_file_01").style.display = "none";
				document.getElementById("divSAGA120_file_02").style.display = "";
	  			document.getElementById("cmbSAL_GBN_SHR").disabled = true;
	  			document.getElementById("cmbSEQ_SHR").disabled = true;
			
	  			
            }
	</script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 파일 전송을 위해 -->
<iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">자료UP/DOWN</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">자료UP/DOWN</font></td>
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
			<div id="changeButton_01" style="position:absolute; left:562; top:49; width:60; height:20; z-index:1;" >
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
           	</div>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
			<div id="changeButton_02" style="position:absolute; left:562; top:49; width:60; height:20; z-index:1;" >
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
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
								<col width="10"></col>
								<col width="80"></col>
								<col width="190"></col>
								<col width="80"></col>
								<col width="180"></col>
								<col width="80"></col>
								<col width="100"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState"><span id="searchMessage_01"></span></td>
								<td>
									<div id="changeDate_01" style="position:absolute; left:121; top:93; width:120; height:20; z-index:1;" >
										<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
						           	</div>
									<div id="changeDate_02" style="position:absolute; left:121; top:93; width:120; height:20; z-index:1;" >
										<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
						           	</div>
								</td>
								<td align="center" class="searchState">구&nbsp;&nbsp;&nbsp;분</td>
								<td>
									<select id="cmbSAL_GBN_SHR" style="WIDTH:70">
										<option value="0" >급  여</option>
	                                    <option value="1" >상  여</option>
	                                    <option value="4" >연  차</option>
									</select>
								</td>
								<td align="center" class="searchState">일련번호</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:60">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
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

<!-- 탭에 따른 DISPLAY 시작 -->
<div id="divSAGA120_file" style="position:absolute; left:617; top:152; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFilecreate','','/images/button/btn_FilecreateOver.gif',3)" >
				<img src="/images/button/btn_FilecreateOn.gif" id="imgFilecreate" name="imgFilecreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_ToFile()" >
			</a>
		</td>
	</tr>
	</table>
</div>

<!-- 제일은행 -->
<div id="divSAGA120_file_01" style="position:absolute; left:617; top:152; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td align="right" style="padding-right:5px; padding-top:2px;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('saga120.xls', '<%=FILEURL %>/saga120.xls');"></a>
        </td>
		<td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
			<a  href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFileAdd','','/images/button/FileAddOver.gif',3)" >
				<img src="/images/button/FileAddOn.gif" id="imgFileAdd" name="imgFileAdd" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()" >
			</a>
		</td>
	</tr>
	</table>
</div>
<!-- 제일은행 -->

<div id="divSAGA120_file_02" style="position:absolute; left:617; top:130; width:200; height:30; z-index:1;" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right" >
				제출일자
				<input id="txtPIS_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD','','634','150');"></a>
		</td>
	</tr>
	</table>
</div>
<!-- 탭에 따른 DISPLAY 끝 -->

		<!--<T>divid="tabSAGA120_01"	title="급상여"</T>-->
		<!--<T>divid="tabSAGA120_02"	title="출자금"</T>-->
		<!--<T>divid="tabSAGA120_03"	title="대출상환"</T>-->
		<!--<T>divid="tabSAGA120_04"	title="연말정산"</T>-->
		<!--<T>divid="tabSAGA120_05"	title="퇴직소득1"</T>-->
		<!--<T>divid="tabSAGA120_09"	title="퇴직소득2"</T>-->
		<!--<T>divid="tabSAGA120_06"	title="제일은행"</T>-->
		<!--<T>divid="tabSAGA120_07"	title="의료비"</T>-->
		<!--<T>divid="tabSAGA120_08"	title="기부금"</T>-->

<!-- 탭 사용 컴퍼넌트 시작 -->
<comment id="__NSID__">
<object id=tabSAGA120 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
		style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder; z-index:2;">
	<param name="BackColor"				value="#F8B97B">
	<param name="DisableBackColor"		value="#EEEEEE">
	<param name="TextColor"				value="#000000">
	<param name="DisableTextColor"		value="#878787">
	<param name="ActiveIndex" 			value="1">
	<param name="Format"					value='

		<T>divid="tabSAGA120_01"	title="급상여"</T>
		<T>divid="tabSAGA120_02"	title="출자금"</T>
		<T>divid="tabSAGA120_03"	title="대출상환"</T>
		<T>divid="tabSAGA120_04"	title="연말정산"</T>
		<T>divid="tabSAGA120_05"	title="퇴직1"</T>
		<T>divid="tabSAGA120_09"	title="퇴직2"</T>
		<T>divid="tabSAGA120_06"	title="은행"</T>
		<T>divid="tabSAGA120_07"	title="의료비"</T>
		<T>divid="tabSAGA120_08"	title="기부금"</T>
		<T>divid="tabSAGA120_10"	title="일용직"</T>

	'>
</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!-- 탭 사용 컴퍼넌트 끝 -->

<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:5;" >

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CP_PAYMASTER_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CP_PAYMASTER_01">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"				align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=100		name="소속"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=100		name="직위"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=100		name="사번"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=100		name="성명"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO"				width=135		name="계좌번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PAY_AMT"			width=100		name="입금액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REMARK"				width=100		name="비고"				align=left			Edit=none		SubBgColor="#99FFCC"	</C>
					'>
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>

                <div style="visibility:hidden; position:absolute; display:none;">
                    <!-- 엑셀 출력을 위해 -->
                    <comment id="__NSID__">
                    <object id="grdT_CP_PAYMASTER_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CP_PAYMASTER_01">
                        <param name="EdiTABLE"                  value="false">
                        <param name="DragDropEnable"            value="true">
                        <param name="SortView"                  value="Left">
                        <param name="VIEWSUMMARY"               value=0>
                        <param name="Format" value='
                            <C> id="ENO_NO"             width=135       name="사번"            align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="GBN"                width=100       name="은행코드"        align=left          Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="ACC_NO"             width=135       name="계좌번호"        align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                            <C> id="PAY_AMT"            width=100       name="입금액"          align=right         Edit=none       SubBgColor="#99FFCC"    </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                </div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

<table width="800" border=1 cellspacing="0" cellpadding="0">
	<tr height="30px" border=1 align=right>
		<td class="tabBold" align="right">
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" checked style="margin-bottom:-2px;border:0;" value="A" onClick="fnc_SearchList();">출자금
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" style="margin-bottom:-2px;border:0;" value="B" onClick="fnc_SearchList();">신규생성자
			<input type="radio" name="radCHULJA_TYPE" id="radCHULJA_TYPE" style="margin-bottom:-2px;border:0;" value="C" onClick="fnc_SearchList();">근로구분변경
			&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table width="800" border=0 cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_02">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"					align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=70		name="직위"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="사번"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="성명"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=70		name="출자금"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EMAENO"				width=70		name="상선사번"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OCC_CD"				width=55		name="근로구분"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(OCC_CD,"A","사무직","M","택배직","C","장비직","D","업무직")}</C>
						<C> id="TAG"				width=60		name="신규구분"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PAY_YMD"			width=80		name="이체일"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HIR_YMD"			width=80		name="입사일"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EM_PHN_NO"			width=90		name="전화번호"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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

<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_03">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=35		name="NO"					align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=55		name="직위"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=65		name="사번"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=65		name="성명"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EMAENO"				width=65		name="상선사번"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=70		name="대출금"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_BAK"			width=70		name="대출잔액"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OCC_CD"				width=45		name="근로구분"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(OCC_CD,"A","사무직","M","택배직","C","장비직","D","업무직")}</C>
						<C> id="GMK_INT"			width=59		name="이자"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=90		name="주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAL_GBN"			width=35		name="구분"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(SAL_GBN,"0","급여","1","상여","2","연차")}</C>
						<C> id="DED_TAG"			width=35		name="공제"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- 탭3조건 입력 테이블 끝 -->

<!-- 탭4 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_04" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETACC_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETACC_04">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)}	</C>
						<C> id="REC_TAG"			width=60		name="구분"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_CD"				width=60		name="세무서"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMP_CD"			width=100		name="사업자번호"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CNT"				width=70		name="전근무처수"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR2"			width=100		name="성명"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO2"			width=100		name="주민등록번호"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="ZIP_NO"				width=100		name="우편번호"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JUSO"				width=350		name="주소"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HOL_YN"				width=100		name="세대주여부"						align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAS_NM"				width=100		name="전근무처"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAO_NO"				width=100		name="전근무사업번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTS"			width=100		name="급여계"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTB"			width=100		name="상여계"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SALT_AMTT"			width=100		name="총계"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SEA_FREE"			width=100		name="국외근로소득"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FREE_INCOME"		width=100		name="비과세소득"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="FIN_SALT"			width=100		name="최종월정액급여"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_INCOME"			width=100		name="총과세소득"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MGR_AMT"			width=100		name="근로소득공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MNI_AMT"			width=100		name="근로소득금액"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="BADD_AMT"			width=100		name="본인공제"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SPSB_AMT"			width=100		name="배우자공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DFM_CNT"			width=100		name="부양자수"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GDED_AMT"			width=100		name="부양가족공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOL_CNT"			width=100		name="경로자수"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOL_AMT"			width=100		name="경로자공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_CNT"			width=100		name="장애자수"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TBL_DED"			width=100		name="장애자공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="WDD_AMT"			width=100		name="부녀자공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_CNT"			width=100		name="자녀자수"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_AMT"			width=100		name="양육비공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INP_CNT"			width=100		name="출생입양수"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INP_AMT"			width=100		name="출생입양공제"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CHI_CNT"            width=100       name="다자녀추가인원"           align=right         Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="SMD_AMT"			width=100		name="다자녀추가공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NPEN_DED"			width=100		name="연금보험료공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="HINU_AMT"			width=100		name="건강보험료"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HINS_AMT"			width=100		name="고용보험료"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LIN_DED"			width=100		name="보장성보험료"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LIH_DED"			width=100		name="장애인전용"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="MMA_DED"			width=100		name="의료비"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_DED"			width=100		name="교육비"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LOAN_DED"			width=100		name="주택임차차입이자"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="MRENT_DED"			width=100		name="월세액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="LONG_DED"			width=100		name="장기주택저당이자"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CPC_DED"			width=100		name="기부금"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="WFM_DED"			width=100		name="결혼장례이사"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SPC_TOT"			width=100		name="조특법공제합계"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NSE_TOT"			width=100		name="특별공제계"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="STA_TOT"			width=100		name="표준공제"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INDED_TOT"			width=100		name="차감소득금액"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="PER_SAV"			width=100		name="개인연금소득공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ANN_DED"			width=100		name="연금저축소득공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE_DED"			width=100		name="주택마련저축공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_DED"			width=100		name="신용카드"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="SAVE1_DED"			width=100		name="청약저축"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE2_DED"			width=100		name="주택청약종합저축"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE3_DED"			width=100		name="장기주택마련저축"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SAVE4_DED"			width=100		name="근로자주택마련저축"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>


						<C> id="STOCK_DED"			width=100		name="장기주식형저축"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="VEN_DED"			width=100		name="투자조합출자"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TTAX_STD"			width=100		name="종합소득과세표준"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TAX_AMT"			width=100		name="산출세액"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HGR_DED"			width=100		name="근로소득세액공제"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="STX_DED"			width=100		name="저축세액"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HTX_DED"			width=100		name="주택세액"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HSX_DED"			width=100		name="근로자주식세액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LSX_DED"			width=100		name="장기증권주식세액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GOV_DED"			width=100		name="정치기부금세액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="OTX_DED"			width=100		name="외국납부세액"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TDED_TOT"			width=100		name="세액공제계"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DGG_TAX"			width=100		name="소득세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DBW_TAX"			width=100		name="농특세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DJM_TAX"			width=100		name="주민세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAL_AMT"			width=100		name="전근무소득세"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAN_AMT"			width=100		name="전근무주민세"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INCM_TAX"			width=100		name="현근무소득세"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CITI_TAX"			width=100		name="현근무주민세"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="HIR_YMD"			width=100		name="귀속시작일"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX-XX-XX"	</C>
						<C> id="RET_YMD"			width=100		name="귀속종료일"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX-XX-XX"	</C>
						<C> id="CASH_AMT"			width=100		name="현금영수증"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JAI_AMT"			width=100		name="인정상여"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_1"			width=100		name="관계1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_1"			width=100		name="성명1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_1"			width=100		name="주민번호1"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_1"			width=100		name="기본공제1"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_1"			width=100		name="장애인1"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_1"			width=100		name="자녀양육1"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
					    <C> id="WCT_MAN_1"          width=100       name="부녀자1"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_1"          width=100       name="경로우대1"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_1"          width=100       name="다자녀추가1"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="INP_MAN_1"          width=100       name="출생입양1"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                    	<C> id="INV_NTS_1"			width=100		name="국세청보험료1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_1"			width=100		name="국세청의료비1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_1"			width=100		name="국세청교육비1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_1"			width=100		name="국세청신용카드1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_1"			width=100		name="국세청현금1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_1"			width=100		name="보험료1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_1"			width=100		name="의료비1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_1"			width=100		name="교육비1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_1"			width=100		name="신용카드1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_1"			width=100		name="기부금1"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_2"			width=100		name="관계2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_2"			width=100		name="성명2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_2"			width=100		name="주민번호2"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_2"			width=100		name="기본공제2"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_2"			width=100		name="장애인2"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_2"			width=100		name="자녀양육2"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_2"          width=100       name="부녀자2"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_2"          width=100       name="경로우대2"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_2"          width=100       name="다자녀추가2"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_2"          width=100       name="출생입양2"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_2"			width=100		name="국세청보험료2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_2"			width=100		name="국세청의료비2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_2"			width=100		name="국세청교육비2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_2"			width=100		name="국세청신용카드2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_2"			width=100		name="국세청현금2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_2"			width=100		name="보험료2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_2"			width=100		name="의료비2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_2"			width=100		name="교육비2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_2"			width=100		name="신용카드2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_2"			width=100		name="기부금2"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_3"			width=100		name="관계3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_3"			width=100		name="성명3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_3"			width=100		name="주민번호3"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_3"			width=100		name="기본공제3"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_3"			width=100		name="장애인3"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_3"			width=100		name="자녀양육3"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_3"          width=100       name="부녀자3"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_3"          width=100       name="경로우대3"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_3"          width=100       name="다자녀추가3"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_3"          width=100       name="출생입양3"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_3"			width=100		name="국세청보험료3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_3"			width=100		name="국세청의료비3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_3"			width=100		name="국세청교육비3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_3"			width=100		name="국세청신용카드3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_3"			width=100		name="국세청현금3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_3"			width=100		name="보험료3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_3"			width=100		name="의료비3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_3"			width=100		name="교육비3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_3"			width=100		name="신용카드3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_3"			width=100		name="기부금3"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_4"			width=100		name="관계4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_4"			width=100		name="성명4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_4"			width=100		name="주민번호4"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_4"			width=100		name="기본공제4"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_4"			width=100		name="장애인4"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_4"			width=100		name="자녀양육4"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_4"          width=100       name="부녀자4"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_4"          width=100       name="경로우대4"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_4"          width=100       name="다자녀추가4"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_4"          width=100       name="출생입양4"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_4"			width=100		name="국세청보험료4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_4"			width=100		name="국세청의료비4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_4"			width=100		name="국세청교육비4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_4"			width=100		name="국세청신용카드4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_4"			width=100		name="국세청현금4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_4"			width=100		name="보험료4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_4"			width=100		name="의료비4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_4"			width=100		name="교육비4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_4"			width=100		name="신용카드4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_4"			width=100		name="기부금4"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_CD_5"			width=100		name="관계5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAM_KOR_5"			width=100		name="성명5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO_5"			width=100		name="주민번호5"				align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="BAS_MAN_5"			width=100		name="기본공제5"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TRB_MAN_5"			width=100		name="장애인5"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="RCH_MAN_5"			width=100		name="자녀양육5"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
                        <C> id="WCT_MAN_5"          width=100       name="부녀자5"                  align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="GOL_MAN_5"          width=100       name="경로우대5"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
                        <C> id="CHI_MAN_5"          width=100       name="다자녀추가5"              align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INP_MAN_5"          width=100       name="출생입양5"                align=center        Edit=none       SubBgColor="#99FFCC"    </C>
						<C> id="INV_NTS_5"			width=100		name="국세청보험료5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_NTS_5"			width=100		name="국세청의료비5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_NTS_5"			width=100		name="국세청교육비5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_NTS_5"			width=100		name="국세청신용카드5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CASH_NTS_5"			width=100		name="국세청현금5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="INV_AMT_5"			width=100		name="보험료5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="MED_AMT_5"			width=100		name="의료비5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="EDU_AMT_5"			width=100		name="교육비5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CARD_AMT_5"			width=100		name="신용카드5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="LC3_AMT_5"			width=100		name="기부금5"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_1"		width=100		name="소득공제구분1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_1"			width=100		name="금융기관코드1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_1"			width=100		name="금융기관상호1"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_1"			width=100		name="계좌번호1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_1"			width=100		name="납입연차1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_1"			width=100		name="불입금액1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_1"			width=100		name="공제금액1"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_2"		width=100		name="소득공제구분2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_2"			width=100		name="금융기관코드2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_2"			width=100		name="금융기관상호2"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_2"			width=100		name="계좌번호2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_2"			width=100		name="납입연차2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_2"			width=100		name="불입금액2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_2"			width=100		name="공제금액2"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_3"		width=100		name="소득공제구분3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_3"			width=100		name="금융기관코드3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_3"			width=100		name="금융기관상호3"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_3"			width=100		name="계좌번호3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_3"			width=100		name="납입연차3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_3"			width=100		name="불입금액3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_3"			width=100		name="공제금액3"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_4"		width=100		name="소득공제구분4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_4"			width=100		name="금융기관코드4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_4"			width=100		name="금융기관상호4"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_4"			width=100		name="계좌번호4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_4"			width=100		name="납입연차4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_4"			width=100		name="불입금액4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_4"			width=100		name="공제금액4"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_5"		width=100		name="소득공제구분5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_5"			width=100		name="금융기관코드5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_5"			width=100		name="금융기관상호5"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_5"			width=100		name="계좌번호5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_5"			width=100		name="납입연차5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_5"			width=100		name="불입금액5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_5"			width=100		name="공제금액5"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_6"		width=100		name="소득공제구분6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_6"			width=100		name="금융기관코드6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_6"			width=100		name="금융기관상호6"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_6"			width=100		name="계좌번호6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_6"			width=100		name="납입연차6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_6"			width=100		name="불입금액6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_6"			width=100		name="공제금액6"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_7"		width=100		name="소득공제구분7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_7"			width=100		name="금융기관코드7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_7"			width=100		name="금융기관상호7"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_7"			width=100		name="계좌번호7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_7"			width=100		name="납입연차7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_7"			width=100		name="불입금액7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_7"			width=100		name="공제금액7"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_8"		width=100		name="소득공제구분8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_8"			width=100		name="금융기관코드8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_8"			width=100		name="금융기관상호8"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_8"			width=100		name="계좌번호8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_8"			width=100		name="납입연차8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_8"			width=100		name="불입금액8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_8"			width=100		name="공제금액8"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_9"		width=100		name="소득공제구분9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_9"			width=100		name="금융기관코드9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_9"			width=100		name="금융기관상호9"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_9"			width=100		name="계좌번호9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_9"			width=100		name="납입연차9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_9"			width=100		name="불입금액9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_9"			width=100		name="공제금액9"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_10"	width=100		name="소득공제구분10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_10"			width=100		name="금융기관코드10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_10"			width=100		name="금융기관상호10"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_10"			width=100		name="계좌번호10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_10"		width=100		name="납입연차10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_10"			width=100		name="불입금액10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_10"			width=100		name="공제금액10"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_11"	width=100		name="소득공제구분11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_11"			width=100		name="금융기관코드11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_11"			width=100		name="금융기관상호11"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_11"			width=100		name="계좌번호11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_11"		width=100		name="납입연차11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_11"			width=100		name="불입금액11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_11"			width=100		name="공제금액11"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_12"	width=100		name="소득공제구분12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_12"			width=100		name="금융기관코드12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_12"			width=100		name="금융기관상호12"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_12"			width=100		name="계좌번호12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_12"		width=100		name="납입연차12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_12"			width=100		name="불입금액12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_12"			width=100		name="공제금액12"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_13"	width=100		name="소득공제구분13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_13"			width=100		name="금융기관코드13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_13"			width=100		name="금융기관상호13"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_13"			width=100		name="계좌번호13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_13"		width=100		name="납입연차13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_13"			width=100		name="불입금액13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_13"			width=100		name="공제금액13"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_14"	width=100		name="소득공제구분14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_14"			width=100		name="금융기관코드14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_14"			width=100		name="금융기관상호14"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_14"			width=100		name="계좌번호14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_14"		width=100		name="납입연차14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_14"			width=100		name="불입금액14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_14"			width=100		name="공제금액14"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>

						<C> id="PEN_GUBUN_CD_15"	width=100		name="소득공제구분15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_CD_15"			width=100		name="금융기관코드15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ABA_NM_15"			width=100		name="금융기관상호15"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ACC_NO_15"			width=100		name="계좌번호15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="YEAR_SEQ_15"		width=100		name="납입연차15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="AMOUNT_15"			width=100		name="불입금액15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DED_AMT_15"			width=100		name="공제금액15"				align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- 탭4 조건 입력 테이블 끝 -->

<!-- 탭5 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_05" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETTABLE_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETTABLE_05">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=40		name="NO"						align=center	Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>

						<G>name="소득자"		HeadBgColor="#F7DCBB"
							<C> id="COL6"			width=100		name="종(전)근무처수"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL7_NM"	width=100		name="거주자구분코드"					align=center	Edit=none		SubBgColor="#99FFCC"	value={DECODE(COL7,"1","거주자","비거주자")}</C>
							<C> id="COL9"			width=120		name="귀속연도시작연월일"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL10"			width=120		name="귀속연도종료연월일"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL11"			width=100		name="성명"							align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL13"			width=100		name="주민등록번호"					align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="주(현)소득지급처별명세"		HeadBgColor="#F7DCBB"
							<C> id="COL14"			width=100		name="퇴직급여"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL15"			width=100		name="명예퇴직수당"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL16"			width=100		name="퇴직연금일시금"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL17"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL18"			width=100		name="비과세소득"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="주(현)근무지퇴직연금명세"		HeadBgColor="#F7DCBB"
							<C> id="COL19"			width=100		name="총수령액"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL20"			width=100		name="원리금합계액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL21"			width=100		name="소득자불입액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL22"			width=120		name="퇴직연금소득공제액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL23"			width=100		name="퇴직연금일시금"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="세액환산명세"		HeadBgColor="#F7DCBB"
							<C> id="COL24"			width=150		name="퇴직연금일시금지급예상액"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL25"			width=100		name="총일시금"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL26"			width=120		name="수령가능퇴직급여액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL27"			width=120		name="환산퇴직소득공제"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL28"			width=150		name="환산퇴직소득공제과세표준"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL29"			width=120		name="환산연평균과세표준"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL30"			width=120		name="환산연평균산출세액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="근속연수"		HeadBgColor="#F7DCBB"
							<C> id="COL31"			width=140		name="주(현)근무지입사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL32"			width=140		name="주(현)근무지퇴사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL33"			width=130		name="주(현)근무지근속월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL34"			width=130		name="주(현)근무지제외월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL35"			width=140		name="종(전)근무지입사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL36"			width=140		name="종(전)근무지퇴사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL37"			width=130		name="종(전)근무지근속월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL38"			width=130		name="종(전)근무지제외월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL39"			width=100		name="중복월수"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL40"			width=100		name="근속연수"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="정산명세"		HeadBgColor="#F7DCBB"
							<C> id="COL41"			width=100		name="퇴직급여액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL42"			width=100		name="퇴직소득공제"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL43"			width=120		name="퇴직소득과세표준"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL44"			width=100		name="연평균과세표준"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL45"			width=100		name="연평균산출세액"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL46"			width=100		name="산출세액"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="결정세액"		HeadBgColor="#F7DCBB"
							<C> id="COL47"			width=100		name="소득세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL48"			width=100		name="주민세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL49"			width=100		name="농특세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL50"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="기납부세액(종(전)근무지)"		HeadBgColor="#F7DCBB"
							<C> id="COL51"			width=100		name="소득세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL52"			width=100		name="주민세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL53"			width=100		name="농특세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL54"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>
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
<!-- 탭5 조건 입력 테이블 끝 -->



<!-- 탭6 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_06" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_LOAN_06" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_LOAN_06">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"				align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="OCC_CD"				width=80		name="근로구분"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=80		name="직위"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="DPT_NM"				width=99		name="소속"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=80		name="성명"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=80		name="사번"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_PAY"			width=80		name="대출금액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_INT"			width=80		name="이자상환액"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_AMT"			width=80		name="원금상환액"		align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="GMK_BAK"			width=80		name="대출잔액"			align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- 탭6 조건 입력 테이블 끝 -->

<!-- 탭7 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_07" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_MEDICAL_07" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_MEDICAL_07">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=40		name="NO"								align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=60		name="직위"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="사번"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="주민등록번호"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAT_CD"				width=80		name="내외국인"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="성명"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"				width=90		name="사업자번호"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NM"			width=180		name="업체명"							align=center		Edit=none		SubBgColor="#99FFCC"	SubSumText=" 합 계 "</C>
						<C> id="MED_CD"				width=80		name="증빙코드"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="건수"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="지급금액"						align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="REL_NM"				width=120		name="관계"							align=center		Edit=none		SubBgColor="#99FFCC"	show=false</C>
						<C> id="TCET_NO"			width=140		name="대상자주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NAT_CD2"			width=80		name="내외국인"						align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COMM_CD"			width=50		name="구분"							align=center		Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- 탭7 조건 입력 테이블 끝 -->

<!-- 탭8 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_08" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_DONATION_08" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_DONATION_08">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=44		name="NO"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="JOB_NM"				width=60		name="직위"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NO"				width=70		name="사번"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=70		name="성명"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CET_NO"				width=100		name="주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NO"				width=90		name="사업자번호"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="COM_NM"			width=180		name="업체명"					align=center		Edit=none		SubBgColor="#99FFCC"	SubSumText=" 합 계 "</C>
						<C> id="REL_NM"				width=60		name="기부유형"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="TOT_CNT"			width=50		name="건수"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="SUM_AMT"			width=80		name="금액"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
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
<!-- 탭8 조건 입력 테이블 끝 -->


<!-- 탭9 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_09" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_AC_RETTABLE_09" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_AC_RETTABLE_09">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"				width=40		name="NO"						align=center	Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>

						<G>name="소득자"		HeadBgColor="#F7DCBB"
							<C> id="COL6"			width=100		name="종(전)근무처수"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL7_NM"	width=100		name="거주자구분코드"					align=center	Edit=none		SubBgColor="#99FFCC"	value={DECODE(COL7,"1","거주자","비거주자")}</C>
							<C> id="COL9"			width=120		name="귀속연도시작연월일"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL10"			width=120		name="귀속연도종료연월일"			align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL11"			width=100		name="성명"							align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL13"			width=100		name="주민등록번호"					align=center	Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="주(현)소득지급처별명세"		HeadBgColor="#F7DCBB"
							<C> id="COL14"			width=100		name="퇴직급여"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL15"			width=100		name="명예퇴직수당"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL16"			width=100		name="퇴직연금일시금"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL17"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL18"			width=100		name="비과세소득"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="주(현)근무지퇴직연금명세"		HeadBgColor="#F7DCBB"
							<C> id="COL19"			width=100		name="총수령액"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL20"			width=100		name="원리금합계액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL21"			width=100		name="소득자불입액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL22"			width=120		name="퇴직연금소득공제액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL23"			width=100		name="퇴직연금일시금"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="세액환산명세"		HeadBgColor="#F7DCBB"
							<C> id="COL24"			width=150		name="퇴직연금일시금지급예상액"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL25"			width=100		name="총일시금"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL26"			width=120		name="수령가능퇴직급여액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL27"			width=120		name="환산퇴직소득공제"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL28"			width=150		name="환산퇴직소득공제과세표준"		align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL29"			width=120		name="환산연평균과세표준"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL30"			width=120		name="환산연평균산출세액"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="근속연수"		HeadBgColor="#F7DCBB"
							<C> id="COL31"			width=140		name="주(현)근무지입사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL32"			width=140		name="주(현)근무지퇴사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL33"			width=130		name="주(현)근무지근속월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL34"			width=130		name="주(현)근무지제외월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL35"			width=140		name="종(전)근무지입사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL36"			width=140		name="종(전)근무지퇴사연월일"		align=center	Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL37"			width=130		name="종(전)근무지근속월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL38"			width=130		name="종(전)근무지제외월수"			align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL39"			width=100		name="중복월수"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL40"			width=100		name="근속연수"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="정산명세"		HeadBgColor="#F7DCBB"
							<C> id="COL41"			width=100		name="퇴직급여액"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL42"			width=100		name="퇴직소득공제"					align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL43"			width=120		name="퇴직소득과세표준"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL44"			width=100		name="연평균과세표준"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL45"			width=100		name="연평균산출세액"				align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL46"			width=100		name="산출세액"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="결정세액"		HeadBgColor="#F7DCBB"
							<C> id="COL47"			width=100		name="소득세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL48"			width=100		name="주민세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL49"			width=100		name="농특세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL50"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>

						<G>name="기납부세액(종(전)근무지)"		HeadBgColor="#F7DCBB"
							<C> id="COL51"			width=100		name="소득세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL52"			width=100		name="주민세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL53"			width=100		name="농특세"						align=right		Edit=none		SubBgColor="#99FFCC"	</C>
							<C> id="COL54"			width=100		name="계"							align=right		Edit=none		SubBgColor="#99FFCC"	</C>
						</G>
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
<!-- 탭9 조건 입력 테이블 끝 -->

<!-- 탭10 조건 입력 테이블 시작 -->
<div class=page id="tabSAGA120_10" style="position:absolute; left:20; top:175; width:800; height:300; z-index:4; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td>
				<comment id="__NSID__">
				<object id="grdT_CA_PAYMASTER_10" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
					<param name="DataID" value="dsT_CA_PAYMASTER_10">
					<param name="EdiTABLE"					value="false">
					<param name="DragDropEnable"			value="true">
					<param name="SortView"					value="Left">
					<param name="VIEWSUMMARY"			    value=0>
					<param name="Format" value='
						<C> id="{currow}"			width=30		name="순"						align=center		Edit=none		SubBgColor="#99FFCC"	value={String(Currow)} </C>
						<C> id="DPT_NM"				width=90		name="소속"					align=left			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="ENO_NM"				width=60		name="성명"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="NATION"				width=60		name="내/외"					align=center		Edit=none		SubBgColor="#99FFCC"	value={DECODE(NATION,"0","내국인","외국인")}</C>						

						<C> id="WRK_YM"				width=60		name="지급월"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX/XX"	</C>						
						<C> id="WRK_YM2"			width=60		name="근무월"					align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXX/XX"	</C>
						<C> id="CNT"					width=60		name="근무일"					align=center		Edit=none		SubBgColor="#99FFCC"	</C>						
						<C> id="WRK_PAY"			width=70		name="총지급"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>						
						<C> id="NOTAX"				width=70		name="비과세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>			
																		
						<C> id="INCM_TAX"			width=60		name="소득세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>
						<C> id="CITI_TAX"			width=60		name="지방세"					align=right			Edit=none		SubBgColor="#99FFCC"	</C>				

						<C> id="CET_NO"				width=100		name="주민등록번호"			align=center		Edit=none		SubBgColor="#99FFCC"	Mask="XXXXXX-XXXXXXX"	</C>
						<C> id="PH_NO"				width=100		name="전화번호"				align=center		Edit=none		SubBgColor="#99FFCC"	</C>						
								
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
<!-- 탭10 조건 입력 테이블 끝 -->



</form>
<!-- form 끝 -->

</body>
</html>