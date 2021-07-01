<!--
    ************************************************************************************
    * @Source         : cdpc040.jsp                                                    *
    * @Description    : 멘토(Mentor)보고서 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/23  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String ROLE_CD = box.getString("SESSION_ROLE_CD");
    String EDU_AUTHO = box.getString("SESSION_EDU_AUTHO");

    boolean isMaster = false;
    boolean isSubMaster = false;

    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")
            || EDU_AUTHO.equals("A")) {
        isMaster = true;
    } else if (EDU_AUTHO.equals("S")) {
        isSubMaster = true;
    }
%>

<html>

    <head>
    <title>멘토(Mentor)보고서(cdpc040)</title>
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
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "F"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var eno_no = '';
        var eno_nm = '';
        var seq_no = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var MNT_GBN = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("hidEMPL_DPT_CD").value;
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;


            // 후견시작일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "후견기긴 FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // 멘토링 기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "멘토링 기간 TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // 멘토링 기간 FROM일자와 TO일자 비교
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("멘토링 기간 FROM일자는 반드시 멘토링 기간 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }

            dsT_CD_MENTO.DataId = "/servlet/GauceChannelSVL?cmd=hr.cdp.c.cdpc040.cmd.CDPC040CMD"
                                + "&S_MODE=SHR"
                                + "&MNT_GBN="+MNT_GBN
                                + "&ENO_NO="+ENO_NO
                                + "&DPT_CD="+DPT_CD
                                + "&STR_YMD="+STR_YMD
                                + "&END_YMD="+END_YMD;
            dsT_CD_MENTO.Reset();

            //form1.grdT_CD_MENTO.Focus();
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

            var MNT_GBN = document.getElementById("cmbMNT_GBN").value;
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;

            // 후견시작일자
            if( STR_YMD == '' ) {
                alert("멘토링 기간 FROM일자는 필수 입력사항입니다.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // 후견시작일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "후견기긴 FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            // 멘토링 기간 TO일자
            if( END_YMD == '' ) {
                alert("멘토링 기간 TO일자는 필수 입력사항입니다.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // 멘토링 기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "멘토링 기간 TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            // 멘토링 기간 FROM일자와 TO일자 비교
            if(STR_YMD != '' && END_YMD != '') {
                if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                    alert("멘토링 기간 FROM일자는 반드시 멘토링 기간 TO일자보다 작아야합니다.");
                    document.getElementById("txtSTR_YMD_SHR").focus();
                    return false;
                }
            }

            var url = "cdpc050_PV.jsp?MNT_GBN="+MNT_GBN
                                + "&ENO_NO="+ENO_NO
                                + "&STR_YMD="+STR_YMD
                                + "&END_YMD="+END_YMD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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

            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            dsT_CD_MENTO.ClearData();


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
            cfStyleGrid(form1.grdT_CD_MENTO,0,"false","false");

<%
    //관리자가 아니면 다른 사번으로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
                document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
                document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';

                fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                fnc_ChangeStateElement(false, "ImgEnoNoShr");

                //멘토(Mentor)만 조회가 되게
                fnc_ChangeStateElement(false, "cmbMNT_GBN");
                document.getElementById("cmbMNT_GBN").value = "M";
<%
    }
    //소속부서담당자의 경우 자신의 부서에서만 검색이 가능
    if(isSubMaster) {
%>
                document.getElementById("hidEMPL_DPT_CD").value = "<%=box.get("SESSION_DPTCD") %>";
<%
    }
%>

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CD_MENTO.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_CD_MENTO)|
    | 3. 사용되는 Table List(T_CD_MENTO)       |
    +----------------------------------------------->
    <Object ID="dsT_CD_MENTO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_CD_MENTO Event="OnDblClick(row, col)">

        eno_no  = dsT_CD_MENTO.NameValue(row, "ENO_NO");
        eno_nm  = dsT_CD_MENTO.NameValue(row, "ENO_NM");
        seq_no  = dsT_CD_MENTO.NameValue(row, "SEQ_NO");

        window.showModalDialog("/hr/cdp/cdpc041.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CD_MENTO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_MENTO.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CD_MENTO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">멘토링 보고서</td>
                    <td align="right" class="navigator">HOME/교육관리/CDP/멘토링관리/<font color="#000000">멘토링 보고서</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                                <col width="90"></col>
                                <col width="100"></col>
                                <col width="90"></col>
                                <col width="180"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>

                            <tr>
                                <td align="right" class="searchState">구&nbsp;&nbsp;분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbMNT_GBN">
                                        <option value="">전체</option>
                                        <option value="P">멘티(Mentee)</option>
                                        <option value="M">멘토(Mentor)</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState" width="70">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">멘토링 기간&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '멘토링 기간 FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> ~
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '멘토링 기간 TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd1" name="ImgEduEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
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
                        <object    id="grdT_CD_MENTO" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_CD_MENTO">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=40    name='순번'       align=center </C>
                                <G> name='멘티(Mentee)' HeadBgColor='#F7DCBB'
                                    <C> id='DPT_NM'          width=80    name='소속'       align=left   </C>
                                    <C> id='JOB_NM'          width=60    name='직위'       align=center </C>
                                    <C> id='ENO_NO'          width=60    name='사번'       align=center </C>
                                    <C> id='ENO_NM'          width=60    name='성명'       align=center </C>
                                </G>
                                <G> name='멘토(Mentor)' HeadBgColor='#F7DCBB'
                                    <C> id='MDPT_NM'         width=80    name='소속'       align=left   </C>
                                    <C> id='MJOB_NM'         width=60    name='직위'       align=center </C>
                                    <C> id='MENO_NO'         width=60    name='사번'       align=center </C>
                                    <C> id='MENO_NM'         width=60    name='성명'       align=center </C>
                                </G>
                                <G> name='멘토링 기간' HeadBgColor='#F7DCBB'
                                    <C> id='STR_YMD'         width=80    name='시작일자'   align=center </C>
                                    <C> id='END_YMD'         width=80    name='종료일자'   align=center </C>
                                </G>
                                <C> id='IPT_YMD'             width=80    name='작성일자'   align=center </C>
                                <C> id='OBJ_TXT'             width=220   name='목적'       align=left   </C>
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

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 해당 항목을 더블클릭 하시면 멘토(Mentor)보고서을 등록하거나 수정하실 수 있습니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>