<!--*************************************************************************
/*--------------------------------------------------------------------------------
+ 시스템명 : 일용직 인사관리 - 결재조회
+ 기능정의 : 결재 상황 조회한다.
+ 프로그램ID : aday040.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2013.04.03
----------------------------------------------------------------------------------
+ 수정내용 : 
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------*/-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>결재조회(aday040.jsp)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			dsT_CA_APPROVE.dataid = "/servlet/GauceChannelSVL?cmd=hr.ada.a.aday040.cmd.ADAY040CMD&S_MODE=SHR"
												+ "&PIS_YYMM=" + document.getElementById("txtPIS_YYMM_SHR").value
												+ "&SITE_CD=" + document.getElementById("txtSITE_CD_SHR").value;
				
			dsT_CA_APPROVE.reset();
			
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {


        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {

        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {

        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {


		}

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {

        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {

			
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            //날짜값들 바인딩
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), 0);
            document.getElementById("txtPIS_YYMM_SHR").value = svc_ymd.substr(0,7); // 해당년월 To


			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YYMM_SHR = (document.getElementById("txtPIS_YYMM_SHR").value).replace("-", "").replace("-", "");
			
			if(PIS_YYMM_SHR.trim() == ""){
				document.getElementById("txtPIS_YYMM_SHR").value = "";
			}

            cfStyleGrid5(form1.grdT_CA_APPROVE,0,"false","true");      // Grid Style 적용

            //fnc_SearchList();
            
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 날짜 형식 유효성 체크                           			*
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
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_CA_APPROVE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CA_BELONG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_CA_APPROVE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CA_APPROVE.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CA_APPROVE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CA_APPROVE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>


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
	<form name="form1" id="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재조회</td>
					<td align="right" class="navigator">HOME/보상관리/일용직관리/<font color="#000000">결재조회</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="100"></col>
                            <col width="150"></col>
                            <col width="100"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
							<td align="center" class="searchState">기준월</td>
                            <td class="padding2423">
								<input id="txtPIS_YYMM_SHR" size="9" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YYMM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YYMM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','75','112');"></a>
							</td>					                        
                            <td class="searchState" align="right">소 속 &nbsp;</td>
	                        <td class="padding2423">
	                        <input id="txtSITE_CD_SHR"  name="txtSITE_CD_SHR" style="width:15%" 	maxlength="4" onChange="fnc_GetCommNm('AY', 'txtSITE_CD_SHR','txtSITE_NM_SHR')">
							<input id="txtSITE_NM_SHR" name="txtSITE_NM_SHR" size="15" maxlength="15" class="input_ReadOnly" readonly>
							<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD_SHR','txtSITE_NM_SHR','소속','AY');fnc_SearchList();"></a>
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
					<object id="grdT_CA_APPROVE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
						<param name="DataID" 					value="dsT_CA_APPROVE">
						<PARAM NAME="TITLEHEIGHT"		VALUE=40>
						<PARAM NAME="SORTVIEW"    		VALUE=LEFT>
						<PARAM NAME="BORDERSTYLE" 		VALUE="0">
						<PARAM NAME="INDWIDTH"			VALUE="0">
						<PARAM NAME="FILLAREA"				VALUE="true">
						<PARAM NAME="EDITABLE"				VALUE="true">
						<PARAM NAME="Colsizing"				VALUE="true">
                        <param name="SuppressOption"    	value="1">								
						<param name="Format" 					value="
						
               				<FC>Name=NO				ID={CurRow} 		Width=30,  	align=center, 	editable=false</FC>		
							<FC>Name=소속,   	 	ID=SITE_NM,  		width=185, 	align=left, 		editable=false sort = true, suppress=4</FC>
							
							<G>Name=결재자    		HeadAlign=Center HeadBgColor=#F7DCBB
							<FC>Name=사번,   	 	ID=ENO_NO,  		width=65, 	align=center, 	edit=none sort = true </FC>	
							<FC>Name=직위,   	 	ID=JOB_NM,  		width=75, 	align=center, 	edit=none sort = true </FC>								            									
							<FC>Name=성명,  		ID=ENO_NM	  		width=70,   align=center, 	edit=none sort = true </FC>
							<FC>Name=진행상태,  	ID=APP_YN,   		width=75, 	align=center, 	edit=none sort = true  	value={IF (APP_YN='R','진행중',IF (APP_YN='Y','결재완료',''))} </FC>						
							</G>
							
							<G>Name=기안자			HeadAlign=Center HeadBgColor=#F7DCBB						
							<FC>Name=사번, 			ID=PENO_NO,    	width=65, 	align=center, 	edit=none sort = true suppress=3</FC>
							<FC>Name=성명,  		ID=PENO_NM,  	width=70, 	align=center, 	edit=none sort = true suppress=2</FC>
							</G>
															
							<FC>Name=기안일시,    ID=IPT_YMD,   		width=140,	align=center, 	edit=none sort = true  suppress=1</FC>
							
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


