	<!--*************************************************************************
	* @source      : insa040.jsp												*
	* @description : 국민연금납부현황 PAGE 											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/08            채갑병            	최초작성
    * 2007/04/27            김학수            	스크립추가 (50~53, 95~98)
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>국민연금납부현황(insa040)</title>
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
		var today = getToday().substr(0,4);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var PIS_YY_SHR = document.form1.txtPIS_YY_SHR.value;
			var PIS_MM_SHR = document.form1.txtPIS_MM_SHR.value;
			var OCC_CD_SHR = document.form1.cmbOCC_CD_SHR.value;
			var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;

        	if( PIS_YY_SHR == "" || PIS_MM_SHR == "" ){
        		alert("기간을 입력하십시오.(년,월)");
        		return;
        	}
            if ( PIS_MM_SHR.length == 1 )
            {
                PIS_MM_SHR = "0" + PIS_MM_SHR;
            }

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa040.cmd.INSA040CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
			dsT_CP_PAYMASTER.reset();

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
			var PIS_YY_SHR = document.form1.txtPIS_YY_SHR.value;
			var PIS_MM_SHR = document.form1.txtPIS_MM_SHR.value;
			var OCC_CD_SHR = document.form1.cmbOCC_CD_SHR.value;
			var DPT_CD_SHR = document.form1.txtDPT_CD_SHR.value;
			var DPT_NM_SHR = document.form1.txtDPT_NM_SHR.value;

            if( PIS_YY_SHR == "" || PIS_MM_SHR == "" ){
        		alert("기간을 입력하십시오.(년,월)");
        		return;
        	}
            if ( PIS_MM_SHR.length == 1 )
            {
                PIS_MM_SHR = "0" + PIS_MM_SHR;
            }

        	if( PIS_YY_SHR == "" || PIS_MM_SHR == "" ){
        		alert("기간을 입력하십시오.(년,월)");
        		return;
        	}

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa040.cmd.INSA040CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR;
            var url = "insa040_PV.jsp?PIS_YY_SHR="+PIS_YY_SHR+"&PIS_MM_SHR="+PIS_MM_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&DPT_NM_SHR="+DPT_NM_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("국민연금납부현황", '', 225)
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

        	document.form1.txtPIS_YY_SHR.value = today;
        	document.form1.txtPIS_MM_SHR.value = "";
        	document.form1.txtDPT_CD_SHR.value = "";
        	document.form1.txtDPT_NM_SHR.value = "";
        	document.form1.cmbOCC_CD_SHR.selectedIndex = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_CP_PAYMASTER.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_CP_PAYMASTER.IsUpdated)  {
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

            document.getElementById("txtPIS_MM_SHR").value = getTodayArray()[1];

			document.form1.txtPIS_YY_SHR.value = today;
			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style 적용
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_PAYMASTER)			   |
    | 3. 사용되는 Table List(T_CP_PAYMASTER) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
        <param name="SubSumExpr"     	value="total">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CP_PAYMASTER)			   |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)				   |
    +------------------------------------------------------>
	<Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)">
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
	<Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow-1);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">국민연금납부현황</td>
					<td align="right" class="navigator">HOME/복리후생/국민연금/<font color="#000000">국민연금납부현황</font></td>
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
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="80"></col>
					<col width="200"></col>
					<col width="60"></col>
					<col width="130"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">소속별</td>
					<td class="padding2423" align="left">
						<input id="txtDPT_CD_SHR" style="width:20%" maxlength="2" style="ime-mode:disabled" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" style="width:50%" class="input_ReadOnly"  readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
					</td>
					<td class="searchState" align="right">근로구분별</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 80%" onChange="fnc_SearchList()">
							<option value="0">모두</option>
						</select>
					</td>
					<td class="searchState" align="right">기간</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtPIS_YY_SHR" name="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','597','108');"></a>
						년&nbsp;1월~
						<input type="text" id="txtPIS_MM_SHR" name="txtPIS_MM_SHR" style="ime-mode:disabled" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
						월
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
					<object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
						<param name="DataID" value="dsT_CP_PAYMASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{currow}"		width=40	name="NO"			align=center	Edit=none	SubBgColor="#99FFCC"	SubSumText={decode(currow,LastRow,"총 계")}</C>
							<C> id="DPT_NM"			width=110	name="소속"			align=left		Edit=none	SubBgColor="#99FFCC"	SubSumText=""	LeftMargin="10"</C>
							<C> id="JOB_NM"			width=80	name="직위"			align=left		Edit=none	SubBgColor="#99FFCC"	SubSumText=""	LeftMargin="10"</C>
                            <C> id="ENO_NM"         width=80    name="성명"           align=center    Edit=none   SubBgColor="#99FFCC"    SubSumText=""</C>
							<C> id="CET_NO"			width=140	name="국민연금NO"		align=center	Edit=none	SubBgColor="#99FFCC"	subsumtext={(subcount(CET_NO)-1)&&"명"}</C>
							<C> id="CAMT_AMT"		width=110	name="본인부담금"		align=right		Edit=none	SubBgColor="#99FFCC"	RightMargin="10"</C>
							<C> id="COM_AMT"		width=110	name="회사부담금"		align=right		Edit=none	SubBgColor="#99FFCC"	RightMargin="10"</C>
							<C> id="NPN_SUM"		width=110	name="합계"			align=right		Edit=none	SubBgColor="#99FFCC"	RightMargin="10"</C>
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
