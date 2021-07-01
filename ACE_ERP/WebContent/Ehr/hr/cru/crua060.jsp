<!--
***********************************************************************
* @source      : crua060.jsp
* @description : 가산점관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/12      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>가산점관리(crua060)</title>
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

			if(!fnc_SearchItemCheck()) return;

			var pis_yy   = document.getElementById("txtPIS_YY_SHR").value;
			var seq_no   = document.getElementById("txtSEQ_NO_SHR").value;
            var reg_no  = document.getElementById("txtREG_NO_SHR").value;
            var eno_nm  = document.getElementById("txtENO_NM_SHR").value;
            var cd_gbn  = document.getElementById("cmbCD_GBN_SHR").value;
            var pnt     = document.getElementById("txtPNT_SHR").value;
            var ud_gbn  = document.getElementById("cmbUD_GBN_SHR").value;

            //채용 차수 리스트 조회
            dsT_RC_HISTORY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=SHR2&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no;
            dsT_RC_HISTORY.reset();

            //가산점 리스트 조회
			dsT_RC_ADDPOINT.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua060.cmd.CRUA060CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no+"&REG_NO="+reg_no+"&ENO_NM="+eno_nm+"&CD_GBN="+cd_gbn+"&PNT="+pnt+"&UD_GBN="+ud_gbn;
    		dsT_RC_ADDPOINT.reset();

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

				if(!fnc_SaveItemCheck()) return;	//유효성 체크

				trT_RC_ADDPOINT.KeyValue = "tr01(I:dsT_RC_ADDPOINT=dsT_RC_ADDPOINT)";
				trT_RC_ADDPOINT.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua060.cmd.CRUA060CMD&S_MODE=SAV";
				trT_RC_ADDPOINT.post();

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

            document.getElementById("txtREG_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("cmbCD_GBN_SHR").value = "";
            document.getElementById("txtPNT_SHR").value = "";
            document.getElementById("cmbUD_GBN_SHR").value = "U";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_RC_ADDPOINT.ClearData();
            dsT_RC_HISTORY.ClearData();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_RC_ADDPOINT.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var year = document.getElementById("txtPIS_YY_SHR");
			var seq = document.getElementById("txtSEQ_NO_SHR");

            if(year == "" || year.value.length < 4){
                alert("4자리수 채용년도를 반드시 입력하셔야 합니다!");
                year.focus();
                return false;
            }
            if(seq == "" || seq.value.length < 2) {
                alert("2자리수 차수를 반드시 입력하셔야 합니다!");
                seq.focus();
                return false;
            }

			return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_ADDPOINT.IsUpdated ) {
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
            fnc_DisableElementAll(pntList);

            document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";

			cfStyleGrid(form1.grdT_RC_ADDPOINT,15,"false","right");      // Grid Style 적용

            document.getElementById('txtPIS_YY_SHR').focus();

            fnc_SearchList();
                form1.grdT_RC_ADDPOINT.ColumnProp("{currow}", "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("PIS_YY"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("SEQ_NO"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("REG_NO"  , "Sort") = "false";
                form1.grdT_RC_ADDPOINT.ColumnProp("ENO_NM"  , "Sort") = "false";

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        //가산점 항목 리스트
        var pntList = new Array(     "txtSCH_PNT"
                                    ,"txtUYMD_PNT"
                                    ,"txtTAVE_PNT"
                                    ,"txtAWDYN_PNT"
                                    ,"txtTOEIC_PNT"
                                    ,"txtHSK_PNT"
                                    ,"txtJPT_PNT"
                                    ,"txtLICENCE_PNT"
                                    ,"txtMILYN_PNT"
                                    ,"txtETC_PNT" );

        var exceptionList = new Array();

        /**
         * 총합을 계산
         */
		function fnc_TotalPNT(pnt) {
            var tot_pnt = 0;

            for(var i=0; i<pntList.length; i++) {
                tot_pnt += fnc_covNumber(document.getElementById(pntList[i]).value);
            }
            document.getElementById("txtTOTAL_PNT").value = tot_pnt;
		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_RC_ADDPOINT) |
    | 3. 사용되는 Table List(T_RC_ADDPOINT)		     |
    +------------------------------------------------>
    <Object ID="dsT_RC_ADDPOINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_RC_HISTORY)  |
    | 3. 사용되는 Table List(T_RC_HISTORY)          |
    +----------------------------------------------->
    <Object ID="dsT_RC_HISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_RC_ADDPOINT)	|
    | 3. 사용되는 Table List(T_RC_ADDPOINT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_ADDPOINT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_RC_ADDPOINT)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_RC_ADDPOINT Event="OnLoadCompleted(iCount)">

        document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;
		document.getElementById("txtSEQ_NO").value = document.getElementById("txtSEQ_NO_SHR").value;

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_RC_ADDPOINT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_ADDPOINT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[아이디] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[채용년도/차수/아이디]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_RC_ADDPOINT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_RC_ADDPOINT event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_RC_ADDPOINT event=OnRowPosChanged(row)>
        fnc_DisableElementAll(pntList);

        if(row > 0) {
            //채용차수가 서류심사기준 완료 일때만 가산점 수정이 가능함
            if(dsT_RC_HISTORY.NameString(0, "PRO_STS") == "2") {
                fnc_EnableElementAll(pntList);
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">가산점관리</td>
					<td align="right" class="navigator">HOME/업무관리/채용관리/<font color="#000000">가산점관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
								<col width="80"></col>
								<col width="110"></col>
								<col width="80"></col>
								<col width="60"></col>
                                <col width="80"></col>
								<col width="60"></col>
                                <col width="80"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">채용년도&nbsp;</td>
								<td class="padding2423">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>
								</td>
								<td align="center" class="searchState">채용차수&nbsp;</td>
								<td class="padding2423">
									<input id="txtSEQ_NO_SHR" size="4" maxLength="2" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">
								</td>
                                <td align="center" class="searchState">수험번호</td>
                                <td class="padding2423"><input id="txtREG_NO_SHR" size="15" maxLength="11" style="ime-mode:disabled;" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"></td>
                                <td align="center" class="searchState">성 명</td>
                                <td class="padding2423"><input id="txtENO_NM_SHR" size="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onkeyup="fc_chk_byte(this,40);"></td>
							</tr>
                            <tr>
                                <td align="center" class="searchState">가산점 조건</td>
                                <td class="padding2423">
                                    <select id="cmbCD_GBN_SHR" style="WIDTH: 100%">
                                        <option value="">없 음</option>
                                        <option value="SCH_PNT">학력가산점</option>
                                        <option value="UYMD_PNT">졸업년월가산점</option>
                                        <option value="TAVE_PNT">학점가산점</option>
                                        <option value="AWDYN_PNT">보훈대상가산점</option>
                                        <option value="TOEIC_PNT">토익가산점</option>
                                        <option value="HSK_PNT">HSK가산점</option>
                                        <option value="JPT_PNT">JPT가산점</option>
                                        <option value="LICENCE_PNT">자격증가산점</option>
                                        <option value="MILYN_PNT">병역가산점</option>
                                        <option value="ETC_PNT">기타가산점</option>
                                    </select>
                                </td>
								<td align="center" class="padding2423">
									<input id="txtPNT_SHR" size="3" maxLength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">점
								</td>
                                <td align="center" class="padding2423">
									<select id="cmbUD_GBN_SHR" style="WIDTH: 100%">
                                        <option value="U">이 상</option>
                                        <option value="D">이 하</option>
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
					<col width="100"></col>
					<col width="35"></col>
					<col width="100"></col>
					<col width="35"></col>
					<col width="100"></col>
					<col width="60"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">채용년도</td>
					<td class="padding2423"><input id="txtPIS_YY" size="11" class="input_ReadOnly" readOnly></td>
					<td align="center" class="creamBold">차  수</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="4" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">수험번호</td>
					<td class="padding2423"><input id="txtREG_NO" size="11" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">성 명</td>
					<td class="padding2423"><input id="txtENO_NM" size="10" class="input_ReadOnly" readOnly></td>
                </tr>
                <tr>
					<td align="center" class="creamBold">학력가산점</td>
					<td class="padding2423"><input id="txtSCH_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">졸업년월가산점</td>
					<td class="padding2423"><input id="txtUYMD_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">학점가산점</td>
					<td class="padding2423"><input id="txtTAVE_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">보훈대상가산점</td>
					<td class="padding2423"><input id="txtAWDYN_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">토익가산점</td>
					<td class="padding2423"><input id="txtTOEIC_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">HSK가산점</td>
					<td class="padding2423"><input id="txtHSK_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">JPT가산점</td>
					<td class="padding2423"><input id="txtJPT_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">자격증가산점</td>
					<td class="padding2423"><input id="txtLICENCE_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">병역가산점</td>
					<td class="padding2423"><input id="txtMILYN_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">기타가산점</td>
					<td class="padding2423"><input id="txtETC_PNT" size="7" maxLength="3" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();" onKeyUp="fnc_TotalPNT(this);">점</td>
                    <td align="center" class="creamBold">가산점 총합</td>
					<td class="padding2423" colspan="3"><input id="txtTOTAL_PNT" size="7" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readOnly>점</td>
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
						<object	id="grdT_RC_ADDPOINT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
							<param name="DataID"				  value="dsT_RC_ADDPOINT">
   						    <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
							<param name="Format"					value="
                                <C> id={currow}		    width=35    name='NO'			sort=false  align=center value={String(currow)}</C>
                                <C> id='PIS_YY'		    width=60	name='채용년도'		sort=false  align=center </C>
                                <C> id='SEQ_NO'		    width=35	name='차수'			sort=false  align=center </C>
                                <C> id='REG_NO'		    width=75	name='수험번호'		sort=false  align=center </C>
                                <C> id='ENO_NM'		    width=55	name='성명'			sort=false  align=center </C>
                                <C> id='SCH_PNT'	    width=50	name='학력'			sort=true   align=right </C>
                                <C> id='UYMD_PNT'	    width=70	name='졸업년월'		sort=true   align=right </C>
                                <C> id='TAVE_PNT'	    width=50	name='학점'			sort=true   align=right </C>
                                <C> id='AWDYN_PNT'	    width=70	name='보훈대상'		sort=true   align=right </C>
                                <C> id='TOEIC_PNT'	    width=50	name='토익'			sort=true   align=right </C>
                                <C> id='HSK_PNT'	    width=45	name='HSK'			sort=true   align=right </C>
                                <C> id='JPT_PNT'	    width=45	name='JPT'			sort=true   align=right </C>
                                <C> id='LICENCE_PNT'    width=60	name='자격증'		sort=true   align=right </C>
                                <C> id='MILYN_PNT'		width=50	name='병역'			sort=true   align=right </C>
                                <C> id='ETC_PNT'		width=50	name='기타'		    sort=true   align=right </C>
                                <C> id='TOTAL_PNT'		width=85	name='가산점총합'	sort=true   align=right </C>
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
<!-- 채용차수별 아이디와 비밀번호 설정 테이블 -->
<object id="bndT_RC_ADDPOINT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_ADDPOINT">
	<Param Name="BindInfo", Value='
        <C>Col=PIS_YY		Ctrl=txtPIS_YY	      	Param=value		</C>
        <C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	     	Param=value		</C>
        <C>Col=REG_NO		Ctrl=txtREG_NO      	Param=value		</C>
        <C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value		</C>
        <C>Col=SCH_PNT		Ctrl=txtSCH_PNT	      	Param=value		</C>
        <C>Col=UYMD_PNT		Ctrl=txtUYMD_PNT	    Param=value		</C>
        <C>Col=TAVE_PNT		Ctrl=txtTAVE_PNT	    Param=value		</C>
        <C>Col=AWDYN_PNT	Ctrl=txtAWDYN_PNT	    Param=value		</C>
        <C>Col=TOEIC_PNT	Ctrl=txtTOEIC_PNT	    Param=value		</C>
        <C>Col=HSK_PNT		Ctrl=txtHSK_PNT	     	Param=value		</C>
        <C>Col=JPT_PNT		Ctrl=txtJPT_PNT	     	Param=value		</C>
        <C>Col=LICENCE_PNT	Ctrl=txtLICENCE_PNT	    Param=value		</C>
        <C>Col=MILYN_PNT	Ctrl=txtMILYN_PNT	    Param=value		</C>
        <C>Col=ETC_PNT		Ctrl=txtETC_PNT	     	Param=value		</C>
        <C>Col=TOTAL_PNT	Ctrl=txtTOTAL_PNT	    Param=value		</C>
    '>
</object>