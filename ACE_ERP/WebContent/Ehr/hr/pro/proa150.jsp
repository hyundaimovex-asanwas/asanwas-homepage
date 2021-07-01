	<!--*************************************************************************
	* @source      : proa150.jsp												*
	* @description : 계약직 승진대상자선정 PAGE									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/04/13      김학수        최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>계약직 승진대상자 선정(proa150)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">
    //버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
        var btnList = 'TFTTFFFT';
//        var btnList = 'FTTTFFTT';
//		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var isSave = false;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 		 	*
         ********************************************/
        function fnc_SearchList() {
			if(!fnc_SearchItemCheck()) return;	//조회 유효성 검사

			var PMT_YMD_SHR  = document.form1.txtPMT_YMD_SHR.value;   // 승진년도
			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // 정기/특별 승진 구분

            dsT_PM_PROMOTION_01.ClearData();

            dsT_PM_PROMOTION_01.DataId = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SHR_01&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
            dsT_PM_PROMOTION_01.Reset();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  		 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
            dsT_PM_PROMOTION.UseChangeInfo = "false";
            trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
			trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SAV";
			trT_PM_PROMOTION.post();
		}

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
		}

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {
  			document.form1.txtPMT_YMD_SHR.value = "";
//			document.form1.txtPRO_CNT.value     = "";
			document.form1.hidGBN_CD_SHR.value  = "1";
            document.getElementById("resultMessage").innerText = ' ';
//			changeInput();
			document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_PROMOTION_01.ClearData();
        	dsT_PM_PROMOTION.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROMOTION.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // 승진년도

            if( PMT_YMD_SHR == "" ){
        		alert("승진년도를 입력하십시오. 예)"+next_yy);
				return false;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("승진년도를 바르게 입력하십시오. 예)"+next_yy);
				return false;
        	}
        	if( PMT_YMD_SHR != next_yy ){
        		alert("차기년도의 대상자만 처리 가능합니다. 예)"+next_yy);
				return false;
        	}
			return true;
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	if ( dsT_PM_PROMOTION.CountRow == 0 ) {
				alert("저장할 승진 대상자가 없습니다.");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분	*
         ********************************************/
        function fnc_OnLoadProcess() {
	        document.form1.txtPMT_YMD_SHR.value = next_yy;
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 		*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

  		/********************************************
         * 날짜 형식 유효성 체크          			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
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
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_PROMOTION)  |
    | 3. 사용되는 Table List(T_PM_PROMOTION)         |
    +----------------------------------------------->
    <Object ID="dsT_PM_PROMOTION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_PROMOTION)  |
    | 3. 사용되는 Table List(T_PM_PROMOTION)         |
    +----------------------------------------------->
    <Object ID="dsT_PM_PROMOTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_PM_PROMOTION                     |
    | 3. Table List : T_PM_PROMOTION                 |
    +----------------------------------------------->
    <Object ID ="trT_PM_PROMOTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_PROMOTION=dsT_PM_PROMOTION,I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_PM_PROMOTION_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

//            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			var PMT_YMD_SHR  = document.form1.txtPMT_YMD_SHR.value;   // 승진년도
			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // 정기/특별 승진 구분

//alert("SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR);
            dsT_PM_PROMOTION.ClearData();

            dsT_PM_PROMOTION.DataId = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa150.cmd.PROA150CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
            dsT_PM_PROMOTION.Reset();
        } else {
//alert(iCount);
//            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_PROMOTION.CountRow );
			alert("계약직 승진 대상자 선정이 되어 있습니다.");

        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_PM_PROMOTION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_PROMOTION.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_PROMOTION_01 Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_PM_PROMOTION Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnFail()">
        alert(trT_PM_PROMOTION.ErrorMsg);
    </script>

    <!--트랜젝션 실패 -->
<!--
    <script for=trT_PM_PROMOTION event="OnFail()">

        cfErrorMsg(this);

    </script>
 -->

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">계약직 승진대상자선정</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">계약직 승진대상자선정</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<table width="100%" border="0" cellspacing="10" cellpadding="0">
						<colgroup>
							<col width="150"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">승진년도</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPMT_YMD_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YMD_SHR" name="imgPMT_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YMD_SHR','','204','118');"></a>
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
        <td class="paddingTop15">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

	<input type="hidden" id="hidGBN_CD_SHR"    value="1">
	</form>

	<!-- form 끝 -->

</body>
</html>