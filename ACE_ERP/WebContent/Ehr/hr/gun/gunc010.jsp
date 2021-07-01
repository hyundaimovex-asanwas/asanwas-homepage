<!--
*****************************************************
* @source       : gunc010.jsp
* @description : 휴일근무결과보고 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/08      한학현        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴일근무결과보고</title>
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
		var btnList = 'TTTTTFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	//검색조건
			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value;      //휴일근무일자.
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value;       //소속
			var ENO_NO_SHR   = document.getElementById("txtENO_NO_SHR").value;

            //해당년월이 없으면 조회못함.
			if(HOL_YMD_SHR.trim().length == 0){
					alert("휴일근무일자를 입력하세요.");
					document.getElementById("txtHOL_YMD_SHR").focus();
					return false;
			}

			//해당년월이 잘못되었으면 조회못함.
			if(HOL_YMD_SHR.trim().length != 10){
					alert("휴일근무일자가 잘못 되었습니다.");
					document.getElementById("txtHOL_YMD_SHR").focus();
					return false;
			}

			//소속이 없으면
			if(DPT_CD_SHR.trim().length == 0){
					alert("소속을 입력하세요.");
					document.getElementById("txtDPT_CD_SHR").focus();
					return false;
			}


            //조회 해당년월을 저장한다.
            document.getElementById("hidDPT_CD_ORI").value = DPT_CD_SHR;

			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR"
                                      + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                      + "&DPT_CD_SHR="+DPT_CD_SHR
                                      + "&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_DI_HOLIDAYWORK.reset();

            //결재자 조회
            fnc_SearchApprover();


        }

        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {
            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;

			HOL_YMD = HOL_YMD.replace("-","").replace("-","")
            var REQ_NO  = HOL_YMD + "H" + DPT_CD;

            dsT_DI_APPROVAL.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna071.cmd.GUNA071CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=H";
            dsT_DI_APPROVAL.Reset();
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
            var HOL_YMD_SHR  = document.form1.txtHOL_YMD_SHR.value;
            var MSG05 = "";


			if (!dsT_DI_HOLIDAYWORK.IsUpdated && !dsT_DI_APPROVAL.IsUpdated ) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
            //5회 초과신청시 초과분부터 무조건대체휴가지정
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {



		           //******************  2011.05       5회초과신청시 초과분부터 무조건대체휴가지정
    	            var ENO_NO_NEW  = dsT_DI_HOLIDAYWORK.NameString(i, "ENO_NO");  // - 5회 Check 대상 사원번호
					dsT_DI_HOLWORK_05.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR_05"
                                      + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                      + "&ENO_NO_SHR="+ENO_NO_NEW;
					dsT_DI_HOLWORK_05.reset();

            	if(dsT_DI_HOLWORK_05.CountRow >= 3 && dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") == '1') {

	            	  MSG05 = dsT_DI_HOLIDAYWORK.NameString(i, "ENO_NM")+ " - 휴일 근무수당 3회 초과  신청 불가합니다.\n\n대체휴가로 신청 후 저장 바랍니다.\n\n 휴일 근무수당 신청일 : ";

	            	  		for(var j = 1; j <= dsT_DI_HOLWORK_05.CountRow; j++) {
	            	  	 	    MSG05 = MSG05 + dsT_DI_HOLWORK_05.NameString(j, "HOL_YMD") + "  ";
	            	  		}
	            	  alert(MSG05);
            	}

           	}

			if (MSG05 != "") {
			    document.getElementById("resultMessage").innerText = '>> 작업은 취소되었습니다. 수정 후 다시 저장하여 주십시요';
			    return;
			}

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD&S_MODE=SAV";
			trT_DI_HOLIDAYWORK.post();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_DI_HOLIDAYWORK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_HOLIDAYWORK.GridToExcel("휴일근무결과보고", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }


        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
            //사용안하는 것들 막기
             fnc_HiddenElement("imgSelectapproval");
             fnc_HiddenElement("imgReport");
             fnc_HiddenElement("imgSave");
             fnc_DisableElementAll(elementList);

			dsT_DI_HOLIDAYWORK.ClearData();
			dsT_DI_APPROVAL.ClearData();


            document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// 소속
            document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// 소속
            document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// 소속


			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtHOL_YMD_SHR.focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_HOLIDAYWORK.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();

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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //사용안하는 것들 막기
            fnc_HiddenElement("imgSelectapproval");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("imgSave");

            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,15,"false","false")      // Grid Style 적용
        	cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용
			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;

            document.getElementById("hidDPT_CD_ORI").value = "<%= box.get("SESSION_DPTCD")%>";// 소속
            document.getElementById("txtDPT_CD_SHR").value = "<%= box.get("SESSION_DPTCD")%>";// 소속
            document.getElementById("txtDPT_NM_SHR").value = "<%= box.get("SESSION_DPTNM")%>";// 소속

