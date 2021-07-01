	<!--*************************************************************************
	* @source      : aida010.jsp												*
	* @description : 경공조금신청서관리 PAGE / 공조금신청서상세 PAGE(POP_UP)    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/12            채갑병          	        최초작성		        *
    * 2006/05/08            김학수          	        최초작성
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String prmREQ_NO    = request.getParameter("REQ_NO");
    String prmTYPE      = request.getParameter("TYPE"); //"TYPE1" : 신규, "TYPE2" : 결재 처리, "TYPE3" : 전표, 지급처리
%>

<html>
<head>
	<title>경공조금신청서상세(aida011.jsp)</title>
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

	<!-- 첨부 파일을 위해 -->
    <jsp:include page="/common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->

	<script language="javascript">
        /**
         * FLAG status
         *  - "S" : 상신
         *  - "O" : 결재
         *  - "R" : 부결
         *  - "C" : 반송
         *  - "D" : 전표
         *  - "E" : 지급
         */

		var year = getToday().substring(0,4);
		var btnList;
        var prmREQ_NO   = "<%=prmREQ_NO %>";    //신청번호
        var prmTYPE     = "<%=prmTYPE %>";      //"TYPE1" : 신규, "TYPE2" : 결재 처리, "TYPE3" : 전표, 지급처리

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            dsRESULT.ClearData();

            trT_AD_AIDAPP2.KeyValue = "shr(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP, O:dsT_AD_DECISION=dsT_AD_DECISION)";
            trT_AD_AIDAPP2.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_04&REQ_NO="+prmREQ_NO;
            trT_AD_AIDAPP2.post();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

            dsT_AD_AIDAPP.UseChangeInfo = false;
            dsT_AD_DECISION.UseChangeInfo = false;

			// save
			trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION, O:dsRESULT=dsRESULT)";
			trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP.post();
        }

        /**
         * 저장함수 저장 후 다른 처리르 하지 않음
         */
        function fnc_Save2() {
            dsT_AD_AIDAPP.UseChangeInfo = false;
            dsT_AD_DECISION.UseChangeInfo = true;

			// save
			trT_AD_AIDAPP2.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION, O:dsRESULT=dsRESULT)";
			trT_AD_AIDAPP2.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP2.post();
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
			//경공조금신청서  정보 조회
			var ENO_NO = document.getElementById("txtENO_NO").value;
			var REQ_NO = document.getElementById("txtREQ_NO").value;

            var url = "aida010_PV.jsp?REQ_NO="+REQ_NO+"&ENO_NO="+ENO_NO;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
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
            //신청서 내역에 새 항목 집어 넣게
			if (dsT_AD_AIDAPP.CountColumn == 0) {
				dsT_AD_AIDAPP.setDataHeader(  "REQ_NO:STRING"
                                            +",ENO_NO:STRING"
                                            +",ENO_NM:STRING"
                                            +",CET_NO:STRING"
                                            +",OCC_CD:STRING"
                                            +",DPT_CD:STRING"
                                            +",DPT_NM:STRING"
                                            +",JOB_CD:STRING"
                                            +",JOB_NM:STRING"
                                            +",HIR_YMD:STRING"
                                            +",RET_YMD:STRING"
                                            +",LSE_YY:INT"
                                            +",LSE_MM:INT"
                                            +",ABA_CD:STRING"
                                            +",ABA_NM:STRING"
                                            +",ACC_NO:STRING"
                                            +",REC_NM:STRING"
                                            +",AID_CD:STRING"
                                            +",AID_CD_NM:STRING"
                                            +",AID_NM:STRING"
                                            +",AID_RPT:STRING"
                                            +",AID_YMD:STRING"
                                            +",SPL_YMD:STRING"
                                            +",REQ_YMD:STRING"
                                            +",HLP1_AMT:INT"
                                            +",HLP2_AMT:INT"
                                            +",SUM_AMT:INT"
                                            +",WORK_NO1:STRING"
                                            +",AID_STS:STRING"
                                            +",AID_STS_NM:STRING"
                                            +",RET_RSN:STRING"
                                            +",AID_CET:STRING"
                                            +",FILE_KEY:STRING"
                                            );
			}

            //결재자 항목에 새 항목 집어 넣기
            if (dsT_AD_DECISION.CountColumn == 0) {
                dsT_AD_DECISION.setDataHeader("ENO_NO:STRING"
                                            +",ENO_NM:STRING"
                                            +",DPT_CD:STRING"
                                            +",JOB_CD:STRING"
                                            +",APP_YN:STRING"
                                            +",APP_YN_NM:STRING"
                                            +",ARR_TIME:STRING"
                                            +",ORD_NO:STRING"
                                            +",AUTHO_CD:STRING"
                                            );
            }

			// 행 추가
			dsT_AD_AIDAPP.AddRow();

			//파일을 위해 키를 생성
            dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY") = "aida011"+(new Date().getTime());

            // 입력필드 사용가능하게
            fnc_EnableElementAll(oElementList);

<%
    //관리자면 신청자 정보를 수정할 수있다.
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            fnc_ChangeStateElement(true, "txtENO_NO");
            fnc_ChangeStateElement(true, "txtENO_NM");
            fnc_ChangeStateElement(true, "ImgEnoNo");
<%
    }
