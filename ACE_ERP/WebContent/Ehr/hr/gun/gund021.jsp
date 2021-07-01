<!--
*****************************************************
* @source       : gund021.jsp
* @description : 연차휴가사용촉진제 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/19      오대성        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>연차휴가사용촉진제(gund021)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>






    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
			        //버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFTTFFFT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var pis_yy = document.form1.txtPIS_YY_SHR.value;	//해당년도
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//소속
			var eno_no = document.form1.txtENO_NO_SHR.value;	//소속

			if(pis_yy.trim().length == 0){
				alert("해당년도를 입력하세요.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}else if(pis_yy.trim().length != 4){
				alert("해당년년도가 올바르지 않습니다.");
				document.getElementById("txtPIS_YY_SHR").focus();
				return false;
			}

            trT_DI_ACCELERATE.KeyValue = "tr01(O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY, O:dsT_DI_ACCELERATE=dsT_DI_ACCELERATE, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_ACCELERATE.Action   = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund021.cmd.GUND021CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
            trT_DI_ACCELERATE.post();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;

			trT_DI_ACCELERATE.KeyValue = "tr02(I:dsT_DI_ACCELERATE=dsT_DI_ACCELERATE)";
			trT_DI_ACCELERATE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund021.cmd.GUND021CMD&S_MODE=SAV";
			trT_DI_ACCELERATE.post();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("imgSave").disabled = false;
            document.getElementById("imgSave").style.display = "";

			document.getElementById("resultMessage").innerText = ' ';
			dsT_DI_ACCELERATE.ClearAll();

            document.form1.txtPIS_YY_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_ACCELERATE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_showOct() {

			 if (form1.grdT_DI_ACCELERATE.ColumnProp("10월", "Show") == "TRUE") {
				form1.grdT_DI_ACCELERATE.ColumnProp("10월", "Show") = "false";
			 } else {
				form1.grdT_DI_ACCELERATE.ColumnProp("10월", "Show") = "true";
			 }
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_ACCELERATE.IsUpdated ) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			if(dsT_DI_ACCELERATE.NameValue(1, "YRP_REM")-(dsT_DI_ACCELERATE.NameValue(1, "ATT_OCT")+
				dsT_DI_ACCELERATE.NameValue(1, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(1, "ATT_DEC")) > 0){
				alert("잔여 연차를 모두 사용하십시요");
				return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			var todayMM = getToday().substring(5, 7);;
			var todayDD = getToday().substring(8);
			var key_man = '<%=box.get("SESSION_ENONO")%>';

if( !(key_man == "200196" || key_man == "200103")){
			//if(todayMM != "10"){
			//	alert("연차휴가촉진제는 10월 에만 사용가능합니다.");
			//	frame = window.external.GetFrame(window);
			//	frame.CloseFrame();
			//}

			//if(todayDD > "15"){
			//	alert("연차휴가촉진제는 10월 1일~15일 사이에만 사용가능합니다.");
			//	frame = window.external.GetFrame(window);
			//	frame.CloseFrame();
			//}

<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M") || box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>


			//if(todayDD > "15"){
			//	alert("연차휴가촉진제(관리자)는 10월 1일~15일 사이에만 사용가능합니다.");
			//	frame = window.external.GetFrame(window);
			//	frame.CloseFrame();
			//}
<%
			}
%>
}
	        dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"DPT_CD:STRING(3),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"SEQ_NO:STRING(1),"+			// 결재선
								"ENO_NO:STRING(10),"+			// 결재자사번
								"JOB_CD:STRING(10),"+			// 결재자직위
								"APP_TIME:STRING(10),"+			// 결재시간
								"PENO_NO:STRING(10),"+			// 상신자사번
								"APP_YN:STRING(10),"+			// 결재여부
								"ENO_NM:STRING(10),"+			// 결재자명
								"JOB_NM:STRING(10),"+				// 직위명
								"REQ_NO:STRING(20)"				// 직위명
								);
			cfStyleGrid(form1.grdT_DI_ACCELERATE,15,"true","false")      // Grid Style 적용
			form1.grdT_DI_ACCELERATE.SelectionColorProp("FocusEditRow", "BgColor") = "";
			form1.grdT_DI_ACCELERATE.SelectionColorProp("EditRow", "BgColor") = "";
            form1.grdT_DI_ACCELERATE.IgnoreSelectionColor = "true";

   	        var oYear = getToday().substring(0,4);

   	        document.getElementById("txtPIS_YY_SHR").value = oYear;
			document.form1.txtPIS_YY_SHR.focus();


          //document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
          //document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";

            document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value = "<%=box.getString("SESSION_ENONM") %>";



<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			 document.getElementById("approval_btn").style.display = "";
			 document.getElementById("append_btn").style.display = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%//A 는 자기부서만 통할
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			document.getElementById("approval_btn").style.display = "";
			document.getElementById("append_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
<%
    }else{
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

			fnc_ChangeStateElement(false, "txtENO_NO_SHR");
			fnc_ChangeStateElement(false, "txtENO_NM_SHR");
			fnc_ChangeStateElement(false, "ImgEnoNoSHR");

			 document.getElementById("approval_btn").style.display = "none";
			 document.getElementById("append_btn").style.display = "none";
<%
	}
%>

			fnc_OnLoadApproval();

        }

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNmSHR() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "txtDPT_CD_SHR", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


		//입력완료
		function fnc_Inputcomplete() {
		}
        /******************
         * 08. 추가 함수  *
         ******************/





        function fnc_Append() {

			if(dsT_DI_ACCELERATE.CountRow < 1){
				alert("연차촉진제내역을 먼저 조회하십시요.");
				return;
			}

            //ds를 리턴받는다.
            //fnc_GetApproverDS(dsT_DI_APPROVAL);

			var STR_YMD_SHR = document.getElementById("txtPIS_YY_SHR").value+"-09-01";
			var END_YMD_SHR = document.getElementById("txtPIS_YY_SHR").value+"-09-01";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var EMP_NO      = "<%=box.getString("SESSION_ENONO") %>";

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"A");

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
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";					//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// 서무가 일별 근태에서 결재자 뜨지 않게 하기위해서...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = EMP_NO;
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "A";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = document.getElementById("hidREQ_NO").value;

            }
        }







        function fnc_OnLoadApproval() {

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_DI_APPROVAL,15,"true","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight   = 18;
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
			form1.grdT_DI_APPROVAL.DisableNoHScroll = false;
			form1.grdT_DI_APPROVAL.DisableNoVScroll = false;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }
        function fnc_Report() {
			if(confirm("상신하시겠습니까? 연차휴가사항을 저장하신후에만 상신이 반영됩니다")){
				var STR_YMD = document.getElementById("txtPIS_YY_SHR").value;
				var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
				if(dsT_DI_ACCELERATE.CountRow == 0){
					alert("상신할 데이터를 먼저 조회하십시요");
					return;
				}
				if(dsT_DI_APPROVAL.CountRow == 0){
					alert("결재선을 지정 하십시요");
					return;
				}

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
				trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund021.cmd.GUND021CMD&S_MODE=REP&STR_YMD="+STR_YMD+"&DPT_CD="+DPT_CD;
				trT_DI_APPROVAL.post();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_HOLIDAY) |
    | 3. 사용되는 Table List(T_DI_HOLIDAY)          |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                        |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_ACCELERATE) |
    | 3. 사용되는 Table List(T_DI_ACCELERATE)          |
    +-------------------------------------------------->
    <Object ID="dsT_DI_ACCELERATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                           |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_ACCELERATE_CR) |
    | 3. 사용되는 Table List(T_DI_ACCELERATE)             |
    +----------------------------------------------------->
    <Object ID="dsT_DI_ACCELERATE_CR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
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
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_ACCELERATE)	|
    | 3. 사용되는 Table List(T_DI_ACCELERATE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_ACCELERATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_APPROVAL)		|
    | 3. 사용되는 Table List(T_DI_APPROVAL)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="sample_tr01(I:T_DI_APPROVAL=T_DI_APPROVAL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_ACCELERATE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();
			dsT_CM_PERSON.DataId="/servlet/GauceChannelSVL?cmd=hr.gun.d.gund021.cmd.GUND021CMD&S_MODE=SHR_01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
			dsT_CM_PERSON.Reset();

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
            //휴일 설정(토요일, 일요일)
			for(i=1;i<=iCount;i++){
                grdT_DI_ACCELERATE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM")+"_V", 'HeadBgColor') = "#F47380";
                grdT_DI_ACCELERATE.ColumnProp(dsT_DI_HOLIDAY.NameValue(i,"COL_NM"), 'edit') = "none";
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_ACCELERATE_CR Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            document.getElementById("resultMessage").innerText = "* "+document.getElementById("txtPIS_YY").value+"년도 데이터가 생성되었습니다.";

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_ACCELERATE_CR Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        document.getElementById("resultMessage").innerText = "* "+document.getElementById("txtPIS_YY").value+"년도 데이터가 이미 존재합니다.";

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 1)    {
			document.getElementById("txtDPT_CD_SHR").value = dsT_CM_PERSON.NameValue(1, "GUN_DPT");
			alert("조회 버튼을 다시 한번 Click하여 주십시요");
        }

    </Script>
	<script language=JavaScript for=dsT_CM_PERSON event=onLoadError()>
		alert("onLoadError");
	</script>
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_ACCELERATE event="OnSuccess()">
        if(trT_DI_ACCELERATE.KeyValue.substring(0,4) == "tr02"){
            fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
            fnc_SearchList();
        }
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_ACCELERATE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("상신이 완료되었습니다.");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>
    <!--------------------------------------------+
    | Grid를 DblClick했을때 발생하는 이벤트 처리  |
    +--------------------------------------------->
    <script language=JavaScript for=grdT_DI_ACCELERATE event=OnClick(row,colid)>

        var colid_1 = '';
        var colid_s = colid.split("_");
		var vCNT = dsT_DI_ACCELERATE.NameValue(row, "YRP_REM") - (dsT_DI_ACCELERATE.NameValue(row, "ATT_OCT")+dsT_DI_ACCELERATE.NameValue(row, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(row, "ATT_DEC"));
        // 추진일정 chekbox를 더블클릭하여 해당 값을 반영
        if (colid.substring(0,2) == "AT")  {
            //사용가능한 연차가 없는 경우
            if(dsT_DI_ACCELERATE.NameValue(row, colid.replace("_V","")) == ""){
                if(dsT_DI_ACCELERATE.NameValue(row, "YRP_REM") <= (dsT_DI_ACCELERATE.NameValue(row, "ATT_OCT")+dsT_DI_ACCELERATE.NameValue(row, "ATT_NOV")+dsT_DI_ACCELERATE.NameValue(row, "ATT_DEC"))){
                    alert("사용가능한 미사용 연차가 없습니다.");
                    return;
                }
            }

            colid_1 = colid.replace("_V","");

            if(form1.grdT_DI_ACCELERATE.ColumnProp(colid_1, 'edit') == 'NONE'){
                return;
            }

            if (dsT_DI_ACCELERATE.NameValue(row, colid_1) == 'H') {
                dsT_DI_ACCELERATE.NameValue(row, colid_1) = '';
                //연차합계수정
                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])-1;
            }else if (dsT_DI_ACCELERATE.NameValue(row, colid_1) == 'P') {
                dsT_DI_ACCELERATE.NameValue(row, colid_1) = '';
                //연차합계수정
                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])-0.5;
            }
            else {
				if (vCNT == 0.5) {
	                dsT_DI_ACCELERATE.NameValue(row, colid_1) = 'P';
	                //연차합계수정
	                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])+0.5;
				}
	            else {
					dsT_DI_ACCELERATE.NameValue(row, colid_1) = 'H';
	                //연차합계수정
	                dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1]) = dsT_DI_ACCELERATE.NameValue(row, "ATT_"+colid_s[1])+1;
				}
            }
        }

    </script>

    <script language="javascript"  for=grdT_DI_ACCELERATE event=OnCloseUp(row,colid)>



    </script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {
			document.getElementById("hidREQ_NO").value = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
        }else{
			document.getElementById("hidREQ_NO").value = "";
		}
		var APP_YN = "";
		for(var i = 1; i <= dsT_DI_APPROVAL.CountRow; i++){
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="Y"){
                APP_YN = "Y";
            }
            if(dsT_DI_APPROVAL.NameValue(i,"APP_YN")=="N"){
                APP_YN = "N";
				break
            }
		}
		if(APP_YN=="Y"){
			document.getElementById("save_btn").style.display = "none";		// 저장버튼
			document.getElementById("append_btn").style.display = "none";	// 상신버튼
			document.getElementById("btn_InsDel").style.display = "none";	// 결재선버튼
		}else{

			document.getElementById("save_btn").style.display = "";
		}
    </Script>

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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<input type="hidden" id="hidREQ_NO">
<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연차휴가사용촉진제</td>
					<td align="right" class="navigator">HOME/근태관리/연차관리/<font color="#000000">연차휴가사용촉진제</font></td>
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
	<span id="append_btn" style="display:none">
	  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRep','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Report()"></a>
	</span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	<span id="save_btn" style="display:none">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	</span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="80"></col>
                                <col width="220"></col>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
										<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','60','115');"></a>
								</td>
                                <td align="right" class="searchState">소속&nbsp;</td>
                                <td class="padding2423">
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
										<img src="/images/button/btn_HelpOn.gif" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
									</a>
                                </td>

								<td class="searchState" align="right">사번</td>
								<td class="padding2423" align="left">
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
									<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
								</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<div id="approval_btn" style="display:none">
	<!-- 결재선 테이블 시작 -->
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:112px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=96	name='부서'		align=center	</C>
									<C> id='JOB_NM'	width=96	name='직위'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
									<C> id='ENO_NM'	width=100	name='성명'		align=center	</C>
									<C> id='APP_YN'	width=100	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','승인','N','부결','미결')} </C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>

			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
	                    <td align="right">
	                        <span id="btn_InsDel">
	                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>

	                        </span>
			            </td>
					</tr>
					<tr>
	                    <td align="right">
	                        <span id="btn_InsDel2">
	                        <input type="button" id="btnPROC1" style="cursor:hand;width:100pt;height:20pt;" value=" 10월 보기/감추기 " onclick="fnc_showOct()">
	                        </span>
			            </td>
					</tr>
				</table>
			</td>


		</tr>
	</table>
