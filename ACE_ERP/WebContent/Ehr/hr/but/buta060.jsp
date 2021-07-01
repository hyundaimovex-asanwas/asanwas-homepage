<!--
***********************************************************************
* @source      : buta060.jsp
* @description : 출장품의 삭제처리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>출장비신청내역(buta050)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TFFTFFTT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById("txtORD_NO_SHR").value;

			dsT_DI_BUSINESSTRIP_STATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta060.cmd.BUTA060CMD&S_MODE=SHR&ORD_NO="+ord_no;
			dsT_DI_BUSINESSTRIP_STATE.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

            if(dsT_DI_BUSINESSTRIP_STATE.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

            if(confirm("[품의번호:"+dsT_DI_BUSINESSTRIP_STATE.NameValue(1,'ORD_NO')+"]의 정보를 삭제하시겠습니까?")){
				dsT_DI_BUSINESSTRIP_STATE.DeleteRow(1);
				trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_STATE=dsT_DI_BUSINESSTRIP_STATE)";
				trT_DI_BUSINESSTRIP_STATE.action = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta060.cmd.BUTA060CMD&S_MODE=DEL";
				trT_DI_BUSINESSTRIP_STATE.post();
			}

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

           //이곳에 해당 코딩을 입력 하세요

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

            document.getElementById("txtORD_NO_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_BUSINESSTRIP_STATE.ClearData();

            document.getElementById("txtORD_NO_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP_STATE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var ord_no = document.getElementById("txtORD_NO_SHR");

            if(ord_no.value == ""){
                alert("품의번호를 입력하세요!");
                ord_no.focus();
                return false;
            }
            return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtORD_NO_SHR").focus();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP_STATE)	   |
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			        |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_STATE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_STATE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        dsT_DI_BUSINESSTRIP_STATE.ClearData();
        document.getElementById("txtORD_NO_SHR").value = "";
        document.getElementById("txtORD_NO_SHR").focus();        
        
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
        cfErrorMsg(this);
    </script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">출장품의 삭제처리</td>
					<td align="right" class="navigator">HOME/근태관리/출장관리/<font color="#000000">출장품의 삭제처리</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="120"></col>
							<col width="120"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">품의번호&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtORD_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
                            <td>&nbsp;</td>
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
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr align="center">
			<td width="20">&nbsp;</td>
			<td>
				<table width="360" height="220" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
								<colgroup>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
								<tr height="30">
									<td align="center" class="creamBold">소   속</td>
									<td class="padding2423">
										<input id="txtDPT_NM" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td class="creamBold" align="center">직   위</td>
									<td class="padding2423">
										<input id="txtJOB_NM" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td align="center" class="creamBold">품 의 자</td>
									<td class="padding2423">
										<input id="txtNAM_KOR" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
								<tr height="30">
									<td align="center" class="creamBold">결재상태</td>
									<td class="padding2423">
										<input id="txtAPP_CMT" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
                                <tr height="30">
									<td align="center" class="creamBold">관리번호</td>
									<td class="padding2423">
										<input id="txtTRANS_NO" style="WIDTH:100%" class="input_ReadOnly" readOnly>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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
<object id="bndT_DI_BUSINESSTRIP_STATE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP_STATE">
	<Param Name="BindInfo", Value='
        <C>Col=DPT_NM     		Ctrl=txtDPT_NM     		Param=value 	</C>
        <C>Col=JOB_NM			Ctrl=txtJOB_NM	   		Param=value		</C>
		<C>Col=NAM_KOR			Ctrl=txtNAM_KOR     	Param=value		</C>
		<C>Col=APP_CMT			Ctrl=txtAPP_CMT	   		Param=value		</C>
		<C>Col=TRANS_NO			Ctrl=txtTRANS_NO   		Param=value		</C>
    '>
</object>