<!--
***********************************************************************
* @source      : vluc010.jsp
* @description : 자기평가진행정보_성과 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/09      오대성        최초작성.
* 2007/03/17      박인이        수정. (직무평가업무내용 추가)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>
<head>
<title>자기평가진행정보_성과(vluc010)</title>
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

        var today = removeChar(getToday(),'-');    //현재 시스템 날짜(YYYYMMDD)
        var ipt_stdt;            //평가자평가 시작일
        var ipt_endt;            //평가자평가 종료일
        var obj_stdt;            //목표입력 시작일
        var obj_endt;            //목표입력 종료일
        var self_stdt;           //본인평가 시작일
        var self_endt            //본인평가 종료일
        var prot_stdt;           //이의신청 시작일
        var prot_endt;           //이의신청 종료일

        frame.SetEvent("onwinstat", fnc_FormActive);     // 본 Form이 Active되는 시점을 찾아서 Event를 발생한다.

        var btnList = 'TFFFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";
        var SEQ_NO  = "";
        var First_yn  = "Y";


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

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
        function fnc_Save(s_mode) {

            //이곳에 해당 코딩을 입력 하세요

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

            // 엑셀로 변환 할 자료가 있는지 체크하고
            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            // 업무구분
            if (frameid == "vluc010") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            fnc_SearchList();

        }

        /************************************
         * 15. Modal창을    띄운다            *
         ***********************************/
        function fnc_showModal(gubun, row) {

            var url = '';
            var eno_nm = '';

            if ( gubun == '1' || gubun == '6' ) {    //목표입력
                if ( gubun == '1' ){
                    url = '/hr/vlu/vluc030.jsp?GUBUN='+GUBUN;
                } else {
                    url = '/hr/vlu/vluc030.jsp?MOD=1&GUBUN='+GUBUN+'&MOD_ENO_NO='+dsT_EV_EVLIST_DT.NameValue(row,'ENO_NO');
                }
                if( today < removeChar(obj_stdt,'-') || today > removeChar(obj_endt,'-') ) {
                    alert("목표입력 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '2' ) {    //목표수정
                url = '/hr/vlu/vluc090.jsp?GUBUN='+GUBUN;
            } else if ( gubun == '3' || gubun == '7' ) {    //본인평가
                if ( gubun == '3' ) {
                    url = '/hr/vlu/vluc130.jsp?GUBUN='+GUBUN;
                } else {
                    url = '/hr/vlu/vluc130.jsp?GUBUN='+GUBUN+'&EVLENO_NO='+dsT_EV_EVLIST_DT.NameValue(row,'ENO_NO');
                }
                if( today < removeChar(self_stdt,'-') || today > removeChar(self_endt,'-') ) {
                    alert("본인평가 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '4' ) {    //평가자평가
                url = '/hr/vlu/vluc150.jsp?GUBUN='+GUBUN;
                if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                    alert("평가자평가 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '5' ) {    //이의신청
                url = '/hr/vlu/vluc200.jsp?GUBUN='+GUBUN;
                if( today < removeChar(prot_stdt,'-') || today > removeChar(prot_endt,'-') ) {
                    alert("이의신청 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '8' ) {    //목표승인
                eno_nm = dsT_EV_AIMLST.NameValue(row,'ENO_NM');
                eno_nm = removeChar(removeChar(eno_nm,'['),']').trim();
                url = '/hr/vlu/vluc051.jsp?MOD=1&GUBUN='+GUBUN+'&EVL_YY='+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+'&ENO_NO='+dsT_EV_AIMLST.NameValue(row,'ENO_NO')+'&ENO_NM='+eno_nm+'&EVLENO_NO='+dsT_EV_ABLRST.NameValue(1,"EVLENO_NO");
                if( today < removeChar(obj_stdt,'-') || today > removeChar(obj_endt,'-') ) {
                    alert("목표승인 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '9' ) {    //목표수정승인
                eno_nm = dsT_EV_AIMLST.NameValue(row,'ENO_NM');
                eno_nm = removeChar(removeChar(eno_nm,'['),']').trim();
                url = '/hr/vlu/vluc111.jsp?MOD=1&GUBUN='+GUBUN+'&EVL_YY='+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+'&ENO_NO='+dsT_EV_AIMLST.NameValue(row,'ENO_NO')+'&ENO_NM='+eno_nm+'&EVLENO_NO='+dsT_EV_ABLRST.NameValue(1,"ENO_NO");
            } else if ( gubun == '10' ) {    //1차평가
                url = '/hr/vlu/vluc151.jsp?GUBUN='+GUBUN+'&EVL_YY='+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+'&ENO_NO='+dsT_EV_AIMLST.NameValue(row,'ENO_NO')+'&EVLENO_NO='+dsT_EV_ABLRST.NameValue(1,"ENO_NO");
                if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                    alert("1차평가 기간이 아닙니다.");
                    return;
                }
            } else if ( gubun == '11' ) {    //참조평가
                url = '/hr/vlu/vluc141.jsp?GUBUN='+GUBUN+'&EVL_YY='+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ")+'&ENO_NO='+dsT_EV_ACHTBL.NameValue(row,'ENO_NO')+'&EVLENO_NO='+dsT_EV_ACHTBL.NameValue(row,'EVLENO_NO')+'&REFENO_NO='+dsT_EV_ABLRST.NameValue(1,"ENO_NO")+'&REF_GBN='+dsT_EV_ACHTBL.NameValue(row,'DRG');
                if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                    alert("참조평가 기간이 아닙니다.");
                    return;
                }
            }

            window.showModalDialog(url, 'win', "dialogWidth:870px; dialogHeight:550px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_OnLoadProcess();

        }

        /***************************************
         * 16. Form이 Active 될 때 처리 할 일  *
         **************************************/
        function fnc_FormActive(strID, winstat) {

            if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리

        }

        /********************
         * 17. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


        function fnc_ChangeFrq() {
            if (document.form1.rdoEVL_FRQ[0].checked == true) {
               document.getElementById("EVL_FRQ").innerText = '1';
               SEQ_NO = '1';
            }
            else {document.getElementById("EVL_FRQ").innerText = '2';
                  SEQ_NO = '2';
            }

            First_yn = 'N';

            fnc_SearchList();

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)    |
    | 3. 사용되는 Table List(T_EV_ESTINFO)            |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------------------------------+
    | 1. 조회용 DataSet                                                            |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                                |
    | 3. 사용되는 Table List(T_EV_ABLRST,T_EV_ESTINFO,T_EV_SCHCHG,T_EV_ESTINFO)    |
    +--------------------------------------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                           |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_DT)                       |
    | 3. 사용되는 Table List(T_EV_EVLIST_DT, T_EV_AIMLST, T_EV_ACHTBL) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                            |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_PROTEST)        |
    | 3. 사용되는 Table List(T_EV_PROTEST)                |
    +--------------------------------------------------->
    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                           |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMLST)                       |
    | 3. 사용되는 Table List(T_EV_AIMLST, T_EV_EVLIST_DT, T_EV_ACHTBL) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                              |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ACHTBL)          |
    | 3. 사용되는 Table List(T_EV_ACHTBL, T_EV_EVLIST_DT) |
    +----------------------------------------------------->
    <Object ID="dsT_EV_ACHTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


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

            alert("평가적용기간이 아닙니다.");
            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        } else {

          if (First_yn == 'Y') {
              dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
              dsT_EV_ABLRST.reset();
          }
          else{
              dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+SEQ_NO;
              dsT_EV_ABLRST.reset();
          }
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



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

            //개인정보 및 평가정보 Setting
            document.getElementById("EVL_YY").innerText  = dsT_EV_ABLRST.NameValue(1,'EVL_YY');
            document.getElementById("EVL_FRQ").innerText = dsT_EV_ABLRST.NameValue(1,'EVL_FRQ');
            document.getElementById("DPT_NM").innerText  = dsT_EV_ABLRST.NameValue(1,'DPT_NM');
            document.getElementById("LEVEL").innerText   = dsT_EV_ABLRST.NameValue(1,'JIK_NM');
            document.getElementById("ENO_NO").innerText  = dsT_EV_ABLRST.NameValue(1,'ENO_NO');
            document.getElementById("ENO_NM").innerText  = dsT_EV_ABLRST.NameValue(1,'ENO_NM');
            document.form1.rdoEVL_FRQ[document.getElementById("EVL_FRQ").innerText-1].checked = true;

            SEQ_NO = dsT_EV_ABLRST.NameValue(1,'EVL_FRQ');
            document.getElementById("GRADE").innerText = dsT_EV_ABLRST.NameValue(1,"FINAL_GRD");

            if(dsT_EV_ABLRST.NameValue(1,'IPT_STDT') != '') {
                ipt_stdt = dsT_EV_ABLRST.NameValue(1,'IPT_STDT');
                ipt_endt = dsT_EV_ABLRST.NameValue(1,'IPT_ENDT');
            } else {
                ipt_stdt = dsT_EV_ABLRST.NameValue(2,'IPT_STDT');
                ipt_endt = dsT_EV_ABLRST.NameValue(2,'IPT_ENDT');
            }

            if(dsT_EV_ABLRST.NameValue(1,'OBJ_STDT') != '') {
                obj_stdt = dsT_EV_ABLRST.NameValue(1,'OBJ_STDT');
                obj_endt = dsT_EV_ABLRST.NameValue(1,'OBJ_ENDT');
            } else {
                obj_stdt = dsT_EV_ABLRST.NameValue(2,'OBJ_STDT');
                obj_endt = dsT_EV_ABLRST.NameValue(2,'OBJ_ENDT');
            }

            if(dsT_EV_ABLRST.NameValue(1,'SELF_STDT') != '') {
                self_stdt = dsT_EV_ABLRST.NameValue(1,'SELF_STDT');
                self_endt = dsT_EV_ABLRST.NameValue(1,'SELF_ENDT');
            } else {
                self_stdt = dsT_EV_ABLRST.NameValue(2,'SELF_STDT');
                self_endt = dsT_EV_ABLRST.NameValue(2,'SELF_ENDT');
            }

            if(dsT_EV_ABLRST.NameValue(1,'PROT_STDT') != '') {
                prot_stdt= dsT_EV_ABLRST.NameValue(1,'PROT_STDT');
                prot_endt = dsT_EV_ABLRST.NameValue(1,'PROT_ENDT');
            } else {
                prot_stdt = dsT_EV_ABLRST.NameValue(2,'PROT_STDT');
                prot_endt = dsT_EV_ABLRST.NameValue(2,'PROT_ENDT');
            }

            document.getElementById("IPT_STDT").innerText  = ipt_stdt;
            document.getElementById("IPT_ENDT").innerText  = ipt_endt;
            document.getElementById("OBJ_STDT").innerText  = obj_stdt;
            document.getElementById("OBJ_ENDT").innerText  = obj_endt;
            document.getElementById("SELF_STDT").innerText = self_stdt;
            document.getElementById("SELF_ENDT").innerText = self_endt;
            document.getElementById("PROT_STDT").innerText = prot_stdt;
            document.getElementById("PROT_ENDT").innerText = prot_endt;

            if(dsT_EV_ABLRST.NameValue(1,'FINAL_GRD') != ''){
                document.getElementById("FINAL").innerText = "완료";
            } else {
                document.getElementById("FINAL").innerText = "미완료";
            }

            document.getElementById("OBJ_TERM").innerText      = obj_stdt  + " ~ " + obj_endt;
            document.getElementById("OBJ_TERM_ACPT").innerText = obj_stdt  + " ~ " + obj_endt;//목표승인 작성기간
            document.getElementById("SELF_TERM").innerText     = self_stdt + " ~ " + self_endt;
            document.getElementById("REF_TERM").innerText      = ipt_stdt  + " ~ " + ipt_endt;
            document.getElementById("PROT_TERM").innerText     = prot_stdt + " ~ " + prot_endt;
            document.getElementById("IPT_TERM").innerText      = ipt_stdt  + " ~ " + ipt_endt;

            //평가진행 세부정보 조회(목표입력, 목표수정, 본인평가)
            dsT_EV_EVLIST_DT.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+SEQ_NO;
            dsT_EV_EVLIST_DT.reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        var eno_no = '';
        var eno_nm = '';
        var obj_gbn = '';
        var obj_sta = '';
        var mod_gbn = '';
        var mod_sta = '';
        var self_sta = '';

        if (iCount < 1)    {

        } else {

            for(i=1;i<dsT_EV_EVLIST_DT.CountRow+1;i++) {
                eno_nm = eno_nm + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NM');
                if (dsT_EV_EVLIST_DT.NameValue(i,'IPT_GBN') != '완료') {
                    if( today < removeChar(obj_stdt,'-') || today > removeChar(obj_endt,'-') ) {
                        obj_gbn = obj_gbn + dsT_EV_EVLIST_DT.NameValue(i,'IPT_GBN');
                    } else {
                        obj_gbn = obj_gbn + "<a href='#' onClick='fnc_showModal(6,"+ i +");return false;'>" + dsT_EV_EVLIST_DT.NameValue(i,'IPT_GBN')+"</a>";
                    }
                }
                if (dsT_EV_EVLIST_DT.NameValue(i,'ACCEPT_STA') != '승인') {
                    obj_sta = obj_sta + dsT_EV_EVLIST_DT.NameValue(i,'ACCEPT_STA');
                }
                if (dsT_EV_EVLIST_DT.NameValue(i,'MOD_NM') != '미입력') {
                    mod_gbn = mod_gbn + dsT_EV_EVLIST_DT.NameValue(i,'MOD_NM');
                }
                if (dsT_EV_EVLIST_DT.NameValue(i,'MOD_STA') != '미입력' && dsT_EV_EVLIST_DT.NameValue(i,'MOD_STA') != '승인') {
                    mod_sta = mod_sta + dsT_EV_EVLIST_DT.NameValue(i,'MOD_STA');
                }
                if (dsT_EV_EVLIST_DT.NameValue(i,'SLF_STA') != '완료') {
                    if( today < removeChar(self_stdt,'-') || today > removeChar(self_endt,'-') ) {
                        self_sta = self_sta + dsT_EV_EVLIST_DT.NameValue(i,'SLF_STA');
                    } else {
                        self_sta = self_sta + "<a href='#' onClick='fnc_showModal(7,"+ i +");return false;'>" + dsT_EV_EVLIST_DT.NameValue(i,'SLF_STA')+"</a>";
                    }
                }
            }

        }
        document.getElementById("OBJ_NM").innerText = eno_nm;
        document.getElementById("SELF_NM").innerText = eno_nm;
        document.getElementById("OBJ_GBN").innerHTML = obj_gbn;
        document.getElementById("OBJ_STA").innerText = obj_sta;
        document.getElementById("MOD_GBN").innerText = mod_gbn;
        document.getElementById("MOD_STA").innerText = mod_sta;
        document.getElementById("SELF_STA").innerHTML = self_sta;

        //평가진행 세부정보 조회(이의신청)
        dsT_EV_PROTEST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+SEQ_NO;
        dsT_EV_PROTEST.reset();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            document.getElementById("PROT_STAT").innerText = '미신청';
            document.getElementById("PROT_STAT1").innerText = '미신청';

        } else {

            document.getElementById("PROT_STAT").innerText = "신청";
            document.getElementById("PROT_STAT1").innerText = dsT_EV_PROTEST.NameValue(1,"STSTUS");

        }

        //평가진행 세부정보 조회(목표승인, 목표수정, 1차평가)
        dsT_EV_AIMLST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+SEQ_NO;
        dsT_EV_AIMLST.reset();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        var evleno_no = '';
        var evleno_nm = '';
        var obj_acpt_gbn = '';
        var obj_acpt_sta = '';
        var mod_acpt_gbn = '';
        var mod_acpt_sta = '';
        var my_sta = '';
        var evl_sta = '';

        if (iCount < 1)    {

        } else {

            for(i=1;i<dsT_EV_AIMLST.CountRow+1;i++) {
                evleno_nm = evleno_nm + dsT_EV_AIMLST.NameValue(i,'ENO_NM');

                //미입력
                if (dsT_EV_AIMLST.NameValue(i,'IPT_GBN') != '완료') {
                    obj_acpt_gbn = obj_acpt_gbn + dsT_EV_AIMLST.NameValue(i,'IPT_GBN');
                }

                //미승인
                if (dsT_EV_AIMLST.NameValue(i,'ACCEPT_STA') != '미대상' && dsT_EV_AIMLST.NameValue(i,'ACCEPT_STA') != '승인') {
                    if( today < removeChar(obj_stdt,'-') || today > removeChar(obj_endt,'-') ) {
                        obj_acpt_sta = obj_acpt_sta + dsT_EV_AIMLST.NameValue(i,'ACCEPT_STA');
                    } else {
                        obj_acpt_sta = obj_acpt_sta + "<a href='#' onClick='fnc_showModal(8,"+ i +");return false;'>" + dsT_EV_AIMLST.NameValue(i,'ACCEPT_STA')+"</a>";
                    }
                }
                if (dsT_EV_AIMLST.NameValue(i,'MOD_NM') != '미입력') {
                    mod_acpt_gbn = mod_acpt_gbn + dsT_EV_AIMLST.NameValue(i,'MOD_NM');
                }
                if (dsT_EV_AIMLST.NameValue(i,'MOD_STA') != '미입력' && dsT_EV_AIMLST.NameValue(i,'MOD_STA') != '승인') {
                    mod_acpt_sta = mod_acpt_sta + "<a href='#' onClick='fnc_showModal(9,"+ i +");return false;'>" + dsT_EV_AIMLST.NameValue(i,'MOD_STA')+"</a>";
                }
                if (dsT_EV_AIMLST.NameValue(i,'MY_STA') != '완료') {
                    my_sta = my_sta + dsT_EV_AIMLST.NameValue(i,'MY_STA');
                }
                if (dsT_EV_AIMLST.NameValue(i,'EVL_STA') != '완료') {
                    if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                        evl_sta = evl_sta + dsT_EV_AIMLST.NameValue(i,'EVL_STA');
                    } else {
                        evl_sta = evl_sta + "<a href='#' onClick='fnc_showModal(10,"+ i +");return false;'>" + dsT_EV_AIMLST.NameValue(i,'EVL_STA')+"</a>";
                    }
                }
            }

        }
        document.getElementById("OBJ_ACPT_NM").innerText  = evleno_nm;//목표승인 평가대상
        document.getElementById("IPT_NM").innerText       = evleno_nm;
        document.getElementById("OBJ_ACPT_GBN").innerText = obj_acpt_gbn;//목표승인 미입력
        document.getElementById("OBJ_ACPT_STA").innerHTML = obj_acpt_sta;//목표승인 미승인
        document.getElementById("MOD_ACPT_GBN").innerText = mod_acpt_gbn;
        document.getElementById("MOD_ACPT_STA").innerHTML = mod_acpt_sta;
        document.getElementById("MY_STA").innerText       = my_sta;
        document.getElementById("EVL_STA").innerHTML      = evl_sta;

        //평가진행 세부정보 조회(참조평가)
        dsT_EV_ACHTBL.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc010.cmd.VLUC010CMD&S_MODE=SHR_05&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+SEQ_NO;
        dsT_EV_ACHTBL.reset();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHTBL Event="OnLoadCompleted(iCount)">

        var eno_no = '';
        var eno_nm = '';
        var sts = '';
        var sel = '';

        if (iCount < 1) {

        } else {

            for(i=1;i<dsT_EV_ACHTBL.CountRow+1;i++) {
                eno_nm = eno_nm + dsT_EV_ACHTBL.NameValue(i,'ENO_NM');
                if (dsT_EV_ACHTBL.NameValue(i,'STS') != '완료') {
                    if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                        sts = sts + dsT_EV_ACHTBL.NameValue(i,'STS');
                    } else {
                        sts = sts + "<a href='#' onClick='fnc_showModal(11,"+ i +");return false;'>" + dsT_EV_ACHTBL.NameValue(i,'STS')+"</a>";
                    }
                }
                if (dsT_EV_ACHTBL.NameValue(i,'SEL') != '완료') {
                    sel = sel + dsT_EV_ACHTBL.NameValue(i,'SEL');
                }
            }

        }

        document.getElementById("REF_NM").innerText = eno_nm;
        document.getElementById("STS").innerHTML = sts;
        document.getElementById("SEL").innerHTML = sel;

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="15" rightmargin="20" bottommargin="30" marginwidth="0" marginheight="0" onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
            <!-- 타이틀 바 테이블 시작 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">자기평가진행정보_성과</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">자기평가진행정보_성과</font></td>
                </tr>
            </table>
            <!-- 타이틀 바 테이블 끝 -->
        </td>
    </tr>
    <tr>
        <!-- 버튼 -->
        <td height="35" class="paddingTop5" align="right">
 <!--            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>    -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
    <tr>
        <td height="125" background="/images/specialHr/gridGreen.gif">
            <!--개인정보테이블 시작 -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11"><img src="/images/specialHr/gridWhiteL.gif" width="11" height="125"></td>
                    <td align="center" valign="top">
                        <table width="775" height="112" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="32" style="padding:5 0 0 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title1.gif" width="44" height="15" align="absmiddle"></td>
                            </tr>
                            <tr>
                                <td class="hrWtable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="110" align="center" valign="bottom"><img src="/images/specialHr/iconPc.gif" width="92" height="70"></td>
                                            <td>
                                                <!--개인정보데이타 테이블 -->
                                                <table width="640" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="27" colspan="9" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info1.gif" width="21" height="15" align="absmiddle">&nbsp;<span id="EVL_YY">&nbsp;</span>
                                                            <img src="/images/specialHr/info2.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="EVL_FRQ">&nbsp;</span>
                                                            <img src="/images/specialHr/info3.gif" width="20" height="15" align="absmiddle">
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="rdoEVL_FRQ" id="rdoEVL_FRQ" style="margin-bottom:-2px;border:0;" onClick="fnc_ChangeFrq();">1회차
                                                                                                <input type="radio" name="rdoEVL_FRQ" id="rdoEVL_FRQ" style="margin-bottom:-2px;border:0;" onClick="fnc_ChangeFrq();">2회차
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td height="1" background="/images/specialHr/dot.gif" colspan="12"></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="27" class="hrTextGreen" style="padding:5 0 0 0"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info4.gif" width="19" height="15" align="absmiddle">&nbsp;<span id="DPT_NM">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info5.gif" width="21" height="15" align="absmiddle">&nbsp;<span id="LEVEL">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info6.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="ENO_NO">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info7.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="ENO_NM">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info8.gif" width="41" height="15" align="absmiddle">&nbsp;<span id="GRADE">&nbsp;</span></td>
                                                    </tr>
                                                </table></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteR.gif" width="11" height="125"></td>
                </tr>
            </table>
            <!--개인정보테이블 끝 -->
        </td>
    </tr>
    <tr>
        <td height="15">&nbsp;</td>
    </tr>
    <tr>
        <td height="110" bgcolor="F3F5EB">
            <!--평가정보테이블 시작 -->
            <table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center" valign="top">
                        <table width="775" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title2.gif" width="44" height="15" align="absmiddle">
                                </td>
                            </tr>
                            <tr>
                                <td height="175" class="hrWtable" style="padding:20 6 6 6">
                                    <table width="100%" height="163" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="116" height="25" valign="top"><img src="/images/specialHr/inputT1.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td width="116" valign="top"><img src="/images/specialHr/inputT2.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td width="116" valign="top"><img src="/images/specialHr/inputT3.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td width="116" valign="top"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td width="116" valign="top"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td width="116" valign="top"><img src="/images/specialHr/inputT6.gif" width="116" height="20"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/inputImg1.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal(1,0);"></td>
                                            <td><img src="/images/specialHr/inputImg2.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal(2,0);"></td>
                                            <!--
                                            <td><img src="/images/specialHr/inputImg2.gif" width="116" height="80" style="cursor:hand"></td>
                                            -->
                                            <td><img src="/images/specialHr/inputImg3.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal(3,0);"></td>
                                            <td><img src="/images/specialHr/inputImg4.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal(4,0);"></td>
                                            <td><img src="/images/specialHr/inputImg5.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal(5,0);"></td>
                                            <td><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
                                        </tr>
                                        <tr>
                                            <td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="OBJ_STDT"></span>&nbsp;부터<br>&nbsp;<span id="OBJ_ENDT"></span>&nbsp;까지</td>
                                            <td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">수시</td>
                                            <td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="SELF_STDT"></span>&nbsp;부터<br>&nbsp;<span id="SELF_ENDT"></span>&nbsp;까지</td>
                                            <td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="IPT_STDT"></span>&nbsp;부터<br>&nbsp;<span id="IPT_ENDT"></span>&nbsp;까지</td>
                                            <td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="PROT_STDT"></span>&nbsp;부터<br>&nbsp;<span id="PROT_ENDT"></span>&nbsp;까지</td>
                                            <td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="FINAL">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="11" width="13"><img src="/images/specialHr/gridWhiteLB.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td><img src="/images/specialHr/gridWhiteRB.gif" width="11" height="11"></td>
                </tr>
            </table>
            <!--평가정보테이블 끝 -->
        </td>
    </tr>
    <tr>
        <td height="15">&nbsp;</td>
    </tr>
    <tr>
        <td bgcolor="F6F4DF">
            <!--평가진행세부정보 테이블 시작 -->
            <table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center" valign="top">
                        <table width="775" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotOlive.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title3.gif" width="89" height="15" align="absmiddle">
                                </td>
                                <!-- <td align="right" valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/pen.gif" width="230" height="16"></td> -->
                            </tr>
                            <tr>
                            <tr>
                                <td width="385" align="left" class="hrWtable2"><img src="/images/specialHr/info21.gif" width="188" height="15"></td>
                                <td width="385" align="left" class="hrWtable3"><img src="/images/specialHr/info22.gif" width="180" height="15"></td>
                            </tr>
                                <td width="385" class="hrWtable2">

                                    <!-- 목표입력 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailTimg1.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="OBJ_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT2.gif" width="28" height="12"></td>
                                            <td class="hrTextBlack"><span id="OBJ_NM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT9.gif" width="27" height="12"></td>
                                            <td class="hrTextBlue"><span id="OBJ_GBN">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT10.gif" width="28" height="12"></td>
                                            <td class="hrTextBlack"><span id="OBJ_STA">&nbsp;</span></td>
                                        </tr>
                                    </table> </td>
                                <td width="385" class="hrWtable3">
                                    <!--목표승인 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailT2img1.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT21.gif" width="38" height="12"></td>
                                            <!-- 작성기간 --><td class="hrTextBlack"><span id="OBJ_TERM_ACPT">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT13.gif" width="38" height="12"></td>
                                            <!-- 평가대상 --><td class="hrTextBlack"><span id="OBJ_ACPT_NM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT16.gif" width="27" height="12"></td>
                                            <!-- 미입력 --><td class="hrTextBlack"><span id="OBJ_ACPT_GBN">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT17.gif" width="28" height="12"></td>
                                            <!-- 미승인 --><td class="hrTextBlue"><span id="OBJ_ACPT_STA">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td class="hrWtable2">
                                    <!-- 목표수정 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailTimg2.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">수 시</td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT14.gif" width="47" height="12"></td>
                                            <td class="hrTextBlack"><span id="MOD_GBN">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT10.gif" width="28" height="12"></td>
                                            <td class="hrTextBlack"><span id="MOD_STA">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                                <td class="hrWtable3">
                                    <!--목표수정 승인-->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailT2img2.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT21.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">수 시</td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT14.gif" width="47" height="12"></td>
                                            <td class="hrTextBlack"><span id="MOD_ACPT_GBN">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT17.gif" width="28" height="12"></td>
                                            <td class="hrTextBlue"><span id="MOD_ACPT_STA">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td class="hrWtable2">
                                    <!-- 본인평가 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg3.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="SELF_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT2.gif" width="28" height="12"></td>
                                            <td class="hrTextBlack"><span id="SELF_NM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT18.gif" width="28" height="12"></td>
                                            <td class="hrTextBlue"><span id="SELF_STA">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                                <td class="hrWtable3">
                                    <!--참조평가 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailT2img3.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="60"><img src="/images/specialHr/detailT21.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="REF_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT13.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="REF_NM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT15.gif" width="38" height="26"></td>
                                            <td class="hrTextBlack"><span id="SEL">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT18.gif" width="28" height="12"></td>
                                            <td class="hrTextBlue"><span id="STS">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="hrWtable2">
                                    <!-- 이의신청 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg4.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="PROT_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT5.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="PROT_STAT">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT6.gif" width="37" height="12"></td>
                                            <td class="hrTextBlack"><span id="PROT_STAT1">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                                <td class="hrWtable3">
                                    <!--1차평가 -->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="7"><img src="/images/specialHr/detailT2img4.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="60"><img src="/images/specialHr/detailT21.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="IPT_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT13.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack"><span id="IPT_NM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT15.gif" width="38" height="26"></td>
                                            <td class="hrTextBlack"><span id="MY_STA">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT18.gif" width="28" height="12"></td>
                                            <td class="hrTextBlue"><span id="EVL_STA">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="11" width="13"><img src="/images/specialHr/gridWhiteLB.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td><img src="/images/specialHr/gridWhiteRB.gif" width="11" height="11"></td>
                </tr>
            </table>
            <!--평가진행 세부정보 테이블 끝 -->
        </td>
    </tr>
</table>
</body>
</html>