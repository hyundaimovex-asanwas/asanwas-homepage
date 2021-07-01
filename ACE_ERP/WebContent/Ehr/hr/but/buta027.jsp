<!--
*****************************************************
* @source       : buta027.jsp
* @description  : 출장품의서결재 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2014/07/07      이동훈        최초작성
* 2016/06/01      이동훈        ERP 이사
* 2016/07/26      이동훈        미결재함에서만 넘어오는 출장
*****************************************************
-->

<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<%

	String ord_no = request.getParameter("ORD_NO");         //품의번호
	String eno_no = request.getParameter("PENO_NO");         //품의자사번
	String app_status = request.getParameter("APP_STATUS"); //결재상태
	String app_cmt = request.getParameter("APP_CMT");       //결재자의견
%>

<html>
<head>
<title>출장품의서(결재)</title>
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

        var obj = new String();
        
		obj.app_cmt = "";

        var dsTemp = window.dialogArguments;

        var status = "";//현재 결재 상태

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
        	
	        	trT_DI_BUSINESSTRIP.KeyValue = "tr(O:dsT_DI_BUSINESSTRIP=dsT_DI_BUSINESSTRIP, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_BUSINESSTRIP_WORKER=dsT_DI_BUSINESSTRIP_WORKER)";
				trT_DI_BUSINESSTRIP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta025.cmd.BUTA025CMD&S_MODE=SHR_05&ORD_NO=<%=ord_no%>&ENO_NO=<%=eno_no%>";
				trT_DI_BUSINESSTRIP.post();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //품의번호 조회
            dsORD_NO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.c.butc020.cmd.BUTC020CMD&S_MODE=SHR_01";
			dsORD_NO.reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {



        }



        /*****************
         * 03-1.상신처리 *
         ****************/
        function fnc_Conduct() {


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


            
		}

        /******************
         * 09. 제거 함수  *
         ******************/
         //미사용
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

                window.close();
                

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

            //교통수단 조회
            dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta025.cmd.BUTA025CMD&S_MODE=SHR_02";
            dsT_DI_BUSINESSTRIP_BASIS.reset();

			cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_WORKER,0,"false","true");      // Grid Style 적용            


            fnc_OnLoadPop();


            
            //시작할때 기본으로
            document.getElementById("cmbBUT_GBN").value = "2";

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");     // Grid Style 적용
			
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = true;
			form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {



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
            document.getElementById("chkOFFER_GBN").disabled = true;
            document.getElementById("cmbSTART_GBN").disabled = true;
            document.getElementById("cmbBUT_GBN").disabled = true;
            document.getElementById("txtBUT_CITY").className = "input_ReadOnly";
            document.getElementById("txtBUT_CITY").readOnly = true;
            document.getElementById("txtCITY_DPT1").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT1").readOnly = true;
            document.getElementById("txtCITY_ARV1").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV1").readOnly = true;
            document.getElementById("cmbCITY_GBN1").disabled = true;
            document.getElementById("txtCITY_DPT2").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT2").readOnly = true;
            document.getElementById("txtCITY_ARV2").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV2").readOnly = true;
            document.getElementById("cmbCITY_GBN2").disabled = true;
            document.getElementById("txtCITY_DPT3").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT3").readOnly = true;
            document.getElementById("txtCITY_ARV3").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV3").readOnly = true;
            document.getElementById("cmbCITY_GBN3").disabled = true;
            document.getElementById("txtCITY_DPT4").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT4").readOnly = true;
            document.getElementById("txtCITY_ARV4").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV4").readOnly = true;
            document.getElementById("cmbCITY_GBN4").disabled = true;
            document.getElementById("txtCITY_DPT5").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT5").readOnly = true;
            document.getElementById("txtCITY_ARV5").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV5").readOnly = true;
            document.getElementById("cmbCITY_GBN5").disabled = true;
            document.getElementById("txtCITY_DPT6").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT6").readOnly = true;
            document.getElementById("txtCITY_ARV6").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV6").readOnly = true;
            document.getElementById("cmbCITY_GBN6").disabled = true;
            document.getElementById("txtCITY_DPT7").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT7").readOnly = true;
            document.getElementById("txtCITY_ARV7").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV7").readOnly = true;
            document.getElementById("cmbCITY_GBN7").disabled = true;
            document.getElementById("txtCITY_DPT8").className = "input_ReadOnly";
            document.getElementById("txtCITY_DPT8").readOnly = true;
            document.getElementById("txtCITY_ARV8").className = "input_ReadOnly";
            document.getElementById("txtCITY_ARV8").readOnly = true;
            document.getElementById("cmbCITY_GBN8").disabled = true;
            document.getElementById("txtBUT_OBJ").className = "input_ReadOnly";
            document.getElementById("txtBUT_OBJ").readOnly = true;
            document.getElementById("txtBUT_AFF").className = "input_ReadOnly";
            document.getElementById("txtBUT_AFF").readOnly = true;
            document.getElementById("txtBUT_NAME").className = "input_ReadOnly";
            document.getElementById("txtBUT_NAME").readOnly = true;
            document.getElementById("txtBUT_PHONE").className = "input_ReadOnly";
            document.getElementById("txtBUT_PHONE").readOnly = true;
            document.getElementById("txtREMARK").className = "input_ReadOnly";
            document.getElementById("txtREMARK").readOnly = true;



        }

        function fnc_InputEnable() {
            document.getElementById("txtBUT_FR_YMD").className = "";
            document.getElementById("txtBUT_FR_YMD").readOnly = false;
            document.getElementById("txtBUT_TO_YMD").className = "";
            document.getElementById("txtBUT_TO_YMD").readOnly = false;
            document.getElementById("chkOFFER_GBN").disabled = false;
            document.getElementById("cmbSTART_GBN").disabled = false;
            document.getElementById("cmbBUT_GBN").disabled = false;
            document.getElementById("txtBUT_CITY").className = "";
            document.getElementById("txtBUT_CITY").readOnly = false;
            document.getElementById("txtCITY_DPT1").className = "";
            document.getElementById("txtCITY_DPT1").readOnly = false;
            document.getElementById("txtCITY_ARV1").className = "";
            document.getElementById("txtCITY_ARV1").readOnly = false;
            document.getElementById("cmbCITY_GBN1").disabled = false;
            document.getElementById("txtCITY_DPT2").className = "";
            document.getElementById("txtCITY_DPT2").readOnly = false;
            document.getElementById("txtCITY_ARV2").className = "";
            document.getElementById("txtCITY_ARV2").readOnly = false;
            document.getElementById("cmbCITY_GBN2").disabled = false;
            document.getElementById("txtCITY_DPT3").className = "";
            document.getElementById("txtCITY_DPT3").readOnly = false;
            document.getElementById("txtCITY_ARV3").className = "";
            document.getElementById("txtCITY_ARV3").readOnly = false;
            document.getElementById("cmbCITY_GBN3").disabled = false;
            document.getElementById("txtCITY_DPT4").className = "";
            document.getElementById("txtCITY_DPT4").readOnly = false;
            document.getElementById("txtCITY_ARV4").className = "";
            document.getElementById("txtCITY_ARV4").readOnly = false;
            document.getElementById("cmbCITY_GBN4").disabled = false;
            document.getElementById("txtCITY_DPT5").className = "";
            document.getElementById("txtCITY_DPT5").readOnly = false;
            document.getElementById("txtCITY_ARV5").className = "";
            document.getElementById("txtCITY_ARV5").readOnly = false;
            document.getElementById("cmbCITY_GBN5").disabled = false;
            document.getElementById("txtCITY_DPT6").className = "";
            document.getElementById("txtCITY_DPT6").readOnly = false;
            document.getElementById("txtCITY_ARV6").className = "";
            document.getElementById("txtCITY_ARV6").readOnly = false;
            document.getElementById("cmbCITY_GBN6").disabled = false;
            document.getElementById("txtCITY_DPT7").className = "";
            document.getElementById("txtCITY_DPT7").readOnly = false;
            document.getElementById("txtCITY_ARV7").className = "";
            document.getElementById("txtCITY_ARV7").readOnly = false;
            document.getElementById("cmbCITY_GBN7").disabled = false;
            document.getElementById("txtCITY_DPT8").className = "";
            document.getElementById("txtCITY_DPT8").readOnly = false;
            document.getElementById("txtCITY_ARV8").className = "";
            document.getElementById("txtCITY_ARV8").readOnly = false;
            document.getElementById("cmbCITY_GBN8").disabled = false;
            document.getElementById("txtBUT_OBJ").className = "";
            document.getElementById("txtBUT_OBJ").readOnly = false;
            document.getElementById("txtBUT_AFF").className = "";
            document.getElementById("txtBUT_AFF").readOnly = false;
            document.getElementById("txtBUT_ADDR").className = "";
            document.getElementById("txtBUT_ADDR").readOnly = false;
            document.getElementById("txtBUT_NAME").className = "";
            document.getElementById("txtBUT_NAME").readOnly = false;
            document.getElementById("txtBUT_PHONE").className = "";
            document.getElementById("txtBUT_PHONE").readOnly = false;
            document.getElementById("txtREMARK").className = "";
            document.getElementById("txtREMARK").readOnly = false;
            document.form1.rdoBUT_FR_GBN.Enable = "true";
            document.form1.rdoBUT_TO_GBN.Enable = "true";


            //결재선 삽입, 제거 버튼
            document.getElementById("btn_InsDel").style.display = "";

        }

        /*************************
         * 19. 상신, 결재 처리   *
         *************************/
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" 처리를 하시겠습니까?")) return;


            var app_yn = "";    //결재완료여부

            if(kind == "상신"){
                fnc_InputDisabled();//입력란 disabled
                document.getElementById("btn_appre").style.display = "none";//상신않보이게  ===>  수정 요망
                status = "A1";
                return false;

            }else if(kind == "결재"){
                app_yn = "Y";
            }else if(kind == "부결" || kind == "반송"){

				if(obj.app_cmt == ""){
          			window.showModalDialog("../../../Ehr/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
          	    }

	            if(obj.app_cmt != ""){
					app_yn = "N";
		            if(kind == "부결") {
		            	app_yn = "N";

		            }else if(kind == "반송") {
		            	app_yn = "E";
		            }
	            }else{
                    alert("부결 또는 반송사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
	                return false;
            	}

            }

            dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
            dsT_DI_BUSINESSTRIP_STATE.AddRow();
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_STATUS") = status;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;
            dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_YN") = app_yn;


            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE )";
			trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta025.cmd.BUTA025CMD&S_MODE=SAV_02";
			trT_DI_BUSINESSTRIP_STATE.post();


            document.getElementById("btn_approval").style.display = "";//결재버튼들

            window.close();
            

        }

        /*****************************************
         * 22. 사유입력팝업(부결, 반송처리)      *
         ****************************************/
		function fnc_SubmitCancle(kind) {


            var obj = new String();

            window.showModalDialog("../../../Ehr/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.app_cmt != undefined){

                dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
                dsT_DI_BUSINESSTRIP_STATE.AddRow();
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ORD_NO") = document.getElementById("txtORD_NO").value;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_STATUS") = status;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_CMT") = kind+"처리-"+obj.app_cmt;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"KIND") = kind;
                dsT_DI_BUSINESSTRIP_STATE.NameValue(1,"APP_YN") = "N";

                trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE)";
                trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta025.cmd.BUTA025CMD&S_MODE=SAV_03";
                trT_DI_BUSINESSTRIP_STATE.post();

                document.getElementById("btn_approval").style.display = "";

            }

        }

        /*************************
         * 20. 여비 계산         *
         *************************/
		function fnc_Calcul_Basis() {



        }

        /*************************
         * 21. 팝업일 경우 처리  *
         *************************/
		function fnc_OnLoadPop() {

            status = "<%=app_status%>";
            cmt = "<%=app_cmt%>";

            fnc_SearchList(); //해당 출장품의서 조회
            
            fnc_InputDisabled();


            var APP_STATUS = "";
            var Aeno_no = "";

                for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){

                    Aeno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");   //결재자
                    
					APP_STATUS = dsT_DI_APPROVAL.NameValue(i,"APP_STATUS");   //결재여부  &&  (app_yn == null)			
					
					if(Aeno_no == gusrid && ( APP_STATUS == "미결")){

						document.getElementById("btn_approval").style.display = "";
						
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						
						break;

                }
					
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
    | 3. Table List : T_DI_BUSINESSTRIP             |
    +----------------------------------------------->
    <Object ID="dsORD_NO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_BASIS           |
    | 3. Table List : T_DI_BUSINESSTRIP_BASIS       |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP                 |
    | 3. Table List : T_DI_BUSINESSTRIP             |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_WORKER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_AD_DECISION                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                               |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP_ACCOUNT)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_ACCOUNT)       |
    +------------------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_ACCOUNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                               |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP_ACCOUNT)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_ACCOUNT)       |
    +------------------------------------------------------->
    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>
    
    <Object ID="dsT_RP_REPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>    
    
    <Object ID="dsT_RP_REPORT4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>        
    
    <Object ID="dsT_RP_REPORT5" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>     
        
    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP)	            |
    +------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_BUSINESSTRIP Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            //동행인 여부 라디오버튼 설정
            if(dsT_DI_BUSINESSTRIP.NameValue(1,"COM_YN") == "Y"){
                document.getElementById("radio2").checked = true;
            }else{
                document.getElementById("radio1").checked = true;
            }

            //숙박제공교육 여부
            if(dsT_DI_BUSINESSTRIP.NameValue(1,"OFFER_GBN") == "Y"){
				document.getElementById("chkOFFER_GBN").checked = true;
	            document.getElementById("cmbSTART_GBN").disabled = false;
            }else{
            	document.getElementById("chkOFFER_GBN").checked = false;
				document.getElementById("cmbSTART_GBN").value = "";
	            document.getElementById("cmbSTART_GBN").disabled = true;
            }

        }

    </Script>

    <Script For=dsORD_NO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			document.getElementById("txtORD_NO").value = dsORD_NO.NameValue(1,"ORD_NO");
        }

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
			//교통수단
			if(document.getElementById("cmbCITY_GBN1").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN1").add(oOption);

	            }
            }

			if(document.getElementById("cmbCITY_GBN2").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN2").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN3").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN3").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN4").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN4").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN5").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN5").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN6").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN6").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN7").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN7").add(oOption);
	            }
            }

			if(document.getElementById("cmbCITY_GBN8").length == 1){
	            for( var i = 1; i <= dsT_DI_BUSINESSTRIP_BASIS.CountRow; i++ ) {
	                oOption       = document.createElement("OPTION");
	                oOption.value = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD");
	                oOption.text  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")+"  "+dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_NAME");
	                document.getElementById("cmbCITY_GBN8").add(oOption);
	            }
			}

        }

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {

        } else {

            //첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용
            
            form1.grdT_DI_APPROVAL.TitleHeight = 18;
            form1.grdT_DI_APPROVAL.RowHeight = 18;
            form1.grdT_DI_APPROVAL.DisableNoVScroll = true;
            form1.grdT_DI_APPROVAL.HiddenHScroll  = true;
            form1.grdT_DI_APPROVAL.HiddenVScroll  = true;
            form1.grdT_DI_APPROVAL.DisableNoHScroll = true;

            form1.grdT_DI_APPROVAL.IgnoreSelectionColor = "true";
       }

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsORD_NO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_DI_BUSINESSTRIP_ACCOUNT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP event="OnSuccess()">

        document.getElementById("btn_trbfee").style.display = "";
        document.getElementById("btn_SlipconductOn").style.display = "";
        
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		window.showModalDialog("../../../Ehr/hr/but/buta026.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../../Ehr/hr/but/buta023.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
  </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5" align="left" width="285" height="35" >
            <span id="btn_trbfee" style="display:none">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAccount','','../../images/button/btn_AccountOver.gif',1)"><img src="../../images/button/btn_AccountOn.gif" name="imgAccount" width="90" height="20" border="0" align="absmiddle" onClick="fnc_Calcul_Basis();"></a>
            </span>
		</td>

		<td class="paddingTop5" align="right" width="435" height="35" >
		    <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)"><img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle" 	  onClick="fnc_SubmitApproval('결재');"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)"><img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');"></a>
            </span>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
								<td align="center" class="blueBold">품의번호</td>
								<td class="padding2423">
									<input id="txtORD_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            <tr height="27">
								<td align="center" class="blueBold">소속</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">직위</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">출장자</td>
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
        <td width="30">&nbsp;&nbsp;</td>
        <td>
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="550" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
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
   				<tr>
                    <td align="right">
             &nbsp;    <span id="btn_InsDel">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','../../images/button/btn_SelectapprovalOver.gif',1)"> <img src="../../images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
                       </span>
		            </td>
		       </tr>
            </table>
        	<!-- 결재선 정보 테이블 끝 -->
        </td>
    </tr>
