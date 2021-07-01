<!--
    ************************************************************************************
    * @Source         : mema016.jsp                                                    *
    * @Description    : 가족사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>가족사항</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_FAMILY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_FAMILY.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_ME_FAMILY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=SAV";
                trT_ME_FAMILY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_ME_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_FAMILY.RowStatus(dsT_ME_FAMILY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_FAMILY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("가족[" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_ME_FAMILY.NameValue(dsT_ME_FAMILY.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;

            dsT_ME_FAMILY.DeleteRow(dsT_ME_FAMILY.RowPosition);

            if (status != 1) {

                trT_ME_FAMILY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema016.cmd.MEMA016CMD&S_MODE=DEL";
                trT_ME_FAMILY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_FAMILY.SetColumn(form1.grdT_ME_FAMILY.GetColumnID(0));
            form1.grdT_ME_FAMILY.Focus();

            bnd.ActiveBind = true;

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

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_ME_FAMILY.CountColumn == 0) {
                dsT_ME_FAMILY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, REL_NM:STRING, ENO_NM:STRING:KEYVALUETYPE,  BIR_YMD:STRING, EDGR_CD:STRING, EDGR_NM:STRING, OCC_NAM:STRING, JOB_CD:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_FAMILY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_FAMILY.setColumn(form1.grdT_ME_FAMILY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtREL_CD").disabled = false;
            document.getElementById("txtENO_NM").disabled = false;
            document.getElementById("ImgRelCd").disabled  = false;

            document.getElementById("txtREL_CD").focus();
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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_FAMILY.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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

            var f = document.form1;

            //DataSet의 변경 여부 확인
            if (!dsT_ME_FAMILY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_FAMILY.CountRow; i++ ) {
                if ( dsT_ME_FAMILY.RowStatus(i) == 1 ||
                     dsT_ME_FAMILY.RowStatus(i) == 3 ) {

                    // 가족관계
                    if( dsT_ME_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("가족관계는 필수 입력사항입니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return false;
                    }

                    // 성명
                    if( dsT_ME_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("가족성명는 필수 입력사항입니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtENO_NM").focus();
                        return false;
                    }

                    // 생년월일 CHECK
                    if (!fnc_CheckDate2(dsT_ME_FAMILY.NameValue(i, "BIR_YMD"), "생년월일") && dsT_ME_FAMILY.NameValue(i, "BIR_YMD") != "") {
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtBIR_YMD").focus();
                        return false;
                    }

                    // 가족관계
                    if (dsT_ME_FAMILY.NameValue(i, "REL_CD") != "" &&
                        dsT_ME_FAMILY.NameValue(i, "REL_NM") == "") {
                        alert("가족관계코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return;
                    }

                    // 학력코드
                    if (dsT_ME_FAMILY.NameValue(i, "EDGR_CD") != "" &&
                        dsT_ME_FAMILY.NameValue(i, "EDGR_NM") == "") {
                        alert("학력코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_FAMILY.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }

                    if ( dsT_ME_FAMILY.RowStatus(i) == 1) {
                       document.getElementById("txtREL_CD").disabled = true;
                       document.getElementById("txtENO_NM").disabled = true;
                       document.getElementById("ImgRelCd").disabled  = true;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style 적용
            cfStyleGrid(form1.grdT_ME_FAMILY, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_FAMILY.IsUpdated)  {
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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                document.getElementById("txtREL_CD").disabled  = false;
                document.getElementById("txtREL_NM").disabled  = false;
                document.getElementById("txtENO_NM").disabled  = false;
                document.getElementById("txtBIR_YMD").disabled = false;
                document.getElementById("txtEDGR_CD").disabled = false;
                document.getElementById("txtEDGR_NM").disabled = false;
                document.getElementById("txtOCC_NAM").disabled = false;
                document.getElementById("txtJOB_CD").disabled  = false;

                document.getElementById("ImgRelCd").disabled   = false;
                document.getElementById("ImgBirYmd").disabled  = false;
                document.getElementById("ImgEdgrCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtREL_CD").disabled  = true;
                document.getElementById("txtREL_NM").disabled  = true;
                document.getElementById("txtENO_NM").disabled  = true;
                document.getElementById("txtBIR_YMD").disabled = true;
                document.getElementById("txtEDGR_CD").disabled = true;
                document.getElementById("txtEDGR_NM").disabled = true;
                document.getElementById("txtOCC_NAM").disabled = true;
                document.getElementById("txtJOB_CD").disabled  = true;

                document.getElementById("ImgRelCd").disabled   = true;
                document.getElementById("ImgBirYmd").disabled  = true;
                document.getElementById("ImgEdgrCd").disabled  = true;

            }
        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_FAMILY                       |
    | 3. Table List : T_ME_FAMILY                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_FAMILY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_FAMILY.CountRow);

            document.getElementById("txtREL_CD").disabled = true;
            document.getElementById("txtENO_NM").disabled = true;
            document.getElementById("ImgRelCd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_FAMILY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_FAMILY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[가족관계/가족성명] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("가족관계/가족성명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_FAMILY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_FAMILY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_FAMILY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_FAMILY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtREL_CD").disabled = false;
            document.getElementById("txtENO_NM").disabled = false;
            document.getElementById("ImgRelCd").disabled  = false;
        }
        else {
            document.getElementById("txtREL_CD").disabled = true;
            document.getElementById("txtENO_NM").disabled = true;
            document.getElementById("ImgRelCd").disabled  = true;

        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>가족사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">  <img src="/images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif"  name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">가족코드</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('G1', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','가족관계','G1')"></a>
                    </td>
                    <td align="center" maxlength="12" class="creamBold">성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">생년월일</td>
                    <td class="padding2423" >
                        <input id="txtBIR_YMD" style="width:75%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '생년월일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBirYmd" name="ImgBirYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtBIR_YMD','','415','53');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">학력코드</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');"> <input id="txtEDGR_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','학력구분','E1')"></a>
                    </td>
                    <td align="center" class="creamBold">근 무 처</td>
                    <td class="padding2423" >
                        <input id="txtOCC_NAM" maxlength="30" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_ME_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_FAMILY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='순번'         align=center </C>
                                <C> id=REL_CD          width=90   name='가족코드'     align=center </C>
                                <C> id=REL_NM          width=90   name='관계'                      </C>
                                <C> id=ENO_NM          width=90   name='성명'                      </C>
                                <C> id=BIR_YMD         width=90   name='생년월일'     align=center </C>
                                <C> id=EDGR_CD         width=90   name='학력코드'     align=center </C>
                                <C> id=EDGR_NM         width=90   name='학력'                      </C>
                                <C> id=OCC_NAM         width=90   name='근무처'                    </C>
                                <C> id=JOB_CD          width=90   name='직위'                      </C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 가족사항 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_FAMILY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=REL_CD        Ctrl=txtREL_CD       Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM       Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM       Param=value </C>
        <C> Col=BIR_YMD       Ctrl=txtBIR_YMD      Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD      Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM      Param=value </C>
        <C> Col=OCC_NAM       Ctrl=txtOCC_NAM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
    '>
</object>