%>


          //fnc_ShowElement(  "btnDEC"      );  //결재자변경 버튼
            fnc_HiddenElement(  "btnDEC"      );  //결재자변경 버튼
            fnc_ShowElement(  "btnSave"     );  //저장 버튼
            fnc_HiddenElement("imgRemove"   );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            fnc_HiddenElement("btnC"        );
            fnc_HiddenElement("btnD"        );
            fnc_HiddenElement("btnE"        );


            // 콤보박스 기본 선택
            document.form1.cmbAID_CD.selectedIndex = 0;
            //document.form1.cmbABA_CD.selectedIndex = 0;
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
	        if (dsT_AD_AIDAPP.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "신청사유  = "+fnc_GetCommonName("dsT_CM_COMMON_R1", dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_CD"))+"\n";
            	tmpMSG += "대상자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_NM")+"\n";

	            if( confirm(tmpMSG) ){
					dsT_AD_AIDAPP.DeleteRow(dsT_AD_AIDAPP.RowPosition);
                    dsT_AD_DECISION.DeleteRow(dsT_AD_DECISION.RowPosition);

					//해당 행을 삭제하기전 파일들을 먼저 삭제한다.
                    for(var i=1; i<=dsFILE.CountRow; i++) {
                        dsFILE.DeleteRow(i);
                    }
                    fnc_DelFile()

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
					trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=DEL";
					trT_AD_AIDAPP.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

  			fnc_DisableElementAll(oElementList);
	        document.getElementById("resultMessage").innerText = ' ';

			// 콤보박스 기본 선택
			document.form1.cmbAID_CD.selectedIndex = 0;
			//document.form1.cmbABA_CD.selectedIndex = 0;

        	dsT_AD_AIDAPP.ClearData();
            dsT_AD_DECISION.ClearData();
            dsRESULT.ClearData();
            dsFILE.ClearData();

            //결재자 정보 지움
            document.getElementById("txtA1_ENO_NO").innerText   = "";
            document.getElementById("txtA2_ENO_NO").innerText   = "";

            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";

            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
            if (dsT_AD_AIDAPP.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            opener.parent.fnc_SearchList();
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
         	if ( !dsT_AD_AIDAPP.isUpdated && !dsT_AD_DECISION.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

            var oElement;
            var oElement2;

            oElement = document.getElementById("txtAID_CET");
            if(oElement.value == "") {
                alert("대상자주민번호를 등록해 주세요.");
                oElement.focus();
                return false;
            }
            oElement = document.getElementById("txtAID_NM");
            if(oElement.value == "") {
                alert("대상자성명을 등록해 주세요.");
                oElement.focus();
                return false;
            }
            oElement = document.getElementById("txtAID_YMD");
            if(oElement.value == "") {
                alert("발생일자를 등록해 주세요.");
                oElement.focus();
                return false;
            }
            oElement = document.getElementById("cmbAID_CD");
            if(oElement.value == "") {
                alert("신청사유를 선택해 주세요.");
                oElement.focus();
                return false;
            }
            /*
            oElement = document.getElementById("cmbABA_CD");
            if(oElement.value == "") {
                alert("은행명을 선택해 주세요.");
                oElement.focus();
                return false;
            }
            */
            oElement = document.getElementById("medHLP1_AMT");
            oElement2 = document.getElementById("medHLP2_AMT");
            if(oElement.Text == "0" && oElement2.Text == "0") {
                alert("경조금, 공조금중 하나라도 입력하셔야 됩니다.");
                oElement.focus();
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_ConstructCommonCode("dsT_CM_COMMON_R1", "cmbAID_CD");   //신청사유 구분 콤보박스
            //fnc_ConstructCommonCode("dsT_CM_COMMON_BK", "cmbABA_CD");   //은행명 콤보박스
			fnc_DisableElementAll(oElementList);                        //모든입력창 막아두기

            //사원입력창은 막아둠
            fnc_ChangeStateElement(false, "txtENO_NO");
            fnc_ChangeStateElement(false, "txtENO_NM");
            fnc_ChangeStateElement(false, "ImgEnoNo");

            fnc_EnableElementAll(btnNameList);                          //모든버튼(조회,저장,취소 등등)을 사용가능하게 풀어두기

            //인쇄버튼 안보이게
            //fnc_HiddenElement("imgPrint"    );

			//신청 번호가 비어있으면 신규
			if( prmREQ_NO == ''){
                //새로운 행을 추가하고
                fnc_AddNew();

                //조회와 취소버튼을 사용 못하게 막음
                fnc_ChangeStateElement(false, "imgSearch");
                fnc_ChangeStateElement(false, "imgCancel");
                fnc_ChangeStateElement(false, "imgRemove");

                // 단축키 비활성화 처리
                btnList = "F"   //조회
                        + "F"   //신규
                        + "T"   //저장
                        + "F"   //취소
                        + "F"   //엑셀
                        + "T"   //인쇄
                        + "F"   //삭제
                        + "T";  //닫기

                fnc_HotKey();

                //신청자 정보를 가지고옴
                document.getElementById("txtENO_NO").value = "<%=box.get("SESSION_ENONO") %>";
                fnc_SearchEmpNo();
			} else {

                // 단축키 비활성화 처리
                btnList = "T"   //조회
                        + "T"   //신규
                        + "T"   //저장
                        + "F"   //취소
                        + "F"   //엑셀
                        + "T"   //인쇄
                        + "F"   //삭제
                        + "T";  //닫기

                fnc_HotKey();

                // 신청번호(REQ_NO)에 해당하는 신청서 조회
                fnc_SearchList();
            }

            //버튼 리스트를 보여줍시다.

            var layerName;
            if(prmTYPE == "TYPE1" || prmTYPE == "TYPE2"){
                layerName = "procBTN";
            }else            if(prmTYPE == "TYPE3"){
                layerName = "popupBTN";
			}

            fnc_ShowHiddenLayer(new Array("procBTN", "popupBTN"), layerName);
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        //버튼들
        var btnNameList = new Array( "imgSearch"
                                    ,"imgCancel"
                                    ,"imgPrint"
                                    ,"imgExit" );

        //입력창들
        var oElementList = new Array("cmbAID_CD"
                                    ,"txtAID_CET"
                                    ,"txtAID_NM"
                                    ,"txtAID_YMD"
                                    //,"cmbABA_CD"
                                    //,"txtREC_NM"
                                    //,"txtACC_NO"
                                    ,"medHLP1_AMT"
                                    ,"medHLP2_AMT"
                                    ,"medSUM_AMT"
                                    ,"imgAID_YMD"
                                    ,"FileAdd"
                                    ,"FileDel"
									);

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
         * 신청사유 콤보박스 변동시 해당 지급 금액 조회      		*
         ********************************************/
        function getAidAmt(){
        	if(document.form1.txtENO_NO.value == '')   { return; } // 사번 없을경우 리턴
        	if(document.form1.txtREQ_YMD.value == '')  { return ; }  // 신청일자 없을경우 리턴
        	if(document.getElementById("cmbAID_CD").value == '')  { return ; }  // 신청사유 없을경우 리턴


        	// 조회조건
        	var ENO_NO  = document.form1.txtENO_NO.value;
        	var LSE_YY  = document.form1.txtLSE_YY.value;
            var REQ_YMD = (document.form1.txtAID_YMD.value == null || document.form1.txtAID_YMD.value.trim() == '') ? (document.form1.txtREQ_YMD.value) : (document.form1.txtAID_YMD.value);
        	var HIR_YMD = document.form1.txtHIR_YMD.value;
        	var AID_CD  = document.form1.cmbAID_CD.value;
            var JOB_CD  = document.getElementById("hidJOB_CD").value;

			// 신청사유, 근속년수 에 해당하는 공조부조금/경조금 조회
			dsT_AD_AIDAMT.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_03&ENO_NO="+ENO_NO+"&LSE_YY="+LSE_YY+"&AID_CD="+AID_CD+"&REQ_YMD="+REQ_YMD+"&HIR_YMD="+HIR_YMD+"&JOB_CD="+JOB_CD;
			dsT_AD_AIDAMT.reset();
        }

 		/********************************************
         * 신청일자에서 포커스 떠날때 신청일자와 비교       		*
         ********************************************/
		function cfCheckDateTermAIDA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("발생일자가 신청일자보다 큽니다.");
					document.getElementById(p_obj).value = '';
				}
			}
		}

 		/********************************************
         * 예금주 필드에서 포커스 떠날때  		     		*
         ********************************************/
	    function checkNAME(){
	    	var eno_nm = document.form1.txtENO_NM.value;
	    	var rec_nm = document.form1.txtREC_NM.value;
	    	var aid_cd = document.form1.cmbAID_CD.value;
	    	// 본인에 관한 지원사유일 경우 신청인명과 예금주명이 같을 수 없다
	    	if( aid_cd == "AA"){  // 본인결혼
	    		if( eno_nm != "" && rec_nm != "" && eno_nm == rec_nm ){
	    			alert("신청인과 예금주가 같을 수 없습니다.");
	    			document.form1.txtREC_NM.focus();
	    			return;
	    		}
	    	}
	    }

 		/********************************************
         * 결재선지정 버튼 클릭시 처리                                   	*
         ********************************************/
        function fnc_btnDEC(){

            //신청자 사번
            var eno_no = document.getElementById("txtENO_NO").value;
            var eno_nm = document.getElementById("txtENO_NM").value;
            var job_nm = document.getElementById("txtJOB_NM").value;
            var idx    = "";


            //사원 정보 가져오기
        	var obj    = new String;
            var appObj = new String;    //결재자
            var reqObj = new String;    //신청자

            //결재자 검색 정규직 전체   ==> 결재자지정
            appObj = fnc_GetApprover(document.getElementById("txtENO_NO").value, "");
            //reqObj = fnc_GetCommonEnoObj("21008171");
            //appObj = fnc_GetCommonEnoObj("200218");

            //결재자 정보가 없으면 입력 안함
            if(appObj == undefined
                    || appObj.eno_no == undefined
                    || appObj.eno_no == ""
                    || appObj.eno_nm == undefined
                    || appObj.eno_nm == "") {
                    alert("결재자를 지정하여 주십시요");
                return;
            }

            document.getElementById("txtA1_ENO_NO").value       = "";
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_ENO_NO").value       = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";


            //신청자 사번이랑 결재자 사번이 같으면 첫번째 결재자에 넣고 아니면 아니면 두번째에 넣음
            dsT_AD_DECISION.ClearData();
            if(eno_no == appObj.eno_no) {
                idx = 2;
                dsT_AD_DECISION.AddRow();
            } else {
                idx = 1;
                dsT_AD_DECISION.AddRow();
                dsT_AD_DECISION.AddRow();

                //신청자 정보 조회
                reqObj = fnc_GetCommonEnoObj(eno_no);
            }


            for(var i = idx, j=1; i<=2; i++, j++) {
                if(i == 1) {
                    obj = reqObj;
                } else {
                    obj = appObj;
                }

                dsT_AD_DECISION.NameValue(j,"ENO_NO")           = obj.eno_no;
                dsT_AD_DECISION.NameValue(j,"ENO_NM")           = obj.eno_nm;
                dsT_AD_DECISION.NameValue(j,"DPT_CD")           = obj.dpt_cd;
                dsT_AD_DECISION.NameValue(j,"JOB_CD")           = obj.job_cd;
                dsT_AD_DECISION.NameValue(j,"ORD_NO")           = document.getElementById("txtREQ_NO").value;

                dsT_AD_DECISION.NameValue(j,"APP_YN")           = "1";
                if(j == 2) {
                    dsT_AD_DECISION.NameValue(j,"APP_YN")       = "2";
                }
                dsT_AD_DECISION.NameValue(j,"AUTHO_CD")         = "A"+i;

                document.getElementById("txtA"+j+"_ENO_NO").value = obj.eno_no;

                document.getElementById("txtA"+j+"_ENO_NM").innerText   = obj.job_nm+" "+obj.eno_nm;
                document.getElementById("txtA"+j+"_APP_STS").innerText  = "미결";
            }

        }


 		/********************************************
         * 상신 버튼 클릭시 처리                                   		*
         ********************************************/
        function fnc_btnS(){

            var aid_cd = dsT_AD_AIDAPP.NameString(0, "AID_CD");


            //결재자 사번이랑 신청자 사번이 같으면 바로 결재로 넘어감
            if(document.getElementById("txtENO_NO").value == dsT_AD_DECISION.NameString(1, "ENO_NO")) {
                alert("결재자 사번이랑 신청자 사번이 같으면 바로 결재로 넘어감2222222222.");

                //신청 상태 변경
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "S"; //상신

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();

                fnc_btnO();
				fnc_HiddenElement("btnS");
                if(dsT_AD_AIDAPP.CountRow != 0
                    && (   aid_cd == "AE"
                        || aid_cd == "AF"
                        || aid_cd == "AK"
                        || aid_cd == "AL"
                        || aid_cd == "AX"
                        || aid_cd == "AY"
                        || aid_cd == "AQ"
                        || aid_cd == "AR"
                        || aid_cd == "AS"
                        || aid_cd == "AT"
                        || aid_cd == "AZ"
                        || aid_cd == "BA"))
                   alert("결재자 사번이랑 신청자 사번이 같으면 바로 결재로 넘어감.");
                else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
                   alert("결재자 사번이랑 신청자 사번이 같으면 바로 결재로 넘어감.");

                return;
            }

        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("상신 처리할 자료가 없습니다!");
                return;
            }

            var oCheckList = new Array(  "txtAID_CET"
                                        ,"txtAID_NM"
                                        ,"txtAID_YMD"
//                                        ,"txtREC_NM"
//                                        ,"txtACC_NO"
                                        );

            var oCheckMsgList = new Array(
                                         "대상자주민번호"
                                        ,"대상자성명"
                                        ,"발생일자"
//                                        ,"예금주"
//                                        ,"계좌번호"
                                        );
            var oElement;


            // 모든 필드 입력 후 상신 가능
            for(var i=0; i<oCheckList.length; i++) {
                oElement = document.getElementById(oCheckList[i]);
                if(oElement.value == "") {
                    alert("[ " + oCheckMsgList[i] + " ]은 필수 입력사항입니다");
                    return;
                }
            }

        	var tmpMSG = "아래 행을 상신하시겠습니까?\n";
           	tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){

                // 상신하기 직전에 모든 데이타를 저장한다.
                fnc_Save2();

                var APP_YN = "N"; //==> 결재자지정
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //신청 상태 변경
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "S"; //상신

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}

            if(dsT_AD_AIDAPP.CountRow != 0
                    && (   aid_cd == "AE"
                        || aid_cd == "AF"
                        || aid_cd == "AK"
                        || aid_cd == "AL"
                        || aid_cd == "AX"
                        || aid_cd == "AY"
                        || aid_cd == "AQ"
                        || aid_cd == "AR"
                        || aid_cd == "AS"
                        || aid_cd == "AT"
                        || aid_cd == "AZ"
                        || aid_cd == "BA"))
              //alert("경조대상자의 가족관계증명서를 경영지원실 담당자에게 제출하시기 바랍니다.");
                alert("처리가 완료되었습니다.");
            else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
              //alert("경조대상자의 주민등록등본을 경영지원실 담당자에게 제출하시기 바랍니다.");
                alert("처리가 완료되었습니다.");
            else
                alert("처리가 완료되었습니다.");

			fnc_HiddenElement("btnS"        );

        }

 		/********************************************
         * 결재 버튼 클릭시 처리                    *
         ********************************************/
        function fnc_btnO(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("결재 처리할 자료가 없습니다!");
                return;
            }

            var tmpMSG = "아래 행을 결재하시겠습니까?\n";
            tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
            tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
            tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){

                // 결재하기 직전에 모든 데이타를 저장한다.
                fnc_Save2();


                var APP_YN = "Y";
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //신청 상태 변경
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "O"; //결재

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
        }

 		/********************************************
         * 부결 버튼 클릭시 처리                                   		*
         ********************************************/
        function fnc_btnR(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("부결 처리할 자료가 없습니다!");
                return;
            }
        	if( document.form1.txtRET_RSN.value == ""){
	        	alert("부결사유를 입력해 주세요.");
	        	document.form1.txtRET_RSN.focus();
	        	return;
        	}
            var tmpMSG = "아래 행을 부결 처리하시겠습니까?\n";
            tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
            tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
            tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

            if( confirm(tmpMSG) ){
                var APP_YN = "R";
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //신청 상태 변경
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "R"; //부결

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO+",APP_YN="+APP_YN;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
        }

 		/********************************************
         * 반송 버튼 클릭시 처리                                   		*
         ********************************************/
        function fnc_btnC(){
     		if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("반송 처리할 자료가 없습니다!");
                return;
            }
        	if( document.form1.txtRET_RSN.value == ""){
	        	alert("반송사유를 입력해 주세요.");
	        	document.form1.txtRET_RSN.focus();
	        	return;
        	}

        	var tmpMSG = "아래 행을 반송처리 하시겠습니까?\n";
           	tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
        		var REQ_NO = document.form1.txtREQ_NO.value;

                //신청 상태 변경
                dsT_AD_AIDAPP.UseChangeInfo = false;
                dsT_AD_DECISION.UseChangeInfo = false;
                dsT_AD_AIDAPP.NameString(1, "AID_STS") = "C"; //반송

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV_01";
				trT_AD_AIDAPP.post();
			}
        }

 		/********************************************
         * 전표 버튼 클릭시 처리                                   		*
         ********************************************/
        function fnc_btnD(){
        	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("전표를 생성할 자료가 없습니다!");
                return;
            }
        	var tmpMSG = "아래 행의 전표처리를 하시겠습니까?\n";
           	tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "신청자     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
				var url = "/hr/but/buta011.jsp";
				var returnValue = new Array(2);
				window.showModalDialog(url, returnValue, "dialogWidth:730px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
				var GUBUN = returnValue[0]
				var CCTR_CD = returnValue[1]
				var CCTR_NM = returnValue[2]
				if(GUBUN == "undefined" || GUBUN == undefined || GUBUN == ""){
				}else{
					var REQ_NO = document.form1.txtREQ_NO.value;
					var ENO_NO = dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition,"ENO_NO");
					trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
					trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_D"+"&GUBUN="+GUBUN+"&CCTR_CD="+CCTR_CD+"&CCTR_NM="+CCTR_NM+"&ENO_NO="+ENO_NO;;
					trT_AD_AIDAPP.post();
				}
			}
        }

 		/********************************************
         * 지급 버튼 클릭시 처리                                   		*
         ********************************************/
        function fnc_btnE(){
          	if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("지급 처리할 자료가 없습니다!");
                return;
            }

            //지급일자가 없으면 지급처리 불가능하다.
			if(dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD").length == 0){
				alert("지급일자를 입력하세요.");
				return;
			}

        	var tmpMSG = "아래 행을 지급처리 하시겠습니까?\n";
           	tmpMSG += "신청번호  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO")+"\n";
           	tmpMSG += "발생일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_YMD")+"\n";
           	tmpMSG += "지급일자  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD")+"\n";
           	tmpMSG += "신청자    = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";

	        if( confirm(tmpMSG) ){
        		var REQ_NO = document.form1.txtREQ_NO.value;

        		trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

        		trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP, I:dsT_AD_DECISION=dsT_AD_DECISION)";
        		trT_AD_AIDAPP.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=PROC_E&SPL_YMD="+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "SPL_YMD");
				trT_AD_AIDAPP.post();
			}
        }

  		/********************************************
         * 진행 상태(AID_STS)에 따라 활성화 처리 *
         ********************************************/
        function checkAidStatus(){
        	var status = dsT_AD_AIDAPP.NameValue(0, "AID_STS");

            //결재자인지 여부를 파악
            var isApproval;

            if((dsT_AD_DECISION.NameString(1, "ENO_NO") == "<%=ls_UserId%>" && dsT_AD_DECISION.NameString(1, "APP_YN") == "N") ||
               (dsT_AD_DECISION.NameString(2, "ENO_NO") == "<%=ls_UserId%>" && dsT_AD_DECISION.NameString(2, "APP_YN") == "N"))
                isApproval = true;
            else
                isApproval = false;

            // 수정 불가능 하게 처리
            fnc_DisableElementAll(oElementList);
            fnc_ChangeStateElement(true, "txtRET_RSN");    //반송사유
            fnc_ChangeStateElement(false, "txtSPL_YMD");
            fnc_ChangeStateElement(false, "imgSPL_YMD");

            fnc_HiddenElement("btnDEC"      );
            fnc_HiddenElement("btnSave"     );
            fnc_HiddenElement("imgRemove"   );
          //  fnc_HiddenElement("imgPrint"    );
            fnc_HiddenElement("btnS"        );
            fnc_HiddenElement("btnO"        );
            fnc_HiddenElement("btnR"        );
            fnc_HiddenElement("btnC"        );
            fnc_HiddenElement("btnD"        );
            fnc_HiddenElement("btnE"        );

<%
    //관리자 화면일때만 인쇄버튼 보여지게
    if(prmTYPE.equals("TYPE3")) {
%>
            //결재, 지급, 전표
            if( status == "O"
                    || status == "D"
                    || status == "E" )
                fnc_ShowElement("imgPrint");
<%
    }
%>

        	if( status == "S" ){        // 상신
                fnc_ShowElement("imgRemove" );

                //상신일때 신청자랑 자신이랑 같으면 결재자 변경이 가능하다.
                if(document.getElementById("txtENO_NO").value == "<%=ls_UserId %>"){
                  //fnc_ShowElement("btnDEC");
                    fnc_HiddenElement("btnDEC");
                    fnc_ShowElement("btnS"  );  //상신 후에도 다시 상신 할 수 있음
                }

                if(isApproval) {
    				fnc_ShowElement("btnO"  );
    				fnc_ShowElement("btnR"  );
                }

			}else if( status == "O" ){  // 결재
<%
    //마스터 권한이 있어야 반송, 전표버튼 보임
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

                fnc_ShowElement("btnC"  ); //반송
                //결재를 해야 되는 상태이면 반송사유를 입력가능하게
                if(prmTYPE == "TYPE3")
                    fnc_ChangeStateElement(true, "txtRET_RSN");

                //공조금이 있을 경우 전표
                if(dsT_AD_AIDAPP.NameString(dsT_AD_AIDAPP.CountRow, "HLP2_AMT") != "0") {
                    fnc_ShowElement("btnD"  );

				}else if( status == "R" ){  // 부결
					fnc_ShowElement("btnR"  );    // 다른 결재자 부결 처리 가능토록



                //공조금이 없을 경우 결재 다음 바로 지급이 가능하게
                }else {
                    fnc_ShowElement("btnE"  );

                    //전표처리되었으면 지급일자를 넣을수있다. 지급일자가 있어야 지급이 가능하다.
                    fnc_ChangeStateElement(true, "txtSPL_YMD");
                    fnc_ChangeStateElement(true, "imgSPL_YMD");
                }
<%
    }
%>

			}else if( status == "R" ){  // 부결
<%
    //마스터 권한이 있어야 반송, 전표버튼 보임
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			fnc_ShowElement("btnR"  );
<%
    }
