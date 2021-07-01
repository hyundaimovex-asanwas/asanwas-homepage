    <!--*************************************************************************
    * @source      : welh021.jsp                                                                                          *
    * @description : 중식비  PAGE                                                                           *
    *****************************************************************************
    * DATE            AUTHOR        DESCRIPTION                                                                   *
    *----------------------------------------------------------------------------
    * 2006/12/28            채갑병              최초작성                                                                *
    ***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
    <title>  중식비(welh010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">

        var btnList = 'TFTTTTFT';
        var FLAG_SHR = "";        // 검색 옵션 저장 변수

        /********************************************
         * 01. 조회 함수_List 형태의 조회               *
         ********************************************/
        function fnc_SearchList() {
            var tmpST = document.form1.txtPIS_YM_SHR.value;
            var PIS_YY_SHR = "";
            var PIS_MM_SHR = "";

            if( tmpST.length != 0 && tmpST.length != ""){
                PIS_YY_SHR = tmpST.substr(0,4);
                PIS_MM_SHR = tmpST.substr(5);
            }else{
                alert("검색하려는 해당년월을 입력하십시오.");
                return;
            }

            FLAG_SHR = document.form1.hidGBN_SHR.value;

            //차량유지비/ /중식비 조회
            //var GBN2_TAG_SHR = document.getElementById("cmbGBN2_TAG_SHR").value; // 지역
            var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위
            var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 부서
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;

            dsT_WL_CTLNBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&GBN2_TAG_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_WL_CTLNBOOK.reset();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회               *
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {
            // save
            trT_WL_CTLNBOOK.KeyValue = "tr01(I:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK)";
            trT_WL_CTLNBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=SAV";
            trT_WL_CTLNBOOK.post();
        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_WL_CTLNBOOK.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_WL_CTLNBOOK.ColumnString(dsT_WL_CTLNBOOK.RowPosition,dsT_WL_CTLNBOOK.ColumnIndex("ENO_NM")) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_WL_CTLNBOOK.DeleteRow(dsT_WL_CTLNBOOK.RowPosition);

            trT_WL_CTLNBOOK.KeyValue = "tr01(I:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK)";
            trT_WL_CTLNBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=DEL";
            trT_WL_CTLNBOOK.post();

        }
        /********************************************
         * 04. 초기화 함수                                *
         ********************************************/
        function fnc_DeleteAll() {
			var tmpST = document.form1.txtPIS_YM_SHR.value;
			var PIS_YY_SHR = "";
            var PIS_MM_SHR = "";

            if (dsT_WL_CTLNBOOK.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if( tmpST.length != 0 && tmpST.length != ""){
                PIS_YY_SHR = tmpST.substr(0,4);
                PIS_MM_SHR = tmpST.substr(5);
            }else{
                alert("초기화하려는 해당년월을 입력하십시오.");
                return;
            }

            // 초기화 여부를 물어 본다.
            if (confirm(PIS_YY_SHR+"년 "+PIS_MM_SHR+"월의 자료를 초기화하시겠습니까?") == false) return;
			dsT_WL_CTLNBOOK.DeleteAll();

            trT_WL_CTLNBOOK.KeyValue = "tr01(I:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK)";
            trT_WL_CTLNBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=INIT&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR;
            trT_WL_CTLNBOOK.post();

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {


            var tmpST = document.form1.txtPIS_YM_SHR.value;
            var PIS_YY_SHR = "";
            var PIS_MM_SHR = "";

            if( tmpST.length != 0 && tmpST.length != ""){
                PIS_YY_SHR = tmpST.substr(0,4);
                PIS_MM_SHR = tmpST.substr(5);
            }else{
                alert("검색하려는 해당년월을 입력하십시오.");
                return;
            }

            //차량유지비/ /중식비 조회
            var GBN2_TAG_SHR = document.getElementById("cmbGBN2_TAG_SHR").value; // 지역
            var JOB_CD_SHR = document.getElementById("txtJOB_CD_SHR").value; // 직위
            var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // 부서
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;


            var url = "welh010_PV.jsp?&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&GBN2_TAG_SHR="+GBN2_TAG_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /********************************************
         * 06. 엑셀 저장 함수                           *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_WL_CTLNBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_WL_CTLNBOOK.GridToExcel("중식비", '', 225)
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            //이곳에 해당 코딩을 입력 하세요

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_WL_CTLNBOOK.CountColumn == 0) {
                alert("조회후 신규입력이 가능하니다.");
                return false;
            }

            dsT_WL_CTLNBOOK.AddRow();

            var PIS_YM = document.form1.txtPIS_YM.value;//일괄처리년도

        //    dsT_WL_CTLNBOOK.NameValue(dsT_WL_CTLNBOOK.RowPosition,"PIS_YY") = dsT_WL_CTLNBOOK.NameValue(1,"PIS_YY");
        //    dsT_WL_CTLNBOOK.NameValue(dsT_WL_CTLNBOOK.RowPosition,"PIS_MM") = dsT_WL_CTLNBOOK.NameValue(1,"PIS_MM");

            dsT_WL_CTLNBOOK.NameValue(dsT_WL_CTLNBOOK.RowPosition,"PIS_YY") = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            dsT_WL_CTLNBOOK.NameValue(dsT_WL_CTLNBOOK.RowPosition,"PIS_MM") = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);

            document.form1.txtENO_NO.focus();
        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 10. 초기화 함수                              *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("txtJOB_CD_SHR").value = "";
            document.getElementById("txtJOB_NM_SHR").value = "";
            document.getElementById("cmbGBN2_TAG_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            // 초기화
            document.form1.hidGBN_SHR.value="INS";
            document.getElementById("resultMessage").innerText = ' ';

            fnc_DisableElementAll(elementList);

            dsT_WL_CTLNBOOK.ClearData();
        }

        /********************************************
         * 11. 화면 종료(닫기)                          *
         ********************************************/
        function fnc_Exit() {
            if (dsT_WL_CTLNBOOK.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                    *
         ********************************************/
        function fnc_SearchItemCheck() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 13. 저장 유효성 체크                         *
         ********************************************/
        function fnc_SaveItemCheck() {
            if ( !dsT_WL_CTLNBOOK.isUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분          *
         ********************************************/
        function fnc_OnLoadProcess() {
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];

            cfStyleGrid(form1.grdT_WL_CTLNBOOK,15,"true","true");      // Grid Style 적용
			document.getElementById("resultMessage").innerText = '대상 선정 > 저장 > 일괄생성 > 중식대공제 입력 > 저장';
            fnc_DisableElementAll(elementList);
        }

        /********************************************
         * 15. 단축키 처리                          *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일           *
         ********************************************/
        function fnc_FormActive(strID, winstat) {
            //if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
        }


        /********************************************
         * 날짜 형식 유효성 체크                                    *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        function fnc_Create(){

            //생성조건
            var PIS_YM = document.form1.txtPIS_YM.value;//일괄처리년도

            if(PIS_YM.trim().length == 0){
                alert("일괄처리년도를 입력하세요.");
                document.getElementById("txtPIS_YM").focus();
                return false;
            }else if(PIS_YM.trim().length != 7){
                alert("일괄처리년도가 올바르지 않습니다.");
                document.getElementById("txtPIS_YM").focus();
                return false;
            }

            PIS_YY_SHR = PIS_YM.substr(0,4);
            PIS_MM_SHR = PIS_YM.substr(5);

            dsT_WL_CTLNBOOK_01.DataId = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh010.cmd.WELH010CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&GBN2_TAG_SHR="+""+"&JOB_CD_SHR="+""+"&DPT_CD_SHR="+""+"&FLAG_SHR="+""+"&ENO_NO_SHR="+"";
            dsT_WL_CTLNBOOK_01.Reset();

            if(dsT_WL_CTLNBOOK_01.countrow != 0){
                if(!confirm("이미 생성된 데이터가 있습니다. 다시 일괄생성을 하시겠습니까?")){
                    return false;
                }

            }else{
                if(!confirm("일괄생성을 하시겠습니까?")){
                    return false;
                }
            }

            dsT_WL_CTLNBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=INS_01&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR
            dsT_WL_CTLNBOOK.Reset();
        }

        //입력 element 이름
        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"medCAR_AMT"
                                    ,"medDEL1_AMT"
                                    ,"medDEL2_AMT");

        //제외 시킬 항목
        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"medTRA_AMT"
                                    ,"medLUN_AMT");




         /********************************************
         * 입력필드 사용 가능하게(Enable)                *
         ********************************************/
        function enableInput(){
            document.form1.txtENO_NO.readOnly = false;
            document.form1.txtENO_NO.className = "";
            document.getElementById("imgENO_NO").disabled = false;

            form1.medNO_TAX.Enable = "true";
            form1.medCAR_AMT.Enable = "true";
            form1.medTRA_AMT.Enable = "true";
            form1.medSUM_AMT.Enable = "true";
            form1.medLUN_AMT.Enable = "true";
            form1.medDPT_NM.Enable = "true";
            form1.medDEL1_AMT.Enable = "true";
            form1.medDEL2_AMT.Enable = "true";
        }

        /********************************************
         * 입력필드 사용 불가능하게(Disable)                *
         ********************************************/
        function disableInput(){
            document.form1.txtENO_NO.readOnly = true;
            document.form1.txtENO_NO.className = "input_ReadOnly";
            document.getElementById("imgENO_NO").disabled = true;

            form1.medNO_TAX.Enable = "false";
            form1.medCAR_AMT.Enable = "false";
            form1.medTRA_AMT.Enable = "false";
            form1.medSUM_AMT.Enable = "false";
            form1.medLUN_AMT.Enable = "false";
            form1.medDPT_NM.Enable = "false";
            form1.medDEL1_AMT.Enable = "false";
            form1.medDEL2_AMT.Enable = "false";
        }


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

            if(obj.eno_no != "") {

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtJOB_CD").value = obj.job_cd;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
                document.getElementById("txtDPT_CD").value = obj.dpt_cd;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtOCC_CD").value = obj.occ_cd;

            } else {

                document.getElementById("txtENO_NO").value = "";
                document.getElementById("txtENO_NM").value = "";
                document.getElementById("txtJOB_CD").value = "";
                document.getElementById("txtJOB_NM").value = "";
                document.getElementById("txtDPT_CD").value = "";
                document.getElementById("txtDPT_NM").value = "";
                document.getElementById("txtOCC_CD").value = "";

            }
        }

        /*****************************
         * 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
                dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.wel.h.welh021.cmd.WELH021CMD&S_MODE=SHR_03";
                trFILE_UPLOAD.post();

            }

        }

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)            *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_CTLNBOOK)             |
    | 3. 사용되는 Table List(T_WL_CTLNBOOK)                    |
    +------------------------------------------------------>
    <Object ID="dsT_WL_CTLNBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton              |
    | 2. 이름 : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_CTLNBOOK)             |
    | 3. 사용되는 Table List(T_WL_CTLNBOOK)                    |
    +------------------------------------------------------>
    <Object ID="dsT_WL_CTLNBOOK_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <Param Name="SubsumExpr"        Value="total">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용                                            |
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_DININGUSE)            |
    | 3. 사용되는 Table List(T_WL_DININGUSE)                   |
    +------------------------------------------------------>
    <Object ID="dsT_WL_DININGUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">

    </Object>


    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_CTLNBOOK)                 |
    | 3. 사용되는 Table List(T_WL_CTLNBOOK)                    |
    +------------------------------------------------------>
    <Object ID="trT_WL_CTLNBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK,I:dsT_WL_CTLNBOOK=dsT_WL_CTLNBOOK)">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                      *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CTLNBOOK Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_CTLNBOOK.RealCount(0, 0));

            if( FLAG_SHR == "EXL" ){
                fnc_ToExcel();
            }else if( FLAG_SHR == "PRN" ){
                fnc_Print();
            }

			for(i=1;i<=iCount;i++){
                //dsT_WL_CTLNBOOK.UserStatus(i) = 1;
            }

            //초기화
            FLAG_SHR = "";
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

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직              |
    +------------------------------------------------------>
    <Script For=dsT_WL_CTLNBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_WL_CTLNBOOK_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때      |
    +------------------------------------------------------>
    <Script For=dsT_WL_CTLNBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_WL_CTLNBOOK_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                              |
    +------------------------------------------------------>
    <script for=trT_WL_CTLNBOOK event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                 |
    +------------------------------------------------------>
    <script for=trT_WL_CTLNBOOK event="OnFail()">
        alert(trT_WL_CTLNBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CTLNBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            if(dsT_WL_CTLNBOOK.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_CTLNBOOK event=CanRowPosChange(row)>

    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- 캘린더 프레임-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">중식비 산정</td>
                    <td align="right" class="navigator">HOME/복리후생/<font color="#000000">중식비 산정</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="80"></col>
                            <col width="160"></col>
                            <col width="80"></col>
                            <col width="160"></col>
                            <col width="80"></col>
                            <col width="*"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">해당년월</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','40','116');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState" align="right">본사/지방</td>
                            <td class="padding2423" align="left" colspan="3">
                                <select name="cmbGBN2_TAG_SHR" id="cmbGBN2_TAG_SHR" style="width:70">
                                    <option value="">전체</option>
                                    <option value="1">본사</option>
                                    <option value="9">지방</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="searchState" align="right">소속별</td>
                            <td class="padding2423" align="left">
                                <input id="txtDPT_CD_SHR" style="width:30" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                            </td>
                            <td class="searchState" align="right">직위별</td>
                            <td class="padding2423" align="left">
                                <input id="txtJOB_CD_SHR" style="width:30" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');"> <input id="txtJOB_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
                            </td>
                            <td align="right" class="searchState">사 번&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
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
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width="110"></col>
                        <col width="80"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                        <td class="padding2423">
                            <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                            <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        </td>
                        <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                        <td class="padding2423">
                            <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">

                            <input type="hidden" id="txtDPT_CD">
                            <input type="hidden" id="txtDPT_NM">
                            <input type="hidden" id="txtJOB_CD">
                            <input type="hidden" id="txtOCC_CD">

                        </td>


                        <td align="center" class="creamBold">소&nbsp;&nbsp;속 </td>
                        <td class="padding2423">
                            <input id="txtJOB_NM" size="14" readonly class="input_ReadOnly" maxlength= "14">
                        </td>
                        <td align="center" class="creamBold"> 직&nbsp;&nbsp;위</td>
                        <td class="padding2423">
                            <input id="txtDPT_NM" size="14" readonly class="input_ReadOnly" maxlength= "14">
                        </td>
                    </tr>
                    <tr>

                        <td align="center" class="creamBold">중식대</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="medLUN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=7>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=MaxDecimalPlace         value=0>
                                <param name=VisibleMaxDecimal       value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="center" class="creamBold">중식대공제액</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="medDEL2_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=7>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=MaxDecimalPlace         value=0>
                                <param name=VisibleMaxDecimal       value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="center" class="creamBold">중식대지급액 </td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=7>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=MaxDecimalPlace         value=0>
                                <param name=VisibleMaxDecimal       value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td align="center" class="creamBold">과세금액</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="medNO_TAX" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=false>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=7>
                                <param name=Numeric                 value=true>
                                <param name=ShowLiteral             value="false">
                                <param name=Visible                 value="true">
                                <param name=MaxDecimalPlace         value=0>
                                <param name=VisibleMaxDecimal       value="true">
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState" width="430"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right" class="searchState">
                            처리년월
                            <input type="text" id="txtPIS_YM" style="ime-mode:disabled" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        </td>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
   						<td align="right"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','/images/button/BatchCreateOver.gif',1)">  <img src="/images/button/BatchCreateOn.gif" name="imgCreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Create()"></a></td>
   					<!--
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('welf020.xls', '<%=FILEURL %>/welf020.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                    </td>  -->
                    </tr>
                </table>
            </td>
        </tr>
    </table>
<!-- 조회 상태 테이블 끝 -->
    <!-- 조회 상태 테이블 끝 -->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_WL_CTLNBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                        <param name="DataID" value="dsT_WL_CTLNBOOK">
						<param name="SortView"					value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"   width="40"      name="NO"               align="center"  value={String(Currow)}</FC>
                            <FC> id="PIS_YY"        width="50"      name="년도"             align="center"  Edit=none       Show="false"</FC>
                            <FC> id="PIS_MM"        width="25"      name="월"               align="center"  Edit=none       Show="false"</FC>
                            <FC> id="DPT_CD"        width="80"      name="부서코드"         align="left"    Edit=none       Show="false"</FC>
                            <FC> id="DPT_NM"        width="100"     name="소속"             align="left"    Edit=none       LeftMargin="10"  SubBgColor="#99FFCC"   subsumtext="합   계"</FC>
                            <FC> id="OCC_CD"        width="70"      name="근로구분구분"         align="center"  Edit=none       Show="false"</FC>
                            <FC> id="JOB_CD"        width="50"      name="직위코드"         align="center"  Edit=none       Show="false"</FC>
                            <FC> id="JOB_NM"        width="90"      name="직위"             align="center"  Edit=none       SubBgColor="#99FFCC"</FC>
                            <FC> id="ENO_NO"        width="70"      name="사번"             align="center"  Edit=none       </FC>
                            <FC> id="ENO_NM"        width="70"      name="성명"             align="center"  Edit=none       SubBgColor="#99FFCC"    subsumtext={(subcount(ENO_NM)-1)&&"명"}</FC>
                            <C> id="CAR_AMT"    width="75"      name="차량유지비"           show="false"    align="right"   Edit=none   RightMargin="10" SubBgColor="#99FFCC"</C>
                            <C> id="TRA_AMT"    width="75"      name="교통비"               show="false"    align="right"   Edit=none   RightMargin="10" SubBgColor="#99FFCC"</C>
                            <C> id="LUN_CHK"    width="75"      name="현금지급"             Edit=True  EditStyle=CheckBox,Pointer=Hand   </C>
                            <G> name="중  식  대"  HeadBgColor="#F7DCBB"
                                <C> id="LUN_AMT"    width="75"  name="중식대"               align="right"    RightMargin="10" SubBgColor="#99FFCC"</C>
                                <C> id="DEL2_AMT"   width="75"  name="공제액"     align="right"        RightMargin="10" SubBgColor="#99FFCC"</C>
                                <C> id="SUM_AMT"    width="75"  name="지급액"     align="right"        RightMargin="10" SubBgColor="#99FFCC"   value="{(LUN_AMT-DEL2_AMT)}"</C>
	                            <C> id="NO_TAX"     width="75"      name="비과세"       align="right"        RightMargin="10" SubBgColor="#99FFCC"   value="{Greatest((LUN_AMT-DEL2_AMT-100000),0)}"</C>
                            </G>
                            <C> id="TAX_DPT"    width="70"        name="회계코드"      align="right"   Edit=none   LeftMargin="10" SubBgColor="#99FFCC"</C>
                            <C> id="TAX_DPTNM"    width="100"      name="회계부서"      align="right"   Edit=none   LeftMargin="10" SubBgColor="#99FFCC"</C>

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

    <input type="hidden" id="hidGBN_SHR" value="INS">

    </form>
    <!-- form 끝 -->

</body>
</html>

    <!--**************************************************************************************
    *                                                                                        *
    *   바인딩 컴포넌트                                                                          *
    *                                                                                        *
    ***************************************************************************************-->

    <!-- T_WL_DININGCD 설정 테이블 -->
    <object id="bndT_WL_CTLNBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_WL_CTLNBOOK">
        <Param Name="BindInfo", Value="
            <C>Col=ENO_NO       Ctrl=txtENO_NO      Param=value</C>
            <C>Col=ENO_NM       Ctrl=txtENO_NM      Param=value</C>
            <C>Col=DPT_CD       Ctrl=txtDPT_CD      Param=value</C>
            <C>Col=OCC_CD       Ctrl=txtOCC_CD      Param=value</C>
            <C>Col=JOB_CD       Ctrl=txtJOB_CD      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM          Param=value</C>
            <C>Col=JOB_NM       Ctrl=medJOB_NM2         Param=text</C>
            <C>Col=NO_TAX       Ctrl=medNO_TAX          Param=text</C>
            <C>Col=CAR_AMT      Ctrl=medCAR_AMT     Param=text</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM         Param=value</C>
            <C>Col=TRA_AMT      Ctrl=medTRA_AMT     Param=text</C>
            <C>Col=LUN_AMT      Ctrl=medLUN_AMT     Param=text</C>
            <C>Col=DEL1_AMT     Ctrl=medDEL1_AMT    Param=text</C>
            <C>Col=SUM_AMT      Ctrl=medSUM_AMT Param=text</C>
            <C>Col=DEL2_AMT     Ctrl=medDEL2_AMT    Param=text</C>
        ">
    </object>
