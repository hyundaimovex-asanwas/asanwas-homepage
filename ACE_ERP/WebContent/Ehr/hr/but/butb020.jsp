<!--
*****************************************************
* @source       : butb020.jsp
* @description  : 해외출장품의서작성 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2010/03/11      권혁수        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String ord_no = request.getParameter("ORD_NO");         //품의번호
	String eno_no = request.getParameter("PENO_NO");         //품의자사번
	String app_status = request.getParameter("APP_STATUS"); //결재상태
    String app_cmt = request.getParameter("APP_CMT");       //결재장의견
	String role_cd = box.getString("SESSION_ROLE_CD");         //롤권한
    //결재선사용을 위해 셋팅
    if(eno_no == null){
    	eno_no = (String)request.getSession().getAttribute("SESSION_ENONO");
    }

	System.out.println("ord_no [" + ord_no + "]");
	System.out.println("eno_no [" + eno_no + "]");
	System.out.println("app_status [" + app_status + "]");
	System.out.println("app_cmt [" + app_cmt + "]");

%>

<html>
<head>
<title>해외출장품의서작성(butc020)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'FFTTFTFT';

        var dsTemp = window.dialogArguments;

        var status = "";//현재 결재 상태

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            if(dsTemp != "Modal"){
                trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL)";
                trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_03&ORD_NO="+dsT_DI_DISPATCH.NameValue(1,"ORD_NO")+"&ENO_NO="+dsT_DI_DISPATCH.NameValue(1,"ENO_NO");
                trT_DI_DISPATCH_SHR.post();
            }else{
	        	trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL)";
				trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_03&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_DISPATCH_SHR.post();
			}

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //품의번호 조회
            dsORD_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SHR_01";
			dsORD_NO.reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;

            //품의번호 생성
            if(document.getElementById("txtORD_NO").value.trim() == ""){
				fnc_SearchItem();

				//결재선에 품의번호 입력
	            for(i=1; i<=dsT_DI_APPROVAL.CountRow; i++){
					dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");
	            }
            }

            var ord_no = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");

            var msgFlag = "";
            if(dsT_DI_DISPATCH.IsUpdated == true){
                var msgFlag = "Y";
            }
			for(var i = 1; i <= dsT_DI_OVERSEASTRIP_DTL.CountRow;i++){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(i,"ORD_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO");    //품의번호
			}
			trT_DI_DISPATCH.KeyValue = "tr(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL, I:dsT_DI_OVERSEASTRIP_DTL=dsT_DI_OVERSEASTRIP_DTL )";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_01&ORD_NO="+ord_no;
			trT_DI_DISPATCH.post();

            if(msgFlag == "Y"){
				alert("저장되었습니다. 상신하세요.");
       		}
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if(dsT_DI_OVERSEASTRIP_DTL.CountRow < 3){
                alert("출발일과 도착일은 있어야 합니다");
                return;
            }
			dsT_DI_OVERSEASTRIP_DTL.DeleteRow(dsT_DI_OVERSEASTRIP_DTL.RowPosition);
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {
            dsT_DI_OVERSEASTRIP_DTL.AddRow();
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"ORD_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO");    //품의번호
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"ENO_NO") = dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ENO_NO");    //품의번호
            dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NO") = dsT_DI_OVERSEASTRIP_DTL.CountRow;//순번

			var seq_no = dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NO");
			if(seq_no == "1"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "출발일"
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_YMDHM") = (dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"BUT_FR_YMD")).replaceStr("-","")+"0000";
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_FR_NAT") = "KR"
			}else if(seq_no == "2"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "도착일"
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"BUT_YMDHM") = (dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"BUT_TO_YMD")).replaceStr("-","")+"0000";
			}else{
				dsT_DI_OVERSEASTRIP_DTL.NameValue(dsT_DI_OVERSEASTRIP_DTL.RowPosition,"SEQ_NM") = "경유지"
			}
        }
        function fnc_Approval() {

            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO =  document.getElementById("txtENO_NO").value;

      		//ds를 리턴받는다.
            dsT_DI_APPROVAL.DeleteAll();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "E");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();
            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
				var tempEnoNo = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");

				dsT_DI_APPROVAL.addrow();
				dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ORD_NO");
				dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
				dsT_DI_APPROVAL.NameValue(i,"ENO_NM")= dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
				dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
				dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
				dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
				dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
				dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = i;
				dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "E";
				dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
            }
			fnc_AutoApproval(dsT_DI_APPROVAL.countrow);
        }

        /******************
         * 09. 제거 함수  *
         ******************/
         //미사용
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고
            if(dsT_DI_APPROVAL.CountRow < 2){
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			dsT_DI_APPROVAL.DeleteRow(1);

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			dsT_DI_DISPATCH.ClearData();
			dsT_DI_APPROVAL.ClearData();
            dsORD_NO.ClearData();
            fnc_InputEnable();

	        fnc_OnLoadProcess();

	        document.getElementById("imgSave").style.display = "";

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtBUT_FR_YMD").focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
                if (dsT_DI_DISPATCH.IsUpdated)  {
                    if (!fnc_ExitQuestion()) return;
                }
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }else{
                window.close();
            }
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {
			//이곳에 해당 코딩을 입력 하세요
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
            var but_fr_ymd = document.getElementById("txtBUT_FR_YMD");
            var but_to_ymd = document.getElementById("txtBUT_TO_YMD");
            var but_nat = document.getElementById("cmbBUT_NAT");
            var but_city = document.getElementById("txtBUT_CITY");
            var but_obj = document.getElementById("txtBUT_OBJ");
            /**
            var pc_cctrcd = document.getElementById("txtPC_CCTRCD");
            var pc_gbn = document.getElementById("txtPC_GBN");
            var wbs_fr_ymd = document.getElementById("txtWBS_FR_YMD");
            var wbs_to_ymd = document.getElementById("txtWBS_TO_YMD");
            **/
            var visa_yn = document.getElementById("cmbVISA_YN");
            var pass_yn = document.getElementById("cmbPASS_YN");
            var but_gbn = document.getElementById("cmbBUT_GBN");
            var currency_nm = document.getElementById("txtCURRENCY_NM");
            var ext_rate = document.getElementById("txtEXT_RATE");

			//alert("dsTemp : "+dsTemp+",    status : "+status);
            if(dsTemp == "Modal" && (status != "1" && status != "5")) return;//팝업일 경우

			if (!dsT_DI_DISPATCH.IsUpdated && !dsT_DI_APPROVAL.IsUpdated && !dsT_DI_OVERSEASTRIP_DTL.IsUpdated) {
                //alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

            if(dsT_DI_APPROVAL.CountRow < 4){
                alert("결재선을 지정하셔야 합니다!");
                return false;
            }

            if(but_fr_ymd.value == ""){
                alert("출장 시작일을 입력하세요!");
                but_fr_ymd.focus();
                return false;
            }
            if(but_to_ymd.value == ""){
                alert("출장 종료일을 입력하세요!");
                dis_to_ymd.focus();
                return false;
            }
            /**
            if(pc_cctrcd.value == ""){
                alert("전표코드를 입력하세요!");
                 document.getElementById("ImgSelectSlip").focus();
                return false;
            }
			if(pc_gbn.value == "W"){
				if(but_fr_ymd.value.replaceStr("-", "") < wbs_fr_ymd.value){
					alert("프로젝트보다 출장시작일이 늦습니다");
					 document.getElementById("txtBUT_FR_YMD").focus();
					return false;
				}
				if(but_to_ymd.value.replaceStr("-", "") > wbs_to_ymd.value){
					alert("프로젝트보다 출장종료일이 늦습니다");
					 document.getElementById("txtBUT_TO_YMD").focus();
					return false;
				}
			}
			**/
            if(but_nat.value == ""){
                alert("출장국가를 입력하세요!");
                but_nat.focus();
                return false;
            }
            if(but_city.value == ""){
                alert("출장지를 입력하세요!");
                but_city.focus();
                return false;
            }
            if(but_obj.value == ""){
                alert("출장목적을 입력하세요!");
                but_obj.focus();
                return false;
            }
			if(visa_yn.value == ""){
                alert("비자필요여부를 선택하세요!");
                visa_yn.focus();
                return false;
            }
			if(pass_yn.value == ""){
                alert("패스워드필요여부를 선택하세요!");
                pass_yn.focus();
                return false;
            }
			if(but_gbn.value == ""){
                alert("고객사구분을 선택하세요!");
                but_gbn.focus();
                return false;
            }
			if(currency_nm.value == ""){
                alert("여비지급기준을 입력하세요!");
                currency_nm.focus();
                return false;
            }
			if(ext_rate.value == "" || ext_rate.value == "0"){
                alert("환율을 입력하세요!");
                ext_rate.focus();
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.CountRow < 2){
                alert("출발지와 도착지를 지정하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_YMDHM") == ""){
                alert("출발일을 입력하셔야 합니다!");
                return false;
            }
			if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_YMDHM").length != 12){
                alert("출발일은 년-월-일-시-분 을 모두 입력해야합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_FR_NAT") == ""){
                alert("출발국가를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_FR_CITY") == ""){
                alert("출발도시를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TO_NAT") == ""){
                alert("도착국가를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TRA") == ""){
                alert("교통편을 선택 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(1, "BUT_TO_CITY") == ""){
                alert("도착도시를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_YMDHM") == ""){
                alert("출발일을 입력하셔야 합니다!");
                return false;
            }
			if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_YMDHM").length != 12){
                alert("출발일은 년-월-일-시-분 을 모두 입력해야합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_FR_NAT") == ""){
                alert("출발국가를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_FR_CITY") == ""){
                alert("출발도시를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TO_NAT") == ""){
                alert("도착국가를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TO_CITY") == ""){
                alert("도착도시를 입력 하셔야 합니다!");
                return false;
            }
            if(dsT_DI_OVERSEASTRIP_DTL.NameValue(2, "BUT_TRA") == ""){
                alert("교통편을 선택 하셔야 합니다!");
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			// 지역구분
			for( var i = 1; i <= dsT_CM_COMMON_L2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_L2.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_L2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbBUT_NAT").add(oOption);
			}

            if(dsTemp != "Modal"){ //팝업이 아닌경우
                fnc_BusinesstripInsert(); //품의서 작성시 설정
            }else{ //팝업인 경우
                fnc_OnLoadPop();
            }

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)

			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

			cfStyleGrid(form1.grdT_DI_OVERSEASTRIP_DTL,15,"true","false");      // Grid Style 적용

            //국가 조회
            dsT_CM_NAT.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=NAT_SHR";
			dsT_CM_NAT.reset();

			//환율저장버튼 보이게하기
			if( "1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>"){
				if("<%=app_status%>" == "4"){
					document.getElementById("btn_exchSav").style.display = "";
					document.getElementById("txtEXT_RATE").className = "";
					document.getElementById("txtEXT_RATE").disabled = false;
				}
			}
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************************
         * 16. 품의서 작성시 데이터셋 헤더 설정 및 데이터 추가  *
         *******************************************************/
		function fnc_BusinesstripInsert() {

            dsT_DI_DISPATCH.ClearAll();
            dsT_DI_APPROVAL.ClearAll();

			// 데이터셋의 헤더 정보 설정.
			dsT_DI_DISPATCH.setDataHeader("ORD_NO:STRING, "+	// 품의번호
										"ENO_NO:STRING, "+		// 사번
										"ENO_NM:STRING, "+		// 성명
										"DPT_CD:STRING, "+		// 부서
										"DPT_NM:STRING, "+		// 부서명
										"JOB_CD:STRING, "+		// 직위코드
										"JOB_NM:STRING, "+		// 직위명
										"BUT_FR_YMD:STRING, "+	// 출장시작일
										"BUT_TO_YMD:STRING, "+	// 출장종료일
										"SLEEP_DAY:STRING, "+	// 박
										"BUT_DAY:STRING, "+		// 일
										"BUT_CITY:STRING, "+	// 출장지역
										"BUT_NAT:STRING, "+		// 출장국가
										"BUT_OBJ:STRING,"+		// 출장목적
										"BUT_AFF:STRING,"+		// 출장효과
										"BUT_GBN:STRING,"+		// 고객사구분
										"VISA_YN:STRING,"+		// 비자필요여부
										"PASS_YN:STRING,"+		// 여권필요여부
										"BUT_EXPENSE:DECIMAL,"+	// 일비
										"BUT_LODGING:DECIMAL,"+	// 숙박비
										"BUT_SUM:DECIMAL,"+		// 일비합계
										"BUT_AMT:DECIMAL,"+		// 일비
										"PC_GBN:STRING,"+		// 프로젝트구분(W,C)
										"PC_CCTRCD:STRING,"+	// 프로젝트코드
										"PC_CCTRNM:STRING,"+	// 프로젝트명
										"EXT_RATE:DECIMAL,"+	// 환율단위
										"CURRENCY_NM:STRING,"+	// 환율단위
										"APP_CMT:STRING,"+		// 결재의견
										"APP_STATUS:STRING,"+	// 결재상태
										"APP_ENO_NO:STRING,"+	// 상신자사번
										"APP_JOB_CD:STRING");	// 상신자직위

			// 데이터셋의 헤더 정보 설정.
			dsT_DI_OVERSEASTRIP_DTL.setDataHeader("ORD_NO:STRING, "+	// 품의번호
										"ENO_NO:STRING, "+		// 사번
										"SEQ_NO:STRING,"+
										"SEQ_NM:STRING,"+
										"BUT_YMDHM:STRING,"+
										"BUT_FR_NAT:STRING,"+
										"BUT_FR_NAT_NM:STRING,"+
										"BUT_FR_CITY:STRING,"+
										"BUT_FR_CITY_NM:STRING,"+
										"BUT_TO_NAT:STRING,"+
										"BUT_TO_NAT_NM:STRING,"+
										"BUT_TO_CITY:STRING,"+
										"BUT_TO_CITY_NM:STRING,"+
										"BUT_TRA:STRING"
											);	// 상신자직위

			// 데이터셋의 헤더 정보 설정.
			dsT_DI_BUDGET.setDataHeader(
										"ENO_NO:STRING, "+		// 사번
										"DIS_FR_YMD:STRING, "+	// 출장시작일
										"PC_GBN:STRING,"+	// 프로젝트코드
										"PC_CCTRCD:STRING");	// 예산잔액

			// 데이터셋의 헤더 정보 설정.
			dsT_DI_BUDGET_RESULT.setDataHeader(
										"BUDGET_AMT:STRING");	// 예산잔액

            dsT_DI_DISPATCH.AddRow();
            //SESSION 정보
            dsT_DI_DISPATCH.NameValue(1,"DPT_CD") = '<%=box.get("SESSION_DPTCD")%>';
            dsT_DI_DISPATCH.NameValue(1,"JOB_CD") = '<%=box.get("SESSION_JOBCD")%>';
            dsT_DI_DISPATCH.NameValue(1,"ENO_NO") = '<%=box.get("SESSION_ENONO")%>';
            dsT_DI_DISPATCH.NameValue(1,"ENO_NM") = '<%=box.get("SESSION_ENONM")%>';
            dsT_DI_DISPATCH.NameValue(1,"DPT_NM") = '<%=box.get("SESSION_DPTNM")%>';
            dsT_DI_DISPATCH.NameValue(1,"JOB_NM") = '<%=box.get("SESSION_JOBNM")%>';
            // 데이터셋의 헤더 정보 설정(출장, 결재자 정보)
            dsT_DI_APPROVAL.setDataHeader("GUN_YMD:STRING, "+
										  "GUN_GBN:STRING, "+
										  "REQ_NO:STRING,"+
										  "ENO_NO:STRING, "+
										  "ENO_NM:STRING, "+
										  "DPT_CD:STRING, "+
										  "PENO_NO:STRING, "+
										  "DPT_NM:STRING, "+
										  "JOB_CD:STRING, "+
										  "JOB_NM:STRING, "+
										  "SEQ_NM:STRING, "+
										  "SEQ_NO:STRING");

		}
		function fnc_AutoApproval(appNumParam){
			var appNum = appNumParam + 1;
			var obj    = new String;
            //출장 결재자정보 관리 데이터셋에 상신자의 기본정보 Setting(품의번호,상신자정보등)
			for(var i = appNum; i<=appNum+2; i++) {
				dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = "9"+i;
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "E";
				if (i == appNum) {
	            		obj = fnc_GetCommonEnoObj("1990071");
	            } else if (i == appNum + 1) {
	            		obj = fnc_GetCommonEnoObj("2020008");
				} else if (i == appNum + 2) {
	            		obj = fnc_GetCommonEnoObj("2030007");
	            }
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = '<%=box.get("SESSION_ENONO")%>';
	            dsT_DI_APPROVAL.NameValue(i,"ORD_NO") = document.getElementById("txtORD_NO").value;
			}
		}
		/*************************
         * 17. 숙박일수 자동계산 *
         *************************/
		function fnc_Auto_Input(str_ymd, end_ymd) {
            var str = document.getElementById(str_ymd).value.split("-");
            var end = document.getElementById(end_ymd).value.split("-");
            var str_date;
            var end_date;
            var sleep_day;
            if(document.getElementById(str_ymd).value != "" && document.getElementById(end_ymd).value != ""){
                str_date = new Date(str[0],str[1]-1,str[2]);
                end_date = new Date(end[0],end[1]-1,end[2]);
                sleep_day = (end_date-str_date)/(24*60*60*1000);
                document.getElementById("txtSLEEP_DAY").value = sleep_day;
                document.getElementById("txtBUT_DAY").value = sleep_day+1;
            }
        }
        /***************************
         * 18. 입력란 Disabled처리 *
         ***************************/
		function fnc_InputDisabled() {

            document.getElementById("txtBUT_FR_YMD").className = "input_ReadOnly";
            document.getElementById("txtBUT_FR_YMD").readOnly = true;
            document.getElementById("txtBUT_TO_YMD").className = "input_ReadOnly";
            document.getElementById("txtBUT_TO_YMD").readOnly = true;
            document.getElementById("cmbBUT_NAT").className = "input_ReadOnly";
            document.getElementById("cmbBUT_NAT").disabled = true;
            document.getElementById("cmbVISA_YN").className = "input_ReadOnly";
            document.getElementById("cmbVISA_YN").disabled = true;
            document.getElementById("cmbPASS_YN").className = "input_ReadOnly";
            document.getElementById("cmbPASS_YN").disabled = true;
            document.getElementById("txtEXT_RATE").className = "input_ReadOnly";
            document.getElementById("txtEXT_RATE").disabled = true;
            document.getElementById("cmbBUT_GBN").className = "input_ReadOnly";
            document.getElementById("cmbBUT_GBN").disabled = true;
            document.getElementById("txtBUT_CITY").className = "input_ReadOnly";
            document.getElementById("txtBUT_CITY").disabled = true;
            document.getElementById("txtBUT_OBJ").className = "input_ReadOnly";
            document.getElementById("txtBUT_OBJ").readOnly = true;
            document.getElementById("txtBUT_AFF").className = "input_ReadOnly";
            document.getElementById("txtBUT_AFF").readOnly = true;

            //결재선 삽입, 제거 버튼
            document.getElementById("btn_InsDel").style.display = "none";
            //전표 삽입, 제거 버튼
            //document.getElementById("btn_slip").style.display = "none";
        }

        function fnc_InputEnable() {
            document.getElementById("txtBUT_FR_YMD").className = "";
            document.getElementById("txtBUT_FR_YMD").readOnly = false;
            document.getElementById("txtBUT_TO_YMD").className = "";
            document.getElementById("txtBUT_TO_YMD").readOnly = false;
            document.getElementById("cmbBUT_NAT").className = "";
            document.getElementById("cmbBUT_NAT").disabled = false;
            document.getElementById("cmbVISA_YN").className = "";
            document.getElementById("cmbVISA_YN").disabled = false;
            document.getElementById("cmbPASS_YN").className = "";
            document.getElementById("cmbPASS_YN").disabled = false;
            document.getElementById("txtEXT_RATE").className = "";
            document.getElementById("txtEXT_RATE").disabled = false;
            document.getElementById("cmbBUT_GBN").className = "";
            document.getElementById("cmbBUT_GBN").disabled = false;
            document.getElementById("txtBUT_CITY").className = "";
            document.getElementById("txtBUT_CITY").disabled = false;
            document.getElementById("txtBUT_OBJ").className = "";
            document.getElementById("txtBUT_OBJ").readOnly = false;
            document.getElementById("txtBUT_AFF").className = "";
            document.getElementById("txtBUT_AFF").readOnly = false;
            //결재선 삽입, 제거 버튼
            document.getElementById("btn_InsDel").style.display = "";
			//전표 삽입, 제거 버튼
            //document.getElementById("btn_slip").style.display = "";
        }

        /*************************
         * 19. 상신, 결재 처리   *
         *************************/
		function fnc_SubmitApproval(kind) {
            //상신처리시 데이터 변경유무 확인
            if (dsT_DI_DISPATCH.IsUpdated) {
                alert("품의서 내용이 변경되었습니다. 저장후 출장비를 다시 확인해주세요.");
                return false;
            }
            if(dsT_DI_APPROVAL.IsUpdated) {
                alert("결재선이 변경되었습니다. 다시 저장해주세요.");
                return false;
            }
            if (!confirm(kind+" 처리를 하시겠습니까?")) return;
            var app_eno_no = "<%=eno_no%>";
			var app_status = "";
            if(kind == "상신"){
                app_status = "2";
				app_eno_no = '<%=box.getString("SESSION_ENONO")%>';
            }else if(kind == "결재"){
                app_status = "3";
				app_eno_no
			}
			dsT_DI_DISPATCH.NameValue(1, "APP_CMT") = kind;
			dsT_DI_DISPATCH.NameValue(1, "APP_STATUS") = app_status;
			dsT_DI_DISPATCH.NameValue(1, "APP_ENO_NO") = app_eno_no;

			dsT_DI_DISPATCH.UserStatus(1)=1;

			var appCnt = 0;
			for(var i = 0; i < dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i, "APP_YN") == "Y"){
					appCnt += 1;
				}
			}
			if(appCnt == dsT_DI_APPROVAL.CountRow){
				alert("최종결재자이므로 근태반영으로 시간이 다소 걸립니다.");
			}
			var paramURL = "cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_02&APP_CMT="+kind+"&APP_STATUS="+app_status+"&APP_ENO_NO="+app_eno_no;
            trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?"+paramURL;
			trT_DI_DISPATCH.post();
            if(status == "2"){//저장유무
                fnc_InputDisabled();//입력란 disabled
                document.getElementById("btn_appre").style.display = "";//상신않보이게
            }else{
                document.getElementById("btn_approval").style.display = "none";//결재버튼들 않보이게
            }
			if(kind == "결재"){
                document.getElementById("btn_appre").style.display = "none";//상신않보이게
                document.getElementById("btn_approval").style.display = "none";//결재버튼들 않보이게
			}
            document.getElementById("imgSave").style.display = "none";//저장 않보이게
        }
        /********************
         * 16. 단위 입력    *
         *******************/
		function fnc_InputCurrency() {

            if(document.getElementById("cmbBUT_NAT").value == "KR"){
                alert("대한민국은 선택할 수 없습니다!");
                document.getElementById("cmbBUT_NAT").value = "";
                return;
            }

  			var BUT_NAT = document.getElementById("cmbBUT_NAT").value;
			dsT_DI_OVERSEASBT_BASIS_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta090.cmd.BUTA090CMD"
                                              + "&S_MODE=SHR_04"
                                              + "&BUT_CITY_CD="+BUT_NAT;
			dsT_DI_OVERSEASBT_BASIS_01.reset();
		}

        /*************************
         * 21. 팝업일 경우 처리  *
         *************************/
		function fnc_OnLoadPop() {

            status = "<%=app_status%>";
            fnc_SearchList(); //해당 출장품의서 조회

			//반송된것은 상신자가 재상신 가능
            if(("<%=app_cmt%>").substring(0,2) == "반송" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
	            status = "1";
  			//상신이나 결재된것은 불필요버튼 않보이게한다.
            }else if("<%=app_cmt%>" != "저장"){
            	document.getElementById("imgSave").style.display = "none";
            	document.getElementById("ImgAppend").style.display = "none";
            	document.getElementById("ImgRemove").style.display = "none";
            }

            //팝업에서는 취소 않보이게
            document.getElementById("ImgClear").style.display = "none";

            //상신이후의 상태이거나 상신자가 아닌 사람이 팝업으로 띄웠을경우 입력란 Disabled
            if(status != "1" || dsT_DI_DISPATCH.NameValue(1,"ENO_NO") != '<%=box.get("SESSION_ENONO")%>'){
                fnc_InputDisabled();
            }else{
            }

            var temp = "";
            var eno_no = "";
			var app_yn = "";

            if("<%=app_status%>" == "2" || "<%=app_status%>" == "3" || "<%=app_status%>" == "5"){
                for(var i= 0; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");//결재자
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");//결재여부
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  (app_yn == 'R' ||  app_yn == 'E')){
						document.getElementById("btn_approval").style.display = "";
						break;
					}
                }
            }
            //상신이후만 인쇄가 보인다.

            if("<%=app_status%>" == "4" ){
				if( "1001" == "<%=role_cd%>" || "1002" == "<%=role_cd%>"){
					document.getElementById("btn_SlipProc").style.display = "";
				}
            }else{
                document.getElementById("btn_SlipProc").style.display = "none";
            }
        }

        /*****************************************
         * 22. 사유입력팝업(부결, 반송처리)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {

            //if (!confirm(kind+" 처리를 하시겠습니까?")) return;

            var obj = new String();
			var app_yn = "";
            window.showModalDialog("/hr/but/butb023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){
				if(kind == "부결"){
					app_yn = "N";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "6";
				}else{//반송
					app_yn = "E";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "5";
				}
                dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = kind+"처리-"+obj.app_cmt;

                trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
                trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=SAV_03&APP_YN="+app_yn;
                trT_DI_DISPATCH.post();

                document.getElementById("btn_approval").style.display = "none";
            }
        }
/**
        //전표코드 획득
		function fnc_Slipconduct(){
            var but_fr_ymd = document.getElementById("txtBUT_FR_YMD");
            if(but_fr_ymd.value == ""){
                alert("출장 시작일을 입력하세요!");
                but_fr_ymd.focus();
                return false;
            }
			var url = "/hr/but/buta011.jsp";
			var returnValue = new Array(2);
			window.showModalDialog(url, returnValue, "dialogWidth:730px; dialogHeight:650px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			var GUBUN = returnValue[0];
			var CCTR_CD = returnValue[1];
			var CCTR_NM = returnValue[2];
			var WBS_FR_YMD = returnValue[3];
			var WBS_TO_YMD = returnValue[4];

			if(GUBUN == "undefined" || GUBUN == undefined || GUBUN == ""){
			}else{
				if(GUBUN == "WBS"){
					GUBUN = "W";
				}else if(GUBUN == "COST"){
					GUBUN = "C";
				}
				document.getElementById("txtPC_GBN").value = GUBUN;
				document.getElementById("txtPC_CCTRCD").value = CCTR_CD;
				document.getElementById("txtPC_CCTRNM").value = CCTR_NM;
				document.getElementById("txtWBS_FR_YMD").value = WBS_FR_YMD;
				document.getElementById("txtWBS_TO_YMD").value = WBS_TO_YMD;

				dsT_DI_BUDGET.DeleteAll();
				dsT_DI_BUDGET.AddRow();
				dsT_DI_BUDGET.NameValue(1,"ENO_NO") =  '<%=box.get("SESSION_ENONO")%>';
				dsT_DI_BUDGET.NameValue(1,"PC_GBN") =   GUBUN;
				dsT_DI_BUDGET.NameValue(1,"PC_CCTRCD") =  CCTR_CD;
				dsT_DI_BUDGET.NameValue(1,"DIS_FR_YMD") =   but_fr_ymd.value;
                trT_DI_BUDGET_SHR.KeyValue = "tr(I:dsT_DI_BUDGET=dsT_DI_BUDGET,O:dsT_DI_BUDGET_RESULT=dsT_DI_BUDGET_RESULT)";
                trT_DI_BUDGET_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc021.cmd.BUTC021CMD&S_MODE=SHR_02";
                trT_DI_BUDGET_SHR.post();
			}
		}
		//전표처리
		function fnc_Slip() {
			if(confirm("전표처리하시겠습니까?")){
				dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition, "APP_STATUS") = "7";
				trT_DI_DISPATCH_PROC.KeyValue = "tr02(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
				trT_DI_DISPATCH_PROC.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=PROC";
				trT_DI_DISPATCH_PROC.post();
			}else{
			}
		}
**/
		//외환은행 Link
		function fnc_Exchange(){
			window.open('http://fx.keb.co.kr/FER1101C.web','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
		}
		//환율저장
		function fnc_ExchangeSave(){
			trT_DI_DISPATCH_EXCH.KeyValue = "tr02(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
			trT_DI_DISPATCH_EXCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=EXEC";
			trT_DI_DISPATCH_EXCH.post();
		}
    </script>
    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsORD_NO                            |
    | 3. Table List : T_DI_DISPATCH             |
    +----------------------------------------------->
    <Object ID="dsORD_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_DISPATCH                 |
    | 3. Table List : T_DI_DISPATCH             |
    +----------------------------------------------->
    <Object ID="dsT_DI_DISPATCH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_OVERSEASTRIP_DTL)     |
    | 3. 사용되는 Table List(dsT_DI_OVERSEASTRIP_DTL) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_OVERSEASTRIP_DTL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUDGET                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUDGET" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUDGET                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUDGET_RESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERSEASBT_BASIS_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_CM_NAT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERSEASBT_BASIS_01          |
    | 3. Table List : T_DI_OVERSEASBT_BASIS         |
    +----------------------------------------------->
    <Object ID="dsT_CM_CITY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_DISPATCH)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_DISPATCH)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUDGET_SHR)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_BUDGET_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUDGET_SHR)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_PROC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUDGET_SHR)	|
    | 3. 사용되는 Table List(T_DI_DI_DISPATCH)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH_EXCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z4"/>
       <jsp:param name="CODE_GUBUN"    value="Z4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 출장지 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_L2"/>
       <jsp:param name="CODE_GUBUN"    value="L2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_DISPATCH Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <Script For=dsORD_NO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			document.getElementById("txtORD_NO").value = dsORD_NO.NameValue(1,"ORD_NO");
        }

    </Script>


    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            document.form1.grdT_DI_APPROVAL.Format = "<C> id='SEQ_NO'		width=40	name='NO'		align=center	show=false</C>"+
													 "<C> id='SEQ_NM'		width=40	name='NO'		align=center	Value={IF(SEQ_NO > '90','협조', '결재')}</C>"+
                                                     "<C> id='DPT_NM'		width=95	name='소속'		align=left		</C>"+
                                                     "<C> id='JOB_NM'		width=61	name='직위'		align=center	</C>"+
                                                     "<C> id='ENO_NO'		width=70	name='사번'		align=center  show=false	</C>"+
                                                     "<C> id='ENO_NM'		width=100	name='성명'		align=center	</C>"+
                                                     "<C> id='APP_STATUS'	width=160	name='결재상태'	align=left	    </C>";

            //첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
            form1.grdT_DI_APPROVAL.TitleHeight = 18;
            form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
            form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }

    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_OVERSEASBT_BASIS_01 Event="OnLoadCompleted(iCount)">
        if(dsT_DI_OVERSEASBT_BASIS_01.CountRow == 1)
            document.getElementById("txtCURRENCY_NM").value = dsT_DI_OVERSEASBT_BASIS_01.NameString(1, "CURRENCY_NM");
    </Script>
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_DISPATCH Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsORD_NO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>


    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_DISPATCH Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_DISPATCH event="OnSuccess()">
        fnc_SearchList();
		if(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") == "1" ){
			document.getElementById("btn_appre").style.display = "";
		}else{
			document.getElementById("btn_appre").style.display = "none";
		}
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_DISPATCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_EXCH event="OnSuccess()">
        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_EXCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUDGET_SHR event="OnSuccess()">
		document.getElementById("txtBUDGET_AMT").value = dsT_DI_BUDGET_RESULT.NameValue(1,"BUDGET_AMT");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUDGET_SHR event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_DISPATCH_PROC event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_DISPATCH_PROC event="OnFail()">
        cfErrorMsg(this);
		window.close();
    </script>

    <!---------------------------+
    | grid의 팝업필드 클릭시 처리|
    +---------------------------->
    <script language="javascript" for=grdT_DI_OVERSEASTRIP_DTL event=OnPopup(row,colid,data)>

        if(row > 0) {
			var obj = new String();
			obj.nat_cd = "";
			obj.nat_nm = "";
			obj.city_cd = "";
			obj.city_nm = "";
			window.showModalDialog("/common/popup/world_city.jsp", obj, "dialogWidth:500px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			if(colid == "BUT_FR_NAT_NM" || colid == "BUT_FR_CITY_NM"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_NAT") = obj.nat_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_NAT_NM") = obj.nat_nm;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_CITY") = obj.city_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_FR_CITY_NM") = obj.city_nm;
			}else if(colid == "BUT_TO_NAT_NM" || colid == "BUT_TO_CITY_NM"){
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_NAT") = obj.nat_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_NAT_NM") = obj.nat_nm;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_CITY") = obj.city_cd;
				dsT_DI_OVERSEASTRIP_DTL.NameValue(row,"BUT_TO_CITY_NM") = obj.city_nm;
			}
        }
    </script>
