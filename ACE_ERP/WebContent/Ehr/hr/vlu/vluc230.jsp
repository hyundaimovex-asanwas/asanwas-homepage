<!--
*****************************************************
* @source       : vluc230.jsp
* @description  : 등급확정_성과 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/09      오대성        최초작성.
* 2007/03/18      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>등급확정_성과(vluc230)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var year = dsT_EV_ESTINFO.ColumnValue(1,1);        //해당년도
            var frq = dsT_EV_ESTINFO.ColumnValue(1,2);         //회차
            var chg_chk  = "0";

            if(form1.chkCHG_CHK_SHR.checked){
                chg_chk = "1";
            } else {
                chg_chk = "0";
            }

            //검색조건 3가지
            var eno_no = document.form1.txtENO_NO_SHR.value;        //사번
            var dpt_cd = document.form1.txtDPT_CD_SHR.value;        //소속
            var group_cd = document.form1.cmbGROUP_CD_SHR.value;    //평가그룹
            var frq = document.form1.cmbEVL_FRQ.value;				//평가회차

            //역량 평가 적용 결과 정보 조회
            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc230.cmd.VLUC230CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+year+"&EVL_GBN=2&EVL_FRQ="+frq+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&GROUP_CD="+group_cd+"&CHG_CHK="+chg_chk;
            dsT_EV_ABLRST.reset();

            document.form1.grdT_EV_ABLRST.SetColumn("FINAL_GRD");

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

            if(s_mode != 'SAV_01'){
                if(!fnc_SaveItemCheck()) return;    //유효성 체크
                s_mode = 'SAV_02';
            }
            else {    //일괄적용일 경우
                if(!confirm("기존에 수정된 내역은 모두 초기화 됩니다.\n\n그래도 적용 하시겠습니까?")) return;
                // 해당 Dataset의 Header가 없으면 일괄적용을 위해 임의로 Header 선언
                if (dsT_EV_ABLRST.CountColumn == 0) {
                    dsT_EV_ABLRST.setDataHeader("EVL_YY:STRING");
                    dsT_EV_ABLRST.AddRow();
                }
                //일괄 적용을 위해 DateSet의 UserStatus를 임의로 변경한다.
                dsT_EV_ABLRST.UserStatus(1) = 1;
            }

            trT_EV_ABLRST.KeyValue = "tr01(I:dsT_EV_ABLRST=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc230.cmd.VLUC230CMD&S_MODE="+s_mode+"&GUBUN="+GUBUN+"&EVL_GBN=2&EVL_YY="+dsT_EV_ESTINFO.ColumnValue(1,1)+"&EVL_FRQ="+dsT_EV_ESTINFO.ColumnValue(1,2);
            trT_EV_ABLRST.post();

            document.form1.grdT_EV_ABLRST.SetColumn("FINAL_GRD");

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("등급확정_성과", '', 225);

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

            dsT_EV_ABLRST.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            f.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ABLRST.IsUpdated)  {

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

            if (!dsT_EV_ABLRST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","right");      // Grid Style 적용

            // 업무구분
            if (frameid == "vluc230") {
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
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
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

            document.form1.txtEVL_YY.value = dsT_EV_ESTINFO.ColumnValue(1,1);
            document.form1.cmbEVL_FRQ.value = dsT_EV_ESTINFO.ColumnValue(1,2);
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
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);

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

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">
        if (trT_EV_ABLRST_01.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">등급확정_성과</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">등급확정_성과</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save('SAV_02')"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="55"></col>
                                <col width="35"></col>
                                <col width="35"></col>
                                <col width="40"></col>
                                <col width="55"></col>
                                <col width="80"></col>
                                <col width="33"></col>
                                <col width="165"></col>
                                <col width="30"></col>
                                <col width="160"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도</td>
                                <td class="padding2423"><input name=txtEVL_YY size="4" maxlength="4"  class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">회차</td>
<!--                            <td class="padding2423"><input name=txtEVL_FRQ size="2" maxlength="1" class="input_ReadOnly" readonly></td> -->
                                <td class="padding2423">
                                    <select name="cmbEVL_FRQ" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value='1' selected>1회</option>
                                        <option value='2' selected>2회</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">평가그룹</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 90%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value=''>전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM','1','1');">
                                    <input name=txtENO_NM size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM')"></a>
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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right" class="searchState">
                        <input type="checkbox" name="chkCHG_CHK_SHR" id=chkCHG_CHK_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()">조정인원
                    </td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn1','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btn1" name="btn1" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Save('SAV_01')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"        value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"            value=0>
                            <param name="Format"                value="
                                <C> id='GROUP_NM'       width=75    name='평가그룹'        align=left   Edit=None</C>
                                <C> id='HEAD_NM'        width=90    name='본부'            align=left   Edit=None</C>
                                <C> id='DPT_NM'         width=90    name='소속'            align=left   Edit=None</C>
                                <C> id='JOB_NM'         width=55    name='직위'            align=left   Edit=None</C>
                                <C> id='ENO_NO'            width=60    name='사번',           align=center Edit=none</C>
                                <C> id='ENO_NM'            width=60    name='성명'               align=center Edit=none</C>
                                <C> id='CVT'            width=75    name='환산점수'           align=center Edit=none</C>
                                <C> id='RNUM'           width=48    name='순위'            align=center Edit=none</C>
                                <C> id='CHANGE_GRD'        width=70    name='최초;등급'       align=center Edit=none</C>
                                <C> id='CHIEP_GRD'        width=70    name='본부장;조정등급' align=center Edit=none</C>
                                <C> id='FINAL_GRD'        width=70    name='확정;등급'       align=center Editstyle=combo    data='S:S,A:A,B:B,C:C,D:D' bgcolor={Decode(FINAL_GRD,CHIEP_GRD,'#FFFFFF',NULL,'#FFFFFF','#F2AC47')}</C>
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