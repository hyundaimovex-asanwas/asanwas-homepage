<!--
    ************************************************************************************
    * @Source         : pira015.jsp                                                    		*
    * @Description    : 인사기본5 PAGE                                                 		*
    * @Developer Desc :                                                                		*
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
<title>인사기본5</title>
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

            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira015.cmd.PIRA015CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
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

            //DataSet의 변경 여부 확인
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira015.cmd.PIRA015CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

            } else {

                return false;

            }

            return true;

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

            // 취득사유
            if (document.getElementById("txtGET_RSN").value != "" && document.getElementById("txtGET_NM").value == "") {
            	
                alert("취득사유코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                
                document.getElementById("txtGET_RSN").focus();
                
                return false;
                
            }

            // 채용경로
            if (document.getElementById("txtHIR_PATH").value != "" && document.getElementById("txtHIR_NM").value == "") {
            	
                alert("채용경로코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                
                document.getElementById("txtHIR_PATH").focus();
                
                return false;
                
            }

            // 산재경력일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSAN_YMD"), "일자") && document.getElementById("txtSAN_YMD").value != "") {
            	
                document.getElementById("txtSAN_YMD").focus();
                
                return false;
                
            }


            // 장애유형
            if (document.getElementById("txtHDC_CD").value != "" && document.getElementById("txtHDC_NM").value == "") {
            	
                alert("장애유형코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                
                document.getElementById("txtHDC_CD").focus();
                
                return false;
                
            }

            // 장애등급
            if (document.getElementById("txtHDC_GRA").value != "" && document.getElementById("txtHDC_GNM").value == "") {
            	
                alert("장애등급코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                
                document.getElementById("txtHDC_GRA").focus();
                
                return false;
                
            }

            if (document.getElementById("txtMPVA_CD").value != "" && document.getElementById("txtMPVA_NM").value == "") {
            	
                alert("채용구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                
                document.getElementById("txtMPVA_CD").focus();
                
                return false;
                
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

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

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtGET_RSN").disabled  = false;
                document.getElementById("txtHIR_PATH").disabled = false;
                document.getElementById("txtSAN_YMD").disabled  = false;
                document.getElementById("txtSAN_NAM").disabled  = false;
                document.getElementById("txtHDC_CD").disabled   = false;
                document.getElementById("txtHDC_GRA").disabled  = false;
                document.getElementById("txtSAN_HIS").disabled  = false;
                document.getElementById("txtSAN_REM").disabled  = false;
                document.getElementById("txtJAN_YMD").disabled  = false;
                document.getElementById("txtJHDC_CD").disabled  = false;
                document.getElementById("txtJHDC_NM").disabled  = false;
                document.getElementById("txtJHDC_GRA").disabled = false;
                document.getElementById("txtJHDC_GNM").disabled = false;
                document.getElementById("txtSER_STS").disabled  = false;
                document.getElementById("txtSER_SNM").disabled  = false;
                document.getElementById("txtJOB_OCC").disabled  = false;
                document.getElementById("txtJOB_ONM").disabled  = false;
                document.getElementById("txtMPVA_CD").disabled  = false;
                document.getElementById("txtMPVA_NM").disabled  = false;

                document.getElementById("ImgGetRsn").disabled   = false;
                document.getElementById("ImgHirPath").disabled  = false;
                document.getElementById("ImgSanYmd").disabled   = false;
                document.getElementById("ImgHdcCd").disabled    = false;
                document.getElementById("ImgHdcGra").disabled   = false;
                document.getElementById("ImgJanYmd").disabled   = false;
                document.getElementById("ImgTrgCd").disabled    = false;
                document.getElementById("ImgJHdcCd").disabled   = false;
                document.getElementById("ImgJHdcGra").disabled  = false;
                document.getElementById("ImgSerSts").disabled   = false;
                document.getElementById("ImgJobOcc").disabled   = false;
                document.getElementById("ImgMpvaCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtGET_RSN").disabled  = true;
                document.getElementById("txtHIR_PATH").disabled = true;
                document.getElementById("txtSAN_YMD").disabled  = true;
                document.getElementById("txtSAN_NAM").disabled  = true;
                document.getElementById("txtHDC_CD").disabled   = true;
                document.getElementById("txtHDC_GRA").disabled  = true;
                document.getElementById("txtSAN_HIS").disabled  = true;
                document.getElementById("txtSAN_REM").disabled  = true;
                document.getElementById("txtJAN_YMD").disabled  = true;
                document.getElementById("txtJHDC_CD").disabled  = true;
                document.getElementById("txtJHDC_NM").disabled  = true;
                document.getElementById("txtJHDC_GRA").disabled = true;
                document.getElementById("txtJHDC_GNM").disabled = true;
                document.getElementById("txtSER_STS").disabled  = true;
                document.getElementById("txtSER_SNM").disabled  = true;
                document.getElementById("txtJOB_OCC").disabled  = true;
                document.getElementById("txtJOB_ONM").disabled  = true;
                document.getElementById("txtMPVA_CD").disabled  = true;
                document.getElementById("txtMPVA_NM").disabled  = true;

                document.getElementById("ImgGetRsn").disabled   = true;
                document.getElementById("ImgHirPath").disabled  = true;
                document.getElementById("ImgSanYmd").disabled   = true;
                document.getElementById("ImgHdcCd").disabled    = true;
                document.getElementById("ImgHdcGra").disabled   = true;
                document.getElementById("ImgJanYmd").disabled   = true;
                document.getElementById("ImgTrgCd").disabled    = true;
                document.getElementById("ImgJHdcCd").disabled   = true;
                document.getElementById("ImgJHdcGra").disabled  = true;
                document.getElementById("ImgSerSts").disabled   = true;
                document.getElementById("ImgJobOcc").disabled   = true;
                document.getElementById("ImgMpvaCd").disabled   = true;

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

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

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

          if (parent.savflag != '1') {
        	  
              parent.savflag = 1;
              
          }

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

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>인사기본5</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60 "></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">고용보험</td>
                    <td align="center" class="blueBold">취득사유</td>
                    <td class="padding2423">
                        <input id="txtGET_RSN" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C4', 'txtGET_RSN','txtGET_NM');"> <input id="txtGET_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGetRsn','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGetRsn" name="ImgGetRsn" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtGET_RSN','txtGET_NM','취득사유','C4')"></a>
                    </td>
                    <td align="center" class="blueBold">채용경로</td>
                    <td class="padding2423">
                        <input id="txtHIR_PATH" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C5', 'txtHIR_PATH','txtHIR_NM');"> <input id="txtHIR_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirPath','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHirPath" name="ImgHirPath" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtHIR_PATH','txtHIR_NM','채용경로','C5')"></a>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">산재경력</td>
                    <td align="center" class="blueBold">일&nbsp;&nbsp;&nbsp;&nbsp;자</td>
                    <td class="padding2423">
                        <input id="txtSAN_YMD" style="width:65%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSanYmd" name="ImgSanYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtSAN_YMD','','155','80');"></a>
                    </td>
                    <td align="center" class="blueBold">상 병 명</td>
                    <td class="padding2423">
                        <input id="txtSAN_NAM" style="width:100%" maxlength="30">
                    </td>
                    <td align="center" class="blueBold">장애유형</td>
                    <td class="padding2423">
                        <input id="txtHDC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C6', 'txtHDC_CD','txtHDC_NM');"> <input id="txtHDC_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHdcCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHdcCd" name="ImgHdcCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtHDC_CD','txtHDC_NM','장애유형','C6')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">장애등급</td>
                    <td class="padding2423">
                        <input id="txtHDC_GRA" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C7', 'txtHDC_GRA','txtHDC_GNM');"> <input id="txtHDC_GNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHdcGra','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHdcGra" name="ImgHdcGra" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHDC_GRA','txtHDC_GNM','장애등급','C7')"></a>
                    </td>
                    <td align="center" class="blueBold">과거병력</td>
                    <td class="padding2423" >
                        <input id="txtSAN_HIS" style="width:100%" maxlength="30">
                    </td>
                    <td align="center" class="blueBold">발생사유</td>
                    <td class="padding2423" >
                        <input id="txtSAN_REM" style="width:100%" maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">장애사항</td>
                    <td align="center" class="blueBold">인정일자</td>
                    <td class="padding2423">
                        <input id="txtJAN_YMD" style="width:65%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJanYmd" name="ImgJanYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtJAN_YMD','','155','80');"></a>
                    </td>
                    <td align="center" class="blueBold">인정구분</td>
                    <td class="padding2423">
                        <input id="txtTRG_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SA', 'txtTRG_CD','txtTRG_NM');"> <input id="txtTRG_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTrgCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgTrgCd" name="ImgTrgCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtTRG_CD','txtTRG_NM','장애인정구분','SA')"></a>
                    </td>
                    <td align="center" class="blueBold">장애유형</td>
                    <td class="padding2423">
                        <input id="txtJHDC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SB', 'txtJHDC_CD','txtJHDC_NM');"> <input id="txtJHDC_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJHdcCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJHdcCd" name="ImgJHdcCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtJHDC_CD','txtJHDC_NM','장애유형','SB')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">장애등급</td>
                    <td class="padding2423">
                        <input id="txtJHDC_GRA" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SE', 'txtJHDC_GRA','txtJHDC_GNM');"> <input id="txtJHDC_GNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJHdcGra','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJHdcGra" name="ImgJHdcGra" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJHDC_GRA','txtJHDC_GNM','장애등급','SE')"></a>
                    </td>
                    <td align="center" class="blueBold">중증여부</td>
                    <td class="padding2423">
                        <input id="txtSER_STS" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SC', 'txtSER_STS','txtSER_SNM');"> <input id="txtSER_SNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSerSts','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSerSts" name="ImgSerSts" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSER_STS','txtSER_SNM','중증여부','SC')"></a>
                    </td>
                    <td align="center" class="blueBold">근로직종</td>
                    <td class="padding2423">
                        <input id="txtJOB_OCC" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SD', 'txtJOB_OCC','txtJOB_ONM');"> <input id="txtJOB_ONM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobOcc','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJobOcc" name="ImgJobOcc" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_OCC','txtJOB_ONM','근로직종','SD')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">보훈사항</td>
                    <td align="center" class="blueBold">채용구분</td>
                    <td class="padding2423">
                        <input id="txtMPVA_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SH', 'txtMPVA_CD','txtMPVA_NM');"> <input id="txtMPVA_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMpvaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMpvaCd" name="imgMpvaCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtMPVA_CD','txtMPVA_NM','채용구분','SH')"></a>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="3">사내활동</td>
                    <td align="center" class="blueBold">사내활동1</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD1" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD1','txtCLU_NM1');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM1" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">사내활동2</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD2" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD2','txtCLU_NM2');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM2" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">사내활동3</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD3" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD3','txtCLU_NM3');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM3" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">사내활동4</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD4" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD4','txtCLU_NM4');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM4" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">사내활동5</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD5" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD5','txtCLU_NM5');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM5" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">사내활동6</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD6" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD6','txtCLU_NM6');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM6" style="width:75%" class="input_ReadOnly"  readonly>
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
        <C> Col=ENO_NO        Ctrl=ENO_NO          Param=value Disable=disabled</C>
        <C> Col=GET_RSN       Ctrl=txtGET_RSN      Param=value </C>
        <C> Col=GET_NM        Ctrl=txtGET_NM       Param=value </C>
        <C> Col=HIR_PATH      Ctrl=txtHIR_PATH     Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM       Param=value </C>
        <C> Col=SAN_YMD       Ctrl=txtSAN_YMD      Param=value </C>
        <C> Col=SAN_NAM       Ctrl=txtSAN_NAM      Param=value </C>
        <C> Col=HDC_CD        Ctrl=txtHDC_CD       Param=value </C>
        <C> Col=HDC_NM        Ctrl=txtHDC_NM       Param=value </C>
        <C> Col=HDC_GRA       Ctrl=txtHDC_GRA      Param=value </C>
        <C> Col=HDC_GNM       Ctrl=txtHDC_GNM      Param=value </C>
        <C> Col=SAN_HIS       Ctrl=txtSAN_HIS      Param=value </C>
        <C> Col=SAN_REM       Ctrl=txtSAN_REM      Param=value </C>
        <C> Col=JAN_YMD       Ctrl=txtJAN_YMD      Param=value </C>
        <C> Col=TRG_CD        Ctrl=txtTRG_CD       Param=value </C>
        <C> Col=TRG_NM        Ctrl=txtTRG_NM       Param=value </C>
        <C> Col=JHDC_CD       Ctrl=txtJHDC_CD      Param=value </C>
        <C> Col=JHDC_NM       Ctrl=txtJHDC_NM      Param=value </C>
        <C> Col=JHDC_GRA      Ctrl=txtJHDC_GRA     Param=value </C>
        <C> Col=JHDC_GNM      Ctrl=txtJHDC_GNM     Param=value </C>
        <C> Col=SER_STS       Ctrl=txtSER_STS      Param=value </C>
        <C> Col=SER_SNM       Ctrl=txtSER_SNM      Param=value </C>
        <C> Col=JOB_OCC       Ctrl=txtJOB_OCC      Param=value </C>
        <C> Col=JOB_ONM       Ctrl=txtJOB_ONM      Param=value </C>
        <C> Col=MPVA_CD       Ctrl=txtMPVA_CD      Param=value </C>
        <C> Col=MPVA_NM       Ctrl=txtMPVA_NM      Param=value </C>
        <C> Col=CLU_CD1       Ctrl=txtCLU_CD1      Param=value </C>
        <C> Col=CLU_NM1       Ctrl=txtCLU_NM1      Param=value </C>
        <C> Col=CLU_CD2       Ctrl=txtCLU_CD2      Param=value </C>
        <C> Col=CLU_NM2       Ctrl=txtCLU_NM2      Param=value </C>
        <C> Col=CLU_CD3       Ctrl=txtCLU_CD3      Param=value </C>
        <C> Col=CLU_NM3       Ctrl=txtCLU_NM3      Param=value </C>
        <C> Col=CLU_CD4       Ctrl=txtCLU_CD4      Param=value </C>
        <C> Col=CLU_NM4       Ctrl=txtCLU_NM4      Param=value </C>
        <C> Col=CLU_CD5       Ctrl=txtCLU_CD5      Param=value </C>
        <C> Col=CLU_NM5       Ctrl=txtCLU_NM5      Param=value </C>
        <C> Col=CLU_CD6       Ctrl=txtCLU_CD6      Param=value </C>
        <C> Col=CLU_NM6       Ctrl=txtCLU_NM6      Param=value </C>
    '>
</object>