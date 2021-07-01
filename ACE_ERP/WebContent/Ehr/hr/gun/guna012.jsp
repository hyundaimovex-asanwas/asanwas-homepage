	<!--*************************************************************************
	* @source      : guna012.jsp												*
	* @description : 개인별근태등록 PAGE										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------*
	* 2016/06/01      이동훈        ERP 이사
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
	String MODE = request.getParameter("MODE");

	String str_ymd_shr = request.getParameter("str_ymd_shr");
	String end_ymd_shr = request.getParameter("end_ymd_shr");

	String param_eno_no = request.getParameter("eno_no");
	String param_req_no = request.getParameter("req_no");
	String param_app_yn_nm = request.getParameter("app_yn_nm");
%>


<html>
<head>
<title>근태신청</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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


        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			var REQ_NO_SHR = document.getElementById("txtREQ_NO_SHR").value;
			
			trT_DI_DILIGENCE_SHR.KeyValue = "tr05(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			
			trT_DI_DILIGENCE_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna012.cmd.GUNA012CMD"
										                                   + "&S_MODE=SHR"
										                                   + "&REQ_NO="+REQ_NO_SHR;
			
			trT_DI_DILIGENCE_SHR.post();
			
			
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
			trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_APPROVAL=dsT_DI_APPROVAL,O:dsT_DI_DILIGENCE_TEMP=dsT_DI_DILIGENCE_TEMP)";
			
			trT_DI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna012.cmd.GUNA012CMD&S_MODE=SAV";
			
			trT_DI_DILIGENCE.post();
			
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
			// 행 추가
			dsT_DI_DILIGENCE.AddRow();

		    //마스터가 아니면 소속 부서만 조회 하게
			if(gusrid != "6060002" && gusrid != "6070001" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003"){ 

					if(dsT_DI_DILIGENCE.CountRow > 1){
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;
					}else{
		
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
						dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;
					}
					
					fnc_ChangeStateElement(false, "ImgEnoNo");
					fnc_ChangeStateElement(false, "txtENO_NO");
					fnc_ChangeStateElement(false, "txtENO_NM");
					fnc_ChangeStateElement(true, "txtREMARK");
					fnc_ChangeStateElement(true, "cmbGUN_CD");
					fnc_ChangeStateElement(true, "txtPIS_YYMMDD");
					fnc_ChangeStateElement(true, "ImgStrYmd");
					

    	}else{


				if(dsT_DI_DILIGENCE.CountRow > 1){
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "REQ_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NO");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "ENO_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_CD");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "DPT_NM");
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition-1, "JOB_NM");
				}else{
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO") = gusrid;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM") = gusrnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_CD") = gdeptcd;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "DPT_NM") = gdeptnm;
					dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "JOB_NM") = gjobdty;
				}
				
				fnc_DisableElementAll(elementList);
				
				fnc_ChangeStateElement(true, "ImgEnoNo");
				fnc_ChangeStateElement(true, "txtENO_NO");
				fnc_ChangeStateElement(true, "txtENO_NM");
				fnc_ChangeStateElement(true, "txtREMARK");
				fnc_ChangeStateElement(true, "cmbGUN_CD");
				fnc_ChangeStateElement(true, "txtPIS_YYMMDD");
				fnc_ChangeStateElement(true, "ImgStrYmd");

    	}


			document.form1.cmbGUN_CD.selectedIndex = 0;
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			
	        if (dsT_DI_DILIGENCE.CountRow < 1) {
	        	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("삭제 할 자료가 없습니다!");
                
                return;
                
            }else{
            	
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";

				var ENO_NO = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO");
				var PIS_YYMMDD = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "PIS_YYMMDD");
            	tmpMSG += "등록번호 = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO")+"\n";
            	tmpMSG += "근태일   = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "PIS_YYMMDD")+"\n";
            	tmpMSG += "사번       = "+ENO_NO+"\n";
            	tmpMSG += "성명       = "+dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NM")+"\n";

	            if( confirm(tmpMSG) ){
	            	
					var REQ_NO = dsT_DI_DILIGENCE.nameValue(dsT_DI_DILIGENCE.RowPosition, "REQ_NO");
					
					dsT_DI_DILIGENCE.DeleteRow(dsT_DI_DILIGENCE.RowPosition);
					

					
					if(REQ_NO == ""){
						
						return;
						
					}

					// 파라미터 추가
					trT_DI_DILIGENCE.Parameters = "REQ_NO="+REQ_NO+"&ENO_NO="+ENO_NO+"&PIS_YYMMDD="+PIS_YYMMDD;

					trT_DI_DILIGENCE.KeyValue = "tr01(I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
					
					trT_DI_DILIGENCE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna012.cmd.GUNA012CMD&S_MODE=DEL";
					
					trT_DI_DILIGENCE.post();
					
				}
	            
			}
	        
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {

			document.form1.cmbGUN_CD.selectedIndex = 0;        // 근태(입력)

        	dsT_DI_DILIGENCE.ClearData();
			
			dsT_DI_APPROVAL.ClearData();
			
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			
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
			
			if(dsT_DI_APPROVAL.CountRow < 1){
				
				alert("결재선을 하나이상 지정해 주십시요");
				
				return false;
				
			}
			
         	if ( !dsT_DI_DILIGENCE.isUpdated && !dsT_DI_APPROVAL.isUpdated) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
                
			}
         	
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_DI_DILIGENCE.SetDataHeader(
        	        			"REQ_NO:STRING(11),"+			// 시작일자
								"PIS_YYMMDD:STRING(10),"+			// 시작일자
	        					"ENO_NO:STRING(10),"+			// 등록번호
	                            "DPT_NM:STRING(20),"+			// 소속
	                            "DPT_CD:STRING(20),"+			// 소속
								"JOB_NM:STRING(20),"+			// 직위
								"ENO_NM:STRING(10),"+			// 성명
								"GUN_CD:STRING(10),"+			// 근태항목
								"REMARK:STRING(50)"			// 비고
								);

	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"DPT_CD:STRING(6),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"SEQ_NO:STRING(1),"+			// 결재선
								"ENO_NO:STRING(10),"+			// 결재자사번
								"JOB_CD:STRING(10),"+			// 결재자직위
								"APP_TIME:STRING(10),"+			// 결재시간
								"PENO_NO:STRING(10),"+			// 상신자사번
								"APP_YN:STRING(10),"+			// 결재여부
								"ENO_NM:STRING(10),"+			// 결재자명
								"JOB_NM:STRING(10)"				// 직위명
								);

			cfStyleGrid_New(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style 적용

			document.getElementById("txtREQ_NO_SHR").value = "<%=param_req_no%>";
			
			document.getElementById("resultMessage").innerText = '*** 작업순서 : 신규 버튼 => 근태종류/일자 입력 => 결재선지정 => 상신 ***';
			
        	// 근태(입력)
        	var h4_cd = "";

			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {

                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE");

                
                
			    if(h4_cd == "C" || h4_cd == "E" || h4_cd == "F" || h4_cd == "M" || h4_cd == "D" || h4_cd == "W" || h4_cd == "Y" || h4_cd == "N" || h4_cd == "O" ||  h4_cd == "9" || h4_cd == "K" ||  h4_cd == "L"){

                    continue;

			    }

 
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD").add(oOption);
			}


            if("<%=param_app_yn_nm%>" =="결재완료" || "<%=param_app_yn_nm%>" =="결재진행중"){
            	
                document.getElementById("append_btn").style.display = "none";
                document.getElementById("btn_InsDel").style.display = "none";
                
            }else{
            	
                document.getElementById("append_btn").style.display = "";
                document.getElementById("btn_InsDel").style.display = "";
                
            }

            document.getElementById('hidEMPL_DPT_CD').value = gdeptcd;


            fnc_OnLoadApproval();
            
            
<%
	if("READ".equals(MODE)){
%>
		fnc_SearchList();

		fnc_SearchYRP("<%=param_eno_no%>") ;

<%
	}else{

%>
		fnc_SearchYRP(gusrid) ;

<%
	}
%>
			 fnc_DisableElementAll(elementList);

			fnc_ChangeStateElement(true, "txtREMARK");
			fnc_ChangeStateElement(true, "cmbGUN_CD");
			fnc_ChangeStateElement(false, "txtPIS_YYMMDD");
			fnc_ChangeStateElement(true, "ImgStrYmd");

        }

        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"cmbGUN_CD"
                                    ,"txtREMARK"
                                    ,"txtPIS_YYMMDD"
                                    ,"ImgStrYmd"
                                     );

        function fnc_OnLoadApproval() {

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,15,"true","false");     // Grid Style 적용
			
			form1.grdT_DI_APPROVAL.TitleHeight = 25;
			form1.grdT_DI_APPROVAL.RowHeight   = 25;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = false;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {

    		//마스터가 아니면 소속 부서만 조회 하게
		    if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {

				document.getElementById("hidEMPL_DPT_CD").value  = "";

			}

            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

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

		    //마스터가 아니면 소속 부서만 조회 하게
		    if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
		    	
				document.getElementById("hidEMPL_DPT_CD").value  = "";

			}
           
			fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            fnc_SearchEmpNo();
            
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
        	
            var obj = new String;

    		//마스터가 아니면 소속 부서만 조회 하게
		    if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
			
				document.getElementById("hidEMPL_DPT_CD").value  = "";

			}
    		
            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
            	
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;

                dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition,"DPT_CD") = obj.dpt_cd;
                
				fnc_SearchYRP(obj.eno_no) ;

            } else {
            	
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                
            }

        }


        //지나간 날짜인지 체크
        function fnc_ChkDate() {

            var PIS_YYMMDD = document.getElementById("txtPIS_YYMMDD").value.replace("-","").replace("-","");
            
            var today = gcurdate.replace("-","").replace("-","");

            if(PIS_YYMMDD != ""){
            	
	            if(PIS_YYMMDD < today){
	            	
	                alert("이미 지나간 일자는 등록할수 없습니다.");
	                document.getElementById("txtPIS_YYMMDD").value = "";
	                document.getElementById("txtPIS_YYMMDD").focus();
	                return false;
	                
	            }
	            
            }

        }
        
        
        
        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			if(dsT_DI_DILIGENCE.CountRow < 1){
				alert("근태내역을 먼저 등록하십시요.");
				return;
			}
			
			if(dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD")== "" || dsT_DI_DILIGENCE.NameValue(1,"ENO_NO")==""){
				alert("근태내역을 먼저 등록하십시요.");
				return;
			}
			
            //ds를 리턴받는다.

			var STR_YMD_SHR = "<%=str_ymd_shr%>";
			var END_YMD_SHR = "<%=end_ymd_shr%>";
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
			var EMP_NO      = dsT_DI_DILIGENCE.NameValue(dsT_DI_DILIGENCE.RowPosition, "ENO_NO");

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"C");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
            	
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";  //dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// 서무가 일별 근태에서 결재자 뜨지 않게 하기위해서...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = dsT_DI_DILIGENCE.NameValue(1,"ENO_NO");
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "C";
				
