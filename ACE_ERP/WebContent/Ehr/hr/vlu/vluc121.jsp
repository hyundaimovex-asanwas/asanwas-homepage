<!--
    ************************************************************************************
    * @Source         : vluc121.jsp                                                    *
    * @Description    : 목표현황상세.                                                  *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/23  |  안준성   | 최초작성                                               *
    * 2007/03/18  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>목표현황상세(vluc121)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN       = request.getParameter("GUBUN");          //업무구분
    String EVL_YY      = request.getParameter("EVL_YY");         //해당년도
    String EVL_FRQ     = request.getParameter("EVL_FRQ");        //회차
    String ENO_NO      = request.getParameter("ENO_NO");         //피평가자사번
    String ENO_NM      = request.getParameter("ENO_NM");         //피평가자성명
    String DPT_NM      = request.getParameter("DPT_NM");         //소속명
    String EVLENO_NO   = request.getParameter("EVLENO_NO");      //평가자사번
    String AIM_YMD     = request.getParameter("AIM_YMD");        //목표설정일자
    String ACCEPT_YMD  = request.getParameter("ACCEPT_YMD");     //목표승인일자
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';

        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

            if( searchDiv == '1' ) {
                if( !fnc_SearchItemCheck() ) return;

                //데이터셋 전송
                dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc121.cmd.VLUC121CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtEVLENO_NO_SHR=<%=EVLENO_NO%>"+"&txtAIM_YMD_SHR=<%=AIM_YMD%>"+"&txtACCEPT_YMD_SHR=<%=ACCEPT_YMD%>";
                dsT_EV_AIMLST.Reset();
            }

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


           if (dsT_EV_AIMLST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_AIMLST.GridToExcel("목표현황", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

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

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_AIMLST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( !valid(form1) )
                return false;
            else
                return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid2(form1.grdT_EV_AIMLST);

            form1.txtEVL_YY_SHR.value     = "<%=EVL_YY%>";
            form1.txtEVL_FRQ_SHR.value    = "<%=EVL_FRQ%>";
            form1.txtENO_NO_SHR.value     = "<%=ENO_NO%>";
            form1.txtENO_NM_SHR.value     = "<%=ENO_NM%>";
            form1.txtDPT_NM_SHR.value     = "<%=DPT_NM%>";

            // 업무구분
            if ("<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

            }
            else {
                // 직무평가
                GUBUN = "02";

            }

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            fnc_SearchList('1');

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 목표승인 여부에 따른,        *
         *        목표승인처리의 입력 disable,                            *
         *******************************************/
        function fnc_DisableSet(disableDiv) {

            if( disableDiv == '1' ) {    //입력가능
                document.getElementById("cmbACCEPT_GBN_SHR").disabled=false;
            }
            if( disableDiv == '2' ) {    //입력불가
                document.getElementById("cmbACCEPT_GBN_SHR").disabled=true;
            }

        }

        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        function fnc_Disp_RefColumn() {

            var str_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_STDT");
            var end_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_ENDT");
            var str_mm = Number(str_ymd.substring(5,7));
            var end_mm = Number(end_ymd.substring(5,7));


            if("<%=EVL_FRQ%>" == "1"){
               str_mm = 01;
               end_mm = 06;
            }else{
               str_mm = 07;
               end_mm = 12;
            }

            for(var i=str_mm; i<=end_mm; i++){

                if(i == 1) {
                  form1.grdT_EV_AIMLST.ColumnProp("JAN_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JAN_DN_1", "Show") = "true";
                }

                if(i == 2) {
                  form1.grdT_EV_AIMLST.ColumnProp("FEB_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("FEB_DN_1", "Show") = "true";
                }

                if(i == 3) {
                  form1.grdT_EV_AIMLST.ColumnProp("MAR_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("MAR_DN_1", "Show") = "true";
                }

                if(i == 4) {
                  form1.grdT_EV_AIMLST.ColumnProp("APR_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("APR_DN_1", "Show") = "true";
                }

                if(i == 5) {
                  form1.grdT_EV_AIMLST.ColumnProp("MAY_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("MAY_DN_1", "Show") = "true";
                }

                if(i == 6) {
                  form1.grdT_EV_AIMLST.ColumnProp("JUN_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JUN_DN_1", "Show") = "true";
                }

                if(i == 7) {
                  form1.grdT_EV_AIMLST.ColumnProp("JUL_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JUL_DN_1", "Show") = "true";
                }

                if(i == 8) {
                  form1.grdT_EV_AIMLST.ColumnProp("AUG_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("AUG_DN_1", "Show") = "true";
                }

                if(i == 9) {
                  form1.grdT_EV_AIMLST.ColumnProp("SEP_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("SEP_DN_1", "Show") = "true";
                }

                if(i == 10) {
                  form1.grdT_EV_AIMLST.ColumnProp("OCT_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("OCT_DN_1", "Show") = "true";
                }

                if(i == 11) {
                  form1.grdT_EV_AIMLST.ColumnProp("NOV_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("NOV_DN_1", "Show") = "true";
                }

                if(i == 12) {
                  form1.grdT_EV_AIMLST.ColumnProp("DEC_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("DEC_DN_1", "Show") = "true";
                }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = ' ';

            fnc_DisableSet('2');        //입력불가 처리
            alert("검색하신 조건의 자료가 없습니다..");


        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            document.getElementById("resultMessage").innerText = '* ' + dsT_EV_AIMLST.CountRow + ' 건의 자료가 조회되었습니다.';

               document.getElementById("cmbACCEPT_GBN_SHR").value = dsT_EV_AIMLST.NameValue(1,"ACCEPT_GBN");
            fnc_DisableSet('2');        //입력불가 처리
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {

            //평가적용기간에 따라 그리드 조정
            fnc_Disp_RefColumn();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">목표현황상세</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="85"></col>
                                    <col width="65"></col>
                                    <col width="55"></col>
                                    <col width="60"></col>
                                    <col width="45"></col>
                                    <col width="65"></col>
                                    <col width="160"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="55"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><input id=txtEVL_YY_SHR size="4" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='해당년도'>
                                    </td>
                                    <td align="right" class="searchState">회차</td>
                                    <td class="padding2423"><input id=txtEVL_FRQ_SHR size="2" maxlength="3" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='회차'>
                                    </td>
                                    <td align="right" class="searchState">소속</td>
                                    <td class="padding2423"><input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">피평가자 사번</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='피평가자 사번'>
                                    </td>
                                    <td align="right" class="searchState">성명</td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">승인</td>
                                    <td class="padding2423">
                                        <select id=cmbACCEPT_GBN_SHR style="width:100">
                                            <option value="0"> 미승인</option>
                                            <option value="1">승인</option>
                                            <option value="2">반려</option>
                                        </select>
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
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:329px;">
                                <param name="DataID"                  value="dsT_EV_AIMLST">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="AutoReSizing"            value="true">
                                <param name=ColSizing                 value="true">
                                <param name=ColSelect                 value="true">
                                <param name=SuppressOption            value="1">
                                <param name="Format"                  value="
                                <FC> id='AIM_SEQ'         width=50        name='순번'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='주요 핵심과제(업무)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='핵심성공 요소(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (측정방법)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='목표 (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='계량;구분'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:계량,2:비계량'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='목표승인여부'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='순번'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='주요추진항목'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='평가지표(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%이상)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%미만)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%미만)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%미만)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%미만)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='실행시기'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='가중치;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='협조요청사항'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>