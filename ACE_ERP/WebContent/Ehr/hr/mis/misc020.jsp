<!--
    ************************************************************************************
    * @Source         : misc020.jsp                                                    *
    * @Description    : 부서별인원충원계획관리 PAGE                                    *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/02 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String PLN_AUTHO    = box.getString("SESSION_PLN_AUTHO");
    String ROLE_CD      = box.getString("SESSION_ROLE_CD");
    
    //관리자인지 아닌지 여부
    boolean isMaster    = false;
    
    //수신은 마스터 관리자만 사용함
    // A 모든부서, S 소속부서
    // IT(1001)는 마스터와 동일한 권한 인사(1002)는 고려하지 않음 
    if(PLN_AUTHO.equals("A")
            || ROLE_CD.equals("1001")) {
        isMaster = true;
    }
%>

<html>

    <head>
    <title>부서별인원충원계획관리(misc020)</title>
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

        var btnList  = 'TFFTFTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var DPT_CD   = document.getElementById("txtDPT_CD_SHR").value;

            if (PIS_YY == "") {
                alert("사업년도는 필수입력항목입니다.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }
            
            //계획년도를 초기화 한다.
            fnc_BndHIR_YM();    


            dsT_MI_LEVYPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                   + "&S_MODE=SHR"
                                   + "&PIS_YY="+PIS_YY
                                   + "&DPT_CD="+DPT_CD
                                   + "&TYPE=MISC020";
            dsT_MI_LEVYPLAN.Reset();

            form1.grdT_MI_LEVYPLAN.Focus();

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

            if (ProSts != "1") {
                alert("인원계획 작성기간이 아니므로 수정작업을 하실 수 없습니다.");
                return;
            }
            
            //DataSet의 변경 여부 확인
            if (!dsT_MI_LEVYPLAN.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }
            
            trT_MI_LEVYPLAN.KeyValue    = "tr01(I:SAV=dsT_MI_LEVYPLAN)";
            trT_MI_LEVYPLAN.action      = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                        + "&S_MODE=SAV";
            trT_MI_LEVYPLAN.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_MI_LEVYPLAN.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (ProSts != "1") {
                alert("인원계획 작성기간이 아니므로 삭제작업을 하실 수 없습니다.");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("계획년월 [" + dsT_MI_LEVYPLAN.NameValue(dsT_MI_LEVYPLAN.RowPosition,"HIR_YM") + "] 충원사유 [" + dsT_MI_LEVYPLAN.NameValue(dsT_MI_LEVYPLAN.RowPosition,"LEVY_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_MI_LEVYPLAN.DeleteRow(dsT_MI_LEVYPLAN.RowPosition);

            trT_MI_LEVYPLAN.KeyValue    = "tr01(I:SAV=dsT_MI_LEVYPLAN)";
            trT_MI_LEVYPLAN.action      = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD"
                                        + "&S_MODE=SAV";
            trT_MI_LEVYPLAN.post();
            
        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
			var STR_YY = document.getElementById("cmbPIS_YY_SHR").value;
			var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
			var DPT_NM = document.getElementById("txtDPT_NM_SHR").value;

			var url = "misc025_PV.jsp?str_yy="+STR_YY+"&dpt_cd="+DPT_CD+"&dpt_nm="+DPT_NM;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

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
            if (ProSts != "1") {
                alert("인원계획 작성기간이 아니므로 신규작업을 하실 수 없습니다.");
                return;
            }

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_MI_LEVYPLAN.CountColumn == 0) {
                dsT_MI_LEVYPLAN.setDataHeader("PIS_YY:STRING, DPT_CD:STRING, DPT_NM:STRING, TSEQ_NO:STRING, JOB_CD:STRING, JOB_NM:STRING, JOB_GBN:STRING, HIR_YM:STRING, HEAD_CD:STRING, HEAD_NM:STRING, LEVY_CD:STRING, LEVY_NM:STRING, JIKMU_CD:STRING, JIKMU_NM:STRING, OCC_CD:STRING, OCC_NM:STRING, MF_TAG:STRING, MF_TNM:STRING, LEVY_TXT:STRING, REMARK:STRING, OENO_NO:STRING, OENO_NM:STRING, NDPT_CD:STRING, DUMMY:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_MI_LEVYPLAN.AddRow();
            
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "PIS_YY") = document.getElementById("cmbPIS_YY_SHR").value;
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "DPT_CD") = '<%=box.get("SESSION_DPTCD")%>';
            dsT_MI_LEVYPLAN.NameString(dsT_MI_LEVYPLAN.RowPosition, "DPT_NM") = '<%=box.get("SESSION_DPTNM")%>';
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

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_MI_LEVYPLAN.ClearData();

            document.getElementById("cmbPIS_YY_SHR").focus();

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


        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            
            //Grid Style 적용
            cfStyleGrid(form1.grdT_MI_LEVYPLAN,0,"false","false");

            //근로구분
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD").add(oOption);

            }

            //부문(직군)
            for( var i = 1; i <= dsCOMMON_B1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD").add(oOption);

            }

            //직급
            cfCopyDataSet(fnc_GetJobCd(), dsCOMMON_JOB);
            dsCOMMON_JOB.AddRow();
            
            dsCOMMON_JOB.NameString(dsCOMMON_JOB.RowPosition, "COMM_CD") = "ZZ";
            dsCOMMON_JOB.NameString(dsCOMMON_JOB.RowPosition, "COMM_NM") = "파견직";

            for( var i=1; i<=dsCOMMON_JOB.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_JOB.NameValue(i,"COMM_CD");
                oOption.text = dsCOMMON_JOB.NameValue(i,"COMM_CD")+': '+dsCOMMON_JOB.NameValue(i,"COMM_NM");
                document.getElementById("cmbJOB_CD").add(oOption);
            }


            //직무
            cfCopyDataSet(fnc_GetDutyCd('DUTY2', '4'), dsCOMMON_DUTY);
            
            for( var i=1; i<=dsCOMMON_DUTY.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_DUTY.NameValue(i,"COMM_CD");
                oOption.text = dsCOMMON_DUTY.NameValue(i,"COMM_NM");
                document.getElementById("cmbJIKMU_CD").add(oOption);
            }


            //충원사유
            for( var i = 1; i <= dsCOMMON_G4.CountRow; i++ ) {

                // 전환배치 및 감원은 제외
                if (dsCOMMON_G4.NameValue(i,"CODE") != '4' &&
                    dsCOMMON_G4.NameValue(i,"CODE") != '5') {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_G4.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_G4.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbLEVY_CD").add(oOption);
                }

            }
            
            
            // 사업년도 및 대상기간 추출
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc020.cmd.MISC020CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();
            
<% 
    if(!isMaster) {
%>
            document.getElementById("txtDPT_CD_SHR").value = "<%=box.get("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.get("SESSION_DPTNM") %>";
    
            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "imgDPT_CD_SHR");
<%
    }
%>

            //계획년도를 초기화 한다.
            fnc_BndHIR_YM();    

            document.getElementById("cmbPIS_YY_SHR").focus();
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

        
        /**
         * 충원 사유에 따른 처리 방식을 변경함
         */
        function fnc_ChgLEVY_CD() {
            // 충원사유가 계약직전환이 아니면 
            if (document.getElementById("cmbLEVY_CD").value == '1') {

                fnc_ChangeStateElement(true, "txtOENO_NO");
                fnc_ChangeStateElement(true, "txtOENO_NM");
                fnc_ChangeStateElement(true, "ImgEnoNo");
                
            } else {
                document.getElementById("txtOENO_NO").value = "";
                document.getElementById("txtOENO_NM").value = "";

                fnc_ChangeStateElement(false, "txtOENO_NO");
                fnc_ChangeStateElement(false, "txtOENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
            }
            
        }
        
        /**
         * 계획년월을 초기화 한다.
         */
        function fnc_BndHIR_YM() {
            if(dsT_CP_WORKLOG.CountRow == 0) {
                document.getElementById("resultMessage").innerText = "조회된 사업계획이 없습니다.";
                return;
            }
        
            //조회한 년도
            var LogRow  = dsT_CP_WORKLOG.NameValueRow("PIS_YY", document.getElementById("cmbPIS_YY_SHR").value);
            
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(LogRow, "PAY_YMD").split("-");
            var APY_YM  = dsT_CP_WORKLOG.NameValue(LogRow, "APY_YMD").split("-");
            
            //작업번호를 미리 저장해 놓음
            ProSts      = dsT_CP_WORKLOG.NameValue(LogRow, "PRO_STS");
            
            // 계획년월
            var oSelect = document.getElementById("cmbHIR_YM");
            var oOption;
            
            
            //대상시작일
            var str_year  = parseInt(PAY_YM[0]);
            var str_mon   = parseInt(PAY_YM[1]);
            
            //대상종료일
            var end_year  = parseInt(APY_YM[0]);
            var end_mon   = parseInt(APY_YM[1]);
            
            
            //초기화
            oSelect.length = 1;
            
            while(true) {
                //시작일이 종료일을 넘어서면 종료
                if(str_year > end_year 
                        || (str_year == end_year && str_mon > end_mon))
                    break;
                    
            
                oOption         = document.createElement("OPTION");
                oOption.value   = str_year+"-"+lpad(str_mon, 2, '0');
                oOption.text    = str_year+"-"+lpad(str_mon, 2, '0');
                oSelect.add(oOption);
                
                
                //날짜값 설정
                if(str_mon == 12) {
                    str_year++;
                    str_mon = 1;
                } else {
                    str_mon++;
                }
            }
        }
                

        
        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            
            if (document.getElementById("txtOENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }   
        
        /**
         * 사원 정보를 조회 한다. 
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            fnc_SearchEmpNo();
        } 
         
        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;
            
            // 파견사원 전체
            obj = fnc_GetCommonEnoNm("txtOENO_NO", "txtOENO_NM", "txtDPT_CD_SHR", "2");
            if(obj != null && obj.eno_no != "") {            
                document.getElementById("txtOENO_NO").value     = obj.eno_no;
                document.getElementById("txtOENO_NM").value     = obj.eno_nm;
                document.getElementById("cmbMF_TAG").value      = obj.mf_tag;
            } else {
                document.getElementById("txtOENO_NO").value     = "";
                document.getElementById("txtOENO_NM").value     = "";
                document.getElementById("cmbMF_TAG").value      = "";
            }
        }  
        
        
        
        var elementList = new Array(    "txtDPT_CD"    
                                       ,"imgDPT_CD" 
                                       ,"cmbOCC_CD"     
                                       ,"cmbHEAD_CD"    
                                       ,"cmbJOB_CD"     
                                       ,"cmbJIKMU_CD"   
                                       ,"cmbHIR_YM"     
                                       ,"cmbMF_TAG"
                                       ,"cmbLEVY_CD"    
                                       ,"txtREMARK"     
                                       ,"txtLEVY_TXT"   
                                       ,"txtOENO_NO"    
                                       ,"txtOENO_NM"    
                                       ,"ImgEnoNo" );
                                       
        var exceptionList = new Array(  "txtDPT_CD"    
                                       ,"imgDPT_CD" );
 
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_MI_LEVYPLAN)  |
    | 3. 사용되는 Table List(T_MI_LEVYPLAN)         |
    +----------------------------------------------->
    <Object ID="dsT_MI_LEVYPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)   |
    | 3. 사용되는 Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_MI_LEVYPLAN                     |
    | 3. Table List : T_MI_LEVYPLAN                 |
    +----------------------------------------------->
    <Object ID ="trT_MI_LEVYPLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_MI_LEVYPLAN)">
    </Object>

    <!-- 직무 -->
    <Object ID="dsCOMMON_DUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-- 직급 -->
    <Object ID="dsCOMMON_JOB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 부문 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B1"/>
       <jsp:param name="CODE_GUBUN"    value="B1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 충원사유 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_G4"/>
       <jsp:param name="CODE_GUBUN"    value="G4"/>
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
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        var oSelect = document.getElementById("cmbPIS_YY_SHR");
        var oOption;

        oSelect.length = 0;
        
        if (iCount > 0)    {

            //사업년도
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption         = document.createElement("OPTION");
                oOption.value   = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text    = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oSelect.add(oOption);
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_LEVYPLAN Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    
    

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_MI_LEVYPLAN event="OnSuccess()">
        
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_MI_LEVYPLAN event="OnFail()">

        cfErrorMsg(this);

    </script>

     
     
     
    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_MI_LEVYPLAN event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            var LogRow  = dsT_CP_WORKLOG.NameValueRow("PIS_YY", document.getElementById("cmbPIS_YY_SHR").value);
            
            //PRO_STS  1:작업 open, 2:인원계획완료, 3:대상자선정, 4:승진완료, 5:승급완료, 6:급상여작업완료, 7:작업 close
            //작업이 OPEN 상태가 아니면 더이상 수정 할 수 없다.
            if(ProSts != "1")
                return;
        
        
            //신규일 경우        
            if(dsT_MI_LEVYPLAN.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
            
            fnc_ChgLEVY_CD();
        }
    </script>
 
 
 
    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_MI_LEVYPLAN event=CanRowPosChange(row)>
            
        if (dsT_MI_LEVYPLAN.RowStatus(row) == 1 
                || dsT_MI_LEVYPLAN.RowStatus(row) == 3 ) {
                
            // 부서
            if( dsT_MI_LEVYPLAN.NameValue(row, "DPT_CD") == '' ) {
                alert("부서코드는 필수 입력사항입니다.");
                document.getElementById("txtDPT_CD").focus();
                return false;
            }
    
            // 부서 CHECK
            if (dsT_MI_LEVYPLAN.NameValue(row, "DPT_CD") != "" 
                    && dsT_MI_LEVYPLAN.NameValue(row, "DPT_NM") == "") {
                alert("소속코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtDPT_CD").focus();
                return false;
            }
    
            // 근로구분
            if( dsT_MI_LEVYPLAN.NameValue(row, "OCC_CD") == '' ) {
                alert("근로구분은 필수 입력사항입니다.");
                document.getElementById("cmbOCC_CD").focus();
                return false;
            }
    
            // 직군
            if( dsT_MI_LEVYPLAN.NameValue(row, "HEAD_CD") == '' ) {
                alert("직군은 필수 입력사항입니다.");
                document.getElementById("cmbHEAD_CD").focus();
                return false;
            }
    
            // 직급
            if( dsT_MI_LEVYPLAN.NameValue(row, "JOB_CD") == '' ) {
                alert("직급은 필수 입력사항입니다.");
                document.getElementById("cmbJOB_CD").focus();
                return false;
            }
    
            // 사원구분
            if (dsT_MI_LEVYPLAN.NameValue(row, "JOB_CD") != 'ZZ') {
                // 정규직, 계약직
                dsT_MI_LEVYPLAN.NameValue(row, "JOB_GBN") = '1';
            }
            else {
                // 파견사원
                dsT_MI_LEVYPLAN.NameValue(row, "JOB_GBN") = '2';
            }
    
            // 직무
            if( dsT_MI_LEVYPLAN.NameValue(row, "JIKMU_CD") == '' ) {
                alert("직무는 필수 입력사항입니다.");
                document.getElementById("cmbJIKMU_CD").focus();
                return false;
            }
    
            // 계획년월
            if( dsT_MI_LEVYPLAN.NameValue(row, "HIR_YM") == '' ) {
                alert("계획년월은 필수 입력사항입니다.");
                document.getElementById("cmbHIR_YM").focus();
                return false;
            }
    
            // 충원사유
            if( dsT_MI_LEVYPLAN.NameValue(row, "LEVY_CD") == '' ) {
                alert("충원사유는 필수 입력사항입니다.");
                document.getElementById("cmbLEVY_CD").focus();
                return false;
            }
    
            // 계약직전환인 경우
            if (dsT_MI_LEVYPLAN.NameValue(row, "LEVY_CD") == '1') {
                // 기존사번
                if (dsT_MI_LEVYPLAN.NameValue(row, "OENO_NO") == '') {
    
                    alert("계약직전환인 경우 기존사번은 필수 입력사항입니다.");
                    document.getElementById("txtOENO_NO").focus();
                    return false;
                }
    
                // 사번 CHECK
                if (dsT_MI_LEVYPLAN.NameValue(row, "OENO_NO") != '' 
                        && dsT_MI_LEVYPLAN.NameValue(row, "OENO_NM") == '') {
    
                    alert("기존사번에 입력하신 파견직사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                    document.getElementById("txtOENO_NO").focus();
                    return false;
                }
    
                // 성별
                if( dsT_MI_LEVYPLAN.NameValue(row, "MF_TAG") == '' ) {
                    alert("성별는 필수 입력사항입니다.");
                    document.getElementById("cmbMF_TAG").focus();
                    return false;
                }
            }
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부서별인원충원계획관리</td>
                    <td align="right" class="navigator">HOME/경영정보/사업계획/<font color="#000000">부서별인원충원계획관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사업년도&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">부&nbsp;&nbsp;서&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="85 "></col>
                    <col width="65 "></col>
                    <col width="85 "></col>
                    <col width="65 "></col>
                    <col width="160"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >부&nbsp;&nbsp;&nbsp;&nbsp;서</td>
                    <td class="padding2423" >
                        <input id="txtDPT_CD" name="txtDPT_CD" size="2"  maxlength="3" onChange="fnc_GetCommNm('A4','txtDPT_CD','txtDPT_NM');">
                        <input id="txtDPT_NM" name="txtDPT_NM" size="12" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgDPT_CD" name="imgDPT_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','부서','DEPT')"></a>
                    </td>
                    <td align="center" class="creamBold" >직&nbsp;&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD" name="cmbOCC_CD" style="width:100%">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >직&nbsp;&nbsp;&nbsp;&nbsp;군</td>
                    <td class="padding2423" align="left">
                        <select id="cmbHEAD_CD" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >직&nbsp;&nbsp;&nbsp;&nbsp;급</td>
                    <td class="padding2423" align="left">
                        <select id="cmbJOB_CD" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >직&nbsp;&nbsp;&nbsp;&nbsp;무</td>
                    <td class="padding2423" align="left">
                        <select id="cmbJIKMU_CD" style="width:100%">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >계획년월</td>
                    <td class="padding2423" align="left">
                        <select id="cmbHIR_YM" style="width:100%" >
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >충원사유</td>
                    <td class="padding2423" align="left">
                        <select id="cmbLEVY_CD" style="width:100%" onchange="fnc_ChgLEVY_CD()">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">기존사번</td>
                    <td class="padding2423">
                        <input id="txtOENO_NO" name="txtOENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtOENO_NM" name="txtOENO_NM" size="9" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold" >성&nbsp;&nbsp;&nbsp;&nbsp;별</td>
                    <td class="padding2423" align="left">
                        <select id="cmbMF_TAG" style="width:100%">
                            <option value='M'>남자</option>
                            <option value='W'>여자</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold" >주요업무</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtREMARK" name="txtREMARK" style="width:470px" onkeyup="fc_chk_byte(this,255);">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >사유상세</td>
                    <td class="padding2423" colspan="7">
                        <textarea id="txtLEVY_TXT"  name="txtLEVY_TXT" cols="115" rows="3" onkeyup="fc_chk_byte(this,1000);"></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_MI_LEVYPLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                  value="dsT_MI_LEVYPLAN">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'               align=center </C>
                                <C> id='PIS_YY'       width=60    name='사업년도'           align=center </C>
                                <C> id='LEVY_CD'      width=75    name='사유'               align=left   EditStyle=Lookup Data='dsCOMMON_G4:CODE:CODE_NAME'</C>
                                <C> id='DPT_NM'       width=100   name='부서'               align=left </C>
                                <C> id='OCC_CD'       width=70    name='근로구분'               align=center EditStyle=Lookup Data='dsCOMMON_A1:CODE:CODE_NAME'</C>
                                <C> id='HEAD_CD'      width=70    name='직군'               align=center EditStyle=Lookup Data='dsCOMMON_B1:CODE:CODE_NAME'</C>
                                <C> id='JOB_CD'       width=70    name='직급'               align=center EditStyle=Lookup Data='dsCOMMON_JOB:COMM_CD:COMM_NM'</C>
                                <C> id='JIKMU_CD'     width=120   name='직무'               align=left   EditStyle=Lookup Data='dsCOMMON_DUTY:COMM_CD:COMM_NM'</C>
                                <C> id='HIR_YM'       width=70    name='계획년월'           align=center </C>
                                <C> id='OENO_NM'      width=80    name='성명;(계약직전환)'  align=center </C>
                                <C> id='MF_TAG'       width=60    name='성별'               align=center value={decode(MF_TAG, 'M', '남자', '여자')}</C>
                                <C> id='REMARK'       width=150   name='주요업무'           align=left   </C>
                                <C> id='LEVY_TXT'     width=250   name='사유상세'           align=left   </C>
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
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_MI_LEVYPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY      Ctrl=txtPIS_YY       Param=value </C>
        <C> Col=DPT_CD      Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM      Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=TENO_NO     Ctrl=txtTENO_NO      Param=value </C>
        <C> Col=JOB_CD      Ctrl=cmbJOB_CD       Param=value </C>
        <C> Col=JOB_NM      Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=JOB_GBN     Ctrl=txtJOB_GBN      Param=value </C>
        <C> Col=HIR_YM      Ctrl=cmbHIR_YM       Param=value </C>
        <C> Col=HEAD_CD     Ctrl=cmbHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM     Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=LEVY_CD     Ctrl=cmbLEVY_CD      Param=value </C>
        <C> Col=LEVY_NM     Ctrl=txtLEVY_NM      Param=value </C>
        <C> Col=JIKMU_CD    Ctrl=cmbJIKMU_CD     Param=value </C>
        <C> Col=JIKMU_NM    Ctrl=txtJIKMU_NM     Param=value </C>
        <C> Col=OCC_CD      Ctrl=cmbOCC_CD       Param=value </C>
        <C> Col=OCC_NM      Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=MF_TAG      Ctrl=cmbMF_TAG       Param=value </C>
        <C> Col=LEVY_TXT    Ctrl=txtLEVY_TXT     Param=value </C>
        <C> Col=REMARK      Ctrl=txtREMARK       Param=value </C>
        <C> Col=OENO_NO     Ctrl=txtOENO_NO      Param=value </C>
        <C> Col=OENO_NM     Ctrl=txtOENO_NM      Param=value </C>
        <C> Col=NDPT_CD     Ctrl=txtNDPT_CD      Param=value </C>
    '>
</object>
