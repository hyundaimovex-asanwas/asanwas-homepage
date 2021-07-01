<!--
    ************************************************************************************
    * @Source         : eduh091.jsp                                                    *
    * @Description    : 고용보험관리_신규등록 PAGE                                     *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/08  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>고용보험관리_신규등록(eduh091)</title>
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
    
        var btnList = 'FFTFFFFT';
        
        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_INSURANCE.ClearData();
            
            dsT_ED_INSURANCE.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh091.cmd.EDUH091CMD&S_MODE=SHR_01&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no;
            dsT_ED_INSURANCE.Reset();
            
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

            if (!fnc_SaveItemCheck()) {
                return;
            }
            
            trT_ED_INSURANCE.KeyValue = "tr01(I:SAV=dsT_ED_INSURANCE)";
            trT_ED_INSURANCE.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh091.cmd.EDUH091CMD&S_MODE=SAV";
            trT_ED_INSURANCE.post();
            
            
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
            
            if (!dsT_ED_INSURANCE.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
            
            if ( dsT_ED_INSURANCE.isUpdated) {
                for( i = 1; i <= dsT_ED_INSURANCE.CountRow; i++ ) {
                    if( dsT_ED_INSURANCE.RowStatus(i) == 1 || 
                        dsT_ED_INSURANCE.RowStatus(i) == 3 ) {
                        
                        // 과정코드
                        if( dsT_ED_INSURANCE.NameValue(i, "EDU_CD") == '' ) {
                            alert("과정코드는 필수 입력사항입니다.");
                            document.getElementById("txtEDU_CD").focus();
                            return false;
                        }
                        
                        // 과정코드 CHECK
                        if (dsT_ED_INSURANCE.NameValue(i, "EDU_CD") != "" &&
                            dsT_ED_INSURANCE.NameValue(i, "EDU_NM") == "") {
                            alert("과정코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                            dsT_ED_INSURANCE.RowPosition = i;
                            document.getElementById("txtEDU_CD").focus();
                            return;
                        }
                        
                        // 차수
                        if( dsT_ED_INSURANCE.NameValue(i, "CHASU_TAG") == '' ) {
                            alert("차수는 필수 입력사항입니다.");
                            document.getElementById("txtCHASU_TAG").focus();
                            return false;
                        }       
                        
                        // 요청일자 CHECK
                        if (!fnc_CheckDate2(dsT_ED_INSURANCE.NameValue(i, "RTN_RQST_YMD"), "요청일자") && dsT_ED_INSURANCE.NameValue(i, "RTN_RQST_YMD") != "") {
                            dsT_ED_INSURANCE.RowPosition = i;
                            document.getElementById("txtRTN_RQST_YMD").focus();
                            return false;
                        }
                        
                        // 실행일자 CHECK
                        if (!fnc_CheckDate2(dsT_ED_INSURANCE.NameValue(i, "RTN_EXEC_YMD"), "실행일자") && dsT_ED_INSURANCE.NameValue(i, "RTN_EXEC_YMD") != "") {
                            dsT_ED_INSURANCE.RowPosition = i;
                            document.getElementById("txtRTN_EXEC_YMD").focus();
                            return false;
                        }                 
            
                        // 요청일자와 실행일자 비교
                        if(dsT_ED_INSURANCE.NameValue(i, "RTN_RQST_YMD") != '' && dsT_ED_INSURANCE.NameValue(i, "RTN_EXEC_YMD") != '') {
                            if(removeChar(dsT_ED_INSURANCE.NameValue(i, "RTN_RQST_YMD"),'-') > removeChar(dsT_ED_INSURANCE.NameValue(i, "RTN_EXEC_YMD"),'-')) {
                                alert("실행일자는 반드시 요청일자보다 커야합니다.");
                                document.getElementById("txtRTN_EXEC_YMD").focus();
                                return false;
                            }
                        }
                        
                    }
                }
            }            

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_ComboSet();            

            // 구분이 수정이면
            if (opener.gbn == "2") {

                document.getElementById('txtEDU_CD').value = opener.edu_cd;
                document.getElementById('txtSEQ_NO').value = opener.seq_no;
                
                // 공지사항 데이터 조회
                fnc_SearchList();
            }
            else {
            
                fnc_ColEnabled('E');
                
                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_INSURANCE.CountColumn == 0) {
                    dsT_ED_INSURANCE.setDataHeader("EDU_CD:STRING:KEYVALUETYPE, SEQ_NO:STRING:KEYVALUETYPE, EDU_NM:STRING, CHASU_TAG:STRING, ENO_NO:STRING, ENO_NM:STRING, EDU_GBN_CD:STRING, MNGER_CD:STRING, FIELD_CD:STRING, SHAPE_CD:STRING, PLACE_TAG:STRING, EDU_STR_YMD:STRING, EDU_END_YMD:STRING, TIME_NO:INT, FIX_NO:INT, REQ_NO:INT, OBJ_NO:INT, PAS_NO:INT, ESATIS_TAG:INT, LSATIS_TAG:INT, EDU_TAG:STRING, BUDGET_AMT:INT, EXPENSE_AMT:INT, INS_YN:STRING, RTN_EXPT_AMT:INT, INS_E_AMT:INT, EDUCODE_TAG:STRING, INS_TIME:INT, P_EDU_AMT:INT, TBL_UNIT_AMT:INT, APRV_BL_AMT:INT, P_AID_AMT:INT, RTN_RQST_AMT:INT, RTN_RQST_YMD:STRING, RTN_EXEC_YMD:STRING, BLCTRI_AMT:INT, BLCTRO_AMT:INT, BBOOK_AMT:INT, BSTAT_AMT:INT, BDRINK_AMT:INT, BDVLP_AMT:INT, BPLAC_AMT:INT, BBUS_AMT:INT, BLODG_AMT:INT, BMEAL_AMT:INT, BCOMT_AMT:INT, BETC_AMT:INT, ELCTRI_AMT:INT, ELCTRO_AMT:INT, EBOOK_AMT:INT, ESTAT_AMT:INT, EDRINK_AMT:INT, EDVLP_AMT:INT, EPLAC_AMT:INT, EBUS_AMT:INT, ELODG_AMT:INT, EMEAL_AMT:INT, ECOMT_AMT:INT, EETC_AMT:INT");
                }
                
                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_INSURANCE.AddRow();
                
                document.getElementById('txtEDU_CD').focus();
                
            }
            
        }
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_ED_INSURANCE.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }
            
            window.close();
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        
        /********************
         * 콤보박스 값 SET  *
         ********************/
        function fnc_ComboSet() {
            var oOption = null;        

            //교육구분
            for( var i = 1; i <= dsCOMMON_Q6.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q6.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q6.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEDU_GBN_CD").add(oOption);
                
            }
            
            //교육주관
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD").add(oOption);
                
            }
            
            //교육분야
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD").add(oOption);
                
            }
            
            //교육형태
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD").add(oOption);
                
            }
            
            //고용보험
            for( var i = 1; i <= dsCOMMON_QA.CountRow; i++ ) {
                
                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QA.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QA.NameValue(i,"CODE_NAME");
                document.getElementById("cmbINS_YN").add(oOption);
                
            }
            
        }

        
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtEDU_CD").disabled       = false;
                document.getElementById("txtCHASU_TAG").disabled    = false;
                document.getElementById("txtESATIS_TAG").disabled   = false;
                document.getElementById("txtLSATIS_TAG").disabled   = false;
                document.getElementById("txtEDU_TAG").disabled      = false;
                form1.medBUDGET_AMT.enable                          = true;
                form1.medEXPENSE_AMT.enable                         = true;
                form1.medRTN_EXPT_AMT.enable                        = true;
                form1.medINS_E_AMT.enable                           = true;
                document.getElementById("txtEDUCODE_TAG").disabled  = false;
                document.getElementById("txtINS_TIME").disabled     = false;
                form1.medP_EDU_AMT.enable                           = true;
                form1.medTBL_UNIT_AMT.enable                        = true;
                form1.medAPRV_BL_AMT.enable                         = true;
                form1.medP_AID_AMT.enable                           = true;
                form1.medRTN_RQST_AMT.enable                        = true;
                document.getElementById("txtRTN_RQST_YMD").disabled = false;
                document.getElementById("txtRTN_EXEC_YMD").disabled = false;
                form1.medBLCTRI_AMT.enable                          = true;
                form1.medBLCTRO_AMT.enable                          = true;
                form1.medBBOOK_AMT.enable                           = true;
                form1.medBSTAT_AMT.enable                           = true;
                form1.medBDRINK_AMT.enable                          = true;
                form1.medBDVLP_AMT.enable                           = true;
                form1.medBPLAC_AMT.enable                           = true;
                form1.medBBUS_AMT.enable                            = true;
                form1.medBLODG_AMT.enable                           = true;
                form1.medBMEAL_AMT.enable                           = true;
                form1.medBCOMT_AMT.enable                           = true;
                form1.medBETC_AMT.enable                            = true;
                form1.medELCTRI_AMT.enable                          = true;
                form1.medELCTRO_AMT.enable                          = true;
                form1.medEBOOK_AMT.enable                           = true;
                form1.medESTAT_AMT.enable                           = true;
                form1.medEDRINK_AMT.enable                          = true;
                form1.medEDVLP_AMT.enable                           = true;
                form1.medEPLAC_AMT.enable                           = true;
                form1.medEBUS_AMT.enable                            = true;
                form1.medELODG_AMT.enable                           = true;
                form1.medEMEAL_AMT.enable                           = true;
                form1.medECOMT_AMT.enable                           = true;
                form1.medEETC_AMT.enable                            = true;
                
                document.getElementById("ImgEduCd").disabled        = false;
                document.getElementById("ImgRtnRqstYmd").disabled   = false;
                document.getElementById("ImgRtnExecYmd").disabled   = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtEDU_CD").disabled       = true;
                document.getElementById("txtCHASU_TAG").disabled    = true;
                document.getElementById("txtESATIS_TAG").disabled   = true;
                document.getElementById("txtLSATIS_TAG").disabled   = true;
                document.getElementById("txtEDU_TAG").disabled      = true;
                form1.medBUDGET_AMT.enable                          = false;
                form1.medEXPENSE_AMT.enable                         = false;
                form1.medRTN_EXPT_AMT.enable                        = false;
                form1.medINS_E_AMT.enable                           = false;
                document.getElementById("txtEDUCODE_TAG").disabled  = true;
                document.getElementById("txtINS_TIME").disabled     = true;
                form1.medP_EDU_AMT.enable                           = false;
                form1.medTBL_UNIT_AMT.enable                        = false;
                form1.medAPRV_BL_AMT.enable                         = false;
                form1.medP_AID_AMT.enable                           = false;
                form1.medRTN_RQST_AMT.enable                        = false;
                document.getElementById("txtRTN_RQST_YMD").disabled = true;
                document.getElementById("txtRTN_EXEC_YMD").disabled = true;
                form1.medBLCTRI_AMT.enable                          = false;
                form1.medBLCTRO_AMT.enable                          = false;
                form1.medBBOOK_AMT.enable                           = false;
                form1.medBSTAT_AMT.enable                           = false;
                form1.medBDRINK_AMT.enable                          = false;
                form1.medBDVLP_AMT.enable                           = false;
                form1.medBPLAC_AMT.enable                           = false;
                form1.medBBUS_AMT.enable                            = false;
                form1.medBLODG_AMT.enable                           = false;
                form1.medBMEAL_AMT.enable                           = false;
                form1.medBCOMT_AMT.enable                           = false;
                form1.medBETC_AMT.enable                            = false;
                form1.medELCTRI_AMT.enable                          = false;
                form1.medELCTRO_AMT.enable                          = false;
                form1.medEBOOK_AMT.enable                           = false;
                form1.medESTAT_AMT.enable                           = false;
                form1.medEDRINK_AMT.enable                          = false;
                form1.medEDVLP_AMT.enable                           = false;
                form1.medEPLAC_AMT.enable                           = false;
                form1.medEBUS_AMT.enable                            = false;
                form1.medELODG_AMT.enable                           = false;
                form1.medEMEAL_AMT.enable                           = false;
                form1.medECOMT_AMT.enable                           = false;
                form1.medEETC_AMT.enable                            = false;
                
                document.getElementById("ImgEduCd").disabled        = true;
                document.getElementById("ImgRtnRqstYmd").disabled   = true;
                document.getElementById("ImgRtnExecYmd").disabled   = true;
                
            }
        }
        
        // 차수 입력시 
        function fnc_ChgChasuTag() {
            var EDU_CD    = document.getElementById("txtEDU_CD").value;
            var CHASU_TAG = document.getElementById("txtCHASU_TAG").value;

            if (document.getElementById("txtCHASU_TAG").value == '') {
                // 관련 내용을 초기화함
                fnc_ResetChasuInfo();
                return;
            }
                
                
            if (document.getElementById("txtEDU_CD").value == '') {
                alert("과정코드를 먼저 입력하여 주십시오.");
                document.getElementById("txtCHASU_TAG").value = '';
                document.getElementById("txtEDU_CD").focus();
                return;
            }
            
            // 과정명/차수에 대한 정보 가져옴
            dsT_ED_COURSELIST.ClearData();
            
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh091.cmd.EDUH091CMD&S_MODE=SHR_02&EDU_CD="+EDU_CD+"&CHASU_TAG="+CHASU_TAG;
            dsT_ED_COURSELIST.Reset();

        }
        
        
        // 과정코드 팝업창 선택시
        function fnc_Popup() {
            var EDU_CD = document.getElementById("txtEDU_CD").value;

            fnc_commonCodePopup('txtEDU_CD','txtEDU_NM','교육과정','Q1');
            
            if (EDU_CD != document.getElementById("txtEDU_CD").value) {
            
                // 관련 내용을 초기화함
                fnc_ResetChasuInfo();
            }
        }
        
        
        function fnc_ResetChasuInfo() {
            // 관련 내용을 초기화함
            document.getElementById("txtCHASU_TAG").value   = '';
            document.getElementById("txtSEQ_NO").value      = '';
            document.getElementById("txtENO_NO").value      = '';
            document.getElementById("txtENO_NM").value      = '';
            document.getElementById("cmbEDU_GBN_CD").value  = '';
            document.getElementById("cmbMNGER_CD").value    = '';
            document.getElementById("cmbFIELD_CD").value    = '';
            document.getElementById("cmbSHAPE_CD").value    = '';
            document.getElementById("txtPLACE_TAG").value   = '';
            document.getElementById("txtEDU_STR_YMD").value = '';
            document.getElementById("txtEDU_END_YMD").value = '';
            document.getElementById("txtTIME_NO").value     = '0';
            document.getElementById("txtFIX_NO").value      = '0';
            document.getElementById("txtREQ_NO").value      = '0';
            document.getElementById("txtOBJ_NO").value      = '0';
            document.getElementById("txtPAS_NO").value      = '0';
            document.getElementById("cmbINS_YN").value      = '';
            form1.medRTN_EXPT_AMT.value                     = '0';
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_INSURANCE)|
    | 3. 사용되는 Table List(T_ED_INSURANCE)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_INSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
   
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_INSURANCE)|
    | 3. 사용되는 Table List(T_ED_INSURANCE)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_INSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_INSURANCE)">
    </Object>
    
    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 교육구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q6"/>
       <jsp:param name="CODE_GUBUN"    value="Q6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 교육주관 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 교육분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>
    
    <!-- 고용보험 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QA"/>
       <jsp:param name="CODE_GUBUN"    value="QA"/>
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
    <Script For=dsT_ED_INSURANCE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_INSURANCE.CountRow );
            
            fnc_ColEnabled('E');

            // 과정코드, 차수는 DISABLE 상태가 됨
            document.getElementById("txtEDU_CD").disabled    = true;
            document.getElementById("txtCHASU_TAG").disabled = true;
            document.getElementById("ImgEduCd").disabled     = true;
                        
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_INSURANCE Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            // 해당 과정/차수에 대한 정보가 없다는 메세지 띄움
            alert("해당 교육과정 또는 교육과정차수에 대한 정보가 미존재합니다.\n확인하시기 바랍니다.");
            
            // 관련내용 초기화
            fnc_ResetChasuInfo();
            
            document.getElementById("txtCHASU_TAG").focus();

        } else {

            if (dsT_ED_COURSELIST.NameValue(1, "CNT") == "0") {
                // 가져온 교육과정/차수의 정보를 해당 컬럼에 SET
                document.getElementById("txtSEQ_NO").value      = dsT_ED_COURSELIST.NameValue(1, "SEQ_NO");
                document.getElementById("txtENO_NO").value      = dsT_ED_COURSELIST.NameValue(1, "ENO_NO");
                document.getElementById("txtENO_NM").value      = dsT_ED_COURSELIST.NameValue(1, "ENO_NM");
                document.getElementById("cmbEDU_GBN_CD").value  = dsT_ED_COURSELIST.NameValue(1, "EDU_GBN_CD");
                document.getElementById("cmbMNGER_CD").value    = dsT_ED_COURSELIST.NameValue(1, "MNGER_CD");
                document.getElementById("cmbFIELD_CD").value    = dsT_ED_COURSELIST.NameValue(1, "FIELD_CD");
                document.getElementById("cmbSHAPE_CD").value    = dsT_ED_COURSELIST.NameValue(1, "SHAPE_CD");
                document.getElementById("txtPLACE_TAG").value   = dsT_ED_COURSELIST.NameValue(1, "PLACE_TAG");
                document.getElementById("txtEDU_STR_YMD").value = dsT_ED_COURSELIST.NameValue(1, "EDU_STR_YMD");
                document.getElementById("txtEDU_END_YMD").value = dsT_ED_COURSELIST.NameValue(1, "EDU_END_YMD");
                document.getElementById("txtTIME_NO").value     = dsT_ED_COURSELIST.NameValue(1, "TIME_NO");
                document.getElementById("txtFIX_NO").value      = dsT_ED_COURSELIST.NameValue(1, "FIX_NO");
                document.getElementById("txtREQ_NO").value      = dsT_ED_COURSELIST.NameValue(1, "REQ_NO");
                document.getElementById("txtOBJ_NO").value      = dsT_ED_COURSELIST.NameValue(1, "OBJ_NO");
                document.getElementById("txtPAS_NO").value      = dsT_ED_COURSELIST.NameValue(1, "PAS_NO");
                document.getElementById("cmbINS_YN").value      = dsT_ED_COURSELIST.NameValue(1, "INS_YN");
                form1.medRTN_EXPT_AMT.value                     = dsT_ED_COURSELIST.NameValue(1, "RTN_EXPT_AMT");
                
                document.getElementById("txtESATIS_TAG").focus();
            }
            else {
                alert("이미 등록된 데이터입니다. 확인하시기 바랍니다.");
                
                // 관련내용 초기화
                fnc_ResetChasuInfo();
                document.getElementById("txtCHASU_TAG").focus();
                
                return;
            }
                        
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        cfErrorMsg(this);
        
    </Script>
    
    
   
    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_INSURANCE event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
        opener.fnc_SearchList();
        
    </script>
    
    <!--트랜젝션 실패 -->
    <script for=trT_ED_INSURANCE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>
    

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고용보험관리_신규등록</td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="105"></col>
                    <col width="130"></col>
                    <col width="100"></col>
                    <col width="130"></col>
                    <col width="100"></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">과정코드</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="5"  maxlength="3" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('Q1', 'txtEDU_CD','txtEDU_NM');"> <input id="txtEDU_NM" name="txtEDU_NM" size="30" class="input_ReadOnly"  readOnly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_Popup()"></a>
                    </td>
                    <td align="center" class="creamBold">차 수 명</td>
                    <td class="padding2423" >
                        <input id="txtCHASU_TAG"  name="txtCHASU_TAG" size="7" maxlength="7" style="ime-mode:disabled" onkeypress="cfDateHyphen(this);cfCheckNumber();" onChange="fnc_ChgChasuTag()">
                        <input type=hidden id="txtSEQ_NO">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">과정담당자</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" size="8" class="input_ReadOnly"  readOnly>  <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">교육구분</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100%"  disabled>
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육주관</td>
                    <td class="padding2423" >
                        <select id="cmbMNGER_CD" style="width:100%"  disabled>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육분야</td>
                    <td class="padding2423" >
                        <select id="cmbFIELD_CD" style="width:100%" disabled>
                        </select>
                    </td>

                    <td align="center" class="creamBold">교육형태</td>
                    <td class="padding2423" >
                        <select id="cmbSHAPE_CD" style="width:100%" disabled>
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육장소</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TAG"  name="txtPLACE_TAG" style="width:100%" maxlength="20"  class="input_ReadOnly"  readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육일정</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_STR_YMD"  name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly> ~ 
                        <input id="txtEDU_END_YMD"  name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly"  readOnly>
                    </td>

                    <td align="center" class="creamBold">교육시간</td>
                    <td class="padding2423" >
                        <input id="txtTIME_NO"  name="txtTIME_NO" style="width:70%;ime-mode:disabled;text-align:right;" class="input_ReadOnly"  readOnly> 시간
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육정원</td>
                    <td class="padding2423" >
                        <input id="txtFIX_NO"  name="txtFIX_NO" style="width:70%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> 명
                    </td>
                    <td align="center" class="creamBold">교육신청인원</td>
                    <td class="padding2423" >
                        <input id="txtREQ_NO"  name="txtREQ_NO" style="width:70%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> 명
                    </td>
                    <td align="center" class="creamBold">교육대상인원</td>
                    <td class="padding2423" >
                        <input id="txtOBJ_NO"  name="txtOBJ_NO" style="width:70%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> 명
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육수료인원</td>
                    <td class="padding2423" >
                        <input id="txtPAS_NO"  name="txtPAS_NO" style="width:70%;ime-mode:disabled;text-align:right;"  class="input_ReadOnly"  readOnly> 명
                    </td>
                    <td align="center" class="creamBold">과정만족도</td>
                    <td class="padding2423" >
                        <input id="txtESATIS_TAG"  name="txtESATIS_TAG" style="width:70%;ime-mode:disabled;text-align:right;" maxlength="3" > 점
                    </td>
                    <td align="center" class="creamBold">강사만족도</td>
                    <td class="padding2423" >
                        <input id="txtLSATIS_TAG"  name="txtLSATIS_TAG" style="width:70%;ime-mode:disabled;text-align:right;" maxlength="3" > 점
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교 육 량</td>
                    <td class="padding2423" >
                        <input id="txtEDU_TAG"  name="txtEDU_TAG" style="width:100%;" maxlength="20" >
                    </td>
                    <td align="center" class="creamBold">교육예산</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBUDGET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">교육비용</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEXPENSE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%"  readOnly>
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">고용보험적용유무</td>
                    <td class="padding2423" >
                        <select id="cmbINS_YN" style="width:100%"  disabled>
                        </select>
                    </td>
                    <td align="center" class="creamBold">환급예상금액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medRTN_EXPT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">환급실행금액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medINS_E_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">훈련코드</td>
                    <td class="padding2423" >
                        <input id="txtEDUCODE_TAG"  name="txtEDUCODE_TAG" style="width:100%;" maxlength="20" >
                    </td>
                    <td align="center" class="creamBold">환급시간</td>
                    <td class="padding2423" >
                        <input id="txtINS_TIME"  name="txtINS_TIME" style="width:70%;ime-mode:disabled;text-align:right;" maxlength="5" > 시간
                    </td>
                    <td align="center" class="creamBold">인당훈련비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medP_EDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">조견표단가</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medTBL_UNIT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">인정숙식비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medAPRV_BL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">인당지원금</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medP_AID_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">환급요청액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medRTN_RQST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">환급요청일</td>
                    <td class="padding2423" >
                        <input id="txtRTN_RQST_YMD"  name="txtRTN_RQST_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '환급요청일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRtnRqstYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRtnRqstYmd" name="ImgRtnRqstYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRTN_RQST_YMD','','320','368');"></a>
                    </td>
                    <td align="center" class="creamBold">환급실행일</td>
                    <td class="padding2423" >
                        <input id="txtRTN_EXEC_YMD"  name="txtRTN_EXEC_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '환급실행일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRtnExecYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRtnExecYmd" name="ImgRtnExecYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRTN_EXEC_YMD','','585','368');"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="155"></col>
                    <col width="155"></col>
                    <col width="90"></col>
                    <col width="155"></col>
                    <col width="155"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">항목</td>
                    <td align="center" class="creamBold">예산</td>
                    <td align="center" class="creamBold">집행</td>
                    <td align="center" class="creamBold">항목</td>
                    <td align="center" class="creamBold">예산</td>
                    <td align="center" class="creamBold">집행</td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">사내강사료</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBLCTRI_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medELCTRI_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">사외강사료</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBLCTRO_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medELCTRO_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교 재 대</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBBOOK_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEBOOK_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">문 구 대</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBSTAT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medESTAT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">음 료 대</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBDRINK_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEDRINK_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">개발/도업비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBDVLP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEDVLP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">강의장임차</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBPLAC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEPLAC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">버스임차</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBBUS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEBUS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">숙 박 비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBLODG_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medELODG_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">식&nbsp;&nbsp;&nbsp;&nbsp;비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBMEAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEMEAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">위탁교육비</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBCOMT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medECOMT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">기&nbsp;&nbsp;&nbsp;&nbsp;타</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medBETC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medEETC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_ED_INSURANCE"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_INSURANCE">
    <Param Name="BindInfo", Value='
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=SEQ_NO       Ctrl=txtSEQ_NO       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C>Col=CHASU_TAG    Ctrl=txtCHASU_TAG    Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=PLACE_TAG    Ctrl=txtPLACE_TAG    Param=value </C>
        <C>Col=EDU_STR_YMD  Ctrl=txtEDU_STR_YMD  Param=value </C>
        <C>Col=EDU_END_YMD  Ctrl=txtEDU_END_YMD  Param=value </C>
        <C>Col=TIME_NO      Ctrl=txtTIME_NO      Param=value </C>
        <C>Col=FIX_NO       Ctrl=txtFIX_NO       Param=value </C>
        <C>Col=REQ_NO       Ctrl=txtREQ_NO       Param=value </C>
        <C>Col=OBJ_NO       Ctrl=txtOBJ_NO       Param=value </C>
        <C>Col=PAS_NO       Ctrl=txtPAS_NO       Param=value </C>
        <C>Col=ESATIS_TAG   Ctrl=txtESATIS_TAG   Param=value </C>
        <C>Col=LSATIS_TAG   Ctrl=txtLSATIS_TAG   Param=value </C>
        <C>Col=EDU_TAG      Ctrl=txtEDU_TAG      Param=value </C>
        <C>Col=BUDGET_AMT   Ctrl=medBUDGET_AMT   Param=text  </C>
        <C>Col=EXPENSE_AMT  Ctrl=medEXPENSE_AMT  Param=text  </C>
        <C>Col=INS_YN       Ctrl=cmbINS_YN       Param=value </C>
        <C>Col=RTN_EXPT_AMT Ctrl=medRTN_EXPT_AMT Param=text  </C>
        <C>Col=INS_E_AMT    Ctrl=medINS_E_AMT    Param=text  </C>
        <C>Col=EDUCODE_TAG  Ctrl=txtEDUCODE_TAG  Param=value </C>
        <C>Col=INS_TIME     Ctrl=txtINS_TIME     Param=value </C>
        <C>Col=P_EDU_AMT    Ctrl=medP_EDU_AMT    Param=text  </C>
        <C>Col=TBL_UNIT_AMT Ctrl=medTBL_UNIT_AMT Param=text  </C>
        <C>Col=APRV_BL_AMT  Ctrl=medAPRV_BL_AMT  Param=text  </C>
        <C>Col=P_AID_AMT    Ctrl=medP_AID_AMT    Param=text  </C>
        <C>Col=RTN_RQST_AMT Ctrl=medRTN_RQST_AMT Param=text  </C>
        <C>Col=RTN_RQST_YMD Ctrl=txtRTN_RQST_YMD Param=value </C>
        <C>Col=RTN_EXEC_YMD Ctrl=txtRTN_EXEC_YMD Param=value </C>
        <C>Col=BLCTRI_AMT   Ctrl=medBLCTRI_AMT   Param=text  </C>
        <C>Col=BLCTRO_AMT   Ctrl=medBLCTRO_AMT   Param=text  </C>
        <C>Col=BBOOK_AMT    Ctrl=medBBOOK_AMT    Param=text  </C>
        <C>Col=BSTAT_AMT    Ctrl=medBSTAT_AMT    Param=text  </C>
        <C>Col=BDRINK_AMT   Ctrl=medBDRINK_AMT   Param=text  </C>
        <C>Col=BDVLP_AMT    Ctrl=medBDVLP_AMT    Param=text  </C>
        <C>Col=BPLAC_AMT    Ctrl=medBPLAC_AMT    Param=text  </C>
        <C>Col=BBUS_AMT     Ctrl=medBBUS_AMT     Param=text  </C>
        <C>Col=BLODG_AMT    Ctrl=medBLODG_AMT    Param=text  </C>
        <C>Col=BMEAL_AMT    Ctrl=medBMEAL_AMT    Param=text  </C>
        <C>Col=BCOMT_AMT    Ctrl=medBCOMT_AMT    Param=text  </C>
        <C>Col=BETC_AMT     Ctrl=medBETC_AMT     Param=text  </C>
        <C>Col=ELCTRI_AMT   Ctrl=medELCTRI_AMT   Param=text  </C>
        <C>Col=ELCTRO_AMT   Ctrl=medELCTRO_AMT   Param=text  </C>        
        <C>Col=EBOOK_AMT    Ctrl=medEBOOK_AMT    Param=text  </C>
        <C>Col=ESTAT_AMT    Ctrl=medESTAT_AMT    Param=text  </C>
        <C>Col=EDRINK_AMT   Ctrl=medEDRINK_AMT   Param=text  </C>
        <C>Col=EDVLP_AMT    Ctrl=medEDVLP_AMT    Param=text  </C>
        <C>Col=EPLAC_AMT    Ctrl=medEPLAC_AMT    Param=text  </C>
        <C>Col=EBUS_AMT     Ctrl=medEBUS_AMT     Param=text  </C>
        <C>Col=ELODG_AMT    Ctrl=medELODG_AMT    Param=text  </C>
        <C>Col=EMEAL_AMT    Ctrl=medEMEAL_AMT    Param=text  </C>
        <C>Col=ECOMT_AMT    Ctrl=medECOMT_AMT    Param=text  </C>
        <C>Col=EETC_AMT     Ctrl=medEETC_AMT     Param=text  </C>
    '>                                         
</object>