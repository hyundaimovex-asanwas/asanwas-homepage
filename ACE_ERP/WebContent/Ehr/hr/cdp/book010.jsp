<!--
*****************************************************
* @source       : BOOK010.jsp
* @description : 도서구입신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/06/15      이동훈        최초작성
*----------------------------------------------------------------------
* 2016/06/01    |  정영식   | 소스이전                                              *
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>도서구입신청</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/result.js"></script>
<script language=javascript src="../../common/input.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >




        var param = window.dialogArguments;
		var chkValid  = 'T';
		var rq_seq = 0;
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//도서신청현황 정보 조회
            //var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
			var rqst_no = param.req_no;

			dsT_ED_BOOKMASTER.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR&REQ_NO="+rqst_no;
			dsT_ED_BOOKMASTER.reset();


			dsT_ED_BOOKDETAIL.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_02&REQ_NO="+rqst_no;
			dsT_ED_BOOKDETAIL.reset();

            //결재자 조회
            fnc_SearchApprover();


        }

        /**
         * 결재자 정보를 조회한다.
         */
        function fnc_SearchApprover() {

            var REQ_NO  = param.req_no;

            dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_APP&REQ_NO="+REQ_NO+"&GUN_GBN=Q";
            dsT_DI_APPROVAL.Reset();
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //신청번호 조회
            dsRQST_NO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SHR_03";
			dsRQST_NO.reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			chkValid = "T";

			fnc_Valid();  //유효성 검사 후 작업

            if(chkValid == "F"){
             //  alert("도서구입 신청작업은 취소되었습니다.");
              return;
            }

            //신청번호 생성
			fnc_SearchItem();

            var RQST_NO = dsRQST_NO.NameValue(1,"RQST_NO");

            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "RQST_REMARK") = document.getElementById("txtREMARK").value;

			trT_ED_BOOKMASTER.KeyValue = "tr01(I:dsT_ED_BOOKMASTER=dsT_ED_BOOKMASTER, I:dsT_ED_BOOKDETAIL=dsT_ED_BOOKDETAIL, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";

			trT_ED_BOOKMASTER.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD&S_MODE=SAV&REQ_NO="+RQST_NO;
			
			trT_ED_BOOKMASTER.post();


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

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			fnc_First();

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ED_BOOKMASTER.CountColumn == 0) {
                dsT_ED_BOOKMASTER.setDataHeader("ENO_NO:STRING:NOTNULL, ENO_NM:STRING:NOTNULL, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, RQST_NO:STRING, RQST_REMARK:STRING,  RQST_YMD:STRING");
            }
            
          
			// 행 추가
			dsT_ED_BOOKMASTER.AddRow();
			

            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "ENO_NO")  = gusrid;
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "ENO_NM")  = gusrnm;
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "DPT_CD")  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "DPT_NM")  = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "JOB_CD")  = dsVI_T_PERSON.NameValue(0,"JOB_CD");
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "JOB_NM")  = dsVI_T_PERSON.NameValue(0,"JOB_NM");
             
            dsT_ED_BOOKMASTER.NameValue(dsT_ED_BOOKMASTER.RowPosition, "RQST_YMD") = gcurdate;

			document.form1.txtREMARK.focus();

        }

        /******************
         * 08. 유효성 검사 *
         ******************/
        function fnc_Valid() {


			if (!dsT_ED_BOOKMASTER.IsUpdated ) {
                alert("dsT_ED_BOOKMASTER 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_ED_BOOKDETAIL.IsUpdated) {
                alert("도서 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}

			if (!dsT_DI_APPROVAL.IsUpdated ) {
                alert("결재선이 지정되지 않았습니다");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
			    chkValid = "F";
                return false;
			}




/*
            //해당년월이 없으면 추가못함.
            var HOL_YMD_SHR  = document.getElementById("txtHOL_YMD_SHR").value;      //휴일근무일자.
            var ENO_NO_SHR   = document.getElementById("txtENO_NO_SHR").value;       //조회용 사원번호
			var DIL_AUTHO    = ""


			if((DIL_AUTHO == "M") || (DIL_AUTHO == "A")){
			fnc_ChangeStateElement(true, "txtENO_NO");
			fnc_ChangeStateElement(true, "txtENO_NM");
			fnc_ChangeStateElement(true, "ImgEnoNo");

            }else{
				fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
				fnc_ChangeStateElement(false, "ImgDptCd");
				fnc_ChangeStateElement(false, "txtENO_NO");
				fnc_ChangeStateElement(false, "txtENO_NM");
				fnc_ChangeStateElement(false, "ImgEnoNo");
	            document.getElementById("txtENO_NO").value = gusrid;
	            document.getElementById("txtENO_NM").value = gusrnm;
	            document.getElementById("txtJOB_CD").value = dsVI_T_PERSON.NameValue(0,"JOB_CD");


				document.getElementById("approval_btn").style.display = "none";
			}
*/
        }

        /******************
         * 08. 추가 함수  *
         ******************/
		function fnc_Append(){

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ED_BOOKDETAIL.CountColumn == 0) {
                dsT_ED_BOOKDETAIL.setDataHeader("RQST_NO:STRING, RQST_SEQ:STRING, BOOK_NM:STRING, BOOK_PUL:STRING, BOOK_WRT:STRING, BOOK_QTY:STRING, BOOK_AMT:STRING, END_TAG:STRING, HOMEPAGE:STRING, BOOK_REMARK:STRING");
            }

			// 행 추가
            dsT_ED_BOOKDETAIL.AddRow();

			rq_seq = rq_seq + 1;

            dsT_ED_BOOKDETAIL.NameValue(dsT_ED_BOOKDETAIL.RowPosition, "RQST_NO")  = dsRQST_NO.NameValue(dsRQST_NO.RowPosition, "RQST_NO");
            dsT_ED_BOOKDETAIL.NameValue(dsT_ED_BOOKDETAIL.RowPosition, "RQST_SEQ") = rq_seq;

		}


        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_BOOKDETAIL.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			dsT_ED_BOOKDETAIL.DeleteRow(dsT_ED_BOOKDETAIL.RowPosition);


        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_First() {

			dsT_ED_BOOKMASTER.ClearData();
			dsT_ED_BOOKDETAIL.ClearData();
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("resultMessage").innerText = ' ';

			chkValid = "T";

        }

        function fnc_Clear() {

			dsT_ED_BOOKMASTER.ClearData();
			dsT_ED_BOOKDETAIL.ClearData();
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("resultMessage").innerText = ' ';

			chkValid = "T";

			fnc_OnLoadProcess();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_ED_BOOKMASTER.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}

			window.close();

        }


        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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

            fnc_ShowElement("imgSave");
            fnc_ShowElement("imgAppend");
            fnc_ShowElement("imgRemove");
            fnc_HiddenElement("imgReport");

			cfStyleGrid_New(form1.grdT_ED_BOOKDETAIL,15,"true","false")      // Grid Style 적용

        	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용

			form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
			
			
			//개인정보 불러오기 추가  ( 직위, 소속   때문에 사용함.)
            dsVI_T_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.a.idta030.cmd.IDTA030CMD&S_MODE=SHR_02&ENO_NO="+gusrid;
            dsVI_T_PERSON.reset();

			fnc_AddNew();


            //시작하자마자 폼 로드
            //fnc_SearchList();
            document.getElementById("resultMessage").innerText = '작업순서: 용도> (추가버튼) 아래 그리드에 도서신청 > 결재선지정 > 저장 > 상신 ';

	        dsT_DI_APPROVAL.SetDataHeader(

								"ENO_NO:STRING(10),"+			// 결재자사번
								"ENO_NM:STRING(10),"+			// 결재자명
								"DPT_CD:STRING(6),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"JOB_CD:STRING(10),"+			// 결재자직위
								"JOB_NM:STRING(10),"+			// 직위명
								"SEQ_NO:STRING(2),"+			// 결재선
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
								"PENO_NO:STRING(10),"+			// 상신자사번
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"REQ_NO:STRING(10),"+			//
								"APP_YN:STRING(10)"				// 결재여부

								);
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

            var DPT_CD =  dsVI_T_PERSON.NameValue(0,"DPT_CD");

			var EMP_NO =  gusrid;

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;

			RQST_YMD = RQST_YMD.replace("-","").replace("-","")

            //ds를 리턴받는다.
            dsT_DI_APPROVAL.DeleteAll();

            fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, DPT_CD, "1", "1", "", "", 10, "Q");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);

            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){

                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") =  dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") =  i;	//결재선(결재순서)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = RQST_YMD;
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = gusrid;	//상신자 사번
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "Q";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";

            }

            fnc_AutoApproval(dsT_DI_APPROVAL.countrow);
        }




		function fnc_AutoApproval(appNumParam){

			var appNum = appNumParam + 1;
			var appNum_1YN = "N";
			var appNum_2YN = "N";
			var appNum_3YN = "N";
			var obj    = new String;

            //출장 결재자정보 협조자 중복 검사)
			for(var i = 1; i<=appNumParam; i++) {

				if (dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2030007") {
	            		appNum_1YN = "Y";
	            } else if (dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2070019") {
	            		appNum_2YN = "Y";
				//} else if(dsT_DI_APPROVAL.NameValue(i,"ENO_NO") == "2110003") {
	            //		appNum_3YN = "Y";
	            }
	         }
            //도서구입 결재자정보 관리 데이터셋에 상신자의 기본정보 Setting(품의번호,상신자정보등)

			for(var i = appNum; i<=appNum+1; i++) {

				var r;

				if (i == appNum) {
	            		if (appNum_1YN == "Y" )  continue;
	            		obj = fnc_GetCommonEnoObj_DH("2030007");
						r = "9";
	            } else if (i == appNum + 1) {
	            		if (appNum_2YN == "Y" )  continue;
	            		obj = fnc_GetCommonEnoObj_DH("2070019");
						r = "8";
	            //} else if (i == appNum + 2) {
	            //		if (appNum_3YN == "Y" )  continue;
	            //		obj = fnc_GetCommonEnoObj_DH("2110003");
				//		r = "7";
	            }

	           	dsT_DI_APPROVAL.AddRow();
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"SEQ_NO") = "9"+r;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_YMD") = "99991231";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"GUN_GBN") = "Q";
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_CD") = obj.dpt_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"DPT_NM") = obj.dpt_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_CD") = obj.job_cd;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"JOB_NM") = obj.job_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NO") = obj.eno_no;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"ENO_NM") = obj.eno_nm;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"PENO_NO") = gusrid;
	            dsT_DI_APPROVAL.NameValue(dsT_DI_APPROVAL.RowPosition,"REQ_NO") = document.getElementById("txtRQST_YMD").value;

			}

		}




        /**
         * 상신처리
         */
        function fnc_Conduct() {


            if(dsT_ED_BOOKMASTER.CountRow < 1){
              alert("상신가능한 도서구입신청내역이 없습니다");
              return;
            }

            if(dsT_ED_BOOKDETAIL.CountRow < 1){
              alert("상신가능한 도서구입신청내역이 없습니다");
              return;
            }

            //1.상신처리 조건함
            if(dsT_DI_APPROVAL.CountRow < 1) {
                alert("결재선을 지정해주세요.");
                return;
            }

            //2.상신처리

            var RQST_YMD = document.getElementById("txtRQST_YMD").value;
			var GUN_YMD = RQST_YMD.replace("-","").replace("-","")
            //var DPT_CD  = document.getElementById("hidDPT_CD_ORI").value;
			var DPT_CD  = dsVI_T_PERSON.NameValue(0,"DPT_CD");
			var REQ_NO  = dsRQST_NO.NameValue(1,"RQST_NO");

			trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cdp.a.book010.cmd.BOOK010CMD"
                                      + "&S_MODE=UPT_APP"
                                      + "&APP_YN="  +"R"
                                      + "&GUN_YMD=" +GUN_YMD
                                      + "&GUN_GBN=" +"Q"
                                      + "&GUN_DPT=" +DPT_CD
                                      + "&REQ_NO="	+REQ_NO;

			trT_DI_APPROVAL.post();

        }



        //입력 element
        var elementList = new Array( 	"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"cmbSTR_HOL_HOUR"
                                        ,"cmbSTR_HOL_MIN"
                                        ,"cmbEND_HOL_HOUR"
                                        ,"cmbEND_HOL_MIN"
                                        ,"txtREMARK" );

        //예외 항목
        var exceptionList = new Array(  "txtENO_NO"
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
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsRQST_NO                           |
    | 3. Table List :             					|
    +----------------------------------------------->
    <Object ID="dsRQST_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKMASTER                   |
    | 3. Table List : T_ED_BOOKMASTER               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ED_BOOKDETAIL                   |
    | 3. Table List : T_ED_BOOKDETAIL               |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOOKDETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_HOLIDAY                      |
    | 3. Table List : T_DI_HOLIDAY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet(주소)              |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)      |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)        |
    +------------------------------------------------------>
	 <Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	  <Param Name="Syncload"     Value="True">
	  <Param Name="UseChangeInfo"   Value="True">
	  <Param Name="ViewDeletedRow"  Value="False">
	 </Object>
    

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_HOLIDAYWORK)	|
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK)	        |
    +--------------------------------------------------->
    <Object ID ="trT_ED_BOOKMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ED_BOOKDETAIL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			fnc_HiddenElement("imgReport");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			fnc_ShowElement("imgReport");
        }
        var APP_YN  = dsT_DI_HOLIDAYWORK.NameString(1, "END_TAG");  //결재자 결재 유무 '':저장, 'R':상신, 'Y':결재, 'N':부결

            if(APP_YN == "" || APP_YN == "N") {
                fnc_ShowElement("imgSelectapproval");
                fnc_ShowElement("imgReport");
                fnc_ShowElement("imgSave");
                fnc_ShowElement("imgAppend");
                fnc_ShowElement("imgRemove");

			}else if(APP_YN == "R" || APP_YN == "Y") { // 상신했을 경우 저장버튼 안보이게.. 그 상태에서 결재 후 시간바꿔 저장할수있다.
			        fnc_HiddenElement("imgSave");
		            fnc_HiddenElement("imgAppend");
                    fnc_HiddenElement("imgRemove");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
	                document.getElementById("resultMessage").innerText = "* 상신이 완료되었습니다. 결재중이므로 작업은 불가합니다. *. ";
                    }
    </Script>

    <!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    if (iCount >= 1)    {
			        fnc_HiddenElement("imgSave");
		            fnc_HiddenElement("imgAppend");
                    fnc_HiddenElement("imgRemove");
    	            fnc_HiddenElement("imgSelectapproval");
	                fnc_HiddenElement("imgReport");
	                fnc_DisableElementAll(elementList);
	                document.getElementById("resultMessage").innerText =  '** 상신이 완료되었습니다. 결재중이므로 작업은 불가합니다. **';

             for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){
				if(dsT_DI_APPROVAL.NameValue(i,"APP_YN") == "N"){
	                fnc_ShowElement("imgSelectapproval");
    	            fnc_ShowElement("imgReport");
        	        fnc_ShowElement("imgSave");
            	    fnc_ShowElement("imgAppend");
                	fnc_ShowElement("imgRemove");
                	document.getElementById("resultMessage").innerText =  '** 부결상태! 작업이 가능합니다. **';
					break;
					}
            }
     }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOOKMASTER Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_ED_BOOKDETAIL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ED_BOOKMASTER event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		alert("저장되었습니다\n상신을 위해서는 상신버튼을 눌러주세요");

        fnc_ShowElement("imgReport");

    </script>

    <script for=trT_DI_APPROVAL event="OnSuccess()">

		alert("상신되었습니다");
        //document.getElementById("resultMessage").innerText = "상신처리되었습니다";
        //fnc_HiddenElement("imgReport");
		fnc_OnLoadProcess();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ED_BOOKMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------------------+
    | 그리드 조회시 화면설정 변경 및 결재선 조회|
    +------------------------------------------->
	<script language="javascript"  for=dsT_DI_HOLIDAYWORK  event=OnRowPosChanged(row)>

        var today   = fnc_covNumber(getToday());

        if(row > 0) {

                //저장상태이거나 부결일때 수정이 가능함

          if(dsT_DI_APPROVAL.NameString(1, "APP_YN") == ""
          		|| dsT_DI_APPROVAL.NameString(2, "APP_YN") == "N"	|| dsT_DI_APPROVAL.NameString(1, "APP_YN") == "N") {
                    //신규일 경우
                    if(dsT_DI_HOLIDAYWORK.RowStatus(row) == "1") {  //신규

                        fnc_EnableElementAll(elementList);

                    } else {
                        fnc_EnableElementAll(elementList, exceptionList);   //신규이외
                    }
                }
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

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type=hidden id="txtENO_NO_SHR" size="10">
<input type=hidden id="txtENO_NM_SHR" size="10">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <img src="../../images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


<table border="0">
	<tr>
		<td valign="top">
			<!-- 조건 입력 테이블 시작 -->
			<table width="450" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td class="paddingTop8">
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="80"></col>
                                <col width="100"></col>
                            </colgroup>
 							<tr>
	                            <td align="center" class="blueBold">신청자</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtENO_NO" name="txtENO_NO" size="8"  maxlength= "8"  class="input_ReadOnly"  readonly>
			                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14" class="input_ReadOnly"  readonly>
                        		</td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">소속</td>
                                <td class="padding2423" >
									<input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly>
                                </td>
                                <td align="center" class="blueBold">직위</td>
                                <td class="padding2423" >
									<input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly>
                                </td>
                            </tr>
							<tr>
								<td align="center" class="blueBold">신청일</td>
                                <td class="padding2423" colspan ="3">
			                        <input id="txtRQST_YMD" name="txtRQST_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '신청일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();setStrEndDate(this.value);">
			                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRQST_YMD','','../../images/button/btn_HelpOver.gif',1)">
			                        <img src="../../images/button/btn_HelpOn.gif" id="ImgRQST_YMD" name="ImgRQST_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRQST_YMD','','36','227');"></a> -->
                                </td>
							</tr>
                            <tr>
                                <td align="center" class="blueBold">용도</td>
                                <td class="padding2423" colspan ="3">
                                    <input id="txtREMARK" style="width=100%" onKeyUp="fc_chk_byte(this,50)">
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
		</td>
		<td valign="top">
		<div  id="approval_btn" style="DISPLAY:">
			<table width="530" border="0">
				<tr>
			        <td class="paddingTop8">

			        	<!-- 결재선 정보 테이블 시작 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<comment id="__NSID__">
									<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:545px;height:110px;">
										<param name="DataID"				value="dsT_DI_APPROVAL">
										<param name="Format"				value="
											<C> id='SEQ_NM'	width=80		name='구분'			align=center	Value={IF(SEQ_NO = '9','협조', '결재')}</C>
											<C> id='JOB_NM'	width=80		name='직위'			align=center	</C>
											<C> id='ENO_NM'	width=80		name='성명'			align=center	</C>
											<C> id='APP_YN'	width=160	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')&' '&APP_YMD} </C>
											<C> id='REMARK1'width=160	name='사유'			align=center 	Color='Blue'	</C>
										">
										<param name="wmode" value="transparent" >
									</object>
									</comment><script> __ShowEmbedObject(__NSID__); </script>

				                        <img src="../../images/button/btn_SelectapprovalOn.gif"  name="imgSelectapproval"    width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)" >
				                        <img src="../../images/button/btn_ReportOn.gif"          name="imgReport"            width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)" >
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
		<td align="right">  <!-- 추가 삭제 버튼 -->
			<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
			<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_ED_BOOKDETAIL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:230px;">
							<param name="DataID"				value="dsT_ED_BOOKDETAIL">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=30				name='NO'				align=center	value={String(Currow)}	</C>
								<C> id='BOOK_NM'			width=200			name='도서명'			align=center	</C>
								<C> id='BOOK_PUL'			width=120			name='출판사'			align=center	</C>
								<C> id='BOOK_WRT'		width=100			name='저자'				align=center	</C>
								<C> id='BOOK_QTY'			width=70				name='수량'				align=center	edit=numeric editlimit=3</C>
								<C> id='BOOK_AMT'			width=80				name='가격'				align=center	edit=numeric editlimit=6</C>
								<C> id='HOMEPAGE'			width=130			name='홈페이지'		align=center	</C>
                                <C> id='BOOK_REMARK'    width=150            name='비고'         		align=left      </C>
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
<object id="bndT_ED_BOOKMASTER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKMASTER">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO   		 	Ctrl=txtENO_NO    		 	Param=value		</C>
		<C>Col=ENO_NM				Ctrl=txtENO_NM     		 	Param=value		</C>
		<C>Col=DPT_CD     		 	Ctrl=txtDPT_CD     			Param=value 	</C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM 		     	Param=value 	</C>
		<C>Col=JOB_CD     		 	Ctrl=txtJOB_CD     			Param=value 	</C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM	   			Param=value		</C>
		<C>Col=RQST_YMD				Ctrl=txtRQST_YMD	   		Param=value		</C>
		<C>Col=RQST_REMARK			Ctrl=txtREMARK	   			Param=value		</C>
    '>
</object>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<object id="bndT_ED_BOOKDETAIL" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ED_BOOKDETAIL">
	<Param Name="BindInfo", Value='
        <C>Col=RQST_NO         		Ctrl=txtRQST_NO        		Param=value     </C>
		<C>Col=BOOK_NM   		 	Ctrl=txtBOOK_NM    		 	Param=value		</C>
		<C>Col=BOOK_PUL				Ctrl=txtBOOK_PUL     		Param=value		</C>
		<C>Col=BOOK_WRT     		Ctrl=txtBOOK_WRT     		Param=value 	</C>
		<C>Col=BOOK_QTY      		Ctrl=txtBOOK_QTY 		    Param=value 	</C>
		<C>Col=BOOK_AMT				Ctrl=txtBOOK_AMT	   		Param=value		</C>
		<C>Col=END_TAG				Ctrl=txtEND_TAG	   			Param=value		</C>
		<C>Col=HOMEPAGE				Ctrl=txtHOMEPAGE	   		Param=value		</C>
		<C>Col=BOOK_REMARK			Ctrl=txtBOOK_REMARK	   		Param=value		</C>
    '>
</object>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
