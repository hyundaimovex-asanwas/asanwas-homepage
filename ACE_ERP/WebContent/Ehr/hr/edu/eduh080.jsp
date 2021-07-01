<!--
    ************************************************************************************
    * @Source         : eduh080.jsp                                                    *
    * @Description    : 예외자관리 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/06  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>예외자관리(eduh080)</title>
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

        var btnList = 'TTFTFFFT';

        var gbn     = '';
        var exc_cd  = '';
        var eno_no  = '';
        var eno_nm  = '';


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;
            var EXC_CD = document.getElementById("cmbEXC_CD_SHR").value;
            var ENO_NO = document.getElementById("txtENO_NO_SHR").value;

            dsT_ED_EXCEPTER.ClearData();

            dsT_ED_EXCEPTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh080.cmd.EDUH080CMD&S_MODE=SHR&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&EXC_CD="+EXC_CD+"&ENO_NO="+ENO_NO;
            dsT_ED_EXCEPTER.Reset();

            form1.grdT_ED_EXCEPTER.Focus();

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

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ED_EXCEPTER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일[" + dsT_ED_EXCEPTER.NameValue(dsT_ED_EXCEPTER.RowPosition,"STR_YMD") + "] 예외자구분[" + dsT_ED_EXCEPTER.NameValue(dsT_ED_EXCEPTER.RowPosition,"EXC_NM")  + "] 사번 [" + dsT_ED_EXCEPTER.NameValue(dsT_ED_EXCEPTER.RowPosition,"ENO_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ED_EXCEPTER.DeleteRow(dsT_ED_EXCEPTER.RowPosition);

            trT_ED_EXCEPTER.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh080.cmd.EDUH080CMD&S_MODE=DEL";
            trT_ED_EXCEPTER.post();


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
            if (dsT_ED_EXCEPTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_ED_EXCEPTER.GridToExcel("예외자관리", '', 225);
        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            var obj = new String();
            obj.gbn     = "1";        // 1: 신규, 2: 수정
            obj.str_ymd = "";
            obj.end_ymd = "";
            obj.exc_cd  = "";
            obj.eno_no  = "";
            obj.eno_nm  = "";
            obj.remark  = "";

            window.showModalDialog("/hr/edu/eduh081.jsp", obj, "dialogHeight:300px; dialogWidth:430px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            fnc_SearchList();
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

            //document.getElementById("txtSTR_YMD_SHR").value = "";
            //document.getElementById("txtEND_YMD_SHR").value = "";
            document.getElementById("cmbEXC_CD_SHR").value = "";
            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_EXCEPTER.ClearData();

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
            cfStyleGrid(form1.grdT_ED_EXCEPTER,0,"false","false");

            //예외자구분
            for( var i = 1; i <= dsCOMMON_QD.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QD.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QD.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEXC_CD_SHR").add(oOption);

            }

            document.getElementById("txtSTR_YMD_SHR").value = getToday().substr(0, 4)+"-01-01";
            document.getElementById("txtEND_YMD_SHR").value = getToday().substr(0, 4)+"-12-31";

            document.getElementById("txtSTR_YMD_SHR").focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_EXCEPTER)|
    | 3. 사용되는 Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_EXCEPTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_EXCEPTER)|
    | 3. 사용되는 Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_EXCEPTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_EXCEPTER)">
    </Object>

    <!-- 예외자구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QD"/>
       <jsp:param name="CODE_GUBUN"    value="QD"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_EXCEPTER Event="OnDblClick(row, col)">
        var obj = new String();
        obj.gbn     = "2";        // 1: 신규, 2: 수정
        obj.str_ymd  = dsT_ED_EXCEPTER.NameValue(row, "STR_YMD");
        obj.end_ymd  = dsT_ED_EXCEPTER.NameValue(row, "END_YMD");
        obj.exc_cd  = dsT_ED_EXCEPTER.NameValue(row, "EXC_CD");
        obj.eno_no  = dsT_ED_EXCEPTER.NameValue(row, "ENO_NO");
        obj.eno_nm  = dsT_ED_EXCEPTER.NameValue(row, "ENO_NM");
        obj.remark  = dsT_ED_EXCEPTER.NameValue(row, "REMARK");

        window.showModalDialog("/hr/edu/eduh081.jsp", obj, "dialogHeight:280px; dialogWidth:410px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        fnc_SearchList();
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_EXCEPTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_EXCEPTER.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_EXCEPTER event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_EXCEPTER event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">예외자관리</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">예외자관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
	                           <col width="230"></col>
	                           <col width="80"></col>
	                           <col width="80"></col>
	                           <col width="60"></col>
	                           <col width=""></col>
	                        </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당기간&nbsp;</td>
                                <td class="padding2423" align="left">
	                                <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','110');"></a>
	                                ~
	                                <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
	                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','110');"></a>
                                </td>
                                <td align="right" class="searchState">예외자구분&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbEXC_CD_SHR>
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12"  onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                        <object    id="grdT_ED_EXCEPTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_ED_EXCEPTER">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=29    name='순번'           align=center </C>
                                <C> id='DPT_NM'       width=110   name='소속'           align=center </C>
                                <C> id='JOB_NM'       width=60    name='직위'           align=center </C>
                                <C> id='ENO_NO'       width=80    name='사번'           align=center </C>
                                <C> id='ENO_NM'       width=80    name='성명'           align=center </C>
                                <C> id='STR_YMD'      width=80    name='시작일자'       align=center </C>
                                <C> id='END_YMD'      width=80    name='종료일자'       align=center </C>
                                <C> id='EXC_NM'       width=80    name='예외구분'       align=center </C>
                                <C> id='REMARK'       width=130   name='비고'           align=left   </C>
                                <C> id='CPT_PNT'      width=50    name='점수'           align=right  RightMargin=5 </C>
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