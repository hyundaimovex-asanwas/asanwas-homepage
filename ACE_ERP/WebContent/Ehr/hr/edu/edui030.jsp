	<!--*************************************************************************
	* @source      : edui030.jsp												*
	* @description : 교육 대상자 현황                       					*
	* @source      : edui030.jsp												*
	* @description : 교육 대상자 현황					                        *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/04            채갑병            	최초작성                        *
	* 2007/05/10            김학수            	수정                            *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>교육 대상자 현황(edui030)</title>
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
		var today = getToday();


		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
            // 기준일자 입력 필수
            if( document.form1.txtJPR_YMD_SHR.value=="" ){
                alert("기준일자를 입력하십시오. 예)"+today);
                return;
            }

            var JPR_YMD_SHR = document.getElementById("txtJPR_YMD_SHR").value;
            var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

            var EDU_CD_SHR  = document.getElementById("txtEDU_CD_SHR").value;
            var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
            var JOB_CD_SHR  = document.getElementById("txtJOB_CD_SHR").value;

            dsT_CM_EDUCATION.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.i.edui030.cmd.EDUI030CMD"
                                    + "&S_MODE=SHR"
                                    + "&JPR_YMD_SHR="+JPR_YMD_SHR
                                    + "&OCC_CD_SHR="+OCC_CD_SHR
                                    + "&DPT_CD_SHR="+DPT_CD_SHR
                                    + "&EDU_CD_SHR="+EDU_CD_SHR
                                    + "&JOB_CD_SHR="+JOB_CD_SHR;
            dsT_CM_EDUCATION.Reset();
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

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_EDUCATION.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("교육대상자현황관리", '', 225);
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
            document.form1.cmbOCC_CD_SHR.selectedIndex      = 0;
            document.getElementById("txtDPT_CD_SHR").value  = "";
            document.getElementById("txtDPT_NM_SHR").value  = "";
            document.getElementById("txtEDU_CD_SHR").value  = "";
            document.getElementById("txtEDU_NM_SHR").value  = "";
            document.getElementById("txtJOB_CD_SHR").value  = "";
            document.getElementById("txtJOB_NM_SHR").value  = "";
            document.getElementById("txtJPR_YMD_SHR").value = today;

            document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_EDUCATION.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CM_EDUCATION.IsUpdated)  {
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

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_EDUCATION,0,"false","false");

            // 근로구분 구분 검색 콤보박스 생성
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

			document.form1.txtJPR_YMD_SHR.value = today;

            document.form1.txtJOB_CD_SHR.readOnly = true;
            document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
            document.form1.txtDPT_CD_SHR.readOnly = false;
            document.form1.txtDPT_CD_SHR.className = "";

            document.form1.txtJOB_CD_SHR.value = "";
            document.form1.txtJOB_NM_SHR.value = "";
            document.getElementById("Image20").disabled = true;
            document.getElementById("Image21").disabled = false;
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
         * 직위/부서 선택에 따른 입력 구분                 			*
         ********************************************/
        function changeInput() {
        	if( document.form1.rdoJOBDPT_SHR[0].checked ){
        		document.form1.txtJOB_CD_SHR.readOnly = true;
        		document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
        		document.form1.txtDPT_CD_SHR.readOnly = false;
        		document.form1.txtDPT_CD_SHR.className = "";

        		document.form1.txtJOB_CD_SHR.value = "";
        		document.form1.txtJOB_NM_SHR.value = "";
        		document.getElementById("Image20").disabled = true;
        		document.getElementById("Image21").disabled = false;

        	}else{
                document.form1.txtJOB_CD_SHR.readOnly = false;
        		document.form1.txtJOB_CD_SHR.className = "";
        		document.form1.txtDPT_CD_SHR.readOnly = true;
        		document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";

        		document.form1.txtDPT_CD_SHR.value = "";
        		document.form1.txtDPT_NM_SHR.value = "";
        		document.getElementById("Image20").disabled = false;
        		document.getElementById("Image21").disabled = true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EDUCATION)			   |
    | 3. 사용되는 Table List(T_CM_EDUCATION) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
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
	<Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_EDUCATION.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CM_EDUCATION Event="OnDataError()">
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
				<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">교육 대상자 현황</td>
				<td align="right" class="navigator">HOME/교육관리/현황/<font color="#000000">교육 대상자 현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="greenTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
				<td class="searchState" align="right" width="100">근로구분구분</td>
				<td class="padding2423" align="left" width="300">
					<select id="cmbOCC_CD_SHR" name="cmbOCC_CD_SHR" style="WIDTH: 20%" onChange="fnc_SearchList()">
						<option value="">모두</option>
					</select>
				</td>
                <td align="right" class="searchState"><input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" checked style="margin-bottom:-2px;border:0;"   onClick="changeInput()">소속별</td>
                <td class="padding2423" align="left">
                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6">
                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
                    </a>
                </td>
            </tr>
            <tr>
				<td class="searchState" align="right">교육과정</td>
                <td class="padding2423">
                    <input id="txtEDU_CD_SHR" name="txtEDU_CD_SHR" size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                    <input id="txtEDU_NM_SHR" name="txtEDU_NM_SHR" size="20" class="input_ReadOnly"  readOnly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd1','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEduCd1" name="ImgEduCd1" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');">
                    </a>
                </td>
                <td align="right" class="searchState"><input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" style="margin-bottom:-2px;border:0;"  onClick="changeInput()">직위별</td>
                <td class="padding2423" align="left">
                    <input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="6"  maxlength="6">
                    <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)">
                        <img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','직위','A2')">
                    </a>
                </td>
            </tr>
			<tr>
				<td class="searchState" align="right">기준일자</td>
				<td class="padding2423" align="left" colspan="3">
					<input type="text" id="txtJPR_YMD_SHR" name="txtJPR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJPR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgJPR_YMD_SHR" name="imgJPR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtJPR_YMD_SHR','','134','108');"></a>
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


<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'       width=30        name='순번'       align=center </C>
                                <C> id='DPT_NM'         width='100'     name='소속'       align='center' </C>
                                <C> id='JOB_NM'         width='60'      name='직위'       align='center' </C>
                                <C> id='ENO_NM'         width='60'      name='이름'       align='center' </C>
                                <C> id='EDU_NM'         width='120'     name='과정명'   align='center' </C>
                                <C> id='HIRG_YMD'       width='80'      name='입사일'     align='center' </C>
                                <C> id='JPR_YMD'        width='80'      name='승진일'     align='center' </C>
                                <C> id='CHASU'          width='40'      name='차수'       align='center' </C>
                                <C> id='HIR_DESC'       width='120'     name='비고'       align='center' </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->


</form>
<!-- form 끝 -->

</body>
</html>

