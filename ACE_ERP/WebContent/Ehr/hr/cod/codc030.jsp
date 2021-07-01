<!--
*****************************************************
* @source       : codc030.jsp
* @description : 업무별권한관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/03      한학현        최초작성.(수정시 반드시 근태관리의 부서별담당자등록같이 수정)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String LAW_AUTHO    = box.getString("SESSION_LAW_AUTHO");
    String ROLE_CD      = box.getString("SESSION_ROLE_CD");
%>

<html>
<head>
<title>업무별권한관리</title>
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

		var btnList = 'TFTTFFFT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

<%
    //아무런 권한이 없으면 조회할 수 없다.
    if(!ROLE_CD.equals("1001")
            && !ROLE_CD.equals("1002")
            && !LAW_AUTHO.equals("M")) {
%>
            alert("조회 할 수 있는 권한이 없습니다.");
            return;
<%
    } else {
%>

			//검색조건 3가지
			var service = document.form1.cmbSERVICE_SHR.value;		//사번
			var eno_no = document.form1.txtENO_NO_SHR.value;		//사번
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;		//소속
			var autho = document.form1.cmbAUTHO_SHR.value;	//평가그룹

			//역량 평가 적용 결과 정보 조회
			dsT_CM_EMPLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc030.cmd.CODC030CMD&S_MODE=SHR&SERVICE="+service+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&AUTHO="+autho;
			dsT_CM_EMPLIST.reset();
<%
    }
%>
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

			if(!fnc_SaveItemCheck()) return;

			var service = document.form1.cmbSERVICE_SHR.value;		//사번

			trT_CM_EMPLIST.KeyValue = "tr01(I:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
			trT_CM_EMPLIST.action = "/servlet/GauceChannelSVL?cmd=hr.cod.c.codc030.cmd.CODC030CMD&S_MODE=SAV&SERVICE="+service;
			trT_CM_EMPLIST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

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

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

			document.getElementById("cmbSERVICE_SHR").selectedIndex = 0;
			document.getElementById("txtENO_NO_SHR").value = '';
			document.getElementById("txtENO_NM_SHR").value = '';
			document.getElementById("txtDPT_CD_SHR").value = '';
			document.getElementById("txtDPT_NM_SHR").value = '';
			document.getElementById("cmbAUTHO_SHR").value = '';

			document.getElementById("resultMessage").innerText = ' ';
			dsT_CM_EMPLIST.ClearAll();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CM_EMPLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CM_EMPLIST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_CM_EMPLIST,15,"false","false")      // Grid Style 적용

			document.form1.txtENO_NO_SHR.focus();

            //Role 코드를 설정시킨다.
            var oSelect = document.getElementById("cmbROLE_CD");
            var oOption = null;
            for(var i = 1; i <= dsT_CM_COMMON_RL.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_RL.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_RL.NameValue(i,"CODE_NAME");

                if(oOption.value < "2100")
                    oSelect.add(oOption);
            }


            //Service 코드를 설정시킨다.
            oSelect = document.getElementById("cmbSERVICE_SHR");
            for(var i = 0; i < serviceCdList.length; i++ ) {
<%
    //법무권한 마스터일 경우 업무 를 법무로 고정시킴 (Role 권한이 있을 경우 Role 권한이 우선함 )
    if(!(ROLE_CD.equals("1001") || ROLE_CD.equals("1002")) && LAW_AUTHO.equals("M")) {
%>
                if(serviceCdList[i] != "LAW")
                    continue;
<%
    }
%>
                oOption       = document.createElement("OPTION");
                oOption.value = serviceCdList[i];
                oOption.text  = serviceNmList[i];

                oSelect.add(oOption);
            }

            fnc_ChangeStateElement(false, "cmbAUTHO_SHR");
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * 업무가 전체일때는 권한에는 상관없이 조회시킴
         */
        function fnc_checkAuthoType() {
            var oSERVICE_SHR = document.getElementById("cmbSERVICE_SHR");
            var oAUTHO_SHR = document.getElementById("cmbAUTHO_SHR");
            var oOption = null;

            if(oSERVICE_SHR.value == "") {
                oAUTHO_SHR.selectedIndex = 0;
                fnc_ChangeStateElement(false, "cmbAUTHO_SHR");
            } else {
                fnc_ChangeStateElement(true, "cmbAUTHO_SHR");
            }
        }


        //서비스 코드
        var serviceCdList = new Array(   "LAW"
                                        ,"EDU"
                                        ,"PLN"
                                        ,"SEL"
                                        ,"EIS"
                                        ,"CON"
                                        ,"YAC"
                                        ,"L3" );
        //서비스 이름
        var serviceNmList = new Array(   "법무"
                                        ,"교육"
                                        ,"사업계획"
                                        ,"셀프서비스"
                                        ,"EIS"
                                        ,"콘도"
                                        ,"연말정산"
                                        ,"사업본부장" );

        //입력창 리스트
        var elementList = new Array( "cmbLAW_AUTHO"
                                    ,"cmbEDU_AUTHO"
                                    ,"cmbPLN_AUTHO"
                                    ,"cmbSEL_AUTHO"
                                    ,"cmbEIS_AUTHO"
                                    ,"cmbCON_AUTHO"
                                    ,"cmbYAC_AUTHO"
                                    ,"cmbL3_AUTHO"
                                    ,"cmbROLE_CD"   );

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_EMPLIST                      |
    | 3. Table List : T_CM_EMPLIST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_RL"/>
       <jsp:param name="CODE_GUBUN"    value="RL"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_CM_EMPLIST)		|
    | 3. 사용되는 Table List(T_CM_EMPLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtENO_NO_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_CM_EMPLIST.focus();

            fnc_EnableElementAll(elementList);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">
        cfErrorMsg(this);
    </script>





    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_CM_EMPLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
<%
    //전체 관리자인 경우 모든 메뉴를 수정 및 사용이 가능하게 한다.
    if(ROLE_CD.equals("1001")
            || ROLE_CD.equals("1002")) {
%>
            fnc_EnableElementAll(elementList);
<%
    }
    //법무 마스터일 경우 법무 권한만 수정이 가능하게 풀어준다.
    else if(LAW_AUTHO.equals("M")) {
%>
            fnc_ChangeStateElement(true, "cmbLAW_AUTHO");
<%
    }
%>

            //조회한 ROW가 법무 마스터인경우 수정못하게 막는다.
            if(dsT_CM_EMPLIST.NameString(row, "LAW_AUTHO") == "M")
                fnc_ChangeStateElement(false, "cmbLAW_AUTHO");
        }
    </script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">업무별권한관리</td>
					<td align="right" class="navigator">HOME/기초정보/권한관리/<font color="#000000">업무별권한관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="40"></col>
                                <col width="170"></col>
                                <col width="50"></col>
                                <col width="180"></col>
                                <col width="50"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">업무&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbSERVICE_SHR" name="cmbSERVICE_SHR" style="WIDTH: 85%" onChange="fnc_checkAuthoType();fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
										<option value="">전 체</option>
                                    </select>
								</td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="right" class="searchState">소속&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">권한&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbAUTHO_SHR" name="cmbAUTHO_SHR" style="WIDTH: 85%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
										<option value=''>전 체</option>
										<option value='N'>없음</option>
										<option value='S'>해당소속</option>
										<option value='A'>모든소속</option>
                                        <option value='M'>MASTER</option>
                                    </select>
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


