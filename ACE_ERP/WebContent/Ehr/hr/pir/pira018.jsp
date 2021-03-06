<!--
    ************************************************************************************
    * @Source         : pira018.jsp                                                    *
    * @Description    : 가족사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>가족사항</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
    String Gubun = request.getParameter("GUBUN");
    String mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
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

            dsT_CM_FAMILY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_FAMILY.Reset();

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

                trT_CM_FAMILY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SAV";
                trT_CM_FAMILY.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            var row = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CM_FAMILY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_FAMILY.RowStatus(dsT_CM_FAMILY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_FAMILY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("가족[" + dsT_CM_FAMILY.NameValue(dsT_CM_FAMILY.RowPosition,"REL_NM") + "] [" + dsT_CM_FAMILY.NameValue(dsT_CM_FAMILY.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;

            dsT_CM_FAMILY.DeleteRow(dsT_CM_FAMILY.RowPosition);

            if (status != 1) {

                trT_CM_FAMILY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=DEL";
                trT_CM_FAMILY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_FAMILY.SetColumn(form1.grdT_CM_FAMILY.GetColumnID(0));
            form1.grdT_CM_FAMILY.Focus();

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
            if (dsT_CM_FAMILY.CountColumn == 0) {
                dsT_CM_FAMILY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REL_CD:STRING:KEYVALUETYPE, REL_NM:STRING, ENO_NM:STRING:KEYVALUETYPE,  BIR_YMD:STRING, EDGR_CD:STRING, EDGR_NM:STRING, OCC_NAM:STRING, JOB_CD:STRING,  DPD_TAG:STRING, HIU_TAG:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_FAMILY.AddRow();

            form1.grdT_CM_FAMILY.setColumn(form1.grdT_CM_FAMILY.getColumnID(0));

            //신규면 모든 필드 사용가능하게
            fnc_EnableElementAll(elementList);

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("cmbDPD_TAG").value = "O";
            document.getElementById("cmbHIU_TAG").value = "O";

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

   			dsT_CM_FAMILY.ClearData();
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
            if (!dsT_CM_FAMILY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_FAMILY.CountRow; i++ ) {
                if ( dsT_CM_FAMILY.RowStatus(i) == 1 ||
                     dsT_CM_FAMILY.RowStatus(i) == 3 ) {

                    // 가족관계
                    if( dsT_CM_FAMILY.NameValue(i, "REL_CD") == '' ) {
                        alert("가족관계는 필수 입력사항입니다.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return false;
                    }

                    // 성명
                    if( dsT_CM_FAMILY.NameValue(i, "ENO_NM") == '' ) {
                        alert("가족성명는 필수 입력사항입니다.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtENO_NM").focus();
                        return false;
                    }

                    // 가족관계
                    if (dsT_CM_FAMILY.NameValue(i, "REL_CD") != "" &&
                        dsT_CM_FAMILY.NameValue(i, "REL_NM") == "") {
                        alert("가족관계코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtREL_CD").focus();
                        return;
                    }

                    // 학력코드
                    if (dsT_CM_FAMILY.NameValue(i, "EDGR_CD") != "" &&
                        dsT_CM_FAMILY.NameValue(i, "EDGR_NM") == "") {
                        alert("학력코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_FAMILY.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

//개인정보 조회시 처리
<%
if(Gubun != null) {
    if(Gubun.equals("1") && mode.equals("read")){
%>
            document.getElementById("ImgRelCd").style.display = "none";
            document.getElementById("imgSearch").style.display = "none";
            document.getElementById("ImgEdgrCd").style.display = "none";
            document.getElementById("ImgAdd").style.display = "none";
            document.getElementById("imgSave").style.display = "none";
            document.getElementById("imgClear").style.display = "none";
            document.getElementById("imgDelete").style.display = "none";
<%
    }
}
%>

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_CM_FAMILY, 0,"false","false");

            //모든 필드 막기
            fnc_DisableElementAll(elementList);

            fnc_SearchList();
        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_PERSON.IsUpdated)  {
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

        var elementList = new Array(    "txtREL_CD"
                                       ,"txtENO_NM"
                                       ,"txtBIR_YMD"
                                       ,"txtEDGR_CD"
                                       ,"txtOCC_NAM"
                                       ,"txtJOB_CD"
                                       ,"cmbDPD_TAG"
                                       ,"cmbHIU_TAG"
                                       ,"ImgRelCd"
                                       ,"ImgBirYmd"
                                       ,"ImgEdgrCd"
                                    );

        var exceptionList = new Array(  "txtREL_CD"
                                       ,"txtENO_NM"
                                       ,"ImgRelCd"
                                      );

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
    | 2. 이름 : dsT_CM_FAMILY                       |
    | 3. Table List : T_CM_FAMILY                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_FAMILY                       |
    | 3. Table List : T_CM_FAMILY                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_FAMILY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_FAMILY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAMILY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //키 값을 제외한 나머지 필드 사용가능하게
            //fnc_EnableElementAll(elementList, exceptionList);

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_FAMILY.CountRow);
        }


    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_FAMILY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAMILY Event="OnDataError()">

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
    <script for=trT_CM_FAMILY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_FAMILY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_FAMILY Event="OnRowPosChanged(row)">
<%
    //개인정보 조회시 처리
    if(Gubun == null
            || (!Gubun.equals("1") && !mode.equals("read"))) {
%>
        var SysStatus = dsT_CM_FAMILY.SysStatus(row);

        //신규이면 모두 수정 가능하게
        if (SysStatus == 1) {
            fnc_EnableElementAll(elementList);
        } else {
            fnc_EnableElementAll(elementList, exceptionList);
        }
<%
    }
%>
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>가족사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">가족코드</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('G1', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','가족관계','G1')"></a>
                    </td>
                    <td align="center" maxlength="12" class="blueBold">성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
                    <td class="padding2423" >
                        <input id="txtENO_NM" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">생년월일</td>
                    <td class="padding2423" >
                        <input id="txtBIR_YMD" style="width:75%" maxlength="6">

                    </td>
                    <td align="center" class="blueBold">학력코드</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');"> <input id="txtEDGR_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','학력구분','E1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">근 무 처</td>
                    <td class="padding2423" >
                        <input id="txtOCC_NAM" maxlength="30" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">부양여부</td>
                    <td class="padding2423">
                        <select id="cmbDPD_TAG" style="width:100%" >
                            <option value="" ></option>
                            <option value="O" >부양</option>
                            <option value="X" >미부양</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">의보여부</td>
                    <td class="padding2423">
                        <select id="cmbHIU_TAG" style="width:100%" >
                            <option value="" ></option>
                            <option value="O" >부양</option>
                            <option value="X" >미부양</option>
                        </select>
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_FAMILY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center </C>
                                <C> id=REL_CD          width=80   name='가족코드'     align=center </C>
                                <C> id=REL_NM          width=80   name='관계'         align=center </C>
                                <C> id=ENO_NM          width=100   name='성명'         align=center </C>
                                <C> id=BIR_YMD         width=100  name='생년월일'     align=center mask='XX-XX-XX'</C>
                                <C> id=EDGR_NM         width=80   name='학력'                      </C>
                                <C> id=OCC_NAM         width=100   name='근무처'                    </C>
                                <C> id=JOB_CD          width=100   name='직위'                      </C>
                                <C> id=DPD_TAG1        width=100   name='부양여부'     align=center value={Decode(DPD_TAG,'O','부양','X','미부양','')} </C>
                                <C> id=HIU_TAG1        width=100   name='의보여부'     align=center value={Decode(HIU_TAG,'O','부양','X','미부양','')} </C>
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
    <Param Name="DataID",   Value="dsT_CM_FAMILY">
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
        <C> Col=DPD_TAG       Ctrl=cmbDPD_TAG      Param=value </C>
        <C> Col=HIU_TAG       Ctrl=cmbHIU_TAG      Param=value </C>
    '>
</object>