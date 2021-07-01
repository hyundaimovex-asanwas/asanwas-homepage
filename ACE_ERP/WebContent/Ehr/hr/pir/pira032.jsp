<!--
    ************************************************************************************
    * @Source         : pira032.jsp                                                    *
    * @Description    : 사번생성 PAGE                                                  *
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
<title>사번생성</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        var GUBUN = '';
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira032.cmd.PIRA032CMD&S_MODE=SHR&GUBUN="+GUBUN;
            dsT_CM_PERSON.Reset();

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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

            dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("txtENO_NO1").value = '';
            document.getElementById("txtNO").value = '';
            document.getElementById("txtENO_NO").value = '';
            document.getElementById("txtMSG").value = '';

            document.getElementById("txtENO_NO1").focus();

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
            cfStyleGrid_New(form1.grdT_CM_PERSON, 0,"false","false");

            if (p_srcid == 'pira010') {
                // 정규사원
                GUBUN = '1';
            }
            else if (p_srcid == 'mema010') {
                // 파견사원
                GUBUN = '2';
            }

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

        /******************************
         * 사번생성 버튼 클릭시 처리  *
         ******************************/
        function fnc_CreateEnono() {
        	
            var NO1 = 0;

            if (document.getElementById("txtENO_NO1").value.length < 7) {
                alert("숫자를 7자리 입력하시기 바랍니다.\n\n아래 오른쪽 그리드에서 Double Click하세요");
                document.getElementById("txtENO_NO1").focus();
                return;
            }

            document.getElementById("txtNO").value = 1;
            document.getElementById("txtENO_NO").value = parseInt(document.getElementById("txtENO_NO1").value) + 1;

        }

        function fnc_CopyEnono() {
        	
            if(!confirm("현재 작업중이던 사원정보에 변경사항이 존재하더라도 저장되지 않고 신규 사원을 생성합니다.\n\n그래도 적용 하시겠습니까?")) return;

            parent.fnc_Clear();
            parent.fnc_AddNew();
            parent.document.getElementById("txtENO_NO").value = document.getElementById("txtENO_NO").value;
            
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
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 더블클릭시 해당 레코드의 사번생성내역을 보여줌   |
    +-------------------------------------------------->
    <Script For=grdT_CM_PERSON Event="OnDblClick(row,colid)">

        var ENO_NO = dsT_CM_PERSON.NameValue(row, "ENO_NO");
        document.getElementById("txtENO_NO1").value = ENO_NO.substr(0, 7);

        fnc_CreateEnono();

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


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
            <strong>사번생성</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="475">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse:collapse;height:230px;" bordercolor="#999999" class="table_cream">
                <tr>
                    <td class="padding2423">
                        <input id="txtENO_NO1" maxlength="7" size="8" style="ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();"> + <input id="txtNO" maxlength="1" size="2"  class="input_ReadOnly"  readonly> = <input id="txtENO_NO" maxlength="8" size="9"  class="input_ReadOnly"  readonly>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnonocreate','','../../images/button/btn_EnonocreateOver.gif',1)"><img src="../../images/button/btn_EnonocreateOn.gif"  name="imgAdd"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateEnono()"></a>
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEnonoapply','','../../images/button/btn_EnonoapplyOver.gif',1)"><img src="../../images/button/btn_EnonoapplyOn.gif"  name="imgAdd"    width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyEnono()"></a>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423">
                        <textarea id=txtMSG name=txtMSG rows="16" cols="78" class="input_ReadOnly"  readonly></textarea>
                    </td>
                </tr>
            </table>
        </td>
        <td width="515" >
            <!-- 조회 상태 테이블 시작 -->
            <table width="515" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="bottom" class="searchState">&nbsp;<span id="resultMessage">&nbsp;</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!-- 조회 상태 테이블 끝 -->

            <!-- 내용 조회 그리드 테이블 시작-->
            <table width="515" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop3" align="right">
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:510px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_PERSON">
                                        <param name="Format"                  value="
                                            <C> id=ENO_NO          width=90   name='사번'                  </C>
                                            <C> id=ENO_NM          width=90   name='성명'                  </C>
                                            <C> id=DPT_NM          width=100   name='부서'                  </C>
                                            <C> id=JOB_NM          width=100   name='직위'                  </C>
                                            <C> id=HIR_YMD         width=80   name='입사일'                </C>
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
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>