<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width="90"></col>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
				<tr>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input type="hidden" id=txtDPT_CD name=txtDPT_CD>
                        <input id=txtDPT_NM name=txtDPT_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">직위</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">사번</td>
                    <td class="padding2423">
                        <input id=txtENO_NO name=txtENO_NO style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">성명</td>
                    <td class="padding2423">
                        <input id=txtENO_NM name=txtENO_NM style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">법무권한</td>
                    <td class="padding2423">
						<select id="cmbLAW_AUTHO" name="cmbLAW_AUTHO" style="width:90px">
							<option value=''>없음</option>
							<option value='S'>해당소속</option>
							<option value='A'>모든소속</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">교육권한</td>
                    <td class="padding2423">
						<select id="cmbEDU_AUTHO" name="cmbEDU_AUTHO" style="width:90px">
							<option value=''>없음</option>
							<option value='S'>해당소속</option>
							<option value='A'>모든소속</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">사업계획권한</td>
                    <td class="padding2423">
						<select id="cmbPLN_AUTHO" name="cmbPLN_AUTHO" style="width:90px">
							<option value=''>없음</option>
							<option value='S'>해당소속</option>
							<option value='A'>모든소속</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">셀프서비스권한</td>
                    <td class="padding2423">
						<select id="cmbSEL_AUTHO" name="cmbSEL_AUTHO" style="width:90px">
							<option value=''>없음</option>
							<option value='S'>해당소속</option>
							<option value='A'>모든소속</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">EIS권한</td>
                    <td class="padding2423">
						<select id="cmbEIS_AUTHO" name="cmbEIS_AUTHO" style="width:90px">
							<option value=''>없음</option>
							<option value='M'>권한주기</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">콘도권한</td>
                    <td class="padding2423">
                        <select id="cmbCON_AUTHO" name="cmbCON_AUTHO" style="width:90px">
                            <option value=''>없음</option>
                            <option value='M'>권한주기</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">연말정산권한</td>
                    <td class="padding2423">
                        <select id="cmbYAC_AUTHO" name="cmbYAC_AUTHO" style="width:90px">
                            <option value=''>없음</option>
                            <option value='M'>권한주기</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">본부/부서장권한</td>
                    <td class="padding2423">
                        <select id="cmbL3_AUTHO" name="cmbLAW_AUTHO" style="width:90px">
                            <option value=''>없음</option>
                            <option value='M'>본부장 권한</option>
                            <option value='A'>부서장 권한</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">ROLE권한</td>
                    <td class="padding2423" colspan="7">
						<select id="cmbROLE_CD" name="cmbROLE_CD" style="width:90px">
							<option value=''>없음</option>
                        </select>
                    </td>
                </tr>
            </table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object	id="grdT_CM_EMPLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
							<param name="DataID"				value="dsT_CM_EMPLIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<FC> id={currow}		width=29		name='NO'		        align=center					    </FC>
                                <FC> id='DPT_NM'        width=90        name='소속'             align=center        Edit=None       </FC>
                                <FC> id='JOB_NM'        width=50        name='직위'             align=center        Edit=None       </FC>
                                <FC> id='ENO_NO'        width=70        name='사번'             align=center        Edit=None       </FC>
                                <FC> id='ENO_NM'        width=70        name='성명'             align=center        Edit=None       </FC>
                                <C>  id='LAW_AUTHO'      width=68        name='법무'             align=center        Edit=none       Value={Decode(LAW_AUTHO, 'S', '해당소속', 'A', '모든소속', 'M', 'MASTER')} </C>
