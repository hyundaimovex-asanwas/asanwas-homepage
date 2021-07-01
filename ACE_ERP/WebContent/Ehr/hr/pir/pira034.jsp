<!--
    ************************************************************************************
    * @Source         : pira034.jsp                                                    *
    * @Description    : 사회공헌 PAGE                                                  *
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
<title>사회공헌</title>
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

            dsT_CM_SERVICE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_SERVICE.Reset();

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

                trT_CM_SERVICE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=SAV";
                trT_CM_SERVICE.post();

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
            if (dsT_CM_SERVICE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_SERVICE.RowStatus(dsT_CM_SERVICE.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_SERVICE.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("일자[" + dsT_CM_SERVICE.NameValue(dsT_CM_SERVICE.RowPosition,"STR_YMD") + "] 행사내용[" + dsT_CM_SERVICE.NameValue(dsT_CM_SERVICE.RowPosition,"ATT_SBJ") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_SERVICE.DeleteRow(dsT_CM_SERVICE.RowPosition);

            if (status != 1) {
                trT_CM_SERVICE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=DEL";
                trT_CM_SERVICE.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_SERVICE.SetColumn(form1.grdT_CM_SERVICE.GetColumnID(0));
            form1.grdT_CM_SERVICE.Focus();

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
            if (dsT_CM_SERVICE.CountColumn == 0) {
                dsT_CM_SERVICE.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, ATT_OFFICE:STRING, ATT_SBJ:STRING,  ATT_HOUR:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_SERVICE.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_SERVICE.setColumn(form1.grdT_CM_SERVICE.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

            document.getElementById("txtSTR_YMD").focus();
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

            dsT_CM_SERVICE.ClearData();
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
            if (!dsT_CM_SERVICE.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_SERVICE.CountRow; i++ ) {
                if ( dsT_CM_SERVICE.RowStatus(i) == 1 ||
                     dsT_CM_SERVICE.RowStatus(i) == 3 ) {


                    // 일자
                    if( dsT_CM_SERVICE.NameValue(i, "STR_YMD") == '' ) {
                        alert("일자는 필수 입력사항입니다.");
                        dsT_CM_SERVICE.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_SERVICE.NameValue(i, "STR_YMD"), "일자") && dsT_CM_SERVICE.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_SERVICE.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }


                    if ( dsT_CM_SERVICE.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = true;
                       document.getElementById("ImgStrYmd").disabled  = true;


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
            cfStyleGrid_New(form1.grdT_CM_SERVICE, 0,"false","false");

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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtATT_OFFICE").disabled  = false;
                document.getElementById("txtATT_SBJ").disabled = false;
                document.getElementById("txtATT_HOUR").disabled = false;

                document.getElementById("ImgStrYmd").disabled  = false;


            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtATT_OFFICE").disabled  = true;
                document.getElementById("txtATT_SBJ").disabled = true;
                document.getElementById("txtATT_HOUR").disabled = true;

                document.getElementById("ImgStrYmd").disabled  = true;


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
    | 2. 이름 : dsT_CM_SERVICE                      |
    | 3. Table List : T_CM_SERVICE                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_SERVICE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_SERVICE                      |
    | 3. Table List : T_CM_SERVICE                  |
    +----------------------------------------------->
    <Object ID ="trT_CM_SERVICE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_SERVICE)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_SERVICE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_SERVICE.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_SERVICE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_SERVICE Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목 [일자/주관] 내용 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("[일자/주관] 내용에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_SERVICE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_SERVICE event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_SERVICE Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_SERVICE.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;



        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;


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
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>사회공헌</strong>
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
                    <col width="120"></col>
                    <col width="70 "></col>
                    <col width="120"></col>
                    <col width="70 "></col>
                    <col width="200"></col>
                    <col width="70 "></col>

                </colgroup>
                <tr>
                    <td align="center" class="blueBold">일 자</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','70','52');"></a>
                    </td>
                    <td align="center" class="blueBold">행사장소</td>
                    <td class="padding2423" >
                        <input id="txtATT_OFFICE" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">행사내용</td>
                    <td class="padding2423" >
                        <input id="txtATT_SBJ" maxlength="30" style="width:98%">
                    </td>
                    <td align="center" class="blueBold">시 간</td>
                    <td class="padding2423" >
                        <input id="txtATT_HOUR" maxlength="4" style="width:100%">
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
                        <object id="grdT_CM_SERVICE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_SERVICE">
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='순번'         align=center  </C>
                                <C> id=STR_YMD         width=100   name='일 자'        align=center  </C>
                                <C> id=ATT_OFFICE      width=200  name='행사장소'                   </C>
                                <C> id=ATT_SBJ         width=550  name='행사내용'                   </C>
                                <C> id=ATT_HOUR        width=70   name='시간'         align=center  </C>
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
<!-- 사회공헌 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_SERVICE">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=ATT_OFFICE    Ctrl=txtATT_OFFICE   Param=value </C>
        <C> Col=ATT_SBJ       Ctrl=txtATT_SBJ      Param=value </C>
        <C> Col=ATT_HOUR      Ctrl=txtATT_HOUR     Param=value </C>
    '>
</object>