<!--
    ************************************************************************************
    * @Source         : educ021.jsp                                                    *
    * @Description    : 직무별교육이력 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  김학수   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

    boolean isMaster = false;
    boolean isSubMaster = false;

    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>나의직무별교육이력(educ021)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        var edu_cd      = '';
        var edu_nm      = '';
        var seq_no      = '';
        var eno_no      = '';
        var str_ymd     = '';
        var edu_autho   = '';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {


        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//학습자 사번

			fnc_DutyCheck();
			var JIKMU_CD = document.getElementById("txtJIKMU_CD_SHR").value;//년도

            if(JIKMU_CD == ""){
        		alert("해당년도를 입력하세요.");
                document.getElementById("txtJIKMU_CD_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("사번을 입력하세요.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("사번이 잘못되었습니다.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}


        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04, "+
        	                                "O:dsT_ED_EXCEPTER_05=dsT_ED_EXCEPTER_05)";
			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ021.cmd.EDUC021CMD&S_MODE=SHR&JIKMU_CD="+JIKMU_CD+"&ENO_NO="+ENO_NO;
			trT_CM_EDUCATION.Post();

			fnc_SaveResult();

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

            //이곳에 해당 코딩을 입력 하세요

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

        	var JIKMU_CD = document.getElementById("txtJIKMU_CD_SHR").value;//년도
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//학습자 사번

        	if(ENO_NO == ""){
        		alert("사번을 입력하세요.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("사번이 잘못되었습니다.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

            var url = "educ021_PV.jsp?eno_no="+ENO_NO+"&str_ymd="+JIKMU_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION_01.CountRow < 1 &&
                dsT_CM_EDUCATION_02.CountRow < 1 &&
                dsT_ED_LCTRHIST_03.CountRow < 1 &&
                dsT_CM_EDUCATION_04.CountRow < 1 &&
                dsT_ED_EXCEPTER_05.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }


/*          if(dsT_ED_EXCEPTER_05.CountRow > 0){
		      form1.grdT_ED_EXCEPTER_05.GridToExcel("예외자이력", '', 225);
            }
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.RunExcelSheetEx("사외교육이력", 1, 0);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.RunExcelSheetEx("사내강의이력", 1, 0);
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.RunExcelSheetEx("사내교육이력", 1, 0);
            }
            if(dsT_CM_EDUCATION_01.CountRow > 0){
                form1.grdT_CM_EDUCATION_01.RunExcelSheetEx("교육점수현황", 1, 0);
            }                         */



            if(dsT_CM_DUTYMST.CountRow > 0){
               // form1.grdT_CM_EDUCATION_01.GridToExcel("교육점수현황", "C:\\educ021.xls", 1+4);
                form1.grdT_CM_EDUCATION_01.SaveExcel("교육점수현황", true, true, false, "C:\\educ021.xls");
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.GridToExcel("공통교육이력", "C:\\educ021.xls", 1+32);
            }
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.GridToExcel("직무교육이력", "C:\\educ021.xls", 1+32);
            }
            if(dsT_ED_EXCEPTER_05.CountRow > 0){
                form1.grdT_ED_EXCEPTER_05.GridToExcel("기타교육이력"  ,  "C:\\educ021.xls", 1+32);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.GridToExcel("사내강의이력",  "C:\\educ021.xls", 1+32);
            }


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

            dsT_CM_EDUCATION_01.ClearData();
            dsT_CM_EDUCATION_02.ClearData();
            dsT_ED_LCTRHIST_03.ClearData();
            dsT_CM_EDUCATION_04.ClearData();
            dsT_ED_EXCEPTER_05.ClearData();



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
        function fnc_SaveResult() {

			// 강의시간 계산
			dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") = 0;
			for (var i = 1; i <= dsT_ED_LCTRHIST_03.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") = dsT_CM_DUTYMST.NameValue(1, "LCT_TIME") + dsT_ED_LCTRHIST_03.NameValue(i, "LCT_TIME");
			}
			// 공통역량 교육 건수 계산
			dsT_CM_DUTYMST.NameValue(1, "COM_FNSH") = dsT_CM_EDUCATION_02.CountRow;

			// 공통역량 교육 평균 계산
			dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = 0;
			for (var i = 1; i <= dsT_CM_EDUCATION_02.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = dsT_CM_DUTYMST.NameValue(1, "COM_AVG") + dsT_CM_EDUCATION_02.NameValue(i, "APP_VAL");
			}
            if (dsT_CM_EDUCATION_02.CountRow != 0) {
               dsT_CM_DUTYMST.NameValue(1, "COM_AVG") = dsT_CM_DUTYMST.NameValue(1, "COM_AVG") / dsT_CM_EDUCATION_02.CountRow;
            }

			// 직무역량 교육 건수 계산
			dsT_CM_DUTYMST.NameValue(1, "JOB_FNSH") = dsT_CM_EDUCATION_01.CountRow;

			// 직무역량 교육 평균 계산
			dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = 0;
			for (var i = 1; i <= dsT_CM_EDUCATION_01.CountRow; i++) {

			    dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") + dsT_CM_EDUCATION_01.NameValue(i, "APP_VAL");
			}
            if (dsT_CM_EDUCATION_02.CountRow != 0) {
               dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") = dsT_CM_DUTYMST.NameValue(1, "JOB_AVG") / dsT_CM_EDUCATION_01.CountRow;
            }

			// 기타교육 건수 계산
			dsT_CM_DUTYMST.NameValue(1, "ETC_CNT") = dsT_ED_EXCEPTER_05.CountRow;


        }
        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_DutyCheck() {
            var ENO_NO    = document.getElementById("txtENO_NO_SHR").value;

        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_DUTYMST=dsT_CM_DUTYMST)";
			trT_CM_EDUCATION.Action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ021.cmd.EDUC021CMD&S_MODE=SHR_00&&ENO_NO="+ENO_NO;
			trT_CM_EDUCATION.Post();
        }
        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

   			cfStyleGrid(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style 적용
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style 적용
			cfStyleGrid(form1.grdT_ED_EXCEPTER_05,0,"false","false");      // Grid Style 적용



            if (opener != null){
                document.getElementById("txtENO_NO_SHR").value = opener.eno_no;
                document.getElementById("txtENO_NM_SHR").value = opener.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
                document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            }
<%
    //관리자가 아니면 다른 사번으로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
<%
    }
    //소속부서담당자이거나 일반사용자의 경우 자신의 부서에서만 검색이 가능
    if(!isMaster) {
%>
            document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

           if (opener != null){

                window.close();

            } else {

                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

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


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EMPLIST)   |
    | 3. 사용되는 Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->

	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_EXCEPTER_05" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">


	    if (iCount == 0)    {

            alert("입사후 경력 - 직무코드 설정 후 작업바랍니다.");

        } else {

            document.getElementById("txtJIKMU_CD_SHR").value = dsT_CM_DUTYMST.NameValue(1, "JIKMU_CD");
            document.getElementById("txtJIKMU_NM").value     = dsT_CM_DUTYMST.NameValue(1, "DUTY_NM");
            document.getElementById("txtJIKMU_NM_UP").value  = dsT_CM_DUTYMST.NameValue(1, "UP_DUTY_NM");

        }
    </Script>


    <Script For=grdT_CM_EDUCATION_04 Event="OnDblClick(row, col)">
        var obj = new String();

        obj.edu_cd      = dsT_CM_EDUCATION_04.NameValue(row, "EDU_CD");
        obj.edu_nm      = dsT_CM_EDUCATION_04.NameValue(row, "EDU_NM");
        obj.seq_no      = dsT_CM_EDUCATION_04.NameValue(row, "SEQ_NO");
        obj.eno_no      = dsT_CM_EDUCATION_04.NameValue(row, "ENO_NO");
        obj.eno_nm      = document.getElementById("txtENO_NO_SHR").value;

        //obj.str_ymd     = dsT_ED_CHASULIST.NameValue(row, "STR_YMD");



        // 결과보고
        // 1: 등록, 2: 수정
        if (col == 'EDU_RPT' && dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "보고서작성") {
            if(dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "보고서작성"){
            	obj.gbn = "1";
            } else if(dsT_CM_EDUCATION_04.NameValue(row, "EDU_RPT") == "완료"){
            	obj.gbn = "2";
            }

            window.showModalDialog("/hr/edu/educ011.jsp", obj, "dialogWidth:860px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }



    </Script>
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_EXCEPTER_05 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무별교육현황</td>
                    <td align="right" class="navigator">HOME/교육관리/나의학습정보/<font color="#000000">직무별교육현황</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
			                	<col width="80"></col>
			                    <col width="180"></col>
			                    <col width="80"></col>
			                    <col width="100"></col>
			                    <col width="80"></col>
			                    <col width="*"></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD')">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD')">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">직무&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtJIKMU_NM_UP"  style="width:100%" class="input_ReadOnly"  readOnly >
                                </td>
                                <td align="right" class="searchState">직무레벨&nbsp;</td>
                                <td class="padding2423">
									<input type="text" id="txtJIKMU_CD_SHR" size="6" class="input_ReadOnly"  readOnly >
									<input type="text" id="txtJIKMU_NM"     size="20" class="input_ReadOnly"  readOnly >
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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>교육훈련 이수현황</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:86px;">
						<param name="DataID" value="dsT_CM_DUTYMST">
						<param name="Format"				value="
							<G> name='공통역량'  HeadBgColor='#F7DCBB'
								<C> id='ACH_COM'			width='80'		name='목표'			align='center'	Edit=none</C>
								<C> id='COM_FNSH'			width='80'		name='이수'			align='center'	Edit=none</C>
								<C> id='COM_RAT'			width='80'		name='이수률(%)'	align='center'	Edit=none Value={COM_FNSH/ACH_COM*100}</C>
								<C> id='COM_AVG'			width='80'		name='점수(평균)'	align='center'	Edit=none</C>
							</G>
							<G> name='직무역량'  HeadBgColor='#F7DCBB'
								<C> id='ACH_JOB'			width='80'		name='목표'			align='center'	Edit=none</C>
								<C> id='JOB_FNSH'			width='80'		name='이수'			align='center'	Edit=none</C>
								<C> id='JOB_RAT'			width='80'		name='이수률(%)'	align='center'	Edit=none  Value={JOB_FNSH/ACH_JOB*100}</C>
								<C> id='JOB_AVG'			width='80'		name='점수(평균)'	align='center'	Edit=none</C>
							</G>
							<G> name='기타교육'  HeadBgColor='#F7DCBB'
							<C> id='ETC_CNT'            	width='80'      name='이수'     	align='center'   Edit=none</C>
							</G>
							<G> name='사내강의'  HeadBgColor='#F7DCBB'
							<C> id='LCT_TIME'			width='80'		name='이력(HR)'			align='center'	Edit=none</C>
							</G>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>공통역량 교육 이수내역</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='165'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='차수'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='참석'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='수료여부'     align='center' 		value={DECODE(EDU_TAG,'N','미수료','Y','수료')} </C>
								<C> id='APP_VAL'        width='75'		name='이수점수'		align='center'		Edit=none				</C>
								<C> id='TIME_NO'		width='75'		name='교육시간'		align='center'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>직무역량 교육 이수내역</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='CLAS_NM'		width='75'		name='과정분류'		align='left'		Edit=none				</C>
								<C> id='INT_NAM'		width='75'		name='교육기관'		align='left'		Edit=none				</C>
								<C> id='EDU_NM'			width='165'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='차수'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='참석'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='수료여부'     align='center' 		value={DECODE(EDU_TAG,'N','미수료','Y','수료')} </C>
								<C> id='APP_VAL'        width='75'		name='이수점수'		align='center'		Edit=none				</C>
								<C> id='TIME_NO'		width='75'		name='교육시간'		align='center'		Edit=none				</C>
								<C> id='RPT_REQ_NO'		width='75'		name='결재번호'		align='center'		Edit=none				</C>
								<C> id='RPT_YN'			width='75'		name='결과보고'		align='center'		Edit=none				</C>
								<C> id='SPRD'			width='75'		name='전파교육'		align='center'		Edit=none				</C>
								<C> id='EDU_RPT'		width='90'		name='보고서작성'	align='center'		Edit=none	Color='Blue'			</C>
								<C> id='ENO_NO'			width='75'		name='사번'		align='center'		Edit=none	show=false			</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>기타교육 이수내역</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_EXCEPTER_05" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_EXCEPTER_05">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='165'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='50'		name='차수'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='형태'			align='center'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='교육일정'		align='center'		Edit=none				</C>
								<C> id='ATND'	        width='50'		name='참석'			align='center'		Edit=none				</C>
								<C> id='EDU_TNM'        width='75'     	name='수료여부'     align='center' 		value={DECODE(EDU_TAG,'N','미수료','Y','수료')} </C>
								<C> id='TIME_NO'		width='75'		name='교육시간'		align='center'		Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>사내강의이력</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:117px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='39'		name='NO'			align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='150'		name='강의명'		align='left'		Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='강의시간'		align='right'		Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='강의일정'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='과정명'		align='left'		Edit=none				</C>
								<C> id='SEQ_NO'		    width='75'		name='차수'			align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='75'		name='형태'			align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='70'		name='학점'			align='right'		Edit=none				</C>
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