%>


			}else if( status == "C" ){  // 반송


			}else if( status == "D" ){  // 전표
<%
    //마스터 권한이 있어야 지급버튼 보임
    if(box.getString("SESSION_ROLE_CD").equals("1001")
            || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
                fnc_ShowElement("btnE"  );

                //전표처리되었으면 지급일자를 넣을수있다. 지급일자가 있어야 지급이 가능하다.
                fnc_ChangeStateElement(true, "txtSPL_YMD");
                fnc_ChangeStateElement(true, "imgSPL_YMD");
<%
    }
%>

			}else if( status == "E" ){  // 지급


			}else if( status == "A" ){  // 저장
                //fnc_ShowElement("btnDEC"    );
                fnc_HiddenElement("btnDEC"    );
                fnc_ShowElement("btnSave"   );
                fnc_ShowElement("imgRemove" );
                fnc_ShowElement("btnS"      );

				fnc_EnableElementAll(oElementList);
			}
        }

        /********************************************
         * 주민등록번호 필드에서 포커스 떠날때 유효한지 검사      *
         ********************************************/
        function checkSSN(){
            // 하이픈 제거
            var ssn = removeChar( document.form1.txtAID_CET.value, "-" ) ;
            if( document.form1.txtAID_CET.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){
                alert("잘못된 주민번호입니다.");
                document.form1.txtAID_CET.value = "";
                document.form1.txtAID_CET.focus();
            }
        }

        /********************************************
         * 주민등록번호 입력시 자동 하이픈(-) 넣기          *
         ********************************************/
        function cfCheckNumber5(){
            if((event.keyCode < 48)||(event.keyCode > 57)){
                if(event.keyCode != 45){
                    event.returnValue=false;
                }
            }
            if( document.form1.txtAID_CET.value.length == 6 ){
                document.form1.txtAID_CET.value += "-";
            }
        }

        /********************************************
         * 첨부파일 처리								*
         ********************************************/
		function fnc_FileUpload() {
            if(dsFILE.CountRow == 5) {
                alert("더 이상 첨부파일을 추가하실 수 없습니다.");
                return;
            }

            var key = dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY");

            if(key == "") {
                key = "aida011"+(new Date().getTime());
                dsT_AD_AIDAPP.NameValue(dsT_AD_AIDAPP.RowPosition, "FILE_KEY") = key;
            }

            if(!fnc_AddFileImg(key)) {
                return;
            }
		}

		/********************************************
         * 첨부파일 삭제								*
         ********************************************/
		function fnc_FileDelete() {
            if(dsFILE.CountRow < 1) {
                alert("삭제할 파일이 존재하지 않습니다.");
                return;
            }

            if( confirm("첨부된 파일을 삭제하시겠습니까?") ){
                dsFILE.DeleteRow(dsFILE.RowPosition);
                fnc_DelFile();
            }
		}

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");
            fnc_SearchEmpNo();
            getRet_ymd();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "1", "");
            if(obj != null && obj.eno_no != "") {
                dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR_01&ENO_NO="+obj.eno_no;
                dsVI_T_PERSON.reset();
            } else {
                document.getElementById("txtREQ_NO").value      = "";
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
                document.getElementById("hidOCC_CD").value      = "";
                document.getElementById("hidJOB_CD").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("hidDPT_CD").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtHIR_YMD").value     = "";
                document.getElementById("txtRET_YMD").value     = "";
                document.getElementById("txtLSE_YY").value      = "";
                document.getElementById("txtLSE_MM").value      = "";
            }
            getRet_ymd();
        }

       function getRet_ymd() {
             //신청사유가 퇴사이면
            if(document.getElementById("cmbAID_CD").value == "AG"){
                document.getElementById("txtAID_CET").value = document.getElementById("txtCET_NO").value;
                document.getElementById("txtAID_NM").value  = document.getElementById("txtENO_NM").value;
                document.getElementById("txtAID_YMD").value = document.getElementById("txtRET_YMD").value;
            }
            else{
                document.getElementById("txtAID_CET").value = "";
                document.getElementById("txtAID_NM").value  = "";
                document.getElementById("txtAID_YMD").value = "";

            }
       }

        /**
         * 발생일자가 변경되었을때 발생하는 이벤트
         */
        function changeAidYmd() {
            var str_ymd = document.getElementById("txtHIR_YMD").value;
            var end_ymd;

            //신청사유가 퇴사이면
            if(document.getElementById("cmbAID_CD").value == "AG")
                end_ymd = document.getElementById("txtRET_YMD").value;                //퇴사일자
            else
                end_ymd = document.getElementById("txtAID_YMD").value;     //발생일자


            document.getElementById("txtLSE_YY").value      = "";
            document.getElementById("txtLSE_MM").value      = "";

            if(str_ymd == ""
                    || str_ymd == undefined
                    || end_ymd == ""
                    || end_ymd == undefined) {
                return;
            }

            dsLSE_YMD.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida010.cmd.AIDA010CMD"
                             + "&S_MODE=SHR_LSE"
                             + "&STR_YMD="+str_ymd
                             + "&END_YMD="+end_ymd;
            dsLSE_YMD.reset();

            getAidAmt();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. 조회용 DataSet								       |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDTRF)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDTRF) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAMT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_AD_DECISION                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_AD_DECISION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsLSE_YMD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			       |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	<Object ID="trT_AD_AIDAPP2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 신청사유 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 은행명  -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_BK"/>
       <jsp:param name="CODE_GUBUN"    value="BK"/>
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
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);

            fnc_EnableElementAll(oElementList);
        }
    </Script>

    <!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AD_AIDAPP event=OnRowPosChanged(row)>
        //입력 못하게 막기
        fnc_DisableElementAll(oElementList);

        if(row > 0) {
            //등록된 파일들 조회
            fnc_GetFileList(dsT_AD_AIDAPP.NameValue(row, "FILE_KEY"));

            //아직 완료가 되지 않았거나 수정기간 이면
//            if(dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "0"
//                    && dsT_SC_SCHLBOOK.NameValue(row, "IS_MOD") == "1") {
//                //수정가능하게 창 풀어 놓기
//                fnc_EnableElementAll(oElementList);
//            }
        }
	</script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("해당사원의 정보가 없습니다.");
		} else {
			// 사원정보 입력 후 신청사유 선택 가능하게 처리
			document.getElementById("cmbAID_CD").disabled  = false;

			// 사원 정보 매핑
            document.getElementById("txtREQ_NO").value      = dsVI_T_PERSON.NameValue(0, "REQ_NO");
            document.getElementById("txtENO_NO").value      = dsVI_T_PERSON.NameValue(0, "ENO_NO");
            document.getElementById("txtENO_NM").value      = dsVI_T_PERSON.NameValue(0, "ENO_NM");
            document.getElementById("txtCET_NO").value      = dsVI_T_PERSON.NameValue(0, "CET_NO");
            document.getElementById("hidOCC_CD").value      = dsVI_T_PERSON.NameValue(0, "OCC_CD");
            document.getElementById("hidJOB_CD").value      = dsVI_T_PERSON.NameValue(0, "JOB_CD");
            document.getElementById("txtJOB_NM").value      = dsVI_T_PERSON.NameValue(0, "JOB_NM");
            document.getElementById("hidDPT_CD").value      = dsVI_T_PERSON.NameValue(0, "DPT_CD");
            document.getElementById("txtDPT_NM").value      = dsVI_T_PERSON.NameValue(0, "DPT_NM");
            document.getElementById("txtHIR_YMD").value     = dsVI_T_PERSON.NameValue(0, "HIR_YMD");
            document.getElementById("txtRET_YMD").value     = dsVI_T_PERSON.NameValue(0, "RET_YMD");

            //은행정보 넣기
            //document.getElementById("cmbABA_CD").value      = dsVI_T_PERSON.NameValue(0, "ABA_CD");
            //document.getElementById("txtACC_NO").value      = dsVI_T_PERSON.NameValue(0, "ACC_NO");
            //document.getElementById("txtREC_NM").value      = dsVI_T_PERSON.NameValue(0, "REC_NAM");

            document.getElementById("txtREQ_YMD").value = getToday();

			// 신청인 변경시 지급금액 조회
            changeAidYmd();
 			//getAidAmt();
        }
    </Script>

	<Script For=dsT_AD_AIDAMT Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			// 신청사유, 근속년월에 해당하는 지급금액이 없더라도
			// 근속년월 필드에 값을 매핑해 주기 위해서 1개의 행을 리턴하게 되어있다.
			// 아래 else 구문에서 처리 하게 하였다.
		} else {
			// 해당 신청사유가 있을경우 지급 금액 매핑
			var HLP1_AMT = dsT_AD_AIDAMT.NameValue(0,"HLP1_AMT");
			var HLP2_AMT = dsT_AD_AIDAMT.NameValue(0,"HLP2_AMT");

			document.form1.medHLP1_AMT.Text = HLP1_AMT;
			document.form1.medHLP2_AMT.Text = HLP2_AMT;
			document.form1.medSUM_AMT.Text  = HLP1_AMT+HLP2_AMT;
			document.form1.hidAID_RPT.value = dsT_AD_AIDAMT.NameValue(0,"AID_RPT");

			// 근로구분 사번 앞자리 3:계약직 	//계약직 공조금 급여공제없으므로 지급없음
            if (document.getElementById("txtENO_NO").value.substr(0,1)  == "3") {
					document.form1.medHLP1_AMT.Text = 0;
					document.form1.medSUM_AMT.Text  = HLP2_AMT;
                }
			if( (HLP1_AMT == "" || HLP1_AMT == "0") && (HLP2_AMT == "" || HLP2_AMT == "0") ){
				alert("신청인은 선택한 신청사유에 대한 해당사항이 없습니다.");
			}
        }
    </Script>

    <!-- 결재자 있을 경우 -->
	<Script For=dsT_AD_DECISION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {

		} else {

            //신청자 사번
            document.getElementById("txtA1_ENO_NM").innerText   = "";
            document.getElementById("txtA1_APP_STS").innerText  = "";
            document.getElementById("txtA2_ENO_NM").innerText   = "";
            document.getElementById("txtA2_APP_STS").innerText  = "";


            for(var i=1; i<=dsT_AD_DECISION.CountRow; i++) {
                document.getElementById("txtA"+i+"_ENO_NM").innerText   = dsT_AD_DECISION.NameString(i, "JOB_NM")+" "+dsT_AD_DECISION.NameString(i, "ENO_NM");
                document.getElementById("txtA"+i+"_APP_STS").innerText  = dsT_AD_DECISION.NameString(i, "APP_YN_NM");
                document.getElementById("txtA"+i+"_ENO_NO").value = dsT_AD_DECISION.NameString(1, "ENO_NO");

            }

            //결재자 정보 조회뒤 권한에 따른 버튼 활성화
            checkAidStatus();
        }
    </Script>

    <!-- 근속일자를 조회해 왔을때 -->
	<Script For=dsLSE_YMD Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {

		} else {
            document.form1.txtLSE_YY.value  = dsLSE_YMD.NameValue(0,"LSE_YY");
            document.form1.txtLSE_MM.value  = dsLSE_YMD.NameValue(0,"LSE_MM");
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_AD_AIDAMT Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_AD_DECISION Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
        //에러 메세지가 있는 여부를 파악한 후 알림
        if (dsRESULT.Countrow == 1 && dsRESULT.NameString(0, "RESULT_MSG") != "") {
            alert(dsRESULT.NameString(0, "RESULT_MSG"));
        } else {
            dsRESULT.ClearData();

/*           var aid_cd = dsT_AD_AIDAPP.NameString(0, "AID_CD");
            if(dsT_AD_AIDAPP.CountRow != 0
                    && (   aid_cd == "AE"
                        || aid_cd == "AF"
                        || aid_cd == "AK"
                        || aid_cd == "AL"
                        || aid_cd == "AX"
                        || aid_cd == "AY"
                        || aid_cd == "AQ"
                        || aid_cd == "AR"
                        || aid_cd == "AS"
                        || aid_cd == "AT"
                        || aid_cd == "AZ"
                        || aid_cd == "BA"))
                alert("경조대상자의 가족관계증명서를 경영지원실 담당자에게 제출하시기 바랍니다.");
            else if(dsT_AD_AIDAPP.CountRow != 0  && aid_cd == "AD")
                alert("경조대상자의 주민등록등본을 경영지원실 담당자에게 제출하시기 바랍니다.");
            else
                alert("처리가 완료되었습니다.");    */

            fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

            //삭제 후 row가 남지 않았으면 창을 닫는다.
            if(dsT_AD_AIDAPP.CountRow == 0) {
                window.close();
            }

            //강제 insert 처리 원래대로
            dsT_AD_AIDAPP.UseChangeInfo = true;
            dsT_AD_DECISION.UseChangeInfo = true;

            //신규일때(TYPE1) 새로생성된 신청번호와 TYPE 코드를 가지고 새로 조회를 해 처리된 데이터를 가지고 온다.
            if(prmTYPE == "TYPE1")  {
                prmREQ_NO   = document.getElementById("txtREQ_NO").value;    //신청번호
                prmTYPE     = "TYPE2";       //"TYPE1" : 신규, "TYPE2" : 결재 처리, "TYPE3" : 전표, 지급처리
            }

            fnc_OnLoadProcess();
        }
    </script>
	<script for=trT_AD_AIDAPP2 event="OnSuccess()">
        //강제 insert 처리 원래대로
        dsT_AD_AIDAPP.UseChangeInfo = true;
        dsT_AD_DECISION.UseChangeInfo = true;
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   				       |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>
	<script for=trT_AD_AIDAPP2 event="OnFail()">
        alert(trT_AD_AIDAPP2.ErrorMsg);
    </script>

	<!-- 파일 그리드 클릭시 다운로드 되게 -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");

            // 첨부 파일이 존재하는 경우만 수행하게~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">경공조금신청서상세</td>
					<td align="right" class="navigator">HOME/복리후생/경공조금/<font color="#000000">경공조금신청서상세</font></td>
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
	            <img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)" style="cursor:hand;">
				<img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)" style="cursor:hand;">
                <img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)" style="cursor:hand;">
	            <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)" style="cursor:hand;">
	            <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)" style="cursor:hand;">
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

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

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr height="50">
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>&nbsp;</td>
                    <td align="center" align="right">
                        <div id="procBTN" style="display:none;position:absolute">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                                    <img src="/images/button/btn_SelectapprovalOn.gif"  id="btnDEC"     onClick="fnc_btnDEC()" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEC','','/images/button/btn_SelectapprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_SaveOn.gif"            id="btnSave"    onClick="fnc_btnDEC();fnc_Save()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnSave','','/images/button/btn_SaveOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_ReportOn.gif"          id="btnS"       onClick="fnc_btnS()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnS','','/images/button/btn_ReportOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_ApprovalOn.gif"        id="btnO"       onClick="fnc_btnO()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnO','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_RejectionOn.gif"       id="btnR"       onClick="fnc_btnR()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnR','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                        <div id="popupBTN" style="display:none;position:absolute">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="left">
                                    <img src="/images/button/btn_SendbackOn.gif"        id="btnC"       onClick="fnc_btnC()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnC','','/images/button/btn_SendbackOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_SlipOn.gif"            id="btnD"       onClick="fnc_btnD()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnD','','/images/button/btn_SlipOver.gif',1)" style="cursor:hand;">
                                    <img src="/images/button/btn_PaymentOn.gif"         id="btnE"       onClick="fnc_btnE()"   border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnE','','/images/button/btn_PaymentOver.gif',1)" style="cursor:hand;">
                                </td>
                            </tr>
                            </table>
                        </div>
                    </td>
					<td>&nbsp;</td>
					<td align="right">
    					<table border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse"  bordercolor="#999999" align="right">
        					<tr align="center" height="25">
        						<td rowspan="2" class="creamBold" width="50">결재<br>현황
                                    <input type="hidden" id="txtA1_ENO_NO">
                                    <input type="hidden" id="txtA2_ENO_NO">
                                </td>
                                <td id="txtA1_ENO_NM" width="120"></td>
                                <td id="txtA2_ENO_NM" width="120"></td>
        					</tr>
        					<tr align="center" height="25">
                                <td id="txtA1_APP_STS"></td>
                                <td id="txtA2_APP_STS"></td>
        					</tr>
    					</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="100"></col>
				<col width="60"></col>
				<col width="80"></col>
				<col width="60"></col>
				<col width="60"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="creamBold">신청번호</td>
			<td class="padding2423"><input id="txtREQ_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>

            <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo();">
                <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                <input type="hidden" id="hidEMPL_DPT_CD">
            </td>
            <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm();" onchange="fnc_SearchEmpNm();">
            </td>

			<td align="center" class="creamBold">직위</td>
			<td class="padding2423">
				<input id="txtJOB_NM" class="input_ReadOnly" size="10" readonly>
				<input type="hidden" id="hidOCC_CD" value="">
				<input type="hidden" id="hidJOB_CD" value="">
                <input type="hidden" id="hidDPT_CD" value="">
                <input type="hidden" id="hidAID_RPT" value="">
			</td>
			<td align="center" class="creamBold">부서</td>
			<td class="padding2423">
				<input id=txtDPT_NM class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">주민번호</td>
			<td class="padding2423"><input id="txtCET_NO" class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">입사일</td>
			<td class="padding2423"><input id="txtHIR_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">퇴사일</td>
			<td class="padding2423"><input id="txtRET_YMD" class="input_ReadOnly" size="10" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">근속년수</td>
			<td class="padding2423"><input id="txtLSE_YY" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
			<td align="center" class="creamBold">근속월수</td>
			<td class="padding2423"><input id="txtLSE_MM" class="input_ReadOnly" size="5" style="ime-mode:disabled" readonly></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="8" class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> 공조사항이 발생하게 된 대상자의 성명, 주민번호, 발생일자</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="60"></col>
				<col width="110"></col>
				<col width="100"></col>
				<col width="110"></col>
				<col width="80"></col>
				<col width="110"></col>
				<col width="80"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="creamBold">신청사유</td>
			<td class="padding2423">
				<select id="cmbAID_CD" style="WIDTH: 100%"  onChange="getRet_ymd();changeAidYmd();"></select>
    		</td>
			<td align="center" class="creamBold">대상자주민번호</td>
			<td class="padding2423"><input id="txtAID_CET" size="17" maxLength="14" style="ime-mode:disabled" onKeypress="cfCheckNumber5();"></td>
			<td align="center" class="creamBold">대상자성명</td>
			<td class="padding2423"><input id="txtAID_NM" size="17" maxLength="4"></td>
			<td align="center" class="creamBold">발생일자</td>
			<td class="padding2423">
				<input type="text" id="txtAID_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);changeAidYmd();" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAID_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgAID_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtAID_YMD','','595','100');"></a>
			</td>
		</tr>
		<!--
		<tr>
			<td align="center" class="creamBold">은행명</td>
			<td class="padding2423">
				<select id="cmbABA_CD" style="WIDTH: 100%"></select>
			</td>
			<td align="center" class="creamBold">예금주</td>
			<td class="padding2423"><input id="txtREC_NM"size="17" maxLength="4" onFocusOut="checkNAME();"></td>
			<td align="center" class="creamBold">계좌번호</td>
			<td class="padding2423"><input id="txtACC_NO"size="17" maxLength="18" style="ime-mode:disabled"  onkeypress="cfCheckNumber();"></td>
			<td align="center" class="creamBold">신청일자</td>
			<td class="padding2423"><input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly></td>
		</tr>
		-->
		<tr>
			<td align="center" class="creamBold">제출서류<br>첨부</td>
			<td class="padding2423" colspan="5">
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:60px;">
                    <param name="DataID" value="dsFILE">
                    <param name="Editable" value="false">
                    <param name="DragDropEnable" value="true">
                    <param name="SortView" value="Left">
                    <param name=ViewHeader  value="false">
                    <param name="Format" value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="270"     name="파일명"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>

			</td>
			<td align="center" class="creamBold">신청일자</td>
			<td class="padding2423"><input type="text" id="txtREQ_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly></td>
		</tr>
		<tr>
			<td align="center" class="creamBold">공조금</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medHLP1_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">경조금</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
					<comment id="__NSID__"><object id="medHLP2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">원</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">지급금액</td>
			<td class="padding2423">
				<table width="100%" border="0" >
				<tr>
					<td width="90%">
						<comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
				<td align="center" class="creamBold">지급일자</td>
				<td class="padding2423">
				    <input type="text" id="txtSPL_YMD"  style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSPL_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="ImgSPL_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSPL_YMD','','595','170');" disabled=true></a>
				</td>
			</tr>
			<tr>
			<td align="center" class="creamBold">관리번호</td>
			<td class="padding2423"><input id="txtWORK_NO1" class="input_ReadOnly" size="17" maxLength="3" readonly></td>
			<td align="center" class="creamBold">상태</td>
			<td class="padding2423">
                <input type="text" id="txtAID_STS_NM" class="input_ReadOnly" size="17" maxLength="3" readonly>
                <input type="hidden" id="txtAID_STS">
			</td>
			<td align="center" class="creamBold">부결사유</td>
				<td class="padding2423" colspan="3"><input id="txtRET_RSN" class="input_ReadOnly" size="31" maxLength="15" ></td>
			</tr>
			</table>
			</td>
		</tr>
        <tr>
            <td colspan="8" class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <tr>
                    <td>[신청서 사용법 - 아래의 순서대로 작업하세요]<br>
                    &nbsp;&nbsp;1. 신청사유를 선택하세요. <br>
                    &nbsp;&nbsp;2. 대상자 성명과 발생일자는 공조사항이 발생하게 된 대상자의 성명과 날짜입니다.<br>
                    &nbsp;&nbsp;3. 신청서의 해당내용 입력이 끝나면 저장 -결재자 지정(본인 팀장) - 상신 버튼을 누릅니다.
                    </td>
                </tr>
            </table>
            </td>
        </tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	</form>
	<!-- form 끝 -->

