	<!--********************************************************
	* @source      : idta030.jsp							*
	* @description : 증명서신청 PAGE 						*
	***********************************************************
	* DATE            AUTHOR        DESCRIPTION				*
	*----------------------------------------------------------------------------
	* 2016/04/28            이동훈            	ERP 이사	*
	*******************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>증명서신청</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>


	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
        var trTypeMsg = "";
        
    
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.form1.txtSTR_YMD_SHR.value;
			var END_YMD_SHR = document.form1.txtEND_YMD_SHR.value;
			var CEF_SEC_SHR = document.form1.cmbCEF_SEC_SHR.value;
			var CEF_STS_SHR = document.form1.cmbCEF_STS_SHR.value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;

            if(ENO_NO_SHR == "") {
                alert("사번이 비어 있습니다. 사번을 입력해 주세요.");
                document.getElementById("txtENO_NO_SHR").focus();
                return;
            }

			dsT_ID_CEFBOOK.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&CEF_STS_SHR="+CEF_STS_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			//prompt(this,dsT_ID_CEFBOOK.DataId);
			dsT_ID_CEFBOOK.reset();
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
        function fnc_Save(sts) {

            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //용도

            //이미 직접출력으로 처리가 되어 있다면 더이상 인쇄를 못하게 막음
            if(CEF_STS == "F"
                    && dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'SPL_YMD') != "") {
                alert("더이상 출력 하실 수 없습니다.\n신규 신청 후 사용 하십시요.");
                return;
            }

            if((CEF_RSN == "19") && (document.getElementById("txtREMARK").value.trim() == '')){
               alert("비고란에 기타 신청 사유를 입력하세요.");
               document.getElementById("txtREMARK").focus();
               return;
            }

            //직접 출력을 하면서 버튼을 막아 버림
            if(CEF_STS == "F")
                fnc_HiddenElement("btnF");      //직접출력

            //출입국 출력을 하면서 버튼을 막아 버림
            if(CEF_STS == "I")
                fnc_HiddenElement("btnI");      //출입국출력

            if(sts == "F" &&  CEF_SEC == "03") {
                alert("재직증명서(학교제출용), 퇴직증명서는 직접 출력을 하실 수 없습니다.");
                return;
            }

			dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'CEF_STS') = sts;

			if(sts == "F" || sts == "E" || sts == "G" || sts == "H"|| sts == "I"){
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition,'SPL_YMD') = gcurdate;
			}

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

            //결과 메세지를 출력 하기 위해
            if(sts == "A")
                trTypeMsg = "저장"
            else if(sts == "B")
                trTypeMsg = "인사팀신청"
            else if(sts == "F" || sts == "G" || sts == "H")
                trTypeMsg = "직접출력"
            else if(sts == "I")
                trTypeMsg = "출입국증명"


            //저장한 사람으로 리스트를 가지고 오기
            document.getElementById("txtENO_NO_SHR").value = dsT_ID_CEFBOOK.NameString(dsT_ID_CEFBOOK.RowPosition, "ENO_NO");
            document.getElementById("txtENO_NM_SHR").value = dsT_ID_CEFBOOK.NameString(dsT_ID_CEFBOOK.RowPosition, "ENO_NM");

			// save
			trT_ID_CEFBOOK.KeyValue = "tr01(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
			trT_ID_CEFBOOK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SAV";
			trT_ID_CEFBOOK.post();

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
        function fnc_Print1() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var eno_no = document.getElementById('txtENO_NO').value;

            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }

        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }

        	//회사 주소 선택. 기본은 1.서울주소 
			if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
			
			
			//선택된 ROW를 복사하여 dsT_ID_CEFBOOK_PRINT 넘겨준다.
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			
			gcrp_print1.Preview();

        }

        function fnc_Print2() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var eno_no = document.getElementById('txtENO_NO').value;

            if(CEF_STS != "E" && CEF_STS != "G") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }

        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }
        	
        	//회사 주소 선택. 기본은 1.서울주소 
			if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}

			//선택된 ROW를 dsT_EV_DUTYRSH_CP에 복사하여 Modal창에 dsT_EV_DUTYRSH_CP를 넘겨준다.
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print2.Preview();

        }

        function fnc_Print3() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var eno_no = document.getElementById('txtENO_NO').value;

            if(CEF_STS != "E" && CEF_STS != "H") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }

        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }
			
        	//회사 주소 선택. 기본은 1.서울주소 
			if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
        	
			//선택된 ROW를 dsT_EV_DUTYRSH_CP에 복사하여 Modal창에 dsT_EV_DUTYRSH_CP를 넘겨준다.
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print3.Preview();

        }

        function fnc_Print4() {

            if(dsT_ID_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var eno_no = document.getElementById('txtENO_NO').value;

            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }

        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }
			
        	//회사 주소 선택. 기본은 1.서울주소 
			if (document.getElementById("rdoCOM_ADD").CodeValue == "01"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "1";
				
			}else if(document.getElementById("rdoCOM_ADD").CodeValue == "02"){
				
				dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "DRV_TAG") = "2";
				
			}
        	
			//선택된 ROW를 dsT_EV_DUTYRSH_CP에 복사하여 Modal창에 dsT_EV_DUTYRSH_CP를 넘겨준다.
			cfCopyDataSet(dsT_ID_CEFBOOK, dsT_ID_CEFBOOK_PRINT, "copyHeader=yes,rowFrom="+dsT_ID_CEFBOOK.RowPosition+",rowCnt=1");

			gcrp_print4.Preview();

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_ID_CEFBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ID_CEFBOOK.GridToExcel("증명서신청", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			
			if (dsT_ID_CEFBOOK.CountColumn == 0) {
				dsT_ID_CEFBOOK.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, ENO_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, PER_ADR:STRING, ADDRESS:STRING, CEF_SEC:STRING, CEF_CNT:STRING, CEF_RSN:STRING, CEF_STS:STRING, CEF_STS_NM:STRING, REQ_YMD:STRING, CEF_NO:STRING, SPL_YMD:STRING, PRT_YMD:STRING, REMARK:STRING, STR_YMD:STRING, END_YMD:STRING, CITY:STRING");
			}

			
            for(var i=1; i<=dsT_ID_CEFBOOK.CountRow; i++) {
            	
                if(dsT_ID_CEFBOOK.RowStatus(i) == "1") {
                    alert("이미 신규신청건이 있습니다. 저장 후 사용하세요.");
                    return;
                }
                
            }

			// 행 추가
			dsT_ID_CEFBOOK.AddRow();


			
            //사원 정보 찾아와서 넣기
            document.getElementById("txtENO_NO").value = document.getElementById("txtENO_NO_SHR").value;
          
            fnc_SearchEmpNo();

			
			document.form1.cmbCEF_RSN.selectedIndex = 0;
			
            dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_YMD") = gcurdate;
            dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS") = "A";
            dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS_NM") = "신규";
            dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_SEC") = "01";
            

            
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
			if (dsT_ID_CEFBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
                // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
                var CEF_STS = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_STS");

                //저장과 신청 상태 일때만 삭제가 가능
                if(!(CEF_STS == "A" || CEF_STS == 'B')) {
                    alert("상태가 저장이거나 신청일때만 삭제가 가능합니다.");
                    return;
                }

           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "등록번호 = "+dsT_ID_CEFBOOK.nameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO")+"\n";
            	tmpMSG += "사번       = "+dsT_ID_CEFBOOK.nameValue(dsT_ID_CEFBOOK.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "성명       = "+dsT_ID_CEFBOOK.nameValue(dsT_ID_CEFBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "증명서    = "+dsT_ID_CEFBOOK.nameValue(dsT_ID_CEFBOOK.RowPosition, "CEF_RSN")+"\n";

	            if( confirm(tmpMSG) ){
					var REQ_NO = dsT_ID_CEFBOOK.nameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");

					dsT_ID_CEFBOOK.DeleteRow(dsT_ID_CEFBOOK.RowPosition);

                    //결과 메세지를 뿌리기 위해
                    trTypeMsg = "삭제";

					// 파라미터 추가
					trT_ID_CEFBOOK_DEL.Parameters = "REQ_NO="+REQ_NO;

					trT_ID_CEFBOOK_DEL.KeyValue = "tr01(I:dsT_ID_CEFBOOK=dsT_ID_CEFBOOK)";
					trT_ID_CEFBOOK_DEL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=DEL";
					trT_ID_CEFBOOK_DEL.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

            document.getElementById("txtCEF_CNT").value = "";
            document.getElementById("cmbCEF_SEC_SHR").selectedIndex = 0;
            document.getElementById("cmbCEF_STS_SHR").selectedIndex = 0;
            document.getElementById("cmbCEF_RSN").selectedIndex = 0;
            document.getElementById("rdoCEF_SEC").CodeValue = "10";
            document.getElementById("hidPRT_YMD").value = "";

        	document.getElementById("resultMessage").innerText = ' ';
        	fnc_DisableElementAll(elementList);

        	dsT_ID_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			
			if (dsT_ID_CEFBOOK.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
        	window.close();
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
  			if ( !dsT_ID_CEFBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            for(var i=1; i<=dsT_ID_CEFBOOK.CountRow; i++) {
                if(dsT_ID_CEFBOOK.NameString(i, "CEF_CNT") == 0) {
                    alert("매수입력은 필수 입력사항입니다.");
                    dsT_ID_CEFBOOK.RowPosition == i;

                    document.getElementById("txtCEF_CNT").focus();
                    return false;
                }
            }

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	

            // 용도 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_R4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_R4.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_R4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_RSN").add(oOption);
			}
			
			
            // 증명서 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_R3.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_R3.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_R3.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_SEC_SHR").add(oOption);
			}

			
			fnc_DisableElementAll(elementList);

            fnc_HiddenElement("btnA");      //저장
            fnc_HiddenElement("btnB");      //인재지원부신청
            fnc_HiddenElement("btnF");      //직접출력
            fnc_HiddenElement("btnG");      //직접출력
            fnc_HiddenElement("btnH");      //직접출력
            fnc_HiddenElement("btnI");      //직접출력

            cfStyleGrid_New(form1.grdT_ID_CEFBOOK,15,"false","false");      // Grid Style 적용
            
            document.getElementById("txtENO_NO_SHR").value = gusrid;  
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

            document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = gcurdate;

            fnc_ChangeStateElement(true, "ImgEnoNoShr");
            fnc_ChangeStateElement(true, "txtENO_NO_SHR");
            fnc_ChangeStateElement(true, "txtENO_NM_SHR");
            
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001"){ 

	            fnc_ChangeStateElement(false, "ImgEnoNoShr");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            
			}

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

        //입력 element들
        var elementList = new Array(     "txtHIR_CNT"
                                        ,"txtEXP_CNT"
                                        ,"txtRET_CNT"
                                        ,"txtCAR_CNT"
                                        ,"txtREMARK"
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"cmbCEF_RSN"
                                        ,"btnPrintCef"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
        	
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
        	
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');

            if(obj != null && obj.eno_no != "") {
        	
                dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+obj.eno_no;
                dsVI_T_PERSON.reset();
                
            } else {
       	
                document.getElementById("txtENO_NO" ).value = "";
                document.getElementById("txtENO_NM" ).value = "";
                document.getElementById("txtPER_ADR").value = "";
                document.getElementById("txtADDRESS").value = "";
                document.getElementById("hidDPT_CD" ).value = "";
                document.getElementById("txtDPT_NM" ).value = "";
                document.getElementById("hidJOB_CD" ).value = "";
                document.getElementById("txtJOB_NM" ).value = "";
                document.getElementById("hidRET_YMD" ).value = "";
                
            }
        }



        /********************************************
         * 기타 함수                                *
         ********************************************/

         //재직증병서 발급부수가 0이 아닐때
        //퇴직자는 재직증명서를 출력할 수 없음

         function fnc_chkCef() {

            var ret_ymd = document.getElementById("hidRET_YMD").value;

           }


         //퇴직자는 재직증명서를 출력할 수 없다는 메세지 뿌려줌
         //다른 증명서를 클릭했다가
         //다시 재직증명서로 갈때

            function fnc_SelChange() {

				if(document.getElementById("rdoCEF_SEC").CodeValue == "04"){
					document.getElementById("eng_div").style.display = "";
				}else{
					document.getElementById("eng_div").style.display = "none";
				}

				var ret_ymd = document.getElementById("hidRET_YMD").value;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_ID_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"		Value="False">
	</Object>

	<Object ID="dsT_ID_CEFBOOK_UPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"		Value="False">
	</Object>

	<Object ID="dsT_ID_CEFBOOK_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"		Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)							       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 				Value="True">
		<Param Name="UseChangeInfo" 		Value="True">
		<Param Name="ViewDeletedRow" 	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_ID_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<Object ID="trT_ID_CEFBOOK_DEL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 용도 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 증명서 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R3"/>
       <jsp:param name="CODE_GUBUN"    value="R3"/>
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
	<Script For=dsT_ID_CEFBOOK Event="OnLoadCompleted(iCount)">

	
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_ID_CEFBOOK.CountRow);
        }
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">

		if (iCount == 0)    {
			alert("해당사원의 정보가 없습니다.");
		} else {
			// 사원정보 입력 후 추가사항 입력 가능하게 처리

			// 사원 정보 매핑
			document.getElementById("txtENO_NO" ).value =   dsVI_T_PERSON.NameValue(0,"ENO_NO");
			document.getElementById("txtENO_NM" ).value =   dsVI_T_PERSON.NameValue(0,"ENO_NM");
			document.getElementById("txtPER_ADR").value =   dsVI_T_PERSON.NameValue(0,"PER_ADR");
			document.getElementById("txtADDRESS").value =   dsVI_T_PERSON.NameValue(0,"ADDRESS");
			document.getElementById("hidDPT_CD" ).value =   dsVI_T_PERSON.NameValue(0,"DPT_CD");
			document.getElementById("txtDPT_NM" ).value =   dsVI_T_PERSON.NameValue(0,"DPT_NM");
            document.getElementById("hidJOB_CD" ).value =   dsVI_T_PERSON.NameValue(0,"JOB_CD");
			document.getElementById("txtJOB_NM" ).value =   dsVI_T_PERSON.NameValue(0,"JOB_NM");
			document.getElementById("hidRET_YMD" ).value =   dsVI_T_PERSON.NameValue(0,"RET_YMD");
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnSuccess()">

        var REQ_NO = dsT_ID_CEFBOOK.NameValue(dsT_ID_CEFBOOK.RowPosition, "REQ_NO");
        var CEF_STS;
        var CEF_SEC;
        var rowIndex;

        fnc_SearchList();

        //입력한 신청번호를 가지는 Row로 이동
        rowIndex = dsT_ID_CEFBOOK.NameValueRow("REQ_NO", REQ_NO);

        if(rowIndex > 0) {
            dsT_ID_CEFBOOK.RowPosition = rowIndex;
            CEF_STS = dsT_ID_CEFBOOK.NameValue(rowIndex, "CEF_STS");
            CEF_SEC = dsT_ID_CEFBOOK.NameValue(rowIndex, "CEF_SEC");
        }

        //메세지 뿌리기
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

        if(trTypeMsg == "저장")
            //alert("* 자료가 저장되었습니다.\n인사팀 신청과 직접출력 중 하나를 선택하시기 바랍니다.\n직접출력시 회사직인과 담당자인은 이미지 처리됩니다.");
        	alert("* 자료가 저장되었습니다.");
        else
            alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");


        //재직증명서 출력
        if(CEF_STS == "F"&& CEF_SEC == "01") {
            fnc_Print1();
        }

        //경력증명서 출력
        if(CEF_STS == "G"&& CEF_SEC == "02") {
            fnc_Print2();
        }

        //퇴직증명서 출력
        if(CEF_STS == "H"&& CEF_SEC == "03") {
            fnc_Print3();
        }

        //만약 상태값이 출입국출력이라면 그건을 출력함
        if(CEF_STS == "I" && CEF_SEC == "04") {
            fnc_Print4();
        }

    </script>

	<script for=trT_ID_CEFBOOK_DEL event="OnSuccess()">
        fnc_SearchList();

        //메세지 뿌리기
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnFail()">
        alert(trT_ID_CEFBOOK.ErrorMsg);
    </script>

	<script for=trT_ID_CEFBOOK_DEL event="OnFail()">
        alert(trT_ID_CEFBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ID_CEFBOOK event=OnRowPosChanged(row)>

        fnc_DisableElementAll(elementList);

        fnc_HiddenElement("btnA");      //저장
        fnc_HiddenElement("btnB");      //인재지원부신청
        fnc_HiddenElement("btnF");      //직접출력
        fnc_HiddenElement("btnG");      //직접출력
        fnc_HiddenElement("btnH");      //직접출력
        fnc_HiddenElement("btnI");      //출입국출력

        if(row > 0) {
            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력', 'I', '출입국출력'
            var CEF_STS = dsT_ID_CEFBOOK.NameValue(row, "CEF_STS");
            var CEF_SEC = dsT_ID_CEFBOOK.NameValue(row, "CEF_SEC");
            var ROW_STS = dsT_ID_CEFBOOK.RowStatus(row);


            
            if(CEF_STS == "A" || ROW_STS == "1") {
            	

	                fnc_EnableElementAll(elementList);
	                fnc_ShowElement("btnA");

	                if(ROW_STS != "1") {              		//신규가 아니면 인재지원부 신청과 직접출력이 가능하게
	                    fnc_ShowElement("btnB");        	//인재지원부신청
	                }

	                if(CEF_SEC == "01") {              		//재직출력
	                    fnc_ShowElement("btnB");        	//인재지원부신청
	                    fnc_ShowElement("btnF");        	//재직출력
	                    fnc_HiddenElement("btnG");        	//경력출력
	                    fnc_HiddenElement("btnH");        	//퇴직출력
	                    fnc_HiddenElement("btnI");        	//출입출력
	                }

	                if(CEF_SEC == "02") {              		//경력출력
	                    fnc_ShowElement("btnB");        	//인재지원부신청
	                    fnc_HiddenElement("btnF");        	//재직출력
	                    fnc_HiddenElement("btnG");        	//경력출력
	                    fnc_HiddenElement("btnH");        	//퇴직출력
	                    fnc_HiddenElement("btnI");        	//출입출력
	                }

	                if(CEF_SEC == "03") {              		//퇴직출력
	                    fnc_ShowElement("btnB");        	//인재지원부신청
	                    fnc_HiddenElement("btnF");        	//재직출력
	                    fnc_HiddenElement("btnG");        	//경력출력
	                    fnc_HiddenElement("btnH");        	//퇴직출력
	                    fnc_HiddenElement("btnI");        	//출입출력
	                }

	                if(CEF_SEC == "04") {              		//신규가 아니면 인재지원부 신청과 직접출력이 가능하게
	                    fnc_ShowElement("btnB");        	//인재지원부신청
	                    fnc_HiddenElement("btnF");        	//재직출력
	                    fnc_HiddenElement("btnG");        	//경력출력
	                    fnc_HiddenElement("btnH");        	//퇴직출력
	                    fnc_HiddenElement("btnI");        	//출입출력
	                }

    		
					if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2180001"){ 
					
				
		                //사원 사번 결정
		                fnc_ChangeStateElement(false, "txtENO_NO");
		                fnc_ChangeStateElement(false, "txtENO_NM");
		                fnc_ChangeStateElement(false, "ImgEnoNo");
		
					} else {
						
		                //입력일때만 사번 수정 가능하게
		                if(ROW_STS != "1") {
		                    fnc_ChangeStateElement(false, "txtENO_NO");
		                    fnc_ChangeStateElement(false, "txtENO_NM");
		                    fnc_ChangeStateElement(false, "ImgEnoNo");
		           		}				
	
	            	}

            }

        }

    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_ID_CEFBOOK event=CanRowPosChange(row)>
	
		if ( dsT_ID_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_ID_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			//return false;
		}
		
	</script>

	<!-- 기타 -->
	<script language=JavaScript for=rdoCEF_SEC event=OnSelChange()>
		fnc_SelChange();
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->
<!-- 
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
-->



<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- 캘린더 프레임 -->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>


	<!-- form 시작 -->
	<form name="form1">

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="55"></col>
					<col width="220"></col>
					<col width="40"></col>
					<col width="120"></col>
                    <col width="55"></col>
                    <col width="70"></col>
					<col width="40"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">신청기간</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','134','108');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a> -->
						~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
						<!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','248','108');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a> -->
					</td>
					<td class="searchState" align="right" rowspan="2">증명서</td>
					<td class="padding2423" align="left" rowspan="2">
						<select id="cmbCEF_SEC_SHR" style="WIDTH: 120px" onChange="fnc_SearchList()">
							<option value="0">모두</option>
						</select>
					</td>
					<td class="searchState" align="right">조회조건</td>
					<td class="padding2423" align="left">
						<select id="cmbCEF_STS_SHR" style="WIDTH: 70px" onChange="fnc_SearchList()">
							<option value="0">모두</option>
							<option value="A">저장</option>
							<option value="B">신청</option>
							<option value="C">반송</option>
							<option value="E">발급</option>
							<option value="F">직접출력</option>
						</select>
					</td>
                    <td align="right" class="searchState">사번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="8" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<colgroup>
		<col width="398"></col>
		<col width="4"></col>
		<col width="398"></col>
	</colgroup>
	<tr>
		<td colspan="3" >
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td align="right" height="20">
                <img src="../../images/button/btn_SaveOn.gif" name="btnA" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('A');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnA','','../../images/button/btn_SaveOver.gif',1)">
                <img src="../../images/button/btn_ApplyOn.gif" name="btnB" border="0" align="absmiddle" onClick="fnc_Save('B');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnB','','../../images/button/btn_ApplyOver.gif',1)">
                <img src="../../images/button/btn_DirectPrintOn.gif" name="btnF" border="0" align="absmiddle" onClick="fnc_Save('F');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnF','','../../images/button/btn_DirectPrintOver.gif',1)">
                <img src="../../images/button/btn_DirectPrintOn.gif" name="btnG" border="0" align="absmiddle" onClick="fnc_Save('G');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnG','','../../images/button/btn_DirectPrintOver.gif',1)">
                <img src="../../images/button/btn_DirectPrintOn.gif" name="btnH" border="0" align="absmiddle" onClick="fnc_Save('H');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnH','','../../images/button/btn_DirectPrintOver.gif',1)">
                <img src="../../images/button/btn_DirectPrintOn.gif" name="btnI" border="0" align="absmiddle" onClick="fnc_Save('I');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnI','','../../images/button/btn_DirectPrintOver.gif',1)">
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3" >
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="180"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">신청번호</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">사번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
            </td>
			<td align="center" class="blueBold">직위</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="blueBold">부서</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">주소</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtADDRESS" style="ime-mode:disabled;width:100%;"  class="input_ReadOnly" readonly>
		        <input type="hidden" id="hidPRT_YMD">
			</td>
			<td align="center" class="blueBold"></td>
			<td class="padding2423" align="left" colspan="3">
        	</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="140"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">증명서<br>종류</td>
			<td class="padding2423" align="left" colspan="3">
                <comment id="__NSID__">
                    <object id="rdoCEF_SEC" classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^재직증명서,02^경력증명서,03^퇴직증명서,04^출입국증명서" >
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">발급부수</td>
			<td class="padding2423" colspan="3">
				<input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled"onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onchange="fnc_chkCef()">
                <input type="hidden" id="hidRET_YMD">
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">용도</td>
			<td class="padding2423" colspan="3">
				<select id="cmbCEF_RSN" style="width:50%"></select>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">비고</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">상태</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">신청일자</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="blueBold">발급번호</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="blueBold">발급일자</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		</tr>
		
		<tr>
			<td align="center" class="blueBold">회사주소</td>
			<td class="padding2423" align="left" colspan="3">
                <comment id="__NSID__">
                    <object id="rdoCOM_ADD" classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:300;height:50;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^서울시 종로구 율곡로 194,02^강원도 고성군 현내면 화진포서길 10" >
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>			
		
	
		
		</table>

		<div id="eng_div" style="DISPLAY:none">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="200"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">부임기간</td>
			<td class="padding2423" align="left" >
				<input id="txtSTR_YMD_CON" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_CON','txtSTR_YMD_CON','txtEND_YMD_CON'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">  ~
				<input id="txtEND_YMD_CON" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_CON','txtSTR_YMD_CON','txtEND_YMD_CON'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			</td>
			<td align="center" class="blueBold">부임지</td>
			<td class="padding2423" align="left" >
				<input type="text" id="txtCON_NM" size="8" maxlength="8" >
        	</td>
		</tr>
		
	
		
		
		</table>
		</div>
		</td>

		<td>&nbsp;</td>
		<td class="paddingTop5">
		<table width="100%" height="201px" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse; vertical-align:top;" bordercolor="#999999" class="table_cream">
		<tr><td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="300"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td colspan="2">[신청서 사용법 - 아래의 순서대로 작업하세요]<br>
			&nbsp;&nbsp;1. 신규버튼을 누른 후 증명서 종류를 선택하세요.<br>
			&nbsp;&nbsp;2. 신청한 증명서의 매수를 입력하고 신청용도를 선택하세요.<br>
			&nbsp;&nbsp;3. 저장 후 인재지원팀 신청 또는 직접출력을 선택하십시요.
			</td>
		</tr>
			<tr>
				<td colspan="2">※ 직접출력에 관한 공지</td>
			</tr>
			<tr>
				<td colspan="2">-&nbsp;재직증명서만 [직접출력]이 가능하오니
                    <br>&nbsp;&nbsp;다른 증명서는[인사팀]를 선택하시기 바랍니다.
					<br>-&nbsp;[직접출력]을 선택할 시에는 본인이 직접 증명서를 출력할 수
					<br>&nbsp;&nbsp;있으나 직인과 담당자인은 이미지 처리됩니다.
				</td>
			</tr>
			</table>
		</td>
		</tr>
		</table>
		</td>
	</tr>

	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ID_CEFBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:200px;">
						<param name="DataID" value="dsT_ID_CEFBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
							<C> id="REQ_NO"		width=100	name="신청번호"		align=center	Edit=none	 </C>
							<C> id="CEF_SEC"	width=150	name="증명서종류"	align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_R3:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_CNT"	width=50	name="매수"			align=center	Edit=none	 </C>
							<C> id="CEF_RSN"	width=200	name="용도"			align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_R4:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_STS_NM" width=80	name="상태"			align=center	Edit=none	</C>
							<C> id="REQ_YMD"	width=100	name="신청일자"		align=center	Edit=none	 </C>
							<C> id="CEF_NO"		width=150	name="발급번호"		align=center	Edit=none	 </C>
							<C> id="SPL_YMD"	width=100	name="발급일자"		align=center	Edit=none	 </C>
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

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 재 직  증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print1  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=320 ,right=1945 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=844 ,right=1945 ,bottom=1016 ,border=true</X>
	<X>left=37 ,top=1180 ,right=1945 ,bottom=1352 ,border=true</X>
	<X>left=37 ,top=505 ,right=1945 ,bottom=677 ,border=true</X>
	<X>left=37 ,top=675 ,right=1945 ,bottom=847 ,border=true</X>
	<X>left=37 ,top=1011 ,right=1945 ,bottom=1183 ,border=true</X>
	<X>left=37 ,top=2188 ,right=362 ,bottom=2656 ,border=true</X>
	<L> left=323 ,top=323 ,right=323 ,bottom=1349 </L>
	<L> left=1310 ,top=508 ,right=1310 ,bottom=847 </L>
	<L> left=984 ,top=505 ,right=984 ,bottom=841 </L>
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1220 ,bottom=2757</I>
	<L> left=693 ,top=246 ,right=1291 ,bottom=246 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=37 ,top=320 ,right=37 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=320 ,right=1942 ,bottom=320 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=2656 ,right=1942 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=320 ,right=1945 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=37 ,top=320 ,right=37 ,bottom=2656 </L>
	<L> left=1942 ,top=320 ,right=1942 ,bottom=2656 </L>
	<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
	<L> left=40 ,top=2466 ,right=360 ,bottom=2466 </L>
	<L> left=37 ,top=2275 ,right=362 ,bottom=2275 </L>
	<C>id='CEF_NO', left=37, top=241, right=505, bottom=307, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS', left=344, top=384, right=1921, bottom=450, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=344, top=725, right=976, bottom=791, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HIR_YMD', left=344, top=1061, right=1921, bottom=1127, align='left' ,mask='XXXX년 XX월 XX일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='재 직 증 명 서' ,left=24 ,top=90 ,right=1958 ,bottom=238 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=995 ,top=720 ,right=1307 ,bottom=783 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직     위' ,left=995 ,top=553 ,right=1307 ,bottom=619 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2199 ,right=333 ,bottom=2265 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2487 ,right=119 ,bottom=2548 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2577 ,right=119 ,bottom=2638 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2402 ,right=119 ,bottom=2455 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2347 ,right=119 ,bottom=2397 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2286 ,right=119 ,bottom=2342 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주     소' ,left=48 ,top=378 ,right=315 ,bottom=445 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소     속' ,left=48 ,top=553 ,right=315 ,bottom=619 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성     명' ,left=48 ,top=720 ,right=315 ,bottom=783 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='용     도' ,left=48 ,top=886 ,right=315 ,bottom=953 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입 사 일' ,left=48 ,top=1061 ,right=315 ,bottom=1127 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상기 사실을 증명함.' ,left=344 ,top=1397 ,right=1934 ,bottom=1458 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SPL_YMD2', left=1320, top=2024, right=1818, bottom=2093, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<I>id='../../images/common/1.jpg' ,left=143 ,top=2291 ,right=328 ,bottom=2455</I>
	<I>id='../../images/common/2.jpg' ,left=143 ,top=2477 ,right=328 ,bottom=2641</I>
	<T>id='비     고' ,left=48 ,top=1228 ,right=315 ,bottom=1294 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<C>id='DPT_NM', left=344, top=558, right=974, bottom=624, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CET_NO', left=1334, top=725, right=1926, bottom=788, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1334, top=556, right=1926, bottom=622, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CEF_RSN_NM', left=344, top=894, right=1921, bottom=958, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=344, top=1201, right=1921, bottom=1331, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>



">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 경 력 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print2  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2614 ,right=1220 ,bottom=2712</I>
	<X>left=37 ,top=270 ,right=1942 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2135 ,right=362 ,bottom=2606 ,border=true</X>
	<X>left=37 ,top=1302 ,right=1942 ,bottom=1302 ,border=true</X>
	<X>left=37 ,top=1130 ,right=1942 ,bottom=1304 ,border=true</X>
	<X>left=37 ,top=963 ,right=1942 ,bottom=1135 ,border=true</X>
	<X>left=37 ,top=794 ,right=1942 ,bottom=966 ,border=true</X>
	<X>left=37 ,top=455 ,right=1942 ,bottom=627 ,border=true</X>
	<X>left=37 ,top=624 ,right=1942 ,bottom=796 ,border=true</X>
	<L> left=37 ,top=270 ,right=37 ,bottom=2601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=270 ,right=1939 ,bottom=270 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=2606 ,right=1939 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1942 ,top=270 ,right=1942 ,bottom=2601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=984 ,top=455 ,right=984 ,bottom=796 </L>
	<L> left=1275 ,top=455 ,right=1275 ,bottom=796 </L>
	<L> left=37 ,top=270 ,right=37 ,bottom=2606 </L>
	<L> left=1939 ,top=270 ,right=1939 ,bottom=2606 </L>
	<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
	<L> left=42 ,top=2416 ,right=357 ,bottom=2416 </L>
	<L> left=37 ,top=2225 ,right=355 ,bottom=2225 </L>
	<C>id='CERTINO', left=37, top=191, right=601, bottom=257, align='left' ,mask='제 XXXX - XXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD2', left=1320, top=1974, right=1818, bottom=2043, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=696 ,top=198 ,right=1291 ,bottom=198 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='경 력 증 명 서' ,left=24 ,top=42 ,right=1958 ,bottom=188 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2148 ,right=333 ,bottom=2215 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2437 ,right=119 ,bottom=2498 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2529 ,right=119 ,bottom=2588 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2352 ,right=119 ,bottom=2405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2297 ,right=119 ,bottom=2347 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2236 ,right=119 ,bottom=2291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	    <C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<C>id='CERETC', left=344, top=1193, right=1921, bottom=1259, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='비     고' ,left=45 ,top=1188 ,right=320 ,bottom=1254 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENDDT', left=1294, top=1024, right=1926, bottom=1090, align='left' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='퇴사일' ,left=987 ,top=1024 ,right=1275 ,bottom=1090 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='STRTDT', left=344, top=1024, right=974, bottom=1090, align='left' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='입 사 일' ,left=45 ,top=1021 ,right=320 ,bottom=1087 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CERUSE', left=344, top=860, right=1921, bottom=926, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='용     도' ,left=45 ,top=852 ,right=320 ,bottom=918 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1294, top=685, right=1926, bottom=751, align='left' ,mask='XXXXXX - XXXXXXX', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=987 ,top=685 ,right=1275 ,bottom=751 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNMK', left=344, top=685, right=974, bottom=751, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성     명' ,left=45 ,top=677 ,right=320 ,bottom=743 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYGNM', left=1294, top=516, right=1926, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직     위' ,left=987 ,top=516 ,right=1275 ,bottom=582 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DEPTNM', left=344, top=516, right=974, bottom=582, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소     속' ,left=45 ,top=511 ,right=320 ,bottom=574 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CADDR', left=344, top=349, right=1921, bottom=415, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주     소' ,left=45 ,top=344 ,right=320 ,bottom=410 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENDDT', left=42, top=1344, right=1937, bottom=1410 ,mask='상기자는 XXXX년 XX월 XX일부로 당사 퇴직하였음을 증명함.', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=320 ,top=273 ,right=320 ,bottom=1304 </L>
	<L> left=984 ,top=963 ,right=984 ,bottom=1135 </L>
	<L> left=1275 ,top=968 ,right=1275 ,bottom=1135 </L>
</B>


">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 퇴 직 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print3  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=270 ,right=1945 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=794 ,right=1945 ,bottom=966 ,border=true</X>
	<X>left=37 ,top=2138 ,right=362 ,bottom=2606 ,border=true</X>
	<X>left=37 ,top=1130 ,right=1945 ,bottom=1307 ,border=true</X>
	<X>left=37 ,top=455 ,right=1945 ,bottom=627 ,border=true</X>
	<L> left=37 ,top=270 ,right=37 ,bottom=2604 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=270 ,right=1942 ,bottom=270 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=2606 ,right=1942 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=270 ,right=1945 ,bottom=2604 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=37 ,top=270 ,right=37 ,bottom=2606 </L>
	<L> left=1942 ,top=270 ,right=1942 ,bottom=2606 </L>
	<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
	<L> left=40 ,top=2416 ,right=360 ,bottom=2416 </L>
	<L> left=37 ,top=2225 ,right=357 ,bottom=2225 </L>
	<C>id='CERTINO', left=37, top=191, right=601, bottom=257, align='left' ,mask='제 XXXX - XXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=37 ,top=963 ,right=1945 ,bottom=1135 ,border=true</X>
	<C>id='SPL_YMD2', left=1320, top=1974, right=1818, bottom=2045, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=693 ,top=196 ,right=1291 ,bottom=196 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='퇴 직 증 명 서' ,left=24 ,top=40 ,right=1958 ,bottom=188 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2151 ,right=333 ,bottom=2217 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2437 ,right=119 ,bottom=2498 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2527 ,right=119 ,bottom=2588 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2352 ,right=119 ,bottom=2405 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2297 ,right=119 ,bottom=2347 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2236 ,right=119 ,bottom=2291 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<L> left=1294 ,top=458 ,right=1294 ,bottom=796 </L>
	<L> left=984 ,top=458 ,right=984 ,bottom=796 </L>
	<L> left=984 ,top=968 ,right=984 ,bottom=1135 </L>
	<L> left=1289 ,top=966 ,right=1289 ,bottom=1132 </L>
	<L> left=323 ,top=273 ,right=323 ,bottom=1304 </L>
	<C>id='PAYGNM', left=1294, top=513, right=1926, bottom=579, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직     위' ,left=987 ,top=513 ,right=1275 ,bottom=579 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='생년월일' ,left=987 ,top=683 ,right=1275 ,bottom=749 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='RESINO', left=1294, top=683, right=1926, bottom=749, align='left' ,mask='XXXXXX - XXXXXXX', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=1294, top=1021, right=1926, bottom=1087, align='left' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='퇴사일' ,left=987 ,top=1021 ,right=1275 ,bottom=1087 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='STRTDT', left=344, top=1021, right=976, bottom=1087, align='left' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CERUSE', left=344, top=857, right=1921, bottom=923, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=344, top=683, right=976, bottom=749, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=344, top=513, right=976, bottom=579, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소     속' ,left=45 ,top=508 ,right=320 ,bottom=572 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성     명' ,left=45 ,top=675 ,right=320 ,bottom=741 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='용     도' ,left=45 ,top=849 ,right=320 ,bottom=915 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='입 사 일' ,left=45 ,top=1016 ,right=320 ,bottom=1082 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비     고' ,left=45 ,top=1185 ,right=320 ,bottom=1251 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CERETC', left=344, top=1191, right=1921, bottom=1257, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=40, top=1341, right=1937, bottom=1408 ,mask='상기자는 XXXX년 XX월 XX일부로 당사 퇴직하였음을 증명함.', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CADDR', left=344, top=341, right=1921, bottom=407, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주     소' ,left=45 ,top=336 ,right=320 ,bottom=402 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### 출 국 (확인) 증 명 서 ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print4  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"			VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_ID_CEFBOOK_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"				VALUE="0">
	<PARAM NAME="PaperSize"				VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=37 ,top=320 ,right=1945 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2188 ,right=362 ,bottom=2656 ,border=true</X>
	<X>left=37 ,top=1180 ,right=1945 ,bottom=1352 ,border=true</X>
	<X>left=37 ,top=844 ,right=1945 ,bottom=1016 ,border=true</X>
	<X>left=37 ,top=675 ,right=1945 ,bottom=847 ,border=true</X>
	<X>left=37 ,top=505 ,right=1945 ,bottom=677 ,border=true</X>
	<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1220 ,bottom=2754</I>
	<L> left=37 ,top=320 ,right=37 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=320 ,right=1942 ,bottom=320 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=2656 ,right=1942 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1945 ,top=320 ,right=1945 ,bottom=2654 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=37 ,top=320 ,right=37 ,bottom=2656 </L>
	<L> left=1942 ,top=320 ,right=1942 ,bottom=2656 </L>
	<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
	<L> left=40 ,top=2466 ,right=360 ,bottom=2466 </L>
	<L> left=37 ,top=2275 ,right=362 ,bottom=2275 </L>
	<T>id='출 국 (확인) 증 명 서' ,left=24 ,top=90 ,right=1958 ,bottom=238 ,face='HY견고딕' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확   인' ,left=64 ,top=2199 ,right=333 ,bottom=2265 ,face='굴림' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담' ,left=45 ,top=2487 ,right=119 ,bottom=2548 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당' ,left=45 ,top=2577 ,right=119 ,bottom=2638 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=45 ,top=2402 ,right=119 ,bottom=2455 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=45 ,top=2347 ,right=119 ,bottom=2397 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확' ,left=45 ,top=2286 ,right=119 ,bottom=2342 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DRV_TAG,1,\'서울시 종로구 율곡로 194\',2,\'강원도 고성군 현내면 화진포서길 10\',\'서울시 종로구 율곡로 194\')}' ,left=1101 ,top=2225 ,right=1900 ,bottom=2323 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</C>
	<T>id='현 대 아 산 주 식 회 사' ,left=1101 ,top=2336 ,right=1839 ,bottom=2434 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대 표 이 사    이 백 훈' ,left=1101 ,top=2445 ,right=1839 ,bottom=2543 ,align='left' ,face='HY견고딕' ,size=14 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/new_attampt1.gif' ,left=1582 ,top=2281 ,right=1886 ,bottom=2572</I>
	<I>id='../../images/common/icon.jpg' ,left=741 ,top=2699 ,right=1220 ,bottom=2799</I>
	<X>left=37 ,top=1011 ,right=1945 ,bottom=1183 ,border=true</X>
	<L> left=537 ,top=241 ,right=1437 ,bottom=241 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='CEF_NO', left=37, top=241, right=505, bottom=307, align='left' ,mask='제 XXXXXXXXX 호', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPL_YMD2', left=1320, top=2024, right=1818, bottom=2093, align='right' ,mask='XXXX년 XX월 XX일 ', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=323 ,top=323 ,right=323 ,bottom=1355 </L>
	<L> left=1310 ,top=508 ,right=1310 ,bottom=847 </L>
	<L> left=984 ,top=505 ,right=984 ,bottom=841 </L>
	<T>id='상기와 같이 출국 하였음을 증명함.' ,left=344 ,top=1389 ,right=1934 ,bottom=1484 ,align='left' ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CEF_RSN_NM', left=344, top=1244, right=1921, bottom=1310, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='용     도' ,left=48 ,top=1238 ,right=315 ,bottom=1304 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='END_YMD', left=743, top=1074, right=1225, bottom=1140, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STR_YMD', left=344, top=1074, right=725, bottom=1140, align='left' ,mask='XXXXXXXXXX  ~', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부임기간' ,left=48 ,top=1069 ,right=315 ,bottom=1135 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CITY', left=344, top=902, right=1921, bottom=968, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='부 임 지' ,left=48 ,top=902 ,right=315 ,bottom=968 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성     명' ,left=48 ,top=728 ,right=315 ,bottom=794 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=344, top=736, right=976, bottom=799, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=995 ,top=736 ,right=1307 ,bottom=799 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CET_NO', left=1334, top=736, right=1926, bottom=799, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1334, top=566, right=1926, bottom=632, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직     위' ,left=995 ,top=566 ,right=1307 ,bottom=632 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DPT_NM', left=344, top=566, right=976, bottom=632, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소     속' ,left=48 ,top=561 ,right=315 ,bottom=624 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ADDRESS', left=344, top=400, right=1921, bottom=466, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='주     소' ,left=48 ,top=394 ,right=315 ,bottom=460 ,face='굴림' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
	
">
</OBJECT>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_ID_CEFBOOK 설정 테이블 -->
	<object id="bndT_ID_CEFBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_ID_CEFBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO			Ctrl=txtREQ_NO			Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
			<C>Col=JOB_CD			Ctrl=hidJOB_CD			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=DPT_CD			Ctrl=hidDPT_CD			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=PER_ADR			Ctrl=txtPER_ADR			Param=value</C>
			<C>Col=ADDRESS			Ctrl=txtADDRESS			Param=value</C>
			<C>Col=STR_YMD			Ctrl=txtSTR_YMD_CON	Param=value</C>
			<C>Col=END_YMD			Ctrl=txtEND_YMD_CON	Param=value</C>
			<C>Col=CITY				Ctrl=txtCON_NM			Param=value</C>
			<C>Col=CEF_RSN			Ctrl=cmbCEF_RSN		Param=value</C>
			<C>Col=REQ_YMD			Ctrl=txtREQ_YMD			Param=value</C>
			<C>Col=SPL_YMD			Ctrl=txtSPL_YMD			Param=value</C>
			<C>Col=CEF_NO			Ctrl=txtCEF_NO			Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM		Param=value</C>
			<C>Col=CEF_SEC			Ctrl=rdoCEF_SEC			Param=CodeValue</C>
			<C>Col=CEF_CNT			Ctrl=txtCEF_CNT			Param=value</C>
			<C>Col=REMARK			Ctrl=txtREMARK			Param=value</C>
            <C>Col=PRT_YMD      	Ctrl=hidPRT_YMD     		Param=value</C>
			<C>Col=RET_YMD      	Ctrl=hidRET_YMD     		Param=value</C>
		">
	</object>
	
	
	