
<!--*************************************************************************
	* @source      : taxa250.jsp												*
	* @description : 소득증명원신청 PAGE 												*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/20            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<%
	//권한이 'IT' 이거나 '경리부' 이면 관리자 권한을 가진다.
	boolean isMaster = false;
	if (box.getString("SESSION_ROLE_CD").equals("1001")
			|| box.getString("SESSION_ROLE_CD").equals("1010")) {
		isMaster = true;
	}
%>

<html>
<head>
<title>소득증명원신청(taxa250)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

<script language="javascript">

		var btnList = 'TTFTFTTT';
		var today = getToday();
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

			dsT_AC_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&CEF_STS_SHR="+CEF_STS_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_AC_CEFBOOK.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수						        *
         ********************************************/
        function fnc_Save(sts) {
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //용도


            //이미 직접출력으로 처리가 되어 있다면 더이상 인쇄를 못하게 막음
            if(CEF_STS == "F"
                    && dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') != "") {
                alert("더이상 출력 하실 수 없습니다.\n신규 신청 후 사용 하십시요.");
                return;
            }

            //직접 출력을 하면서 버튼을 막아 버림
            if(CEF_STS == "F")
                fnc_HiddenElement("btnF");      //직접출력

			dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'CEF_STS') = sts;
			if(sts == "F" || sts == "E"){
				dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition,'SPL_YMD') = today;
			}

			if ( !fnc_SaveItemCheck() ) {
				return;
			}


            //결과 메세지를 출력 하기 위해
            if(sts == "A")
                trTypeMsg = "저장"
            else if(sts == "B")
                trTypeMsg = "재경부신청"
            else if(sts == "F")
                trTypeMsg = "직접출력"

            //저장한 사람으로 리스트를 가지고 오기
            document.getElementById("txtENO_NO_SHR").value = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "ENO_NO");
            document.getElementById("txtENO_NM_SHR").value = dsT_AC_CEFBOOK.NameString(dsT_AC_CEFBOOK.RowPosition, "ENO_NM");

			// save
			trT_AC_CEFBOOK.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
			trT_AC_CEFBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SAV";
			trT_AC_CEFBOOK.post();

			fnc_ChangeStateElement(false, "txtSTR_YY");  //귀속년도 비활성화

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
            if(dsT_AC_CEFBOOK.RowPosition == "0") return;

            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");  //상태
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC");  //증명서 종류
            var CEF_CNT = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_CNT");  //발급매수
            var CEF_RSN = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN");  //발급사유
            var REQ_NO  = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");   //발급번호

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var STR_YMD  = document.getElementById("txtREQ_YMD").value;
            var STR_YY  = document.getElementById("txtSTR_YY").value;

            var STR_YM  = document.getElementById("txtCEF_YY").value;
			var DPT_CD ="";
            if(CEF_STS != "E" && CEF_STS != "F") {
                alert("상태가 발급이나 직접출력이 아니면 출력하실 수 없습니다.");
                return;
            }
        	if ( document.getElementById('txtENO_NO').value == null || document.getElementById('txtENO_NO').value == "" ) {
                alert("인쇄하실 내용이 없습니다.");
                return;
            }

			//01^근로소득원천징수 영수증,02^근로소득원천징수부,03^퇴직소득원천징수 영수증,04^갑근세원천징수증명서
			if(CEF_SEC == "01"){  //근로소득원천징수 영수증
				var url = "taxa160_PV.jsp"
	                    + "?PIS_YY="+STR_YY   //정산년도
	                    + "&ENO_NO="+ENO_NO     //사번
	                    + "&DPT_CD="+DPT_CD 		//부서코드
	                    + "&STR_YMD="+STR_YMD	//신청일자
	                    + "&CEF_CNT="+CEF_CNT
	                    + "&TYPE=E&STP_GBN=1&TAX_GBN=8&PRT_GBN=1&CHK_OCC=ALL"
	                    + "&SEND_PARM=2";

	                    //+ "&TYPE="+TYPE			//무조건 E : 사번으로 출력 한다.
	                    //+ "&STP_GBN="+STP_GBN	//직인출력 구분 : 무조건 직인출력 : 1
	                    //+ "&TAX_GBN="+TAX_GBN   //정산구분:1연말정산
	                    //+ "&PRT_GBN="+PRT_GBN   //증명서 종류(무조건 1: 소득자,발행자)
	                    //+ "&CHK_OCC="+CHK_OCC;  //근로구분구분(여기서는 무의미)
            }else if(CEF_SEC == "02"){  //근로소득 원천징수부

                var url = "taxa080_PV.jsp"
                    + "?PIS_YY="+STR_YY
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                    + "&CEF_CNT="+CEF_CNT
                    + "&TYPE=1"
                    + "&SEND_PARM=2";

            }else if(CEF_SEC == "03"){  //퇴직소득 원천징수영수증

            	var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+STR_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&STP_GBN=1"//+STP_GBN
                    + "&CEF_CNT="+CEF_CNT
                    + "&PRT_GBN=1"//+PRT_GBN;


            }else if(CEF_SEC == "04"){  //갑근세 증명서

				var url = "taxa180_PV.jsp"
                    + "?PIS_YY="+STR_YM.replace("-","")
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&DPT_CD="+DPT_CD
                     + "&CEF_CNT="+CEF_CNT
//                    + "&JOB_CD="+JOB_CD
                    + "&IS_YEAR_AMT=Y"//+IS_YEAR_AMT
                    + "&SEND_PARM=2";
                   // + "&DOC1="+DOC1
                   // + "&DOC2="+DOC2
                   // + "&DOC3="+DOC3;

            }
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_CEFBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AC_CEFBOOK.GridToExcel("소득증명원신청", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
      			if (dsT_AC_CEFBOOK.CountColumn == 0) {
				dsT_AC_CEFBOOK.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, ENO_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, PER_ADR:STRING, ADDRESS:STRING, CEF_SEC:STRING, CEF_CNT:STRING, CEF_RSN:STRING, CEF_STS:STRING, CEF_STS_NM:STRING, REQ_YMD:STRING, CEF_NO:STRING, SPL_YMD:STRING, PRT_YMD:STRING, REMARK:STRING, CEF_YY:STRING, STR_YY:STRING");
			}

            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {
                if(dsT_AC_CEFBOOK.RowStatus(i) == "1") {
                    alert("이미 신규신청건이 있습니다. 저장 후 사용하세요.");
                    return;
                }
            }

			// 행 추가
			dsT_AC_CEFBOOK.AddRow();

            //사원 정보 찾아와서 넣기
            document.getElementById("txtENO_NO").value = document.getElementById("txtENO_NO_SHR").value;
            fnc_SearchEmpNo();

			document.form1.cmbCEF_RSN.selectedIndex = 0;
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_YMD") = today;
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS") = "A";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS_NM") = "신규";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_SEC") = "01";
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_YY") = getTodayArray()[0]+"-"+getTodayArray()[1];
            dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "STR_YY") = getTodayArray()[0]-1;

            fnc_ChangeStateElement(false, "txtSTR_YY");  //귀속년도 비활성화
            //귀속년도 초기값 설정
            document.getElementById("txtSTR_YY").value = today.substring(0,4); // 2009년 12월 해제 today.substring(0,4)-1
            fnc_HiddenElement("img_spinup");//위화살표 감춤
            fnc_HiddenElement("img_spindown");//아래 화살표 감춤

            //용도가 기타일때 비고란을 활성화 함수 호출
            fnc_Searchcmb();
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
			if (dsT_AC_CEFBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
                // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
                var CEF_STS = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_STS");

                //저장과 신청 상태 일때만 삭제가 가능
                if(!(CEF_STS == "A" || CEF_STS == 'B')) {
                    alert("상태가 저장이거나 신청일때만 삭제가 가능합니다.");
                    return;
                }

           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "등록번호 = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO")+"\n";
            	tmpMSG += "사번       = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "성명       = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "증명서    = "+dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "CEF_RSN")+"\n";

	            if( confirm(tmpMSG) ){
					var REQ_NO = dsT_AC_CEFBOOK.nameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");

					dsT_AC_CEFBOOK.DeleteRow(dsT_AC_CEFBOOK.RowPosition);

                    //결과 메세지를 뿌리기 위해
                    trTypeMsg = "삭제";

					// 파라미터 추가
					trT_AC_CEFBOOK_DEL.Parameters = "REQ_NO="+REQ_NO;

					trT_AC_CEFBOOK_DEL.KeyValue = "tr01(I:dsT_AC_CEFBOOK=dsT_AC_CEFBOOK)";
					trT_AC_CEFBOOK_DEL.action = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=DEL";
					trT_AC_CEFBOOK_DEL.post();
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

        	document.getElementById("resultMessage").innerText = ' ';
        	fnc_DisableElementAll(elementList);

        	dsT_AC_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AC_CEFBOOK.IsUpdated)  {
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
  			if ( !dsT_AC_CEFBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            for(var i=1; i<=dsT_AC_CEFBOOK.CountRow; i++) {
                if(dsT_AC_CEFBOOK.NameString(i, "CEF_CNT") == 0) {
                    alert("매수입력은 필수 입력사항입니다.");
                    dsT_AC_CEFBOOK.RowPosition == i;

                    document.getElementById("txtCEF_CNT").focus();
                    return false;
                }
            }

            if(document.getElementById("rdoCEF_SEC").CodeValue == 02){
               document.getElementById("hidHIR_YMD").value = "20050701";
               var HIR_YMD = document.getElementById("hidHIR_YMD").value;

               var STR_YY = document.getElementById("txtSTR_YY").value.substring(0,4);

               if(HIR_YMD>STR_YY){
                   alert(HIR_YMD + " > "+STR_YY+"입사년도보다 작은날짜는 선택하실 수 없습니다. 취소 후 다시 선택해 주십시오.");
                   fnc_DisableElementAll(elementList);
                   fnc_HiddenElement("btnA");      //저장
                   fnc_HiddenElement("btnB");      //재경부신청
                   fnc_HiddenElement("btnF");      //직접출력
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
			for( var i = 1; i <= dsT_CM_COMMON_AC.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_AC.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_AC.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_SEC_SHR").add(oOption);
			}

			fnc_DisableElementAll(elementList);
            fnc_HiddenElement("btnA");      //저장
            fnc_HiddenElement("btnB");      //재경부신청
            fnc_HiddenElement("btnF");      //직접출력

            document.getElementById("changeDate_01").style.display = "";
            document.getElementById("changeDate_02").style.display = "none";


			cfStyleGrid(form1.grdT_AC_CEFBOOK,15,"false","false");      // Grid Style 적용


            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";
            document.getElementById("hidHIR_YMD").value = "20050701";
            alert("hidHIR_YMD = "+ document.getElementById("hidHIR_YMD").value)
            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

            //귀속년도 초기값 설정
            document.getElementById("txtSTR_YY").value = today.substring(0,4);  // 2009년 12월 해제 today.substring(0,4)-1
            fnc_HiddenElement("img_spinup");//위화살표 감춤
            fnc_HiddenElement("img_spindown");//아래 화살표 감춤

<%
    //IT 관리자나  경리 관리자 이면 사번으로 검색하고 일반유저이면 사번으로 검색못하게 막기
    if(!isMaster) {
%>
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

            document.getElementById("rdoCEF_SEC").Format = "01^근로소득원천징수영수증,02^근로소득원천징수부,04^갑근세원천징수증명서";
<%
    }
%>
            var hir_ymd = document.getElementById("hidHIR_YMD").value.substring(0,4);
            if(hir_ymd == today.substring(0,4)){
                   document.getElementById("rdoCEF_SEC").Format = "02^근로소득원천징수부,04^갑근세원천징수증명서";
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
                                   //   ,"txtREMARK"     //활성화
                                        ,"rdoCEF_SEC"
                                        ,"txtCEF_CNT"
                                        ,"cmbCEF_RSN"
                                        ,"txtCEF_YY"
                                        ,"txtSTR_YY"
                                        ,"img_spinup"
                                        ,"img_spindown"
                                        ,"btnPrintCef"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'1','');

            if(obj != null && obj.eno_no != "") {
                dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa250.cmd.TAXA250CMD&S_MODE=SHR_02&ENO_NO="+obj.eno_no;
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
                document.getElementById("hidHIR_YMD").value = "";
            }
        }


        /********************************************
         * 17. 기타함수                 			*
         ********************************************/
       //용도가 기타일때 비고란을 활성화 한다.
        function fnc_Searchcmb(){
        	if(document.getElementById("cmbCEF_RSN" ).value=='19'){
        	    fnc_ChangeStateElement(true, "txtREMARK");  //활성화
        	}
        	else{
        	    fnc_ChangeStateElement(false, "txtREMARK");  //활성화
        	}
        }

    </script>
</head>

<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AC_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_AC_CEFBOOK) 			 	   |
    +------------------------------------------------------>
<Object ID="dsT_AC_CEFBOOK"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<Object ID="dsT_AC_CEFBOOK_UPT"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>


<!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)							       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
<Object ID="dsVI_T_PERSON"
	ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" Value="True">
	<Param Name="UseChangeInfo" Value="True">
	<Param Name="ViewDeletedRow" Value="False">
</Object>

<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AC_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_AC_CEFBOOK)				   |
    +------------------------------------------------------>
