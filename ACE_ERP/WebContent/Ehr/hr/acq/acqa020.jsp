<!--
***********************************************************************
* @source      : acqa020.jsp
* @description : 지인검색 및 수정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/11/29      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>지인검색 및 수정(acqa020)</title>
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

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFTTTFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건 3가지
			var com_gbn = document.getElementById('cmbCOM_GBN_SHR').value;	//기관구분
			var com_nm = document.getElementById('txtCOM_NM_SHR').value;	//기관명
			var eno_nm = document.getElementById('txtENO_NM_SHR').value;	//성명

			dsT_AQ_ACQAINT.dataid = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=SHR&COM_GBN="+com_gbn+"&COM_NM="+com_nm+"&ENO_NM="+eno_nm;
    		dsT_AQ_ACQAINT.reset();

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

			trT_AQ_ACQAINT.KeyValue = "tr01(I:dsT_AQ_ACQAINT=dsT_AQ_ACQAINT)";
			trT_AQ_ACQAINT.action = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=SAV";
			trT_AQ_ACQAINT.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_AQ_ACQAINT.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[지인성명:"+dsT_AQ_ACQAINT.NameValue(dsT_AQ_ACQAINT.RowPosition,'ENO_NM')+"]의 정보를 삭제하시겠습니까?")){
				dsT_AQ_ACQAINT.DeleteRow(dsT_AQ_ACQAINT.RowPosition);
				trT_AQ_ACQAINT.KeyValue = "tr01(I:dsT_AQ_ACQAINT=dsT_AQ_ACQAINT)";
				trT_AQ_ACQAINT.action = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=DEL";
				trT_AQ_ACQAINT.post();
			}


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

			if (dsT_AQ_ACQAINT.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AQ_ACQAINT.GridToExcel("지인검색목록", '', 225);

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

			document.getElementById('cmbCOM_GBN_SHR').value = '';	//기관구분
			document.getElementById('txtCOM_NM_SHR').value = '';	//기관명
			document.getElementById('txtENO_NM_SHR').value = '';	//성명
			document.getElementById("resultMessage").innerText = ' ';

			dsT_AQ_ACQAINT.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_AQ_ACQAINT.IsUpdated)  {

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

			if (!dsT_AQ_ACQAINT.IsUpdated ) {
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

			cfStyleGrid(form1.grdT_AQ_ACQAINT,15,"false","false");      // Grid Style 적용

			//기관구분
            for( var i = 1; i <= dsCOMMON_W9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCOM_GBN").add(oOption);

            }
			//기관구분
            for( var i = 1; i <= dsCOMMON_W9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W9.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCOM_GBN_SHR").add(oOption);

            }
			//친밀도
            for( var i = 1; i <= dsCOMMON_W7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFAM_LEVEL").add(oOption);

            }

            document.getElementById('cmbCOM_GBN_SHR').focus();

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

    <!----------------------------------------------+
    | 1. 조회용 DataSet								|
    | 2. 이름은 ds_ + 주요 테이블명(dsT_AQ_ACQAINT)	|
    | 3. 사용되는 Table List(T_AQ_ACQAINT)			|
    +----------------------------------------------->
    <Object ID="dsT_AQ_ACQAINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_AQ_ACQAINT)		|
    | 3. 사용되는 Table List(T_AQ_ACQAINT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_AQ_ACQAINT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 기관구분 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_W9"/>
       <jsp:param name="CODE_GUBUN"    value="W9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- 친밀도 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_W7"/>
       <jsp:param name="CODE_GUBUN"    value="W7"/>
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
    <Script For=dsT_AQ_ACQAINT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_AQ_ACQAINT Event="OnLoadError()">

		document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_AQ_ACQAINT Event="OnDataError()">

		document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_AQ_ACQAINT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_AQ_ACQAINT event="OnFail()">
        cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">지인검색 및 수정</td>
					<td align="right" class="navigator">HOME/지인관리/지인관리/<font color="#000000">지인검색 및 수정</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="60"></col>
									<col width="120"></col>
									<col width="100"></col>
									<col width="120"></col>
	                                <col width="60"></col>
									<col width="80"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchBold">기관구분&nbsp;</td>
								<td class="padding2423">
									<select id="cmbCOM_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option value=''>전 체</option>
									</select>
								</td>
								<td align="right" class="searchBold">기관명&nbsp;</td>
								<td class="padding2423"><input id="txtCOM_NM_SHR" size="30" maxlength="30" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
								</td>
								<td align="right" class="searchBold">지인성명&nbsp;</td>
								<td class="padding2423"><input id="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"></td>
								<td>&nbsp;</td>
							</tr>
						</table>
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
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">성 명</td>
					<td class="padding2423"><input id="txtENO_NM" size="12" maxlength="12" onKeyUp="fc_chk_byte(this,12)"></td>
					<td align="center" class="creamBold">기관구분</td>
					<td class="padding2423">
						<select id="cmbCOM_GBN" style="WIDTH: 100%">
						</select>
					</td>
					<td align="center" class="creamBold">기관명</td>
					<td class="padding2423"><input id="txtCOM_NM" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">부서명</td>
					<td class="padding2423"><input id="txtDPT_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">친밀도</td>
					<td class="padding2423">
						<select id="cmbFAM_LEVEL" style="WIDTH: 70%">
						</select>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">관 계</td>
					<td class="padding2423"><input id="txtREL_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">회사전화</td>
					<td class="padding2423"><input id="txtTEL_NO" size="20" maxlength="20" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">핸드폰</td>
					<td class="padding2423"><input id="txtHP_NO" size="20" maxlength="20" onkeypress="cfCheckNumber()" style="ime-mode:disabled"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">E-mail</td>
					<td class="padding2423"><input id="txtE_MAIL" size="30" maxlength="30"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">비&nbsp;&nbsp;고</td>
					<td class="padding2423" colspan="3"><input id="txtREMARK" size="60" maxlength="60" onKeyUp="fc_chk_byte(this,60)"></td>
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
						<object	id="grdT_AQ_ACQAINT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
							<param name="DataID"					value="dsT_AQ_ACQAINT">
							<param name="Format"					value="
								<FC> id={currow}		width=35    name='NO'			align=center </FC>
								<FC> id='ENO_NM'		width=80	name='지인성명'		align=center</FC>
								<C> id='COM_GBN'	width=120	name='기관구분'		align=left
								EditStyle=Lookup  Data='dsCOMMON_W9:CODE:CODE_NAME' </C>
								<C> id='COM_NM'		width=120	name='기관명'		align=left </C>
								<C> id='DPT_NM'		width=120	name='부서명'		align=left </C>
								<C> id='JOB_NM'		width=80	name='직위'			align=left </C>
								<C> id='FAM_LEVEL'	width=100	name='친밀도'		align=left
								EditStyle=Lookup  Data='dsCOMMON_W7:CODE:CODE_NAME'</C>
								<C> id='REL_NM'		width=100	name='관계'			align=left </C>
								<C> id='TEL_NO'		width=100	name='회사전화'		align=left </C>
								<C> id='HP_NO'		width=100	name='휴대폰'		align=left </C>
								<C> id='E_MAIL'		width=120	name='E-mail'		align=left </C>
								<C> id='IPT_YMD'	width=80	name='입력일'		align=center </C>
								<C> id='REMARK'		width=120	name='비고'			align=left </C>
								<C> id='ENO_DPT_NM'	width=80	name='부서'			align=left </C>
								<C> id='ENO_JOB_NM'	width=60	name='직위'			align=left </C>
								<C> id='ENO_NO'		width=80	name='사번'			align=center</C>
								<C> id='ENO_ENO_NM'	width=80	name='성명'			align=center</C>
								<C> id='ENO_YN'		width=80	name='재직여부'		align=center</C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_AQ_ACQAINT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_AQ_ACQAINT">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NM      	Ctrl=txtENO_NM      	Param=value		Disable=disabled</C>
		<C>Col=COM_GBN		Ctrl=cmbCOM_GBN	      	Param=value		Disable=disabled</C>
		<C>Col=COM_NM    	Ctrl=txtCOM_NM	     	Param=value		Disable=disabled</C>
		<C>Col=DPT_NM		Ctrl=txtDPT_NM      	Param=value		Disable=disabled</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM			Param=value		Disable=disabled</C>
		<C>Col=FAM_LEVEL	Ctrl=cmbFAM_LEVEL      	Param=value		Disable=disabled</C>
		<C>Col=REL_NM		Ctrl=txtREL_NM      	Param=value		Disable=disabled</C>
		<C>Col=TEL_NO		Ctrl=txtTEL_NO	     	Param=value		Disable=disabled</C>
		<C>Col=HP_NO		Ctrl=txtHP_NO	     	Param=value		Disable=disabled</C>
		<C>Col=E_MAIL		Ctrl=txtE_MAIL	     	Param=value		Disable=disabled</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		Disable=disabled</C>
    '>
</object>