<!--
*****************************************************
* @source       : vluc200.jsp
* @description : 이의신청(개인)_성과 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/10      오대성        최초작성.
* 2007/03/18      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>이의신청(개인)_성과(vluc200)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //업무구분
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFTT';
        //삭제상태구분
        var stateDiv='';
        var flag= false;        //이의신청 기간체크
        var file_flag = '0';    //1:파일삭제시

        //모달창으로 띄웠을 경우 구분하기 위해 사용 by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송(이의신청(개인)_성과)
            dsT_EV_PROTEST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_PROTEST.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem(searchDiv) {

            if( searchDiv == '1') {
                 //현재 평가적용기간에 해당하는 년도,회차 정보
                dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=3";
                dsT_EV_ESTINFO.Reset();
            }

            if( searchDiv == '2') {
                //이의신청기간 여부 체크
                dsT_EV_ESTINFO_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub080.cmd.VLUB080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
                dsT_EV_ESTINFO_01.Reset();
            }

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //트랜잭션 전송
            trT_EV_PROTEST.Value="SVL(I:SAV=dsT_EV_PROTEST, I:FILE=oFileListGDS, O:RELOAD=dsT_EV_PROTEST2)";
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SAV&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&FLAG="+file_flag;
            trT_EV_PROTEST.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if ( dsT_EV_PROTEST.CountRow  < 1 || dsT_EV_PROTEST.RowStatus(dsT_EV_PROTEST.RowPosition) == 1 ) {
                   fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

            if( !fnc_DeleteEnableCheck() ) {
                alert("접수된 자료이므로 삭제할수 없습니다.")
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_PROTEST.ColumnString(1,6) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_PROTEST.DeleteRow(1);

            stateDiv = 'delete';
            //트랜잭션 전송
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SAV";
            trT_EV_PROTEST.Post();

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

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_PROTEST.CountColumn == 0) {
                dsT_EV_PROTEST.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_GBN:STRING, EVL_FRQ:INT, ENO_NO:STRING, PROTEST_YMD:STRING, PROTEST_TIT:STRING, PROTEST_DEC:STRING, ACCEPT_GBN:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_PROTEST.AddRow();

            dsT_EV_PROTEST.NameValue(1,"GUBUN") =  GUBUN;
            dsT_EV_PROTEST.NameValue(1,"EVL_YY") = document.getElementById("txtEVL_YY_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"EVL_GBN") = document.getElementById("txtEVL_GBN_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"EVL_FRQ") = document.getElementById("txtEVL_FRQ_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"ACCEPT_GBN") = 'N';

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( dsT_EV_PROTEST.isUpdated ) {
                if( form1.txtEVL_YY_SHR.value == '') {
                    alert("해당년도는 필수입력사항입니다.");
                    form1.txtEVL_YY_SHR.focus();
                    return false;
                }
                if( form1.txtEVL_FRQ_SHR.value == '') {
                    alert("회차는 필수입력사항입니다.");
                    form1.txtEVL_FRQ_SHR.focus();
                    return false;
                }
                if( form1.txtENO_NO_SHR.value == '') {
                    alert("사번은 필수입력사항입니다.");
                    form1.txtENO_NO_SHR.focus();
                    return false;
                }
                if( form1.txtPROTEST_YMD.value == '') {
                    alert("일자는 필수입력사항입니다.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( (form1.txtPROTEST_YMD.value != '' && cfDateExpr(form1.txtPROTEST_YMD.value) == false) ) {
                    alert("일자가 날짜형식에 맞지않습니다.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( form1.txtPROTEST_TIT.value == '') {
                    alert("제목은 필수입력사항입니다.");
                    form1.txtPROTEST_TIT.focus();
                    return false;
                }
                if( form1.txtPROTEST_DEC.value == '') {
                    alert("내용은 필수입력사항입니다.");
                    form1.txtPROTEST_DEC.focus();
                    return false;
                }
                //유효성 체크
                if( !valid() ) return;
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 자료가 없습니다!");
                return false;
            }
            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
            if( dsT_EV_PROTEST.isUpdated ) {
                if( form1.txtEVL_YY_SHR.value == '') {
                    alert("해당년도는 필수입력사항입니다.");
                    form1.txtEVL_YY_SHR.focus();
                    return false;
                }
                if( form1.txtEVL_FRQ_SHR.value == '') {
                    alert("회차는 필수입력사항입니다.");
                    form1.txtEVL_FRQ_SHR.focus();
                    return false;
                }
                if( form1.txtENO_NO_SHR.value == '') {
                    alert("사번은 필수입력사항입니다.");
                    form1.txtENO_NO_SHR.focus();
                    return false;
                }
                if( form1.txtPROTEST_YMD.value == '') {
                    alert("일자는 필수입력사항입니다.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( (form1.txtPROTEST_YMD.value != '' && cfDateExpr(form1.txtPROTEST_YMD.value) == false) ) {
                    alert("일자가 날짜형식에 맞지않습니다.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( form1.txtPROTEST_TIT.value == '') {
                    alert("제목은 필수입력사항입니다.");
                    form1.txtPROTEST_TIT.focus();
                    return false;
                }
                if( form1.txtPROTEST_DEC.value == '') {
                    alert("내용은 필수입력사항입니다.");
                    form1.txtPROTEST_DEC.focus();
                    return false;
                }
                //유효성 체크
                if( !valid(form1) ) return;
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 자료가 없습니다!");
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            // 파일 첨부용 데이터셋의 헤더 정보 설정.
            oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // 업무구분
            if (frameid == "vlug200" || "<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            //현재 평가적용기간에 해당하는 년도,회차 정보
            fnc_SearchItem('1');
            //이의신청일자 설정
        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 삭제여부 설정 (접수여부) 부분  *
         *******************************************/
        function fnc_DeleteEnableCheck() {

            if( dsT_EV_PROTEST.NameValue(1,"ACCEPT_GBN") == 'N' ) {
                return true;
            } else {
                document.getElementById("txtPROTEST_YMD").readOnly=true;
                document.getElementById("txtPROTEST_TIT").readOnly=true;
                document.getElementById("txtPROTEST_DEC").readOnly=true;
                return false;
            }
               form1.txtPROTEST_TIT.focus();//set focus
        }

        /********************************************
         * 16. 조건에 따른 이의신청(개인)_성과의 enable/disable 처리    *
         *******************************************/
        function fnc_DisableSet() {

            document.getElementById("image1").disabled='disabled';
            document.getElementById("image2").disabled='disabled';
            document.getElementById("txtPROTEST_TIT").readOnly=true;
            document.getElementById("txtPROTEST_TIT").style.backgroundColor = 'EEEEEE';
            document.getElementById("txtPROTEST_DEC").readOnly=true;
            document.getElementById("txtPROTEST_DEC").style.backgroundColor = 'EEEEEE';

        }

        /********************
         * 17. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************
         * 첨부파일 처리    *
         *******************/
        function fnc_FileUpload() {

            oFileListGDS.addrow();
            oFileListGDS.NameValue(oFileListGDS.RowPosition, "ENO_NO") = form1.txtENO_NO_SHR.value;

            oFileGF.OpenFileName = form1.txtFILE_NAME.value;

            oFileGF.open();

            if(oFileGF.SelectState == true)
            {
                form1.txtFILE_NAME.value = oFileGF.value;
                form1.txtFILE_URL2.value = '';
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
            if (form1.txtFILE_URL.value != "" && form1.txtFILE_URL.value == form1.txtFILE_URL2.value) {

                file_flag = '1';

                form1.txtFILE_NAME.value = "";

                fnc_Save();
            }
            else {
                if (form1.txtFILE_NAME.value != "") {
                    form1.txtFILE_NAME.value = "";
                    form1.txtFILE_URL.value = "";
                    form1.txtFILE_URL2.value = "";
                }
                else {
                    alert("삭제할 파일이 존재하지 않습니다.");
                }
            }
        }

        function fnc_link() {
            if (dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME") != "" && form1.txtFILE_URL2.value != "") {    // 첨부 파일이 존재하는 경우만 수행하게~
                cfDownload(dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME"), form1.txtFILE_URL2.value);
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

     <Object ID="dsT_EV_ESTINFO_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload용 데이터셋 -->
    <Object ID="dsT_EV_PROTEST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_PROTEST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_PROTEST, I:FILE=oFileListGDS, O:RELOAD=dsT_EV_PROTEST2)">
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

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            if( flag == true ) { //이의신청 기간체크
                fnc_AddNew();
                document.getElementById("resultMessage").innerText = ' ';

                document.getElementById("txtPROTEST_YMD").value = getToday();

                form1.txtPROTEST_TIT.focus();//set focus
            }

        } else {

            if( flag == true ) {        //이의신청 기간 체크
                document.getElementById("resultMessage").innerText = '* 자료가 조회 되었습니다!';

                //삭제가능 여부체크
                if( !fnc_DeleteEnableCheck() ) {
                    fnc_DisableSet();
                    document.getElementById("resultMessage").innerText = '* 접수가 완료된 상태입니다.';
                    alert("접수가 완료된 상태입니다.");

                    document.getElementById("btnUPLOAD").disabled = "true";
                    document.getElementById("btnDEL").disabled = "true";

                    return;
                }
            }

            form1.txtFILE_URL2.value = form1.txtFILE_URL.value;
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_DisableSet();
            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

            document.getElementById("btnUPLOAD").disabled = "true";
            document.getElementById("btnDEL").disabled = "true";

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NAME_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NAME_SHR").value = '<%=box.get("SESSION_DPTNM")%>';

            //이의신청 입력기간 여부 체크
            fnc_SearchItem('2');

        }

    </Script>

    <Script For=dsT_EV_ESTINFO_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_DisableSet();
            document.getElementById("resultMessage").innerText = '* 현재 이의 신청 기간이 아닙니다!';
            alert("현재 이의 신청 기간이 아닙니다.");

            document.getElementById("btnUPLOAD").disabled = "true";
            document.getElementById("btnDEL").disabled = "true";

        } else {

            flag=true;        //이의신청가능 기간일 경우
            //이의신청(개인)_성과 조회

        }

        fnc_SearchList();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_PROTEST event="OnSuccess()">

        // 파일삭제시
        if (file_flag == '1') {

            document.getElementById("resultMessage").innerText = '* 첨부파일이 삭제되었습니다.';
            file_flag == '0';
        }
        else {

            if( stateDiv == 'delete' ) {
                fnc_AddNew();
                //이의신청일자 설정
                document.getElementById("txtPROTEST_YMD").value = getToday();
            }
            stateDiv = '';
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_PROTEST event="OnFail()">

        cfErrorMsg(this);
        file_flag == '0';

    </script>

    <!-- 데이터를 성공적으로 가지고 온 경우 발생하는 이벤트 -->
    <script for=dsT_EV_PROTEST2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("조회된 데이터가 없습니다.");
            return;
        }

        /** 데이터셋 복사 **/
        cfCopyDataSet(dsT_EV_PROTEST2, dsT_EV_PROTEST, "copyHeader=yes");
        form1.txtFILE_URL2.value = form1.txtFILE_URL.value;
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이의신청(개인)_성과</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">이의신청(개인)_성과</font></td>
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
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_DeleteOver.gif',2)"><img src="/images/button/btn_DeleteOn.gif" id="image2" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',3)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>

            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <input type="hidden" id="txtEVL_GBN_SHR" name="txtEVL_GBN_SHR" value='2'>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right" class="searchBold">해당년도&nbsp;</td>
                                    <td><input id="txtEVL_YY_SHR" name="txtEVL_YY_SHR" style="width 100%;text-align: center" size="4" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">회차&nbsp;</td>
                                    <td><input id="txtEVL_FRQ_SHR" name="txtEVL_FRQ_SHR" style="width 100%;text-align: center" size="2" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">소속&nbsp;</td>
                                    <td><input id="txtDPT_NAME_SHR" name="dept" style="width 100%;" size="10" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">사번&nbsp;</td>
                                    <td><input id="txtENO_NO_SHR" name="txtENO_NO_SHR" style="width 100%;text-align: center" size="10" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">성명&nbsp;</td>
                                    <td><input id="txtENO_NAME_SHR" name="eno_nm" style="width 100%;text-align:center" size="10" class="input_ReadOnly" readonly></td>
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" height="160" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="25"></col>
                        <col width="30"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold" rowspan="3">이<BR><BR>의<BR><BR>신<BR><BR>청</td>
                        <td align="center" class="creamBold">일자</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_YMD name=txtPROTEST_YMD class="input_ReadOnly" size="15" maxlength=10 onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" readonly>
                            &nbsp;&nbsp;<B>첨부파일명</B>&nbsp;
                            <input id=txtFILE_NAME name=txtFILE_NAME size="58" valid='maxlength=255' readonly style="cursor:hand" onClick="fnc_link()">&nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)">  <img src="/images/button/FileAddOn.gif"   id="btnUPLOAD" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEL','','/images/button/FileDelOver.gif',3)">  <img src="/images/button/FileDelOn.gif"   id="btnDEL" name="btnDEL" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete()"></a>
                            <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60"><input type=hidden id=txtFILE_URL2 name=txtFILE_URL2 size="60">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">제목</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_TIT name=txtPROTEST_TIT size="121" valid='maxlength=100' field='제목'>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">내<BR><BR>용</td>
                        <td align="center">
                            <textarea id=txtPROTEST_DEC name=txtPROTEST_DEC rows="9" cols="120" valid='maxlength=4000' field='내용'></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" rowspan="2">답<BR><BR><BR>변</td>
                        <td align="center" class="creamBold">일자</td>
                        <td class="padding2423">
                            <input id=txtANSWER_YMD name=txtANSWER_YMD style="text-align: center" size="15" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">내<BR><BR>용</td>
                        <td align="center">
                            <textarea id=txtANSWER_DEC name=txtANSWER_DEC rows="9" cols="120" class="input_ReadOnly" readonly></textarea>
                        </td>
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
    <!--  테이블 -->
    <comment id="__NSID__">
    <object id="bndT_EV_PROTEST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_EV_PROTEST">
        <Param Name="ActiveBind"        Value=true>
        <Param Name="BindInfo", Value='
            <C>Col=PROTEST_YMD       Ctrl=txtPROTEST_YMD      Param=value</C>
            <C>Col=PROTEST_TIT       Ctrl=txtPROTEST_TIT      Param=value</C>
            <C>Col=PROTEST_DEC       Ctrl=txtPROTEST_DEC      Param=value</C>
            <C>Col=ANSWER_YMD       Ctrl=txtANSWER_YMD      Param=value</C>
            <C>Col=ANSWER_DEC       Ctrl=txtANSWER_DEC      Param=value</C>
            <C>Col=FILE_NAME        Ctrl=txtFILE_NAME       Param=Value</C>
            <C>Col=FILE_URL         Ctrl=txtFILE_URL        Param=Value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

    <!-- 첨부파일용 바인딩 오브젝트 -->
    <object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="oFileListGDS">
        <Param Name="BindInfo", Value='
            <C>Col=FILE_NAME        Ctrl=oFileGF            Param=Value</C>
            <C>Col=FILE_URL            Ctrl=oFileGF            Param=Value</C>'>
    </object>
