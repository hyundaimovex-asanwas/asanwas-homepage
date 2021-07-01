<!--
*****************************************************
* @source      : insc020.jsp
* @description : 복리후생/산재보험/산업재해발생관리
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/13      조정호                   최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>산업재해발생관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">

    <!--*****************************
    *  CSS 선언  *
    *****************************-->
    <style type="text/css">
    .header {
        padding: 1px;
        background-color: #f7dcbb;
        text-align: center;
    }
    .content {
        padding: 1px;
        padding-right : 6px;
        background-color: #ffffff;
        text-align: right;
    }
    .content2 {
        padding: 1px;
        background-color: #ffffff;
        text-align: center;
    }
    </style>


<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<script language="javascript" src="/common/dateformat.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
        //단축키 순서
        var btnList = "T"   //조회
                    + "T"   //신규
                    + "T"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "T"   //삭제
                    + "T";  //닫기
        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc020.cmd.INSC020CMD";
        var params = null;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //검색조건
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oFROM_YMD   = document.getElementById("txtFROM_YMD_SHR");
            var oTO_YMD     = document.getElementById("txtTO_YMD_SHR");

            if(oFROM_YMD.value == "" ){
                alert("대상년월을 입력하십시오.");
                oFROM_YMD.focus();
                return;
            }
            
            if(oTO_YMD.value == "" ){
                alert("대상년월을 입력하십시오.");
                oTO_YMD.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&FROM_YMD="+oFROM_YMD.value
                   + "&TO_YMD="+oTO_YMD.value;

            dsT_IS_ACCIDENT.dataid = dataClassName+params;
            dsT_IS_ACCIDENT.reset();
        }
        
        /**
         * 평균임금 산정내역을 조회한다.
         */
        function fnc_SearchPay() {
            //검색조건
            var oENO_NO         = document.getElementById("txtENO_NO");

            if(oENO_NO.value == "") {
                return;
            }

            params = "&S_MODE=SHR"
                   + "&ENO_NO="+oENO_NO.value
                   + "&YMD="+getToday();

            //초기화 시키기
            dsT_CP_PAYMASTER.ClearData();
            dsT_CP_CHANGE_FIELD.ClearData();
            dsT_CP_CHANGE1.ClearData();
            dsT_CP_CHANGE2.ClearData();
            dsT_CP_CHANGE3.ClearData();
            dsT_CP_CHANGE4.ClearData();
            dsT_CP_PAYMASTER_BONUS.ClearData();
            dsT_CP_YEARLYBONUS.ClearData();

            //리턴받을 DataSet 설정
            trT_CP_PAYMASTER.KeyValue = "tr02"
                                   + "(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER"         //산정내역
                                   + ",O:dsT_CP_CHANGE_FIELD=dsT_CP_CHANGE_FIELD"   //기타수당 항목
                                   + ",O:dsT_CP_CHANGE1=dsT_CP_CHANGE1"             //기타수당1
                                   + ",O:dsT_CP_CHANGE2=dsT_CP_CHANGE2"             //기타수당2
                                   + ",O:dsT_CP_CHANGE3=dsT_CP_CHANGE3"             //기타수당3
                                   + ",O:dsT_CP_CHANGE4=dsT_CP_CHANGE4"             //기타수당4
                                   + ",O:dsT_CP_PAYMASTER_BONUS=dsT_CP_PAYMASTER_BONUS"//상여금
                                   + ",O:dsT_CP_YEARLYBONUS=dsT_CP_YEARLYBONUS"     //연월차수당
                                   + ")";
            trT_CP_PAYMASTER.action = "/servlet/GauceChannelSVL?cmd=hr.ins.c.insc010.cmd.INSC010CMD"+params;
            trT_CP_PAYMASTER.post();
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
            //값 유효성 검증
            if(!fnc_SaveItemCheck()) return;

            trT_IS_ACCIDENT.KeyValue = "tr01(I:dsT_IS_ACCIDENT=dsT_IS_ACCIDENT)";
            trT_IS_ACCIDENT.action = dataClassName+"&S_MODE=SAV";
            trT_IS_ACCIDENT.post();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_IS_ACCIDENT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("성립번호 [" + dsT_IS_ACCIDENT.ColumnString(dsT_IS_ACCIDENT.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_IS_ACCIDENT.DeleteRow(dsT_IS_ACCIDENT.RowPosition);

            trT_IS_ACCIDENT.KeyValue = "SVL(I:dsT_IS_ACCIDENT=dsT_IS_ACCIDENT)";
            trT_IS_ACCIDENT.Action = dataClassName+"&S_MODE=DEL";
            trT_IS_ACCIDENT.post();
        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //검색조건
            var YMD = document.getElementById("txtFROM_YMD_SHR");

            if(YMD.value == "" ){
                alert("대상년월을 입력하십시오.");
                YMD.focus();
                return;
            }
			var url = "insc020_PV.jsp?STR_YMD="+YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_IS_ACCIDENT.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_IS_ACCIDENT.GridToExcel("개인연금관리", '', 225);
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 Header 정의
            if (dsT_IS_ACCIDENT.CountColumn == 0) {
                dsT_IS_ACCIDENT.setDataHeader("REQ_NO:STRING,  ENO_NO:STRING,  ENO_NM:STRING,  DPT_CD:STRING,  DPT_NM:STRING,  JOB_CD:STRING,  JOB_NM:STRING,  CET_NO:STRING,  HIRG_YMD:STRING,  SAN_YMD:STRING,  SAN_NAM:STRING,  SAN_REM:STRING,  HDC_GRA:STRING,  HDC_CD:STRING,  HDC_NM:STRING,  MED_AMT:INT,  HDC_AMT:INT,  SUR_AMT:INT,  STR_YMD:STRING,  END_YMD:STRING,  TMR_DD:STRING,  SAL_AMT:INT,  AVG_AMT:INT,  DAY_AMT:INT,  REC_AMT:INT,  REMARK:STRING");
            }            

            dsT_IS_ACCIDENT.AddRow();
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
            dsT_IS_ACCIDENT.ClearData();
            fnc_ClearInputElement(elementList);

            document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
            if (dsT_IS_ACCIDENT.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
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

            if (!dsT_IS_ACCIDENT.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_IS_ACCIDENT,15,"false","false")      // Grid Style 적용

            var oSelect = null;
            var oOption = null;

            // 장해 유형 콤보박스 생성
            fnc_BindingCommonCode(document.getElementById("dsT_CM_COMMON_C6"), "cmbHDC_CD");
            
            // 장해 등급 콤보박스 생성
            oSelect = document.getElementById("cmbHDC_GRA");
            oSelect.options.length = 0;
            for( i= 0; i<=10; i++) {
                oOption       = document.createElement("OPTION");
                if(i == 0) {
                    oOption.value = "";
                    oOption.text  = "선택하세요";
                } else {
                    oOption.value = i;
                    oOption.text  = i;
                }
                oSelect.add(oOption);
            }

            //처음에는 사용하지 못하게 disable 시킨다.
            fnc_DisableElementAll(elementList);
            fnc_DisableElementAll(btnElementList);
            
            //값들 초기화
            document.getElementById("txtFROM_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtTO_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /********************
         *     기타 함수            *
         *******************/

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup('txtENO_NO');

            fnc_GetUserInfo();
        }

        /**
         * 유저정보를 가져옵시다.
         */
        function fnc_GetUserInfo() {
            var obj = fnc_GetEnoNm("txtENO_NO");

            document.getElementById("txtENO_NO").value = obj.eno_no;
            document.getElementById("txtENO_NM").value = obj.eno_nm;
            document.getElementById("txtJOB_NM").value = obj.job_nm;
            document.getElementById("txtDPT_NM").value = obj.dpt_nm;
            document.getElementById("txtHIRG_YMD").value = obj.hirg_ymd;
            document.getElementById("txtCET_NO").value = obj.cet_no;
        }
        
        var oElement = null;
        var oElementMsg = null;
        //지금 정의되어 있는 항목들
        var elementList = new Array(    "txtREQ_NO"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"txtSAN_YMD"
                                        ,"txtSAN_NAM"
                                        ,"txtSAN_REM"
                                        ,"cmbHDC_GRA"
                                        ,"cmbHDC_CD"
                                        ,"medMED_AMT"
                                        ,"medHDC_AMT"
                                        ,"medSUR_AMT"
                                        ,"txtSTR_YMD"
                                        ,"txtEND_YMD"
                                        ,"txtTMR_DD"
                                        ,"medSAL_AMT"
                                        ,"medREC_AMT"
                                        ,"txtREMARK"
                                        );

        //항목들의 메세지
        var elementListMsg = new Array(  "성립번호"
                                        ,"사번"
                                        ,"성명"
                                        ,"발생일자"
                                        ,"상병명"
                                        ,"사유"
                                        ,"장해등급"
                                        ,"장해유형"
                                        ,"요양급여"
                                        ,"장해급여"
                                        ,"유족급여"
                                        ,"청구기간시작"
                                        ,"청구기간끝"
                                        ,"휴직일수"
                                        ,"당사지급급여"
                                        ,"수령액"
                                        ,"비고"
                                        );

        //예외 사항
        var exceptionList = new Array(   "txtREQ_NO"
                                        ,"txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"txtSAN_YMD"
                                        );
                                        
        var btnElementList = new Array(  "ImgEnoNo"
                                        ,"ImgSAN_YMD"
                                        ,"ImgSTR_YMD"
                                        ,"ImgEND_YMD"
                                        );
                                
        var btnExceptionList = new Array( "ImgEnoNo"
                                         ,"ImgSAN_YMD"
                                         );

        //검색창의 검색 조건 항목들
        var oSearchElementList = new Array(
                                         "txtFROM_YMD_SHR"
                                        ,"txtTO_YMD_SHR"
                                        ,"txtENO_NO_SHR"
                                        ,"txtENO_NM_SHR");

        
        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");
            
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
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        } 
         
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO");
            if(document.getElementById("txtENO_NO").value != "") {
            
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("txtCET_NO").value      = obj.cet_no;
                document.getElementById("txtHIRG_YMD").value    = obj.hirg_ymd;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
                document.getElementById("txtCET_NO").value      = "";
                document.getElementById("txtHIRG_YMD").value    = "";
            }     
            
            //사번이 변경될때 마다 총 평균임금 내역 조회
            fnc_SearchPay();
        }   
        
        /**
         * 총임금액을 기준으로 평균임금, 휴업급여청구 내역을 가지고 온다.
         */
        function fnc_BindingAmt() {
            var sal_amt = fnc_covNumber(document.getElementById("medSAL_AMT").Text);
            var oAvg_amt = document.getElementById("medAVG_AMT");
            var oDay_amt = document.getElementById("medDAY_AMT");
            var tmr_dd  = fnc_covNumber(document.getElementById("txtTMR_DD").value);

            oAvg_amt.Text = sal_amt/tmr_dd;
            oDay_amt.Text = fnc_covNumber(oAvg_amt.Text) * 0.7;
        }       
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_IS_ACCIDENT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_IS_ACCIDENT                       |
    | 3. Table List : T_IS_ACCIDENT                 |
    +----------------------------------------------->
    <Object ID="dsT_IS_ACCIDENT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 총임금액을 가지고 오기 위해 정의된 DS,TR insc010 로직 활용 -->
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>
        
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE_FIELD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_CHANGE4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_PAYMASTER_BONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_YEARLYBONUS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    <!-- 총임금액을 가지고 오기 위해 정의된 DS,TR insc010 로직 활용 -->

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet - 예금종류                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_C6"/>
       <jsp:param name="CODE_GUBUN"    value="C6"/>
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
    <Script For=dsT_IS_ACCIDENT Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_IS_ACCIDENT Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_IS_ACCIDENT Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_IS_ACCIDENT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!-- 총 평균임금을 산정해 온다. -->
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
        var sal_amt = 0;
        sal_amt += dsT_CP_PAYMASTER.NameSum("BAS_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("DUTY_AMT" ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("OT_AMT"   ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("WEL_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("OSE_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("RUN_AMT"  ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("MH_AMT"   ,0, 0);
        sal_amt += dsT_CP_PAYMASTER.NameSum("LSEV_AMT" ,0, 0);    
        
        sal_amt += dsT_CP_CHANGE1.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE2.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE3.NameSum("AMOUNT"  ,0 ,0);
        sal_amt += dsT_CP_CHANGE4.NameSum("AMOUNT"  ,0 ,0);
        
        document.getElementById("medSAL_AMT").Text = sal_amt;
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_IS_ACCIDENT event="OnFail()">
        cfErrorMsg(this);
    </script>
    

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리                |
    +------------------------------------------------------>           
    <script language=JavaScript for=dsT_IS_ACCIDENT event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(dsT_IS_ACCIDENT.RowStatus(row) == "1") {
            fnc_EnableElementAll(elementList);
            fnc_EnableElementAll(btnElementList);
        } else {
            fnc_EnableElementAll(elementList, exceptionList);
            fnc_EnableElementAll(btnElementList, btnExceptionList);
        }
    </script>    
    
     <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |
    +--------------------------->
    <script for=dsT_IS_ACCIDENT event=CanRowPosChange(row)>
        var oElementName;
        var oElementMsg;
        var oElementValue;
        var saveStatus;
        
        //ds 입력 타입이 insert 인지 update인지를 구분함
        //1:Insert
        //3:Update
        saveStatus = dsT_IS_ACCIDENT.RowStatus(row);                   
    

        for(var i=0; i<elementList.length; i++) {
        
            oElementName    = elementList[i].substring(3);
            oElementMsg     = elementListMsg[i];
            oElementValue   = dsT_IS_ACCIDENT.NameString(row, oElementName);
            
            //입력상태가 insert일 경우 '당사지급급여(txtSAL_AMT)'는 무시
            if(saveStatus == 1 && (oElementName == "SAL_AMT" || oElementName == "REC_AMT")) continue;      
            
            //장해등급과 장해유형은 선택 입력
            if(oElementName == "HDC_GRA" || oElementName == "HDC_CD") continue;            
            
            if(oElementValue == "") {
                alert("[ " + oElementMsg + " ]의 값이 비어 있습니다.");
                document.getElementById(elementList[i]).focus();
                return false;
            }
        }
        
    </script>    
    
    
    <script language=JavaScript for=medSAL_AMT event=onKillFocus()>
        fnc_BindingAmt();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">산업재해발생관리</td>
					<td align="right" class="navigator">HOME/복리후생/산재보험/<font color="#000000">산업재해발생관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                <col width="110"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">발생년월</td>
                                <td class="padding2423" colspan="5">
                                    <input type="text" id="txtFROM_YMD_SHR" name="txtFROM_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtFROM_YMD_SHR','','125','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                    ~
                                    <input type="text" id="txtTO_YMD_SHR" name="txtTO_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtTO_YMD_SHR','','125','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">사 번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">

<!-- 계약사항 -->
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>

                <tr>
                    <td class="creamBold" align="center">대&nbsp;&nbsp;&nbsp;상</td>
                    
                    
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" maxlength="12" style= "width:70%"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        
                        <input type="hidden" name="txtJOB_NM" id="txtJOB_NM">
                        <input type="hidden" name="txtCET_NO" id="txtCET_NO">
                        <input type="hidden" name="txtHIRG_YMD" id="txtHIRG_YMD">                        
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" maxlength="12" style= "width:70%"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>  

                    <td class="creamBold" align="center">소&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input type="text" id="txtDPT_NM" name="txtDPT_NM" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center" rowspan="2">재해발생</td>
                    <td class="creamBold" align="center">발생일시</td>
                    <td class="padding2423">
                        <input type="text" id="txtSAN_YMD" name="txtSAN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgSAN_YMD" id="ImgSAN_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSAN_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSAN_YMD','','160','205');" style="cursor:hand;">
                    </td>
                    <td class="creamBold" align="center">상병명</td>
                    <td class="padding2423">
                        <input type="text" id="txtSAN_NAM" name="txtSAN_NAM" size="20" maxlength="30">
                    </td>
                    <td class="creamBold" align="center">성립번호</td>
                    <td class="padding2423">
                        <input type="text" id="txtREQ_NO" name="txtREQ_NO" size="10" maxlength="11" style="ime-mode:disabled">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">사&nbsp;&nbsp;유</td>
                    <td class="padding2423" colspan="3">
                        <input type="text" id="txtSAN_REM" name="txtSAN_REM" size="60" maxlength="30">
                    </td>
                    <td class="creamBold" align="center">휴직일수</td>
                    <td class="padding2423">
                        <input type="text" id="txtTMR_DD" name="txtTMR_DD" size="10" maxlength="9" value="0" style="text-align:right" style="ime-mode:disabled"  onkeypress="cfCheckNumber();" onchange="fnc_BindingAmt()">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">장&nbsp;&nbsp;해</td>
                    <td class="creamBold" align="center">등&nbsp;&nbsp;급</td>
                    <td class="padding2423">
                        <select name="cmbHDC_GRA" id="cmbHDC_GRA"></select>
                    </td>
                    <td class="creamBold" align="center">유&nbsp;&nbsp;형</td>
                    <td class="padding2423" colspan="3">
                        <select name="cmbHDC_CD" id="cmbHDC_CD">
                            <option value="">선택하세요</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">산재급여</td>
                    <td class="creamBold" align="center">요양급여</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medMED_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>      
                    </td>
                    <td class="creamBold" align="center">장해급여</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medHDC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                          
                    </td>
                    <td class="creamBold" align="center">유족급여</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSUR_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                       
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center" rowspan="2">휴업급여</td>
                    <td class="creamBold" align="center">청구기간</td>
                    <td class="padding2423" colspan="5">
                        <input type="text" id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgSTR_YMD" id="ImgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD','','160','305');" style="cursor:hand;">
                        &nbsp;~&nbsp;
                        <input type="text" id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="ImgEND_YMD" id="ImgEND_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEND_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD','','285','305');" style="cursor:hand;">
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">비고</td>
                    <td class="padding2423" colspan="5">
                        <input type="text" id="txtREMARK" name="txtREMARK" size="60" maxlength="30">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center" rowspan="2">비&nbsp;&nbsp;&nbsp;용</td>
                    <td class="creamBold" align="center">총임금액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                                           
                    </td>
                    <td class="creamBold" align="center">평균임금</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medAVG_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px" class="input_ReadOnly" readonly>
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>    
                    </td>
                    <td class="creamBold" align="center">휴업급여청구</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medDAY_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px" class="input_ReadOnly" readonly>
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                       
                    </td>
                <tr>
                    <td class="creamBold" align="center">수령액</td>
                    <td class="padding2423" colspan="5">
                        <comment id="__NSID__"><object id="medREC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_IS_ACCIDENT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_IS_ACCIDENT">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=REQ_NO       width=80        align=center        name=성립번호               </C>
                                <C> id=ENO_NO       width=80        align=center        name=직번                   </C>
                                <C> id=ENO_NM       width=80        align=center        name=성명                   </C>
                                <C> id=DPT_NM       width=80        align=center        name=소속                   </C>
                                <C> id=JOB_NM       width=80        align=center        name=직위                   </C>
                                <C> id=CET_NO       width=80        align=center        name=주민등록번호          </C>
                                <C> id=HIRG_YMD     width=80        align=center        name=입사일                   </C>
                                <C> id=SAN_YMD      width=80        align=center        name=재해발생일시           </C>
                                <C> id=SAN_NAM      width=80        align=center        name=상병명                 </C>
                                <C> id=SAN_REM      width=80        align=center        name=사유                   </C>
                                <C> id=HDC_GRA      width=80        align=center        name=장해등급               </C>
                                <C> id=HDC_CD       width=80        align=center        name=장해유형코드          value={Decode(HDC_CD,'1','지체장애인','2','시각장애인','3','청각장애인','4','언어장애인','5','정신지체인')} </C>
                                <C> id=MED_AMT      width=80        align=center        name=요양급여               </C>
                                <C> id=HDC_AMT      width=80        align=center        name=장해급여               </C>
                                <C> id=SUR_AMT      width=80        align=center        name=유족급여               </C>
                                <C> id=STR_YMD      width=80        align=center        name=청구기간  시작           </C>
                                <C> id=END_YMD      width=80        align=center        name=청구기간  끝                       </C>
                                <C> id=TMR_DD       width=80        align=center        name=휴직일수               </C>
                                <C> id=SAL_AMT      width=80        align=center        name=당사지급급여           </C>
                                <C> id=AVG_AMT      width=80        align=center        name=평균임금/일            </C>
                                <C> id=DAY_AMT      width=80        align=center        name=휴업급여청구           </C>
                                <C> id=REC_AMT      width=80        align=center        name=수령액                 </C>
                                <C> id=REMARK       width=80        align=center        name=비고                   </C>

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
    *                                                                                        *
    *   바인딩 컴포넌트                                                                             *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_IS_ACCIDENT 설정 테이블 -->
    <object id="bndT_IS_ACCIDENT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_IS_ACCIDENT">
        <Param Name="BindInfo", Value="
            <C>Col=ENO_NO           Ctrl=txtENO_NO          Param=value</C>
            <C>Col=ENO_NM           Ctrl=txtENO_NM          Param=value</C>
            <C>Col=DPT_NM           Ctrl=txtDPT_NM          Param=value</C>
            <C>Col=JOB_NM           Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=CET_NO           Ctrl=txtCET_NO          Param=value</C>
            <C>Col=HIRG_YMD         Ctrl=txtHIRG_YMD        Param=value</C>
            <C>Col=SAN_YMD          Ctrl=txtSAN_YMD         Param=value</C>
            <C>Col=SAN_NAM          Ctrl=txtSAN_NAM         Param=value</C>
            <C>Col=REQ_NO           Ctrl=txtREQ_NO          Param=value</C>
            <C>Col=SAN_REM          Ctrl=txtSAN_REM         Param=value</C>
            <C>Col=TMR_DD           Ctrl=txtTMR_DD          Param=value</C>
            <C>Col=HDC_GRA          Ctrl=cmbHDC_GRA         Param=value</C>
            <C>Col=HDC_CD           Ctrl=cmbHDC_CD          Param=value</C>
            <C>Col=MED_AMT          Ctrl=medMED_AMT         Param=text </C>
            <C>Col=HDC_AMT          Ctrl=medHDC_AMT         Param=text </C>
            <C>Col=SUR_AMT          Ctrl=medSUR_AMT         Param=text </C>
            <C>Col=STR_YMD          Ctrl=txtSTR_YMD         Param=value</C>
            <C>Col=END_YMD          Ctrl=txtEND_YMD         Param=value</C>
            <C>Col=REMARK           Ctrl=txtREMARK          Param=value</C>
            <C>Col=SAL_AMT          Ctrl=medSAL_AMT         Param=text </C>
            <C>Col=REC_AMT          Ctrl=medREC_AMT         Param=text </C>
            <C>Col=AVG_AMT          Ctrl=medAVG_AMT         Param=text </C>
            <C>Col=DAY_AMT          Ctrl=medDAY_AMT         Param=text </C>
        ">
    </object>