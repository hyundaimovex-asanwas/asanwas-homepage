<!--
    ************************************************************************************
    * @source         : ymaa010.jsp 				                                                                                     *
    * @description   : 연차수당작업관리 PAGE.                                                                             *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/25  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>연차수당작업관리</title>
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
		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분

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
            dsT_CP_WORKLOG.DataID = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR;
            dsT_CP_WORKLOG.Reset();

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
			dsT_CP_WORKLOG.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtPRO_STS_MSG").value = ' ';
			document.getElementById("cmbOCC_CD_SHR").value = "A"; // 근로구분구분
			document.form1.txtPIS_YYMM_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_CP_WORKLOG.IsUpdated)  {

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

        	if (!dsT_CP_WORKLOG.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;
			var oPIS_YYMM;

			/*
			oPIS_YYMM = dsT_CP_WORKLOG.NameValue(i,"PIS_YYMM");
			if(oPIS_YYMM.trim().length == 0){
				alert("적용일이 잘못되었습니다.");
				dsT_CP_WORKLOG.RowPosition = i;
				return false;
			}
			*/

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			//cfStyleGrid(form1.grdT_CP_WORKLOG,0,"false","false");

			document.getElementById("txtPIS_YYMM_SHR").value = getToday().substring(0,7);

			//근로구분
			if(document.getElementById("cmbOCC_CD_SHR").length == 0){
				for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {
					oOption       = document.createElement("OPTION");
					oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
					oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
					document.getElementById("cmbOCC_CD_SHR").add(oOption);
				}
			}

			disableInput();//입력필드 비활성화

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

         //작업 OPEN
         function object_sts_1(){

         	var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value; // 근로구분구분
			var SAL_GBN_SHR = "4";//구분
			var PRO_STS = "1";//작업상황

			var i = 1;
			var oPAY_YMD, oSTR_YYMM, oEND_YYMM,  oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("지급일자를 입력하세요.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("지급일자가 잘못되었습니다.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oSTR_YYMM = dsT_CP_WORKLOG.NameValue(i,"STR_YYMM");
			if(oSTR_YYMM.trim().length == 0){
				alert("대상기간 시작년월을 입력하세요.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}
			if(oSTR_YYMM.trim().length != 7){
				alert("대상기간 시작년월이 잘못되었습니다.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}

			oEND_YYMM = dsT_CP_WORKLOG.NameValue(i,"END_YYMM");
			if(oEND_YYMM.trim().length == 0){
				alert("대상기간 종료년월을 입력하세요.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			if(oEND_YYMM.trim().length != 7){
				alert("대상기간 종료년월이 잘못되었습니다.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			
			if(oSTR_YYMM.substring(0,4) != oEND_YYMM.substring(0,4)){
                alert("대상기간의 시작년도와 종료년도는 같아야합니다.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
			}
			
			if(oSTR_YYMM.replace("-", "").replace("-", "") > oEND_YYMM.replace("-", "").replace("-", "")){
                alert("종료년월이 시작년월보다 빠릅니다.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
			}

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("호봉표일자를 입력하세요.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("호봉표일자가 잘못되었습니다.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

			//키값이 전부 있어야 트랜잭션으로 넘어간다.
			dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=PIS_YYMM_SHR.substring(0,4);
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=PIS_YYMM_SHR.substring(5,7);
			dsT_CP_WORKLOG.NameValue(i,"OCC_CD")=OCC_CD_SHR;
			dsT_CP_WORKLOG.NameValue(i,"SAL_GBN")=SAL_GBN_SHR;
			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV";
			trT_CP_WORKLOG.Post();

         }

         //대상자 선정
         function object_sts_2(){

			var i = 1;
			var oPAY_YMD, oSTR_YYMM, oEND_YYMM,  oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("지급일자를 입력하세요.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("지급일자가 잘못되었습니다.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oSTR_YYMM = dsT_CP_WORKLOG.NameValue(i,"STR_YYMM");
			if(oSTR_YYMM.trim().length == 0){
				alert("대상기간 시작년월을 입력하세요.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}
			if(oSTR_YYMM.trim().length != 7){
				alert("대상기간 시작년월이 잘못되었습니다.");
				document.getElementById("txtSTR_YYMM").focus();
				return false;
			}

			oEND_YYMM = dsT_CP_WORKLOG.NameValue(i,"END_YYMM");
			if(oEND_YYMM.trim().length == 0){
				alert("대상기간 종료년월을 입력하세요.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			if(oEND_YYMM.trim().length != 7){
				alert("대상기간 종료년월이 잘못되었습니다.");
				document.getElementById("txtEND_YYMM").focus();
				return false;
			}
			
            if(oSTR_YYMM.substring(0,4) != oEND_YYMM.substring(0,4)){
                alert("대상기간의 시작년도와 종료년도는 같아야합니다.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
            }
            
            if(oSTR_YYMM.replace("-", "").replace("-", "") > oEND_YYMM.replace("-", "").replace("-", "")){
                alert("종료년월이 시작년월보다 빠릅니다.");
                document.getElementById("txtEND_YYMM").focus();
                return false;
            }

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("호봉표일자를 입력하세요.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("호봉표일자가 잘못되었습니다.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

            if (confirm("대상자 선정을 하시겠습니까? ") == false) return;

			var PRO_STS = "2";//작업상황

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;
            
            
            //db의 최대 커서수 문제로 인하여 나누어 작업
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_01&TR_SEQ=1";
			trT_CP_WORKLOG.Post();
			
            dsT_CP_WORKLOG.UseChangeInfo = "false";
            			
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_01&TR_SEQ=2";
			trT_CP_WORKLOG.Post();
			
			dsT_CP_WORKLOG.UseChangeInfo = "true";

         }

         //계산
         function object_sts_4(){

            if (confirm("계산을 하시겠습니까? ") == false) return;

			var PRO_STS = "4";//작업상황

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_03";
			trT_CP_WORKLOG.Post();

         }

         //대상자 초기화
         function object_sts_2_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "2"){//대상자선정 초기화

	            if (confirm("대상자 초기화를 하시겠습니까? ") == false) return;

				PRO_STS = "1";//대상자선정으로 변경

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//트랜잭션 전송
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_02";
				trT_CP_WORKLOG.Post();
			}
         }

         //계산 초기화
         function object_sts_4_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "4"){//계산 초기화

	            if (confirm("계산 초기화를 하시겠습니까? ") == false) return;

				PRO_STS = "2";//계산으로 변경

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//트랜잭션 전송
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_04";
				trT_CP_WORKLOG.Post();
			}
         }

         //작업CLOSE
         function object_sts_6(){
            if (confirm("작업CLOSE를 하시겠습니까? ") == false) return;

			var PRO_STS = "6";//작업상황

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "/servlet/GauceChannelSVL?cmd=hr.yma.a.ymaa010.cmd.YMAA010CMD&S_MODE=SAV_05";
			trT_CP_WORKLOG.Post();
         }

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(state){

			//조회필드는 사용 불가능하게
			document.form1.txtPIS_YYMM_SHR.readOnly = true;
  			document.form1.txtPIS_YYMM_SHR.className = "input_ReadOnly";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = true;
  			document.getElementById("cmbOCC_CD_SHR").disabled = true;

  			if(state == "0"){//작업OPEN가능
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
				document.form1.txtSTR_YYMM.readOnly = false;
	  			document.form1.txtSTR_YYMM.className = "";
	  			document.getElementById("imgSTR_YYMM").disabled = false;
				document.form1.txtEND_YYMM.readOnly = false;
	  			document.form1.txtEND_YYMM.className = "";
	  			document.getElementById("imgEND_YYMM").disabled = false;
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = false;
				document.getElementById("btnPRO_STS_1").className="";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE
  			}

  			else if(state == "1"){//작업OPEN 완료
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
				document.form1.txtSTR_YYMM.readOnly = false;
	  			document.form1.txtSTR_YYMM.className = "";
	  			document.getElementById("imgSTR_YYMM").disabled = false;
				document.form1.txtEND_YYMM.readOnly = false;
	  			document.form1.txtEND_YYMM.className = "";
	  			document.getElementById("imgEND_YYMM").disabled = false;
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = false;
				document.getElementById("btnPRO_STS_2").className="";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE
  			}

  			else if(state == "2"){//대상자 선정 완료
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = false;
				document.getElementById("btnPRO_STS_4").className="";//계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = false;
				document.getElementById("btnPRO_STS_2_RESET").className="";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

  			}

  			else if(state == "4"){//계산 완료
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = false;
				document.getElementById("btnPRO_STS_4_RESET").className="";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = false;
				document.getElementById("btnPRO_STS_6").className="";//작업CLOSE

  			}

  			else if(state == "6"){//작업CLOSE
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
				document.form1.txtSTR_YYMM.readOnly = true;
	  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgSTR_YYMM").disabled = true;
				document.form1.txtEND_YYMM.readOnly = true;
	  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
	  			document.getElementById("imgEND_YYMM").disabled = true;
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

  			}

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			//조회필드는 사용 가능하게
			document.form1.txtPIS_YYMM_SHR.readOnly = false;
  			document.form1.txtPIS_YYMM_SHR.className = "";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = false;
  			document.getElementById("cmbOCC_CD_SHR").disabled = false;

			document.form1.txtPAY_YMD.readOnly = true;
  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgPAY_YMD").disabled = true;
			document.form1.txtSTR_YYMM.readOnly = true;
  			document.form1.txtSTR_YYMM.className = "input_ReadOnly";
  			document.getElementById("imgSTR_YYMM").disabled = true;
			document.form1.txtEND_YYMM.readOnly = true;
  			document.form1.txtEND_YYMM.className = "input_ReadOnly";
  			document.getElementById("imgEND_YYMM").disabled = true;
			document.form1.txtAPY_YMD.readOnly = true;
  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgAPY_YMD").disabled = true;
  			document.getElementById("btnPRO_STS_1").disabled = true;
			document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
  			document.getElementById("btnPRO_STS_2").disabled = true;
			document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
  			document.getElementById("btnPRO_STS_4").disabled = true;
			document.getElementById("btnPRO_STS_4").className="inputDisabled";//계산
  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
			document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//재작업(대상자및계산)
  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
			document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//재작업(대상자및계산)
  			document.getElementById("btnPRO_STS_6").disabled = true;
			document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

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
    | 2. 이름 : dsT_CP_WORKLOG                             |
    | 3. Table List : T_CP_WORKLOG                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut    value=100000>
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CP_PAYTABLE                          |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 2. 이름 : trT_CP_WORKLOG                                       |
    | 3. Table List : T_CP_WORKLOG                                 |
    +----------------------------------------------->
    <Object ID ="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
            <param name=TimeOut    value=1000000>
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">


        if (iCount == 0) {//데이터가 없으면 신규 작업OPEN
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.getElementById("txtPRO_STS_MSG").value = "연차수당처리 작업OPEN 할 수 있습니다.";

            dsT_CP_WORKLOG.AddRow();

            //대상년월 초기화
			document.getElementById("txtSTR_YYMM").value = getToday().substring(0,4)+"-01";
  			document.getElementById("txtEND_YYMM").value = getToday().substring(0,4)+"-12";

			//최근 저장한 호봉표일자 조회
			ds01T_CP_PAYTABLE.DataID = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga010.cmd.SAGA010CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			enableInput("0");

			document.getElementById("txtPAY_YMD").focus();

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "작업OPEN을 하였습니다.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	//document.getElementById("txtPRO_STS_MSG").value = "대상자선정완료";
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "계산을 완료하였습니다.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	//document.getElementById("txtPRO_STS_MSG").value = "작업완료";
            }else if(PRO_STS == "6"){
               	document.getElementById("txtPRO_STS_MSG").value = "작업CLOSE";
               	enableInput("6");
            }

        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        //alert("해당 필수입력항목[해당년월/근로구분/직위/호봉] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        //alert("해당년월/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

		var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

		if(PRO_STS == "1"){
			//document.getElementById("txtPRO_STS_MSG").value = "작업OPEN을 하였습니다.";
			//enableInput("1");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "2"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
			//enableInput("2");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "3"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "대상자선정완료";
		}else if(PRO_STS == "4"){
		    //document.getElementById("txtPRO_STS_MSG").value = "계산을 완료하였습니다.";
			//enableInput("4");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "5"){
	   		//document.getElementById("txtPRO_STS_MSG").value = "작업완료";
		}else if(PRO_STS == "6"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "작업CLOSE";
			//enableInput("6");
			fnc_SearchList();//재조회
		}

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_WORKLOG event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연차수당작업관리</td>
					<td align="right" class="navigator">HOME/보상관리/연차관리/<font color="#000000">연차수당작업관리</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
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
								<col width="50"></col>
								<col width="100"></col>
								<col width="300"></col>
								<col width="100"></col>
								<col width="150"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">해당년월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','130','112');"></a>
								</td>
								<td align="center" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
								<td>
									<select id="cmbOCC_CD_SHR" style="WIDTH:100">
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="240"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">지급일자</td>
					<td class="padding2423">
						<input id="txtPAY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','65','155');"></a>
					</td>
                    <td align="center" class="creamBold">대상기간</td>
					<td class="padding2423">
						<input id="txtSTR_YYMM" size="8" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YYMM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YYMM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YYMM','','290','155');"></a>
						&nbsp;~&nbsp;
						<input id="txtEND_YYMM" size="8" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YYMM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YYMM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YYMM','','400','155');"></a>
					</td>
					<td align="center" class="creamBold">호봉표일자</td>
					<td class="padding2423">
						<input id="txtAPY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','620','155');"></a>
					</td>
				</tr>
				<tr>
	        		<td align="center" class="creamBold">대상인원</td>
	        		<td colspan="5">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                  <colgroup>
                                      <col width="100"></col>
                                      <col width="130"></col>
                                      <col width="100"></col>
                                      <col width=""></col>
                                  </colgroup>
                                  <tr>
	        		            <td align="right">처리인원&nbsp;</td>
	        		            <td ><input id="txtPRO_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
	        		            <td align="right">미처리인원&nbsp;</td>
	        		            <td ><input id="txtERR_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
	        		        <tr>
	        		    </table>
	        		</td>
				</tr>
				<tr>
	        		<td align="center" class="creamBold">작업상황</td>
	        		<td  class="padding2423" colspan="5">
	        			<input id="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
	        			<input id="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
	        		</td>
	            </tr>
			</table>
		</td>
	</tr>
</table>
<table>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="260"></col>
	                            <col width="260"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr height="50">
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_1"  style="cursor:hand;width:110pt;height:25pt;" value=" 작업OPEN " onclick="object_sts_1();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2"  style="cursor:hand;width:110pt;height:25pt;" value=" 대상자선정 " onclick="object_sts_2();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4"  style="cursor:hand;width:110pt;height:25pt;" value=" 계산 " onclick="object_sts_4();">
	                            </td>
	                        </tr>
	                        <tr height="50">
	                            <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_6" style="cursor:hand;width:110pt;height:25pt;" value=" 작업CLOSE " onclick="object_sts_6();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2_RESET"  style="cursor:hand;width:110pt;height:25pt;" value=" 대상자 초기화 " onclick="object_sts_2_reset();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4_RESET"  style="cursor:hand;width:110pt;height:25pt;" value=" 계산 초기화 " onclick="object_sts_4_reset();">
	                            </td>
	                        </tr>
	                    </table>
	                <td>
	            </tr>
            </table>
        </td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_CP_WORKLOG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_WORKLOG">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS     		 	Ctrl=txtPRO_STS     		 	Param=value 		</C>
		<C>Col=PAY_YMD     		 	Ctrl=txtPAY_YMD     		 	Param=value 		</C>
		<C>Col=STR_YYMM     	 	Ctrl=txtSTR_YYMM    		 	Param=value 		</C>
		<C>Col=END_YYMM     	 	Ctrl=txtEND_YYMM    		 	Param=value 		</C>
		<C>Col=APY_YMD     		 	Ctrl=txtAPY_YMD     		 	Param=value 		</C>
		<C>Col=PRO_CNT     		 	Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		     	Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>