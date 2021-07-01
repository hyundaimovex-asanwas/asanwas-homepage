<!--
    ************************************************************************************
    * @Source         : vluc250.jsp                                                    *
    * @Description    : 부서목표현황 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/01  |  박인이   | 최초작성                                               *
    * 2007/03/18  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>부서목표현황(vluc250)</title>
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
        var EVL_GBN = '2';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY  = document.form1.txtEVL_YY_SHR.value;      //해당년도
            var EVL_FRQ = document.form1.cmbEVL_FRQ_SHR.value;     //회차
            var DPT_CD   = document.form1.txtDPT_CD_SHR.value;     //소속
            var GROUP_CD = document.form1.cmbGROUP_CD_SHR.value;   //평가그룹

            //역량 평가 적용 결과 정보 조회
            dsT_EV_AIMLST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc250.cmd.VLUC250CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&DPT_CD="+DPT_CD+"&GROUP_CD="+GROUP_CD+"&EVL_GBN="+EVL_GBN;
            dsT_EV_AIMLST.reset();

            form1.grdT_EV_AIMLST.Focus();

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

            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_ESTINFO.ClearData();
            dsT_EV_AIMLST.ClearData();

            document.form1.cmbGROUP_CD_SHR.focus();

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

            var EVL_YY  = null;

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_AIMLST,0,"false","false");

            // 업무구분
            if (frameid == "vluc250") {
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

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            form1.txtDPT_CD_SHR.focus();

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


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMLST)    |
    | 3. 사용되는 Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
        if ( iCount == 0 )    {

            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

            dsT_EV_AIMLST.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value  = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.cmbEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");

            form1.txtDPT_CD_SHR.value  = '<%=box.get("SESSION_DPTCD")%>';
            form1.txtDPT_NM_SHR.value  = '<%=box.get("SESSION_DPTNM")%>';

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
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        var firstList = new Array ();

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_AIMLST.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------+
    | 그리드를 더블클릭시 면담상세관리팝업창이 뜨도록 함   |
    +------------------------------------------------------>
    <script For=grdT_EV_AIMLST Event="OnDblClick(row,colid)">

        if( row < 1 )  return;

         var EVL_YY     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
         var EVL_FRQ    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
         var ENO_NO     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
         var ENO_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NM");
         var DPT_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"DPT_NM");
         var EVLENO_NO  = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
         var AIM_YMD    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD");
         var ACCEPT_YMD = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ACCEPT_YMD");

         var revck    = null;

         url = "/hr/" + "vlu" + "/" + "vluc121.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+"&EVLENO_NO="+EVLENO_NO+"&AIM_YMD="+AIM_YMD+"&ACCEPT_YMD="+ACCEPT_YMD;

         // 면담상세관리 화면 호출
         revck = window.showModalDialog(url, "AIMLST_01", "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

         if (revck == -1 || revck == null) {
             return;
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">부서목표현황</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">부서목표현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="50"></col>
                                <col width="40"></col>
                                <col width="40"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="200"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423"><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">회차</td>
<!--                            <td class="padding2423"><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly></td> -->
                                <td class="padding2423">
                                    <select name="cmbEVL_FRQ_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value='1' selected>1회</option>
                                        <option value='2' selected>2회</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">평가그룹&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()">
                                        <option value=''>전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">소속&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtDPT_CD_SHR size="8"  class="input_ReadOnly" readonly>
                                    <input name=txtDPT_NM_SHR size="20" class="input_ReadOnly" readonly>
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
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                        <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_AIMLST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="FixSizing"               value="true">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='GROUP_NM'      width=80   name='평가그룹'   align=left   </C>
                                <C> id='HEAD_NM'       width=110  name='본부'       align=left   </C>
                                <C> id='DPT_NM'        width=110  name='소속'       align=left   </C>
                                <C> id='JOB_NM'        width=80   name='직위'       align=left   </C>
                                <C> id='ENO_NO'        width=80   name='사번'       align=center </C>
                                <C> id='ENO_NM'        width=80   name='성명'       align=center </C>
                                <C> id='EVLENO_NM'     width=80   name='평가자'     align=center </C>
                                <C> id='AIM_YMD_VIEW'  width=80   name='작성일자'   align=center </C>
                                <C> id='ACCEPT_YMD'    width=80   name='승인일자'   align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="searchState"> * 더블 클릭시 상세 내역이 조회됩니다.</td>
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