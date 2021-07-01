<!--
    ************************************************************************************
    * @Source         : vluc110.jsp                                                    *
    * @Description    : 수정목표승인.                                                  *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/23  |  안준성   | 최초작성                                               *
    * 2007/03/17  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>수정목표승인(vluc110)</title>
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

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송(수정목표승인 조회)
            dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc110.cmd.VLUC110CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&&txtEVLENO_NO_SHR="+document.getElementById("txtEVLENO_NO_SHR").value;
            dsT_EV_AIMLST.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //년도별 평가회차정보 조회
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

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

            dsT_EV_AIMLST.ClearAll();

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

            // 업무구분
            if (frameid == "vluc110") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            //년도별 평가회차관리 조회
            fnc_SearchItem();

        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 조건에 따른 ,        *
         *        목표승인의 입력 disable,                            *
         *******************************************/
        function fnc_DisableSet(disableDiv) {

            if( disableDiv == 'true' ) {

            } else {

            }

        }

        /********************************************
         * 16. 수정목표승인처리 팝업        *
         *******************************************/
        function openPopupWin()
        {
            var EVL_YY     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
            var EVL_FRQ    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
            var AIM_YMD    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD");
            var ENO_NO     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
            var EVLENO_NO  = document.getElementById("txtEVLENO_NO_SHR").value;
            var ENO_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NM");
            var DPT_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"DPT_NM");

            var revck    = null;

            url = "/hr/" + "vlu" + "/" + "vluc111.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM;

            // 목표승인 화면 호출
            revck = window.showModalDialog(url, self, "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null)
                return;

        }

        /********************
         * 17. 단축키 처리  *
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

    <script language=JavaScript for=grdT_EV_AIMLST event=OnDblClick(row,colid)>

        if (row < 1) return;
        openPopupWin();        //수정목표승인처리 팝업

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("귀하는 수정목표를 승인 할 대상이 없습니다.");

        } else {

        }

           grdT_EV_AIMLST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("평가적용기간이 아닙니다.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value    = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value   = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            document.getElementById("txtEVLENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value    = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NM_SHR").value    = '<%=box.get("SESSION_DPTNM")%>';

             fnc_SearchList();
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

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

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
<!-- 그리드 클릭시 -->

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">수정목표승인</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">수정목표승인</font></td>
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
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="60"></col>
                                    <col width="75"></col>
                                    <col width="120"></col>
                                    <col width="75"></col>
                                    <col width="65"></col>
                                    <col width="75"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">해당년도</td>
                                    <td class="padding2423"><input id=txtEVL_YY_SHR size="10" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">회차</td>
                                    <td class="padding2423"><input id=txtEVL_FRQ_SHR size="10" maxlength="3" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">소속</td>
                                    <td class="padding2423"><input id=txtDPT_NM_SHR size="15" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">평가자 사번</td>
                                    <td class="padding2423"><input id=txtEVLENO_NO_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">성명</td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
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

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>피평가자 List</strong></td>
        </tr>
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                  value="dsT_EV_AIMLST">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id=''       width=50        name='순번'     align=center        value={(String(Currow))} </C>
                                    <C> id='GROUP_NM'       width=82        name='평가그룹'     align=left </C>
                                    <C> id='HEAD_NM'       width=100        name='본부'     align=left </C>
                                    <C> id='DPT_NM'       width=81        name='소속'     align=left </C>
                                    <C> id='JOB_NM'       width=81        name='직위'     align=left </C>
                                    <C> id='ENO_NO'       width=80        name='사번'     align=center </C>
                                    <C> id='ENO_NM'       width=80        name='성명'     align=center </C>
                                    <C> id='AIM_YMD'       width=70        name='수정일자'     align=center </C>
                                    <C> id='AIM_INPUT_GBN'       width=80        name='목표입력여부'     align=center    value={'입력'} </C>
                                    <C> id='ACCEPT_GBN'       width=60        name='승인여부'     align=center        editstyle=combo data='0:미승인,1:승인,2:반려,3:승인취소' </C>
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