<Object ID="trT_AC_CEFBOOK"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_AC_CEFBOOK_DEL"
	ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<!-- 공통 콤보를 위한 DataSet -->
<!-- 용도 구분 -->
<jsp:include page="/common/gauceDataSet.jsp" flush="true">
	<jsp:param name="DATASET_ID" value="dsT_CM_COMMON_R4" />
	<jsp:param name="CODE_GUBUN" value="R4" />
	<jsp:param name="SYNCLOAD" value="false" />
	<jsp:param name="USEFILTER" value="false" />
</jsp:include>

<!-- 증명서 구분 -->
<jsp:include page="/common/gauceDataSet.jsp" flush="true">
	<jsp:param name="DATASET_ID" value="dsT_CM_COMMON_AC" />
	<jsp:param name="CODE_GUBUN" value="AC" />
	<jsp:param name="SYNCLOAD" value="false" />
	<jsp:param name="USEFILTER" value="false" />
</jsp:include>


<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_CEFBOOK.CountRow);
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
			document.getElementById("hidHIR_YMD").value =   dsVI_T_PERSON.NameValue(0,"HIR_YMD");
        }
    </Script>

<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
<Script For=dsT_AC_CEFBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
<script for=trT_AC_CEFBOOK event="OnSuccess()">
        var REQ_NO = dsT_AC_CEFBOOK.NameValue(dsT_AC_CEFBOOK.RowPosition, "REQ_NO");
        var CEF_STS;
        var rowIndex;

        fnc_SearchList();

        //입력한 신청번호를 가지는 Row로 이동
        rowIndex = dsT_AC_CEFBOOK.NameValueRow("REQ_NO", REQ_NO);
        if(rowIndex > 0) {
            dsT_AC_CEFBOOK.RowPosition = rowIndex;
            CEF_STS = dsT_AC_CEFBOOK.NameValue(rowIndex, "CEF_STS");
        }

        //메세지 뿌리기
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        if(trTypeMsg == "저장")
            alert("* 자료가 저장되었습니다.\n재경부신청과 직접출력 중 하나를 선택하시기 바랍니다.\n직접출력시 회사직인은 이미지 처리됩니다.");
        else
            alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");


        //만약 상태값이 직접출력이라면 그건을 출력함
        if(CEF_STS == "F") {
            fnc_Print();
        }
    </script>

