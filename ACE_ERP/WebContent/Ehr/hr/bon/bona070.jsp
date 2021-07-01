<!--
    ************************************************************************************
    * @Source         : bona070.jsp                                                    *
    * @Description    : 예외자상여비율등록 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/08/23  |  한학현   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>예외자상여비율등록(bona070)</title>
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
    
        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'T' + 'T' + 'T' + 'T' + 'F' + 'T' + 'T';    

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var STR_YM   = document.getElementById("txtSTR_YM_SHR").value;
            var END_YM   = document.getElementById("txtEND_YM_SHR").value;
            var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;

            if(STR_YM.trim().length != 0 || END_YM.trim().length != 0){
	            //시작년월이 없으면 조회못함.
	            if(STR_YM.trim().length == 0){
	                alert("시작년월을 입력하세요.");
	                document.getElementById("txtSTR_YM_SHR").focus();
	                return false;
	            }
	            //시작년월이 잘못되었으면 조회못함.
	            if(STR_YM.trim().length != 7){
	                alert("시작년월이 잘못되었습니다.");
	                document.getElementById("txtSTR_YM_SHR").focus();
	                return false;
	            }
	
	            //종료년월이 없으면 조회못함.
	            if(END_YM.trim().length == 0){
	                alert("종료년월을 입력하세요.");
	                document.getElementById("txtEND_YM_SHR").focus();
	                return false;
	            }
	            //종료년월이 잘못되었으면 조회못함.
	            if(END_YM.trim().length != 7){
	                alert("종료년월이 잘못되었습니다.");
	                document.getElementById("txtEND_YM_SHR").focus();
	                return false;
	            }
	
	            //종료년월이 시작년월보다 크면 않된다.
	            if(parseInt(END_YM.replaceStr("-","")) < parseInt(STR_YM.replaceStr("-",""))){
	                    alert("종료년월이 시작년월보다 빠릅니다.");
	                    document.getElementById("txtEND_YM_SHR").focus();
	                    return false;
	            }
            }
            
            dsT_CP_BONUS_EXCEPTION.DataId = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona070.cmd.BONA070CMD&S_MODE=SHR&STR_YM="+STR_YM+"&END_YM="+END_YM+"&ENO_NO="+ENO_NO;
            dsT_CP_BONUS_EXCEPTION.Reset();
            
            form1.grdT_CP_BONUS_EXCEPTION.Focus();
            
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

            if(fnc_SaveItemCheck()) {

                trT_CP_BONUS_EXCEPTION.action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona070.cmd.BONA070CMD&S_MODE=SAV";
                trT_CP_BONUS_EXCEPTION.post();
                
            } else {
                
                return;
                
            }
            
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CP_BONUS_EXCEPTION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            
            status = dsT_CP_BONUS_EXCEPTION.RowStatus(dsT_CP_BONUS_EXCEPTION.RowPosition);
            
            //DataSet의 변경 여부 확인
            if (dsT_CP_BONUS_EXCEPTION.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }
            
            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작년월[" + dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition,"STR_YM") + "] 성명[" + dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition,"ENO_NM") + "] [" + dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition,"ENO_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CP_BONUS_EXCEPTION.DeleteRow(dsT_CP_BONUS_EXCEPTION.RowPosition);

            if (status != 1) {
                trT_CP_BONUS_EXCEPTION.action = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona070.cmd.BONA070CMD&S_MODE=DEL";
                trT_CP_BONUS_EXCEPTION.post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CP_BONUS_EXCEPTION.SetColumn(form1.grdT_CP_BONUS_EXCEPTION.GetColumnID(0));
            form1.grdT_CP_BONUS_EXCEPTION.Focus();

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

            if (dsT_CP_BONUS_EXCEPTION.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_BONUS_EXCEPTION.GridToExcel("예외자상여비율등록", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CP_BONUS_EXCEPTION.CountColumn == 0) {
                dsT_CP_BONUS_EXCEPTION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, ENO_NM:STRING, STR_YM:STRING:KEYVALUETYPE, END_YM:STRING, OCC_CD:STRING, OCC_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, BAS_PCT:STRING, OT_PCT:STRING, OSE_PCT:STRING, LSEV_PCT:STRING");
            }
                                
            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CP_BONUS_EXCEPTION.AddRow();
            
            fnc_ColEnabled('E');
            
            form1.grdT_CP_BONUS_EXCEPTION.setColumn(form1.grdT_CP_BONUS_EXCEPTION.getColumnID(0));
            
            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YM").disabled     = false;
            document.getElementById("imgENO_NO").disabled     = false;
            document.getElementById("imgSTR_YM").disabled     = false;
            
            document.getElementById("txtENO_NO").focus();

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

            //document.getElementById("txtSTR_YM_SHR").value = '';
            //document.getElementById("txtEND_YM_SHR").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            
            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_CP_BONUS_EXCEPTION.ClearData();
            
            fnc_ColEnabled('D');
            
            //fnc_SetDateTerm();
            
            document.getElementById("txtSTR_YM_SHR").focus();

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

            var f = document.form1;
        
            //DataSet의 변경 여부 확인
            if (!dsT_CP_BONUS_EXCEPTION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }  
            
            for ( i = 1; i <= dsT_CP_BONUS_EXCEPTION.CountRow; i++ ) {
                if ( dsT_CP_BONUS_EXCEPTION.RowStatus(i) == 1 || 
                     dsT_CP_BONUS_EXCEPTION.RowStatus(i) == 3 ) {
                
                    // 사번
                    if( dsT_CP_BONUS_EXCEPTION.NameValue(i, "ENO_NO") == '' ) {
                        alert("사번은 필수 입력사항입니다.");
                        dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    }   
                    
                    // 사번
                    if( dsT_CP_BONUS_EXCEPTION.NameValue(i, "ENO_NO") != '' && dsT_CP_BONUS_EXCEPTION.NameValue(i, "ENO_NM") == '') {
                        alert("입력하신 사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                        dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    }   
                    
                    // 시작년월
                    if( dsT_CP_BONUS_EXCEPTION.NameValue(i, "STR_YM") == '' ) {
                        alert("시작년월은 필수 입력사항입니다.");
                        dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                        document.getElementById("txtSTR_YM").focus();
                        return false;
                    } 
                    
                    // 시작년월 CHECK
                    if (!fnc_CheckDate2(dsT_CP_BONUS_EXCEPTION.NameValue(i, "STR_YM"), "시작년월") && dsT_CP_BONUS_EXCEPTION.NameValue(i, "STR_YM") != "") {
                        dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                        document.getElementById("txtSTR_YM").focus();
                        return false;
                    }
                    
                    // 종료년월 CHECK
                    if (!fnc_CheckDate2(dsT_CP_BONUS_EXCEPTION.NameValue(i, "END_YM"), "종료년월") && dsT_CP_BONUS_EXCEPTION.NameValue(i, "END_YM") != "") {
                        dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                        document.getElementById("txtEND_YM").focus();
                        return false;
                    }
                    
                    // 시작년월과 종료년월 비교
                    if( dsT_CP_BONUS_EXCEPTION.NameValue(i, "STR_YM") != '' && dsT_CP_BONUS_EXCEPTION.NameValue(i, "END_YM") != '' ) {
                        if( cfDateDiff(dsT_CP_BONUS_EXCEPTION.NameValue(i, "STR_YM").replace(/\-/g,''),dsT_CP_BONUS_EXCEPTION.NameValue(i, "END_YM").replace(/\-/g,'')) < 0 ) {
                            alert("적용기간 종료년월이 시작년월보다 작습니다.");
                            dsT_CP_BONUS_EXCEPTION.RowPosition = i;
                            document.getElementById("txtEND_YM").focus();
                            return false;
                        }
                    }
                    
                    if ( dsT_CP_BONUS_EXCEPTION.RowStatus(i) == 1) {
                       document.getElementById("txtENO_NO").disabled     = false;
                       document.getElementById("txtENO_NM").disabled     = false;
                       document.getElementById("txtSTR_YM").disabled     = false;
                       document.getElementById("imgENO_NO").disabled     = false;
                       document.getElementById("imgSTR_YM").disabled     = false;
                    }
                    
                }
            }   
        
            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_CP_BONUS_EXCEPTION,0,"false","false");

            fnc_SetDateTerm();
            
            fnc_ColEnabled('D');
            
            document.getElementById("txtSTR_YM_SHR").focus();
            
        }
        
        
        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
            
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/
        
        // 적용기간 SET
        function fnc_SetDateTerm() {

            var dateinfo = getToday().split("-");
                
            //from - to 날짜값 설정하기
            var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);  
            var fromDate = null;
            var toDate   = null;
            
            fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));
            
            // FROM 일자
            document.getElementById("txtSTR_YM_SHR").value = fnc_MakeDateString(fromDate);
            
            // TO 일자
            document.getElementById("txtEND_YM_SHR").value = fnc_MakeDateString(toDate);

        }
         
        // DATE형을 STRING(YYYY-MM-DD)형태 일자로 변환
        function fnc_MakeDateString(date) {
        
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }
            
            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month;// + "-" + date
            
        }
        
            
        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
               
                document.getElementById("txtENO_NO").disabled    = false;
                document.getElementById("txtENO_NM").disabled    = false;
                document.getElementById("txtSTR_YM").disabled    = false;
                document.getElementById("txtEND_YM").disabled    = false;

                form1.medBAS_PCT.Enable  = "true";
				form1.medOT_PCT.Enable   = "true";
				form1.medOSE_PCT.Enable  = "true";//form1.medMH_PCT.Enable   = "true";
				form1.medLSEV_PCT.Enable = "true";
                                                                 
                document.getElementById("imgENO_NO").disabled    = false;
                document.getElementById("imgSTR_YM").disabled    = false;
                document.getElementById("imgEND_YM").disabled    = false;
                
                
            }
            else if (prop == 'D') {

                document.getElementById("txtENO_NO").disabled    = true;
                document.getElementById("txtENO_NM").disabled    = true;
                document.getElementById("txtSTR_YM").disabled    = true;
                document.getElementById("txtEND_YM").disabled    = true;
                
                form1.medBAS_PCT.Enable  = "false";
                form1.medOT_PCT.Enable   = "false";
                form1.medOSE_PCT.Enable  = "false";//form1.medMH_PCT.Enable   = "false";
                form1.medLSEV_PCT.Enable = "false";
                                                                 
                document.getElementById("imgENO_NO").disabled    = true;
                document.getElementById("imgSTR_YM").disabled    = true;
                document.getElementById("imgEND_YM").disabled    = true;
                
            }
        }

        function fnc_EnoPopup() {

            var obj = new String();
            
            obj = fnc_emplPopup('txtENO_NO', 'txtENO_NM');
            
            if (obj.eno_no != null) {
                document.getElementById("txtENO_NO").value = obj.eno_no; 
                document.getElementById("txtENO_NM").value = obj.eno_nm; 
                document.getElementById("txtOCC_NM").value = obj.occ_nm; 
                document.getElementById("txtDPT_NM").value = obj.dpt_nm; 
                document.getElementById("txtJOB_NM").value = obj.job_nm; 
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "OCC_CD") = obj.occ_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "DPT_CD") = obj.dpt_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "JOB_CD") = obj.job_cd;                 
            }
                
        }

        // 사번으로 성명 가져오기
        function fnc_UsrGetEnoNm() {
            var obj = new String();
            
            document.getElementById("txtENO_NM").value = ''; 
            document.getElementById("txtOCC_NM").value = ''; 
            document.getElementById("txtDPT_NM").value = ''; 
            document.getElementById("txtJOB_NM").value = ''; 
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "OCC_CD") = '';
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "DPT_CD") = '';
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "JOB_CD") = '';
            
            if (document.getElementById("txtENO_NO").value  == "") {

                return;
            }
            
            // 정규직 재직자
            obj = fnc_GetEnoNm('txtENO_NO','','0','1'); 
            
            if (obj.eno_nm  == "") {

                return;
            }
            else {    
                document.getElementById("txtENO_NM").value = obj.eno_nm; 
                document.getElementById("txtOCC_NM").value = obj.occ_nm; 
                document.getElementById("txtDPT_NM").value = obj.dpt_nm; 
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "OCC_CD") = obj.occ_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "DPT_CD") = obj.dpt_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "JOB_CD") = obj.job_cd; 
            }
        }
        
        // 성명으로 사번 가져오기
        function fnc_UsrGetEnoNo() {
            var obj = new String();
            
            document.getElementById("txtENO_NO").value = ''; 
            document.getElementById("txtOCC_NM").value = '';
            document.getElementById("txtDPT_NM").value = ''; 
            document.getElementById("txtJOB_NM").value = '';
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "OCC_CD") = '';
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "DPT_CD") = '';
            dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "JOB_CD") = '';

            if (document.getElementById("txtENO_NM").value  == "") {

                return;
            }
            
            // 정규직 재직자
            obj = fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '0', '1','Y');
            
            if (obj.eno_no  == "") {

                return;
            }
            else {    

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtOCC_NM").value = obj.occ_nm;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "OCC_CD") = obj.occ_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "DPT_CD") = obj.dpt_cd;
                dsT_CP_BONUS_EXCEPTION.NameValue(dsT_CP_BONUS_EXCEPTION.RowPosition, "JOB_CD") = obj.job_cd; 
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_BONUS_EXCEPTION) |
    | 3. 사용되는 Table List(T_CP_BONUS_EXCEPTION)        |
    +----------------------------------------------->
    <Object ID="dsT_CP_BONUS_EXCEPTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CP_BONUS_EXCEPTION                    |
    | 3. Table List : T_CP_BONUS_EXCEPTION                |
    +----------------------------------------------->
    <Object ID ="trT_CP_BONUS_EXCEPTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CP_BONUS_EXCEPTION)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_BONUS_EXCEPTION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CP_BONUS_EXCEPTION.CountRow );
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtENO_NO").disabled    = true;
            document.getElementById("txtENO_NM").disabled    = true;
            document.getElementById("txtSTR_YM").disabled    = true;
            document.getElementById("imgENO_NO").disabled    = true;
            document.getElementById("imgSTR_YM").disabled    = true;
            
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_BONUS_EXCEPTION Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_BONUS_EXCEPTION Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YM").disabled     = false;
            document.getElementById("imgENO_NO").disabled     = false;
            document.getElementById("imgSTR_YM").disabled     = false;
            
            alert("해당 필수입력항목[사번/시작년월] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YM").disabled     = false;
            document.getElementById("imgENO_NO").disabled     = false;
            document.getElementById("imgSTR_YM").disabled     = false;
            
            alert("사번/시작년월에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>
    
    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CP_BONUS_EXCEPTION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CP_BONUS_EXCEPTION event="OnFail()">
    
        cfErrorMsg(this);
    
    </script>
    
    <script language=JavaScript for=dsT_CP_BONUS_EXCEPTION event=OnRowPosChanged(row)>
        var SysStatus = dsT_CP_BONUS_EXCEPTION.SysStatus(row);
        
        if (SysStatus == 1) {
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YM").disabled    = false;
            document.getElementById("imgENO_NO").disabled      = false;
            document.getElementById("imgSTR_YM").disabled     = false;
            
        }
        else {
            document.getElementById("txtENO_NO").disabled     = true;
            document.getElementById("txtENO_NM").disabled     = true;
            document.getElementById("txtSTR_YM").disabled    = true;
            document.getElementById("imgENO_NO").disabled      = true;
            document.getElementById("imgSTR_YM").disabled     = true;

        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">예외자상여비율등록</td>
                    <td align="right" class="navigator">HOME/보상관리/상여관리/<font color="#000000">예외자상여비율등록</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->            
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
                                <col width="60"></col>
                                <col width="220"></col>
                                <col width="60"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당기간</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YM_SHR" size="8" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YM_SHR','','75','112');"></a>
                                    &nbsp;~&nbsp;
                                    <input id="txtEND_YM_SHR" size="8" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YM_SHR','','190','112');"></a>
                                </td>
                                <td align="right" class="searchState">사원번호</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="111"></col>
                    <col width="80"></col>
                    <col width="111"></col>
                    <col width="80"></col>
                    <col width="111"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">사원번호</td>
                    <td class="padding2423" colspan="3">
                        <input name=txtENO_NO id=txtENO_NO size="8" style="ime-mode:disabled" maxlength="10" onChange="fnc_UsrGetEnoNm();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EnoPopup()"></a>
                        <input name=txtENO_NM id=txtENO_NM size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_UsrGetEnoNo();}" onChange="fnc_UsrGetEnoNo();">
                    </td>
                    <td align="center" class="creamBold">적용기간</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSTR_YM" size="8" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YM','','75','112');"></a>
                        &nbsp;~&nbsp;
                        <input id="txtEND_YM" size="8" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YM','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YM','','190','112');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input name=txtOCC_NM id=txtOCC_NM style="width:100" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input name=txtDPT_NM id=txtDPT_NM style="width:100" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input name=txtJOB_NM id=txtJOB_NM style="width:100" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">기본급율</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBAS_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>                    
                </tr>
                <tr>
                    <td align="center" class="creamBold">시간외수당율</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOT_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>                
                    <td align="center" class="creamBold">자기개발비율</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medOSE_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">근속수당율</td>
                    <td class="padding2423" colspan="3">
                        <comment id="__NSID__"><object id="medLSEV_PCT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                            <param name=Alignment                   value=2>
                            <param name=Border                      value=true>
                            <param name=ClipMode                    value=true>
                            <param name=DisabledBackColor   value="#EEEEEE">
                            <param name=Enable                      value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                    value=0>
                            <param name=MaxLength               value=3>
                            <param name=Numeric                 value=true>
                            <param name=ShowLiteral             value="false">
                            <param name=Visible                     value="true">
                            <param name=MaxDecimalPlace     value=2>
                            <param name=VisibleMaxDecimal   value="true">
                            <param name=SelectAll                   value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

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
                        <object    id="grdT_CP_BONUS_EXCEPTION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:310px;">
                            <param name="DataID"                  value="dsT_CP_BONUS_EXCEPTION">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'       width=29    name='NO'             align=center </C>
                                <C> id='DPT_NM'         width=100   name='소속'           align=center </C>
                                <C> id='JOB_NM'         width=60    name='직위'           align=center </C>
                                <C> id='ENO_NO'         width=70    name='사번'           align=center </C>
                                <C> id='ENO_NM'         width=70    name='성명'           align=center </C>
                                <C> id='STR_YM'         width=70    name='시작년월'       align=center </C>
                                <C> id='END_YM'         width=70    name='종료년월'       align=center </C>
                                <C> id='BAS_PCT'        width=75    name='기본급율'       align=right  </C>
                                <C> id='OT_PCT'         width=80    name='시간외수당율'   align=right  </C>
                                <C> id='OSE_PCT'        width=80    name='자기개발비율'   align=right  </C>
                                <C> id='LSEV_PCT'       width=75    name='근속수당율'     align=right  </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CP_BONUS_EXCEPTION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM       Param=value </C>        
        <C> Col=OCC_NM        Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=STR_YM        Ctrl=txtSTR_YM       Param=value </C>
        <C> Col=END_YM        Ctrl=txtEND_YM       Param=value </C>
        <C> Col=BAS_PCT       Ctrl=medBAS_PCT      Param=text </C>
        <C> Col=OT_PCT        Ctrl=medOT_PCT       Param=text </C>
        <C> Col=OSE_PCT       Ctrl=medOSE_PCT      Param=text </C>
        <C> Col=LSEV_PCT      Ctrl=medLSEV_PCT     Param=text </C>
    '>
</object>