</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_AIDAPP 설정 테이블 -->
	<object id="bndT_AD_AIDAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDAPP">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO		Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=AID_YMD		Ctrl=txtAID_YMD		Param=value</C>
			<C>Col=CET_NO		Ctrl=txtCET_NO		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=RET_YMD		Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=LSE_YY		Ctrl=txtLSE_YY		Param=value</C>
			<C>Col=LSE_MM		Ctrl=txtLSE_MM		Param=value</C>
			<C>Col=ABA_CD		Ctrl=cmbABA_CD		Param=value</C>
			<C>Col=ACC_NO		Ctrl=txtACC_NO		Param=value</C>
			<C>Col=REC_NM		Ctrl=txtREC_NM		Param=value</C>
			<C>Col=AID_CD		Ctrl=cmbAID_CD		Param=value</C>
			<C>Col=AID_NM		Ctrl=txtAID_NM		Param=value</C>
			<C>Col=AID_RPT		Ctrl=hidAID_RPT		Param=value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=HLP1_AMT		Ctrl=medHLP1_AMT	Param=text</C>
			<C>Col=HLP2_AMT		Ctrl=medHLP2_AMT	Param=text</C>
			<C>Col=SUM_AMT		Ctrl=medSUM_AMT		Param=text</C>
			<C>Col=WORK_NO1		Ctrl=txtWORK_NO1	Param=value</C>
			<C>Col=SPL_YMD		Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=AID_STS		Ctrl=txtAID_STS		Param=value</C>
			<C>Col=AID_STS_NM	Ctrl=txtAID_STS_NM	Param=value</C>
			<C>Col=RET_RSN		Ctrl=txtRET_RSN		Param=value</C>
			<C>Col=AID_CET		Ctrl=txtAID_CET		Param=value</C>
			<C>Col=DEC1_NM		Ctrl=txtDEC1_NM		Param=value</C>
			<C>Col=DEC1_YMD		Ctrl=txtDEC1_YMD	Param=value</C>
			<C>Col=DEC2_NM		Ctrl=txtDEC2_NM		Param=value</C>
			<C>Col=DEC2_YMD		Ctrl=txtDEC2_YMD	Param=value</C>
		">
	</object>