<!--
***********************************************************************
* @source      : gunc021.jsp
* @description : 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String selectRow = request.getParameter("selectRow");
%>
<html>
<head>
	<title>결재세부사항(gunc021)</title>
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

	<script language="javascript">

		var btnList = 'FFFFFFFT';
        var param = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            trT_DI_HOLIDAYWORK.KeyValue = "shr(O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_DI_HOLIDAYWORK=dsT_DI_HOLIDAYWORK)";
            trT_DI_HOLIDAYWORK.action   = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc021.cmd.GUNC021CMD"
                                        + "&S_MODE=SHR"
                                        + "&HOL_YMD="   +param.gun_ymd
                                        + "&DPT_CD="    +param.gun_dpt
                                        + "&SEQ_NO="    +param.seq_no
                                        + "&GRP_NO="    +param.grp_no
                                        + "&GUNC="      +param.gunc;
            trT_DI_HOLIDAYWORK.post();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
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

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
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
            fnc_HiddenElement("imgApproval");
            fnc_HiddenElement("imgRejection");



			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,0,"false","false");      // Grid Style 적용

            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /**
         * 처리 버튼
         */
        function fnc_Append(app_yn) {

            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("처리할 자료가 없습니다!");
                document.getElementById("resultMessage").innerText = "* 처리할 자료가 없습니다!";
                return;
            }

            //결재정보 변경
            if(param.gunc == "020") {
                var text = "[소속:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "해당년월:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+", "
                         + "상신자:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PENO_NM")+"] "
                         + "의 자료를 "+(app_yn == "Y" ? "결재" : "부결")+" 하시겠습니까?";
                if (!confirm(text)) return;
                dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "APP_TAG") = app_yn;

            } else {
                 var text = "[소속:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "해당년월:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+"] "
                         + "의 자료를 "+(app_yn == "Y" ? "결재" : "부결")+" 하시겠습니까?";
                if (!confirm(text)) return;


                for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++)
                    dsT_DI_APPROVAL.NameString(i, "APP_TAG") = app_yn;
            }


            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc020.cmd.GUNC020CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_HOLIDAYWORK)		   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_HOLIDAYWORK)		   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_HOLIDAYWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_APPROVAL)		   |
    | 3. 사용되는 Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

  	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if(iCount > 0) {
            var today   = fnc_covNumber(getToday());

            //CHECK_DATE!!!

            //결재기간
            var appFrom = fnc_covNumber(param.gun_ymd+"11");
            var appTo   = fnc_covNumber(param.gun_ymd+"15");

            var app_yn  = dsT_DI_APPROVAL.NameString(1, "PAPP_YN");


            //오늘이 결재기간이면
            /*
            test test test
            if(appFrom <= today
                    && today <= appTo) {
            */
                //상신일때
                if(app_yn == "R" && param.seq_no == "1") {
                    fnc_ShowElement("imgApproval");
                    fnc_ShowElement("imgRejection");
                }else if(app_yn == "R" && param.seq_no == "2"){
                    fnc_HiddenElement("imgApproval");
                    fnc_ShowElement("imgRejection");
                }

            /*
            test test test
            }
            */
        }

    </Script>


	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("처리가 완료 되었습니다.");
        window.close();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재세부사항</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/휴일근무결재처리/<font color="#000000">결재세부사항</font></td>
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
                <img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- 조회 상태 테이블 시작 -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_HOLIDAYWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_HOLIDAYWORK">
						<param name="Format"				value="
								<C> id='{CUROW}'		width=39			name='NO'								align=center			value={String(Currow)}	</C>
								<C> id='DPT_NM'			width=120			name='소속'								align=center													</C>
								<C> id='JOB_NM'			width=85			name='직위'								align=center													</C>
								<C> id='ENO_NO'			width=90			name='사번'								align=center													</C>
								<C> id='ENO_NM'			width=90			name='성명'								align=center													</C>
								<C> id='HOL_YMD'		width=90			name='휴일근무일자'						align=center													</C>
								<C> id='HOL_TIME'		width=75			name='시간'								align=center													</C>
								<C> id='HOL_AMT'		width=90			name='수당'								align=right				value={Decode(HOL_AMT,0,'',HOL_AMT)}	</C>
								<C> id='REP_APP'		width=100			name='휴일근무신청'						align=center			value={Decode(REP_APP,'1','대체휴가','2','대체반차','3','휴일근무수당',' ')}	</C>
                                <C> id='REMARK'         width=100           name='비고'                              align=left      Edit=none                  </C>
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