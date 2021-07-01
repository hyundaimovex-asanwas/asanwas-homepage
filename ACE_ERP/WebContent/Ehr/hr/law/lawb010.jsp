<!--
*****************************************************
* @source       : lawb010.jsp
* @description : 법무권한설정 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/12/19      한학현        최초작성.(수정시 반드시 문서권한설정 같이 수정)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>법무권한설정</title>
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

		var btnList = 'TFTTFFFT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건 3가지
			var eno_no = document.form1.txtENO_NO_SHR.value;		//사번
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;		//부서
			var law_autho = document.form1.cmbLAW_AUTHO_SHR.value;	//평가그룹

			//역량 평가 적용 결과 정보 조회
			dsT_CM_EMPLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.law.b.lawb010.cmd.LAWB010CMD&S_MODE=SHR&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&LAW_AUTHO="+law_autho;
			dsT_CM_EMPLIST.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_CM_EMPLIST.KeyValue = "tr01(I:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
			trT_CM_EMPLIST.action = "/servlet/GauceChannelSVL?cmd=hr.law.b.lawb010.cmd.LAWB010CMD&S_MODE=SAV";
			trT_CM_EMPLIST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

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

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

			document.getElementById("txtENO_NO_SHR").value = '';
			document.getElementById("txtENO_NM_SHR").value = '';
			document.getElementById("txtDPT_CD_SHR").value = '';
			document.getElementById("txtDPT_NM_SHR").value = '';
			document.getElementById("cmbLAW_AUTHO_SHR").value = '';
			document.getElementById("txtENO_NO").value = '';
			document.getElementById("txtENO_NM").value = '';
			document.getElementById("txtDPT_CD").value = '';
			document.getElementById("txtDPT_NM").value = '';
			document.getElementById("cmbLAW_AUTHO").value = '';

			document.getElementById("resultMessage").innerText = ' ';
			dsT_CM_EMPLIST.ClearAll();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CM_EMPLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_CM_EMPLIST.IsUpdated) {
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

			cfStyleGrid(form1.grdT_CM_EMPLIST,15,"false","false")      // Grid Style 적용

			document.form1.txtENO_NO_SHR.focus();

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
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_EMPLIST                      |
    | 3. Table List : T_CM_EMPLIST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_CM_EMPLIST)		|
    | 3. 사용되는 Table List(T_CM_EMPLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(I:T_EV_ABLRST=T_EV_ABLRST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtENO_NO_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_CM_EMPLIST.focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">법무권한설정</td>
					<td align="right" class="navigator">HOME/총무(기타)/법무관리/<font color="#000000">법무권한설정</font></td>
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
			<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">부서</td>
					<td class="padding2423">
						<input type="hidden" id=txtDPT_CD name=txtDPT_CD>
						<input id=txtDPT_NM name=txtDPT_NM style="width:100%" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">직위</td>
					<td class="padding2423">
						<input id=txtJOB_NM name=txtJOB_NM style="width:100%" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">사번</td>
					<td class="padding2423">
						<input id=txtENO_NO name=txtENO_NO style="width:100%" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">성명</td>
					<td class="padding2423">
						<input id=txtENO_NM name=txtENO_NM style="width:100%" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">권한</td>
					<td class="padding2423">
						<select id="cmbLAW_AUTHO" name="cmbLAW_AUTHO" style="width:100%">
							<option value=''>없음</option>
							<option value='S'>소속부서</option>
							<option value='A'>모든부서</option>
                        </select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="35"></col>
                                <col width="200"></col>
                                <col width="35"></col>
                                <col width="200"></col>
                                <col width="65"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();">
									<input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image4" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
								</td>
                                <td align="right" class="searchState">부서&nbsp;</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">권한&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbLAW_AUTHO_SHR" name="cmbLAW_AUTHO_SHR" style="WIDTH: 50%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
										<option value=''>전 체</option>
										<option value='NULL'>없음</option>
										<option value='S'>소속부서</option>
										<option value='A'>모든부서</option>
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
						<object	id="grdT_CM_EMPLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
							<param name="DataID"				value="dsT_CM_EMPLIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id={currow}			width=80		name='NO'		align=center																																								</C>
								<C> id='DPT_NM'			width=145		name='부서'		align=left			Edit=None																																			</C>
								<C> id='JOB_NM'			width=145		name='직위'		align=left			Edit=None																																			</C>
								<C> id='ENO_NO'			width=145		name='사번'		align=center		Edit=None																																			</C>
								<C> id='ENO_NM'			width=145		name='성명'		align=center		Edit=None																																			</C>
								<C> id='LAW_AUTH'		width=104		name='권한'		align=center		Edit=none								Value={Decode(LAW_AUTHO,'','없음','S','소속부서','A','모든부서')}		</C>
								<C> id='LAW_AUTHO'	width=104		name='권한'		align=center		Edit=none		Show=false																													</C>
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
<!-- -->
<object id="bndT_CM_EMPLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_EMPLIST">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO      	Ctrl=txtENO_NO      	Param=value  Disable=disabled</C>
		<C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value</C>
		<C>Col=DPT_NM    	Ctrl=txtDPT_NM      	Param=value</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM      	Param=value</C>
		<C>Col=LAW_AUTHO	Ctrl=cmbLAW_AUTHO		Param=value</C>
    '>
</object>