<script language=JavaScript for=grdT_DI_OVERSEASTRIP_DTL event=OnCloseUp(row,colid)>
/*
		if(colid == "BUT_FR_NAT" || colid == "BUT_TO_NAT"){
			var NAT_CD = dsT_CM_CITY.NameValue(row,"NAT_CD")
            //도시 조회
            dsT_CM_CITY.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb020.cmd.BUTB020CMD&S_MODE=CITY_SHR&NAT_CD=";
			dsT_CM_CITY.reset();
		}
*/
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외출장품의서</td>
					<td align="right" class="navigator">HOME/근태관리/해외출장/<font color="#000000">해외출장품의서</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="435" height="35" >
            <span id="btn_SlipProc" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','/images/button/btn_SlipconductOver.gif',1)"><img src="/images/button/btn_SlipconductOn.gif" name="imgSlip" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Slip();"></a>
            </span>
            <span id="btn_appre" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)"><img src="/images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('상신');"></a>
            </span>
            <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('결재');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('부결');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSendback','','/images/button/btn_SendbackOver.gif',1)"><img src="/images/button/btn_SendbackOn.gif" name="imgSendback" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('반송');"></a>
            </span>
		</td>
		<td class="paddingTop5" align="right" width="285" height="35" >
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="100"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="creamBold">품의번호</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="creamBold">소속</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="creamBold">직위</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="creamBold">출장자</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtNAM_KOR" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
        </td>
        <td width="30">&nbsp;</td>
        <td>
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:560px;height:108px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NO'		width=40	name='NO'		align=center	show='false'</C>
								<C> id='ENO_NO'		width=100	name='사번'		align=center	show=false</C>
								<C> id='SEQ_NM'		width=50	name='구분'		align=center	Value={IF(SEQ_NO > '90','협조', '결재')}</C>
								<C> id='ENO_NM'		width=70	name='결재자'		align=center</C>
								<C> id='JOB_NM'		width=60	name='직위'		align=center	</C>
                                <C> id='DPT_NM'		width=100	name='부서'		align=left		</C>
								<C> id='APP_STATUS'	width=170	name='결재상태'	align=left	    </C>
								<C> id='REMARK1'	width=87	name='의견'		align=center 	Color='Blue'	</C>
								<C> id='REMARK'		width=60	name='사유'		align=center	show=false</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right">
                        <span id="btn_InsDel">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
                        </span>
		            </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">

				<colgroup>
					<col width="100"></col>
                    <col width="310"></col>
                    <col width="50"></col>
                    <col width="60"></col>
                    <col width="50"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">출장기간</td>
					<td class="padding2423">
						<input id="txtBUT_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_FR_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_FR_YMD','','40','235');"></a>
                        <input id="txtBUT_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_TO_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_TO_YMD','','300','235');"></a>
						(<input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>박
                        <input id="txtBUT_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>일)
                    </td>
					<td align="center" class="creamBold">비자</td>
                    <td class="padding2423">
						<select id="cmbVISA_YN" name="cmbVISA_YN" style="width:85">
                            <option value="Y">필요</option>
                            <option value="N">불필요</option>
                        </select>

					</td>
					<td align="center" class="creamBold">여권</td>
                    <td class="padding2423" >
						<select id="cmbPASS_YN" name="cmbPASS_YN" style="width:85">
                            <option value="Y">필요</option>
                            <option value="N">불필요</option>
                        </select>

					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">출장지역</td>
					<td class="padding2423">
						<select id="cmbBUT_NAT" style="width='110';" onChange="fnc_InputCurrency();">
						</select>
						<b>단위</b>:<input id="txtCURRENCY_NM" size="5" align="right" class="input_ReadOnly" readOnly>
						<b>환율</b>:<input id="txtEXT_RATE"  size="5" maxlength="10" align="right"   style="ime-mode:disabled" onkeypress="cfCheckNumber2()">
						<span id="btn_exchSav" style="display:none">
							<input type="button" value="환율저장" size="10" align="right" onClick="fnc_ExchangeSave()">
						</span>
                    </td>
					<td align="center" class="creamBold">경유지</td>
                    <td class="padding2423" colspan="3" >
						<input id="txtBUT_CITY" size="40" maxlength="25">
					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">고객사구분</td>
					<td class="padding2423" colspan="5">
						<select id="cmbBUT_GBN" style="width='120';">
							<option value="1">당사출장</option>
							<option value="2">고객사출장</option>
						</select>
						 <input type="button" value="환율조회" size="10" align="right" onClick="fnc_Exchange()">
                    </td>
                </tr>
                <!--
                <tr>
					<td align="center" class="creamBold">프로젝트</td>
					<td class="padding2423" colspan="5">
						&nbsp;
						<input id="txtPC_CCTRCD" size="20" class="input_ReadOnly" readOnly>
						<input id="txtPC_CCTRNM" size="40"  class="input_ReadOnly" readOnly>
						<input type="hidden" id="txtPC_GBN" size="30" >
						<input type="hidden" id="txtWBS_FR_YMD" size="30" >
						<input type="hidden" id="txtWBS_TO_YMD" size="30" >
						<span id="btn_Slip">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectSlip','','/images/button/btn_SlipOver.gif',1)"> <img src="/images/button/btn_SlipOn.gif" name="ImgSelectSlip"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Slipconduct()"></a>
						<b>예산잔액</b> : <input id="txtBUDGET_AMT" size="15" align="right" class="input_ReadOnly" readOnly>
						</span>
					</td>
				</tr>
				 -->
                <tr>
					<td align="center" class="creamBold">출장목적</td>
					<td class="padding2423" colspan="5">
						<textarea id="txtBUT_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">출장효과</td>
					<td class="padding2423" colspan="5">
						<textarea id="txtBUT_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=3 >
						</textarea>
					</td>
				</tr>

				<!-- 테이블모양으로 인하여 삽입한 빈 태그(선언된 colgroup만큼 td가있어야 테이블 모양이 찌그러지지 않는다.) -->
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
            <table bgcolor="#FFFFFF" width="800"><tr><td>&nbsp;</td></tr></table>
		<!-- 여비지급 -->
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td align="center" class="creamBold">일당</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_EXPENSE" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
										<!--
						<input id="txtBUT_EXPENSE" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">일당계</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_SUM" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_SUM" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">숙박비</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_LODGING" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_LODGING" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
					<td align="center" class="creamBold">일비</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="txtBUT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:90">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=14>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
						<!--
						<input id="txtBUT_AMT" size="20" class="input_ReadOnly" align="right" readOnly>
						-->
                    </td>
				</tr>
		</table>

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
	<!-- 버튼 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="right">
                            <span id="rate_msg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            <img src="/images/button/btn_AppendOn.gif" name="ImgAppend"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppend','','/images/button/btn_AppendOver.gif',1)">
                            <img src="/images/button/btn_RemoveOn.gif" name="ImgRemove"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRemove','','/images/button/btn_RemoveOver.gif',1)">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	<!-- 버튼 테이블 끝 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_OVERSEASTRIP_DTL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:150px;">
						<param name="DataID" value="dsT_DI_OVERSEASTRIP_DTL">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=30	name="NO"			align=center	value={String(Currow)}	</C>
                            <C> id="SEQ_NM"			width=60	name="구분"		    align=center  Edit=none </C>
                            <C> id="BUT_YMDHM"	    width=120	name="출발일"		align=center   MASK=XXXX-XX-XX-XX-XX </C>
						<G> name="출발지"  HeadBgColor="#F7DCBB"
                            <C> id="BUT_FR_NAT"	    width=120	name="국가코드"	align=left    show=false</C>
                            <C> id="BUT_FR_NAT_NM"	width=100	name="국가"	    align=left EditStyle=PopupFix </C>
                            <C> id="BUT_FR_CITY"	width=110	name="도시코드"	align=left  show=false</C>
                            <C> id="BUT_FR_CITY_NM"	width=140	name="도시"	    align=left EditStyle=PopupFix </C>
						</G>
						<G> name="도착지"  HeadBgColor="#F7DCBB"
                            <C> id="BUT_TO_NAT"	    width=120	name="국가코드"	align=left    show=false</C>
                            <C> id="BUT_TO_NAT_NM"  width=100	name="국가"	    align=left EditStyle=PopupFix </C>
                            <C> id="BUT_TO_CITY"	width=110	name="도시코드"	align=left    show=false</C>
                            <C> id="BUT_TO_CITY_NM"	width=140	name="도시"	    align=left EditStyle=PopupFix </C>
						</G>
                            <C> id="BUT_TRA"	   width=70	name="교통"	align=center  EditStyle=Combo Data="1:항공,2:배"  </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
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
<object id="bndT_DI_DISPATCH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_DISPATCH">
	<Param Name="BindInfo", Value='
        <C>Col=ORD_NO     		Ctrl=txtORD_NO     		Param=value 	</C>
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     		Param=value 	</C>
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
		<C>Col=JOB_CD			Ctrl=txtJOB_CD	   		Param=value		</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=ENO_NO   		Ctrl=txtENO_NO    		Param=value		</C>
		<C>Col=ENO_NM   		Ctrl=txtENO_NM    		Param=value		</C>
        <C>Col=BUT_FR_YMD       Ctrl=txtBUT_FR_YMD  	Param=value 	</C>
        <C>Col=BUT_TO_YMD       Ctrl=txtBUT_TO_YMD  	Param=value 	</C>
        <C>Col=PC_CCTRCD        Ctrl=txtPC_CCTRCD  		Param=value 	</C>
        <C>Col=PC_CCTRNM        Ctrl=txtPC_CCTRNM  		Param=value 	</C>
        <C>Col=PC_GBN           Ctrl=txtPC_GBN  		Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=BUT_DAY          Ctrl=txtBUT_DAY  	    Param=value 	</C>
        <C>Col=BUT_NAT          Ctrl=cmbBUT_NAT  	    Param=value 	</C>
        <C>Col=BUT_CITY         Ctrl=txtBUT_CITY  	    Param=value 	</C>
        <C>Col=BUT_OBJ          Ctrl=txtBUT_OBJ  	    Param=value 	</C>
        <C>Col=BUT_AFF          Ctrl=txtBUT_AFF  	    Param=value 	</C>
        <C>Col=VISA_YN          Ctrl=cmbVISA_YN  	    Param=value 	</C>
        <C>Col=PASS_YN          Ctrl=cmbPASS_YN  	    Param=value 	</C>
        <C>Col=EXT_RATE         Ctrl=txtEXT_RATE  	    Param=value 	</C>
        <C>Col=BUT_EXPENSE      Ctrl=txtBUT_EXPENSE     Param=Text 	</C>
        <C>Col=BUT_SUM          Ctrl=txtBUT_SUM         Param=Text 	</C>
        <C>Col=BUT_LODGING      Ctrl=txtBUT_LODGING     Param=Text 	</C>
        <C>Col=BUT_AMT          Ctrl=txtBUT_AMT         Param=Text </C>
        <C>Col=CURRENCY_NM      Ctrl=txtCURRENCY_NM     Param=value		</C>
		<C>Col=BUT_GBN          Ctrl=cmbBUT_GBN         Param=value		</C>
    '>
</object>

