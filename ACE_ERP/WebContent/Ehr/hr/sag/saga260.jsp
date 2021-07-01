<!--
    ************************************************************************************
    * @source         : saga260.jsp 				                                   *
    * @description   : 직원사내대출 PAGE.                                              *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+                                             											 *
    * 2011/09/06  |  이동훈   | 직원사내대출                                           *
    ************************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>직원사내대출</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

        var savObj = new Array();
        
        var today = gcurdate;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_Loan_Detail.ClearData();

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 상환기준월
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 상환기준월

			//기준일자가 없으면 조회 못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("상환기준월 입력하세요.");
					document.getElementById("PIS_YYMM_SHR").focus();
					return false;
				}
			}

            //데이터셋 전송
            dsT_Loan_Master.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR
																								            +"&ENO_NO_SHR="+ENO_NO_SHR;

            dsT_Loan_Master.Reset();

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

		if (dsT_Loan_Master.countrow<1){

			alert ("저장할 정보가 없습니다.");

		}else {

		//	if(ln_Valchk()){

				if (confirm("저장하시겠습니까?")) {

					dsT_Loan_Temp.ClearData();

					var row = dsT_Loan_Temp.rowposition;

					var THeader = "ENO_NO:STRING(7),APPDT:STRING(10),APLDT:STRING(10),APPAMT:DECIMAL(9),REASON:STRING(50)";

					dsT_Loan_Temp.SetDataHeader(THeader);

					for(i=1;i<=dsT_Loan_Master.countrow;i++) {

						if (dsT_Loan_Master.SysStatus(i)==1||dsT_Loan_Master.SysStatus(i)==2||dsT_Loan_Master.SysStatus(i)==3){

							dsT_Loan_Temp.addrow();
							dsT_Loan_Temp.namevalue(1,"ENO_NO") = dsT_Loan_Master.namevalue(i,"ENO_NO");
							dsT_Loan_Temp.namevalue(1,"APPDT") 	= dsT_Loan_Master.namevalue(i,"APPDT");
							dsT_Loan_Temp.namevalue(1,"APLDT") 	= dsT_Loan_Master.namevalue(i,"APLDT");
							dsT_Loan_Temp.namevalue(1,"APPAMT") = dsT_Loan_Master.namevalue(i,"APPAMT");
							dsT_Loan_Temp.namevalue(1,"REASON") = dsT_Loan_Master.namevalue(i,"REASON");

							//트랜잭션 전송
							trT_Loan_Master.KeyValue = "SVL(I:SAV=dsT_Loan_Temp)";
							trT_Loan_Master.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SAV";
							trT_Loan_Master.Post();

							//fnc_SearchList();

						}

					}

				}

			}

        }

        /**************************
         * 03. 저장 함수 - Detail  *
         **************************/
		function fnc_Save2(){

			if (dsT_Loan_Detail.countrow<1){

				alert ("저장할 정보가 없습니다.");

			}else {

				var str1 = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");

				if (confirm("저장하시겠습니까?")) {

					//트랜잭션 전송
					trT_Loan_Detail.KeyValue = "SVL(I:SAV=dsT_Loan_Detail)";
					trT_Loan_Detail.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SAV_01";
					trT_Loan_Detail.Post();

				}
			}
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

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 적용일자

			//적용일자가 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("적용일자를 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//적용일자가 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("적용일자가 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}


			dsT_RP_REPORT.ClearAll();
			ln_SetDataHeader();
			dsT_RP_REPORT.Addrow();
			dsT_RP_REPORT.namevalue(1,"MM") = " 사내 대출 대장 ( "+PIS_YYMM_SHR+" 월 )" ;
			dsT_RP_REPORT.namevalue(1,"PRINTDT") = today;
			dsT_RP_REPORT.namevalue(1,"CNT") = "합계" ;

			dsT_RP_REPORT2.ClearData();
            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SHR_PRINT&PIS_YYMM_SHR="+PIS_YYMM_SHR;
            dsT_RP_REPORT2.Reset();

			gcrp_print.preview();

        }


		/*******************************************************************************
		  Description : 데이타셋 헤드
		******************************************************************************/
		function ln_SetDataHeader(){
					if(dsT_RP_REPORT.countrow<1){
						var s_temp = "MM:STRING,PRINTDT:STRING,CNT:STRING";
						dsT_RP_REPORT.SetDataHeader(s_temp);
					}
		 }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_Loan_Master.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_Loan_Master.GridToExcel("직원대출", '', 225);

        }
        
        
        /***********************
         * 06-1. 엑셀 저장 함수2    *
         ***********************/
        function fnc_ToExcel2() {

            if (dsT_Loan_Detail.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_Loan_Detail.GridToExcel("직원대출", '', 225);

        }
        

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {


			if (dsT_Loan_Master.CountRow < 1) {
                alert("조회를 먼저 하셔야합니다.");
                return;
            }

            dsT_Loan_Detail.ClearData();
            dsT_Loan_Master.AddRow();

            enableInput();	// 입력필드 활성화

            document.getElementById("txtENO_NO").value = "";
			document.getElementById("txtENO_NM").value = "";
            document.getElementById("txtAPP_YMD").value = "";
            document.getElementById("txtAPP_AMT").value = "";
			document.getElementById("txtAPL_YMD").value = "";
            document.getElementById("cmbREASON").value = "";
			document.getElementById("txtENO_NO").focus();



        }

        /******************
         * 08. 추가 함수  *
         ******************/
			function fnc_Add(){



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

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_Loan_Master.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }
	        
        	window.close();

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

        	if (!dsT_CP_PAYTABLE.isUpdated && dsT_CP_PAYTABLE.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
			cfStyleGrid_New(form1.grdT_Loan_Master,15,"true","true");
			cfStyleGrid_New(form1.grdT_Loan_Detail,15,"true","false");

            document.getElementById('txtPIS_YYMM_SHR').value = today.substring(0,7);

			var txtPIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");

			disableInput();//입력필드 비활성화

            dsT_Loan_Master.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SHR&PIS_YYMM_SHR="+txtPIS_YYMM_SHR;
            dsT_Loan_Master.Reset();


        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17.
         ****************************/
         function fnc_FileUpload() {



        }

        /*****************************
         * 17.
         ****************************/
		function fnc_proc() {



		}



		/********************************************************************
         * 18.
         ********************************************************************/
        function fnc_AccountPopup() {




        }
        /********************************************************************
         * 19.
         ********************************************************************/
        function fnc_PrjPopup() {




        }
        /********************************************************************
         * 20.
         ********************************************************************/
        function fnc_VendorPopup() {




        }
        /********************************************************************
         * 21.
         ********************************************************************/
        function fnc_CostDeptPopup() {




        }
        /*************************
         * 그리드 변경 처리      *
         ************************/
		function fnc_ChangeGrid() {


		}

		/******************************************************************************
			Description : 대출 상환 보류
		******************************************************************************/
		function fnc_Delay() {

			var row = 1;

			var name;

			var THeader = "ENO_NO:STRING(7)";

			dsT_Loan_Check.SetDataHeader(THeader);

            //리스트 전체에서 체크된 녀석들만 정보를 넣기
            for(i=1; i<=dsT_Loan_Master.countrow; i++){

                if( dsT_Loan_Master.NameValue(i, "CHK") == "T") {

					dsT_Loan_Check.addrow();

                    dsT_Loan_Check.NameValue(row, "ENO_NO") =  dsT_Loan_Master.NameValue(i, "ENO_NO");

                    row = row + 1;

                if( name == undefined)

                    name = dsT_Loan_Master.NameValue(i, "ENO_NM");

                else
                	name = name + ',' + dsT_Loan_Master.NameValue(i, "ENO_NM");

				}

			}


			if (confirm(name + "님의 상환을 보류하시겠습니까?")) {


					dsT_Loan_Temp.ClearData();

					var row = dsT_Loan_Master.rowposition;

					var THeader = "ENO_NO:STRING(7),ENO_NM:STRING(10),APPDT:STRING(10),APLDT:STRING(10),APPAMT:DECIMAL(9)";

					dsT_Loan_Temp.SetDataHeader(THeader);

					dsT_Loan_Temp.addrow();
					dsT_Loan_Temp.namevalue(1,"ENO_NO") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");
					dsT_Loan_Temp.namevalue(1,"ENO_NM") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NM");
					dsT_Loan_Temp.namevalue(1,"APPDT") 	= dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPDT");
					dsT_Loan_Temp.namevalue(1,"APLDT") 	= document.getElementById("txtPIS_YYMM_SHR").value;
					dsT_Loan_Temp.namevalue(1,"APPAMT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT");

			window.showModalDialog("../../../Ehr/hr/sag/saga261.jsp", dsT_Loan_Temp, "dialogWidth:600px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            //modal close후 재조회
            fnc_SearchList();

			}
		}



		/******************************************************************************
		Description : 실행
		******************************************************************************/
		function fnc_Run(){

		var THeader = "ENO_NO:STRING(7),APPDT:STRING(10),APLDT:STRING(10),APPAMT:DECIMAL(9),"
		+ "APPCNT:DECIMAL(9),APJAMT:DECIMAL(9),APLRAT:DECIMAL(9),APLAMT:DECIMAL(9),AMT_1:DECIMAL(9),REASON:STRING(30)";
		dsT_Loan_Detail.SetDataHeader(THeader);

		for(j=1;j<=60;j++) {

		dsT_Loan_Detail.addrow();

		if (j!=60) {
		dsT_Loan_Detail.namevalue(j,"ENO_NO")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");		//사번
		dsT_Loan_Detail.namevalue(j,"APPDT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPDT");			//대출일자
		dsT_Loan_Detail.namevalue(j,"APPAMT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT");		//대출금액
		dsT_Loan_Detail.namevalue(j,"REASON") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"REASON");		//대출금액

		dsT_Loan_Detail.namevalue(j,"APPCNT") = j;                                    //횟수
		if (j==1){
		dsT_Loan_Detail.namevalue(j,"APLDT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APLDT").replace("-", "").replace("-", "");
		}else{
		dsT_Loan_Detail.namevalue(j,"APLDT") = ln_APLDT(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));//상환일자
		}

		dsT_Loan_Detail.namevalue(j,"APLAMT") =  Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/60));	  //상환원금

		if (j==1){
		dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(j,dsT_Loan_Detail.namevalue(j,"APPAMT"),0);     //대출잔액

		}else{
		dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(j,dsT_Loan_Detail.namevalue(j-1,"APJAMT"),dsT_Loan_Detail.namevalue(j-1,"APLAMT") );
		}
		dsT_Loan_Detail.namevalue(j,"APLDT") = ln_APLDT(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));	  //상환일자

		dsT_Loan_Detail.namevalue(j,"APLRAT") = ln_Aplrat(dsT_Loan_Detail.namevalue(j,"APJAMT"));	  //상환이자 APJAMT

		var amt_01 = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/60));//상환원금
		var amt_02 = ln_Aplrat(dsT_Loan_Detail.namevalue(j,"APJAMT"));

		dsT_Loan_Detail.namevalue(j,"AMT_1")  = amt_01+amt_02;	//상환액

		}else{

		dsT_Loan_Detail.namevalue(j,"ENO_NO") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"ENO_NO");		//사번
		dsT_Loan_Detail.namevalue(j,"APPDT")  = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPDT");		//대출일자
		dsT_Loan_Detail.namevalue(j,"APPAMT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT");	//대출금액
		dsT_Loan_Detail.namevalue(j,"REASON") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"REASON");		//대출금액
		dsT_Loan_Detail.namevalue(j,"APPCNT") = j;                                    //횟수

		if (j==1){dsT_Loan_Detail.namevalue(j,"APLDT") = dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APLDT")
		}else{dsT_Loan_Detail.namevalue(j,"APLDT") = ln_APLDT(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));} //상환일자

		var appamt_eja = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/60));
		var appamt_won = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")));
		var appamt_jan = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/60))*60;

		dsT_Loan_Detail.namevalue(j,"APLAMT") =  appamt_eja+(appamt_won-appamt_jan);	  //상환원금

		if (j==1){dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(j,dsT_Loan_Detail.namevalue(j,"APPAMT"),0);     //대출잔액
		}else{
		dsT_Loan_Detail.namevalue(j,"APJAMT") = ln_Apjamt(j,dsT_Loan_Detail.namevalue(j-1,"APJAMT"),dsT_Loan_Detail.namevalue(j-1,"APLAMT") );
		}

		dsT_Loan_Detail.namevalue(j,"APLDT") = ln_APLDT(j,dsT_Loan_Detail.namevalue(j-1,"APLDT"));	  //상환일자
		dsT_Loan_Detail.namevalue(j,"APLRAT") = ln_Aplrat(dsT_Loan_Detail.namevalue(j,"APJAMT"));				//상환이자

		var amt_01 = Math.floor((dsT_Loan_Master.namevalue(dsT_Loan_Master.rowposition,"APPAMT")/60));//상환원금
		var amt_02 = ln_Aplrat(dsT_Loan_Detail.namevalue(j,"APJAMT"));
		dsT_Loan_Detail.namevalue(j,"AMT_1")  = amt_01+amt_02;	//상환액
		}

		}//FOR
		}



		/******************************************************************************
			Description : 대출잔액 ,
			              cnt - 횟수, apjamt - 대출잔액, aplamt - 상환원금
		******************************************************************************/
		function ln_Apjamt(cnt,apjamt,aplamt) {

			if(cnt==1){
				return apjamt
			}else{
		    apjamt = apjamt - aplamt
				return apjamt;
			}
		}

		/******************************************************************************
			Description : 상환일자
			              cnt - 횟수, aplday - 상환일자
		******************************************************************************/
		function ln_APLDT(cnt,aplday) {

		   var yyyy="";

		   var mm="";

		   var dd="";

			yyyy = aplday.substr(0,4);

			mm=aplday.substr(4,2);

			dd = aplday.substr(6,2);



			if(cnt==1){

				return aplday;

			}else{

				if (mm=="12"){

						yyyy = Number(yyyy) + 1;

						mm="01";

		        return yyyy+mm+dd;

				}else{

		        mm = Number(mm) + 1;



						if(mm=="10"||mm=="11"||mm=="12"){

		        		}else{

							mm="0"+mm;
						}

				    return yyyy + mm+ dd;

				}

			}

		}

		/******************************************************************************
			Description : 상환이자
			              apjamt-대출잔액
		******************************************************************************/
		function ln_Aplrat(apjamt) {
		var aplrat=0;

			if (apjamt<=20000000){
				return 	aplrat = Math.floor((apjamt*0.02)/12)
			}else{
				return aplrat = Math.floor(((20000000*0.02) + (apjamt-20000000)*0.03)/12);
			}

		}


		/***********************
		* 	사원조회용 팝업    *
		**********************/
		function fnc_EmplPop() {

		var obj = new String();

		obj.shr_kind = "SHR_02";
		obj.eno_nm = "";

		window.showModalDialog("../../common/popup/empl2.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

		document.getElementById("txtENO_NO").value = obj.eno_no;
		document.getElementById("txtENO_NM").value = obj.eno_nm;

        document.getElementById("txtDPT_NM").value = obj.dpt_nm;
        document.getElementById("txtJOB_NM").value = obj.job_nm;

		}
		/********************************************
         * 입력필드 사용 가능하게(Enable)          	*
         ********************************************/
  		function enableInput(){

			document.form1.txtENO_NO.readOnly = false;
			document.form1.txtENO_NO.className = "";

			document.form1.txtENO_NM.readOnly = false;
			document.form1.txtENO_NM.className = "";

			document.form1.txtAPP_YMD.readOnly = false;
			document.form1.txtAPP_YMD.className = "";

			document.form1.txtAPP_AMT.readOnly = false;
			document.form1.txtAPP_AMT.className = "";

			document.form1.txtAPL_YMD.readOnly = false;
			document.form1.txtAPL_YMD.className = "";

			document.form1.cmbREASON.readOnly = false;
			document.form1.cmbREASON.className = "";





  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)        *
         ********************************************/
  		function disableInput(){

			document.form1.txtENO_NO.readOnly = true;
			document.form1.txtENO_NO.className = "input_ReadOnly";

			document.form1.txtENO_NM.readOnly = true;
			document.form1.txtENO_NM.className = "input_ReadOnly";

			document.form1.txtAPP_YMD.readOnly = true;
			document.form1.txtAPP_YMD.className = "input_ReadOnly";

			document.form1.txtAPP_AMT.readOnly = true;
			document.form1.txtAPP_AMT.className = "input_ReadOnly";

			document.form1.txtAPL_YMD.readOnly = true;
			document.form1.txtAPL_YMD.className = "input_ReadOnly";

			document.form1.cmbREASON.readOnly = true;
			document.form1.cmbREASON.className = "input_ReadOnly";



  		}
  		/********************************************
         * 행 상하 이동         		*
         ********************************************/
  		function on_Move(a){



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
    | 2. 이름 : dsT_Loan_Master                     |
    | 3. Table List : T_AC_COLOAN                   |
    +----------------------------------------------->
    <Object ID="dsT_Loan_Master" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_Loan_Detail" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_Loan_Temp" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_Loan_Check" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!----------------------------------------------+
    | 1. 레포트용 DataSet                     		|
    | 2. 이름 : dsT_RP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
		<param name="SuppressColumns"   value="1:EXE">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
		<param name="SubsumExpr"		value="2:EXE">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_Loan_Master                     |
    | 3. Table List : T_AC_EMLOAN                   |
    +----------------------------------------------->
    <Object ID ="trT_Loan_Master" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <Object ID ="trT_Loan_Detail" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 조회용 Data Transacton                |
    | 2. 이름 : trT_CP_PAYTABLE                     |
    | 3. Table List : T_CP_PAYTABLE                 |
    +----------------------------------------------->
    <Object ID ="trT_Loan_Master_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!--------------------------+
    | grid에서 row를 클릭했을때      |
    +------ -------------------->
	<script for=grdT_Loan_Master event=OnClick(Row,Colid)>

		var overId = "ENO_NO";
		var overValue = dsT_Loan_Master.NameValue(Row,overId);

		try {
			dsT_Loan_Detail.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.a.saga260.cmd.SAGA260CMD&S_MODE=SHR_01&ENO_NO_SHR="+overValue;
			dsT_Loan_Detail.Reset();
		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_Loan_Master.UserStatus(i) = 1;
            }

            if(dsT_Loan_Master.NameValue(1, "MNG_NO") == ''){
            	enableInput();
            }

        }
    </Script>

    <Script For=dsT_Loan_Detail Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {

        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_Loan_Detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_Loan_Master Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[시작일자/종료일자/직위/사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("적용일자/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=dsT_Loan_Detail Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_Loan_Master event="OnSuccess()">
        alert("기본사항이 저장되었습니다. 세부사항 일괄생성하십시요");
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>



    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_Loan_Master event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_Loan_Detail event="OnSuccess()">
    	alert("세부사항 저장이 완료되었습니다");
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>



    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_Loan_Detail event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelay','','../../images/button/btn_DeferlOver.gif',1)"><img src="../../images/button/btn_DeferlOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delay()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
						<table width="1000" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="paddingTop8">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="center" class="blueTable">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<colgroup>
														<col width="100"></col>
														<col width="200"></col>
														<col width="100"></col>
														<col width=""></col>
													</colgroup>
													<tr>
													<td align="left" class="searchState">상환기준월</td>
													<td>
														<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
														<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)">
														<img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','150');"></a>
													</td>
													<td align="center" class="searchState">사원번호</td>
													<td>
														<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
														<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
														<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)">
														<img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
													</td>

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
</table>
<!-- power Search테이블 끝 -->

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


			<!-- 왼쪽 화면 시작-->
			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">
						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="500" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_Loan_Master" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:520px;">
						                            <param name="DataID"				value="dsT_Loan_Master">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"				value="Left">
						                            <param name="VIEWSUMMARY"			value=1>
						                            <param name="Format"						value="
                                						<FC> Name='선택'				ID=CHK       				HeadAlign=Center Width=30       align=center 	EditStyle='CheckBox'</FC>
														<FC> Name='순'				ID={CURROW}  			HeadAlign=Center Width=40   		align=center	SumBgColor=#C3D0DB	</FC>
														<FC> Name='사번'				ID=ENO_NO  				HeadAlign=Center Width=55		align=center	SumBgColor=#C3D0DB	</FC>
														<FC> Name='성명'				ID=ENO_NM 				HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB	</FC>
														<C> Name='소속'				ID=DPT_NM  				HeadAlign=Center Width=100  	align=center	SumBgColor=#C3D0DB	SumText='계' </C>
														<C> Name='직위'				ID=JOB_NM					HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB	</C>
														<C> Name='대출일'			ID=APPDT					HeadAlign=Center Width=70		align=center	SumBgColor=#C3D0DB	</C>
														<C> Name='대출금'   			ID=APPAMT  				HeadAlign=Center Width=70		align=RIGHT		SumBgColor=#C3D0DB	SumText=@sum</C>
														<C> Name='횟수'		  		ID=APPCNT  				HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB	</C>
														<C> Name='실제상환'		  	ID=APPCNT_ORI  			HeadAlign=Center Width=60		align=center	SumBgColor=#C3D0DB	</C>
														<C> Name='상환전잔액' 		ID=APJAMT  				HeadAlign=Center Width=80		align=RIGHT		SumBgColor=#C3D0DB	SumText=@sum</C>
														<C> Name='상환일'			ID=APLDT  					HeadAlign=Center Width=80		align=center	SumBgColor=#C3D0DB	</C>
														<C> Name='상환예정'			ID=APLAMT_ORI  			HeadAlign=Center Width=80		align=RIGHT		SumBgColor=#C3D0DB	SumText=@sum</C>
														<C> Name='상환금'			ID=APLAMT  				HeadAlign=Center Width=80		align=RIGHT		SumBgColor=#C3D0DB	SumText=@sum</C>
														<C> Name='이자'     			ID=APLRAT   				HeadAlign=Center Width=80		align=right   	SumBgColor=#C3D0DB	SumText=@sum</C>
														<C> Name='상환액'			ID=AMT_SUM  				HeadAlign=Center Width=100 		align=right		SumBgColor=#C3D0DB	SumText=@sum </C>
														<C> Name='상환후잔액'		ID={APJAMT-APLAMT}  	HeadAlign=Center Width=100 		align=right		SumBgColor=#C3D0DB	SumText=@sum </C>
														<C> Name='대출사유'			ID=REASON  				HeadAlign=Center Width=100 		align=right		SumBgColor=#C3D0DB	</C>
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


			<!-- 왼쪽 화면 끝-->
		</td>
		<td width=5></td>
		<td>
			<!-- 오른쪽 화면 시작-->
			<table width="495" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td>
						<!-- 조건 입력 테이블 시작 -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="495" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
										<colgroup>
											<col width="90"></col>
											<col width=""></col>

										</colgroup>
										<tr>
											<td align="center" class="blueBold">사번</td>
											<td class="padding2423">
												<input id="txtENO_NO" name="txtENO_NO" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO','txtENO_NM');fnc_SearchList();" style="ime-mode:disabled">
												<input id="txtENO_NM" name="txtENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO');fnc_SearchList();">

						                        <input type="hidden" id="txtDPT_NM" name="txtDPT_NM">
						                        <input type="hidden" id="txtJOB_NM" name="txtJOB_NM">

												<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){return;} fnc_EmplPop();""></a>
											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">대출일</td>
											<td class="padding2423">
												<input id="txtAPP_YMD" style="width:30%;padding-left:6" maxlength="10"  onkeypress="cfCheckNumber();" style="ime-mode:disabled">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgAPP_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtAPP_YMD','','500','200');"></a>
											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">대출금</td>
											<td class="padding2423">
												<comment id="__NSID__">
												<object id="txtAPP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
												<param name=Alignment				value=2>
												<param name=Border					value=true>
												<param name=ClipMode				value=true>
												<param name=DisabledBackColor		value="#EEEEEE">
												<param name=Enable					value=true>
												<param name=IsComma					value=true>
												<param name=Language				value=0>
												<param name=MaxLength				value=9>
												<param name=Numeric					value=true>
												<param name=ShowLiteral				value="false">
												<param name=Visible					value="true">
												<param name=SelectAll				value="true">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>
											</td>
										</tr>
										<tr>
											<td align="center" class="blueBold">상환일</td>
											<td class="padding2423">
												<input id="txtAPL_YMD" style="width:30%;padding-left:6" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
												<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPL_YMD','','../../images/button/btn_HelpOver.gif',1)">
												<img src="../../images/button/btn_HelpOn.gif" name="imgAPL_YMD" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtAPL_YMD','','500','200');"></a>
											</td>
										</tr>

										<tr>
											<td align="center" class="blueBold">대출사유</td>
											<td class="padding2423">
												<input id="cmbREASON" style="width:30%;padding-left:6" maxlength="20"  >
									            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
											</td>
										</tr>

									</table>
								</td>
							</tr>
						</table>
						<!-- 조건 입력 테이블 끝 -->

						<!-- 버튼 테이블 시작 -->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="paddingTop8">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										<td  align="right" style="padding-top:3px;position:relative;left:-4px;top:1px;"><nobr>&nbsp;
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
            								<img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save2()"></a>
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">
            								<img src="../../images/button/BatchCreateOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Run()"></a>
            								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> 
            								<img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel2()"></a>
										</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- 조회 상태 테이블 끝 -->

						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="495" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <comment id="__NSID__">
						                        <object id="grdT_Loan_Detail" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:495px;height:360px;">
						                            <param name="DataID"				value="dsT_Loan_Detail">
						                            <param name="EdiTABLE"				value="false">
						                            <param name="DragDropEnable"		value="true">
						                            <param name="SortView"				value="Left">
						                            <param name="VIEWSUMMARY"			value=1>
						                            <param name="Format"				value="
														<C> Name='순'			ID={CURROW} 	HeadAlign=Center Width=30  		align=center	SumBgColor=#C3D0DB 	</C>
														<C> Name='대출잔액'		ID=APJAMT 		HeadAlign=Center Width=70	 	align=right		SumBgColor=#C3D0DB SumText='계'	</C>
														<C> Name='상환일자'		ID=APLDT 		HeadAlign=Center Width=80	 	align=center 	SumBgColor=#C3D0DB SumText=''   </C>
														<C> Name='상환원금'		ID=APLAMT 		HeadAlign=Center Width=80	 	align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='상환이자'		ID=APLRAT		HeadAlign=Center Width=80  		align=right		SumBgColor=#C3D0DB SumText=@sum	</C>
														<C> Name='상환액'		ID=AMT_1 		HeadAlign=Center Width=85		align=right 	SumBgColor=#C3D0DB SumText=@sum	</C>
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

					</td>
				</tr>
			</table>
			<!-- 오른쪽 화면 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="dsT_RP_REPORT">
	<param name="DetailDataID"	    		value="dsT_RP_REPORT2">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" 					VALUE="


<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=391 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=794 ,top=5 ,right=2199 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='순' ,left=32 ,top=294 ,right=93 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출사유' ,left=93 ,top=294 ,right=291 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=288 ,top=294 ,right=487 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=484 ,top=294 ,right=577 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사번' ,left=585 ,top=294 ,right=730 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='만기일' ,left=1251 ,top=294 ,right=1450 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출금' ,left=1072 ,top=294 ,right=1270 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출일' ,left=884 ,top=294 ,right=1082 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=720 ,top=294 ,right=889 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원금+이자' ,left=2477 ,top=294 ,right=2633 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MM', left=799, top=13, right=2101, bottom=98, face='HY헤드라인M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=13 ,top=209 ,right=2818 ,bottom=209 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='대 출 자 현 황' ,left=34 ,top=217 ,right=1450 ,bottom=291 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여공제' ,left=2477 ,top=217 ,right=2633 ,bottom=291 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대출잔액' ,left=2635 ,top=220 ,right=2815 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRINTDT', left=2614, top=114, right=2818, bottom=153, align='right', face='굴림', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Print Date:' ,left=2350 ,top=106 ,right=2611 ,bottom=153 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=13 ,top=384 ,right=2818 ,bottom=384 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1958 ,top=204 ,right=1958 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2471 ,top=204 ,right=2471 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=204 ,right=1450 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2633 ,top=209 ,right=2633 ,bottom=389 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='단위 : 원' ,left=2614 ,top=159 ,right=2818 ,bottom=201 ,align='right' ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=291 ,top=294 ,right=291 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=95 ,top=294 ,right=95 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=294 ,right=482 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=585 ,top=294 ,right=585 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=294 ,right=728 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=884 ,top=294 ,right=884 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=294 ,right=1069 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=294 ,right=1265 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=294 ,right=1598 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1675 ,top=294 ,right=1675 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=294 ,right=2230 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=13 ,top=209 ,right=13 ,bottom=386 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=2818 ,top=209 ,right=2818 ,bottom=386 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<T>id='이자상환내역' ,left=1963 ,top=217 ,right=2471 ,bottom=291 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당월이자' ,left=2000 ,top=294 ,right=2199 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환이자누계' ,left=2238 ,top=304 ,right=2463 ,bottom=365 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환원금누계' ,left=1688 ,top=304 ,right=1947 ,bottom=370 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환원금' ,left=1450 ,top=299 ,right=1603 ,bottom=376 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회수' ,left=1601 ,top=341 ,right=1675 ,bottom=381 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='상환' ,left=1601 ,top=299 ,right=1675 ,bottom=339 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원금상환내역' ,left=1458 ,top=217 ,right=1950 ,bottom=286 ,face='굴림' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=21 ,top=291 ,right=2630 ,bottom=291 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=71 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{CURROW}', left=34, top=0, right=95, bottom=66, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REASON', left=95, top=0, right=294, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DPT_NM', left=294, top=0, right=492, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=484, top=0, right=585, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NO', left=585, top=0, right=728, bottom=66, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=733, top=0, right=884, bottom=66, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPDT', left=881, top=0, right=1080, bottom=66 ,mask='XXXX/XX/XX ', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPAMT', left=1072, top=0, right=1267, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=1251, top=0, right=1450, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT', left=1450, top=0, right=1601, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APPCNT', left=1601, top=0, right=1675, bottom=66, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLAMT_SUM', left=1688, top=0, right=1950, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APLRAT', left=2037, top=0, right=2191, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RATAMT_SUM', left=2238, top=0, right=2463, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AMT_SUM', left=2471, top=0, right=2630, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='APJAMT', left=2635, top=0, right=2815, bottom=66, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=13 ,top=0 ,right=13 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=13 ,top=69 ,right=2820 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2471 ,top=0 ,right=2471 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2633 ,top=0 ,right=2633 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=95 ,top=3 ,right=95 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=291 ,top=3 ,right=291 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=482 ,top=3 ,right=482 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=728 ,top=3 ,right=728 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=585 ,top=3 ,right=585 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=881 ,top=3 ,right=881 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1598 ,top=3 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1675 ,top=3 ,right=1675 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=3 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=3 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2818 ,top=0 ,right=2818 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2233 ,top=3 ,right=2233 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=13 ,top=3 ,right=2818 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='{Sum(APPAMT)} ', left=1072, top=3, right=1267, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_APLRAT)}', left=2471, top=3, right=2630, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(BALANCE)}', left=2641, top=3, right=2818, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=13 ,top=0 ,right=13 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1450 ,top=0 ,right=1450 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2471 ,top=0 ,right=2471 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2633 ,top=0 ,right=2633 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1675 ,top=0 ,right=1675 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1265 ,top=0 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1069 ,top=0 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2230 ,top=0 ,right=2230 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2818 ,top=0 ,right=2818 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	<C>id='CNT', left=32, top=0, right=1045, bottom=66, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=13 ,top=66 ,right=2820 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='{SUM(APLAMT)}', left=1450, top=3, right=1601, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLAMT_SUM)}', left=1704, top=3, right=1947, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APLRAT)}', left=2000, top=3, right=2204, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(RATAMT_SUM)}', left=2238, top=3, right=2477, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(APJAMT)}', left=2635, top=3, right=2815, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='{SUM(AMT_SUM)}', left=2471, top=3, right=2630, bottom=69, align='right', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
</B>
<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
</B>




">
</OBJECT>







</body>
</html>

    <!--**************************************************************************************
    *                                                                                       *
    *  Non Visible Component 선언부(Bind Component)                                         *
    *                                                                                       *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                        |
    | 2. 이름 : bndT_Loan_Detail                    |
    | 3. Table List : T_AC_COLOAN                   |
    +----------------------------------------------->
	<object id="bndT_CM_COMMON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_Loan_Master">
		<Param Name="BindInfo", Value="
			<C>Col='ENO_NO'			Ctrl='txtENO_NO'		Param=value			</C>
			<C>Col='ENO_NM'			Ctrl='txtENO_NM'		Param=value			</C>
			<C>Col='DPT_NM'			Ctrl='txtDPT_NM'		Param=value			</C>
			<C>Col='JOB_NM'			Ctrl='txtJOB_NM'		Param=value			</C>
			<C>Col='APPDT'			Ctrl='txtAPP_YMD'		Param=value			</C>
			<C>Col='APPAMT'			Ctrl='txtAPP_AMT'		Param=text			</C>
			<C>Col='APLDT'			Ctrl='txtAPL_YMD'		Param=value			</C>
			<C>Col='REASON'			Ctrl='cmbREASON'		Param=value			</C>

	    ">
	</object>