<%
	if("READ".equals(MODE)){
%>
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "<%=param_req_no%>";
<%
	}else{
%>
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
<%
	}
%>
            }
        }

		/********************************************
         * 01. 연차정보의 조회 			 	*
         ********************************************/
        function fnc_SearchYRP(ENO_NO) {
			
			var today = gcurdate.replace("-","").replace("-","").substring(0,4);
			
			trT_DI_YEARLY.KeyValue = "tr06(O:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			
			trT_DI_YEARLY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna012.cmd.GUNA012CMD"
												                                   + "&S_MODE=SHR_YRP"
												                                   + "&YYYY="+today+"&ENO_NO="+ENO_NO;
			
			trT_DI_YEARLY.post();
		}
		
		
		/********************************************
         * 01. 연차체크 			 	            *
         ********************************************/
        function fnc_YrpCheck() {

			var NEW_GUN_CD = document.getElementById("cmbGUN_CD").value;		//신규 근태코드
			
			var PIS_YYMMDD = document.getElementById("txtPIS_YYMMDD").value.replace("-","").replace("-","");  // 근태일자 6.30일까지는 근태 신청 가능, 7월 이후꺼는 신청 불가
			
			var MF_TAG     = dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "MF_TAG");

			// 여직원 휴가 Check
			if(NEW_GUN_CD == "J" && MF_TAG == "M"){
				alert("남자직원은 여직원 휴가를 사용할수 없습니다.");
				document.getElementById("cmbGUN_CD").value = "";
				return;

			}
			
			
			// 2020.07.08 연차촉진제를 쓰시라고 
    		// 2020.07.20 연차촉진제 해당 안되는 몇 명은 빼주자 일단 장대원 + 곽진희 사원 + 이영현 사원
   			// 2021년도에 보자. 또 볼까?
   			// 2021년도에 또 보네	ㅎㅎㅎㅎㅎ 이제 진짜 얼마 안 남았다!!!! 	
    		
 		    if(gusrid != "6060001" && gusrid != "3200001" ){
			
				if(NEW_GUN_CD == "H" || NEW_GUN_CD == "P" || NEW_GUN_CD == "R" ){
					
					
					if(PIS_YYMMDD > "20210700"){					
					
						alert("2021년 7월 이후 연차, 반차 신청은\n\n반기별 연차사용 계획 메뉴를 이용하시기 바랍니다.\n\n문의사항은 경영지원팀에게 연락바랍니다.");
						document.getElementById("cmbGUN_CD").value = "";
						return;
					
					}
					
					
	
				}
			
		    }
			
			

			//15일보다 적은 사람은 선연차신청가능
			//15일보다 많은 사람은 선연차신청불가
			//사용가능한여차
			var YRP_CNT = document.getElementById("txtYRP_CNT").value;			//연차
			var AYRP_CNT = document.getElementById("txtAYRP_CNT").value;		//선연차
			var NET_YRP_CNT = document.getElementById("txtNET_YRP_CNT").value;	//연차발생일수
			var YRP_USE = document.getElementById("txtYRP_USE").value;			//사용한연차
			var ADD_YRP_CNT = 0;

			//H:연차, P:오전연반차, R:오후연반차
			 for(var i = 1; i<= dsT_DI_DILIGENCE.countrow; i++ ) {
				 
				 GUN_CD = dsT_DI_DILIGENCE.NameValue(i,"GUN_CD");
				 
				 if(GUN_CD == "H"){
					 
					ADD_YRP_CNT += 1;
					
				 }else if(GUN_CD == "P"){
					 
					ADD_YRP_CNT += 0.5;
					
				 }else if(GUN_CD == "R"){
					 
					ADD_YRP_CNT += 0.5;
					
				 }
			 }

			if(NEW_GUN_CD == "H"){
				
				if(NET_YRP_CNT - YRP_USE - ADD_YRP_CNT  <= 0){
					
					alert("선연차를 사용합니다");
					
				}
				
			}else if(NEW_GUN_CD == "P" || NEW_GUN_CD == "R"){
				
				if(NET_YRP_CNT - YRP_USE - ADD_YRP_CNT  <= 0){
					
					alert("선연차를 사용합니다");
					
				}

			}

		}
    </script>
    