</table>



<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_BUSINESSTRIP_WORKER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:145px;">
						<param name="DataID" 				value="dsT_DI_BUSINESSTRIP_WORKER">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 				value="Left">
						<param name="Format" 				value='
                            <C> id="{CUROW}"			width=40	name="No"			align=center    value={String(Currow)}</C>
                            <C> id="JOB_NM"				width=100	name="직위"		align=center    </C>
							<C> id="NAM_KOR"			width=80	name="성명"		align=center    </C>
							<C> id="BUT_FROM_TO"	width=200	name="출장기간"	align=center	</C>
                            <C> id="C_COST"				width=70	name="교통비"		align=right      </C>
							<C> id="G1_COST"	    	width=70	name="숙박비"	    align=right      </C>
                            <C> id="G2_COST"			width=70	name="식비"	    align=right      </C>
                            <C> id="G3_COST"			width=70	name="잡비"	    align=right      </C>
                            <C> id="X_SUM"				width=70	name="계"	    	align=right      </C>                            
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
<!-- 내용 조회 그리드 데이블 끝-->


<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
                    <col width="342"></col>
                    <col width="222"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">출장기간</td>
					<td class="padding2423" colspan="2">
						<input id="txtBUT_FR_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_FR_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_FR_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_FR_YMD','','40','235');"></a>
                        <comment id="__NSID__">
							<object id=rdoBUT_FR_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:0;width:0;">
								<param name=AutoMargin	value="true">
								<param name=Cols		value="1">
								<param name=Format		value="A^오전">
							</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>~&nbsp;&nbsp;
                        <input id="txtBUT_TO_YMD" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtBUT_TO_YMD','txtBUT_FR_YMD','txtBUT_TO_YMD'); cfCheckDate(this);fnc_Auto_Input('txtBUT_FR_YMD','txtBUT_TO_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="if(txtBUT_TO_YMD.readOnly == true) return; calendarBtn('datetype1','txtBUT_TO_YMD','','300','235');"></a>
                        <comment id="__NSID__">
							<object id=rdoBUT_TO_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:0;width:0">
								<param name=AutoMargin	value="true">
								<param name=Cols		value="2">
								<param name=Format		value="P^오후">
							</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script> (
                        <input id="txtSLEEP_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>박
                        <input id="txtBUT_DAY" size="3" style="text-align:right" class="input_ReadOnly" readOnly>일 )
						<B>출장유형</B>
						<select id="cmbBUT_GBN" name="cmbBUT_GBN" style="width:85">
                            <option value="1">경조</option>
                            <option value="2">일반출장</option>
                        </select>

                    </td>
                    <td class="padding2423" rowspan="2" valign="top">
                        &nbsp;
                        <input type="checkbox" id="chkOFFER_GBN" style="border:0" align="absmiddle" onclick="fnc_OFFER_GBN()">북측출장
                        <br>&nbsp;&nbsp;&nbsp;(숙식제공)
						<input type="hidden" id="txtOFFER_GBN">
						<br>
						&nbsp;

						<input type="hidden" id="cmbSTART_GBN" size="40"  class="input_ReadOnly" readOnly>

					</td>
                </tr>
                <tr>
					<td align="center" class="blueBold">출 장 지</td>
					<td class="padding2423" colspan="2">
						<input id="txtBUT_CITY" size="30" maxlength="40" onKeyUp="fc_chk_byte(this,40)">
						&nbsp;
						<input type="hidden" id="txtPC_CCTRCD" size="20" >
						<input type="hidden" id="txtPC_CCTRNM" size="40"  class="input_ReadOnly" readOnly>
						<input type="hidden" id="txtPC_GBN" size="30" >
						<input type="hidden" id="txtWBS_FR_YMD" size="30" >
						<input type="hidden" id="txtWBS_TO_YMD" size="30" >
						<span id="btn_Slip" type="hidden"  >
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectSlip','','../../images/button/btn_SlipOver.gif',1)"> </a>
						</span>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold" rowspan="4">출장구간<BR><BR>및<BR><BR>교통수단</td>
					<td class="padding2423">
						<B>1. </B><input id="txtCITY_DPT1" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV1" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN1" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT2.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>5. </B><input id="txtCITY_DPT5" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV5" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN5" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT6.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
				</tr>
                <tr>
                    <td class="padding2423">
						<B>2. </B><input id="txtCITY_DPT2" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV2" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN2" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT3.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>6. </B><input id="txtCITY_DPT6" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV6" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN6" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT7.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
                    <td class="padding2423">
						<B>3. </B><input id="txtCITY_DPT3" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV3" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN3" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT4.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>7. </B><input id="txtCITY_DPT7" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV7" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN7" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT8.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
                    <td class="padding2423">
						<B>4. </B><input id="txtCITY_DPT4" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV4" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN4" style="WIDTH: 50%" onkeydown="if(event.keyCode==9){form1.txtCITY_DPT5.focus();event.returnValue=false;}">
                            <option value=""></option>
                        </select>
					</td>
                    <td class="padding2423" colspan="2">
						<B>8. </B><input id="txtCITY_DPT8" size="6" onKeyUp="fc_chk_byte(this,6)">
                        - <input id="txtCITY_ARV8" size="6" onKeyUp="fc_chk_byte(this,6)">
                        <select id="cmbCITY_GBN8" style="WIDTH: 50%">
                            <option value=""></option>
                        </select>
					</td>
                </tr>
                <tr>
					<td align="center" class="blueBold">출장목적</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtBUT_OBJ"  onKeyUp="fc_chk_byte(this,200)"  cols=110  rows=2 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="blueBold">출장효과</td>
					<td class="padding2423" colspan="3">
						<textarea id="txtBUT_AFF"  onKeyUp="fc_chk_byte(this,200)" cols=110  rows=2 >
						</textarea>
					</td>
				</tr>
                <tr>
					<td align="center" class="blueBold" >긴급연락처</td>

					<td class="padding2423" colspan="3">
					    <B>성명</B>
					    <input id="txtBUT_NAME" size="12" onKeyUp="fc_chk_byte(this,12)">
					    <B>연락처</B>  
						<input id="txtBUT_PHONE" size="15" maxLength="15" onkeypress="cfCheckNumber()" style="ime-mode:disabled">
					</td>
				</tr>

                <tr>
					<td align="center" class="blueBold">비&nbsp;&nbsp;고</td>
					<td class="padding2423" colspan="3">
						<input id="txtREMARK" size="80" onKeyUp="fc_chk_byte(this,80)">
                        <input type="hidden" id="hidAPP_CMT"">
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
<object id="bndT_DI_BUSINESSTRIP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP">
	<Param Name="BindInfo", Value='
        <C>Col=ORD_NO     		Ctrl=txtORD_NO     		Param=value 	</C>
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     		Param=value 	</C>
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
		<C>Col=JOB_CD			Ctrl=txtJOB_CD	   		Param=value		</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=ENO_NO   		Ctrl=txtENO_NO    		Param=value		</C>
		<C>Col=NAM_KOR			Ctrl=txtNAM_KOR     	Param=value		</C>
        <C>Col=BUT_FR_YMD       Ctrl=txtBUT_FR_YMD  	Param=value 	</C>
        <C>Col=BUT_FR_GBN       Ctrl=rdoBUT_FR_GBN  	Param=CodeValue </C>
        <C>Col=BUT_TO_YMD       Ctrl=txtBUT_TO_YMD  	Param=value 	</C>
        <C>Col=PC_CCTRCD        Ctrl=txtPC_CCTRCD  		Param=value 	</C>
        <C>Col=PC_CCTRNM        Ctrl=txtPC_CCTRNM  		Param=value 	</C>
        <C>Col=PC_GBN           Ctrl=txtPC_GBN  		Param=value 	</C>
        <C>Col=BUT_TO_GBN       Ctrl=rdoBUT_TO_GBN  	Param=CodeValue </C>
        <C>Col=OFFER_GBN        Ctrl=txtOFFER_GBN  	    Param=value 	</C>
        <C>Col=START_GBN        Ctrl=cmbSTART_GBN  	    Param=value 	</C>
        <C>Col=BUT_GBN          Ctrl=cmbBUT_GBN  	    Param=value 	</C>
        <C>Col=SLEEP_DAY        Ctrl=txtSLEEP_DAY  	    Param=value 	</C>
        <C>Col=BUT_DAY          Ctrl=txtBUT_DAY  	    Param=value 	</C>
        <C>Col=BUT_CITY         Ctrl=txtBUT_CITY  	    Param=value 	</C>
        <C>Col=CITY_DPT1        Ctrl=txtCITY_DPT1  	    Param=value 	</C>
        <C>Col=CITY_ARV1        Ctrl=txtCITY_ARV1  	    Param=value 	</C>
        <C>Col=CITY_GBN1        Ctrl=cmbCITY_GBN1  	    Param=value 	</C>
        <C>Col=CITY_DPT2        Ctrl=txtCITY_DPT2  	    Param=value 	</C>
        <C>Col=CITY_ARV2        Ctrl=txtCITY_ARV2  	    Param=value 	</C>
        <C>Col=CITY_GBN2        Ctrl=cmbCITY_GBN2  	    Param=value 	</C>
        <C>Col=CITY_DPT3        Ctrl=txtCITY_DPT3  	    Param=value 	</C>
        <C>Col=CITY_ARV3        Ctrl=txtCITY_ARV3  	    Param=value 	</C>
        <C>Col=CITY_GBN3        Ctrl=cmbCITY_GBN3  	    Param=value 	</C>
        <C>Col=CITY_DPT4        Ctrl=txtCITY_DPT4  	    Param=value 	</C>
        <C>Col=CITY_ARV4        Ctrl=txtCITY_ARV4  	    Param=value 	</C>
        <C>Col=CITY_GBN4        Ctrl=cmbCITY_GBN4  	    Param=value 	</C>
        <C>Col=CITY_DPT5        Ctrl=txtCITY_DPT5  	    Param=value 	</C>
        <C>Col=CITY_ARV5        Ctrl=txtCITY_ARV5  	    Param=value 	</C>
        <C>Col=CITY_GBN5        Ctrl=cmbCITY_GBN5  	    Param=value 	</C>
        <C>Col=CITY_DPT6        Ctrl=txtCITY_DPT6  	    Param=value 	</C>
        <C>Col=CITY_ARV6        Ctrl=txtCITY_ARV6  	    Param=value 	</C>
        <C>Col=CITY_GBN6        Ctrl=cmbCITY_GBN6  	    Param=value 	</C>
        <C>Col=CITY_DPT7        Ctrl=txtCITY_DPT7  	    Param=value 	</C>
        <C>Col=CITY_ARV7        Ctrl=txtCITY_ARV7  	    Param=value 	</C>
        <C>Col=CITY_GBN7        Ctrl=cmbCITY_GBN7  	    Param=value 	</C>
        <C>Col=CITY_DPT8        Ctrl=txtCITY_DPT8  	    Param=value 	</C>
        <C>Col=CITY_ARV8        Ctrl=txtCITY_ARV8  	    Param=value 	</C>
        <C>Col=CITY_GBN8        Ctrl=cmbCITY_GBN8  	    Param=value 	</C>
        <C>Col=BUT_OBJ          Ctrl=txtBUT_OBJ  	    Param=value 	</C>
        <C>Col=BUT_AFF          Ctrl=txtBUT_AFF  	    Param=value 	</C>
        <C>Col=BUT_ADDR         Ctrl=txtBUT_ADDR  	    Param=value 	</C>
        <C>Col=BUT_NAME         Ctrl=txtBUT_NAME  	    Param=value 	</C>
        <C>Col=BUT_PHONE        Ctrl=txtBUT_PHONE  	    Param=value 	</C>
        <C>Col=COM_YN           Ctrl=hidCOM_YN          Param=value     </C>
        <C>Col=REMARK           Ctrl=txtREMARK  	    Param=value 	</C>
    '>
</object>