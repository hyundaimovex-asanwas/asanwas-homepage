<!--
    ************************************************************************************
    * @Source         : eduh031.jsp                                                    *
    * @Description    : 교육과정정보관리 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>교육과정정보관리(eduh031)</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {


            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh031.cmd.EDUH031CMD&S_MODE=SHR&EDU_CD="+opener.edu_cd;
            dsT_ED_COURSELIST.Reset();

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

            trT_ED_COURSELIST.KeyValue = "tr01(I:SAV=dsT_ED_COURSELIST)";
            trT_ED_COURSELIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh031.cmd.EDUH031CMD&S_MODE=SAV";
            trT_ED_COURSELIST.post();



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

            if (!dsT_ED_COURSELIST.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_COURSELIST.isUpdated) {
                for( i = 1; i <= dsT_ED_COURSELIST.CountRow; i++ ) {
                    if( dsT_ED_COURSELIST.RowStatus(i) == 1 ||
                        dsT_ED_COURSELIST.RowStatus(i) == 3 ) {

                        // 사번
                        if( dsT_ED_COURSELIST.NameValue(i, "ENO_NO") == '' ) {
                            alert("담당자사번은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // 사번 CHECK
                        if (dsT_ED_COURSELIST.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_COURSELIST.NameValue(i, "ENO_NM") == "") {
                            alert("입력하신 사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }
/*
                        // 과정코드
                        if( dsT_ED_COURSELIST.NameValue(i, "EDU_CD") == '' ) {
                            alert("과정코드는 필수 입력사항입니다.");
                            document.getElementById("txtEDU_CD").focus();
                            return false;
                        }

                        // 과정코드 CHECK
                        if (dsT_ED_COURSELIST.NameValue(i, "EDU_CD") != "" &&
                            dsT_ED_COURSELIST.NameValue(i, "EDU_NM") == "") {
                            alert("과정코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtEDU_CD").focus();
                            return;
                        }

                        // 교육구분
                        if( dsT_ED_COURSELIST.NameValue(i, "EDU_GBN_CD") == '' ) {
                            alert("교육구분은 필수 입력사항입니다.");
                            document.getElementById("cmbEDU_GBN_CD").focus();
                            return false;
                        }

                        // 교육주관
                        if( dsT_ED_COURSELIST.NameValue(i, "MNGER_CD") == '' ) {
                            alert("교육주관은 필수 입력사항입니다.");
                            document.getElementById("cmbMNGER_CD").focus();
                            return false;
                        }

                        // 교육분야
                        if( dsT_ED_COURSELIST.NameValue(i, "FIELD_CD") == '' ) {
                            alert("교육분야는 필수 입력사항입니다.");
                            document.getElementById("cmbFIELD_CD").focus();
                            return false;
                        }

                        // 교육형태
                        if( dsT_ED_COURSELIST.NameValue(i, "SHAPE_CD") == '' ) {
                            alert("교육형태는 필수 입력사항입니다.");
                            document.getElementById("cmbSHAPE_CD").focus();
                            return false;
                        }
*/

                        // 비용부담
                        /*if( dsT_ED_COURSELIST.NameValue(i, "COST_CD") == '' ) {
                            alert("비용부담은 필수 입력사항입니다.");
                            document.getElementById("cmbCOST_CD").focus();
                            return false;
                        }*/

                        // 교육장소
                        /*if( dsT_ED_COURSELIST.NameValue(i, "PLACE_CD") == '' ) {
                            alert("교육장소는 필수 입력사항입니다.");
                            document.getElementById("cmbPLACE_CD").focus();
                            return false;
                        }*/

                        // 등록일자 CHECK
                        if (!fnc_CheckDate2(dsT_ED_COURSELIST.NameValue(i, "STR_YMD"), "등록일자") && dsT_ED_COURSELIST.NameValue(i, "STR_YMD") != "") {
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
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
            fnc_DisableElementAll(elementList);


            // 구분이 수정이면
            if (opener.gbn == "2") {

                document.getElementById('txtEDU_CD').value = opener.edu_cd;

                document.getElementById('txtENO_NO').value = opener.eno_no;
                document.getElementById('txtENO_NM').value = opener.eno_nm;

                fnc_ChangeStateElement(false, "txtEDU_CD");

                fnc_ChangeStateElement(false, "cmbEDU_GBN_CD");     //교육구분
                fnc_ChangeStateElement(false, "cmbPLACE_CD");       //교육장소


                // 데이터 조회
                fnc_SearchList();
            }
            else {

                fnc_EnableElementAll(elementList);

                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_COURSELIST.CountColumn == 0) {
                    dsT_ED_COURSELIST.setDataHeader("EDU_CD:STRING:NULL, EDU_NM:STRING, STR_YMD:STRING, END_YMD:STRING, ENO_NO:STRING, ENO_NM:STRING, EDU_GBN_CD:STRING, MNGER_CD:STRING, FIELD_CD:STRING, SHAPE_CD:STRING, GOAL_TAG:STRING , CONTENT_TXT:STRING, EFFECT_TAG:STRING, OBJ_TAG:STRING, CPT_TAG:STRING, USE_YN:STRING");
                }

                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_COURSELIST.AddRow();

                dsT_ED_COURSELIST.NameValue(1, "ENO_NO")  = opener.eno_no;
                dsT_ED_COURSELIST.NameValue(1, "ENO_NM")  = opener.eno_nm;
                dsT_ED_COURSELIST.NameValue(1, "STR_YMD") = getToday();

                document.getElementById('txtENO_NO').focus();
            }

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_COURSELIST.IsUpdated)
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

            //비용부담
            /*for( var i = 1; i <= dsCOMMON_QB.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QB.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QB.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCOST_CD").add(oOption);

            }*/

            //교육장소
            /*for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbPLACE_CD").add(oOption);

            }*/
        }


        var elementList = new Array(      "txtEDU_NM"

                                        , "txtSTR_YMD"
                                        , "txtENO_NO"
                                        , "txtENO_NM"
                                        , "ImgEnoNo"
                                        , "txtCONTENT_TXT"
                                        , "txtEFFECT_TAG"
                                        , "txtOBJ_TAG"
                                        , "txtCPT_TAG"
                                        , "ImgStrYmd"
                                        , "cmbEDU_GBN_CD"
                                        , "cmbMNGER_CD"
                                        , "cmbFIELD_CD"
                                        , "cmbSHAPE_CD"
                                        , "txtGOAL_TAG"
                                        );



        var exceptionList = new Array(    "txtSTR_YMD"
                                        );
                                        //, "cmbEDU_GBN_CD"
                                        //, "cmbPLACE_CD"
                                        
		function fnc_UsrGetEnoNm() {

            var obj = new String();


                obj = fnc_GetEnoNm("txtENO_NO");

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
        }
        function fnc_UsrGetEnoNo() {
        		fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');

        	//fnc_UsrGetEnoNm(gbn);

        }
        function fnc_Popup() {
            var obj = new String();

                obj = fnc_emplPopup('txtENO_NO','txtENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;

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
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_COURSELIST)">
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
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            // 버튼이 보이지 않음.
            document.getElementById("view_1").style.display='none';
            fnc_DisableElementAll(elementList);

        } else {

<%
    if(box.get("SESSION_ROLE_CD").equals("1001")
            || box.get("SESSION_ROLE_CD").equals("1002")) {
%>
                document.getElementById("view_1").style.display='inline';
                fnc_EnableElementAll(elementList, exceptionList);
<%
    } else {
%>
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

            if (dsT_ED_COURSELIST.NameValue(1, "ENO_NO") == '<%=box.get("SESSION_ENONO")%>') {

                // 버튼이 보임
                document.getElementById("view_1").style.display='inline';
                fnc_EnableElementAll(elementList, exceptionList);
            }
            else {

                // 버튼이 보이지 않음.
                document.getElementById("view_1").style.display='none';
                fnc_DisableElementAll(elementList);
            }
<%
    }
%>
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
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        opener.fnc_SearchList();

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_COURSELIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">교육과정정보관리</td>
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
                    <col width="100"></col>
                    <col width="200"></col>
                    <col width="100"></col>
                    <col width="200"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">과정코드</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="10"  maxlength="10" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">과정명</td>
                    <td class="padding2423">
						<input id="txtEDU_NM" name="txtEDU_NM" size="30">
                    </td>
                    <td align="center" class="creamBold">사용여부</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="cmbUSE_YN" classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="width:80%">
							<param name=CBData        value="Y^사용,N^미사용">
		                    <param name=CBDataColumns     value="USE_YN,USE_DESC">
		                    <param name=BindColumn        value="USE_YN">
		                    <param name=ListExprFormat    value="USE_YN^1^20,USE_DESC^0^50">
		                    <param name=EditExprFormat    value="%;USE_DESC">
		                    <param name=ComboStyle        value=2>
		                    <param name=InheritColor      value="true">   
		                    <param name=Enable            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">과정담당자</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" size="6"  maxlength="6" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm();" onChange="fnc_UsrGetEnoNm();">
                        <input id="txtENO_NM" name="txtENO_NM" size="16" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo();" onchange="fnc_UsrGetEnoNo();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup()"></a>
                    </td>
                    <td align="center" class="creamBold">등록일자</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD"  name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '등록일자');"onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','470','100');"></a>
                    </td>
                    <td align="center" class="creamBold">교육구분</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100" >
                        </select>
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">교육주관</td>
                    <td class="padding2423" >
                        <select id="cmbMNGER_CD" style="width:80" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육분야</td>
                    <td class="padding2423" >
                        <select id="cmbFIELD_CD" style="width:100" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육형태</td>
                    <td class="padding2423" >
                        <select id="cmbSHAPE_CD" style="width:100" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육목표</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtGOAL_TAG"  name="txtGOAL_TAG" style="width:100%" maxlength="100" >
                    </td>
                </tr>


                <tr>
                    <td align="center" class="creamBold">교육내용</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="112" rows="5" onkeyup="fc_chk_byte(this,300);"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">수료기준</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCPT_TAG"  name="txtCPT_TAG" cols="112" rows="3" onkeyup="fc_chk_byte(this,150);"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">기대효과</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtEFFECT_TAG"  name="txtEFFECT_TAG" style="width:100%" maxlength="100" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육대상</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtOBJ_TAG"  name="txtOBJ_TAG" style="width:100%" maxlength="50" >
                    </td>
                </tr>

                <!--
                <tr>
                    <td align="center" class="creamBold">교육기관</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtINT_NAM"  name="txtINT_NAM" style="width:100%" maxlength="22" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육정원</td>
                    <td class="padding2423" >
                        <input id="txtFIX_NO"  name="txtFIX_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > 명
                    </td>
                    <td align="center" class="creamBold">교육시간</td>
                    <td class="padding2423" >
                        <input id="txtTIME_NO"  name="txtTIME_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > 시간
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육일수</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtDAY_NO"  name="txtDAY_NO" style="width:34%;ime-mode:disabled;text-align:right;" maxlength="3" > 일
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">비용부담</td>
                    <td class="padding2423" >
                        <select id="cmbCOST_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육장소</td>
                    <td class="padding2423" >
                        <select id="cmbPLACE_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육비용</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%">
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
                    <td align="center" class="creamBold">환급금액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%">
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
                    <td align="center" class="creamBold">이수학점</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="2" > 점
                    </td>
                    <td align="center" class="creamBold">참고사이트</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" style="width:80%" maxlength="30" >
                    </td>
                </tr>
                -->

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

<object id="bndT_ED_COURSELIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_COURSELIST">
    <Param Name="BindInfo", Value='
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>

        <C>Col=CONTENT_TXT  Ctrl=txtCONTENT_TXT  Param=value </C>
        <C>Col=EFFECT_TAG   Ctrl=txtEFFECT_TAG   Param=value </C>
        <C>Col=OBJ_TAG      Ctrl=txtOBJ_TAG      Param=value </C>
        <C>Col=CPT_TAG      Ctrl=txtCPT_TAG      Param=value </C>
        <C>Col=USE_YN      Ctrl=cmbUSE_YN      Param=BindColVal </C>
    '>
</object>

<!-- 다른테이블로 이동된 필드
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>

        <C>Col=INT_NAM      Ctrl=txtINT_NAM      Param=value </C>
        <C>Col=FIX_NO       Ctrl=txtFIX_NO       Param=value </C>
        <C>Col=DAY_NO       Ctrl=txtDAY_NO       Param=value </C>
        <C>Col=TIME_NO      Ctrl=txtTIME_NO      Param=value </C>
        <C>Col=COST_AMT     Ctrl=medCOST_AMT     Param=text  </C>
        <C>Col=COST_CD      Ctrl=cmbCOST_CD      Param=value </C>
        <C>Col=RTN_AMT      Ctrl=medRTN_AMT      Param=text  </C>
        <C>Col=PLACE_CD     Ctrl=cmbPLACE_CD     Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=SITE_TAG     Ctrl=txtSITE_TAG     Param=value </C>
 -->