<!--
*****************************************************
* @source       : butc020.jsp
* @description  : 파견품의서작성 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2010/02/04      권혁수        최초작성
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

    //결재선사용을 위해 셋팅
    if(eno_no == null){
    	eno_no = (String)request.getSession().getAttribute("SESSION_ENONO");
    }

	//System.out.println("ord_no [" + ord_no + "]");
	//System.out.println("eno_no [" + eno_no + "]");
	//System.out.println("app_status [" + app_status + "]");
	//System.out.println("app_cmt [" + app_cmt + "]");

%>

<html>
<head>
<title>파견품의서(butc020)</title>
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
		var obj = new String();
		obj.app_cmt = "";
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            if(dsTemp != "Modal"){
                trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
                trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_03&ORD_NO="+dsT_DI_DISPATCH.NameValue(1,"ORD_NO")+"&ENO_NO="+dsT_DI_DISPATCH.NameValue(1,"ENO_NO");
                trT_DI_DISPATCH_SHR.post();
            }else{
	        	trT_DI_DISPATCH_SHR.KeyValue = "tr(O:dsT_DI_DISPATCH=dsT_DI_DISPATCH, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_DISPATCH_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_03&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_DISPATCH_SHR.post();
			}

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //품의번호 조회
            dsORD_NO.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_01";
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

			trT_DI_DISPATCH.KeyValue = "tr(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_01&ORD_NO="+ord_no;
			trT_DI_DISPATCH.post();

            if(msgFlag == "Y"){

			   if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y"){
				   alert("저장되었습니다. 파견비계산서를 확인하시고 상신하세요.");
			   }else{
				   document.getElementById("btn_appre").style.display = "";//상신보이게
				   alert("저장되었습니다. 상신하세요.");
			   }
       		}
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        	var ord_no = dsT_DI_DISPATCH.NameValue(1,"ORD_NO");

 	        var url = "butc020_PV.jsp?ORD_NO="+ord_no+"&ENO_NO="+'<%=eno_no%>'+"&DPT_CD=" + '<%=box.get("SESSION_DPTCD")%>';
   			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
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
        function fnc_Append() {

            var DPT_CD = document.getElementById("txtDPT_CD").value;
			var EMP_NO =  document.getElementById("txtENO_NO").value;

            //ds를 리턴받는다.
            dsT_DI_APPROVAL.DeleteAll();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "D");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();
            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
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
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "D";
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
	        document.getElementById("btn_trbfee").style.display = "none";

			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtDIS_FR_YMD").focus();

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
            var dis_fr_ymd = document.getElementById("txtDIS_FR_YMD");
            var dis_to_ymd = document.getElementById("txtDIS_TO_YMD");
            var dis_city = document.getElementById("cmbDIS_CITY");
            var dis_gun = document.getElementById("txtDIS_GUN");
            var dis_obj = document.getElementById("txtDIS_OBJ");


			//alert("dsTemp : "+dsTemp+",    status : "+status);
            if(dsTemp == "Modal" && (status != "1" && status != "5")) return;//팝업일 경우

			if (!dsT_DI_DISPATCH.IsUpdated && !dsT_DI_APPROVAL.IsUpdated ) {
                //alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

            if(dsT_DI_APPROVAL.CountRow < 4){
                alert("결재선을 지정하셔야 합니다!");
                return false;
            }

            if(dis_fr_ymd.value == ""){
                alert("파견 시작일을 입력하세요!");
                dis_fr_ymd.focus();
                return false;
            }
			if(!fnc_Auto_DisPayYn()){
				return false;
			}
            if(dis_to_ymd.value == ""){
                alert("파견 종료일을 입력하세요!");
                dis_to_ymd.focus();
                return false;
            }

            if(dis_city.value == ""){
                alert("파견지를 입력하세요!");
                dis_city.focus();
                return false;
            }
            if(dis_obj.value == ""){
                alert("파견목적을 입력하세요!");
                but_obj.focus();
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			// 지역구분
			for( var i = 1; i <= dsT_CM_COMMON_Z4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_Z4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_Z4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbDIS_CITY").add(oOption);
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
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = false;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
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
										"DIS_FR_YMD:STRING, "+	// 파견시작일
										"DIS_TO_YMD:STRING, "+	// 파견종료일
										"SLEEP_DAY:STRING, "+	// 박
										"DIS_DAY:STRING, "+		// 일
										"DIS_PAY_YN:STRING, "+	// 파견비지급여부
										"DIS_CITY:STRING, "+	// 파견지역
										"DIS_GUN:STRING, "+		// 근무지
										"DIS_OBJ:STRING,"+		// 파견목적
										"DIS_AFF:STRING,"+		// 파견효과
										"APP_CMT:STRING,"+		// 결재의견
										"APP_STATUS:STRING,"+	// 결재상태
										"APP_ENO_NO:STRING,"+	// 상신자사번
										"APP_JOB_CD:STRING");	// 상신자직위

			// 데이터셋의 헤더 정보 설정.
			dsT_DI_BUDGET.setDataHeader(
										"ENO_NO:STRING, "+		// 사번
										"DIS_FR_YMD:STRING");	// 파견시작일


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
			fnc_AutoApproval(0);
			//상신이후만 인쇄가 보인다.
            //document.getElementById("imgPrint").style.display = "none";
            document.getElementById("cmbDIS_PAY_YN").readOnly = true;

		}
		function fnc_AutoApproval(appNumParam){
			var appNum = appNumParam + 1;
			var obj    = new String;
            //출장 결재자정보 관리 데이터셋에 상신자의 기본정보 Setting(품의번호,상신자정보등)
			for(var i = appNum; i<=appNum+2; i++) {
				dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = "9"+i;
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "D";
				if (i == appNum) {
	            		obj = fnc_GetCommonEnoObj("1990025");
	            } else if (i == appNum + 1) {
	            		obj = fnc_GetCommonEnoObj("1990105");
				} else if (i == appNum + 2) {
	            		obj = fnc_GetCommonEnoObj("2100001");
	            }
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = '<%=box.get("SESSION_ENONO")%>';
	            dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("txtORD_NO").value;
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
                document.getElementById("txtDIS_DAY").value = sleep_day+1;
				fnc_Auto_DisPayYn();
            }
        }
		function fnc_Auto_DisPayYn(){
			var disDay = document.getElementById("txtDIS_DAY").value;
			if(disDay < 30){
				alert("파견기간이 30일 미만시 국내출장품의를 이용하시기 바랍니다");
				return false;
			}else{
				return true;
			}
		}
		function fnc_Auto_DisPayYn2(){
			var disCity = document.getElementById("cmbDIS_CITY").value;
			var ORD_NO  = document.getElementById("txtORD_NO").value;

			if(ORD_NO == "20100705003"){
				document.getElementById("cmbDIS_PAY_YN").value = "Y"
				return true;
			}

			if(disCity == "01" || disCity == "04" || disCity == "08"){
				document.getElementById("cmbDIS_PAY_YN").value = "N";
				alert("서울/경기/인천 지역은 파견비가 지급되지 않습니다");
			}else{
				document.getElementById("cmbDIS_PAY_YN").value = "Y"
			}



		}
        /***************************
         * 18. 입력란 Disabled처리 *
         ***************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDIS_FR_YMD").className = "input_ReadOnly";
            document.getElementById("txtDIS_FR_YMD").readOnly = true;
            document.getElementById("txtDIS_TO_YMD").className = "input_ReadOnly";
            document.getElementById("txtDIS_TO_YMD").readOnly = true;
            document.getElementById("cmbDIS_CITY").className = "input_ReadOnly";
            document.getElementById("cmbDIS_CITY").disabled = true;
            document.getElementById("txtDIS_OBJ").className = "input_ReadOnly";
            document.getElementById("txtDIS_OBJ").readOnly = true;
            document.getElementById("txtDIS_AFF").className = "input_ReadOnly";
            document.getElementById("txtDIS_AFF").readOnly = true;

            //결재선 삽입, 제거 버튼
            document.getElementById("btn_InsDel").style.display = "none";

        }

        function fnc_InputEnable() {
            document.getElementById("txtDIS_FR_YMD").className = "";
            document.getElementById("txtDIS_FR_YMD").readOnly = false;
            document.getElementById("txtDIS_TO_YMD").className = "";
            document.getElementById("txtDIS_TO_YMD").readOnly = false;
            document.getElementById("cmbDIS_CITY").className = "";
            document.getElementById("cmbDIS_CITY").disabled = false;
            document.getElementById("txtDIS_OBJ").className = "";
            document.getElementById("txtDIS_OBJ").readOnly = false;
            document.getElementById("txtDIS_AFF").className = "";
            document.getElementById("txtDIS_AFF").readOnly = false;
            //결재선 삽입, 제거 버튼
            document.getElementById("btn_InsDel").style.display = "";

        }

        /*************************
         * 19. 상신, 결재 처리   *
         *************************/
		function fnc_SubmitApproval(kind) {
            //상신처리시 데이터 변경유무 확인
            if (dsT_DI_DISPATCH.IsUpdated) {
                alert("품의서 내용이 변경되었습니다. 저장후 파견비를 다시 확인해주세요.");
                return false;
            }
            if(dsT_DI_APPROVAL.IsUpdated && kind == "상신") {
                alert("결재선이 변경되었습니다. 다시 저장해주세요.");
                return false;
            }
            if (!confirm(kind+" 처리를 하시겠습니까?")) return;
            var app_eno_no = "<%=eno_no%>";
			var app_status = "";

            if(kind == "상신"){
                app_status = "2";
				app_eno_no = '<%=box.getString("SESSION_ENONO")%>';
            }
             else if(kind == "결재"){
                app_status = "3";
			}

		//	if(obj.app_cmt != ""){
		//		dsT_DI_DISPATCH.NameValue(1, "APP_CMT") = obj.app_cmt;
		//	}

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
				kind = "결재완료";
                app_status = "4";
				alert("최종결재자이므로 근태반영으로 시간이 다소 걸립니다.");
			}
			dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = obj.app_cmt;
			var paramURL = "cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_02&APP_CMT="+kind+"&APP_STATUS="+app_status+"&APP_ENO_NO="+app_eno_no;
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
            //document.getElementById("imgPrint").style.display = "";//인쇄보이게
        }

        /*************************
         * 20. 여비 계산         *
         *************************/
		function fnc_Calcul_Basis() {
            window.showModalDialog("/hr/but/butc021.jsp?STATUS="+status, dsT_DI_DISPATCH, "dialogWidth:750px; dialogHeight:480px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            //alert(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") + " - " + status + " - " + dsT_DI_DISPATCH.NameValue(1,"ENO_NO") + " - " + '<%=box.get("SESSION_ENONO")%>');
            if(dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") == "1" && status == "1" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
                status = "1";
                //상신버튼 Show
                document.getElementById("btn_appre").style.display = "";
            }
        }

        /*************************
         * 21. 팝업일 경우 처리  *
         *************************/
		function fnc_OnLoadPop() {

            status = "<%=app_status%>";
            fnc_SearchList(); //해당 출장품의서 조회

			//반송된것은 상신자가 재상신 가능
            if(("<%=app_cmt%>").substring(0,2) == "반송" && dsT_DI_DISPATCH.NameValue(1,"ENO_NO") == '<%=box.get("SESSION_ENONO")%>'){
	            status = "1";   //저장 상태로
	            //document.getElementById("btn_appre").style.display = "";
  			//상신이나 결재된것은 불필요버튼 않보이게한다.
            }else if("<%=app_cmt%>" != "저장"){
            	document.getElementById("imgSave").style.display = "none";
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
			//여비계산서 보이게하기...
			if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y"){
				document.getElementById("btn_trbfee").style.display = "";
			}else{
				document.getElementById("btn_trbfee").style.display = "none";
			}
            if("<%=app_status%>" == "2" || "<%=app_status%>" == "3" ){
                for(var i= 0; i <= dsT_DI_APPROVAL.CountRow; i++){
                    eno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");		//결재자
					app_yn = dsT_DI_APPROVAL.NameValue(i,"APP_YN");		//결재여부

			            //해당 결재자 의견입력 준비.
					if(eno_no == '<%=box.get("SESSION_ENONO")%>' &&  app_yn == "R" ){
						document.getElementById("btn_approval").style.display = "";
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						break;
					}
                }
            }else{
            			document.getElementById("btn_approval").style.display = "none";
            			document.getElementById("resultMessage").innerText = '* 이미 결재 처리완료 되었습니다. 조회만 가능합니다. ';

            }

        }

        /*****************************************
         * 22. 사유입력팝업(부결, 반송처리)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {

            if (!confirm(kind+" 처리를 하시겠습니까?")) return;


			var app_yn = "";
			if(obj.app_cmt == ""){
            	window.showModalDialog("/hr/but/butc023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			}
            if(obj.app_cmt != ""){
				if(kind == "부결"){
					app_yn = "N";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "6";
				}else{//반송
					app_yn = "E";
					dsT_DI_DISPATCH.NameValue(1,"APP_STATUS") = "5";
				}
                dsT_DI_DISPATCH.NameValue(1,"APP_CMT") = obj.app_cmt;
                trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
                trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SAV_03&APP_CMT="+kind+"&APP_YN="+app_yn;
                trT_DI_DISPATCH.post();

                document.getElementById("btn_approval").style.display = "none";
            }else{
                    alert("부결 또는 반송사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
	                return false;
           	}
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

    <!-- 공통 콤보를 위한 DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z4"/>
       <jsp:param name="CODE_GUBUN"    value="Z4"/>
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

        }

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
		if(dsT_DI_DISPATCH.NameValue(1,"DIS_PAY_YN") == "Y" ){
			document.getElementById("btn_trbfee").style.display = "";
		}else{
			document.getElementById("btn_trbfee").style.display = "none";
		}
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
    <script for=trT_DI_BUDGET_SHR event="OnSuccess()">
		document.getElementById("txtBUDGET_AMT").value = dsT_DI_BUDGET_RESULT.NameValue(1,"BUDGET_AMT");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUDGET_SHR event="OnFail()">
        cfErrorMsg(this);
    </script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">파견품의서</td>
					<td align="right" class="navigator">HOME/근태관리/파견관리/<font color="#000000">파견품의서</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="400" height="35" >
            <span id="btn_trbfee" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','/images/button/btn_DispatchOver.gif',1)"><img src="/images/button/btn_DispatchOn.gif" name="imgAccount" width="100" height="20" border="0" align="absmiddle" onClick="fnc_Calcul_Basis();"></a>
            </span>
            <span id="btn_appre" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)"><img src="/images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('상신');"></a>
            </span>

		</td>
		<td class="paddingTop5" align="right" width="400" height="35" >
            <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)"><img src="/images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('결재');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)"><img src="/images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('부결');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSendback','','/images/button/btn_SendbackOver.gif',1)"><img src="/images/button/btn_SendbackOn.gif" name="imgSendback" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitCancle('반송');"></a>
            </span>
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
								<td align="center" class="creamBold">파견자</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
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
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:560px;height:108px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
								<C> id='SEQ_NO'		width=40	name='NO'		align=center	show=false</C>
								<C> id='ENO_NO'		width=100	name='사번'		align=center	show=false</C>
								<C> id='SEQ_NM'		width=50	name='구분'		align=center	Value={IF (SEQ_NO > '90','협조', '결재')}</C>
								<C> id='ENO_NM'		width=70	name='결재자'	align=center</C>
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
                <tr>
                    <td align="right">
                        &nbsp;<span id="btn_InsDel">
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
        		              </span>
		            </td>
		       </tr>
            </table>
            <!-- 결재선 정보 테이블 끝 -->
        </td>
    </tr>
</table>

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<!--
				<colgroup>
					<col width="100"></col>
                    <col width="200"></col>
                    <col width="100"></col>
					<col width="**"></col>
				</colgroup>
				-->
				<tr>
					<td width="100" align="center" class="creamBold">파견기간</td>
					<td width="350" class="padding2423">
						<input id="txtDIS_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtDIS_FR_YMD','txtDIS_FR_YMD','txtDIS_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtDIS_FR_YMD','txtDIS_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtDIS_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtDIS_FR_YMD','','40','235');"></a>
                        <input id="txtDIS_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtDIS_TO_YMD','txtDIS_FR_YMD','txtDIS_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtDIS_FR_YMD','txtDIS_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtDIS_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtDIS_TO_YMD','','300','235');"></a>
						(<input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>박
                        <input id="txtDIS_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>일 )
                    </td>
					<td width="100" align="center" class="creamBold">파견비</td>
                    <td class="padding2423" >
						<select id="cmbDIS_PAY_YN" name="cmbDIS_PAY_YN" style="width:85" disabled>
                            <option value="Y">지급</option>
                            <option value="N">미지급</option>
                        </select>

					</td>
                </tr>
				<tr>
					<td align="center" class="creamBold">파견지역</td>
					<td class="padding2423">
						<select id="cmbDIS_CITY" style="width='100';" onChange="fnc_Auto_DisPayYn2()">
						</select>
                    </td>
					<td align="center" class="creamBold">근무지</td>
                    <td class="padding2423" >
						<input id="txtDIS_GUN" size="40" maxlength="25">
					</td>
                </tr>
                <tr>
					<td align="center" class="creamBold">파견목적</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtDIS_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=3 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">파견효과</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtDIS_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=3 >
						</textarea>
					</td>
				</tr>

				<!-- 테이블모양으로 인하여 삽입한 빈 태그(선언된 colgroup만큼 td가있어야 테이블 모양이 찌그러지지 않는다.) -->
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
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
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->
                <!-- 위에 삽입한 빈 태그로 인하여 선이 두꺼워 보이는것을 방지하기위하여 배경을 #FFFFFF로 바꾸어 해당 선위에 덮었다.-->
                <div style="position:absolute; left:20; top:585; width:800; height:1; z-index:2;" >
                    <table bgcolor="#FFFFFF" width="800"><tr><td></td></tr></table>
                </div>

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
        <C>Col=DIS_FR_YMD       Ctrl=txtDIS_FR_YMD  	Param=value 	</C>
        <C>Col=DIS_TO_YMD       Ctrl=txtDIS_TO_YMD  	Param=value 	</C>
		<C>Col=DIS_PAY_YN       Ctrl=cmbDIS_PAY_YN  	Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=DIS_DAY          Ctrl=txtDIS_DAY  	    Param=value 	</C>
        <C>Col=DIS_CITY         Ctrl=cmbDIS_CITY  	    Param=value 	</C>
        <C>Col=DIS_GUN          Ctrl=txtDIS_GUN  	    Param=value 	</C>
        <C>Col=DIS_OBJ          Ctrl=txtDIS_OBJ  	    Param=value 	</C>
        <C>Col=DIS_AFF          Ctrl=txtDIS_AFF  	    Param=value 	</C>
    '>
</object>