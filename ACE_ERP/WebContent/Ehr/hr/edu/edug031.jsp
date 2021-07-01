<!--
    ************************************************************************************
    * @Source         : edug031.jsp                                                    *
    * @Description    : 일지등록 PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2017/04/04      이동훈        최초작성
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="Ehr.common.*" %>

<html>

<head>
<title>OJT 일지등록</title>
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

    <!-- 첨부 파일을 위해 -->
    <jsp:include page="../../common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->

    <script language="javascript" >


        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var ENO_NO    = opener.eno_no;
            var TRA_WEEK  = opener.tra_week;
            var TRA_YMD   = opener.tra_ymd;
            var STATUS     = opener.status;
                     
            dsT_CD_OJT.ClearData();

            dsT_CD_OJT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SHR_31&ENO_NO="+ENO_NO+"&TRA_WEEK="+TRA_WEEK+"&TRA_YMD="+TRA_YMD;
            dsT_CD_OJT.Reset();

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

            var TRA_YMD = dsT_CD_OJTREPORT.NameValue(1, "TRA_YMD");

            if(fnc_SaveItemCheck()) {

            	if(!verifyOjtDate('txtTRA_YMD')){
            		return;
            	}

                trT_CD_OJTREPORT.KeyValue = "tr01(I:SAV=dsT_CD_OJTREPORT, O:RELOAD=dsT_CD_OJTREPORT2)";
                trT_CD_OJTREPORT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SAV&ENO_NO="+opener.eno_no+"&TRA_WEEK="+opener.tra_week+"&TRA_YMD="+TRA_YMD;
                trT_CD_OJTREPORT.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete(gubun) {

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
        function fnc_AddNew(gubun) {

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

            if (!dsT_CD_OJTREPORT.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;
        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {


        	
            if(opener.status == "저장"){
            	
                
            }else if(opener.status == "상신"){
            	
                fnc_ChangeStateElement(false, "txtTRA_PLACE");
                fnc_ChangeStateElement(false, "txtTRA_SUBJECT");
                fnc_ChangeStateElement(false, "txtDAYTRA_ENO_NO");
                fnc_ChangeStateElement(false, "txtDAYTRA_ENO_NM");  
                fnc_ChangeStateElement(false, "ImgDayTraEnoNo");                
                fnc_ChangeStateElement(false, "txtTRA_CONTENT");
                fnc_ChangeStateElement(false, "txtTRA_REMARK");     
            	
            }else if(opener.status == "완료"){
            	
                fnc_ChangeStateElement(false, "txtTRA_PLACE");
                fnc_ChangeStateElement(false, "txtTRA_SUBJECT");
                fnc_ChangeStateElement(false, "txtDAYTRA_ENO_NO");
                fnc_ChangeStateElement(false, "txtDAYTRA_ENO_NM");  
                fnc_ChangeStateElement(false, "ImgDayTraEnoNo");                
                fnc_ChangeStateElement(false, "txtTRA_CONTENT");
                fnc_ChangeStateElement(false, "txtTRA_REMARK");                 	

            }	
        	
            // 데이터 조회
            fnc_SearchList();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_OJTREPORT.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            opener.fnc_SearchList2();

            window.close();

        }

        
        /*****************************************************
         *      상신                                                *
         ****************************************************/
        function fnc_Submit() {


            var TRA_YMD = dsT_CD_OJTREPORT.NameValue(1, "TRA_YMD");
            
        	// DataSet의 변경 여부 확인
            if ( dsT_CD_OJTREPORT.IsUpdated ) {
				alert("저장한 후 상신하시기 바랍니다.");
                return false;
            }

            if (confirm("상신이후에는 수정이 불가능합니다. 상신하시겠습니까?") == false) return;

            dsT_CD_OJTREPORT.UseChangeInfo = "false";            
            
            trT_CD_APPROVAL.KeyValue = "tr01(I:SAV=dsT_CD_OJTREPORT)";      
            trT_CD_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SAV_01&ENO_NO="+opener.eno_no+"&TRA_WEEK="+opener.tra_week+"&TRA_YMD="+TRA_YMD;
            trT_CD_APPROVAL.post();

            alert("상신이 완료되었습니다");

            window.close();
            
        }        
        
        
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        //입력 상태창
        var elementList = new Array(     "txtPLACE_TXT"
                                        ,"txtTRA_YMD"
                                        ,"btnImgYmd"
                                        ,"txtSBJ_TXT"
                                        ,"txtEDU_TXT"
                                        ,"txtPPS_TXT"
                                        ,"txtIDEA_TXT" );


        function fnc_UsrGetEnoNm(gbn) {

            var obj = new String();

            if (gbn == 'DAYTRA_ENO_NO') {

                obj = fnc_GetEnoNm("txtDAYTRA_ENO_NO");

                document.getElementById("txtDAYTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtDAYTRA_ENO_NM").value = obj.eno_nm;
            }
        }

        function fnc_UsrGetEnoNo(gbn) {
        	if (gbn == 'DAYTRA_ENO_NO') {
        		fnc_GetEnoNo('txtDAYTRA_ENO_NM', 'txtDAYTRA_ENO_NO');
        	}

        	fnc_UsrGetEnoNm(gbn);

        }

        function fnc_Popup(gbn) {
            var obj = new String();

            if (gbn == 'DAYTRA_ENO_NO') {
                // 정규직 재직자만
                obj = fnc_emplPopup('txtDAYTRA_ENO_NO','txtDAYTRA_ENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtDAYTRA_ENO_NO").value = obj.eno_no;
                document.getElementById("txtDAYTRA_ENO_NM").value = obj.eno_nm;
            }

        }

        function verifyOjtDate(p_value){

        	var obj = document.getElementById(p_value);
        	if( removeChar(opener.dsT_CD_OJTPLAN.NameValue(opener.dsT_CD_OJTPLAN.RowPosition, "PLAN_STR_YMD"),'-') > removeChar(obj.value,'-')
        		|| removeChar(obj.value,'-') > removeChar(opener.dsT_CD_OJTPLAN.NameValue(opener.dsT_CD_OJTPLAN.RowPosition, "PLAN_END_YMD"),'-') )
        	{
        		alert("교육날자를 확인하십시오.");
        		document.getElementById(obj.id).value="";
        		document.getElementById(obj.id).focus();
        		return false;
        	}

        	return true;

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTORESULT) |
    | 3. 사용되는 Table List(T_CD_MENTORESULT)        |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJTREPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload용 데이터셋 -->
    <Object ID="dsT_CD_OJTREPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)     |
    | 3. 사용되는 Table List(T_CD_MENTO)            |
    +----------------------------------------------->
    <Object ID="dsT_CD_OJT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CD_MENTO                    |
    | 3. Table List : T_CD_MENTO                |
    +----------------------------------------------->
    <Object ID ="trT_CD_OJTREPORT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CD_OJTREPORT)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_CD_APPROVAL) |
    | 3. 사용되는 Table List(T_CD_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_CD_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_CD_OJTREPORT)">
    </Object>
    
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJTREPORT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_OJTREPORT.CountRow );
            dsT_CD_OJTREPORT.RowPosition = 1;

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJTREPORT Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_OJT Event="OnLoadCompleted(iCount)">


        var ENO_NO  = opener.eno_no;
        var TRA_WEEK  = opener.tra_week;

        //alert(opener.gbn);
        
        if (iCount > 0) {
        	var today = gcurdate.replace("-","").replace("-","");
        	var STR_YMD = dsT_CD_OJT.NameValue(1, "STR_YMD").replace("-","").replace("-","");
        	var END_YMD = dsT_CD_OJT.NameValue(1, "END_YMD").replace("-","").replace("-","");

			if (STR_YMD > today || END_YMD < today) {
                //모든창 막기
                fnc_DisableElementAll(elementList);

                //document.getElementById("imgSave").disabled = true;
                //document.getElementById("imgSave").style.display = "none";

            }
            else {
                fnc_EnableElementAll(elementList);
            }

            // 구분이 수정이면
            if (opener.gbn == "2") {

                dsT_CD_OJTREPORT.ClearData();

                dsT_CD_OJTREPORT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.g.edug030.cmd.EDUG030CMD&S_MODE=SHR_32&ENO_NO="+opener.eno_no+"&TRA_WEEK="+opener.tra_week+"&TRA_YMD="+opener.tra_ymd;
                dsT_CD_OJTREPORT.Reset();

                //교육일자를 수정못하게 막기
                fnc_ChangeStateElement(false, "txtTRA_YMD");
                fnc_ChangeStateElement(false, "ImgTraYmd");

            }
            else {


                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow함
                if (dsT_CD_OJTREPORT.CountColumn == 0) {
                    dsT_CD_OJTREPORT.setDataHeader("ENO_NO:STRING:NOTNULL, TRA_WEEK:STRING, TRA_YMD:STRING, TRA_PLACE:STRING, TRA_SUBJECT:STRING, TRA_ENO_NO:STRING, TRA_CONTENT:STRING, TRA_REMARK:STRING, FILE_NAME:STRING, FILE_URL:STRING");
                }


                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_CD_OJTREPORT.AddRow();

                dsT_CD_OJTREPORT.NameValue(1, "ENO_NO")   = opener.eno_no;
                dsT_CD_OJTREPORT.NameValue(1, "TRA_WEEK") = opener.tra_week;
                dsT_CD_OJTREPORT.NameValue(1, "TRA_YMD")  = gcurdate;

                document.getElementById('txtTRA_PLACE').focus();
            }

            var key = "cdpd031"
                    + dsT_CD_OJTREPORT.NameValue(1, "ENO_NO")
                    + dsT_CD_OJTREPORT.NameValue(1, "TRA_WEEK")
                    + dsT_CD_OJTREPORT.NameValue(1, "TRA_YMD");

            //첨부파일 리스트를 가지고옴
            //fnc_GetFileList(key);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_OJT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <script for=dsT_CD_OJTREPORT2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("조회된 데이터가 없습니다.");
            return;
        }

    </script>



    <!-- 트랜젝션 성공. -->
    <script for=trT_CD_OJTREPORT event="OnSuccess()">

    	alert("정상적으로 저장되었습니다.");
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CD_OJTREPORT event="OnFail()">

        cfErrorMsg(this);

    </script>


    <!-- 파일 그리드 클릭시 다운로드 되게 -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
        if(row > 0) {
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
            // 첨부 파일이 존재하는 경우만 수행하게~
            if (vFILE_NAME != "" && vFILE_URL != "") {
                cfDownload(vFILE_NAME, vFILE_URL);
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
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ReportOver.gif',1)">   <img src="../../images/button/btn_ReportOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">   <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                	<col width="90"></col>
                    <col width="60"></col>
                    <col width="215"></col>
                    <col width="60"></col>
                    <col width="145"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                	<td align="center" class="blueBold">대상자</td>
                    <td align="center" class="blueBold">사번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">직위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="blueBold">책임지도사원</td>
                    <td align="center" class="blueBold">사번</td>
                    <td class="padding2423">
                        <input id="txtTRA_ENO_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_ENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">소속</td>
                    <td class="padding2423">
                        <input id="txtMDPT_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">직위</td>
                    <td class="padding2423">
                        <input id="txtMJOB_CD" size="3" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtMJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="136"></col>
                    <col width="120"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">팀</td>
                    <td class="padding2423" colspan="3">
                    	<input id="txtTRA_DPT_CD" size="4" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtTRA_DPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">팀장</td>
                    <td class="padding2423">
                    	<input id="txtHEAD_EMP_NO" size="10" maxlength="10" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                        <input id="txtHEAD_EMP_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423" >
                        <input id="txtTRA_PLACE"  name="txtTRA_PLACE" style="width:100%" maxlength="50">
                    </td>
                    <td align="center" class="blueBold">교육일자</td>
                    <td class="padding2423" >
                        <input name="txtTRA_YMD" id="txtTRA_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '교육일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) verifyOjtDate('txtTRA_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTraYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgTraYmd" name="ImgTraYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTRA_YMD','','630','180');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">지도항목</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtTRA_SUBJECT" name="txtTRA_SUBJECT" style="width:100%" maxlength="4000">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">지도사원</td>
                    <td class="padding2423" colspan="3">
                    	<input id="txtDAYTRA_ENO_NO" size="8" maxlength="8" style="ime-mode:disabled" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm('DAYTRA_ENO_NO');" onChange="fnc_UsrGetEnoNm('DAYTRA_ENO_NO');">
                        <input id="txtDAYTRA_ENO_NM" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo('DAYTRA_ENO_NO');" onchange="fnc_UsrGetEnoNo('DAYTRA_ENO_NO');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDayTraEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgDayTraEnoNo" name="ImgDayTraEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('DAYTRA_ENO_NO')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtTRA_CONTENT"  name="txtTRA_CONTENT" cols="112" rows="15" maxlength="4000" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육생건의</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtTRA_REMARK"  name="txtTRA_REMARK" cols="112" rows="10" maxlength="2000" ></textarea>
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
<!-- 멘토(Mentor)등록 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CD_OJT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD        Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=TRA_ENO_NO       Ctrl=txtTRA_ENO_NO       Param=value </C>
        <C> Col=TRA_ENO_NM       Ctrl=txtTRA_ENO_NM       Param=value </C>
        <C> Col=MDPT_CD       Ctrl=txtMDPT_CD       Param=value </C>
        <C> Col=MDPT_NM       Ctrl=txtMDPT_NM       Param=value </C>
        <C> Col=MJOB_CD       Ctrl=txtMJOB_CD       Param=value </C>
        <C> Col=MJOB_NM       Ctrl=txtMJOB_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD       Param=value </C>
        <C> Col=TRA_DPT_CD        Ctrl=txtTRA_DPT_CD        Param=value </C>
        <C> Col=TRA_DPT_NM        Ctrl=txtTRA_DPT_NM        Param=value </C>
        <C> Col=HIR_YMD       		Ctrl=txtHIR_YMD       Param=value </C>
        <C> Col=TRA_DUTY        	Ctrl=txtTRA_DUTY        Param=value </C>
        <C> Col=HEAD_EMP_NO        Ctrl=txtHEAD_EMP_NO        Param=value </C>
        <C> Col=HEAD_EMP_NM        Ctrl=txtHEAD_EMP_NM        Param=value </C>
    '>
</object>

<!-- 멘토(Mentor)상담일지 테이블 -->
<object id="bndT_CD_MENTORESULT"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",      Value="dsT_CD_OJTREPORT">
    <Param Name="BindInfo",    Value='
        <C>Col=TRA_YMD        Ctrl=txtTRA_YMD       Param=value </C>
        <C>Col=TRA_PLACE       Ctrl=txtTRA_PLACE      Param=value </C>
        <C>Col=TRA_SUBJECT         Ctrl=txtTRA_SUBJECT        Param=value </C>
        <C>Col=TRA_ENO_NO    Ctrl=txtDAYTRA_ENO_NO        Param=value </C>
        <C>Col=TRA_ENO_NM    Ctrl=txtDAYTRA_ENO_NM        Param=value </C>
        <C>Col=TRA_CONTENT         Ctrl=txtTRA_CONTENT        Param=value </C>
        <C>Col=TRA_REMARK        Ctrl=txtTRA_REMARK       Param=value </C>
        <C>Col=FILE_NAME       Ctrl=txtFILE_NAME      Param=value </C>
        <C>Col=FILE_URL        Ctrl=txtFILE_URL       Param=value </C>
    '>
</object>


