<!--
    ************************************************************************************
    * @Source         : eduh010.jsp                                                    *
    * @Description    : 교육일정 PAGE                                                  *
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
    <title>월간교육일정(eduh010)</title>
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

        var btnList = 'TFFTFFFT';


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var YYMM = document.getElementById("txtYYMM_SHR").value;
            var MM   = YYMM.substring(5,7);

            // 년월
            if( YYMM == '' ) {
                alert("년월은 필수 입력사항입니다.");
                document.getElementById("txtYYMM_SHR").focus();
                return false;
            }

            // 년월 CHECK
            if (!fnc_CheckDate(document.getElementById("txtYYMM_SHR"), "년월") && document.getElementById("txtYYMM_SHR").value != "") {
                document.getElementById("txtYYMM_SHR").focus();
                return false;
            }

            dsT_ED_CHASULIST.ClearData();

            trT_ED_CHASULIST.KeyValue = "SHR"
                                      + "(O:dsT_ED_CHASULIST=dsT_ED_CHASULIST"
                                      + ",O:dsT_DI_HOLIDAY=dsT_DI_HOLIDAY"
                                      + ")";
            trT_ED_CHASULIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh010.cmd.EDUH010CMD&S_MODE=SHR&YYMM="+YYMM;
            trT_ED_CHASULIST.post();

            form1.grdT_ED_CHASULIST.Focus();

            if(MM=="04"||MM=="06"||MM=="09"||MM=="11"){
              form1.grdT_ED_CHASULIST.ColumnProp("DD_31", "Show") = "false";
            }
            else if(MM == "02"){
              form1.grdT_ED_CHASULIST.ColumnProp("DD_29", "Show") = "false";
              form1.grdT_ED_CHASULIST.ColumnProp("DD_30", "Show") = "false";
              form1.grdT_ED_CHASULIST.ColumnProp("DD_31", "Show") = "false";
            }
            else{
              form1.grdT_ED_CHASULIST.ColumnProp("DD_29", "Show") = "true";
              form1.grdT_ED_CHASULIST.ColumnProp("DD_30", "Show") = "true";
              form1.grdT_ED_CHASULIST.ColumnProp("DD_31", "Show") = "true";
            }



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

            document.getElementById("txtYYMM_SHR").value = "";
            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_CHASULIST.ClearData();

            document.getElementById("txtYYMM_SHR").value = getToday().substr(0, 7);
            document.getElementById("txtYYMM_SHR").focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            //cfStyleGrid(form1.grdT_ED_CHASULIST,0,"true","false");

            document.getElementById("txtYYMM_SHR").value = getToday().substr(0, 7);
            document.getElementById("txtYYMM_SHR").focus();

            fnc_SearchList();

         }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST)|
    | 3. 사용되는 Table List(T_ED_CHASULIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton                          |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_CHASULIST)               |
    | 3. 사용되는 Table List(T_ED_CHASULIST)                 |
    +------------------------------------------------------>
    <Object ID="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_CHASULIST.CountRow );

            if (dsT_ED_CHASULIST.NameValue(1, "LAST_DAY") >= "31") {
                grdT_ED_CHASULIST.ColumnProp("DD_31", "SHOW") = true;
            }
            else {
                grdT_ED_CHASULIST.ColumnProp("DD_31", "SHOW") = false;
            }

            if (dsT_ED_CHASULIST.NameValue(1, "LAST_DAY") >= "30") {
                grdT_ED_CHASULIST.ColumnProp("DD_30", "SHOW") = true;
            }
            else {
                grdT_ED_CHASULIST.ColumnProp("DD_30", "SHOW") = false;
            }

            if (dsT_ED_CHASULIST.NameValue(1, "LAST_DAY") >= "29") {
                grdT_ED_CHASULIST.ColumnProp("DD_29", "SHOW") = true;
            }
            else {
                grdT_ED_CHASULIST.ColumnProp("DD_29", "SHOW") = false;
            }

        }

    </Script>

    <!-- 휴일인경우 색상 표시를 위해 -->
    <Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">
        var cnt_dd;
        var dd_val;
        if(iCount == 1) {
            for(var i=1; i<=31; i++) {
                cnt_dd = lpad(i, 2, "0");
                dd_val = dsT_DI_HOLIDAY.NameValue(1, "DD_"+cnt_dd);
                if(dd_val == "Y")
                    grdT_ED_CHASULIST.ColumnProp("DD_"+cnt_dd,"HeadBgColor") = "#D2691E";
                else
                    grdT_ED_CHASULIST.ColumnProp("DD_"+cnt_dd,"HeadBgColor") = "#F7DCBB";
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 그리드를 클릭했을때 -->
    <script language="javascript"  for=grdT_ED_CHASULIST event=OnClick(row,colid)>
        if(colid == "EDU_STR_YN"
                || colid == "EDU_END_YN") {

            var oYYMM = document.getElementById("txtYYMM_SHR").value.split("-");
            var year = fnc_covNumber(oYYMM[0]);
            var month = fnc_covNumber(oYYMM[1]);

            if(colid == "EDU_STR_YN") {
                if(month == 1){
                    year = year-1;
                    month= 12;
                } else{
                    month= month-1;
                }
            } else if(colid == "EDU_END_YN") {
                if(month == 12){
                    year = year+1;
                    month= 1;
                } else{
                    month= month+1;
                }
            }

            document.getElementById("txtYYMM_SHR").value = year+"-"+lpad(month, 2, '0');
            fnc_SearchList();
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">월간교육일정</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">월간교육일정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년월&nbsp;</td>
                                <td class="padding2423" align="left">
			                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
			                            <tr>
			                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
			                                    <input type="text" id="txtYYMM_SHR" style="ime-mode:disabled" size="8" maxlength= "7"  onblur="cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                                    <input type="hidden" id="hidTAG_YM">
			                                </td>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYYMM_SHR', 'yyyymm', 'next');fnc_SearchList();" src="/images/common/arrowup.gif"></TD>
			                            </tr>
			                            <tr>
			                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYYMM_SHR', 'yyyymm', 'prev');fnc_SearchList();" src="/images/common/arrowdown.gif"></TD>
			                            </tr>
			                        </table>
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
                        <object    id="grdT_ED_CHASULIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_ED_CHASULIST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="false">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="IndWidth"                value=0>
                            <param name="RowHeight"               value=22>
                            <param name="FillArea"                value=false>
                            <param name="BorderStyle"             value=2>
                            <param name="DisableNoHScroll"        value=true>
                            <param name="DisableNoVScroll"        value=true>
                            <param name="FocusRect"               value=false>
                            <param name="IndicatorBkColor"        value="#F7DCBB">
                            <param name="IndicatorColBkColor"     value="#F7DCBB">
                            <param name="LineColor"               value="#A1A1A1">
                            <param name="FontName"                value="굴림체">
                            <param name="FontSize"                value="9">
                            <param name="UsingOneClick"           value="1">
                            <param name="TitleHeight"             value=27>
                            <param name="Format"                  value="
                                <FC> id='EDU_NM'       width=150   name='과정명' HeadBgColor='#F7DCBB' align=left   Edit='None' suppress = '1'</FC>
                                <FC> id='SEQ_NO'       width=50   name='차수'    HeadBgColor='#F7DCBB' align=center Edit='None' </FC>
                                <C> id='EDU_STR_YN'   width=17    name='<-'      HeadBgColor='#F7DCBB' align=center Edit='None' value={decode(EDU_STR_YN, 'Y', '<-', '')}</C>
                                <C> id='DD_01'        width=17    name='01'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_01,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_02'        width=17    name='02'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_02,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_03'        width=17    name='03'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_03,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_04'        width=17    name='04'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_04,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_05'        width=17    name='05'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_05,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_06'        width=17    name='06'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_06,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_07'        width=17    name='07'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_07,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_08'        width=17    name='08'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_08,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_09'        width=17    name='09'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_09,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_10'        width=17    name='10'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_10,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_11'        width=17    name='11'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_11,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_12'        width=17    name='12'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_12,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_13'        width=17    name='13'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_13,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_14'        width=17    name='14'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_14,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_15'        width=17    name='15'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_15,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_16'        width=17    name='16'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_16,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_17'        width=17    name='17'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_17,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_18'        width=17    name='18'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_18,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_19'        width=17    name='19'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_19,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_20'        width=17    name='20'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_20,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_21'        width=17    name='21'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_21,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_22'        width=17    name='22'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_22,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_23'        width=17    name='23'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_23,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_24'        width=17    name='24'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_24,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_25'        width=17    name='25'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_25,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_26'        width=17    name='26'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_26,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_27'        width=17    name='27'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_27,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_28'        width=17    name='28'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_28,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_29'        width=17    name='29'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_29,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_30'        width=17    name='30'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_30,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='DD_31'        width=17    name='31'      HeadBgColor='#F7DCBB' align=center bgcolor={Decode(DD_31,'T','#F2AC47','#FFFFFF')}    value='' Edit='None' </C>
                                <C> id='EDU_END_YN'   width=17    name='->'      HeadBgColor='#F7DCBB' align=center Edit='None'  value={decode(EDU_END_YN, 'Y', '->', '')}</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>