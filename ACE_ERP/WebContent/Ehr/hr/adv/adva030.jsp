	<!--*************************************************************************
	* @source      : adva030.jsp												*
	* @description : 사내공모신청자목록 PAGE 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27            채갑병          	        최초작성									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<% String prmORD_NO = request.getParameter("ORD_NO"); %>
<% String prmDPT_CD = request.getParameter("DPT_CD"); %>

<html>
<head>
	<title>사내공모신청자목록(adva030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ORD_NO_SHR   = document.getElementById("txtORD_NO_SHR").value;
			var DPT_CD_SHR   = document.getElementById("txtDPT_CD_SHR").value;
			var DPT_NM_SHR   = document.getElementById("txtDPT_NM_SHR").value;
			var STR_YMD_SHR  = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR  = document.getElementById("txtEND_YMD_SHR").value;

			dsT_EV_ADVTBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva030.cmd.ADVA030CMD&S_MODE=SHR&ORD_NO_SHR="+ORD_NO_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR;
			dsT_EV_ADVTBOOK.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
        	//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
        	//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_EV_ADVTBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ADVTBOOK.GridToExcel("사내공모신청자목록", '', 225)
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
            document.getElementById("txtORD_NO_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";

	        document.getElementById("resultMessage").innerText = ' ';
        	dsT_EV_ADVTBOOK.ClearData();

            //검색 조건 초기화
            document.getElementById("txtSTR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtEND_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-"+fnc_Lastday(getTodayArray()[0], getTodayArray()[1]);
            document.getElementById("txtSTR_YMD_SHR").focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			// POP_UP 일 경우
			if( '<%=prmORD_NO %>' != ""){
				window.close();
			// 사내공모 신청서 목록 페이지 일 경우
			}else{
				if (dsT_EV_ADVTBOOK.IsUpdated)  {
					if (!fnc_ExitQuestion())  return;
				}
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_EV_ADVTBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	// 팝업일 경우

	        if( '<%=prmORD_NO %>' != "" && '<%=prmORD_NO %>' != "null"){
	        	// '조회','취소'버튼 숨기기
	        	document.getElementById("imgSearch").style.display = "none";
	        	document.getElementById("imgCancel").style.display = "none";
	        	document.getElementById("imgExcel").style.display = "none";

	        	// 단축키 비활성화
	        	btnList = 'FFFFFFFT';


	        	document.getElementById("powerSearch").style.display = "none";

	        	// 파라미터로 전달된 '관리번호'로 목록조회
	        	document.form1.txtORD_NO_SHR.value = '<%=prmORD_NO %>';
	        	document.form1.txtDPT_CD_SHR.value = '<%=prmDPT_CD %>';
	        	document.getElementById("txtSTR_YMD_SHR").value = "00000000";
	            document.getElementById("txtEND_YMD_SHR").value = "99999999";

	        	fnc_SearchList();
	        }else{
	            //검색 조건 초기화
	            document.getElementById("txtSTR_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
	            document.getElementById("txtEND_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-"+fnc_Lastday(getTodayArray()[0], getTodayArray()[1]);
	            document.getElementById("txtSTR_YMD_SHR").focus();
            }

			cfStyleGrid(form1.grdT_EV_ADVTBOOK,0,"false","false");      // Grid Style 적용
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ADVTBOOK)			   |
    | 3. 사용되는 Table List(T_EV_ADVTBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_ADVTBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ADVTBOOK)		       |
    | 3. 사용되는 Table List(T_EV_ADVTBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_ADVTBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK,I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ADVTBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnFail()">
        alert(trT_EV_ADVTBOOK.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Grid Double Click Event                                   |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_EV_ADVTBOOK event=OnDblClick(row,colid)>

        window.showModalDialog("/hr/adv/adva021.jsp?GBN=adva030"+"&ORD_NO_SHR="+dsT_EV_ADVTBOOK.NameString(row, "ORD_NO")+"&ENO_NO_SHR="+dsT_EV_ADVTBOOK.NameString(row, "ADV_ENO_NO"), self, "dialogHeight:670px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        fnc_SearchList();

    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

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
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사내공모신청자목록</td>
					<td align="right" class="navigator">HOME/인사평가/사내공모/<font color="#000000">사내공모신청자목록</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" id="imgSearch" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" id="imgCancel" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<span id="powerSearch" >
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
                            <col width="80"></col>
                            <col width="220"></col>
                            <col width="80"></col>
                            <col width="80"></col>
                            <col width="80"></col>
                            <col width=""></col>
						</colgroup>
						<tr>
                            <td align="center" class="searchState">접수기간</td>
                            <td class="padding2423">
                                <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a>
                                ~
                                <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
                            </td>
							<td class="searchState" align="center">관리번호</td>
							<td class="padding2423" align="left">
								<input id="txtORD_NO_SHR" style="ime-mode:disabled" maxLength="9" size="10" onKeypress="if (event.keyCode == 13){ fnc_SearchList(); return false;} ">
							</td>
							<td class="searchState" align="center">공모부서</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
								</a>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</span>
	<!-- power Search테이블 끝 -->

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

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_EV_ADVTBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" 			value="dsT_EV_ADVTBOOK">
						<param name="SortView" 			value="Left">
						<param name="Format" 			value='
							<C> id="{CUROW}"		width="39"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="ORD_NO"			width="70"		name="관리번호"			align="center"	Edit=none</C>
							<C> id="DPT_NM"			width="105"		name="공모부서"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_NM"			width="120"		name="대상직위"			align="center"	Edit=none</C>
							<C> id="FIELD_DIS"		width="150"		name="모집분야"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="ADV_DPT_NM"		width="90"		name="신청자소속"		align="left"	LeftMargin="10"</C>
							<C> id="ADV_JOB_NM"		width="70"		name="신청자직위"		align="center"</C>
							<C> id="ADV_ENO_NO"		width="70"		name="신청자사번"		align="center"</C>
							<C> id="ADV_ENO_NM"		width="65"		name="신청자이름"		align="center"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <td>
        <br><b>&nbsp;※ <u>해당내역을 더블클릭하면 사내공모 세부 신청서를 볼 수 있습니다.</u></b>
        </td>

	</table>
	<!-- 내용 조회 그리드 데이블 끝-->
	</form>
	<!-- form 끝 -->

</body>
</html>