</div>


<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="66%"><span id="resultMessage">&nbsp;</span></td>
					<!--
                    <td align="right" width="">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInputcomplete','','/images/button/btn_InputcompleteOver.gif',1)">    <img src="/images/button/btn_InputcompleteOn.gif"   name="imgInputcomplete"   width="80" height="20" border="0" align="absmiddle" onClick="fnc_Inputcomplete()"></a>
                    </td>
					-->
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_ACCELERATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_ACCELERATE">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'			width=34			name='NO'			align=center			value={String(Currow)}		</FC>
								<FC> id='DPT_NM'			width=80			name='소속'			align=center			Edit=None					</FC>
								<FC> id='JOB_NM'			width=50			name='직위'			align=center			Edit=None					</FC>
								<FC> id='ENO_NO'			width=60			name='사번'			align=center			Edit=None					</FC>
								<FC> id='ENO_NM'			width=60			name='성명'			align=center			Edit=None					</FC>
                                <FC> id='YRP_REM'			width=50			name='미사용;연차'	align=center			Edit=None	DECAO=1				</FC>
                                <FC> id='REM_CNT'		    width=40			name='잔여'	        align=center			Edit=None	DECAO=1		Value={YRP_REM-(ATT_OCT+ATT_NOV+ATT_DEC)}	</FC>
                                <G> name='10월'  HeadBgColor='#F7DCBB' Show=false
									<C> id='AT1_OCT'		width=20		name='1'				align=center			Show=false		</C>
									<C> id='AT2_OCT'		width=20		name='2'				align=center			Show=false		</C>
                                    <C> id='AT3_OCT'		width=20		name='3'				align=center			Show=false		</C>
									<C> id='AT4_OCT'		width=20		name='4'				align=center			Show=false		</C>
                                    <C> id='AT5_OCT'		width=20		name='5'				align=center			Show=false		</C>
									<C> id='AT6_OCT'		width=20		name='6'				align=center			Show=false		</C>
                                    <C> id='AT7_OCT'		width=20		name='7'				align=center			Show=false		</C>
									<C> id='AT8_OCT'		width=20		name='8'				align=center			Show=false		</C>
                                    <C> id='AT9_OCT'		width=20		name='9'				align=center			Show=false		</C>
									<C> id='AT10_OCT'		width=20		name='10'				align=center			Show=false		</C>
                                    <C> id='AT11_OCT'		width=20		name='11'				align=center			Show=false		</C>
                                    <C> id='AT12_OCT'		width=20		name='12'				align=center			Show=false		</C>
                                    <C> id='AT13_OCT'		width=20		name='13'				align=center			Show=false		</C>
                                    <C> id='AT14_OCT'		width=20		name='14'				align=center			Show=false		</C>
                                    <C> id='AT15_OCT'		width=20		name='15'				align=center			Show=false		</C>
                                    <C> id='AT16_OCT'		width=20		name='16'				align=center			Show=false		</C>
                                    <C> id='AT17_OCT'		width=20		name='17'				align=center			Show=false		</C>
                                    <C> id='AT18_OCT'		width=20		name='18'				align=center			Show=false		</C>
                                    <C> id='AT19_OCT'		width=20		name='19'				align=center			Show=false		</C>
                                    <C> id='AT20_OCT'		width=20		name='20'				align=center			Show=false		</C>
                                    <C> id='AT21_OCT'		width=20		name='21'				align=center			Show=false		</C>
                                    <C> id='AT22_OCT'		width=20		name='22'				align=center			Show=false		</C>
                                    <C> id='AT23_OCT'		width=20		name='23'				align=center			Show=false		</C>
                                    <C> id='AT24_OCT'		width=20		name='24'				align=center			Show=false		</C>
                                    <C> id='AT25_OCT'		width=20		name='25'				align=center			Show=false		</C>
                                    <C> id='AT26_OCT'		width=20		name='26'				align=center			Show=false		</C>
                                    <C> id='AT27_OCT'		width=20		name='27'				align=center			Show=false		</C>
                                    <C> id='AT28_OCT'		width=20		name='28'				align=center			Show=false		</C>
                                    <C> id='AT29_OCT'		width=20		name='29'				align=center			Show=false		</C>
                                    <C> id='AT30_OCT'		width=20		name='30'				align=center			Show=false		</C>
                                    <C> id='AT31_OCT'		width=20		name='31'				align=center			Show=false		</C>
                                    <C> id='AT1_OCT_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT2_OCT_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT3_OCT_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT4_OCT_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT5_OCT_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT6_OCT_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT7_OCT_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT8_OCT_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT9_OCT_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT10_OCT_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT11_OCT_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT12_OCT_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT13_OCT_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT14_OCT_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT15_OCT_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT16_OCT_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT17_OCT_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT18_OCT_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT19_OCT_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT20_OCT_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT21_OCT_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT22_OCT_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT23_OCT_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT24_OCT_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT25_OCT_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT26_OCT_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT27_OCT_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT28_OCT_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT29_OCT_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT30_OCT_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT31_OCT_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_OCT,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
								</G>
                                <G> name='11월'  HeadBgColor='#F7DCBB'
									<C> id='AT1_NOV'		width=20		name='1'				align=center			Show=false		</C>
									<C> id='AT2_NOV'		width=20		name='2'				align=center			Show=false		</C>
                                    <C> id='AT3_NOV'		width=20		name='3'				align=center			Show=false		</C>
									<C> id='AT4_NOV'		width=20		name='4'				align=center			Show=false		</C>
                                    <C> id='AT5_NOV'		width=20		name='5'				align=center			Show=false		</C>
									<C> id='AT6_NOV'		width=20		name='6'				align=center			Show=false		</C>
                                    <C> id='AT7_NOV'		width=20		name='7'				align=center			Show=false		</C>
									<C> id='AT8_NOV'		width=20		name='8'				align=center			Show=false		</C>
                                    <C> id='AT9_NOV'		width=20		name='9'				align=center			Show=false		</C>
									<C> id='AT10_NOV'		width=20		name='10'				align=center			Show=false		</C>
                                    <C> id='AT11_NOV'		width=20		name='11'				align=center			Show=false		</C>
                                    <C> id='AT12_NOV'		width=20		name='12'				align=center			Show=false		</C>
                                    <C> id='AT13_NOV'		width=20		name='13'				align=center			Show=false		</C>
                                    <C> id='AT14_NOV'		width=20		name='14'				align=center			Show=false		</C>
                                    <C> id='AT15_NOV'		width=20		name='15'				align=center			Show=false		</C>
                                    <C> id='AT16_NOV'		width=20		name='16'				align=center			Show=false		</C>
                                    <C> id='AT17_NOV'		width=20		name='17'				align=center			Show=false		</C>
                                    <C> id='AT18_NOV'		width=20		name='18'				align=center			Show=false		</C>
                                    <C> id='AT19_NOV'		width=20		name='19'				align=center			Show=false		</C>
                                    <C> id='AT20_NOV'		width=20		name='20'				align=center			Show=false		</C>
                                    <C> id='AT21_NOV'		width=20		name='21'				align=center			Show=false		</C>
                                    <C> id='AT22_NOV'		width=20		name='22'				align=center			Show=false		</C>
                                    <C> id='AT23_NOV'		width=20		name='23'				align=center			Show=false		</C>
                                    <C> id='AT24_NOV'		width=20		name='24'				align=center			Show=false		</C>
                                    <C> id='AT25_NOV'		width=20		name='25'				align=center			Show=false		</C>
                                    <C> id='AT26_NOV'		width=20		name='26'				align=center			Show=false		</C>
                                    <C> id='AT27_NOV'		width=20		name='27'				align=center			Show=false		</C>
                                    <C> id='AT28_NOV'		width=20		name='28'				align=center			Show=false		</C>
                                    <C> id='AT29_NOV'		width=20		name='29'				align=center			Show=false		</C>
                                    <C> id='AT30_NOV'		width=20		name='30'				align=center			Show=false		</C>
                                    <C> id='AT1_NOV_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT2_NOV_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT3_NOV_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT4_NOV_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT5_NOV_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT6_NOV_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT7_NOV_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT8_NOV_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT9_NOV_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT10_NOV_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT11_NOV_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT12_NOV_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT13_NOV_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT14_NOV_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT15_NOV_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT16_NOV_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT17_NOV_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT18_NOV_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT19_NOV_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT20_NOV_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT21_NOV_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT22_NOV_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT23_NOV_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT24_NOV_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT25_NOV_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT26_NOV_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT27_NOV_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT28_NOV_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT29_NOV_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT30_NOV_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_NOV,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
								</G>
                                <G> name='12월'  HeadBgColor='#F7DCBB'
									<C> id='AT1_DEC'		width=20		name='1'				align=center			Show=false		</C>
									<C> id='AT2_DEC'		width=20		name='2'				align=center			Show=false		</C>
                                    <C> id='AT3_DEC'		width=20		name='3'				align=center			Show=false		</C>
									<C> id='AT4_DEC'		width=20		name='4'				align=center			Show=false		</C>
                                    <C> id='AT5_DEC'		width=20		name='5'				align=center			Show=false		</C>
									<C> id='AT6_DEC'		width=20		name='6'				align=center			Show=false		</C>
                                    <C> id='AT7_DEC'		width=20		name='7'				align=center			Show=false		</C>
									<C> id='AT8_DEC'		width=20		name='8'				align=center			Show=false		</C>
                                    <C> id='AT9_DEC'		width=20		name='9'				align=center			Show=false		</C>
									<C> id='AT10_DEC'		width=20		name='10'				align=center			Show=false		</C>
                                    <C> id='AT11_DEC'		width=20		name='11'				align=center			Show=false		</C>
                                    <C> id='AT12_DEC'		width=20		name='12'				align=center			Show=false		</C>
                                    <C> id='AT13_DEC'		width=20		name='13'				align=center			Show=false		</C>
                                    <C> id='AT14_DEC'		width=20		name='14'				align=center			Show=false		</C>
                                    <C> id='AT15_DEC'		width=20		name='15'				align=center			Show=false		</C>
                                    <C> id='AT16_DEC'		width=20		name='16'				align=center			Show=false		</C>
                                    <C> id='AT17_DEC'		width=20		name='17'				align=center			Show=false		</C>
                                    <C> id='AT18_DEC'		width=20		name='18'				align=center			Show=false		</C>
                                    <C> id='AT19_DEC'		width=20		name='19'				align=center			Show=false		</C>
                                    <C> id='AT20_DEC'		width=20		name='20'				align=center			Show=false		</C>
                                    <C> id='AT21_DEC'		width=20		name='21'				align=center			Show=false		</C>
                                    <C> id='AT22_DEC'		width=20		name='22'				align=center			Show=false		</C>
                                    <C> id='AT23_DEC'		width=20		name='23'				align=center			Show=false		</C>
                                    <C> id='AT24_DEC'		width=20		name='24'				align=center			Show=false		</C>
                                    <C> id='AT25_DEC'		width=20		name='25'				align=center			Show=false		</C>
                                    <C> id='AT26_DEC'		width=20		name='26'				align=center			Show=false		</C>
                                    <C> id='AT27_DEC'		width=20		name='27'				align=center			Show=false		</C>
                                    <C> id='AT28_DEC'		width=20		name='28'				align=center			Show=false		</C>
                                    <C> id='AT29_DEC'		width=20		name='29'				align=center			Show=false		</C>
                                    <C> id='AT30_DEC'		width=20		name='30'				align=center			Show=false		</C>
                                    <C> id='AT31_DEC'		width=20		name='31'				align=center			Show=false		</C>
                                    <C> id='AT1_DEC_V'		width=20		name='1'				align=center	edit='None'       bgcolor={Decode(AT1_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT2_DEC_V'		width=20		name='2'				align=center	edit='None'       bgcolor={Decode(AT2_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT3_DEC_V'		width=20		name='3'				align=center	edit='None'       bgcolor={Decode(AT3_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT4_DEC_V'		width=20		name='4'				align=center	edit='None'       bgcolor={Decode(AT4_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT5_DEC_V'		width=20		name='5'				align=center	edit='None'       bgcolor={Decode(AT5_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT6_DEC_V'		width=20		name='6'				align=center	edit='None'       bgcolor={Decode(AT6_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT7_DEC_V'		width=20		name='7'				align=center	edit='None'       bgcolor={Decode(AT7_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT8_DEC_V'		width=20		name='8'				align=center	edit='None'       bgcolor={Decode(AT8_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT9_DEC_V'		width=20		name='9'				align=center	edit='None'       bgcolor={Decode(AT9_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
									<C> id='AT10_DEC_V'		width=20		name='10'				align=center	edit='None'       bgcolor={Decode(AT10_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT11_DEC_V'		width=20		name='11'				align=center	edit='None'       bgcolor={Decode(AT11_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT12_DEC_V'		width=20		name='12'				align=center	edit='None'       bgcolor={Decode(AT12_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT13_DEC_V'		width=20		name='13'				align=center	edit='None'       bgcolor={Decode(AT13_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT14_DEC_V'		width=20		name='14'				align=center	edit='None'       bgcolor={Decode(AT14_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT15_DEC_V'		width=20		name='15'				align=center	edit='None'       bgcolor={Decode(AT15_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT16_DEC_V'		width=20		name='16'				align=center	edit='None'       bgcolor={Decode(AT16_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT17_DEC_V'		width=20		name='17'				align=center	edit='None'       bgcolor={Decode(AT17_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT18_DEC_V'		width=20		name='18'				align=center	edit='None'       bgcolor={Decode(AT18_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT19_DEC_V'		width=20		name='19'				align=center	edit='None'       bgcolor={Decode(AT19_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT20_DEC_V'		width=20		name='20'				align=center	edit='None'       bgcolor={Decode(AT20_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT21_DEC_V'		width=20		name='21'				align=center	edit='None'       bgcolor={Decode(AT21_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT22_DEC_V'		width=20		name='22'				align=center	edit='None'       bgcolor={Decode(AT22_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT23_DEC_V'		width=20		name='23'				align=center	edit='None'       bgcolor={Decode(AT23_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT24_DEC_V'		width=20		name='24'				align=center	edit='None'       bgcolor={Decode(AT24_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT25_DEC_V'		width=20		name='25'				align=center	edit='None'       bgcolor={Decode(AT25_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT26_DEC_V'		width=20		name='26'				align=center	edit='None'       bgcolor={Decode(AT26_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT27_DEC_V'		width=20		name='27'				align=center	edit='None'       bgcolor={Decode(AT27_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT28_DEC_V'		width=20		name='28'				align=center	edit='None'       bgcolor={Decode(AT28_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT29_DEC_V'		width=20		name='29'				align=center	edit='None'       bgcolor={Decode(AT29_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT30_DEC_V'		width=20		name='30'				align=center	edit='None'       bgcolor={Decode(AT30_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
                                    <C> id='AT31_DEC_V'		width=20		name='31'				align=center	edit='None'       bgcolor={Decode(AT31_DEC,'H','#F2AC47','P','#087F01','#FEEFEF')} </C>
								</G>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table  align="center" border="0" cellspacing="0" cellpadding="0" >
	<tr height="18">
		<td width="50">범례:</td>
		<td width="18"   bgcolor="#F2AC47"></td>
		<td width="60">연차휴가</td>
		<td width="18"   bgcolor="#087F01"></td>
		<td width="150">오전반차 (마지막 지정)</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>