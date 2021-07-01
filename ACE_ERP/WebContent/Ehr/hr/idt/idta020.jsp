	<!--*************************************************************************
	* @source      : idta020.jsp												*
	* @description : 증명서발급현황 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/17            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>증명서발급현황(idta020)</title>
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

		var btnList = 'TFFTTTFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var CEF_RSN_SHR = document.getElementById("cmbCEF_RSN_SHR").value;
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // 사번

			var HIR_NM  = "";  	var RET_NM  = "";  	var EXP_NM  = "";	var CAR_NM  = "";

        	if( document.form1.chkHIR_NM.checked ){
        		HIR_NM = "01";
        	}
        	if( document.form1.chkEXP_NM.checked ){
        		EXP_NM = "02";
        	}
        	if( document.form1.chkRET_NM.checked ){
        		RET_NM = "03";
        	}
        	if( document.form1.chkCAR_NM.checked ){
        		CAR_NM = "04";
        	}

			dsT_ID_CEFBOOK.DataId = "/servlet/GauceChannelSVL?cmd=hr.idt.a.idta020.cmd.IDTA020CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&CEF_RSN_SHR="+CEF_RSN_SHR+"&HIR_NM="+HIR_NM+"&RET_NM="+RET_NM+"&EXP_NM="+EXP_NM+"&CAR_NM="+CAR_NM;
			dsT_ID_CEFBOOK.reset();

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
  			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var CEF_RSN_SHR = document.getElementById("cmbCEF_RSN_SHR").value;
 			var HIR_NM  = "";  	var RET_NM  = "";  	var EXP_NM  = "";	var CAR_NM  = "";


        	if ( STR_YMD_SHR == ""|| END_YMD_SHR == "" ) {
                alert("인쇄하실 내용이 없습니다.");
            }
            else {
	         	if( document.form1.chkHIR_NM.checked ){
	        		HIR_NM = "01";
	        	}
	        	if( document.form1.chkEXP_NM.checked ){
	        		EXP_NM = "02";
	        	}
	        	if( document.form1.chkRET_NM.checked ){
	        		RET_NM = "03";
	        	}
	        	if( document.form1.chkCAR_NM.checked ){
	        		CAR_NM = "04";
	        	}

                var url = "idta020_PV.jsp?STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&CEF_RSN_SHR="+CEF_RSN_SHR+"&HIR_NM="+HIR_NM+"&RET_NM="+RET_NM+"&EXP_NM="+EXP_NM+"&CAR_NM="+CAR_NM;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                return;
            }
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_ID_CEFBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ID_CEFBOOK.GridToExcel("증명서발급현황", '', 225)
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

        	//document.form1.txtSTR_YMD_SHR.value = "";
        	//document.form1.txtEND_YMD_SHR.value = "";
        	document.form1.cmbCEF_RSN_SHR.selectedIndex  = 0;
        	document.form1.chkHIR_NM.checked = true;
        	document.form1.chkRET_NM.checked = true;
        	document.form1.chkEXP_NM.checked = true;
        	document.form1.chkCAR_NM.checked = true;

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";

        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_ID_CEFBOOK.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_ID_CEFBOOK.IsUpdated)  {
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

            // 용도 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_R4.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_R4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_R4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_RSN_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdT_ID_CEFBOOK,0,"true","false");      // Grid Style 적용

            //날짜값들 바인딩
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1]+"-"+"01";
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1]+"-"+toDays[2];
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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_ID_CEFBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">

	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_ID_CEFBOOK)			   |
    | 3. 사용되는 Table List(T_ID_CEFBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_ID_CEFBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsT_ID_CEFBOOK)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 용도 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R4"/>
       <jsp:param name="CODE_GUBUN"    value="R4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_ID_CEFBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_ID_CEFBOOK Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnSuccess()">
		// 트랜젝션을 이용한 조회이므로  "**건의 자료가 조회되었습니다."  표시
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_ID_CEFBOOK.CountRow/2-1);
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_ID_CEFBOOK event="OnFail()">
        alert(trT_ID_CEFBOOK.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">증명서발급현황</td>
					<td align="right" class="navigator">HOME/업무관리/증명서발급관리/<font color="#000000">증명서발급현황</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="180"></col>
					<col width="70"></col>
					<col width="120"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">조회기간</td>
					<td class="padding2423" align="left" colspan="3">
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','55','110');"></a> ~
						<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"></a>
					</td>
					<td class="searchState" align="right" rowspan="2">종&nbsp;&nbsp;류</td>
					<td class="padding2423" align="left" rowspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left"><input type="checkbox" id="chkHIR_NM" style="border:0" align="absmiddle" checked>재직증명서</td>
								<td align="left"><input type="checkbox" id="chkEXP_NM" style="border:0" align="absmiddle" checked>경력증명서</td>
							</tr>
							<tr>
								<td align="left"><input type="checkbox" id="chkRET_NM" style="border:0" align="absmiddle" checked>퇴직증명서</td>
								<td align="left"><input type="checkbox" id="chkCAR_NM" style="border:0" align="absmiddle" checked>출입국증명서</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="searchState" align="right">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR','','','','','2');"></a>
                    </td>
					<td class="searchState" align="right">용&nbsp;&nbsp;도</td>
					<td class="padding2423" align="left">
						<select id="cmbCEF_RSN_SHR" style="WIDTH: 95%" onChange="fnc_SearchList()">
							<option value="0">모두</option>
						</select>
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
					<object id="grdT_ID_CEFBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_ID_CEFBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
							<C> id="CEF_NO"		width=70	name="발급번호"		align=center	Edit=none	 </C>
							<C> id="DPT_NM"		width=120	name="부서"			align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"		width=60	name="직위"			align=center	Edit=none	 </C>
							<C> id="ENO_NO"		width=60	name="사번"			align=center	Edit=none	 </C>
							<C> id="ENO_NM"		width=60	name="성명"			align=center	Edit=none	 </C>
							<C> id="CEF_SEC"	width=130	name="증명서종류"		align=center	Edit=none	 </C>
							<C> id="CEF_RSN"	width=130	name="용도"			align=center	Edit=none	 </C>
							<C> id="CEF_CNT"	width=40	name="매수"			align=center	Edit=none	 </C>
							<C> id="SPL_YMD"	width=80	name="발급일"			align=center	Edit=none	 </C>
						'>
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

