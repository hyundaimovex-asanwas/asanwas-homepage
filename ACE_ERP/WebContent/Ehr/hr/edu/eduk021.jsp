<!--
    ************************************************************************************
    * @Source         : eduk021.jsp                                                    *
    * @Description    : 연간교육신청 PAGE                                          *
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
    <title>연간교육신청(eduk021)</title>
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

			var YEAR      = opener.pis_yy;
            var DPT_CD    = opener.dpt_cd;
            var ORD_NO    = opener.ord_cd;
            
            dsT_ED_YEARPLAN.ClearData();
            dsT_ED_YEARPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk021.cmd.EDUK021CMD&S_MODE=SHR&YEAR="+YEAR+"&DPT_CD"+DPT_CD+"&ORD_CD"+ORD_CD;
            dsT_ED_YEARPLAN.Reset();

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

            trT_ED_YEARPLAN.KeyValue = "tr01(I:SAV=dsT_ED_YEARPLAN)";
            trT_ED_YEARPLAN.action = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk021.cmd.EDUK021CMD&S_MODE=SAV";
            trT_ED_YEARPLAN.post();



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

            if (!dsT_ED_YEARPLAN.IsUpdated) {

                // DataSet의 변경 여부 확인
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_YEARPLAN.isUpdated) {
                for( i = 1; i <= dsT_ED_YEARPLAN.CountRow; i++ ) {
                    if( dsT_ED_YEARPLAN.RowStatus(i) == 1 ||
                        dsT_ED_YEARPLAN.RowStatus(i) == 3 ) {

                        // 사번
                        if( dsT_ED_YEARPLAN.NameValue(i, "ENO_NO") == '' ) {
                            alert("담당자사번은 필수 입력사항입니다.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // 사번 CHECK
                        if (dsT_ED_YEARPLAN.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_YEARPLAN.NameValue(i, "ENO_NM") == "") {
                            alert("입력하신 사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                            dsT_ED_YEARPLAN.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }

                        // 등록일자 CHECK
                        if (!fnc_CheckDate2(dsT_ED_YEARPLAN.NameValue(i, "STR_YMD"), "등록일자") && dsT_ED_YEARPLAN.NameValue(i, "STR_YMD") != "") {
                            dsT_ED_YEARPLAN.RowPosition = i;
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

                document.getElementById('txtYEAR').value = opener.edu_cd;

                fnc_ChangeStateElement(false, "txtEDU_CD");
                fnc_ChangeStateElement(false, "cmbEDU_GBN_CD");     //교육구분
                fnc_ChangeStateElement(false, "cmbPLACE_CD");       //교육장소


                // 데이터 조회
                fnc_SearchList();
            }
            else {

                fnc_EnableElementAll(elementList);

                // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
                if (dsT_ED_YEARPLAN.CountColumn == 0) {
                    dsT_ED_YEARPLAN.setDataHeader("PIS_YY:STRING, DPT_CD:STRING, ORD_NO:STRING, ENO_NO:STRING, JOB_CD:STRING, EDU_CD:STRING, EDU_NM:STRING, INT_NAM:STRING, STR_YMD:STRING, END_YMD:STRING, TIME_NO:NUMBER, COST_AMT:NUMBER, DUTY_REL:STRING, DUTY_TXT:STRING, EFFECT_TAG:STRING, INS_YN:STRING, SHAPE_CD:STRING, GOAL_TAG:STRING, NOTE_TAG:STRING");
                }

                // Row Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거
                dsT_ED_YEARPLAN.AddRow();

                dsT_ED_YEARPLAN.NameValue(1, "PIS_YY")  = getToday().substr(0,4);
                dsT_ED_YEARPLAN.NameValue(1, "DPT_CD")  = opener.dpt_cd;
                document.getElementById("txtENO_NO").value = '<%=box.get("SESSION_ENONO")%>';
            	document.getElementById("txtENO_NM").value = '<%=box.get("SESSION_ENONM")%>';

            }

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_YEARPLAN.IsUpdated)
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
    <Object ID="dsT_ED_YEARPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_YEARPLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_YEARPLAN)">
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
    <Script For=dsT_ED_YEARPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03");

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_YEARPLAN Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_YEARPLAN Event="OnDataError()">

        cfErrorMsg(this);

    </Script>



    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_YEARPLAN event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        opener.fnc_SearchList();

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_YEARPLAN event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">연간교육신청</td>
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
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80 "></col>
                    <col width="215"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                </colgroup>
                <tr>
                    <input type=hidden id="txtORD_NO">
                    <td align="center" class="creamBold">신 청 자</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "9"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <b>
                        &nbsp;&nbsp;부서
                        <input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                        &nbsp;&nbsp;직위
                        <input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                        </b>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >교육과정</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');" >
                        <input id="txtEDU_NM_SHR" size="20" maxlength= "200" class="input_ReadOnly" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
                        <input id="txtEDU_TXT" name="txtEDU_TXT"  maxlength="200" style="width:100%" >
                    </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold" >교육목적</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGOAL_TXT" name="txtGOAL_TXT" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="creamBold" >교육구분</td>
                    <td class="padding2423" align="left" colspan="5">
                        <select id="cmbEDU_GBN_CD" style="width:100px" >
                        </select>
                    </td>
                </tr>
           <!-- <tr>
                    <td align="center" class="creamBold" >교육대상</td>
                    <td class="padding2423" colspan="5">
                        <input type="checkbox" name="chkOBJ_TYPE" value="T"> 전직원
                        <input type="checkbox" name="chkOBJ_TYPE" value="A"> 사무직
                        <input type="checkbox" name="chkOBJ_TYPE" value="M"> 택배직
                        <input type="checkbox" name="chkOBJ_TYPE" value="E"> 파견직
                        <input type="checkbox" name="chkOBJ_TYPE" value="O"> 기타
                        <input id="txtOBJ_TXT" name="txtOBJ_TXT" maxlength="50" style="width:100px">
                    </td>
                </tr>    -->
                <tr>
                    <td align="center" class="creamBold">교육일시</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '교육시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd" name="ImgEduStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD','','0','252');"></a> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate1(this);" onChange="fnc_CheckDate(this, '교육종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd" name="ImgEduEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD','','112','252');"></a>
                    </td>
                    <td align="center" class="creamBold">교육기관</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="28" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">교육장소</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">교육내용</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="117" rows="4" onKeyUp="fc_chk_byte(this,300)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">소요비용</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">인&nbsp;&nbsp;&nbsp;&nbsp;원</td>
                    <td class="padding2423">
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="5" style="width:100%;text-align:right;" onchange="fnc_BindTOT();">
                    </td>
                    <td align="center" class="creamBold">총&nbsp;&nbsp;&nbsp;&nbsp;액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">환급여부</td>
                    <td class="padding2423">
                        <select id="cmbINS_YN" style="width:100%" onchange="fnc_BindTOT()">
                            <option value="N">미적용</option>
                            <option value="Y">적용</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">환급예상액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">처리상황</td>
                    <td class="padding2423">
                        <select id="cmbSTS_GBN" style="width:100%" >
                            <option value="1">신청</option>
                            <option value="2">접수</option>
                            <option value="3">부결</option>
                            <option value="4">승인</option>
                        </select>
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
, JOB_CD, EDU_CD, EDU_NM, INT_NAM, STR_YMD, END_YMD, TIME_NO, COST_AMT, DUTY_REL, DUTY_TXT, EFFECT_TAG, INS_YN, SHAPE_CD, GOAL_TAG, NOTE_TAG
-->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_YEARPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY        Ctrl=txtPIS_YY        Param=value </C>
        <C> Col=DPT_CD   Ctrl=txtDPT_CD   Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=ORD_NO   Ctrl=txtORD_NO   Param=value </C>
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=CET_NO        Ctrl=txtCET_NO        Param=value </C>
        <C> Col=EDU_TXT       Ctrl=txtEDU_TXT       Param=value </C>
        <C> Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM        Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD    Param=value </C>
        <C> Col=GOAL_TXT      Ctrl=txtGOAL_TXT      Param=value </C>
        <C> Col=EDU_GBN_TXT   Ctrl=txtEDU_GBN_TXT   Param=value </C>
        <C> Col=PLACE_TXT     Ctrl=txtPLACE_TXT     Param=value </C>
        <C> Col=CONTENT_TXT   Ctrl=txtCONTENT_TXT   Param=value </C>
        <C> Col=COST_AMT      Ctrl=medCOST_AMT      Param=text  </C>
        <C> Col=FIX_NO        Ctrl=txtFIX_NO        Param=value </C>
        <C> Col=INS_YN        Ctrl=cmbINS_YN        Param=value </C>
        <C> Col=SUM_AMT       Ctrl=medSUM_AMT       Param=text  </C>
        <C> Col=RTN_AMT       Ctrl=medRTN_AMT       Param=text  </C>
        <C> Col=STS_GBN       Ctrl=cmbSTS_GBN       Param=value </C>
    '>
</object>