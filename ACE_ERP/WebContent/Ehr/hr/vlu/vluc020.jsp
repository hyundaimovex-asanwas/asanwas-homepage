<!--
***********************************************************************
* @source      : vluc020.jsp
* @description : 개인별평가일정조정_성과 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/04      박인이        최초작성.
* 2006/09/29      오대성
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인별평가일정조정_성과(vluc020)</title>
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

        var btnList = 'TFTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var year = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");         //해당년도
            var frq  = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");        //회차

            //검색조건 3가지
            var eno_no   = document.form1.txtENO_NO_SHR.value;       //사번
            var dpt_cd   = document.form1.txtDPT_CD_SHR.value;       //소속
            var group_cd = document.form1.cmbGROUP_CD_SHR.value;     //평가그룹

            //평가 구조 설정 정보 조회
            dsT_EV_SCHCHG.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+year+"&EVL_FRQ="+frq+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&GROUP_CD="+group_cd;
            dsT_EV_SCHCHG.reset();

            document.form1.grdT_EV_SCHCHG.SetColumn("OBJ_STDT");

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

                if(!fnc_SaveItemCheck()) return;    //유효성 체크

                trT_EV_SCHCHG.KeyValue = "tr01(I:dsT_EV_SCHCHG=dsT_EV_SCHCHG)";
                trT_EV_SCHCHG.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=SAV";
                trT_EV_SCHCHG.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            if(dsT_EV_SCHCHG.CountRow < 1) {
                alert("삭제할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            if(confirm("["+dsT_EV_SCHCHG.NameValue(dsT_EV_SCHCHG.RowPosition,'ENO_NM')+"]님의 평가일정조정정보를 삭제하시겠습니까?")){
                dsT_EV_SCHCHG.DeleteRow(dsT_EV_SCHCHG.RowPosition);
                trT_EV_SCHCHG.KeyValue = "tr01(I:dsT_EV_SCHCHG=dsT_EV_SCHCHG)";
                trT_EV_SCHCHG.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=DEL";
                trT_EV_SCHCHG.post();
            }

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

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

            dsT_EV_SCHCHG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            f.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_SCHCHG.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_SCHCHG.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }

            //입력한 날짜의 유효성 체크
            for(i=0;i<dsT_EV_SCHCHG.CountRow;i++){
                if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT'))){
                        alert(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT'));
                        alert("평가입력기간(시작일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT') == ''){
                        alert("평가입력기간(종료일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT'))) {
                            alert("평가입력기간(시작일)은 평가입력기간(종료일)보다 반드시 작아야 합니다.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT'))){
                        alert("평가입력기간(종료일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT') == ''){
                        alert("평가입력기간(시작일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT'))){
                        alert("목표입력기간(시작일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT') == ''){
                        alert("목표입력기간(종료일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT'))) {
                            alert("목표입력기간(시작일)은 목표입력기간(종료일)보다 반드시 작아야 합니다.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT'))){
                        alert("목표입력기간(종료일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT') == ''){
                        alert("목표입력기간(시작일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT'))){
                        alert("본인평가기간(시작일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT') == ''){
                        alert("본인평가기간(종료일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT'))) {
                            alert("본인평가기간(시작일)은 본인평가기간(종료일)보다 반드시 작아야 합니다.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT'))){
                        alert("본인평가기간(종료일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT') == ''){
                        alert("본인평가기간(시작일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT'))){
                        alert("이의신청기간(시작일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT') == ''){
                        alert("이의신청기간(종료일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT'))) {
                            alert("이의신청기간(시작일)은 이의신청기간(종료일)보다 반드시 작아야 합니다.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT'))){
                        alert("이의신청기간(종료일)이\n날짜 형식에 맞지 않습니다.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT') == ''){
                        alert("이의신청기간(시작일)을 입력하세요.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                        return false;
                    }
                }

            }//for
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_SCHCHG,15,"true","false");      // Grid Style 적용

            // 업무구분
            if (frameid == "vluc020") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";

            }

            //년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN=01&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            document.form1.txtDPT_CD_SHR.focus();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_SCHCHG)                       |
    | 3. 사용되는 Table List(T_EV_SCHCHG, T_EV_EVLIST_HD, T_CM_PERSON) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_SCHCHG)        |
    | 3. 사용되는 Table List(T_EV_SCHCHG)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_SCHCHG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(O:VLUA010=dsT_EV_TYPE,O:VLUA030=dsT_EV_ADJRATE,I:VLUA030=dsT_EV_ADJRATE)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
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
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("평가기간 및 평가회차설정이\n되어있지 않습니다.");

        } else {

            document.form1.txtEVL_YY.value  = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.form1.txtEVL_FRQ.value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_SCHCHG event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_SCHCHG event="OnFail()">
        cfErrorMsg(this);
    </script>


<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별평가일정조정_성과</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">개인별평가일정조정_성과</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<!-- 조건 입력 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="65"></col>
                                <col width="30"></col>
                                <col width="35"></col>
                                <col width="10"></col>
                                <col width="65"></col>
                                <col width="*"></col>
                                <col width="35"></col>
                                <col width="175"></col>
                                <col width="35"></col>
                                <col width="165"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도</td>
                                <td class="padding2423"><input name=txtEVL_YY size="4" maxlength="4"  class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423"><input name=txtEVL_FRQ size="2" maxlength="1" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">평가그룹</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 90%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value=''>전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image7" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM','1','1');">
                                    <input name=txtENO_NM size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM')"></a>
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_SCHCHG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_SCHCHG">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='순번'              align=center </C>
                                <C> id='GROUP_NM'   width=75   name='평가그룹'   Edit=None   align=left </C>
                                <C> id='HEAD_NM'    width=90   name='본부'       Edit=None   align=left </C>
                                <C> id='DPT_NM'     width=90   name='소속'       Edit=None   align=left </C>
                                <C> id='JOB_NM'     width=60   name='직위'       Edit=None   align=left </C>
                                <C> id='ENO_NO'     width=60   name='사번'       Edit=None   align=center </C>
                                <C> id='ENO_NM'     width=50   name='성명'       Edit=None   align=center </C>
                                <G> name='목표입력기간' HeadBgColor='#F7DCBB'>
                                    <C> id='OBJ_STDT'    width=70    name='시작일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='OBJ_ENDT'   width=70    name='종료일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='본인평가기간' HeadBgColor='#F7DCBB'>
                                    <C> id='SELF_STDT'  width=70    name='시작일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='SELF_ENDT'    width=70    name='종료일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='평가입력기간' HeadBgColor='#F7DCBB'>
                                    <C> id='IPT_STDT'   width=70    name='시작일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='IPT_ENDT'   width=70    name='종료일'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='이의신청기간' HeadBgColor='#F7DCBB'>
                                    <C> id='PROT_STDT'  width=70    name='시작일'    Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX   align=center </C>
                                    <C> id='PROT_ENDT'  width=70    name='종료일'    Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX   align=center </C>
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
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>