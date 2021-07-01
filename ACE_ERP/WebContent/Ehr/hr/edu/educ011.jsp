<!--
    ************************************************************************************
    * @Source         : educ011.jsp                                                    *
    * @Description    : 교육결과보고 PAGE                                              *
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
    <title>교육결과보고(educ011)</title>
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

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;
        var file_flag = '0';    //1:파일삭제시

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_EDUCATION.ClearData();

            trT_CM_EDUCATION.KeyValue = "SVL(O:SHR=dsT_CM_EDUCATION, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_CM_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ011.cmd.EDUC011CMD&S_MODE=SHR&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no+"&ENO_NO="+opener.eno_no;
            trT_CM_EDUCATION.post();


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

        // if(!confirm("단순 저장시 지정하신 결재선은 무시됩니다. 계속 하시겠습니까?")){
		//		return;
        //  }
        //	dsT_DI_APPROVAL.ClearData();

            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_CM_EDUCATION.KeyValue = "tr01(I:SAV=dsT_CM_EDUCATION, I:FILE=oFileListGDS, O:RELOAD=dsT_CM_EDUCATION2)";
            trT_CM_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ011.cmd.EDUC011CMD&S_MODE=SAV&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no+"&ENO_NO="+opener.eno_no;
            trT_CM_EDUCATION.post();

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

            if (!dsT_CM_EDUCATION.IsUpdated) {

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

            fnc_ComboSet();

            document.getElementById('txtENO_NO').value = opener.eno_no;
            document.getElementById('txtENO_NM').value = opener.eno_nm;

            // 파일 첨부용 데이터셋의 헤더 정보 설정.
            oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

            cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false");

            dsT_DI_APPROVAL.SetDataHeader(
	        					"GUN_YMD:STRING(10),"+			// 근태날짜
	                            "GUN_GBN:STRING(1),"+			// 근태결재구분
								"DPT_CD:STRING(3),"+			// 근태부서
								"DPT_NM:STRING(10),"+			// 근태부서명
								"SEQ_NO:STRING(1),"+			// 결재선
								"ENO_NO:STRING(10),"+			// 결재자사번
								"JOB_CD:STRING(10),"+			// 결재자직위
								"APP_TIME:STRING(10),"+			// 결재시간
								"PENO_NO:STRING(10),"+			// 상신자사번
								"APP_YN:STRING(10),"+			// 결재여부
								"ENO_NM:STRING(10),"+			// 결재자명
								"JOB_NM:STRING(10)"				// 직위명
								);

            // 공지사항 데이터 조회
            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CM_EDUCATION.IsUpdated)
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

                document.getElementById("txtABSTRACT_TXT").disabled    = false;
                document.getElementById("txtIMPRESSION_TXT").disabled    = false;
                document.getElementById("txtOPINION_TXT").disabled    = false;
                document.getElementById("txtRE_TARGET_TAG").disabled   = false;
                document.getElementById("txtSITE_TAG").disabled         = false;
                document.getElementById("cmbDEGREE_TAG").disabled      = false;

                document.getElementById("btnUPLOAD").disabled          = false;
                document.getElementById("btnDEL").disabled             = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtABSTRACT_TXT").disabled    = true;
                document.getElementById("txtIMPRESSION_TXT").disabled    = true;
                document.getElementById("txtOPINION_TXT").disabled    = true;
                document.getElementById("txtRE_TARGET_TAG").disabled   = true;
                document.getElementById("txtSITE_TAG").disabled         = true;
                document.getElementById("cmbDEGREE_TAG").disabled      = true;

                document.getElementById("btnUPLOAD").disabled          = true;
                document.getElementById("btnDEL").disabled             = true;

            }
        }


        /********************
         * 첨부파일 처리    *
         *******************/
        function fnc_FileUpload() {

            oFileListGDS.addrow();
            oFileListGDS.NameValue(oFileListGDS.RowPosition, "ENO_NO") = document.getElementById("txtENO_NO").value;

            oFileGF.OpenFileName = document.getElementById("txtFILE_NAME").value;

            oFileGF.open();

            if(oFileGF.SelectState == true)
            {
                document.getElementById("txtFILE_NAME").value = oFileGF.value;
                document.getElementById("txtFILE_URL2").value = '';
            }
            else {
                oFileListGDS.deleterow(oFileListGDS.RowPosition);
            }

        }

        /********************
         * 첨부파일 삭제    *
         *******************/
        function fnc_FileDelete() {
            // 서버에 저장된 파일경로와 화면에서 사용하는 임시파일경로가 같으면 삭제가능하게 한다.
            if (document.getElementById("txtFILE_URL").value != "" && document.getElementById("txtFILE_URL").value == document.getElementById("txtFILE_URL2").value) {

                file_flag = '1';

                document.getElementById("txtFILE_NAME").value = "";

                fnc_Save();
            }
            else {

                if (document.getElementById("txtFILE_NAME").value != "") {
                    document.getElementById("txtFILE_NAME").value = "";
                    document.getElementById("txtFILE_URL").value  = "";
                    document.getElementById("txtFILE_URL2").value = "";
                }
                else {
                    alert("삭제할 파일이 존재하지 않습니다.");
                }
            }
        }

        function fnc_link() {

            // 첨부 파일이 존재하는 경우만 수행하게~
            if (dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "FILE_NAME") != "" && document.getElementById("txtFILE_URL2").value != "") {
                cfDownload(dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "FILE_NAME"), document.getElementById("txtFILE_URL2").value);
            }

        }

        /********************
         * 상신    *
         *******************/
        function fnc_Report(){
        	if(dsT_DI_APPROVAL.CountRow < 1){
				alert("결재선을 한 곳 이상 지정해 주십시요");
				return false;
			}
			fnc_Save();
			trT_CM_EDUCATION.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_CM_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ011.cmd.EDUC011CMD&S_MODE=RPT&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no+"&ENO_NO="+opener.eno_no;
            trT_CM_EDUCATION.post();
        }

        //결재선지정
		function fnc_Approval(){

         	var STR_YMD_SHR = "";
			var END_YMD_SHR = "";
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = "<%=box.get("SESSION_DPTCD")%>";
			var EMP_NO      = "<%=box.get("SESSION_ENONO")%>";

			fnc_GetDiApproverDS(dsT_DI_APPROVAL, EMP_NO, EMPL_DPT_CD, "1", "1", STR_YMD_SHR, END_YMD_SHR, 10,"N");

            //강제로 IsUpdated 체크하게 만듬
            cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_TEMP);
            dsT_DI_APPROVAL.ClearData();

            for(var i=1; i<=dsT_DI_APPROVAL_TEMP.countrow; i++){
                dsT_DI_APPROVAL.addrow();

	            dsT_DI_APPROVAL.NameValue(i,"ENO_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NO");
	            dsT_DI_APPROVAL.NameValue(i,"ENO_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"ENO_NM");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_CD");
	            dsT_DI_APPROVAL.NameValue(i,"DPT_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"DPT_NM");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_CD") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_CD");
	            dsT_DI_APPROVAL.NameValue(i,"JOB_NM") = dsT_DI_APPROVAL_TEMP.NameValue(i,"JOB_NM");
	            dsT_DI_APPROVAL.NameValue(i,"SEQ_NO") = dsT_DI_APPROVAL_TEMP.NameValue(i,"SEQ_NO");	//결재선(결재순서)
	            dsT_DI_APPROVAL.NameValue(i,"GUN_YMD") = "99991231";//dsT_DI_DILIGENCE.NameValue(1,"PIS_YYMMDD");// 일별 근태에서 결재자 뜨지 않게 하기위해서...
	            dsT_DI_APPROVAL.NameValue(i,"PENO_NO") = "<%=box.get("SESSION_ENONO")%>";	//상신자 사번
				dsT_DI_APPROVAL.NameValue(i,"GUN_GBN") = "N";
				dsT_DI_APPROVAL.NameValue(i,"REQ_NO") = "";
            }

		}

		// Link
		function fnc_SiteTag(){
			var siteTag = document.getElementById("txtSITE_TAG").value;
			if(siteTag == ""){
				return;
			}
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION)|
    | 3. 사용되는 Table List(T_CM_EDUCATION)       |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload용 데이터셋 -->
    <Object ID="dsT_CM_EDUCATION2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="oFileListGDS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=oFileGF classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"        value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_APPROVAL)			 	   |
    | 3. 사용되는 Table List(T_DI_APPROVAL) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_APPROVAL_TEMP                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_TEMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_EDUCATION) |
    | 3. 사용되는 Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_EDUCATION, I:FILE=oFileListGDS, O:RELOAD=dsT_CM_EDUCATION2)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
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
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow );

            if (opener.rec_autho == "0") {               // 조회만 가능
                fnc_ColEnabled('D');
            }
            else if (opener.rec_autho == "1") {
                fnc_ColEnabled('E');
            }

            document.getElementById("txtFILE_URL2").value = document.getElementById("txtFILE_URL").value;

        }

    </Script>
    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_ColEnabled('E');

        } else {

            fnc_ColEnabled('D');

            fnc_HiddenElement("imgSave");
            fnc_HiddenElement("imgReport");
            fnc_HiddenElement("ImgSelectapproval");

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <script for=dsT_CM_EDUCATION2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("조회된 데이터가 없습니다.");
            return;
        }

        /** 데이터셋 복사 **/
        cfCopyDataSet(dsT_CM_EDUCATION2, dsT_CM_EDUCATION, "copyHeader=yes");
        document.getElementById("txtFILE_URL2").value = document.getElementById("txtFILE_URL").value;
    </script>



    <!-- 트랜젝션 성공. -->
    <script for=trT_CM_EDUCATION event="OnSuccess()">

        // 파일삭제시
        if (file_flag == '1') {

            document.getElementById("resultMessage").innerText = '* 첨부파일이 삭제되었습니다.';
            file_flag == '0';
        }
        else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_01");

            oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

        }

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_CM_EDUCATION event="OnFail()">

        cfErrorMsg(this);
        file_flag == '0';

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">교육결과보고</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
    	<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','/images/button/btn_ReportOver.gif',1)">  <img src="/images/button/btn_ReportOn.gif"     name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Report()"></a>
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
                    <col width="120"></col>
                    <col width="280"></col>
                    <col width="120"></col>
                    <col width="280"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">등 록 자</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" size="10"  class="input_ReadOnly" readOnly> <input id="txtENO_NM" name="txtENO_NM" size="16" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="padding2423" colspan="2" rowspan="6">
                    	<table width="350" border="0" cellspacing="0" cellpadding="0">
							<tr><td align="right">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSelectapproval','','/images/button/btn_SelectapprovalOver.gif',1)"> <img src="/images/button/btn_SelectapprovalOn.gif" name="ImgSelectapproval"  width="90" height="20" border="0" align="absmiddle" onClick="fnc_Approval()"></a>
							</td></tr>
                    		<tr><td class="padding2423">
							<comment id="__NSID__">
							<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:350px;height:100px;">
								<param name="DataID"				value="dsT_DI_APPROVAL">
								<param name="Format"				value="
									<C> id='REQ_NO'	width=40	name='등록번호'	align=center	show=false</C>
	            					<C> id='SEQ_NO'	width=40	name='NO'		align=center	</C>
	            					<C> id='DPT_NM'	width=80	name='부서'		align=center	</C>
									<C> id='JOB_NM'	width=60	name='직위'		align=center	</C>
									<C> id='ENO_NO'	width=100	name='사번'		align=center	show=false</C>
									<C> id='ENO_NM'	width=70	name='성명'		align=center	</C>
									<C> id='APP_YN'	width=70	name='결재여부'	align=center	Value={DECODE(APP_YN,'Y','결재','N','부결','미결')} </C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td></tr>
						</table>
					</td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육분야</td>
                    <td class="padding2423" >
                        <select id="cmbFIELD_CD" style="width:100%" disabled>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">학습기간</td>
                    <td class="padding2423" >
                        <input id="txtEDU_STR_YMD"  name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly" readOnly> ~
                        <input id="txtEDU_END_YMD"  name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" class="input_ReadOnly" readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">이수점수</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:80%;ime-mode:disabled;text-align:right;" class="input_ReadOnly" readOnly> 점
                    </td>


                </tr>
                <tr>
                    <td align="center" class="creamBold">교육장소</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TAG"  name="txtPLACE_TAG" style="width:100%" class="input_ReadOnly" readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">고용보험</td>
                    <td class="padding2423" >
                        <select id="cmbINS_YN" style="width:100%" disabled>
                        </select>
                    </td>

                </tr>
                <tr>
                	<td align="center" class="creamBold">과정코드</td>
                    <td class="padding2423" >
                        <input id="txtEDU_CD" name="txtEDU_CD" size="5"  class="input_ReadOnly" readOnly> <input id="txtEDU_NM" name="txtEDU_NM" size="30" class="input_ReadOnly"  readOnly>
                    </td>
                    <td align="center" class="creamBold">교육형태</td>
                    <td class="padding2423" >
                        <select id="cmbSHAPE_CD" style="width:100%" disabled>
                        </select>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">교육시간</td>
                    <td class="padding2423" >
                        <input id="txtTIME_NO"  name="txtTIME_NO" style="width:80%;ime-mode:disabled;text-align:right;" class="input_ReadOnly" readOnly> 시간
                    </td>
                    <td align="center" class="creamBold">교육기관</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM"  name="txtINT_NAM" style="width:100%" class="input_ReadOnly" readOnly>
                    </td>
                </tr>
                <tr>
                	<td align="center" class="creamBold">교육비용</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%" >
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  원
                    </td>
                    <td align="center" class="creamBold">환급금액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%" >
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
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
                    <td align="center" class="creamBold">주요내용요약</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtABSTRACT_TXT"  name="txtABSTRACT_TXT" cols="112" rows="10" maxlength="300" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">평가 및 소감</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtIMPRESSION_TXT"  name="txtIMPRESSION_TXT" cols="112" rows="10" maxlength="300" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">직무관련<br>개선방안</td>
                    <td class="padding2423" colspan="3">
                        <textarea id="txtOPINION_TXT"  name="txtOPINION_TXT" cols="112" rows="10" maxlength="300" ></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">학습추천대상</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtRE_TARGET_TAG"  name="txtRE_TARGET_TAG" style="width:100%" maxlength="30" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">관련자료</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtFILE_NAME" name="txtFILE_NAME" style="width:72%"  valid='maxlength=255' readonly style="cursor:hand" onClick="fnc_link()">&nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)"><img src="/images/button/FileAddOn.gif"   id="btnUPLOAD" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEL','','/images/button/FileDelOver.gif',3)">   <img src="/images/button/FileDelOn.gif"   id="btnDEL"    name="btnDEL"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete()"></a>
                        <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60"><input type=hidden id=txtFILE_URL2 name=txtFILE_URL2 size="60">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">참고사이트</td>
                    <td class="padding2423">
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="30" maxlength="300" >&nbsp;<input type="button" value="연결" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                    <td align="center" class="creamBold">학습만족도</td>
                    <td class="padding2423" >
                        <select id="cmbDEGREE_TAG" style="width:100%" >
                            <option value="1">상</option>
                            <option value="2">중</option>
                            <option value="3">하</option>
                        </select>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

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
<object id="bndT_CM_EDUCATION"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",      Value="dsT_CM_EDUCATION">
    <Param Name="BindInfo",    Value='
        <C>Col=ENO_NO          Ctrl=txtENO_NO         Param=value </C>
        <C>Col=ENO_NM          Ctrl=txtENO_NM         Param=value </C>
        <C>Col=FIELD_CD        Ctrl=cmbFIELD_CD       Param=value </C>
        <C>Col=SHAPE_CD        Ctrl=cmbSHAPE_CD       Param=value </C>
        <C>Col=EDU_CD          Ctrl=txtEDU_CD         Param=value </C>
        <C>Col=EDU_NM          Ctrl=txtEDU_NM         Param=value </C>
        <C>Col=EDU_STR_YMD     Ctrl=txtEDU_STR_YMD    Param=value </C>
        <C>Col=EDU_END_YMD     Ctrl=txtEDU_END_YMD    Param=value </C>
        <C>Col=TIME_NO         Ctrl=txtTIME_NO        Param=value </C>
        <C>Col=CPT_PNT         Ctrl=txtCPT_PNT        Param=value </C>
        <C>Col=INT_NAM         Ctrl=txtINT_NAM        Param=value </C>
        <C>Col=PLACE_TAG       Ctrl=txtPLACE_TAG      Param=value </C>
        <C>Col=COST_AMT        Ctrl=medCOST_AMT       Param=text  </C>
        <C>Col=INS_YN          Ctrl=cmbINS_YN         Param=value </C>
        <C>Col=RTN_AMT         Ctrl=medRTN_AMT        Param=text  </C>
        <C>Col=ABSTRACT_TXT    Ctrl=txtABSTRACT_TXT   Param=value </C>
        <C>Col=IMPRESSION_TXT    Ctrl=txtIMPRESSION_TXT   Param=value </C>
        <C>Col=OPINION_TXT    Ctrl=txtOPINION_TXT   Param=value </C>
        <C>Col=RE_TARGET_TAG   Ctrl=txtRE_TARGET_TAG  Param=value </C>
        <C>Col=SITE_TAG         Ctrl=txtSITE_TAG        Param=value </C>
        <C>Col=DEGREE_TAG      Ctrl=cmbDEGREE_TAG     Param=value </C>
        <C>Col=FILE_NAME       Ctrl=txtFILE_NAME      Param=value </C>
        <C>Col=FILE_URL        Ctrl=txtFILE_URL       Param=value </C>
    '>
</object>


<!-- 첨부파일용 바인딩 오브젝트 -->
<object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID"       Value="oFileListGDS">
    <Param Name="BindInfo"     Value='
        <C>Col=FILE_NAME       Ctrl=oFileGF           Param=Value</C>
        <C>Col=FILE_URL        Ctrl=oFileGF           Param=Value</C>
    '>
</object>