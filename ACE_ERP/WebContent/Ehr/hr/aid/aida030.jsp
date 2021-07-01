	<!--*************************************************************************
	* @source      : aida030.jsp												*
	* @description : 경공조금 지급현황 PAGE	 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/13            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>경공조금 지급현황(aida030)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = getToday().substring(0,4);
		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			//경공조금 지급현황 조회
			var SPL_YMD_STDT_SHR = document.form1.txtSPL_YMD_STDT_SHR.value;
			var SPL_YMD_ENDT_SHR = document.form1.txtSPL_YMD_ENDT_SHR.value;

			var JOB_CD_SHR       = document.form1.txtJOB_CD_SHR.value;
			var DPT_CD_SHR       = document.form1.txtDPT_CD_SHR.value;
			var AID_CD_SHR       = document.form1.txtAID_CD_SHR.value;

			var CEF_SEC_SHR      = document.getElementById("cmbCEF_SEC_SHR").value;
			var OCC_CD_SHR       = document.getElementById("cmbOCC_CD_SHR").value;

            var ORDER_TYPE          = fnc_GetCheckedValue("radORDER_TYPE");

			dsT_AD_AIDAPP.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida030.cmd.AIDA030CMD&S_MODE=SHR&SPL_YMD_STDT_SHR="+SPL_YMD_STDT_SHR+"&SPL_YMD_ENDT_SHR="+SPL_YMD_ENDT_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&AID_CD_SHR="+AID_CD_SHR+"&ORDER_TYPE="+ORDER_TYPE;
			dsT_AD_AIDAPP.reset();
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
			//경공조금 지급현황 조회
			var SPL_YMD_STDT_SHR = document.form1.txtSPL_YMD_STDT_SHR.value;
			var SPL_YMD_ENDT_SHR = document.form1.txtSPL_YMD_ENDT_SHR.value;

			var JOB_CD_SHR  = document.form1.txtJOB_CD_SHR.value;
			var DPT_CD_SHR  = document.form1.txtDPT_CD_SHR.value;
			var AID_CD_SHR  = document.form1.txtAID_CD_SHR.value;

			var CEF_SEC_SHR = document.getElementById("cmbCEF_SEC_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

			var ORDER_TYPE          = fnc_GetCheckedValue("radORDER_TYPE");


            //var url = "aida030_PV.jsp?SPL_YMD_STDT_SHR="+SPL_YMD_STDT_SHR+"&SPL_YMD_ENDT_SHR="+SPL_YMD_ENDT_SHR+"&CEF_SEC_SHR="+CEF_SEC_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&AID_CD_SHR="+AID_CD_SHR;
            var hnwparm = "[:SPL_YMD_STDT_SHR]="+SPL_YMD_STDT_SHR+"[:SPL_YMD_ENDT_SHR]="+SPL_YMD_ENDT_SHR+"[:CEF_SEC_SHR]="+CEF_SEC_SHR+"[:OCC_CD_SHR]="+OCC_CD_SHR+"[:JOB_CD_SHR]="+JOB_CD_SHR+"[:DPT_CD_SHR]="+DPT_CD_SHR+"[:AID_CD_SHR]="+AID_CD_SHR+"[:ORDER_TYPE]="+ORDER_TYPE;

            document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");

            //window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AD_AIDAPP.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AD_AIDAPP.GridToExcel("경공조금 지급현황", '', 225)
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
        	// 초기화
			document.form1.txtAID_CD_SHR.value = "";
			document.form1.txtAID_NM_SHR.value = "";
			document.form1.txtDPT_CD_SHR.value = "";
			document.form1.txtDPT_NM_SHR.value = "";
			document.form1.txtJOB_CD_SHR.value = "";
			document.form1.txtJOB_NM_SHR.value = "";

        	document.form1.cmbCEF_SEC_SHR.selectedIndex = 0;
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_AD_AIDAPP.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AD_AIDAPP.IsUpdated)  {
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
            // 경공조금 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_R2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_R2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_R2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCEF_SEC_SHR").add(oOption);
			}

            // 직종 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

            document.getElementById('txtSPL_YMD_STDT_SHR').value = getStrDate();
            document.getElementById('txtSPL_YMD_ENDT_SHR').value = getToday();

			cfStyleGrid(form1.grdT_AD_AIDAPP,0,"true","false");      // Grid Style 적용

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
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDAPP)			   |
    | 3. 사용되는 Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDAPP)			   |
    | 3. 사용되는 Table List(T_AD_AIDAPP)				   |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP,I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 경공조금 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R2"/>
       <jsp:param name="CODE_GUBUN"    value="R2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직종 구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자3434료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   						   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_AD_AIDAPP event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {
            var url = "/hr/aid/aida011.jsp?REQ_NO="+dsT_AD_AIDAPP.NameString(row, "REQ_NO")+"&TYPE=TYPE3";
			cfWinOpen(url,"경공조",870,500)
			fnc_SearchList();
		}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">경공조금 지급현황</td>
					<td align="right" class="navigator">HOME/복리후생/경공조금/<font color="#000000">경공조금 지급현황</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="70"></col>
							<col width="290"></col>
							<col width="70"></col>
							<col width="290"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">지급일</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSPL_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSPL_YMD_STDT_SHR','','107','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtSPL_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSPL_YMD_ENDT_SHR','','222','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">직종별</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="0">
								<select id="cmbOCC_CD_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()">
									<option value="0">모두</option>
								</select>
							</td>
						</tr>






						<tr>
							<td class="searchState" rowspan="4" align="right">조회조건</td>
							<td class="padding2423" rowspan="4" align="left">
								<select id="cmbCEF_SEC_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()">
									<option value="0">모두</option>
								</select>
							</td>
						</tr>


						<tr>
							<td class="searchState" align="right">직위별</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="1">
								<input id="txtJOB_CD_SHR" style="width:10%" maxlength="2"> <input id="txtJOB_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">소속별</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="2">
								<input id="txtDPT_CD_SHR" style="width:10%" maxlength="2"> <input id="txtDPT_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
							</td>
						</tr>
						<tr>
							<td class="searchState" align="right">신청내용별</td>
							<td class="padding2423" align="left">
                                <input type="radio" name="radORDER_TYPE" value="3">
								<input id="txtAID_CD_SHR" style="width:10%" maxlength="2"> <input id="txtAID_NM_SHR" style="width:30%" class="input_ReadOnly"  readonly>
		                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAidCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAidCd" name="ImgAidCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtAID_CD_SHR','txtAID_NM_SHR','신청내용','R1')"></a>
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
					<object id="grdT_AD_AIDAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AD_AIDAPP">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=57	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=80	name="신청번호"		align=center	Edit=none	show=false</C>
							<C> id="OCC_NM"		width=60	name="직종"			align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A1:CODE:CODE_NAME"</C>
							<C> id="DPT_NM"		width=100	name="부서"			align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A4:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="JOB_NM"		width=60	name="직위"			align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="ENO_NM"		width=80	name="성명"			align=center	Edit=none</C>
							<C> id="AID_NM"		width=100	name="신청내용"		align=left		Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R1:CODE:CODE_NAME"	LeftMargin=10</C>
							<C> id="AID_YMD"	width=80	name="발생일자"		align=center	Edit=none</C>
							<C> id="HLP1_AMT"	width=80	name="공조금"		align=right		Edit=none	RightMargin=10</C>
							<C> id="HLP2_AMT"	width=80	name="경조금"		align=right		Edit=none	RightMargin=10</C>
							<C> id="SPL_YMD"	width=80	name="지급일자"		align=center	Edit=none</C>
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
<comment id="__HNWID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="aida030.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__HNWID__); </script>
	</form>
	<!-- form 끝 -->

</body>
</html>

