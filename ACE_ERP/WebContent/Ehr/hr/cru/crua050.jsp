<!--
***********************************************************************
* @source      : crua050.jsp
* @description : 서류심사기준관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/05      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>서류심사기준관리(crua050)</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var oYMD_SHR = document.getElementById("txtYMD_SHR");
            if(oYMD_SHR.value == "") {
                alert("기준일을 입력해 주세요");
                oYMD_SHR.focus();
                return;
            }

            var ymd = document.getElementById("txtYMD_SHR").value;
            var cd_gbn = document.getElementById("cmbCD_GBN_SHR").value;
            var work_gbn = document.getElementById("cmbWORK_GBN_SHR").value;
            var gubun = document.getElementById('cmbGUBUN_SHR').value;

            dsT_RC_JUDGESTD.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=SHR&YMD="+ymd+"&CD_GBN="+cd_gbn+"&WORK_GBN="+work_gbn+"&GUBUN="+gubun;
            dsT_RC_JUDGESTD.reset();

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

				if(!fnc_SaveItemCheck()) return;	//유효성 체크

				trT_RC_JUDGESTD.KeyValue = "tr01(I:dsT_RC_JUDGESTD=dsT_RC_JUDGESTD)";
				trT_RC_JUDGESTD.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=SAV";
				trT_RC_JUDGESTD.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			var row = dsT_RC_JUDGESTD.RowPosition;

			if(dsT_RC_JUDGESTD.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
            if(dsT_RC_JUDGESTD.NameValue(row,"END_YMD") != ""){
                alert("해당데이터는 삭제할 수 없습니다!");
                return;
            }
			if(confirm("[기준항목:" + dsT_RC_JUDGESTD.NameValue(row,'CD_GBN') + "/시작일:" + dsT_RC_JUDGESTD.NameValue(row,'STR_YMD') + "]의 정보를 삭제하시겠습니까?")){
				dsT_RC_JUDGESTD.DeleteRow(row);
				trT_RC_JUDGESTD.KeyValue = "tr01(I:dsT_RC_JUDGESTD=dsT_RC_JUDGESTD)";
				trT_RC_JUDGESTD.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua050.cmd.CRUA050CMD&S_MODE=DEL";
				trT_RC_JUDGESTD.post();
			}

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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_RC_JUDGESTD.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_RC_JUDGESTD.setDataHeader("CD_GBN:STRING:KEYVALUE, STR_YMD:STRING:KEYVALUE, END_YMD:STRING, WORK_GBN:STRING:KEYVALUE, SEQ_NO:STRING:KEYVALUE, BASE_CNT:STRING, BASE_CD:STRING, BASE_NM:STRING, FULL_CNT:STRING, THAN_TAG:STRING, ADD_CNT:INTEGER");
			}

			dsT_RC_JUDGESTD.AddRow();

			//임시SEQ, 저장시에는 PK로 일련번호로 계산
			dsT_RC_JUDGESTD.NameValue(dsT_RC_JUDGESTD.RowPosition,'SEQ_NO') = dsT_RC_JUDGESTD.CountRow;

			document.getElementById('cmbCD_GBN').focus();

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

            //document.getElementById("txtYMD_SHR").value = "";
            document.getElementById("cmbCD_GBN_SHR").value = "";
            document.getElementById("cmbWORK_GBN_SHR").value = "";
			document.getElementById('cmbGUBUN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_RC_JUDGESTD.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_RC_JUDGESTD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_JUDGESTD.IsUpdated ) {
				alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			for(i=1;i<dsT_RC_JUDGESTD.CountRow+1;i++){
				if(dsT_RC_JUDGESTD.NameValue(i,'STR_YMD') != '' && dsT_RC_JUDGESTD.NameValue(i,'END_YMD') != ''){
					if (dsT_RC_JUDGESTD.NameValue(i,'STR_YMD') > dsT_RC_JUDGESTD.NameValue(i,'END_YMD')) {
						alert("시작일은 종료일 보다 반드시 작아야 합니다.");
						dsT_RC_JUDGESTD.RowPosition = i;
						document.getElementById('txtSTR_YMD').focus();
						return false;
					}
				}
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
        
            fnc_DisableElementAll(elementList);

			cfStyleGrid(form1.grdT_RC_JUDGESTD,15,"false","false");      // Grid Style 적용

            document.getElementById("txtYMD_SHR").value = getToday();
            document.getElementById('txtYMD_SHR').focus();
            
            dsCOMM_CODE.ClearData();
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_E7");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_E6");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_H1");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_F1");
            fnc_BindingCommonDataSet("dsCOMM_CODE", "dsT_CM_COMMON_Z5");
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /**
         * 기준항목이 변경 되었을때 처리할 내역
         */
		function fnc_ChangeCdGbn() {
            
            //해당되는 모든  코드 초기화
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD" ) = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "FULL_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "THAN_TAG") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "ADD_CNT" ) = "";
            
            //항목들 변경 시킴
            fnc_BindCode();
		}
        
        /**
         * 기준항목이 변경되었을때 맞춰서 변경시킬 항목들
         */
        function fnc_BindCode() {
            var cd_gbn      = document.getElementById("cmbCD_GBN").value;
            var oSelect     = document.getElementById("cmbWORK_GBN");
            var oOption;
            var wrkGbnNames;
            var wrkGbnVals;
            
            fnc_ChangeStateElement(false, "cmbBASE_CD");    //기준코드 사용
            fnc_ChangeStateElement(false, "txtBASE_CNT");   //기준점 사용못하게
            fnc_ChangeStateElement(false, "txtFULL_CNT");   //환산만점 사용못하게
            fnc_ChangeStateElement(false, "cmbTHAN_TAG");   //구분 사용 못하게
            fnc_ChangeStateElement(false, "txtADD_CNT" );   //가산점 사용 못하게

			//'UGRDYN','학력'
			//'UYMD','졸업년도'
			//'TAVE','학점'
			//'TOEIC','토익'
			//'UMAJOR','전공'
			//'AWDYN','보훈대상'
			//'LICENCE','자격증'
			//'MILYN','병역'
            
            //===================================
            //1.기준코드를 바인딩 합시다.
            //===================================
            
            //학력, 전공, 자격증, 병역, 보훈대상
            if(cd_gbn=="UGRDYN" || cd_gbn=="UMAJOR" || cd_gbn=="LICENCE" || cd_gbn=="MILYN" || cd_gbn=="AWDYN"){
                
                fnc_ChangeStateElement(true , "cmbBASE_CD");

                //기준코드 바인딩
                //학력 일때
                if(cd_gbn=="UGRDYN")        
                    fnc_ConstructCommonCode("dsT_CM_COMMON_E7", "cmbBASE_CD");  
                    
                //전공 일때
                else if(cd_gbn=="UMAJOR")  
                    fnc_ConstructCommonCode("dsT_CM_COMMON_E6", "cmbBASE_CD");  
              
                //자격증 일때
                else if(cd_gbn=="LICENCE")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_H1", "cmbBASE_CD");  

                //병역 일때                
                else if(cd_gbn=="MILYN")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_F1", "cmbBASE_CD");  

                //보훈대상 일때                
                else if(cd_gbn=="AWDYN")
                    fnc_ConstructCommonCode("dsT_CM_COMMON_Z5", "cmbBASE_CD");  
            }
            
            else{
                document.getElementById('cmbBASE_CD').length = 0;
            }




            //===================================
            //2.기준항목에 해당하는 적용항목을 바인딩 합시다.
            //===================================
            
            //'TAVE:학점'과 'TOEIC:토익'에만 환산점수 입력이 가능하다.
            if(cd_gbn=="TAVE" || cd_gbn=="TOEIC"){
                wrkGbnNames = new Array( ""
                                       , "배 제"
                                       , "환산점"
                                       , "가산점" );
                wrkGbnVals  = new Array( ""
                                       , "1"
                                       , "2"
                                       , "3" );
            } else {
                wrkGbnNames = new Array( ""
                                       , "배 제"
                                       , "가산점" );
                wrkGbnVals  = new Array( ""
                                       , "1"
                                       , "3" );
            }
            
            //적용항목 바인드
            oSelect.options.length = 0;
            
            for(var i=0; i<wrkGbnNames.length; i++) {
                oOption       = document.createElement("OPTION");
            
                oOption.value = wrkGbnVals[i];
                oOption.text  = wrkGbnNames[i];
                
                oSelect.add(oOption);
            }
            
            
            //선택한 값을 바인드합시다.
            document.getElementById("cmbBASE_CD").value     = dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD");
            document.getElementById("cmbWORK_GBN").value    = dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN");
        }
        
        /*
         * 적용항목이 변경 되었을때 처리할 이벤트
         */
        function fnc_ChangeWrkGbn() {
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "WORK_GBN") = document.getElementById("cmbWORK_GBN").value;

            //해당되는 모든  코드 초기화
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "FULL_CNT") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "THAN_TAG") = "";
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "ADD_CNT" ) = "";

            fnc_ChangeStateElement(false, "txtBASE_CNT");   //기준점 사용못하게
            fnc_ChangeStateElement(false, "txtFULL_CNT");   //환산만점 사용못하게
            fnc_ChangeStateElement(false, "cmbTHAN_TAG");   //구분 사용 못하게
            fnc_ChangeStateElement(false, "txtADD_CNT" );   //가산점 사용 못하게
            

            //'UGRDYN','학력'
            //'UYMD','졸업년도'
            //'TAVE','학점'
            //'TOEIC','토익'
            //'UMAJOR','전공'
            //'AWDYN','보훈대상'
            //'LICENCE','자격증'
            //'MILYN','병역'
            var cd_gbn      = document.getElementById("cmbCD_GBN"  ).value;
            var wrk_gbn     = document.getElementById("cmbWORK_GBN").value;

            //졸업년도, 학점, 토익
            if(cd_gbn == "UYMD" || cd_gbn == "TAVE" || cd_gbn == "TOEIC") {
                fnc_ChangeStateElement(true, "txtBASE_CNT");   //기준점
                
                
                //환산점수
                if(wrk_gbn == "2" && (cd_gbn == "TAVE" || cd_gbn == "TOEIC")) {
                    fnc_ChangeStateElement(true, "txtFULL_CNT");   //환산만점
                } else {
                    fnc_ChangeStateElement(true, "cmbTHAN_TAG");   //구분
                }
            } 
            
            if(wrk_gbn == "3") {
                fnc_ChangeStateElement(true, "txtADD_CNT" );   //가산점
            }
        }
        
        /**
         * 기준코드가 변경 되었을때 처리할 이벤트
         */
        function fnc_ChangeBaseCd() {
            dsT_RC_JUDGESTD.NameString(dsT_RC_JUDGESTD.RowPosition, "BASE_CD") = document.getElementById("cmbBASE_CD").value;
        }

        /*****************************************
         * 18. 기준코드 변경에 기준명 변경 처리  *
         ****************************************/
		function fnc_changeBaseCD(index) {
            //현재 선택된 셀렉트 박스의 INDEX로 기준명을 표시한다
            dsT_RC_JUDGESTD.NameValue(dsT_RC_JUDGESTD.RowPosition, 'BASE_NM') = document.getElementById("cmbBASE_CD")[index].text;

		}

      
        //항목 리스트
        var elementList = new Array(     "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"imgSTR_YMD"
                                        ,"imgEND_YMD"
                                        ,"cmbWORK_GBN"
                                        ,"txtBASE_CNT"
                                        ,"cmbBASE_CD"
                                        ,"txtFULL_CNT"
                                        ,"cmbTHAN_TAG"
                                        ,"txtADD_CNT" );
                                        
        var elementList2 = new Array(    "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"imgSTR_YMD"
                                        ,"imgEND_YMD"
                                        ,"cmbWORK_GBN" );
        
        var exceptionList = new Array(   "cmbCD_GBN"
                                        ,"txtSTR_YMD"
                                        ,"imgSTR_YMD"
                                        ,"cmbWORK_GBN" );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_RC_JUDGESTD) |
    | 3. 사용되는 Table List(T_RC_JUDGESTD)		     |
    +------------------------------------------------>
    <Object ID="dsT_RC_JUDGESTD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <Object ID="dsCOMM_CODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_RC_JUDGESTD)	|
    | 3. 사용되는 Table List(T_RC_JUDGESTD)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_JUDGESTD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 학력 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E7"/>
       <jsp:param name="CODE_GUBUN"    value="E7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 전공 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E6"/>
       <jsp:param name="CODE_GUBUN"    value="E6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 자격증 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H1"/>
       <jsp:param name="CODE_GUBUN"    value="H1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 병역 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_F1"/>
       <jsp:param name="CODE_GUBUN"    value="F1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 보훈대상 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Z5"/>
       <jsp:param name="CODE_GUBUN"    value="Z5"/>
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
    <Script For=dsT_RC_JUDGESTD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_RC_JUDGESTD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_JUDGESTD Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준항목, 시작일, 적용항목, 순서] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[기준항목, 시작일, 적용항목, 순서]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_RC_JUDGESTD event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_RC_JUDGESTD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_RC_JUDGESTD event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            //항목들 변경 시킴
            fnc_BindCode();

            //신규일 경우        
            if(dsT_RC_JUDGESTD.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList2);
            } else {
                fnc_EnableElementAll(elementList2, exceptionList);
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">서류심사기준관리</td>
					<td align="right" class="navigator">HOME/기타/채용관리/<font color="#000000">서류심사기준관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="70"></col>
                                    <col width="100"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="80"></col>
                                    <col width="90"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="center" class="searchState">기준일</td>
                                <td class="padding2423">
                                    <input id="txtYMD_SHR" size="10" maxLength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfDateHyphen(this); cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtYMD_SHR','','25','170');"></a>
                                </td>
                                <td align="center" class="searchState">기준항목</td>
                                <td class="padding2423">
                                    <select id="cmbCD_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value="">전 체</option>
                                        <option value="UGRDYN">학 력</option>
                                        <option value="UYMD">졸업년도</option>
                                        <option value="TAVE">학 점</option>
                                        <option value="TOEIC">토 익</option>
                                        <option value="UMAJOR">전 공</option>
                                        <option value="AWDYN">보훈대상</option>
                                        <option value="LICENCE">자격증</option>
                                        <option value="MILYN">병역</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">적용항목&nbsp;</td>
								<td class="padding2423">
									<select id="cmbWORK_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value="">전 체</option>
										<option value="1">배 제</option>
							            <option value="2">환산점</option>
                                        <option value="3">가산점</option>
									</select>
								</td>
								<td align="right" class="searchState">사용기준&nbsp;</td>
								<td class="padding2423">
									<select id="cmbGUBUN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option value="">전 체</option>
										<option value="Y">사용중</option>
									</select>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="120"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">기준항목</td>
					<td class="padding2423">
                        <select id="cmbCD_GBN" style="WIDTH: 100%" onChange="fnc_ChangeCdGbn()">
                            <option value="UGRDYN">학 력</option>
                            <option value="UYMD">졸업년도</option>
                            <option value="TAVE">학 점</option>
                            <option value="TOEIC">토 익</option>
                            <option value="UMAJOR">전 공</option>
                            <option value="AWDYN">보훈대상</option>
                            <option value="LICENCE">자격증</option>
                            <option value="MILYN">병역</option>
						</select>
                    </td>
					<td align="center" class="creamBold">시작일</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtSTR_YMD.disabled == true){ return; } calendarBtn('datetype1','txtSTR_YMD','','180','100');"></a>
					</td>
					<td align="center" class="creamBold">폐기일</td>
					<td class="padding2423">
						<input id="txtEND_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }" style="ime-mode:disabled"> 
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','340','100');"></a>
					</td>
                    <td align="center" class="creamBold">적용항목</td>
					<td class="padding2423" colspan="3">
                        <select id="cmbWORK_GBN" style="WIDTH: 100%" onChange="fnc_ChangeWrkGbn()">
						</select>
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">기준점</td>
					<td class="padding2423"><input id="txtBASE_CNT" size="10" maxLength="5" onkeypress="cfCheckNumber3();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">기 준</td>
					<td class="padding2423">
                        <select id="cmbBASE_CD" style="WIDTH: 100%" onchange="fnc_ChangeBaseCd()">
                        </select>
                    </td>
                    <td align="center" class="creamBold">환산만점</td>
					<td class="padding2423"><input id="txtFULL_CNT" size="10" maxLength="3" onkeypress="cfCheckNumber3();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">구 분</td>
					<td class="padding2423">
                        <select id="cmbTHAN_TAG" style="WIDTH: 100%">
							<option value=""></option>
							<option value="1">이 상</option>
							<option value="2">초 과</option>
                            <option value="3">이 하</option>
                            <option value="4">미 만</option>
						</select>
                    </td>
					<td align="center" class="creamBold">가산점</td>
					<td class="padding2423"><input id="txtADD_CNT" size="4" maxLength="3" onkeypress="cfCheckNumber();" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_RC_JUDGESTD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_RC_JUDGESTD">
							<param name="Format"					value="
								<C> id={currow}		width=39    name='NO'			align=center </C>
								<C> id='CD_GBN'		width=70	name='기준항목'		align=left Value={Decode(CD_GBN,'UGRDYN','학력','UYMD','졸업년도','TAVE','학점','TOEIC','토익','UMAJOR','전공','AWDYN','보훈대상','LICENCE','자격증','MILYN','병역')}</C>
								<C> id='STR_YMD'	width=70	name='시작일'		align=center </C>
								<C> id='END_YMD'	width=70	name='종료일'		align=center </C>
                                <C> id='WORK_GBN'	width=70	name='적용항목'		align=center Value={DECODE(WORK_GBN,1,'배 제',2,'환산점',3,'가산점')}</C>
								<C> id='BASE_CNT'	width=70	name='기준점'		align=center </C>
                                <C> id='BASE_CD'    width=180	name='기준코드명'		align=center EditStyle=Lookup Data='dsCOMM_CODE:CODE:CODE_NAME'</C>
                                <C> id='FULL_CNT'	width=65	name='환산만점'		align=right </C>
                                <C> id='THAN_TAG'	width=65	name='구분'		    align=center Value={DECODE(THAN_TAG,1,'이 상',2,'초 과',3,'이 하',4,'미 만')}</C>
								<C> id='ADD_CNT'	width=65	name='가산점'		align=right </C>
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
<!-- 서류심사기준관리 테이블 -->
<object id="bndT_RC_JUDGESTD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_JUDGESTD">
	<Param Name="BindInfo", Value='
		<C>Col=CD_GBN		Ctrl=cmbCD_GBN	      	Param=value		</C>
		<C>Col=STR_YMD		Ctrl=txtSTR_YMD      	Param=value		</C>
		<C>Col=END_YMD		Ctrl=txtEND_YMD	      	Param=value		</C>
		<C>Col=BASE_CNT		Ctrl=txtBASE_CNT     	Param=value		</C>
        <C>Col=FULL_CNT		Ctrl=txtFULL_CNT     	Param=value		</C>
        <C>Col=THAN_TAG		Ctrl=cmbTHAN_TAG     	Param=value		</C>
		<C>Col=ADD_CNT		Ctrl=txtADD_CNT	     	Param=value		</C>
    '>
</object>