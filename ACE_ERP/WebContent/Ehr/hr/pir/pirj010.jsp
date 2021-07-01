	<!--*************************************************************************
	* @source      : pirj010.jsp												*
	* @description : 재직인원현황 PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/09            채갑병            	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>재직인원현황(pirj010)</title>
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

		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR = document.getElementById("cmbGBN_CD_SHR").value;

			DPT_CD_SHR = (DPT_CD_SHR == null) ? "%" : DPT_CD_SHR;

			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.j.pirj010.cmd.PIRJ010CMD&S_MODE=SHR&DPT_CD_SHR="+DPT_CD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
			trVI_T_CM_PERSON.KeyValue = "SHR"
                                      + "(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON"
                                      + ",O:dsT_CM_COMMON=dsT_CM_COMMON)";
			trVI_T_CM_PERSON.post();

            document.getElementById("txtTOT_INFO").style.backgroundColor = "#F2FDD1";

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
        	alert("서비스 준비중입니다.");
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("재직인원현황", '', 225)
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

        	document.form1.txtDPT_CD_SHR.value = "";
        	document.form1.txtDPT_NM_SHR.value = "";
        	document.getElementById("txtTOT_CNT").innerText   = ' ';
        	document.form1.txtTOT_INFO.value   = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsVI_T_CM_PERSON.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
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

            // 근로구분 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style 적용
            document.getElementById("txtTOT_INFO").style.display = "none";

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
    | 1. 조회용 DataSet									   |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsVI_T_CM_PERSON)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 구분 -->
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
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
        }

            //   alert(dsVI_T_CM_PERSON.ExportData(1,dsVI_T_CM_PERSON.CountRow,true));
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
		if(dsVI_T_CM_PERSON.CountRow >= 1){
       //     document.getElementById("txtTOT_CNT").innerText = dsT_CM_COMMON.NameSum("CNT", 0, 0)+" 명";

          document.getElementById("txtTOT_CNT").innerText = dsT_CM_COMMON.NameSum("CNT", 0, 0)+" 명"
                               + '  ( 남: ' +  dsT_CM_COMMON.NameSum("MF_CNT", 0, 0) + ' 명'
                               + ' / 여: '  +  (dsT_CM_COMMON.NameSum("CNT", 0, 0)-dsT_CM_COMMON.NameSum("MF_CNT", 0, 0)) + ' 명 )';

            var info = "";
            for(var i=1; i<=dsT_CM_COMMON.CountRow; i++) {
                info += "     " + dsT_CM_COMMON.NameValue(i, "INFO")+"\t";
                if(i%6 == 0) info += "\n";

            }
	        document.getElementById("txtTOT_INFO").style.display = "";
            document.getElementById("txtTOT_INFO").rows = Math.ceil(i/6);
    		document.form1.txtTOT_INFO.value = info; // 총원 상세

		}

		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">재직인원현황</td>
					<td align="right" class="navigator">HOME/인사관리/인원정보/<font color="#000000">재직인원현황</font></td>
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
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
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
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>
					<col width="150"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">소속</td>
					<td class="padding2423">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onfocusout="fnc_GetCommNm('A4', 'txtDPT_CD_SHR', 'txtDPT_NM_SHR')" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
							<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
						</a>
					</td>
					<td class="searchState" align="right">근로구분별</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 75%">
							<option value="0">모두</option>
						</select>
					</td>
					<td class="searchState" align="right">근무구분</td>
					<td class="padding2423" align="left">
						<select id="cmbGBN_CD_SHR" style="WIDTH: 60%">
							<option value="0">모두</option>
							<option value="1">본사</option>
							<option value="2">IT실</option>
							<option value="3">대외사업</option>
							<option value="4">해외</option>
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{curow}"	width=29	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="DPT_NM"		width=110	name="소속"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"		width=70	name="직위"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HOB_NM"		width=60	name="호봉"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NO"		width=70	name="사번"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NM"		width=60	name="성명"		align=center	Edit=none	 </C>
							<C> id="CET_NO"		width=100	name="주민번호"	align=center	Edit=none	 </C>
							<C> id="HIR_YMD"	width=90	name="입사일"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="JPR_YMD"	width=90	name="승진일"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE"		width=60	name="나이"			align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE_GG"		width=60	name="구간"			align=center	Edit=none	 RightMargin="10"</C>
							<C> id="EM_PHN_NO"	width=100	name="핸드폰"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_CD"	width=60	name="학력코드"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_NM"	width=100	name="학력구분"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_CD"		width=60	name="학교코드"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_NM"		width=100	name="학교명"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_CD"		width=60	name="학과코드"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_NM"		width=100	name="학과명"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_CD"		width=60	name="졸업코드"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_NM"		width=60	name="졸업구분"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SEX"		width=60	name="성별"		   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HIRG_YMD"	width=90	name="그룹입사일"		   align=left		Edit=none	 RightMargin="10"</C>
							<C> id="REMARK"		width=120	name="담당업무"		   align=left		Edit=none	 RightMargin="10"</C>
							<C> id="REG_NM"		width=120	name="근무지역"		   align=left		Edit=none	 RightMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="paddingTop8">
    			<table border="0" cellspacing="0" cellpadding="0" width="100%">
        			<tr>
        				<td align="left" width="80"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">&nbsp;총&nbsp;&nbsp;원&nbsp;:&nbsp;&nbsp;</td>
        				<td align="left" width="720" id="txtTOT_CNT"></td>
        			</tr>
                    <tr>
                        <td colspan="2"><textarea rows="1" id="txtTOT_INFO" class="input_ReadOnly" readonly style="width:100%;"></textarea></td>

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

