	<!--
	***********************************************************************
	* @source      : weld060.jsp
	* @description : 성수기콘도신청 PAGE
	***********************************************************************
	* DATE            AUTHOR        DESCRIPTION
	*----------------------------------------------------------------------
	* 2006/12/15      오대성        최초작성.
	***********************************************************************
	-->

	<%@ page contentType="text/html; charset=EUC-KR"%>
	<%@ include file="/common/sessionCheck.jsp" %>

	<html>
	<head>
	<title>성수기콘도신청(weld060)</title>
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

	        //단축키 순서
	        var btnList = "T"   //조회
	                    + "F"   //신규
	                    + "T"   //저장
	                    + "T"   //취소
	                    + "F"   //엑셀
	                    + "F"   //인쇄
	                    + "F"   //삭제
	                    + "T";  //닫기

	        /***********************************
	         * 01. 조회 함수_List 형태의 조회  *
	         ***********************************/
	        function fnc_SearchList() {

				var ORD_NO = document.getElementById("cmbORD_NO_SHR").value;

	            trSHR.KeyValue  = "tr01(O:CONDOLOT=dsT_WL_CONDOLOT, O:CONDOSSN=dsT_WL_CONDOSSN2)";
	            trSHR.action    = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld060.cmd.WELD060CMD&S_MODE=SHR&ORD_NO="+ORD_NO;
	            trSHR.post();

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

				trT_WL_CONDOLOT.KeyValue = "tr01(I:dsT_WL_CONDOLOT=dsT_WL_CONDOLOT)";
				trT_WL_CONDOLOT.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld060.cmd.WELD060CMD&S_MODE=SAV";
				trT_WL_CONDOLOT.post();

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

				//document.getElementById('cmbRST_YN_SHR').value = '';
				document.getElementById("resultMessage").innerText = ' ';

				dsT_WL_CONDOLOT.ClearData();

	        }

	        /************************
	         * 11. 화면 종료(닫기)  *
	         ***********************/
	        function fnc_Exit() {

				if (dsT_WL_CONDOLOT.IsUpdated)  {

					if (!fnc_ExitQuestion()) return;

				}

				frame = window.external.GetFrame(window);
				frame.CloseFrame();

	        }

	        /******************************
	         * 12. 검색 조건 유효성 검사  *
	         ******************************/
	        function fnc_SearchItemCheck() {

				//이곳에 해당 코딩을 입력 하세요

	        }

	        /*************************
	         * 13. 저장 유효성 체크  *
	         *************************/
	        function fnc_SaveItemCheck() {

				var app1     = dsT_WL_CONDOSSN2.NameValue(1,'APP1_YMD');
				var app2     = dsT_WL_CONDOSSN2.NameValue(1,'APP2_YMD');
				var lottery  = dsT_WL_CONDOSSN2.NameValue(1,'LOTTERY');
				var today    = removeChar(getToday(),"-");


				if (app1 > today || app2 < today){
					alert("성수기 추첨 신청 기간이 아닙니다!");
					return false;
				}
				if (lottery > 0){
					alert("성수기 추첨이 완료되어 저장 할 수 없습니다!");
					return false;
				}

	            if (!dsT_WL_CONDOLOT.IsUpdated ) {
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

				cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"false","false");      // Grid Style 적용

				//콘도 성수기 관리번호 (weld050 사용)
				dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
				dsT_WL_CONDOSSN.Reset();

	        }

			/********************
	         * 15. 단축키 처리  *
	         *******************/
			function fnc_HotKey() {

				fnc_HotKey_Process(btnList, event.keyCode);

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
	    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOLOT) |
	    | 3. 사용되는 Table List(T_WL_CONDOLOT)		     |
	    +------------------------------------------------>
	    <Object ID="dsT_WL_CONDOLOT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

		<!-----------------------------------------------+
	    | 1. 조회용 DataSet								 |
	    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOSSN) |
	    | 3. 사용되는 Table List(T_WL_CONDOSSN)		     |
	    +------------------------------------------------>
	    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

	    <Object ID="dsT_WL_CONDOSSN2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	        <Param Name="Syncload"        Value="True">
	        <Param Name="UseChangeInfo"   Value="True">
	        <Param Name="ViewDeletedRow"  Value="False">
	    </Object>

	    <!--------------------------------------------------+
	    | 1. 자료 저장 및 조회용 Data Transacton			|
	    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOLOT)	|
	    | 3. 사용되는 Table List(T_WL_CONDOLOT)	            |
	    +--------------------------------------------------->
	    <Object ID ="trT_WL_CONDOLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	        <Param Name=KeyName     Value="toinb_dataid4">
	        <Param Name=ReadOnly	Value="True">
	    </Object>

	    <Object ID ="trSHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	        <Param Name=KeyName     Value="toinb_dataid4">
	    </Object>


	    <!-- 공통 콤보를 위한 DataSet -->
	    <!-- 콘도 -->
	    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
	       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
	       <jsp:param name="CODE_GUBUN"    value="CN"/>
	       <jsp:param name="SYNCLOAD"      value="false"/>
	       <jsp:param name="USEFILTER"     value="false"/>
	    </jsp:include>


	    <!--*************************************
	    *                                       *
	    *  Component에서 발생하는 Event 처리부  *
	    *                                       *
	    **************************************-->

	    <!-------------------------------------------------+
	    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
	    +-------------------------------------------------->
	    <Script For=dsT_WL_CONDOLOT Event="OnLoadCompleted(iCount)">

	        if (iCount < 1)    {

	            alert("현재 성수기 추첨등록기간이 아닙니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_02");

	        } else {

				fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

	        }

	    </Script>

	    <!-----------------------------------------------------+
	    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
	    +------------------------------------------------------>
	    <Script For=dsT_WL_CONDOLOT Event="OnLoadError()">

	        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
	        cfErrorMsg(this);

	        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

	    </Script>

		<!-------------------------------------------------+
	    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
	    +-------------------------------------------------->
	    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

	        if (iCount > 0) {
				var oOption;
				for(var i=1 ; i<=iCount ; i++) {

					oOption         = document.createElement("OPTION");
					oOption.text    = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
					oOption.value   = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");

					document.getElementById("cmbORD_NO_SHR").add(oOption);
				}
				document.getElementById("cmbORD_NO_SHR").selectedIndex = 0;
	        }

	    </Script>

	    <Script For=dsT_WL_CONDOSSN2 Event="OnLoadCompleted(iCount)">
	        var app1     = dsT_WL_CONDOSSN2.NameValue(1,'APP1_YMD');
	        var app2     = dsT_WL_CONDOSSN2.NameValue(1,'APP2_YMD');
	        var lottery  = dsT_WL_CONDOSSN2.NameValue(1,'LOTTERY');
	        var today    = removeChar(getToday(),"-");


	        if (app1 > today || app2 < today || lottery > 0){
	            grdT_WL_CONDOLOT.Editable = false;
	        } else {
	            grdT_WL_CONDOLOT.Editable = true;
	        }

	    </Script>

	    <!-----------------------------------------------------+
	    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
	    +------------------------------------------------------>
	    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

	        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
	        cfErrorMsg(this);

	        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

	    </Script>

	    <!-----------------------------------------------------------------+
	    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
	    +------------------------------------------------------------------>
	    <Script For=dsT_WL_CONDOLOT Event="OnDataError()">

	        //Dataset관련 Error 처리
	        cfErrorMsg(this);

	    </Script>

	    <!-----------------------------+
	    | Transaction Successful 처리  |
	    +------------------------------>
	    <script for=trT_WL_CONDOLOT event="OnSuccess()">
			fnc_SearchList();
	        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
	    </script>

	    <!--------------------------+
	    | Transaction Failure 처리  |
	    +--------------------------->
	    <script for=trT_WL_CONDOLOT event="OnFail()">
	        cfErrorMsg(this);
	    </script>

	    <!--------------------------+
	    | grid에서 row를 클릭했을때 |
	    +------ -------------------->
		<script for=grdT_WL_CONDOLOT event=OnClick(Row,Colid)>

			if(Row < 1 || !grdT_WL_CONDOLOT.Editable) {
				return;
			} else {
				if(Colid == 'APP_YN'){

	                if(dsT_WL_CONDOLOT.Namevalue(Row, 'APP_YN') != "F") {
	    				for(i=1;i<dsT_WL_CONDOLOT.CountRow+1;i++){
	    					if(i != Row){
	    						dsT_WL_CONDOLOT.Namevalue(i, 'APP_YN') = 'F';
	    					}
	    				}
	                }

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
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">성수기콘도신청</td>
						<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">성수기콘도신청</font></td>
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
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" class="greenTable">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<colgroup>
										<col width="120"></col>
										<col width="*"></col>
									</colgroup>
								<tr>
									<td align="center" class="searchState">성수기관리번호</td>
									<td class="padding2423">
	                                    <select id="cmbORD_NO_SHR" name="cmbORD_NO_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
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
							<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
								<param name="DataID"					value="dsT_WL_CONDOLOT">
								<param name="Format"					value="
									<C> id={currow}	   width=39   name='NO'				align=center	edit=none </C>
									<C> id='ORD_NO'	   width=90   name='성수기관리번호'	align=center	edit=none  </C>
									<C> id='STR_YMD'   width=80   name='이용시작일'		align=center	edit=none  </C>
									<C> id='CN_NM'	   width=80	  name='콘도'			align=left leftmargin=10	edit=none  </C>
									<C> id='CO_NM'	   width=220  name='지역'			align=left leftmargin=10	edit=none  </C>
									<C> id='ROOM_CNT'  width=55	  name='객실수'			align=right rightmargin=10	edit=none  </C>
									<C> id='STAY_CNT'  width=60	  name='이용일수'		align=right rightmargin=10	edit=none  </C>
									<C> id='APP_CNT'   width=80	  name='현재신청자수'	align=right rightmargin=10	edit=none  </C>
									<C> id='APP_YN'	   width=60	  name='신청여부'		align=center  EditStyle=CheckBox </C>
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