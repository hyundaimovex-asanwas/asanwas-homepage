<!--
***********************************************************************
* @source      : weld080.jsp
* @description : 성수기추첨결과 PAGE
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
<title>성수기추첨결과(weld080)</title>
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

		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;
			var rst_gbn = document.getElementById('cmbRST_GBN_SHR').value;

			dsT_WL_CONDOLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld080.cmd.WELD080CMD&S_MODE=SHR&ORD_NO="+ord_no+"&RST_GBN="+rst_gbn;
    		dsT_WL_CONDOLOT.reset();

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

            if(!dsT_WL_CONDOLOT.IsUpdated) {
                alert("변경된 내역이 없습니다.");
                return;
            }
            if(!confirm("변경된 내역을 반영하시겠습니까?")) {
                return;
            }

            trT_WL_CONDOLOT.KeyValue = "TR(I:dsT_WL_CONDOLOT=dsT_WL_CONDOLOT)";                           
            trT_WL_CONDOLOT.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld080.cmd.WELD080CMD&S_MODE=SAV";
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

			if (dsT_WL_CONDOLOT.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_WL_CONDOLOT.GridToExcel("성수기추첨결과", '', 225);

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

			document.getElementById('cmbORD_NO_SHR').value = '';
			document.getElementById('cmbRST_GBN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOLOT.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

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

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//콘도 성수기 관리번호 조회를 위해 WELD050CMD 사용
			dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
			dsT_WL_CONDOSSN.Reset();

			cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"true","false");      // Grid Style 적용

            document.getElementById('cmbORD_NO_SHR').focus();

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

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOLOT)    |
    | 3. 사용되는 Table List(T_WL_CONDOLOT)            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

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

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOLOT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {



        } else {

			//성수기 콘도 관리번호
            for( i = 1; i <= dsT_WL_CONDOSSN.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
                oOption.text  = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
				document.getElementById("cmbORD_NO_SHR").add(oOption);

            }

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


    <!-----------------------------------------------------+
    | Transaction Successful 처리                                |
    +------------------------------------------------------>
    <script for=trT_WL_CONDOLOT event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("작업을 완료 하였습니다!");
    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure 처리                                   |
    +------------------------------------------------------>
    <script for=trT_WL_CONDOLOT event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">성수기추첨결과</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">성수기추첨결과</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"> <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
									<col width="120"></col>
									<col width="120"></col>
									<col width="80"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">성수기관리번호</td>
								<td class="padding2423">
									<select id="cmbORD_NO_SHR" style="WIDTH:80" onChange="fnc_SearchList();">
									</select>
								</td>
								<td align="center" class="searchState">결&nbsp;&nbsp;과</td>
								<td class="padding2423">
									<select id="cmbRST_GBN_SHR" style="WIDTH:20%" onChange="fnc_SearchList();">
										<option value="">모 두</option>
										<option value="Y">당 첨</option>
										<option value="N">낙 첨</option>
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
						<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_CONDOLOT">
							<param name="Format"					value="
								<C> id={currow}	   width=35   name='NO'				align=center     Edit=none</C>
								<C> id='ORD_NO'	   width=90   name='성수기관리번호'	align=center   Edit=none</C>
								<C> id='STR_YMD'   width=70   name='이용시작일'		align=center    Edit=none</C>
								<C> id='CN_NM'	   width=65	  name='콘도'			align=left     Edit=none</C>
								<C> id='CO_NM'	   width=90   name='지역'			align=left     Edit=none</C>
								<C> id='EXT_01'	   width=40	  name='평수'			align=center  Edit=none</C>
								<C> id='STAY_CNT'  width=55	  name='이용일수'		align=center     Edit=none</C>
								<C> id='DPT_NM'	   width=65	  name='소속'			align=left    Edit=none</C>
								<C> id='JOB_NM'	   width=55	  name='직위'			align=left    Edit=none</C>
								<C> id='ENO_NO'	   width=55	  name='사번'			align=center  Edit=none</C>
								<C> id='ENO_NM'    width=55	  name='성명'			align=center  Edit=none</C>
								<C> id='RST_GBN'   width=40	  name='결과'			align=center	Value={Decode(RST_GBN,'Y','당첨','낙첨')}    Edit=none</C>
								<C> id='CMP_YN'    width=50	  name='확정'			align=center	EditStyle=Combo Data='Y:확정,N:미확정'    Edit={IF(CMP_YN='N','true','false')}</C>
								<C> id='RSV_NO'    width=100  name='예약번호'		align=center </C>
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