<script for=trT_AC_CEFBOOK_DEL event="OnSuccess()">
        fnc_SearchList();

        //메세지 뿌리기
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* "+trTypeMsg+" 작업을 완료 하였습니다!");
    </script>

<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
<script for=trT_AC_CEFBOOK event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

<script for=trT_AC_CEFBOOK_DEL event="OnFail()">
        alert(trT_AC_CEFBOOK.ErrorMsg);
    </script>

<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
<script language=JavaScript for=dsT_AC_CEFBOOK
	event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        fnc_HiddenElement("btnA");      //저장
        fnc_HiddenElement("btnB");      //재경부신청
        fnc_HiddenElement("btnF");      //직접출력
       // fnc_HiddenElement("txtCEF_YY");   //귀속년월

        if(row > 0) {
            // 상태에 따른 버튼 처리 - CEF_STS, 'A', '저장', 'B', '신청', 'C', '반송', 'E', '발급', 'F', '직접출력'
            var CEF_STS = dsT_AC_CEFBOOK.NameValue(row, "CEF_STS");
            var CEF_SEC = dsT_AC_CEFBOOK.NameValue(row, "CEF_SEC");
            var ROW_STS = dsT_AC_CEFBOOK.RowStatus(row);

            if(CEF_STS == "A" || ROW_STS == "1") {
                fnc_EnableElementAll(elementList);
                fnc_ShowElement("btnA");

                if(ROW_STS != "1") {              //신규가 아니면 경리부 신청과 직접출력이 가능하게
                    fnc_ShowElement("btnB");        //재경부신청
                    fnc_ShowElement("btnF");        //직접출력
                }

                //갑근세원천징수증명서는 귀속년도를 입력하지 않음

                if(CEF_SEC == "04") {
                    fnc_ChangeStateElement(false, "txtCEF_YY");
                    fnc_ChangeStateElement(false, "img_spinup1");
                    fnc_ChangeStateElement(false, "img_spindown1");
                }

<%
    //IT 관리자나  경리 관리자 이면 사번으로 검색하고 일반유저이면 사번으로 검색못하게 막기
    if(!isMaster) {
%>
                //사원 사번 결정
                fnc_ChangeStateElement(false, "txtENO_NO");
                fnc_ChangeStateElement(false, "txtENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    } else {
%>
                //입력일때만 사번 수정 가능하게
                if(ROW_STS != "1") {
                    fnc_ChangeStateElement(false, "txtENO_NO");
                    fnc_ChangeStateElement(false, "txtENO_NM");
                    fnc_ChangeStateElement(false, "ImgEnoNo");
                }
<%
    }
%>
            }

            //직접출력일 경우 인쇄가 가능함
            //(출력을 한번도 안했을 경우)
            if(CEF_STS == "F"
                    && dsT_AC_CEFBOOK.NameValue(row,'SPL_YMD') == "") {
                fnc_ShowElement("btnF");        //직접출력
            }

            if(dsT_AC_CEFBOOK.NameValue(row,'PRT_YMD') == "") {
                fnc_ChangeStateElement(true, "btnPrintCef");    //재직증명서
            }

        }
    </script>

<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
<script language=JavaScript for=dsT_AC_CEFBOOK
	event=CanRowPosChange(row)>
		if ( dsT_AC_CEFBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_AC_CEFBOOK.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
	</script>


<!-----------------------------------------------------+
    | 증명서 종류를 변경할때 처리
    +------------------------------------------------------>


<!-----------------------------------------------------+
    | 증명서종류 변경시 생기는 이벤트    				   |
    +------------------------------------------------------>

<script language=JavaScript for=rdoCEF_SEC event=OnSelChange()>

    var RDO_Value = rdoCEF_SEC.CodeValue;

      if(RDO_Value=="01") {//근로소득원천징수 영수증

         var hir_ymd = document.getElementById("hidHIR_YMD").value;
         if(hir_ymd == today.substring(0,4)){
         fnc_HiddenElement("RDO_Value"); }

         document.getElementById("searchMessage_01").innerText = "귀속년도";
         document.getElementById("changeDate_01").style.display = "";
         document.getElementById("changeDate_02").style.display = "none";
         fnc_ChangeStateElement(false, "txtSTR_YY");  //비활성화
         fnc_HiddenElement("img_spinup");//위화살표 감춤
         fnc_HiddenElement("img_spindown");//아래 화살표 감춤
         document.getElementById("txtSTR_YY").value = today.substring(0,4)-1;

      }else if(RDO_Value=="02"){//근로소득원천징수부
         document.getElementById("searchMessage_01").innerText = "귀속년도";
         document.getElementById("changeDate_01").style.display = "";
         document.getElementById("changeDate_02").style.display = "none";
         fnc_ShowElement("img_spinup");
         fnc_ShowElement("img_spindown");
         fnc_ChangeStateElement(true , "txtSTR_YY");  //활성화
         fnc_ChangeStateElement(true , "img_spinup");
         fnc_ChangeStateElement(true , "img_spindown");
         document.getElementById("txtSTR_YY").value = today.substring(0,4);

      }else if(RDO_Value=="03"){//퇴직소득원친징수 영수증
         document.getElementById("searchMessage_01").innerText = "귀속년월";
         document.getElementById("changeDate_01").style.display = "none";
         document.getElementById("changeDate_02").style.display = "";
         fnc_ShowElement("txtCEF_YY");
         fnc_ShowElement("img_spinup1");
         fnc_ShowElement("img_spindown1");
         fnc_ChangeStateElement(true, "txtCEF_YY");  //활성화
         fnc_ChangeStateElement(true, "img_spinup1");
         fnc_ChangeStateElement(true, "img_spindown1");

      }else if(RDO_Value=="04"){//갑근세원천징수증명서
         document.getElementById("searchMessage_01").innerText = "귀속년월";
         document.getElementById("changeDate_01").style.display = "none";
         document.getElementById("changeDate_02").style.display = "";
         fnc_ShowElement("txtCEF_YY");
         fnc_ChangeStateElement(false, "txtCEF_YY");  //비활성화
         fnc_HiddenElement("img_spinup1");//위화살표 감춤
         fnc_HiddenElement("img_spindown1");//아래 화살표 감춤
      }
     </script>



<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"	onload="fnc_OnLoadProcess();">

<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">소득증명원신청</td>
					<td align="right" class="navigator">HOME/정산세무/소득증명원출력/<font color="#000000">소득증명원신청</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<!-- 	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
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
					<col width="220"></col>
                    <col width="70"></col>
                    <col width="100"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">신청기간</td>
					<td class="padding2423" align="left" colspan="5">
						<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','134','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
						~
						<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','248','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
                </tr>
                <tr>
					<td class="searchState" align="right" rowspan="2">증명서</td>
					<td class="padding2423" align="left" rowspan="2">
						<select id="cmbCEF_SEC_SHR" style="WIDTH: 160px" onChange="fnc_SearchList()">
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
                    <td align="right" class="searchState">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="8" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>
			</table>
			</td>
		</tr>
	</table>
<!-- power Search테이블 끝 -->


<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<colgroup>
		<col width="398"></col>
		<col width="4"></col>
		<col width="398"></col>
	</colgroup>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td align="right" height="20">
                <img src="/images/button/btn_SaveOn.gif" name="btnA" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('A');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnA','','/images/button/btn_SaveOver.gif',1)">
                <img src="/images/button/btn_AntOn.gif" name="btnB" border="0" align="absmiddle" onClick="fnc_Save('B');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnB','','/images/button/btn_AntOver.gif',1)">
                <img src="/images/button/btn_DirectPrintOn.gif" name="btnF" border="0" align="absmiddle" onClick="fnc_Save('F');" style="cursor:hand" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnF','','/images/button/btn_DirectPrintOver.gif',1)">
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
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
			<td align="center" class="creamBold">신청번호</td>
			<td class="padding2423" align="left">
				<input id="txtREQ_NO" name="txtREQ_NO" size="12"  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">사번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidHIR_YMD">
            </td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423" align="left">
				<input id="txtJOB_NM" name="txtJOB_NM" size="10" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidJOB_CD">
			</td>
			<td align="center" class="creamBold">부서</td>
			<td class="padding2423" align="left">
				<input id="txtDPT_NM" name="txtDPT_NM" size="15" class="input_ReadOnly" readonly  maxlength="10" style="ime-mode:disabled" onKeypress="cfNumberCheck();">
                <input type="hidden" id="hidDPT_CD">
			</td>
		</tr>
		<tr>
		<td align="center" class="creamBold">본적</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtPER_ADR" name="txtPER_ADR" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">주소</td>
			<td class="padding2423" align="left" colspan="3">
				<input id="txtADDRESS" name="txtADDRESS" style="ime-mode:disabled;width:100%;" onKeypress="cfNumberCheck();" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	   </tr>
	   <tr>
		<td class="paddingTop5">

		<table width="100%" border="1" cellspacing="0" cellpadding="0"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="230"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td align="center" class="creamBold" rowspan="4">증명서<br>종류</td>
			<td class="padding2423" align="left" rowspan="4">
                <comment id="__NSID__">
                    <object id=rdoCEF_SEC classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200;height:90;">
                        <param name=AutoMargin  value="true">
                        <param name=Cols        value="1">
                        <param name=Format      value="01^근로소득원천징수영수증,02^근로소득원천징수부,03^퇴직소득원천징수영수증,04^갑근세원천징수증명서">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>

			</td>
			<td align="center" class="creamBold">용도</td>
			<td class="padding2423" colspan="3">
				<select id="cmbCEF_RSN" style="width:150px" onChange="fnc_Searchcmb()"></select>
				&nbsp;
			</td>

            <td align="center" class="creamBold">매수</td>
            <td class="padding2423">
                <input id="txtCEF_CNT" size="4"  maxlength="2" style="ime-mode:disabled">
            </td>
		    </tr>
		    <tr>
				<td align="center" class="creamBold">비고</td>
				<td class="padding2423" colspan="5">
				<input type="text" id="txtREMARK" style="width:100%" class="input_ReadOnly" readonly>
				</td>
			</tr>
			<tr>
				<td align="center" class="creamBold"><span
					id="searchMessage_01">귀속년도</span></td>
				<td class="padding2423" align="left">
				<table id="changeDate_01" height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td width="40" rowspan="2" style="padding-left:0px; border-style:none">
						<input type="text" id="txtSTR_YY" style="ime-mode:disabled" size="5" maxlength="4"
							onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()" class="input_ReadOnly" readonly>
						</td>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spinup" style="cursor: hand" onclick="datechange('txtSTR_YY', 'yyyy', 'next');"  src="/images/common/arrowup.gif"></TD>
					</tr>
					<tr>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spindown" style="cursor: hand" onclick="datechange('txtSTR_YY', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
					</tr>
				</table>
				<table id="changeDate_02" height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
						<td width="40" rowspan="2" style="padding-left:0px; border-style:none">
						<input type="text" id="txtCEF_YY" style="ime-mode:disabled" size="7" maxlength="7"
							onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						</td>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spinup1" style="cursor: hand" onclick="datechange('txtCEF_YY', 'yyyymm', 'next');" src="/images/common/arrowup.gif"></TD>
					</tr>
					<tr>
						<td style="height:9px; padding-left:0px; border-style:none">
						<img id="img_spindown1" style="cursor: hand" onclick="datechange('txtCEF_YY', 'yyyymm', 'prev');" src="/images/common/arrowdown.gif"></TD>
					</tr>
					</td>
				</table>
				<td align="center" class="creamBold">상태</td>
			<td class="padding2423">
				<input type="text" id="txtCEF_STS_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">신청일자</td>
			<td class="padding2423">
				<input type="text" id="txtREQ_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		    </tr>
		    <tr>
			<td align="center" class="creamBold">발급번호</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtCEF_NO" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">발급일자</td>
			<td class="padding2423">
				<input type="text" id="txtSPL_YMD" size="10" maxlength="10" class="input_ReadOnly" readonly>
			</td>
		    </tr>
		    </table>

		</td>
	</tr>
	<tr>
		<td colspan="3" class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="3"
			style="border-collapse: collapse" bordercolor="#999999"
			class="table_cream">
			<tr>
				<td>[증명서 신청방법]<br>
				&nbsp;&nbsp;1. 증명서 종류를
				선택하세요.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.
				신청한 증명서의 매수를 입력하고 신청용도를 선택하세요.<br>
				[직접출력 공지]<br>
				&nbsp;&nbsp;직접출력은 본인이 직접 증명서를 출력할 수 있으나 직인은 이미지 처리 됩니다.</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 --> <!-- 조회 상태 테이블 시작 -->
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
<!-- 조회 상태 테이블 끝 --> <!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr align="center">
				<td><comment id="__NSID__"> <object
					id="grdT_AC_CEFBOOK"
					classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B"
					style="width:800px;height:144px;">
					<param name="DataID" value="dsT_AC_CEFBOOK">
					<param name="Editable" value="false">
					<param name="DragDropEnable" value="true">
					<param name="SortView" value="Left">
					<param name="Format"
						value='
							<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
							<C> id="REQ_NO"		width=75	name="신청번호"		align=center	Edit=none	 </C>
							<C> id="ENO_NO"		width=60	name="사번"			align=center	Edit=none	 Show=false</C>
							<C> id="ENO_NM"		width=60	name="성명"			align=center	Edit=none	 Show=false</C>
							<C> id="JOB_NM"		width=60	name="직위"			align=center	Edit=none	 Show=false</C>
							<C> id="DPT_NM"		width=100	name="부서"			align=left		Edit=none	 Show=false</C>
							<C> id="PER_ADR"	width=180	name="본적"			align=left		Edit=none	 Show=false</C>
							<C> id="ADDRESS"	width=180	name="주소"			align=left		Edit=none	 Show=false</C>
							<C> id="CEF_SEC"	width=160	name="증명서종류"		align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_AC:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_CNT"	width=40	name="매수"			align=center	Edit=none	 </C>
							<C> id="CEF_RSN"	width=140	name="용도"			align=left		EditStyle=Lookup  Data="dsT_CM_COMMON_R4:CODE:CODE_NAME" 	 LeftMargin="10"</C>
							<C> id="CEF_STS_NM" width=60	name="상태"			align=center	Edit=none	</C>
							<C> id="REQ_YMD"	width=80	name="신청일자"		align=center	Edit=none	 </C>
							<C> id="CEF_NO"		width=100	name="발급번호"		align=center	Edit=none	 </C>
							<C> id="SPL_YMD"	width=80	name="발급일자"		align=center	Edit=none	 </C>
						'>
				</object> </comment><script> __ShowEmbedObject(__NSID__); </script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝--></form>
<!-- form 끝 -->

</body>
</html>


<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

<!-- T_AC_CEFBOOK 설정 테이블 -->
<object id="bndT_AC_CEFBOOK"
	classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID" ,   Value="dsT_AC_CEFBOOK">
	<Param Name="BindInfo"
		, Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=PER_ADR		Ctrl=txtPER_ADR		Param=value</C>
			<C>Col=ADDRESS		Ctrl=txtADDRESS		Param=value</C>
			<C>Col=CEF_RSN		Ctrl=cmbCEF_RSN		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=CEF_NO		Ctrl=txtCEF_NO		Param=value</C>
			<C>Col=CEF_STS_NM	Ctrl=txtCEF_STS_NM	Param=value</C>
			<C>Col=CEF_SEC		Ctrl=rdoCEF_SEC		Param=CodeValue</C>
			<C>Col=CEF_CNT		Ctrl=txtCEF_CNT		Param=value</C>
			<C>Col=CEF_YY		Ctrl=txtCEF_YY		Param=value</C>
			<C>Col=CEF_YY		Ctrl=txtCEF_YY		Param=value</C>
			<C>Col=STR_YY		Ctrl=txtSTR_YY		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=hidHIR_YMD		Param=value</C>
		">
</object>
