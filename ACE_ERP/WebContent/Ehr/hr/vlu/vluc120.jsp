<!--
    ************************************************************************************
    * @Source         : vluc120.jsp                                                    *
    * @Description    : 목표현황.                                                      *
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
<%@ include file="/common/sessionCheck.jsp"%>

<html>

<head>
<title>목표현황(vluc120)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript">

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

            if( document.getElementById("cmbGROUP_CD_SHR").value != '' ) {
                if (GUBUN == "01") {
                    document.getElementById("txtCOMM_CD_SHR").value = 'EG';
                }
                else if (GUBUN == "02") {
                    document.getElementById("txtCOMM_CD_SHR").value = '4';
                }
            }
            else {
                document.getElementById("txtCOMM_CD_SHR").value = '';
            }

            if( searchDiv == '1' || searchDiv == undefined ) {
                //작성일자,승인일자 초기화
                dsT_EV_AIMLST_01.ClearAll();
                //데이터셋 전송(목표현황 조회)
                dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc120.cmd.VLUC120CMD&S_MODE=SHR&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&cmbEVL_FRQ_SHR="+document.getElementById("cmbEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value;
                dsT_EV_AIMLST.Reset();
            }
            if( searchDiv == '2' ) {
                //데이터셋 전송(작성일자,승인일자 조회)
                dsT_EV_AIMLST_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc120.cmd.VLUC120CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
                dsT_EV_AIMLST_01.Reset();
            }

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

                //데이터셋 전송(평가구조설정정보 조회)
                dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
                dsT_EV_TYPE.Reset();

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

            document.getElementById("cmbEVL_YY_SHR")[4].selected = true;
            fnc_SearchItem();
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            dsT_EV_AIMLST.ClearAll();
            dsT_EV_AIMLST_01.ClearAll();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_EV_AIMLST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

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
            cfStyleGrid(form1.grdT_EV_AIMLST, 15, "false", "false");
            cfStyleGrid(form1.grdT_EV_AIMLST_01, 15, "false", "false");

            getSelYy('cmbEVL_YY_SHR');                 //SelectBox년도 Setting

            // 업무구분
            if (frameid == "vluc120") {
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

            //평가구조설정정보 조회
            fnc_SearchItem();

<%
    //마스터가 아니면 다른 사번으로 검색 못함
    if(!box.getString("SESSION_ROLE_CD").equals("1001")
            && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            document.getElementById("txtENO_NO_SHR").value   = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value   = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_CD_SHR").value   = '<%=box.get("SESSION_DPTCD")%>';
            document.getElementById("txtDPT_NM_SHR").value   = '<%=box.get("SESSION_DPTNM")%>';

            document.getElementById("txtENO_NO_SHR").readOnly  = true;
            document.getElementById("txtDPT_CD_SHR").readOnly  = true;
            document.getElementById("txtENO_NO_SHR").className     = "input_ReadOnly";
            document.getElementById("txtDPT_CD_SHR").className     = "input_ReadOnly";
            document.getElementById("imgDPT_CD_SHR").style.display = "none";
            document.getElementById("imgENO_NO_SHR").style.display = "none";
<%
    }
%>


        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 면담상세관리 팝업        *
         *******************************************/
        function openPopupWin()
        {

            var EVL_YY = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
            var EVL_FRQ = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
            var ENO_NO = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
            var ENO_NM = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NM");
            var DPT_NM = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"DPT_NM");
            var EVLENO_NO = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
            var AIM_YMD = dsT_EV_AIMLST_01.NameValue(dsT_EV_AIMLST_01.RowPosition,"AIM_YMD");
            var ACCEPT_YMD = dsT_EV_AIMLST_01.NameValue(dsT_EV_AIMLST_01.RowPosition,"ACCEPT_YMD");

            var revck    = null;

            url = "/hr/" + "vlu" + "/" + "vluc121.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+"&EVLENO_NO="+EVLENO_NO+"&AIM_YMD="+AIM_YMD+"&ACCEPT_YMD="+ACCEPT_YMD;

            // 면담상세관리 화면 호출
            revck = window.showModalDialog(url, "AIMLST_01", "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null)
                return;

        }

        /********************
         * 16. 단축키 처리  *
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsT_EV_AIMLST_01"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"  value="EG"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
        if( row > 0 )
            fnc_SearchList('2');        //작성일자,승인일자 조회
    </script>

    <script language=JavaScript for=grdT_EV_AIMLST_01    event=OnDblClick(row,colid)>
        if( row > 0 )
            openPopupWin('S');        //면담상세관리 팝업
    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_AIMLST.CountRow);

        }

           grdT_EV_AIMLST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_AIMLST_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩

        }

           grdT_EV_AIMLST_01.SetColumn("AIM_YMD_VIEW");//set focus

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //회차콤보 모두삭제
            for( i=0; i<=document.getElementById("cmbEVL_FRQ_SHR").length; i++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
            }

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            var oOption;
            //회차콤보 모두삭제
            for( j=0; j<=document.getElementById("cmbEVL_FRQ_SHR").length; j++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
                document.getElementById("cmbEVL_FRQ_SHR").remove(1);
            }
            for( k=1; k<=Number(dsT_EV_TYPE.NameValue(1,"ACH_CNT")); k++ ) {        //역량평가회수
                oOption = document.createElement("OPTION");
                oOption.value = k;
                oOption.text = k;
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

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

    <Script For=dsT_EV_AIMLST_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

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

    <Script For=dsT_EV_AIMLST_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">목표현황</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">목표현황</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1');"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="60 "></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="60 "></col>
                                    <col width="100"></col>
                                    <col width="45 "></col>
                                    <col width="170"></col>
                                    <col width="45 "></col>
                                    <col width="170"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                    <td align="right" class="searchState">회차</td>
                                    <td class="padding2423">
                                        <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList('1');" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">평가그룹</td>
                                    <td class="padding2423">
                                        <input type="hidden" id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR">
                                        <select id=cmbGROUP_CD_SHR style="WIDTH: 100%" onChange="fnc_SearchList('1');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                            <option value='' selected>전 체</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">소속</td>
                                    <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="8"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                    <input name=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly>&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                    </td>
                                    <td align="right" class="searchState">사번</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1'); cfNumberCheck();">
                                    <input name=txtENO_NM_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly>&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:619px;height:340px;">
                                <param name="DataID"                    value="dsT_EV_AIMLST">
                                <param name="EdiTABLE"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                    value="Left">
                                <param name="IndWidth"                    value=0>
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="Format"                    value="
                                    <C> id={String(currow)}        width=50        name='순번'         align=center </C>
                                    <C> id='GROUP_NM'        width=80        name='평가그룹'        align=left </C>
                                    <C> id='HEAD_NM'        width=83        name='본부'        align=left </C>
                                    <C> id='DPT_NM'        width=80        name='소속'            align=left </C>
                                    <C> id='JOB_NM'        width=80        name='직위'            align=left </C>
                                    <C> id='ENO_NO'        width=70        name='사번'            align=center </C>
                                    <C> id='ENO_NM'        width=70        name='성명'            align=center </C>
                                    <C> id='EVLENO_NM'        width=70        name='평가자'        align=center </C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td width="30"></td>
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_AIMLST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:176px;height:340px;">
                                <param name="DataID"                    value="dsT_EV_AIMLST_01">
                                <param name="Editable"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                    value="Left">
                                <param name="IndWidth"                    value=0>
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="Format"                    value="
                                    <C> id='AIM_YMD_VIEW'        width=70        name='작성일자',        align=center         </C>
                                    <C> id='ACCEPT_YMD'        width=70        name='승인일자'            align=center </C>
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