	<!--*************************************************************************
	* @source      : scha080.jsp												*
	* @description : 기간별 학자금지급현황 PAGE	 								*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27      오대성          최초작성									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>기간별 학자금지급현황(scha080)</title>
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

		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var occ_cd = document.getElementById("cmbOCC_CD_SHR").value;
			var sort_gbn = document.getElementById("cmbSORT_GBN_SHR").value;

            var oGRD    = document.getElementById("grdT_SC_SCHLBOOK");

            if      (sort_gbn == "1") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:JOB_NM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "1";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "";
            }
            else if (sort_gbn == "2") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:GUBUN_NM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "1";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "";
            }
            else if (sort_gbn == "3") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:PIS_YM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "1";
            }

            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;

            var STR_YMD2 = document.getElementById("txtSTR_YMD_SHR2").value;
            var END_YMD2 = document.getElementById("txtEND_YMD_SHR2").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha080.cmd.SCHA080CMD"
                                   + "&S_MODE=SHR"
                                   + "&OCC_CD="+occ_cd
                                   + "&SORT_GBN="+sort_gbn
                                   + "&STR_YMD="+STR_YMD
                                   + "&END_YMD="+END_YMD
                                   + "&STR_YMD2="+STR_YMD2
                                   + "&END_YMD2="+END_YMD2;
			dsT_SC_SCHLBOOK.reset();
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
			if(!fnc_SearchItemCheck()) return;

			//학자금 신청서 처리 조회
			var occ_cd = document.getElementById("cmbOCC_CD_SHR").value;
			var sort_gbn = document.getElementById("cmbSORT_GBN_SHR").value;

	        var url = "scha080_PV.jsp?OCC_CD="+occ_cd+"&STR_YM="+str_ym+"&END_YM="+end_ym+"&SORTGBN="+sort_gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SC_SCHLBOOK.GridToExcel("기간별학자금지급현황", '', 225);
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
        	// 초기화
			document.getElementById("cmbOCC_CD_SHR").value = "A";
            document.getElementById("cmbSORT_GBN_SHR").value = "1";
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_SC_SCHLBOOK.ClearData();
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


			return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   *
         ********************************************/
        function fnc_OnLoadProcess() {

			//근로구분
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);

            }

            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

			cfStyleGrid(form1.grdT_SC_SCHLBOOK,0,"false","false");      // Grid Style 적용
			document.getElementById('cmbOCC_CD_SHR').focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_SC_SCHLBOOK)		   |
    | 3. 사용되는 Table List(T_SC_SCHLBOOK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload"        Value="True">
		<Param Name="UseChangeInfo"   Value="True">
		<Param Name="ViewDeletedRow"  Value="False">
	</Object>

	<!-- 공통 콤보를 위한 DataSet -->
    <!-- 근로구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.RealCount(1, dsT_SC_SCHLBOOK.CountRow));
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!---------------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">기간별 학자금지급현황</td>
					<td align="right" class="navigator">HOME/복리후생/학자금지원/<font color="#000000">기간별 학자금지급현황</font></td>
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
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="220"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
                        <tr>
                            <td class="searchState" align="right">신청일자</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','110');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','110');"></a>
                            </td>
                            <td class="searchState" align="right">지급일자</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR2','','103','110');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR2','','218','110');"></a>
                            </td>
                        </tr>
						<tr>
							<td align="center" class="searchState">근로구분&nbsp;</td>
							<td class="padding2423">
								<select id="cmbOCC_CD_SHR" style="WIDTH:80px" onChange="fnc_SearchList();">
								                        <option value="">전체</option>
								</select>
							</td>
                            <td align="center" class="searchState">정렬기준&nbsp;</td>
							<td class="padding2423">
                                <select id="cmbSORT_GBN_SHR" style="width:80px" onChange="fnc_SearchList();">
                                    <option value="1">직급별</option>
                                    <option value="2">학교별</option>
                                    <option value="3">기간별</option>
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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="PIS_QQ"	    width="40"	name="분기"			align="center"	Edit=none subsumtext=""</C>
                            <C> id="IPT_YMD"	width="80"	name="신청일자"		align="center"	Edit=none</C>
                            <C> id="PAY_YMD"	width="80"	name="지급일자"		align="center"	Edit=none</C>

							<C> id="ENO_NO"		width="60"	name="사번"			align="center" </C>
							<C> id="ENO_NM"		width="60"	name="성명"			align="left" </C>
							<C> id="DPT_NM"		width="110"	name="소속"			align="left"   </C>
							<C> id="JOB_NM"		width="70"	name="직위"			align="center"   </C>
							<C> id="HIR_YMD"	width="70"	name="입사일"	    align="center" </C>
							<C> id="SEL_NM"		width="50"	name="대상자"	    align="left" </C>
							<C> id="GUBUN_NM"	width="65"	name="학력구분"		align="center" </C>
							<C> id="FSCH_NM"	width="65"	name="학년구분"		align="center" </C>
							<C> id="RET_AMT"	width="65"	name="입학금"	    align="right" </C>
							<C> id="EDU_AMT"	width="65"	name="수업료"	    align="right" </C>
							<C> id="END_AMT"	width="65"	name="학생회비"		align="right" </C>
							<C> id="OTH_AMT"	width="65"	name="기타"			align="right" </C>
							<C> id="TOT_AMT"	width="65"	name="합계"			align="right" </C>
							<C> id="PAY_AMT"	width="65"	name="지급금액"		align="right" </C>
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
