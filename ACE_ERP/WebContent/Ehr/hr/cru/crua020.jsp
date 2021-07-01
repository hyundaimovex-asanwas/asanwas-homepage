	<!--*************************************************************************
	* @source      : crua020.jsp												*
	* @description : 입사지원현황 PAGE	 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/03      오대성          최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>입사지원현황(crua020)</title>
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

		var btnList = 'TFFTFTFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			var f = document.form1;

			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var regyy = f.txtREGYY_SHR.value;
			var regch = f.txtREGCH_SHR.value;
			var reg_str = f.txtREG_NO_STR.value;
			var reg_end = f.txtREG_NO_END.value;
			var school = f.cmbSCHOOL_SHR.value;
			var split_flag = f.rdoSPLIT_FLAG_SHR.CodeValue;
			var passtag = f.cmbPASSTAG_SHR.value;

			var remove = "";
			if(f.chkREMOVE.checked == true){
				var remove = "Y";
			}else{
				var remove = "N";
			}

			dsT_RC_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua020.cmd.CRUA020CMD&S_MODE=SHR&REGYY="+regyy+"&REGCH="+regch+"&REG_STR="+reg_str+"&REG_END="+reg_end+"&SCHOOL="+school+"&SPLIT_FLAG="+split_flag+"&PASSTAG="+passtag+"&REMOVE="+remove;
			dsT_RC_MASTER.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 *
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
  			var f = document.form1;

			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var regyy = f.txtREGYY_SHR.value;
			var regch = f.txtREGCH_SHR.value;
			var reg_str = f.txtREG_NO_STR.value;
			var reg_end = f.txtREG_NO_END.value;
			var school = f.cmbSCHOOL_SHR.value;
			var split_flag = f.rdoSPLIT_FLAG_SHR.CodeValue;
			var passtag = f.cmbPASSTAG_SHR.value;

            var url = "crua020_PV.jsp?REGYY="+regyy+"&REGCH="+regch+"&REGSTR="+reg_str+"&REGEND="+reg_end+"&SCHOOL="+school+"&SPLITFLAG="+split_flag+"&PASSTAG="+passtag;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
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

			var f = document.form1;
			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";
			f.txtREG_NO_STR.value = "";
			f.txtREG_NO_END.value = "";
			f.cmbSCHOOL_SHR.value = "1";
			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";
			f.cmbPASSTAG_SHR.value = "1";
			f.chkREMOVE.checked = false;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_RC_MASTER.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var regyy = document.getElementById('txtREGYY_SHR');
			var regch = document.getElementById('txtREGCH_SHR');
			var reg_str = document.getElementById('txtREG_NO_STR');
			var reg_end = document.getElementById('txtREG_NO_END');

			if(regyy.value == '') {
				alert("년도는 필수 입력사항입니다!");
				regyy.focus();
				return false;
			} else if(regyy.value.length < 4) {
				alert("4자리수의 년도를 입력하세요!");
				regyy.focus();
				return false;
			}
			if(regch.value == '') {
				alert("회차는 필수 입력사항입니다!");
				regch.focus();
				return false;
			} else if(regch.value.length < 2) {
				alert("2자리수의 회차를 입력하세요!");
				regch.focus();
				return false;
			}

			if(reg_str.value != '' && reg_str.value.length < 11) {
				alert("11자리수의 수험번호를 입력하세요!");
				reg_str.focus();
				return false;
			}
			if(reg_end.value != '' && reg_end.value.length < 11) {
				alert("11자리수의 수험번호를 입력하세요!");
				reg_end.focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   *
         ********************************************/
        function fnc_OnLoadProcess() {
			var f = document.form1;

			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";

			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";

//			cfStyleGrid(form1.grdT_RC_MASTER,0,"false","false");      // Grid Style 적용
			f.txtREGYY_SHR.focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_RC_MASTER)		   |
    | 3. 사용되는 Table List(T_RC_MASTER) 			       |
    +------------------------------------------------------>
	<Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_RC_MASTER Event="OnDataError()">
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
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">입사지원현황</td>
					<td align="right" class="navigator">HOME/기타/채용관리/<font color="#000000">입사지원현황</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
 	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="40"></col>
							<col width="70"></col>
							<col width="100"></col>
							<col width="170"></col>
							<col width="40"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">년도&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGYY_SHR"  size="4" maxLength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtREGYY_SHR','','5','115');"></a>
							</td>
							<td align="right" class="searchState">수험번호&nbsp;</td>
							<td class="padding2423">
								<input id="txtREG_NO_STR"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"> - <input id="txtREG_NO_END"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
							<td align="right" class="searchState">학력</td>
							<td class="padding2423">
                                <select id="cmbSCHOOL_SHR">
                                    <option value="">전 체</option>
                                    <option value="Y">대졸이상</option>
                                    <option value="N">대졸미만</option>
                                </select>
							</td>
							<td align="right" class="searchState">합격여부</td>
							<td class="padding2423">
                                <select id="cmbPASSTAG_SHR">
                                    <option value="">원서접수</option>
                                    <option value="1">서류합격</option>
                                    <option value="2">1차면접합격</option>
                                    <option value="3">2차면접합격</option>
                                    <option value="4">3차면접합격</option>
                                    <option value="5">신체검사합격</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td align="center" class="searchState">차수&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGCH_SHR"  size="4" maxLength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
							</td>
							<td align="center" class="searchState">신입/경력구분&nbsp;</td>
							<td class="padding2423"><comment id="__NSID__">
								<object id=rdoSPLIT_FLAG_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
											style="height:20; width:140">
									<param name=AutoMargin	value="true">
									<param name=Cols		value="2">
									<param name=Format		value="A^신입사원,B^경력사원">
								</object>
								</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
							<td class="searchState" colspan="2">
								&nbsp;&nbsp;배제자 제외
								<input type="checkbox" id="chkREMOVE" style="border:0" align="absmiddle" ></td>
							<td></td>
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
			<td class="paddingTop5">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							<object id="mgrdT_RC_MASTER" classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width="800" height="335">
								<Param Name="DataID"		 value="dsT_RC_MASTER">
							    <Param Name="IndicatorInfo"	 value='<INDICATORINFO width="0"></INDICATORINFO>'>
								<param name="Sort"           value="false">
							    <Param Name="ColumnInfo"	 value='
							      <COLUMNINFO>
									<COLUMN id="NO">
							    		<HEADER left="0" top="0" right="35" bottom="30" bgcolor="#F7DCBB" text="NO"/>
							    		<VIEW bordercolor="silver" left="0" top="0" right="35" bottom="80" align="centercenter" text="@CURREC"/>
							    	</COLUMN>
							    	<COLUMN id="REG_NO" refcolid="REG_NO">
							    		<HEADER left="35" top="0" right="110" bottom="30" bgcolor="#F7DCBB" text="수험번호"/>
							    		<VIEW bordercolor="silver" left="35" top="0" right="110" bottom="80" align="centercenter" />
							    	</COLUMN>
							    	<COLUMN id="ENO_NM" refcolid="ENO_NM">
							    		<HEADER left="110" top="0" right="160" bottom="30" bgcolor="#F7DCBB" text="성명"/>
							    		<VIEW bordercolor="silver" left="110" top="0" right="160" bottom="80" align="centercenter" />
							    	</COLUMN>
									<COLUMN id="BIRYMD" refcolid="BIRYMD">
							    		<HEADER left="160" top="0" right="230" bottom="30" bgcolor="#F7DCBB" text="생년월일"/>
							    		<VIEW bordercolor="silver" left="160" top="0" right="230" bottom="80" align="centercenter" displayformat="XXXX-XX-XX"/>
							    	</COLUMN>
									<COLUMN id="SEXGU" refcolid="SEXGU">
							    		<HEADER left="230" top="0" right="260" bottom="30" bgcolor="#F7DCBB" text="성별"/>
							    		<VIEW bordercolor="silver" left="230" top="0" right="260" bottom="80" align="centercenter" text="@DECODE(SEXGU,[M],[남],[F],[여])"/>
							    	</COLUMN>
									<COLUMN id="SCH_YMD" refcolid="SCH_YMD">
							    		<HEADER left="260" top="0" right="315" bottom="30" bgcolor="#F7DCBB" text="졸업년도"/>
							    		<VIEW bordercolor="silver" left="260" top="0" right="315" bottom="80" align="centercenter" />
							    	</COLUMN>
							    	<COLUMN id="SCH_NM" refcolid="SCH_NM">
							    		<HEADER left="315" top="0" right="415" bottom="30" bgcolor="#F7DCBB" text="출신교/전공"/>
							    		<VIEW bordercolor="silver" left="315" top="0" right="415" bottom="40" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="SCH_MAJOR" refcolid="SCH_MAJOR">
										<HEADER left="315" top="0" right="415" bottom="30" bgcolor="#F7DCBB" text="출신교/전공"/>
							    		<VIEW bordercolor="silver" left="315" top="40" right="415" bottom="80" align="leftcenter"/>
							    	</COLUMN>
									<COLUMN id="AVE" refcolid="AVE">
							    		<HEADER left="415" top="0" right="475" bottom="30" bgcolor="#F7DCBB" text="학점"/>
							    		<VIEW bordercolor="silver" left="415" top="0" right="475" bottom="40" align="centercenter" />
							    	</COLUMN>
									<COLUMN id="" refcolid="">
							    		<HEADER left="415" top="0" right="475" bottom="30" bgcolor="#F7DCBB" text="학점"/>
							    		<VIEW bordercolor="silver" left="415" top="40" right="475" bottom="80" align="centercenter" />
							    	</COLUMN>
									<COLUMN id="TOEIC" refcolid="TOEIC">
							    		<HEADER left="475" top="0" right="555" bottom="30" bgcolor="#F7DCBB" text="외국어"/>
							    		<VIEW bordercolor="silver" left="475" top="0" right="555" bottom="40" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="TOEFL" refcolid="TOEFL">
										<HEADER left="475" top="0" right="555" bottom="30" bgcolor="#F7DCBB" text="외국어"/>
							    		<VIEW bordercolor="silver" left="475" top="40" right="555" bottom="80" align="leftcenter"/>
							    	</COLUMN>
									<COLUMN id="LICENCE1" refcolid="LICENCE1">
							    		<HEADER left="555" top="0" right="675" bottom="30" bgcolor="#F7DCBB" text="자격/특기사항"/>
							    		<VIEW bordercolor="silver" left="555" top="0" right="675" bottom="20" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="LICENCE2" refcolid="LICENCE2">
										<HEADER left="555" top="0" right="675" bottom="30" bgcolor="#F7DCBB" text="자격/특기사항"/>
							    		<VIEW bordercolor="silver" left="555" top="20" right="675" bottom="40" align="leftcenter"/>
							    	</COLUMN>
									<COLUMN id="LICENCE3" refcolid="LICENCE3">
							    		<HEADER left="555" top="0" right="675" bottom="30" bgcolor="#F7DCBB" text="자격/특기사항"/>
							    		<VIEW bordercolor="silver" left="555" top="40" right="675" bottom="60" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="LICENCE4" refcolid="LICENCE4">
										<HEADER left="555" top="0" right="675" bottom="30" bgcolor="#F7DCBB" text="자격/특기사항"/>
							    		<VIEW bordercolor="silver" left="555" top="60" right="675" bottom="80" align="leftcenter"/>
							    	</COLUMN>
									<COLUMN id="TXT_WANT1" refcolid="TXT_WANT1">
							    		<HEADER left="675" top="0" right="715" bottom="30" bgcolor="#F7DCBB" text=""/>
							    		<VIEW bordercolor="silver" left="675" top="0" right="715" bottom="20" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="TXT_WANT2" refcolid="TXT_WANT2">
										<HEADER left="675" top="0" right="715" bottom="30" bgcolor="#F7DCBB" text=""/>
							    		<VIEW bordercolor="silver" left="675" top="20" right="715" bottom="40" align="leftcenter" />
							    	</COLUMN>
									<COLUMN id="TXT_WANT3" refcolid="TXT_WANT3">
							    		<HEADER left="675" top="0" right="715" bottom="30" bgcolor="#F7DCBB" text=""/>
							    		<VIEW bordercolor="silver" left="675" top="40" right="715" bottom="60" align="leftcenter" />
							    	</COLUMN>
							    	<COLUMN id="" refcolid="">
										<HEADER left="675" top="0" right="715" bottom="30" bgcolor="#F7DCBB" text=""/>
							    		<VIEW bordercolor="silver" left="675" top="60" right="715" bottom="80" align="leftcenter"/>
							    	</COLUMN>
									<COLUMN id="WANT_DPT1" refcolid="WANT_DPT1">
							    		<HEADER left="715" top="0" right="800" bottom="30" bgcolor="#F7DCBB" text="희망부서"/>
							    		<VIEW bordercolor="silver" left="715" top="0" right="800" bottom="20" align="leftcenter" />
							    	</COLUMN>
									<COLUMN id="WANT_DPT2" refcolid="WANT_DPT2">
							    		<HEADER left="715" top="0" right="800" bottom="30" bgcolor="#F7DCBB" text="희망부서"/>
							    		<VIEW bordercolor="silver" left="715" top="20" right="800" bottom="40" align="leftcenter" />
							    	</COLUMN>
									<COLUMN id="WANT_DPT3" refcolid="WANT_DPT3">
							    		<HEADER left="715" top="0" right="800" bottom="30" bgcolor="#F7DCBB" text="희망부서"/>
							    		<VIEW bordercolor="silver" left="715" top="40" right="800" bottom="60" align="leftcenter" />
							    	</COLUMN>
									<COLUMN id="" refcolid="">
							    		<HEADER left="715" top="0" right="800" bottom="30" bgcolor="#F7DCBB" text="희망부서"/>
							    		<VIEW bordercolor="silver" left="715" top="60" right="800" bottom="80" align="leftcenter" />
							    	</COLUMN>
									<COLUMN id="FIN_DPT" refcolid="FIN_DPT">
							    		<HEADER left="800" top="0" right="900" bottom="30" bgcolor="#F7DCBB" text="배치부서"/>
							    		<VIEW bordercolor="silver" left="800" top="0" right="900" bottom="80" align="centercenter" />
							    	</COLUMN>
							     </COLUMNINFO>'>
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
