<!--
    ************************************************************************************
    * @Source         : pirc011.jsp                                                    *
    * @Description    : 기본정보 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사									 *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>기본정보</title>
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

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc011.cmd.PIRC011CMD&S_MODE=SHR&ENO_NO=<%=ENO_NO%>";
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

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc011.cmd.PIRC011CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

            } else {

                return;

            }

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

            fnc_SearchList();

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

            //DataSet의 변경 여부 확인
            if (!dsT_CM_PERSON.IsUpdated ) {
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            fnc_SearchList();


            document.getElementById("txtBCT_CD").className = "input_ReadOnly";
            document.getElementById("txtBCT_CD").readOnly     = true;
            document.getElementById("txtHF_NAM").className = "input_ReadOnly";
            document.getElementById("txtHF_NAM").readOnly     = true;
            document.getElementById("txtHFRE_CD").className = "input_ReadOnly";
            document.getElementById("txtHFRE_CD").readOnly     = true;
            document.getElementById("txtPER_ADR").className = "input_ReadOnly";
            document.getElementById("txtPER_ADR").readOnly     = true;
            document.getElementById("txtADDRESS").className = "input_ReadOnly";
            document.getElementById("txtADDRESS").readOnly     = true;
            document.getElementById("txtRADR").className = "input_ReadOnly";
            document.getElementById("txtRADR").readOnly     = true;
            document.getElementById("txtPHN_NO").className = "input_ReadOnly";
            document.getElementById("txtPHN_NO").readOnly     = true;
            document.getElementById("txtEM_PHN_NO").className = "input_ReadOnly";
            document.getElementById("txtEM_PHN_NO").readOnly     = true;
            document.getElementById("txtE_MAIL").className = "input_ReadOnly";
            document.getElementById("txtE_MAIL").readOnly     = true;

            document.getElementById("ImgBctCd").style.display = "none";
            document.getElementById("ImgHfreCd").style.display = "none";
            document.getElementById("ImgZipNo").style.display = "none";
            document.getElementById("ImgRziNo").style.display = "none";
            document.getElementById("ImgHfreCd").style.display = "none";
            document.getElementById("imgSave").style.display = "none";
            document.getElementById("imgClear").style.display = "none";

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/


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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

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

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->



<!-- form 시작 -->
<form name="form1">
<input type="hidden" id="ENO_NO">

<!-- 버튼 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>기본정보</strong>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="898" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="80"></col>
                    <col width="160"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">신상정보</td>
                    <td align="center" class="blueBold">출 신 도</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" maxlength="2"> <input id="txtBCT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">호&nbsp;&nbsp;&nbsp;&nbsp;주</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="blueBold">관&nbsp;&nbsp;&nbsp;&nbsp;계</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" maxlength="2"> <input id="txtHFRE_NM" style="width:60%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">본&nbsp;&nbsp;&nbsp;&nbsp;적</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:90%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">등본상주소</td>
                    <td align="center" class="blueBold">우편번호</td>
                    <td class="padding2423">
                        <input id="txtZIP_NO" size="7" maxlength="7" style="ime-mode:disabled" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423">
                        <input id="txtADR_CT" style="width:50%" class="input_ReadOnly" readonly> <input id="txtADDRESS" maxlength="50" style="width:45%"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">실거주지</td>
                    <td align="center" class="blueBold">우편번호</td>
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="50" style="width:45%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="150"></col>
                    <col width="70 "></col>
                    <col width="155"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >연락번호</td>
                    <td align="center" class="blueBold">전화번호</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:65%;ime-mode:disabled"  maxlength="10" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">휴 대 폰</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">E-mail</td>
                    <td class="padding2423">
                        <input id="txtE_MAIL" maxlength="30" style="width:90%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
        <C> Col=ZIP_NO        Ctrl=txtZIP_NO      Param=value </C>
        <C> Col=ADDRESS       Ctrl=txtADDRESS     Param=value </C>
        <C> Col=ADR_CT        Ctrl=txtADR_CT      Param=value </C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO      Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR        Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT     Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO      Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO   Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL      Param=value </C>
    '>
</object>