<%
    if(ROLE_CD.equals("1001")){
%>
                                <C> id='EDU_AUTHO'      width=68        name='교육'             align=center        Edit=none       Value={Decode(EDU_AUTHO, 'S', '해당소속', 'A', '모든소속')}                </C>
                                <C> id='PLN_AUTHO'      width=68        name='사업계획'         align=center        Edit=none       Value={Decode(PLN_AUTHO, 'S', '해당소속', 'A', '모든소속')}                </C>
                                <C> id='SEL_AUTHO'      width=68        name='셀프서비스'       align=center        Edit=none       Value={Decode(SEL_AUTHO, 'S', '해당소속', 'A', '모든소속')}                </C>
                                <C> id='EIS_AUTHO'      width=68        name='EIS'              align=center        Edit=none       Value={Decode(EIS_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='CON_AUTHO'      width=68        name='콘도'             align=center        Edit=none       Value={Decode(CON_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='YAC_AUTHO'      width=68        name='연말정산'         align=center        Edit=none       Value={Decode(YAC_AUTHO, 'M', 'MASTER')}                                   </C>
                                <C> id='L3_AUTHO'       width=68        name='사업본부장'       align=center        Edit=none       Value={Decode(L3_AUTHO,  'M', '본부장 권한', 'A', '부서장 권한')}                </C>
                                <C> id='ROLE_CD'        width=68        name='ROLE'             align=center        Edit=none       EditStyle=Lookup   Data='dsT_CM_COMMON_RL:CODE:CODE_NAME'                  </C>
<% } %>

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
<!-- -->
<object id="bndT_CM_EMPLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_EMPLIST">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO      	    Ctrl=txtENO_NO      	Param=value  Disable=disabled</C>
		<C>Col=ENO_NM		    Ctrl=txtENO_NM	      	Param=value</C>
		<C>Col=DPT_NM    	    Ctrl=txtDPT_NM      	Param=value</C>
		<C>Col=JOB_NM		    Ctrl=txtJOB_NM      	Param=value</C>
        <C>Col=LAW_AUTHO        Ctrl=cmbLAW_AUTHO       Param=value</C>
        <C>Col=DOC_AUTHO        Ctrl=cmbDOC_AUTHO       Param=value</C>
        <C>Col=EDU_AUTHO        Ctrl=cmbEDU_AUTHO       Param=value</C>
        <C>Col=PLN_AUTHO        Ctrl=cmbPLN_AUTHO       Param=value</C>
        <C>Col=SEL_AUTHO        Ctrl=cmbSEL_AUTHO       Param=value</C>
        <C>Col=EIS_AUTHO        Ctrl=cmbEIS_AUTHO       Param=value</C>
        <C>Col=CON_AUTHO        Ctrl=cmbCON_AUTHO       Param=value</C>
        <C>Col=YAC_AUTHO        Ctrl=cmbYAC_AUTHO       Param=value</C>
        <C>Col=L3_AUTHO         Ctrl=cmbL3_AUTHO        Param=value</C>
        <C>Col=ROLE_CD          Ctrl=cmbROLE_CD         Param=value</C>
    '>
</object>