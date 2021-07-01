<!--
***********************************************************************
* @source      : sagb101.jsp
* @description : 결재세부사항 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>결재세부사항(sagb101)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsT_CP_APPROVAL = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	var ENO_NO2 = dsT_CP_APPROVAL.NameValue(1,"ENO_NO2");
        	var PIS_YM = dsT_CP_APPROVAL.NameValue(1,"PIS_YM");
        	
			dsT_DI_HOLIDAYWORK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb101.cmd.SAGB101CMD&S_MODE=SHR&ENO_NO2="+ENO_NO2+"&PIS_YM="+PIS_YM;
			dsT_DI_HOLIDAYWORK.reset();

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

			cfStyleGrid(form1.grdT_DI_HOLIDAYWORK,0,"false","false");      // Grid Style 적용

            fnc_SearchList();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_HOLIDAYWORK)		   |
    | 3. 사용되는 Table List(T_DI_HOLIDAYWORK) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_HOLIDAYWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
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

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAYWORK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
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
					<td align="right" class="navigator">HOME/근태관리/철야당직/철야당직비본부장결재처리/<font color="#000000">결재세부사항</font></td>
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
						<FC> id={currow}		width=30    name='NO'		    align=center </FC>
						<FC> id='DPT_NM'		width=80	name='소속'			align=left		Edit=none	leftMargin='10'</FC>
						<FC> id='JOB_NM'		width=50	name='직위'			align=left		Edit=none	leftMargin='10'</FC>
						<FC> id='ENO_NO'		width=60	name='사번'			align=center	Edit=none</FC>
						<FC> id='ENO_NM'		width=60	name='성명'			align=center	Edit=none</FC>
                        <C> id='PIS_YM'		width=70	name='해당년월'		align=center	Edit=none</C>
                        <C> id='DUTY_CNT'	width=70	name='당직일수'		align=right 	Edit=none</C>
                        <C> id='DUTY_AMT'	width=70	name='당직수당'		align=right 	Edit=none</C>
                        <C> id='REMARK'		width=100	name='비고'		    align=left	    Edit=none</C>
						<G> name='신청일' HeadBgColor='#F7DCBB'
							<C> id='AT1_CD'		width=20	name='1'	align=center	Edit=none   bgcolor={Decode(AT1_CD,'Y','#F2AC47','#FEEFEF')}    </C>
							<C> id='AT2_CD'		width=20	name='2'	align=center	Edit=none   bgcolor={Decode(AT2_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT3_CD'		width=20	name='3'	align=center	Edit=none   bgcolor={Decode(AT3_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT4_CD'		width=20	name='4'	align=center	Edit=none   bgcolor={Decode(AT4_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT5_CD'		width=20	name='5'	align=center	Edit=none   bgcolor={Decode(AT5_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT6_CD'		width=20	name='6'	align=center	Edit=none   bgcolor={Decode(AT6_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT7_CD'		width=20	name='7'	align=center	Edit=none   bgcolor={Decode(AT7_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT8_CD'		width=20	name='8'	align=center	Edit=none   bgcolor={Decode(AT8_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT9_CD'		width=20	name='9'	align=center	Edit=none   bgcolor={Decode(AT9_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT10_CD'	width=20	name='10'	align=center	Edit=none   bgcolor={Decode(AT10_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT11_CD'	width=20	name='11'	align=center	Edit=none   bgcolor={Decode(AT11_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT12_CD'	width=20	name='12'	align=center	Edit=none   bgcolor={Decode(AT12_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT13_CD'	width=20	name='13'	align=center	Edit=none   bgcolor={Decode(AT13_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT14_CD'	width=20	name='14'	align=center	Edit=none   bgcolor={Decode(AT14_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT15_CD'	width=20	name='15'	align=center	Edit=none   bgcolor={Decode(AT15_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT16_CD'	width=20	name='16'	align=center	Edit=none   bgcolor={Decode(AT16_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT17_CD'	width=20	name='17'	align=center	Edit=none   bgcolor={Decode(AT17_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT18_CD'	width=20	name='18'	align=center	Edit=none   bgcolor={Decode(AT18_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT19_CD'	width=20	name='19'	align=center	Edit=none   bgcolor={Decode(AT19_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT20_CD'	width=20	name='20'	align=center	Edit=none   bgcolor={Decode(AT20_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT21_CD'	width=20	name='21'	align=center	Edit=none   bgcolor={Decode(AT21_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT22_CD'	width=20	name='22'	align=center	Edit=none   bgcolor={Decode(AT22_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT23_CD'	width=20	name='23'	align=center	Edit=none   bgcolor={Decode(AT23_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT24_CD'	width=20	name='24'	align=center	Edit=none   bgcolor={Decode(AT24_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT25_CD'	width=20	name='25'	align=center	Edit=none   bgcolor={Decode(AT25_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT26_CD'	width=20	name='26'	align=center	Edit=none   bgcolor={Decode(AT26_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT27_CD'	width=20	name='27'	align=center	Edit=none   bgcolor={Decode(AT27_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT28_CD'	width=20	name='28'	align=center	Edit=none   bgcolor={Decode(AT28_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT29_CD'	width=20	name='29'	align=center	Edit=none   bgcolor={Decode(AT29_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT30_CD'	width=20	name='30'	align=center	Edit=none   bgcolor={Decode(AT30_CD,'Y','#F2AC47','#FEEFEF')}    </C>
                            <C> id='AT31_CD'	width=20	name='31'	align=center	Edit=none   bgcolor={Decode(AT31_CD,'Y','#F2AC47','#FEEFEF')}    </C>
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