</head>

	<!--**************************************************************************************
    *                                                                                        *
    * Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_DILIGENCE)		   |
    | 3. 사용되는 Table List(T_DI_DILIGENCE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)		   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_YEARLY                       |
    | 3. Table List : T_DI_YEARLY                   |
    +----------------------------------------------->
    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,I:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_YEARLY)		       |
    | 3. 사용되는 Table List(T_DI_YEARLY)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_YEARLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr06(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    		value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    		value="H4"/>
       <jsp:param name="SYNCLOAD"      		value="false"/>
       <jsp:param name="USEFILTER"     		value="false"/>
    </jsp:include>



	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE_TEMP Event="OnLoadCompleted(iCount)">
        alert("상신이 완료되었습니다");
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
<%
	if("READ".equals(MODE)){
%>
		document.getElementById("txtREQ_NO_SHR").value  = "<%=param_req_no%>";
<%
	}else{
%>
	document.getElementById("txtREQ_NO_SHR").value  = dsT_DI_DILIGENCE_TEMP.NameValue(1, "REQ_NO");
<%
	}
%>

        fnc_SearchList();
        
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_YEARLY event="OnSuccess()">

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_YEARLY event="OnFail()">

    </script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_DI_DILIGENCE event=CanRowPosChange(row)>

		if ( dsT_DI_DILIGENCE.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_DI_DILIGENCE.GetHdrDispName('-3','ENO_NO') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_DI_DILIGENCE.NameValue(row,"PIS_YYMMDD") == "" ) {
			alert("[ " + grdT_DI_DILIGENCE.GetHdrDispName('-3','PIS_YYMMDD') + " ]은 필수 입력사항입니다");
			return false;
		}
		if ( dsT_DI_DILIGENCE.NameValue(row,"GUN_CD") == "" ) {
			alert("[ " + grdT_DI_DILIGENCE.GetHdrDispName('-3','GUN_CD') + " ]은 필수 입력사항입니다");
			return false;
		}
	</script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_DI_DILIGENCE event=OnRowPosChanged(row)>

    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">
	<input type="hidden" id="txtREQ_NO_SHR">
	<input type="hidden" id="txtAYRP_CNT">
	<input type="hidden" id="txtYRP_CNT">



	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>

			<td height="35" class="paddingTop5" align="right">
			<span id="append_btn" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ReportOver.gif',1)">  <img src="../../images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			</span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->


	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="120"></col>
					<col width="200"></col>
					<col width="120"></col>
					<col width="200"></col>
					<col width="120"></col>
					<col width=""></col>
				</colgroup>

				<tr>
					<td class="blueBold" align="center">연차발생일수</td>
                    <td class="padding2423">
                       <input id="txtNET_YRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>

					<td align="center" class="blueBold">연차사용일수</td>
					<td class="padding2423">
					 <input id="txtYRP_USE" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
					</td>
					<td align="center" class="blueBold">미사용연차수</td>
					<td class="padding2423">
					 <input id="txtNOT_YRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
					</td>
				</tr>


				<tr>
					<td class="blueBold" align="center">월차발생일수</td>
                    <td class="padding2423">
                       <input id="txtMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
                    </td>

					<td align="center" class="blueBold">월차사용일수</td>
					<td class="padding2423">
					 <input id="txtUMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>일
					</td>
					<td align="center" class="blueBold">미사용월차수</td>
					<td class="padding2423">
					 <input id="txtLMPH_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>일
					</td>
				</tr>

				<tr>
					<td class="blueBold" align="center">사&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="blueBold">소&nbsp;&nbsp;&nbsp;속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="blueBold"></td>
					<td class="padding2423"></td>
				</tr>
				<tr>
					<td class="blueBold" align="center">근태일</td>
					<td class="padding2423" >
                        <input id="txtPIS_YYMMDD" name="txtPIS_YYMMDD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YYMMDD','','20','120');"></a>
					</td>
					<td align="center" class="blueBold">근&nbsp;&nbsp;&nbsp;태</td>
                    <td class="padding2423" align="left">
                        <select id="cmbGUN_CD" style="width='150';" onChange="fnc_YrpCheck()" >
							<option value="">&nbsp;</option>
						</select>                    
                    </td>
					<td class="blueBold" align="center"></td>
					<td class="padding2423" align="left"  colspan="3">

					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="30">
						<td align="left" class="hrTextGreen"><span id="resultMessage">&nbsp;</span></td>
	                    <td align="right">
	                        <span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
			            </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	<!-- 결재선 테이블 시작 -->
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" cellspacing="0" cellpadding="0" >
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td width="500">
					<comment id="__NSID__">
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:480px;height:300px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=50		name="NO"				align=center		value={String(Currow)}</C>
                            <C> id="PIS_YYMMDD" 	width=200    	name="근태일"       	align=center    	edit=none    </C>
							<C> id="GUN_CD"			width=200		name="근태항목"			align=center		edit=none    EditStyle=Lookup  Data="dsT_CM_COMMON_H4:CODE:CODE_NAME" 	</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:300px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
	            					<C> id='SEQ_NO'		width=40		name='NO'			align=center	</C>
	            					<C> id='DPT_NM'		width=150		name='부서'			align=center	</C>
									<C> id='JOB_NM'		width=90		name='직위'			align=center	</C>
									<C> id='ENO_NM'		width=100		name='성명'			align=center	</C>
									<C> id='APP_YN'		width=80		name='결재여부'		align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')} </C>
								">
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
	*	바인딩 컴포넌트																		 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_DI_DILIGENCE 설정 테이블 -->
	<object id="bndT_DI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_DILIGENCE">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO				Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM				Ctrl=txtENO_NM			Param=value</C>
			<C>Col=DPT_NM				Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM				Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=GUN_CD				Ctrl=cmbGUN_CD			Param=value</C>
			<C>Col=REMARK				Ctrl=txtREMARK			Param=value</C>
			<C>Col=PIS_YYMMDD			Ctrl=txtPIS_YYMMDD 		Param=value</C>
		">
	</object>

	<!-- T_DI_YEARLY 설정 테이블 -->
	<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_DI_YEARLY">
		<Param Name="BindInfo", Value="
			<C>Col=YRP_CNT				Ctrl=txtYRP_CNT				Param=value</C>
			<C>Col=AYRP_CNT				Ctrl=txtAYRP_CNT			Param=value</C>
			<C>Col=NET_YRP_CNT			Ctrl=txtNET_YRP_CNT			Param=value</C>
			<C>Col=YRP_USE				Ctrl=txtYRP_USE				Param=value</C>
			<C>Col=NOT_YRP_CNT			Ctrl=txtNOT_YRP_CNT			Param=value</C>
			<C>Col=MPH_CNT				Ctrl=txtMPH_CNT				Param=value</C>
			<C>Col=UMPH_CNT				Ctrl=txtUMPH_CNT			Param=value</C>
			<C>Col=LMPH_CNT				Ctrl=txtLMPH_CNT			Param=value</C>			
		">
	</object>
	
	
	
	