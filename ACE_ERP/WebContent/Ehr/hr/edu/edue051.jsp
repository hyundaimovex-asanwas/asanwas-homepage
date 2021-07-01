<!--
    ************************************************************************************
    * @Source         : edue051.jsp                                                    *
    * @Description    : 과정정보 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
     *-------------+-----------+--------------------------------------------------------+
    * 2016/05/20  |  정영식   | 소스이전                                               *                         *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>과정정보</title>
    <jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue051.cmd.EDUE051CMD&S_MODE=SHR&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no;
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

            //이곳에 해당 코딩을 입력 하세요

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

            document.getElementById("txtEDU_CD").innerText = opener.edu_cd;

            // 그리드에 개인별역량평가대상자설정 데이터 조회
            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_COURSELIST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

		// Link
		function fnc_SiteTag(){
			var siteTag = document.getElementById("txtSITE_TAG").value;
			if(siteTag == "" || siteTag == "등록 안됨"){
				return;
			}
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
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
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_COURSELIST)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

//            document.getElementById("txtENO_NO").innerText      = 'hlc'+dsT_ED_COURSELIST.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NM");
            document.getElementById("txtEDU_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_CD");
            document.getElementById("txtEDU_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_NM");
            document.getElementById("txtEDU_GBN_NM").innerText  = dsT_ED_COURSELIST.NameValue(1, "EDU_GBN_NM");
            document.getElementById("txtMNGER_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "MNGER_NM");
            document.getElementById("txtFIELD_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "FIELD_NM");
            document.getElementById("txtSHAPE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "SHAPE_NM");
            document.getElementById("txtGOAL_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "GOAL_TAG");
            document.getElementById("txtCONTENT_TXT").innerText = dsT_ED_COURSELIST.NameValue(1, "CONTENT_TXT");
            document.getElementById("txtEFFECT_TAG").innerText  = dsT_ED_COURSELIST.NameValue(1, "EFFECT_TAG");
            document.getElementById("txtOBJ_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "OBJ_TAG");
            document.getElementById("txtCPT_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_TAG");
            document.getElementById("txtINT_NAM").innerText     = dsT_ED_COURSELIST.NameValue(1, "INT_NAM");
            document.getElementById("txtFIX_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "FIX_NO");
            document.getElementById("txtDAY_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "DAY_NO");
            document.getElementById("txtTIME_NO").innerText     = dsT_ED_COURSELIST.NameValue(1, "TIME_NO");
            document.getElementById("txtCOST_AMT").innerText    = dsT_ED_COURSELIST.NameValue(1, "COST_AMT");
            document.getElementById("txtCOST_NM").innerText     = dsT_ED_COURSELIST.NameValue(1, "COST_NM");
            document.getElementById("txtINS_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "INS_NM");
            document.getElementById("txtRTN_AMT").innerText     = dsT_ED_COURSELIST.NameValue(1, "RTN_AMT");
            document.getElementById("txtPLACE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "PLACE_NM");
            document.getElementById("txtCPT_PNT").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_PNT");
            document.getElementById("txtSITE_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "SITE_TAG");
            document.getElementById("txtENT_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "ENT_TERM");
            document.getElementById("txtEDU_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "EDU_TERM");

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

        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        opener.fnc_SearchList();
        window.close();

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
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">과정정보</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->



<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">과정담당자</td>
                    <td class="padding2423" >
                        <span id="txtENO_NM" name="txtENO_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">과정코드</td>
                    <td class="padding2423" >
                        <span id="txtEDU_CD" name="txtEDU_CD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">과정명</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtEDU_NM" name="txtEDU_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육구분</td>
                    <td class="padding2423" >
                        <span id="txtEDU_GBN_NM" name="txtEDU_GBN_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육주관</td>
                    <td class="padding2423" >
                        <span id="txtMNGER_NM" name="txtMNGER_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육분야</td>
                    <td class="padding2423" >
                        <span id="txtFIELD_NM" name="txtFIELD_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육형태</td>
                    <td class="padding2423" >
                        <span id="txtSHAPE_NM" name="txtSHAPE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육목표</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtGOAL_TAG" name="txtGOAL_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">신청기간</td>
                    <td class="padding2423" >
                        <span id="txtENT_TERM" name="txtENT_TERM" ></span>
                    </td>
                    <td align="center" class="blueBold">교육기간</td>
                    <td class="padding2423" >
                        <span id="txtEDU_TERM" name="txtEDU_TERM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육내용</td>
                    <td class="padding2423" colspan="3" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="112" rows="10" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">기대효과</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtEFFECT_TAG" name="txtEFFECT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육대상</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtOBJ_TAG" name="txtOBJ_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">수료기준</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtCPT_TAG" name="txtCPT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육기관</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtINT_NAM" name="txtINT_NAM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육정원</td>
                    <td class="padding2423" >
                        <span id="txtFIX_NO" name="txtFIX_NO" ></span>&nbsp;명
                    </td>
                    <td align="center" class="blueBold">교육시간</td>
                    <td class="padding2423" >
                        <span id="txtTIME_NO" name="txtTIME_NO" ></span>&nbsp;시간
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">교육일수</td>
                    <td class="padding2423" >
                        <span id="txtDAY_NO" name="txtDAY_NO" ></span>&nbsp;일
                    </td>
                    <td align="center" class="blueBold">교육비용</td>
                    <td class="padding2423" >
                        <span id="txtCOST_AMT" name="txtCOST_AMT" ></span>&nbsp;원
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">비용부담</td>
                    <td class="padding2423" >
                        <span id="txtCOST_NM" name="txtCOST_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">고용보험</td>
                    <td class="padding2423" >
                        <span id="txtINS_NM" name="txtINS_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">환급금액</td>
                    <td class="padding2423" >
                        <span id="txtRTN_AMT" name="txtRTN_AMT" ></span>&nbsp;원
                    </td>
                    <td align="center" class="blueBold">교육장소</td>
                    <td class="padding2423" >
                        <span id="txtPLACE_NM" name="txtPLACE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">이수점수</td>
                    <td class="padding2423" >
                        <span id="txtCPT_PNT" name="txtCPT_PNT" ></span>&nbsp;점
                    </td>
                    <td align="center" class="blueBold">참고사이트</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="28" maxlength="300" >&nbsp;<input type="button" value="연결" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>