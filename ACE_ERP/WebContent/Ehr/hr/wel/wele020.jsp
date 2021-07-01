	<!--*************************************************************************
	* @source      : wele020.jsp												*
	* @description : 기간별식대비용계산 PAGE										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/22            채갑병         	        최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>기간별식대비용계산(wele020)</title>
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
			//식당이용기록 정보 조회
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            
            if(STR_YMD_SHR == "") {
                alert("시작년월을 입력해 주세요.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }
            if(END_YMD_SHR == "") {
                alert("종료년월을 입력해 주세요.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return;
            }

			dsT_WL_DININGUSE.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.e.wele020.cmd.WELE020CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR;
			dsT_WL_DININGUSE.reset();
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
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
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
  			document.getElementById("resultMessage").innerText = ' ';

        	dsT_WL_DININGUSE.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_WL_DININGUSE.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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
	        //이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            var vDATE = new Date(getTodayArray()[0], getTodayArray()[1]-1, getTodayArray()[2]);
            vDATE.setMonth(vDATE.getMonth() -1);
            
            var vSTR_YMD = vDATE.getYear()+"-"+lpad((vDATE.getMonth()+1), 2, "0")+"-16";
            var vEND_YMD = getTodayArray()[0]+"-"+getTodayArray()[1]+"-15";
            
            document.getElementById("txtSTR_YMD_SHR").value = vSTR_YMD;
            document.getElementById("txtEND_YMD_SHR").value = vEND_YMD;
            document.getElementById('txtSTR_YMD_SHR').focus();
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

  		/********************************************
         * 기간시작일 필드에서 포커스 떠날때 시작일(검색)		*
         ********************************************/
        function setStdYmd(stObj){
        	var str_ymd = document.getElementById(stObj).value;
        	if( str_ymd.length > 8 ){
        		document.getElementById(stObj).value = str_ymd.substr(0,7)+"-16";
        	}
        }


  		/********************************************
         * 기간종료일 필드에서 포커스 떠날때 종료일 매핑(검색)	*
         ********************************************/
        function setEndYmd2(enObj){
           	var end_ymd = document.getElementById(enObj).value;
           	if( end_ymd.length > 8 ){
           		document.getElementById(enObj).value = end_ymd.substr(0,7)+"-15";
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
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_DININGUSE)			 	   |
    | 3. 사용되는 Table List(T_WL_DININGUSE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_DININGUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WL_DININGUSE)			   |
    | 3. 사용되는 Table List(T_WL_DININGUSE)				   |
    +------------------------------------------------------>
	<Object ID="trT_WL_DININGUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_DININGUSE=dsT_WL_DININGUSE,I:dsT_WL_DININGUSE=dsT_WL_DININGUSE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
            document.getElementById("resultMessage").value = "자료가 조회 되었습니다!";
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_DININGUSE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_DININGUSE event="OnFail()">
        alert(trT_WL_DININGUSE.ErrorMsg);
    </script>
    
    
    <script language=JavaScript for=medMRN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medMRN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtMRN_CNT").value);
        document.getElementById("medMRN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
    </script>
    <script language=JavaScript for=medAFN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medAFN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtAFN_CNT").value);
        document.getElementById("medAFN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
    </script>
    <script language=JavaScript for=medEVN_UNI event=onKeyUp(kcode,scode)>
        var uni = parseInt(document.getElementById("medEVN_UNI").Text);
        var cnt = parseInt(document.getElementById("txtEVN_CNT").value);
        document.getElementById("medEVN_AMT").Text = uni*cnt;
        
        
        var mrn = parseInt(document.getElementById("medMRN_AMT").Text);
        var afn = parseInt(document.getElementById("medAFN_AMT").Text);
        var evn = parseInt(document.getElementById("medEVN_AMT").Text);
        document.getElementById("medTOT_AMT").Text = mrn+afn+evn;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기간별식대비용계산</td>
					<td align="right" class="navigator">HOME/복리후생/식당코드/<font color="#000000">기간별식대비용계산</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">조회기간</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);setStdYmd('txtSTR_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','117');"></a>
								~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);setEndYmd2('txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','117');"></a>
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
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="200"></col>
							<col width="200"></col>
							<col width="170"></col>
							<col width="200"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold" colspan="2">&nbsp;</td>
							<td align="center" class="creamBold" colspan="2">일&nbsp;&nbsp;&nbsp;&nbsp;반&nbsp;&nbsp;&nbsp;&nbsp;비</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
							<td align="center" class="creamBold">단&nbsp;&nbsp;&nbsp;&nbsp;가</td>
							<td align="center" class="creamBold">건&nbsp;&nbsp;&nbsp;&nbsp;수</td>
							<td align="center" class="creamBold">금&nbsp;&nbsp;&nbsp;&nbsp;액</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">조&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;식</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medMRN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtMRN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medMRN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">중&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;식</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medAFN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtAFN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medAFN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold">석&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;식</td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medEVN_UNI" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=5>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
							<td class="padding2423" align="center"><input id="txtEVN_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medEVN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class="padding2423" align="center" class="creamBold" colspan="2">총&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계</td>
							<td class="padding2423" align="center"><input id="txtTOT_CNT" size="7"  maxlength="2" style="ime-mode:disabled;text-align:right" class="input_ReadOnly" readonly></td>
							<td class="padding2423" align="center">
							<table width="100%" border="0" >
								<tr>
									<td width="90%">
										<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" enable="false" class="input_ReadOnly">
											<param name=Alignment				value=2>
											<param name=Border					value=true>
											<param name=ClipMode				value=true>
											<param name=DisabledBackColor		value="#EEEEEE">
											<param name=Enable					value=true>
											<param name=IsComma					value=true>
											<param name=Language				value=0>
											<param name=MaxLength				value=10>
											<param name=Numeric					value=true>
											<param name=NumericRange			value=0~+:0>
											<param name=ShowLiteral				value=false>
											<param name=Visible					value=true>
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
									</td>
									<td align="left">원</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_WL_DININGUSE 설정 테이블 -->
	<object id="bndT_WL_DININGUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_DININGUSE">
		<Param Name="BindInfo", Value="
			<C>Col=MRN_CNT		Ctrl=txtMRN_CNT		Param=value</C>
			<C>Col=MRN_AMT		Ctrl=medMRN_AMT		Param=Text</C>
			<C>Col=MRN_UNI		Ctrl=medMRN_UNI		Param=Text</C>
			<C>Col=AFN_CNT		Ctrl=txtAFN_CNT		Param=value</C>
			<C>Col=AFN_AMT		Ctrl=medAFN_AMT		Param=Text</C>
			<C>Col=AFN_UNI		Ctrl=medAFN_UNI		Param=Text</C>
			<C>Col=EVN_CNT		Ctrl=txtEVN_CNT		Param=value</C>
			<C>Col=EVN_AMT		Ctrl=medEVN_AMT		Param=Text</C>
			<C>Col=EVN_UNI		Ctrl=medEVN_UNI		Param=Text</C>
			<C>Col=TOT_CNT		Ctrl=txtTOT_CNT		Param=value</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=Text</C>
			<C>Col=TOT_UNI		Ctrl=medTOT_UNI		Param=Text</C>
		">
	</object>