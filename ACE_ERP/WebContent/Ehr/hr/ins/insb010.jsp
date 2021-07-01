<!--*************************************************************************
* @source      : insb010.jsp																							*
* @description : 건강보험 개인별 현황																			*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION																	*
*----------------------------------------------------------------------------
* 2007/04/03       방석호            	최초작성																	*
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>개인별건강보험납부현황(insb010)</title>
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
		var today = parseInt(getToday().substr(0,4));
		var is2007 = false;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var APY_YMD_SHR = document.form1.txtAPY_YMD_SHR.value;
			var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;

			if( parseInt(APY_YMD_SHR) >= 2007 ){
				is2007 = true;
			}else{
				is2007 = false;
			}

			if( ENO_NO_SHR == "" ){
				alert("사번을 입력하십시오.");
				return;
			}

			dsT_IS_GRADETABLE.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.b.insb010.cmd.INSB010CMD&S_MODE=SHR&APY_YMD_SHR="+APY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_IS_GRADETABLE.reset();
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
			var APY_YMD_SHR = document.form1.txtAPY_YMD_SHR.value;
			var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;

			if( parseInt(APY_YMD_SHR) >= 2007 ){
				is2007 = true;
			}else{
				is2007 = false;
			}

			if( ENO_NO_SHR == "" ){
				alert("사번을 입력하십시오.");
				return;
			}

           var url = "insb010_PV.jsp?APY_YMD_SHR="+APY_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_IS_GRADETABLE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_IS_GRADETABLE.GridToExcel("개인별건강보험납부현황", '', 225)
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

        	document.form1.txtENO_NO_SHR.value = "";
        	document.form1.txtENO_NM_SHR.value = "";
        	document.form1.txtAPY_YMD_SHR.value = today;

        	document.getElementById("resultMessage").innerText = ' ';

        	is2007 = false;
        	dsT_IS_GRADETABLE.ClearData();
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_IS_GRADETABLE.IsUpdated)  {
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.form1.txtAPY_YMD_SHR.value = today;
			cfStyleGrid(form1.grdT_IS_GRADETABLE,0,"true","false");      // Grid Style 적용
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
    | 2. 이름은 ds_ + 주요 테이블명(T_IS_GRADETABLE)			   |
    | 3. 사용되는 Table List(T_IS_GRADETABLE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_IS_GRADETABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
        <param name="SubSumExpr"     	value="total">
	</Object>

	<!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_IS_GRADETABLE)			   |
    | 3. 사용되는 Table List(T_IS_GRADETABLE)				   |
    +------------------------------------------------------>
	<Object ID="trT_IS_GRADETABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_IS_GRADETABLE=dsT_IS_GRADETABLE)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_IS_GRADETABLE.CountRow-1);

        }
		if( is2007 ){
	 		document.grdT_IS_GRADETABLE.ColumnProp('GRD_CD', "Show") = "false";
	       	document.grdT_IS_GRADETABLE.ColumnProp('STDB_AMT', "Name") = "보수월액";
	       	document.grdT_IS_GRADETABLE.ColumnProp('STDB_AMT', "Width") = "270";
	       	document.grdT_IS_GRADETABLE.ColumnProp('CAMT_AMT', "Width") = "270";
		}else{
	 		document.grdT_IS_GRADETABLE.ColumnProp('GRD_CD', "Show") = "true";
	       	document.grdT_IS_GRADETABLE.ColumnProp('STDB_AMT', "Name") = "표준보수월액";
	       	document.grdT_IS_GRADETABLE.ColumnProp('STDB_AMT', "Width") = "200";
	       	document.grdT_IS_GRADETABLE.ColumnProp('CAMT_AMT', "Width") = "200";
		}
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_IS_GRADETABLE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_IS_GRADETABLE event="OnFail()">
        alert(trT_IS_GRADETABLE.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별건강보험납부현황</td>
					<td align="right" class="navigator">HOME/복리후생/건강보험/<font color="#000000">개인별건강보험납부현황</font></td>
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
					<col width="100"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">년도</td>
					<td class="padding2423" align="left">
                        <TABLE height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <TR>
                                <TD width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtAPY_YMD_SHR" name="txtAPY_YMD_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                </TD>
                                <TD style="height:9px; padding-left:0px; border-style:none"><IMG id="img_spinup" style="CURSOR: hand" onclick="datechange('txtAPY_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </TR>
                            <TR>
                                <TD style="height:9px; padding-left:0px; border-style:none"><IMG id="img_spindown" style="CURSOR: hand" onclick="datechange('txtAPY_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </TR>
                        </TABLE>                    
					</td>
					<td align="right" class="searchState">사번</td>
                    <td class="padding2423">
                    	<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                    	<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                    	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                    </td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="65"></col>
			<col width="120"></col>
			<col width="65"></col>
			<col width="90"></col>
			<col width="65"></col>
			<col width="120"></col>
			<col width="65"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">소속</td>
			<td class="padding2423">
				<input type="text" id="txtDPT_NM" size="16" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">직위</td>
			<td class="padding2423">
				<input type="text" id="txtJOB_NM" size="12" class="input_ReadOnly" readonly>
			</td>
			<td align="center" class="creamBold">증번호</td>
			<td class="padding2423">
				<input type="text" id="txtHIU_NO" size="15" class="input_ReadOnly" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

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
					<object id="grdT_IS_GRADETABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
						<param name="DataID" value="dsT_IS_GRADETABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=110	name="N0"			align=center	value={String(Currow)}	SubBgColor="#99FFCC"	subsumtext="합계"</C>
							<C> id="PIS_MM"			width=130	name="월"			align=center	Edit=none				SubBgColor="#99FFCC"</C>
							<C> id="GRD_CD"			width=140	name="등급"			align=center	Edit=none				SubBgColor="#99FFCC"</C>
							<C> id="STDB_AMT"		width=200	name="표준보수월액"	align=right		Edit=none				SubBgColor="#99FFCC"	RightMargin="10"</C>
							<C> id="CAMT_AMT"		width=200	name="보험료"			align=right		Edit=none				SubBgColor="#99FFCC"	RightMargin="10"</C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_IS_GRADETABLE 설정 테이블 -->
	<object id="bndT_IS_GRADETABLE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_IS_GRADETABLE">
		<Param Name="BindInfo", Value="
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=HIU_NO			Ctrl=txtHIU_NO			Param=value</C>
		">
	</object>
