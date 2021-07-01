<!--*************************************************************************
* @source      : insd010.jsp                                                *
* @description : 고용보험신고내역서 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/02/28            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>고용보험신고내역서(insd010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.d.insd010.cmd.INSD010CMD";
        var params = null;

        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            // 기준일자 입력 필수
            if( document.form1.txtSTR_YMD_SHR.value=="" ){
                alert("기준 시작일자를 입력하십시오. 예)"+today.substr(0,8)+"01");
                return;
            }
            if( document.form1.txtEND_YMD_SHR.value=="" ){
                alert("기준 시작종료를 입력하십시오. 예)"+today);
                return;
            }

            var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

            if(OCC_CD_SHR == "0") OCC_CD_SHR = "";

            params = "&STR_YMD_SHR="+STR_YMD_SHR
                   + "&END_YMD_SHR="+END_YMD_SHR
                   + "&OCC_CD_SHR="+OCC_CD_SHR;

            if(document.tabINSD010.ActiveIndex==1){
                dsT_CM_PERSON_01.dataid = dataClassName+"&S_MODE=SHR_01"+params;
                dsT_CM_PERSON_01.reset();
            } else if(document.tabINSD010.ActiveIndex==2){
                dsT_CM_PERSON_02.dataid = dataClassName+"&S_MODE=SHR_02"+params;
                dsT_CM_PERSON_02.reset();
            } else if(document.tabINSD010.ActiveIndex==3){
                dsT_CM_PERSON_03.dataid = dataClassName+"&S_MODE=SHR_03"+params;
                dsT_CM_PERSON_03.reset();
            }


        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {
           // 기준일자 입력 필수
            if( document.form1.txtSTR_YMD_SHR.value=="" ){
                alert("기준 시작일자를 입력하십시오. 예)"+today.substr(0,8)+"01");
                return;
            }
            if( document.form1.txtEND_YMD_SHR.value=="" ){
                alert("기준 시작종료를 입력하십시오. 예)"+today);
                return;
            }
            var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
            var occ_cd  = document.getElementById("cmbOCC_CD_SHR").value;

            var str_ymd = str_ymd_shr.substr(0,4) + str_ymd_shr.substr(5,2) + str_ymd_shr.substr(8,2);
            var end_ymd = end_ymd_shr.substr(0,4) + end_ymd_shr.substr(5,2) + end_ymd_shr.substr(8,2);
            var ymd_val = "( " + str_ymd_shr.substr(0,4) + "/" + str_ymd_shr.substr(5,2) + "/" + str_ymd_shr.substr(8,2) + " - ";
            var ymd_val = ymd_val + end_ymd_shr.substr(0,4) + "/" + end_ymd_shr.substr(5,2) + "/" + end_ymd_shr.substr(8,2) + " )";
			if(document.tabINSD010.ActiveIndex==1){
	            var url = "insd010_PV.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	} else if(document.tabINSD010.ActiveIndex==2){
        		var url = "insd010_PV_1.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	} else if(document.tabINSD010.ActiveIndex==3){
        		var url = "insd010_PV_2.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	}

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {

            if(document.tabINSD010.ActiveIndex==1){
                if (dsT_CM_PERSON_01.CountRow < 1) {
                    alert("엑셀로 변환할 자료가 없습니다!");
                    return;
                }
                form1.grdT_CM_PERSON_01.GridToExcel("고용보험신고내역서(취득자)", '', 225)
            } else if (document.tabINSD010.ActiveIndex==2){
                if (dsT_CM_PERSON_02.CountRow < 1) {
                    alert("엑셀로 변환할 자료가 없습니다!");
                    return;
                }
                form1.grdT_CM_PERSON_02.GridToExcel("고용보험신고내역서(상실자)", '', 225)
            } else {
                if (dsT_CM_PERSON_03.CountRow < 1) {
                    alert("엑셀로 변환할 자료가 없습니다!");
                    return;
                }
                form1.grdT_CM_PERSON_03.GridToExcel("고용보험신고내역서(보직변경자)", '', 225)
            }
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {
            //이곳에 해당 코딩을 입력 하세요
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
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {

            document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
            document.form1.txtEND_YMD_SHR.value = today;
            document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON_01.ClearData();
            dsT_CM_PERSON_02.ClearData();
            dsT_CM_PERSON_03.ClearData();
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CM_PERSON_01.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            if (dsT_CM_PERSON_02.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            if (dsT_CM_PERSON_03.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {

            // 근로구분 구분 검색 콤보박스 생성
            for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);
            }

            //화면겹침버그 임시 해결
            document.tabINSD010.ActiveIndex=2;
            document.tabINSD010.ActiveIndex=1;

            document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
            document.form1.txtEND_YMD_SHR.value = today;

            cfStyleGrid(form1.grdT_CM_PERSON_01,0,"false","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_CM_PERSON_02,0,"false","false");      // Grid Style 적용
            cfStyleGrid(form1.grdT_CM_PERSON_03,0,"false","false");      // Grid Style 적용
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {
            //if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
        }

        /********************************************
         * 날짜 형식 유효성 체크                                     *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        /********************************************
         * 종료일자에서 포커스 떠날때 시작일자와 비교              *
         ********************************************/
        function cfCheckDateTerm2(p_obj,p_stdt,p_endt) {
            if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
                if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
                    alert("종료일자가 시작일자보다 큽니다.");
                    document.getElementById(p_obj).value = '';
                }
            }
        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 저장용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_01_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON_01=dsT_CM_PERSON_01,O:dsT_CM_PERSON_02=dsT_CM_PERSON_02,O:dsT_CM_PERSON_03=dsT_CM_PERSON_03)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_01.CountRow);

            //ds copy시 Status가 변하지 않으므로 tr에서 넘겨져도 insert나 update로 보지 못한다.
            cfCopyDataSet(dsT_CM_PERSON_01, dsT_CM_PERSON_01_CP, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_CM_PERSON_01.CountRow);

            //각 컬럼의 status를 바꾸어 주어 cmd로 값을 넘어갈수 있게 한다.
            for(var i=1;i<=dsT_CM_PERSON_01.CountRow; i++){
                dsT_CM_PERSON_01_CP.UserStatus(i)=1;
            }
        }
    </Script>

    <Script For=dsT_CM_PERSON_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_02.CountRow);
        }
    </Script>

    <Script For=dsT_CM_PERSON_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_03.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    <Script For=dsT_CM_PERSON_02 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    <Script For=dsT_CM_PERSON_03 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_CM_PERSON_02 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_CM_PERSON_03 Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        alert(trT_CM_PERSON.ErrorMsg);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">고용보험신고내역서</td>
                    <td align="right" class="navigator">HOME/복리후생/고용보험/<font color="#000000">고용보험신고내역서</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" class="greenTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="60"></col>
                    <col width="230"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">기간</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                         ~
                        <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTerm2('txtEND_YMD_SHR', 'txtSTR_YMD_SHR', 'txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','208','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td class="searchState" align="right">근로구분</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD_SHR" onChange="fnc_SearchList()">
                            <option value="0">모두</option>
                        </select>
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

    <!-- 탭 사용 컴퍼넌트 시작 -->
    <comment id="__NSID__">
    <object id=tabINSD010 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
            style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder">
        <param name="BackColor"             value="#F8B97B">
        <param name="DisableBackColor"  value="#EEEEEE">
        <param name="TextColor"             value="#000000">
        <param name="DisableTextColor"      value="#878787">
        <param name="ActiveIndex"               value="1">

        <param  name="Format"
                value='
                    <T>divid="tabINSD010_01"    title="취득자"</T>
                    <T>divid="tabINSD010_02"    title="상실자"</T>
                    <T>divid="tabINSD010_03"    title="근로구분변경자"</T>
                    '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

    <!-- 탭1 조건 입력 테이블 시작 -->
    <div class=page id="tabINSD010_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3;" >

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_01">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50    name="NO"           align=center    Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM       width=80        align=center        name=소속               </C>
                            <C> id=JOB_NM       width=80        align=center        name=직위               </C>
                            <C> id=ENO_NO       width=80        align=center        name=사번               </C>
                            <C> id=ENO_NM       width=60        align=center        name=성명               </C>
                            <C> id=CET_NO       width=120       align=center        name=주민번호           </C>
                            <C> id=ZIP_NO       width=60        align=center        name=우편번호           </C>
                            <C> id=ADDRESS      width=280       align=left          name=주소             RightMargin=10  </C>
                            <C> id=PHN_NO       width=80        align=center        name=전화번호           </C>
                            <C> id=HIR_YMD      width=80        align=center        name=취득일             </C>
                            <C> id=GET_RSN      width=80        align=center        name=취득사유           </C>
                            <C> id=LAST_YMD     width=80        align=center        name=최종일             </C>
                            <C> id=EDGR_NM      width=80        align=center        name=학력               </C>
                            <C> id=OCC_NM       width=80        align=center        name=근로구분               </C>
                            <C> id=STDB_AMT     width=80        align=center        name=월평균임금         </C>
                            <C> id=WRK_HOUR     width=80        align=center        name=주근로시간         </C>
                            <C> id=HIR_PATH     width=80        align=center        name=채용경로           </C>
                            <C> id=HDC_NM       width=80        align=center        name=장해유형           </C>
                            <C> id=HDC_GRA      width=80        align=center        name=장해등급           </C>
                            <C> id=REG_YMD      width=80        align=center        name=신고일             </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- 탭1 조건 입력 테이블 끝 -->

    <!-- 탭2 조건 입력 테이블 시작 -->
    <div class=page id="tabINSD010_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:2; visibility:hidden">

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_02">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50    name="NO"           align=center    Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM       width=80        align=center        name=소속               </C>
                            <C> id=JOB_NM       width=80        align=center        name=직위               </C>
                            <C> id=ENO_NO       width=80        align=center        name=사번               </C>
                            <C> id=ENO_NM       width=60        align=center        name=성명               </C>
                            <C> id=CET_NO       width=120       align=center        name=주민번호           </C>
                            <C> id=ZIP_NO       width=60        align=center        name=우편번호           </C>
                            <C> id=ADDRESS      width=280       align=left          name=주소             LeftMargin=10  </C>
                            <C> id=PHN_NO       width=80        align=center        name=전화번호           </C>
                            <C> id=RET_YMD      width=80        align=center        name=자격상실일         </C>
                            <C> id=OCC_NM       width=80        align=center        name=근로구분               </C>
                            <C> id=RET_NM       width=80        align=center        name=상실구체사유       </C>
                            <C> id=RET_CD       width=80        align=center        name=상실사유           </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- 탭2 조건 입력 테이블 끝 -->

    <!-- 탭3 조건 입력 테이블 시작 -->
    <div class=page id="tabINSD010_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:2; visibility:hidden">

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_03">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50        align=center        name="NO"       Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM           width=80        align=center        name=소속           </C>
                            <C> id=JOB_NM           width=80        align=center        name=직위           </C>
                            <C> id=ENO_NO           width=80        align=center        name=사번           </C>
                            <C> id=ENO_NM           width=60        align=center        name=성명           </C>
                            <C> id=CET_NO           width=120       align=center        name=주민번호       </C>
                            <C> id=ZIP_NO           width=60        align=center        name=우편번호       </C>
                            <C> id=ADDRESS          width=280       align=left          name=주소                 LeftMargin=10  </C>
                            <C> id=PHN_NO           width=80        align=center        name=전화번호       </C>
                            <C> id=CHANGE_YMD       width=80        align=center        name=변경일         </C>
                            <C> id=CHANGE_DPT_NM    width=80        align=center        name=변경전부서     </C>
                            <C> id=CHANGE_JOB_NM    width=80        align=center        name=변경전직위     </C>
                            <C> id=CHANGE_AMT       width=80        align=center        name=변경전금액     </C>
                            <C> id=BEFORE_DPT_NM    width=80        align=center        name=변경후부서     </C>
                            <C> id=BEFORE_JOB_NM    width=80        align=center        name=변경후직위     </C>
                            <C> id=BEFORE_AMT       width=80        align=center        name=변경후금액     </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- 탭3 조건 입력 테이블 끝 -->

    </form>
    <!-- form 끝 -->

</body>
</html>
