<!--
    ************************************************************************************
    * @Source         : educ010.jsp                                                    *
    * @Description    : 과정참여현황 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/08  |  박인이   | 최초작성                                               *
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
    <title>과정참여현황(educ010)</title>
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

        var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var YEAR      = document.getElementById("txtYEAR_SHR").value;
            var ENO_NO    = document.getElementById("txtENO_NO_SHR").value;


            dsT_ED_CHASULIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ010.cmd.EDUC010CMD"
                                    + "&S_MODE=SHR"
                                    + "&YEAR="+YEAR
                                    + "&ENO_NO="+ENO_NO
                                    ;
            dsT_ED_CHASULIST.Reset();

            form1.grdT_ED_CHASULIST.Focus();

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

            var ENO_NO  = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NO");
            var STR_YMD = dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"STR_YMD");

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("해당과정 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_CD") + "] [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"EDU_NM") + "], 학습자 [" + dsT_ED_CHASULIST.NameValue(dsT_ED_CHASULIST.RowPosition,"ENO_NM") + "] 자료의 신청을 취소하시겠습니까?") == false) return;

            dsT_ED_CHASULIST.DeleteRow(dsT_ED_CHASULIST.RowPosition);

            trT_ED_CHASULIST.KeyValue = "SVL(I:dsT_ED_CHASULIST=dsT_ED_CHASULIST)";
            trT_ED_CHASULIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.c.educ010.cmd.EDUC010CMD&S_MODE=DEL";
            trT_ED_CHASULIST.post();

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

            if (dsT_ED_CHASULIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_CHASULIST.GridToExcel("과정참여현황", '', 225);

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

            document.getElementById("txtYEAR_SHR").value     = getToday().substr(0,4);
            document.getElementById("txtENO_CD_SHR").value   = '';
            document.getElementById("txtENO_NM_SHR").value   = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_CHASULIST.ClearData();

            document.getElementById("txtYEAR_SHR").focus();

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
            //cfStyleGrid(form1.grdT_ED_CHASULIST,0,"false","false");
            cfStyleGrid2(form1.grdT_ED_CHASULIST);
            form1.grdT_ED_CHASULIST.IndWidth = 0;

            document.getElementById("txtYEAR_SHR").value = getToday().substr(0,4);



<%
    //관리자가 아니면 다른 사번으로 조회가 되지 않게
    if(!isMaster && !isSubMaster) {
%>
            document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';

            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
<%
    }
    //소속부서담당자이거나 일반사용자의 경우 자신의 부서에서만 검색이 가능
    if(!isMaster) {
%>
<%
    }
%>

            document.getElementById("txtYEAR_SHR").focus();

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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_EDUCATION)|
    | 3. 사용되는 Table List(T_CM_EDUCATION)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_CHASULIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_CHASULIST)">
    </Object>

    <!-----------------------------------------------------+
    | 1. 카피용 DataSet							           |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_CHASULIST)		   |
    | 3. 사용되는 Table List(T_ED_CHASULIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_ED_CHASULIST_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-- 교육주관 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육분야 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육형태 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_CHASULIST Event="OnDblClick(row, col)">
        var obj = new String();
        obj.edu_yy      = dsT_ED_CHASULIST.NameValue(row, "EDU_YY");
        obj.edu_cd      = dsT_ED_CHASULIST.NameValue(row, "EDU_CD");
        obj.edu_nm      = dsT_ED_CHASULIST.NameValue(row, "EDU_NM");
        obj.seq_no      = dsT_ED_CHASULIST.NameValue(row, "SEQ_NO");
        obj.eno_no      = dsT_ED_CHASULIST.NameValue(row, "ENO_NO");
        obj.eno_nm      = dsT_ED_CHASULIST.NameValue(row, "ENO_NM");
        //obj.str_ymd     = dsT_ED_CHASULIST.NameValue(row, "STR_YMD");

        // 수강취소
        if (col == 'CANC_YN' && dsT_ED_CHASULIST.NameValue(row, "CANC_YN") == "수강취소") {
            fnc_Delete();
        }

        // 결과보고
        // 1: 등록, 2: 수정
        if (col == 'EDU_RPT' && dsT_ED_CHASULIST.NameValue(row, "EDU_RPT") == "결과보고") {
            if(dsT_ED_CHASULIST.NameValue(row, "EDU_RPT") == "결과보고"){
            	obj.gbn = "1";
            } else if(dsT_ED_CHASULIST.NameValue(row, "EDU_RPT") == "완료"){
            	obj.gbn = "2";
            }

            window.showModalDialog("/hr/edu/educ011.jsp", obj, "dialogWidth:860px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }

        // 교육이력
        else if (col == 'FUNC') {
			window.showModalDialog("/hr/edu/educ012.jsp", obj, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }


    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_CHASULIST.CountRow );

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

    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_CHASULIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_CHASULIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이수과정현황</td>
                    <td align="right" class="navigator">HOME/교육관리/나의학습정보/<font color="#000000">이수과정현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                            <tr>

                                <td align="right" class="searchState">교육년도&nbsp;</td>
                                <td class="padding2423" align="left">


                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtYEAR_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>

                                </td>
                                <td align="right" class="searchState">사&nbsp;&nbsp;번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
                        <object    id="grdT_ED_CHASULIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_CHASULIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="ColSelect"  				value="true">
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=29    name='NO'           align=center </FC>
                                <FC> id='EDU_NM'       width=200   name='과정명'         align=left  suppress = '1' </FC>
                                <FC> id='SEQ_NO'       width=50    name='차수'           align=center </FC>
                                <C>  id='EDU_TERM'     width=160   name='학습기간'       align=center </C>
                                <C>  id='MNGER_NM'     width=55    name='교육주관'           align=center show=false</C>
                                <C>  id='FIELD_NM'     width=80    name='교육분야'           align=center </C>
                                <C>  id='SHAPE_NM'     width=80    name='교육형태'           align=center show=false</C>
                                <C>  id='ENO_NM'       width=60    name='학습자'         align=center </C>
                                <C>  id='PENO_NM'      width=80    name='과정담당자'     align=center show=false</C>
                                <C>  id='DECISION_NM'  width=55    name='수강상태'       align=center </C>
                                <C>  id='CANC_YN'      width=65    name='신청취소'       align=center Color='Blue' </C>
                                <C>  id='EDU_RPT'      width=70    name='결과보고'       align=center Color='Blue' </C>
                                <C>  id='FUNC'         width=80    name='교육이력'       align=center Color='Blue' show=false</C>

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