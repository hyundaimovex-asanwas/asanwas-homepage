<!--
    ************************************************************************************
    * @Source         : eduh050.jsp                                                    *
    * @Description    : 담당과정운영 PAGE                                              *
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
    <title>담당과정운영(eduh050)</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;
            var MNGER_CD = document.getElementById("cmbMNGER_CD_SHR").value;
            var FIELD_CD = document.getElementById("cmbFIELD_CD_SHR").value;
            var SHAPE_CD = document.getElementById("cmbSHAPE_CD_SHR").value;
            var EDU_CD   = document.getElementById("txtEDU_CD_SHR").value;
            var EDU_STR_YMD  = document.getElementById("txtEDU_STR_YMD_SHR").value;
            var EDU_END_YMD  = document.getElementById("txtEDU_END_YMD_SHR").value;
            var SEQ_NO = document.getElementById("txtSEQ_NO_SHR").value;

            if (SEQ_NO == ''){
                SEQ_NO = '%' ;
            }

            //시작일과 종료일이 둘다 입력이 되었거나 둘다 비어있을 경우가 아니면 일자를 등록
            if((EDU_STR_YMD != "" && EDU_END_YMD == "")
                    || (EDU_STR_YMD == "" && EDU_END_YMD != "")) {
                if(EDU_STR_YMD == "") {
                    alert("시작일이 비어 있습니다.");
                    document.getElementById("txtEDU_STR_YMD_SHR").focus();
                    return;
                }
                if(EDU_END_YMD == "") {
                    alert("종료일이 비어 있습니다.");
                    document.getElementById("txtEDU_END_YMD_SHR").focus();
                    return;
                }
            }

           //교육장소구분 없앰
           /* var PLACE_NM1 = "";
            var PLACE_NM2 = "";
            var PLACE_NM3 = "";
            var place = document.getElementsByName("chkPLACE_NM");

            if(place[0].checked == true )
                PLACE_NM1 = "1";
            if(place[1].checked == true )
                PLACE_NM2 = "2";
            if(place[2].checked == true )
                PLACE_NM3 = "3";  */


            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh050.cmd.EDUH050CMD&S_MODE=SHR&MNGER_CD="+MNGER_CD+"&FIELD_CD="+FIELD_CD+"&SHAPE_CD="+SHAPE_CD+"&EDU_CD="+EDU_CD+"&ENO_NO="+<%=box.get("SESSION_ENONO")%>+"&EDU_STR_YMD="+EDU_STR_YMD+"&EDU_END_YMD="+EDU_END_YMD+"&SEQ_NO="+SEQ_NO;  //+"&PLACE_NM1="+PLACE_NM1+"&PLACE_NM2="+PLACE_NM2+"&PLACE_NM3="+PLACE_NM3;
            dsT_ED_COURSELIST.Reset();

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

            if (dsT_ED_COURSELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ED_COURSELIST.GridToExcel("담당과정운영", '', 225)

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

            document.getElementById("cmbMNGER_CD_SHR").value = "";
            document.getElementById("cmbFIELD_CD_SHR").value = "";
            document.getElementById("cmbSHAPE_CD_SHR").value = "";
            document.getElementById("txtEDU_CD_SHR").value   = "";
            document.getElementById("txtEDU_NM_SHR").value   = "";
            document.getElementById("txtEDU_STR_YMD_SHR").value = "";
            document.getElementById("txtEDU_END_YMD_SHR").value = "";
            document.getElementById("txtSEQ_NO_SHR").value = "" ;

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_COURSELIST.ClearData();

            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
            cfStyleGrid(form1.grdT_ED_COURSELIST,0,"false","false");

            //교육주관
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD_SHR").add(oOption);

            }

            //교육분야
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }

            //교육형태
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }

            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_COURSELIST)">
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

    <Script For=grdT_ED_COURSELIST Event="OnDblClick(row, col)">
        var obj = new String();
        obj.edu_cd = dsT_ED_COURSELIST.NameString(row, "EDU_CD");
        obj.edu_nm = dsT_ED_COURSELIST.NameString(row, "EDU_NM");
        obj.seq_no = dsT_ED_COURSELIST.NameString(row, "SEQ_NO");
        obj.comm_no = dsT_ED_COURSELIST.NameString(row, "COMM_NO");

        // 학습자관리 선택시
        if (col == 'OBJ_MAN') {
            window.showModalDialog("/hr/edu/eduh051.jsp", obj, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            fnc_SearchList();
        }
        // 일괄등록 선택시
        else if (col == 'BAT_INS' && dsT_ED_COURSELIST.NameString(row, col) != "") {

/*  2007년에는 대상자 일괄 등록을 자유롭게 사용 2008년 부터는 수정할 필요 있음
            if(!(dsT_ED_COURSELIST.NameValue(row, "EDU_STR_YMD") > getToday())) {
                alert("대상자일괄등록은 교육시작 이전에 등록가능합니다.");
                return;
            }
*/

            window.showModalDialog("/hr/edu/eduh052.jsp", obj, "dialogHeight:600px; dialogWidth:670px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            fnc_SearchList();
        }
        // 실적등록 선택시
        else if (col == 'RES_INS' && dsT_ED_COURSELIST.NameString(row, col) != "") {


            //학습이 시작되야 실적등록 가능
            if(dsT_ED_COURSELIST.NameString(row, "EDU_STR_YMD") >= getToday()){
                alert("교육기간 이후에 실적등록이 가능합니다.");
                return;
            }

            //신청자가 한명이라도 있으면
            if (dsT_ED_COURSELIST.NameValue(row, "REQ_CNT")+dsT_ED_COURSELIST.NameValue(row, "PAS_CNT") > 0) {

                window.showModalDialog("/hr/edu/eduh053.jsp", obj, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                fnc_SearchList();
            }
            else {
                alert("실적등록대상이 존재하지 않습니다.");
                return;
            }
        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
 <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {
            //document.getElementById("hidCOMM_NO").value = dsT_ED_COURSELIST.NameValue(1,"COMM_NO");
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_ED_COURSELIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">담당과정운영</td>
                    <td align="right" class="navigator">HOME/교육관리/과정운영자/<font color="#000000">담당과정운영</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                         <!--   <colgroup>
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="50"></col>
                                <col width="90"></col>
                                <col width="80"></col>
                                <col width="90"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>     -->
                            <tr>
                                <td align="right" class="searchState">교육기간&nbsp;</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtEDU_STR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD_SHR','','20','120');"></a>
                                    ~
                                    <input id="txtEDU_END_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD_SHR','','20','120');"></a>
                                </td>
		                    <!--    <td class="searchState" align="right">교육장소&nbsp;</td>
		                        <td class="padding2423" align="left" colspan="3">
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>사내
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>사외
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>인터넷
		                        </td>    -->
		                          <td align="right" class="searchState">차수명 </td>
                                      <td class="padding2423" align="left">
                                    <input id=txtSEQ_NO_SHR name=txtSEQ_NO_SHR size="7" maxlength="7">
                                  </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">주&nbsp;&nbsp;관&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbMNGER_CD_SHR style="WIDTH:70" >
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">분&nbsp;&nbsp;야&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbFIELD_CD_SHR style="WIDTH:90" >
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">형&nbsp;&nbsp;태&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbSHAPE_CD_SHR style="WIDTH:90" >
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">교육과정&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtEDU_CD_SHR size="4"  maxlength="4" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                                    <input id=txtEDU_NM_SHR name=txtEDU_NM_SHR size="18" class="input_ReadOnly" readOnly>
                                      <input type=hidden id="hidCOMM_NO">
                                      <!--<input id="txtCOMM_NO" name="txtCOMM_NO" size="5" > -->
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=40    name='NO'                align=center </FC>
                                <FC> id='EDU_NM'       width=130   name='과정명'            align=left   suppress = '1'</FC>
                                <FC> id='SEQ_NO'       width=55    name='차수'              align=center </FC>
                                <C>  id='ENT_TERM'     width=150   name='신청기간'          align=center </C>
                                <C>  id='EDU_TERM'     width=150   name='교육기간'          align=center </C>
                                <C>  id='SHAPE_NM'     width=70    name='형태'              align=center </C>
                                <C>  id='EDU_GBN_NM'   width=50    name='구분'              align=center </C>
                                <C>  id='MNGER_CD_NM'  width=50    name='주관'              align=center </C>
                                <C>  id='REQ_CNT'      width=48    name='신청'              align=right  </C>
                                <C>  id='OBJ_CNT'      width=48    name='대상'              align=right  show=false</C>
                                <C>  id='PAS_CNT'      width=48    name='수료'              align=right  </C>
                                <C>  id='OBJ_MAN'      width=90    name='학습자관리'        align=center Color='Blue' </C>
                                <C>  id='BAT_INS'      width=80    name='대 상 자;일괄등록' align=center Color='Blue' </C>
                                <C>  id='RES_INS'      width=80    name='학습결과'          align=center Color='Blue' </C>
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