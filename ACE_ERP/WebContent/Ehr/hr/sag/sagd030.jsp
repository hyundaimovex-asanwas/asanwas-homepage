<!--
    ************************************************************************************
    * @source         : sagd030.jsp 				                                                             *
    * @description   : 신_급여계산처리 PAGE.                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                              *
    *-------------+-----------+--------------------------------------------------------+
    * 2016/01/08  |  이동훈   | 최초작성                                                                                         *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>급여계산처리</title>
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


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월

			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호

			//해당년월이 없으면 조회못함.
			if(PIS_YYMM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월을 입력하세요.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

			//해당년월이 잘못되었으면 조회못함.
			if(PIS_YYMM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당년월이 잘못되었습니다.");
					document.getElementById("txtPIS_YYMM_SHR").focus();
					return false;
				}
			}

            //데이터셋 전송
            dsT_CP_WORKLOG.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SHR&PIS_YYMM_SHR="+PIS_YYMM_SHR+"&SEQ_SHR="+SEQ_SHR;
            dsT_CP_WORKLOG.Reset();

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

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

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
	        if (dsT_CP_WORKLOG.IsUpdated)  {

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

        	
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			//cfStyleGrid(form1.grdT_CP_WORKLOG,0,"false","false");

			document.getElementById("txtPIS_YYMM_SHR").value = gcurdate.substring(0,7);

			fnc_SearchList();			
			
			//disableInput();//입력필드 비활성화
			


        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

         //작업 OPEN
         function object_sts_1(){

         	var PIS_YYMM_SHR = document.getElementById("txtPIS_YYMM_SHR").value; // 해당년월
			var SEQ_SHR = document.getElementById("cmbSEQ_SHR").value; // 일련번호
			var PRO_STS = "1";//작업상황

			var i = 1;
			var oPAY_YMD, oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("지급일자를 입력하세요.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("지급일자가 잘못되었습니다.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("연봉기준일자를 입력하세요.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("연봉기준일자가 잘못되었습니다.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

			//키값이 전부 있어야 트랜잭션으로 넘어간다.

			dsT_CP_WORKLOG.NameValue(i,"PIS_YY")=PIS_YYMM_SHR.substring(0,4);
			dsT_CP_WORKLOG.NameValue(i,"PIS_MM")=PIS_YYMM_SHR.substring(5,7);
			dsT_CP_WORKLOG.NameValue(i,"SEQ")=SEQ_SHR;
			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV";
			trT_CP_WORKLOG.Post();

         }

         //대상자 선정
         function object_sts_2(){

			var i = 1;
			var oPAY_YMD, oAPY_YMD;

			oPAY_YMD = dsT_CP_WORKLOG.NameValue(i,"PAY_YMD");
			if(oPAY_YMD.trim().length == 0){
				alert("지급일자를 입력하세요.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}
			if(oPAY_YMD.trim().length != 10){
				alert("지급일자가 잘못되었습니다.");
				document.getElementById("txtPAY_YMD").focus();
				return false;
			}

			oAPY_YMD = dsT_CP_WORKLOG.NameValue(i,"APY_YMD");
			if(oAPY_YMD.trim().length == 0){
				alert("연봉기준일자를 입력하세요.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}
			if(oAPY_YMD.trim().length != 10){
				alert("연봉기준일자가 잘못되었습니다.");
				document.getElementById("txtAPY_YMD").focus();
				return false;
			}

            if (confirm("대상자 선정을 하시겠습니까? ") == false) return;

			var PRO_STS = "2";//작업상황

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV_01";
			trT_CP_WORKLOG.Post();

         }


         //금액·세액계산
         function object_sts_4(){

            if (confirm("금액·세액계산을 하시겠습니까? ") == false) return;

			var PRO_STS = "4";//작업상황

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;


			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV_03";
			trT_CP_WORKLOG.Post();

         }

         //대상자 초기화
         function object_sts_2_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "2" || PRO_STS == "7"){//대상자선정 초기화

	            if (confirm("대상자 초기화를 하시겠습니까? ") == false) return;

				PRO_STS = "1";//대상자선정으로 변경

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//트랜잭션 전송
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV_02";
				trT_CP_WORKLOG.Post();
			}
         }

         //계산 초기화
         function object_sts_4_reset(){
			var i = 1;
			var PRO_STS = dsT_CP_WORKLOG.NameValue(i,"PRO_STS");

			if(PRO_STS == "4"){//금액,세액 계산 초기화

	            if (confirm("계산 초기화를 하시겠습니까? ") == false) return;

				PRO_STS = "2";//금액,세액계산으로 변경

				dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

				//트랜잭션 전송
				trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
				trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV_04";
				trT_CP_WORKLOG.Post();
			}
         }

         //작업CLOSE
         function object_sts_6(){

            if (confirm("작업CLOSE를 하시겠습니까? ") == false) return;

			var PRO_STS = "6";//작업상황

			var i = 1;

			dsT_CP_WORKLOG.NameValue(i,"PRO_STS")=PRO_STS;

			//트랜잭션 전송
			trT_CP_WORKLOG.KeyValue = "SVL(I:SAV=dsT_CP_WORKLOG)";
			trT_CP_WORKLOG.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd030.cmd.SAGD030CMD&S_MODE=SAV_05";
			trT_CP_WORKLOG.Post();
         }

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(state){

			//조회필드는 사용 불가능하게
			document.form1.txtPIS_YYMM_SHR.readOnly = true;
  			document.form1.txtPIS_YYMM_SHR.className = "input_ReadOnly";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = true;
  			document.getElementById("cmbSEQ_SHR").disabled = true;

  			if(state == "0"){//작업OPEN가능
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
	  			form1.medWOM_AMT.Enable = "true";
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = false;
				document.getElementById("btnPRO_STS_1").className="";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//금액.세액계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE
  			}

  			else if(state == "1"){//작업OPEN 완료
				document.form1.txtPAY_YMD.readOnly = false;
	  			document.form1.txtPAY_YMD.className = "";
	  			document.getElementById("imgPAY_YMD").disabled = false;
	  			form1.medWOM_AMT.Enable = "true";
				document.form1.txtAPY_YMD.readOnly = false;
	  			document.form1.txtAPY_YMD.className = "";
	  			document.getElementById("imgAPY_YMD").disabled = false;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = false;
				document.getElementById("btnPRO_STS_2").className="";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//금액.세액계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE
  			}

  			else if(state == "2" || state == "7"){//대상자 선정 완료, 대상자 추가 선정 완료
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
	  			form1.medWOM_AMT.Enable = "false";
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = false;
				document.getElementById("btnPRO_STS_4").className="";//금액.세액계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = false;
				document.getElementById("btnPRO_STS_2_RESET").className="";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

  			}

  			else if(state == "4"){//금액,세액계산 완료
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
	  			form1.medWOM_AMT.Enable = "false";
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//금액.세액계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = false;
				document.getElementById("btnPRO_STS_4_RESET").className="";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = false;
				document.getElementById("btnPRO_STS_6").className="";//작업CLOSE

  			}

  			else if(state == "6"){//작업CLOSE
				document.form1.txtPAY_YMD.readOnly = true;
	  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgPAY_YMD").disabled = true;
	  			form1.medWOM_AMT.Enable = "false";
				document.form1.txtAPY_YMD.readOnly = true;
	  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
	  			document.getElementById("imgAPY_YMD").disabled = true;

	  			document.getElementById("btnPRO_STS_1").disabled = true;
				document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
	  			document.getElementById("btnPRO_STS_2").disabled = true;
				document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
	  			document.getElementById("btnPRO_STS_4").disabled = true;
				document.getElementById("btnPRO_STS_4").className="inputDisabled";//금액.세액계산
	  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
				document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//대상자 초기화
	  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
				document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//계산 초기화
	  			document.getElementById("btnPRO_STS_6").disabled = true;
				document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

  			}

  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){

			//조회필드는 사용 가능하게
			document.form1.txtPIS_YYMM_SHR.readOnly = false;
  			document.form1.txtPIS_YYMM_SHR.className = "";
  			document.getElementById("imgPIS_YYMM_SHR").disabled = false;
  			document.getElementById("cmbSEQ_SHR").disabled = false;

			document.form1.txtPAY_YMD.readOnly = true;
  			document.form1.txtPAY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgPAY_YMD").disabled = true;
  			form1.medWOM_AMT.Enable = "false";
			document.form1.txtAPY_YMD.readOnly = true;
  			document.form1.txtAPY_YMD.className = "input_ReadOnly";
  			document.getElementById("imgAPY_YMD").disabled = true;
  			document.getElementById("btnPRO_STS_1").disabled = true;
			document.getElementById("btnPRO_STS_1").className="inputDisabled";//작업OPEN
  			document.getElementById("btnPRO_STS_2").disabled = true;
			document.getElementById("btnPRO_STS_2").className="inputDisabled";//대상자선정
  			document.getElementById("btnPRO_STS_4").disabled = true;
			document.getElementById("btnPRO_STS_4").className="inputDisabled";//금액.세액계산
  			document.getElementById("btnPRO_STS_2_RESET").disabled = true;
			document.getElementById("btnPRO_STS_2_RESET").className="inputDisabled";//재작업(대상자및계산)
  			document.getElementById("btnPRO_STS_4_RESET").disabled = true;
			document.getElementById("btnPRO_STS_4_RESET").className="inputDisabled";//재작업(대상자및계산)
  			document.getElementById("btnPRO_STS_6").disabled = true;
			document.getElementById("btnPRO_STS_6").className="inputDisabled";//작업CLOSE

  		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_CP_WORKLOG                             |
    | 3. Table List : T_CP_WORKLOG                         |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
        <param name=TimeOut    				value=200000>
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CP_PAYTABLE                          |
    | 3. Table List : T_CP_PAYTABLE                         |
    +----------------------------------------------->
    <Object ID="ds01T_CP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
    </Object>

   	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    	value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      	value="false"/>
       <jsp:param name="USEFILTER"     	value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_CP_WORKLOG                                       |
    | 3. Table List : T_CP_WORKLOG                                 |
    +----------------------------------------------->
    <Object ID ="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
        <param name=TimeOut value=200000>
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">


        if (iCount == 0) {//데이터가 없으면 신규 작업OPEN
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.getElementById("txtPRO_STS_MSG").value = "급여처리 작업OPEN 할 수 있습니다.";

            dsT_CP_WORKLOG.AddRow();

			//여직원회비 초기화
			form1.medWOM_AMT.Text = 0;

			//최근 저장한 연봉기준일자 조회
			ds01T_CP_PAYTABLE.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.sag.d.sagd010.cmd.SAGD010CMD&S_MODE=SHR_01";
			ds01T_CP_PAYTABLE.Reset();

			enableInput("0");

			document.getElementById("txtPAY_YMD").focus();

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

            var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

            if(PRO_STS == "1"){
            	document.getElementById("txtPRO_STS_MSG").value = "작업OPEN을 하였습니다.";
				enableInput("1");
            }else if(PRO_STS == "2"){
               	document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
				enableInput("2");
            }else if(PRO_STS == "3"){
               	//document.getElementById("txtPRO_STS_MSG").value = "대상자선정완료";
            }else if(PRO_STS == "4"){
               	document.getElementById("txtPRO_STS_MSG").value = "금액,세액계산을 완료하였습니다.";
               	enableInput("4");
            }else if(PRO_STS == "5"){
               	//document.getElementById("txtPRO_STS_MSG").value = "작업완료";
            }else if(PRO_STS == "6"){
               	document.getElementById("txtPRO_STS_MSG").value = "작업CLOSE";
               	enableInput("6");
            }else if(PRO_STS == "7"){
               	document.getElementById("txtPRO_STS_MSG").value = "대상자 추가를 완료하였습니다.";
				enableInput("7");
            }

        }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oAPY_YMD = ds01T_CP_PAYTABLE.NameValue(1,"APY_YMD").trim();
			document.getElementById("txtAPY_YMD").value = oAPY_YMD.substring(0,4)+"-"+oAPY_YMD.substring(4,6)+"-"+oAPY_YMD.substring(6,8);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        //alert("해당 필수입력항목[해당년월/근로구분/직위/호봉] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        //alert("해당년월/근로구분/직위/호봉에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_CP_PAYTABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

		var PRO_STS = dsT_CP_WORKLOG.NameValue(1,"PRO_STS").trim();

		if(PRO_STS == "1"){
			//document.getElementById("txtPRO_STS_MSG").value = "작업OPEN을 하였습니다.";
			//enableInput("1");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "2"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "대상자 선정을 완료하였습니다.";
			//enableInput("2");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "3"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "대상자선정완료";
		}else if(PRO_STS == "4"){
		    //document.getElementById("txtPRO_STS_MSG").value = "금액,세액계산을 완료하였습니다.";
			//enableInput("4");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "5"){
	   		//document.getElementById("txtPRO_STS_MSG").value = "작업완료";
		}else if(PRO_STS == "6"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "작업CLOSE";
			//enableInput("6");
			fnc_SearchList();//재조회
		}else if(PRO_STS == "7"){
		   	//document.getElementById("txtPRO_STS_MSG").value = "대상자 추가를 완료하였습니다. (추가선정가능)";
			//enableInput("7");
			fnc_SearchList();//재조회
		}

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_CP_WORKLOG event="OnFail()">
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="80"></col>
								<col width="150"></col>
								<col width="80"></col>
								<col width="180"></col>
								<col width="80"></col>
								<col width="160"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">해당년월</td>
								<td>
									<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">일련번호</td>
								<td>
									<select id="cmbSEQ_SHR" style="width:50">
										<option value="1" >1</option>
	                                    <option value="2" >2</option>
	                                    <option value="3" >3</option>
									</select>
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

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" height="105" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="120"></col>
					<col width="220"></col>
					<col width="120"></col>
					<col width="220"></col>
					<col width="120"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="blueBold">지급일자</td>
					<td class="padding2423">
						<input id="txtPAY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','65','155');"></a>
					</td>
                    <td align="center" class="blueBold">여직원회비</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medWOM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode						value=true>
							<param name=DisabledBackColor			value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength					value=6>
							<param name=Numeric						value=true>
							<param name=ShowLiteral					value="false">
							<param name=Visible							value="true">
							<param name=SelectAll						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">연봉기준일자</td>
					<td class="padding2423">
						<input id="txtAPY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','580','155');"></a>
					</td>
				</tr>
				<tr>
	        		<td align="center" class="blueBold">대상인원</td>
	        		<td colspan="5">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                  <colgroup>
                                      <col width="100"></col>
                                      <col width="130"></col>
                                      <col width="100"></col>
                                      <col width=""></col>
                                  </colgroup>
                                  <tr>
	        		            <td align="right">처리인원&nbsp;</td>
	        		            <td ><input id="txtPRO_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
	        		            <td align="right">미처리인원&nbsp;</td>
	        		            <td ><input id="txtERR_CNT" size="4"  maxlength="4"  class="input_ReadOnly" readonly> 명</td>
	        		        <tr>
	        		    </table>
	        		</td>
				</tr>
				<tr>
	        		<td align="center" class="blueBold">작업상황</td>
	        		<td  class="padding2423" colspan="5">
	        			<input id="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
	        			<input id="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
	        		</td>
	            </tr>
			</table>
		</td>
	</tr>
</table>

<table>
    <tr>
        <td>
            <table width="1000" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td class="paddingTop8">
	                    <table width="1000" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                        <colgroup>
	                            <col width="294"></col>
	                            <col width="294"></col>
	                            <col width="294"></col>
	                            <col width=""></col>
	                        </colgroup>
	                        <tr height="100">
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_1"  style="cursor:hand;width:200pt;height:35pt;" value=" 작업OPEN " onclick="object_sts_1();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2"  style="cursor:hand;width:200pt;height:35pt;" value=" 대상자선정 " onclick="object_sts_2();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4"  style="cursor:hand;width:200pt;height:35pt;" value=" 금액·세액계산 " onclick="object_sts_4();">
	                            </td>
	                        </tr>
	                        <tr height="100">
	                            <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_6" style="cursor:hand;width:200pt;height:35pt;" value=" 작업CLOSE " onclick="object_sts_6();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_2_RESET"  style="cursor:hand;width:200pt;height:35pt;" value=" 대상자 초기화 " onclick="object_sts_2_reset();">
	                            </td>
	                            <td align="center" class="padding2423">
	                                <input type="button" id="btnPRO_STS_4_RESET"  style="cursor:hand;width:200pt;height:35pt;" value=" 계산 초기화 " onclick="object_sts_4_reset();">
	                            </td>
	                        </tr>
	                    </table>
	                <td>
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

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_CP_WORKLOG" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CP_WORKLOG">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS     		 		Ctrl=txtPRO_STS     		 	Param=value 		</C>
		<C>Col=PAY_YMD     		 	Ctrl=txtPAY_YMD     		 	Param=value 		</C>
		<C>Col=WOM_AMT     		 	Ctrl=medWOM_AMT 		   	 Param=text	 	</C>
		<C>Col=APY_YMD     		 	Ctrl=txtAPY_YMD     		 	Param=value 		</C>
		<C>Col=PRO_CNT     		 	Ctrl=txtPRO_CNT     		 	Param=value 		</C>
		<C>Col=ERR_CNT		    		Ctrl=txtERR_CNT     		 	Param=value 		</C>
    '>
</object>