<%
    //마스터가 아니면 소속 부서만 조회 하게
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "txtDPT_NM_SHR");
            fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>

<%
    //마스터는 모든부서 통할
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			 document.getElementById("approval_btn").style.display = "";
			 document.getElementById("approval_btn").style.display = "";
<%  //A 는 자기부서만 통할
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
			document.getElementById("approval_btn").style.display = "";
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }else{
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
			fnc_ChangeStateElement(false, "ImgDptCd");

			fnc_ChangeStateElement(false, "txtENO_NO");
			fnc_ChangeStateElement(false, "txtENO_NM");
			fnc_ChangeStateElement(false, "ImgEnoNo");
			document.getElementById("txtENO_NO_SHR").value = "<%=box.getString("SESSION_ENONO") %>";
			document.getElementById("approval_btn").style.display = "none";

<%
	}
%>
            document.form1.txtHOL_YMD_SHR.focus();
			document.getElementById("resultMessage").innerText = '>> 작업순서: 근무일자 조회 => 근무시간/내용 입력 => 저장';
            //시작하자마자 폼 로드
    //        fnc_SearchList();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



        /**
         * 결재선 지정.
         */
        function fnc_Approval() {
            var DPT_CD = document.getElementById("hidDPT_CD_ORI").value;
			var EMP_NO =  "<%=box.getString("SESSION_ENONO") %>";
            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
			HOL_YMD = HOL_YMD.replace("-","").replace("-","")

            //ds를 리턴받는다.
            dsT_DI_APPROVAL.ClearData();
            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "H");

            //강제로 IsUpdated 체크하게 만듬

            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"GUN_DPT")=  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//결재선(결재순서)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = HOL_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = "<%=box.get("SESSION_ENONO")%>";	//상신자 사번
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "H";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
            }
        }

		function fnc_Hol_Time(){

           var hol_time =  fnc_covNumber(document.getElementById("cmbEND_AFT_HOUR").value) - fnc_covNumber(document.getElementById("cmbSTR_AFT_HOUR").value);

   		   if(document.getElementById("cmbSTR_AFT_HOUR").value == "24") {
				document.getElementById("cmbSTR_AFT_MIN").value = "00";
   		   }
   		   if(document.getElementById("cmbEND_AFT_HOUR").value == "24") {
				document.getElementById("cmbEND_AFT_MIN").value = "00";
   		   }

           if(parseInt(hol_time) < 0){
              alert("종료시간이 시작시간보다 작습니다. 다시 지정해 주세요");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return;
   		   }
   		   if(!(parseInt(hol_time) == 0) && ((parseInt(hol_time) > 8) || (parseInt(hol_time) < 4))) {
              alert("8시간/일 초과  또는 4시간/일 미만  근무 불인정. 다시 지정해 주세요");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return;
   		   }

		}

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3", "1", "1");

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
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidDPT_CD_ORI", "3");

            if(obj.eno_no.substring(0,1) == "8"){
              alert("파견사원은 해당 메뉴로 신청할 수 없습니다.");
              dsT_DI_HOLIDAYWORK.DeleteRow(dsT_DI_HOLIDAYWORK.RowPosition);
              return false;
            }

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            } else {
                document.getElementById("txtENO_NO").value = "";
	            document.getElementById("txtENO_NM").value = "";
	            document.getElementById("txtJOB_CD").value = "";
	            document.getElementById("txtJOB_NM").value = "";
	            document.getElementById("txtDPT_CD").value = "";
	            document.getElementById("txtDPT_NM").value = "";
            }
        }

        function fnc_Ymd_Len(){
            if(document.getElementById("txtHOL_YMD_SHR").value.length == 10){
              fnc_SearchList();
            }

        }


  		/**
         * 날짜 체크 실제 휴일인지를 체크 한다.
         */
		function fnc_CheckDate(){
			var sel_ymd = document.getElementById("txtHOL_YMD_SHR").value.replace(/-/g, "");

			if(sel_ymd.length == 8){

                //1.실제휴일인지 체크
                dsT_DI_HOLIDAY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc010.cmd.GUNC010CMD"
                                      + "&S_MODE=SHR_02"
                                      + "&HOL_YMD="+sel_ymd;
                dsT_DI_HOLIDAY.reset();

           /**     if(dsT_DI_HOLIDAY.NameValue(1,"CHK_YN") == "N"){
                    alert("해당일자는 신청가능 일자가 아닙니다.");
                    document.getElementById("txtHOL_YMD_SHR").value = "";
                    document.getElementById("txtHOL_YMD_SHR").focus();
                    return false;
                }  잠시 조건 해제 Test용 **/
			}
		}


        /**
         * 상신처리
         */
        function fnc_Conduct() {

        	var unworked_no = 0;

            if(dsT_DI_HOLIDAYWORK.CountRow < 1){
              alert("상신가능한 휴일근무신청내역이 없습니다");
              return;
            }

            //신청자 전원 미근무 했을 경우 상신하지 말자!
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {
            	if(dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") == "3")
            		unworked_no++;
            }

            //결과보고시 근무시간을 빼먹지 말자!
            for(var i = 1; i <= dsT_DI_HOLIDAYWORK.CountRow; i++) {
            	if(dsT_DI_HOLIDAYWORK.NameString(i, "STR_AFT_HOUR") == "00" && dsT_DI_HOLIDAYWORK.NameString(i, "STR_AFT_MIN") == "00"
            	  && dsT_DI_HOLIDAYWORK.NameString(i, "END_AFT_HOUR") == "00" && dsT_DI_HOLIDAYWORK.NameString(i, "END_AFT_MIN") == "00"
            	  && dsT_DI_HOLIDAYWORK.NameString(i, "REP_APP") != "3") {
	              alert("근무시간을 입력하십시오.");
	              return;
            	}
           	}

            if(dsT_DI_HOLIDAYWORK.CountRow == unworked_no){
            	alert("전원 미근무시 상신할 필요가 없습니다.");
            	return;
            }

            //1.상신처리 조건함
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("결재선을 지정해주세요.");
                return;
            }
            //2.상신처리

            var HOL_YMD = document.getElementById("txtHOL_YMD_SHR").value;
			var GUN_YMD = HOL_YMD.replace("-","").replace("-","")
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var REQ_NO  = GUN_YMD + "H" + DPT_CD;

			trT_DI_HOLIDAYWORK.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_HOLIDAYWORK.action = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc090.cmd.GUNC090CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"H"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="+REQ_NO;
			trT_DI_HOLIDAYWORK.post();
		}


        //입력 element
        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_AFT_HOUR"
                                        ,"cmbSTR_AFT_MIN"
                                        ,"cmbEND_AFT_HOUR"
                                        ,"cmbEND_AFT_MIN"
                                        ,"txtREMARK" );

        //예외 항목
        var exceptionList = new Array(   "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo");

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_HOLIDAYWORK                                |
    | 3. Table List : T_DI_HOLIDAYWORK                           |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <Object ID="dsT_DI_HOLWORK_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_HOLIDAY                                      |
    | 3. Table List : T_DI_HOLIDAY                                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			                  |
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_HOLIDAYWORK)		  |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_DI_HOLIDAYWORK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

        var APP_YN  = dsT_DI_HOLIDAYWORK.NameString(1, "SIGN_TAG");  //결재자 결재 유무 '':저장, 'R':상신, 'Y':결재, 'N':반려

            if(APP_YN == "" || APP_YN == "N") {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgReport");
                fnc_ShowElement("imgSave");
           		rdoREP_APP.Enable = "true";


			}else if(APP_YN == "R" || APP_YN == "Y") { // 상신했을 경우 저장버튼 안보이게.. 그 상태에서 결재 후 시간바꿔 저장할수있다.
			        fnc_HiddenElement("imgSave");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
					rdoREP_APP.Enable = "false";
                    }
			rdoREP_APP.reset();
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_HOLIDAYWORK Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_HOLIDAY Event="OnDataError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_HOLIDAYWORK event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_HOLIDAYWORK event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-------------------------------------+
    | 그리드 조회시 화면설정 변경 및 결재선 조회|
    +-------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        var today   = fnc_covNumber(getToday());

        if(row > 0) {

            //오늘이 신청기간이면 입력창 풀어 놓기
            /*
             * TEST
            if(holFrom <= today && today <= holTo) {
             */

                //저장상태이거나 부결일때 수정이 가능함
                if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
                        || dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N"
                        || dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N") {
                    //신규일 경우
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {
                        fnc_EnableElementAll(elementList);
                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);
                    }
                }
            /*
            }
            */
        }
	</script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_DI_HOLIDAYWORK event=CanRowPosChange(row)>

		var oENO_NO = dsT_DI_HOLIDAYWORK.NameValue(row, "ENO_NO");
		if(oENO_NO.trim().length == 0){
			alert("사번을 입력하세요.");
			document.getElementById("txtENO_NO").focus();
			return false;
		}
		if(oENO_NO.trim().length != 6){
			alert("사번이 잘못되었습니다.");
			document.getElementById("txtENO_NO").focus();
			return false;
		}

		var oREP_APP = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_APP");
		var oREP_YMD = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_YMD");
		var oREP_TYP = dsT_DI_HOLIDAYWORK.NameValue(row, "REP_TYP");
		var oHOL_YMD = dsT_DI_HOLIDAYWORK.NameValue(row, "HOL_YMD");
		if(oREP_APP.trim() == ""){
			alert("휴일근무신청을 선택하세요.");
			return false;
		}else if(oREP_APP.trim() == "2" ){
		    if(oREP_YMD.trim() == ""){
				alert("대체휴일을 지정하십시요.");
				return false;
			}
			if(oREP_TYP.trim() == ""){
				alert("대체휴가 반차/전일 지정하십시요.");
				return false;
			}
			if(oREP_YMD <= oHOL_YMD){
				alert("대체 휴가일이 휴일근무보다 이전입니다. 다시 지정해 주세요");
				document.getElementById("txtREP_YMD").focus();
				return false;
			}
		}else if(oREP_APP.trim() == "1" || oREP_APP.trim() == "3"){
			    if(oREP_TYP.trim() == "" || oREP_YMD.trim() == ""){
			    }
			    else{
			    document.getElementById("txtREP_YMD").value = "";
			    document.getElementById("rdoREP_TYP").CodeValue="";
			    rdoREP_TYP.Reset();
				alert("대체휴가 입력사항은 취소되었습니다.");
				return false;
				}
		}
		var hol_time =  fnc_covNumber(document.getElementById("cmbEND_AFT_HOUR").value) - fnc_covNumber(document.getElementById("cmbSTR_AFT_HOUR").value);
	   if(!(parseInt(hol_time) == 0) && ((parseInt(hol_time) > 8) || (parseInt(hol_time) < 4))) {
	          alert("8시간/일 초과  또는 4시간/일 미만  근무 불인정. 다시 지정해 주세요");
              document.getElementById("cmbEND_AFT_HOUR").value = "00";
              document.getElementById("cmbEND_AFT_MIN" ).value = "00";
              return false;
   		   }

    </script>
    <!-----------------------------+
    | 라디오 버튼  선택했을때 처리 |
    +------------------------------>
	<script language=JavaScript for=rdoREP_APP event=OnSelChange()>
		if(rdoREP_APP.CodeValue == "1" || rdoREP_APP.CodeValue == "3"){
			fnc_ChangeStateElement(false, "txtREP_YMD");
			fnc_ChangeStateElement(false, "imgREP_YMD");
		    document.getElementById("txtREP_YMD").value = "";
		    document.getElementById("rdoREP_TYP").CodeValue="";
		    document.getElementById("rdoREP_TYP").DataValue="";
		    rdoREP_TYP.Reset();
			rdoREP_TYP.Enable = "false";
		}else{
			fnc_ChangeStateElement(true, "txtREP_YMD");
			fnc_ChangeStateElement(true, "imgREP_YMD");
			rdoREP_TYP.Enable = "true";
		}

	</script>
	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		var obj = new String();
		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("/hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
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
<input type=hidden id="txtENO_NO_SHR" size="10">
<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴일근무결과보고</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/<font color="#000000">휴일근무결과보고</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left"> <font color="#6A5ACD">
		  * 휴일근무지급기준:전월1일~말일분까지 금월급여에 산정 <br>
		  * 입력기간:휴일근무실시 다음주 금요일까지 품의,결재완료  <br>
		  * 휴일 근무 시간 : 4 ~ 8 시간 인정 <br>
			</font>
		</td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                	<col width="100"></col>
                    <col width="200"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td align="right" class="searchState">휴일근무일자&nbsp;</td>
                    <td class="padding2423">

                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="100" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input id="txtHOL_YMD_SHR" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" onFocus="fnc_CheckDate();fnc_Ymd_Len();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YMD_SHR','','190','115');"></a>
                                </td>
                            </tr>
                   </table>

					</td>
                    <td align="right" class="searchState">소&nbsp;&nbsp;속&nbsp;</td>
                    <td class="padding2423">
                        <input id="hidDPT_CD_ORI" type="hidden">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->



<table border="0">
	<tr>
		<td valign="top">
			<!-- 조건 입력 테이블 시작 -->
			<table width="350" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="100"></col>
                                <col width="250"></col>
                            </colgroup>
							<tr>
								<td align="center" class="creamBold">사원번호</td>
                                <td class="padding2423" >
                                    <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                                    <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                                    <input type="hidden" id="txtJOB_CD">
                                    <input type="hidden" id="txtJOB_NM">
                                    <input type="hidden" id="txtDPT_CD">
                                    <input type="hidden" id="txtDPT_NM">
                                </td>
							</tr>
	                        <tr>
								<td align="center" class="creamBold">근무시간</td>
								<td class="padding2423" >
									<select id="cmbSTR_AFT_HOUR" style="width:40px" onChange="document.getElementById('cmbEND_AFT_HOUR').value = this.value;fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
									</select>:
                                    <select id="cmbSTR_AFT_MIN" style="width:40px" onChange="document.getElementById('cmbEND_AFT_MIN').value = this.value;fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="05">05</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
                                    &nbsp;~&nbsp;
                                    <select id="cmbEND_AFT_HOUR" style="width:40px" onChange="fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                    </select>:
                                    <select id="cmbEND_AFT_MIN" style="width:40px" onChange="fnc_Hol_Time();">
                                        <option value="00">00</option>
                                        <option value="05">05</option>
                                        <option value="10">10</option>
                                        <option value="15">15</option>
                                        <option value="20">20</option>
                                        <option value="25">25</option>
                                        <option value="30">30</option>
                                        <option value="35">35</option>
                                        <option value="40">40</option>
                                        <option value="45">45</option>
                                        <option value="50">50</option>
                                        <option value="55">55</option>
                                    </select>
         						</td>
                            </tr>
                            <tr>
								<td align="center" class="creamBold">수당구분</td>
								<td class="padding2423" >
                                    <comment id="__NSID__">
                                        <object id=rdoREP_APP classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:220;">
                                            <param name=AutoMargin  value="true">
                                            <param name=Cols        value="3">
                                            <param name=Format      value="1^휴일근무수당,2^대체휴가,3^미근무">
                                        </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
							</tr>
                            <tr>
								<td align="center" class="creamBold">대체휴가</td>
								<td class="padding2423" >
			 						<input type="text" id="txtREP_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgREP_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgREP_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtREP_YMD','','150','200');"></a>
                                    <comment id="__NSID__">
                                        <object id=rdoREP_TYP classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:14;width:90;">
                                            <param name=AutoMargin  value="true">
                                            <param name=Cols        value="2">
                                            <param name=Format      value="U^반차,T^전일">
                                        </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:none">
			<table width="430" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- 결재선 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:440px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
			            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
			            					<C> id='DPT_NM'	width=80	name='부서'		align=center	show=false</C>
											<C> id='JOB_NM'	width=60	name='직위'		align=center	</C>
											<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
											<C> id='ENO_NM'	width=70	name='성명'		align=center	</C>
											<C> id='APP_YN'	width=160	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&APP_YMD} </C>
											<C> id='REMARK1'	width=60	name='사유'	align=center 	Color='Blue'	</C>
											<C> id='REMARK'	width=60	name='사유'		align=center	show=false</C>
										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
			                </tr>
						  	<tr>
								<td align="right">
				                        <img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
				                        <img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >
								</td>
			                </tr>
			            </table>
			        	<!-- 결재선 정보 테이블 끝 -->
 					</td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				<!--	<td  align="right" valign="top">
				         <img src="/images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)" >
				         <img src="/images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)" >
					</td> -->
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
						<object	id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				value="dsT_DI_HOLIDAYWORK">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=30			name='NO'								align=center	value={String(Currow)}	</C>
								<C> id='JOB_NM'			width=50			name='직위'								align=center													</C>
								<C> id='ENO_NO'			width=65			name='사번'								align=center													</C>
								<C> id='ENO_NM'			width=65			name='성명'								align=center													</C>
								<C> id='HOL_YMD'		width=80			name='근무일자'							align=center													</C>
							    <G>name=사전신청내역	HeadBgColor=#F7DCBB
  								  <C> id='STR_TIME'		width=65			name='시작시간'							align=center													</C>
                                  <C> id='END_TIME'		width=65			name='종료시간'						    align=center													</C>
                                  <C> id='TOT_TIME'		width=65			name='총근무시간'						align=center													</C>
				                </G>
				                <G>name=휴일근무결과 	HeadBgColor=#F7DCBB
			 	                  <C> id='STR_AFT_TIME'	width=65	    	name='시작시간'							align=center													</C>
                                  <C> id='END_AFT_TIME'	width=65		    name='종료시간'						    align=center													</C>
                                  <C> id='TOT_AFT_TIME'	width=65		    name='총근무시간'						align=center													</C>
				                  <C> id='REP_APP'		width=80			name='수당구분'						    align=center	value={Decode(REP_APP,'1','휴일근무수당','2','대체휴가','3','미근무',' ')}	</C>
                                </G>
                                <G>name=대체휴가	 	HeadBgColor=#F7DCBB
   								  <C> id='REP_YMD'		width=80			name='대체휴가일'						align=center													</C>
				                  <C> id='REP_TYP'		width=80			name='반차여부'						    align=center	value={Decode(REP_TYP,'U','반차','T','전일','')}	</C>
				                </G>
                                  <C> id='SIGN_TAG'     width=80 	        name='결재상태'        		            align=center    value={Decode(SIGN_TAG,'R','상신','N','부결','Y','결재완료','저장')}                  </C>
                                  <C> id='REMARK'       width=250           name='근무내용'                         align=left      Edit=none                  </C>

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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_DI_HOLIDAYWORK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_HOLIDAYWORK">
	<Param Name="BindInfo", Value='
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD				Ctrl=txtJOB_CD	   			Param=value		</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
        <C>Col=STR_AFT_HOUR         Ctrl=cmbSTR_AFT_HOUR        Param=value     </C>
        <C>Col=STR_AFT_MIN          Ctrl=cmbSTR_AFT_MIN         Param=value     </C>
        <C>Col=END_AFT_HOUR         Ctrl=cmbEND_AFT_HOUR        Param=value     </C>
        <C>Col=END_AFT_MIN          Ctrl=cmbEND_AFT_MIN         Param=value     </C>
		<C>Col=REP_APP				Ctrl=rdoREP_APP				Param=CodeValue </C>
		<C>Col=REP_TYP				Ctrl=rdoREP_TYP				Param=CodeValue </C>
		<C>Col=REP_YMD				Ctrl=txtREP_YMD    		 	Param=value		</C>
        <C>Col=REMARK               Ctrl=txtREMARK              Param=value </C>
    '>
</object>