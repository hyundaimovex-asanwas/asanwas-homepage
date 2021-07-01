<!--
***********************************************************************
* @source      : wela040.jsp
* @description : 이사비용 참고 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/05      오대성        최초작성.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>이사비용 참고(wela040)</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
			
			var cd_nm = document.getElementById('txtCD_NM_SHR').value;
			dsT_WL_MOVEXPENS.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=SHR&CD_NM="+cd_nm;
    		dsT_WL_MOVEXPENS.reset();

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

				trT_WL_MOVEXPENS.KeyValue = "tr01(I:dsT_WL_MOVEXPENS=dsT_WL_MOVEXPENS)";
				trT_WL_MOVEXPENS.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=SAV";
				trT_WL_MOVEXPENS.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
			
			if(dsT_WL_MOVEXPENS.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[구분코드:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'GBN_CD')+"/일련번호:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'SEQ_NO')+"/품목:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'CD_NM')+"]의 정보를 삭제하시겠습니까?")){
				dsT_WL_MOVEXPENS.DeleteRow(dsT_WL_MOVEXPENS.RowPosition);
				trT_WL_MOVEXPENS.KeyValue = "tr01(I:dsT_WL_MOVEXPENS=dsT_WL_MOVEXPENS)";
				trT_WL_MOVEXPENS.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=DEL";
				trT_WL_MOVEXPENS.post();
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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
			
			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_WL_MOVEXPENS.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_WL_MOVEXPENS.setDataHeader("GBN_CD:STRING:KEYVALUE, SEQ_NO:STRING:KEYVALUE, CD_NM:STRING, ITEM_NM:STRING, COST1_AMT:STRING, COST2_AMT:STRING, COST3_AMT:STRING, CBM_AMT:STRING, REMARK:STRING");
			}
		
			dsT_WL_MOVEXPENS.AddRow();				
			
			document.getElementById('txtGBN_CD').focus();
			
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
			
			document.getElementById('txtCD_NM_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_MOVEXPENS.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_MOVEXPENS.IsUpdated)  {

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
			
			if (!dsT_WL_MOVEXPENS.IsUpdated ) {
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

			cfStyleGrid(form1.grdT_WL_MOVEXPENS,15,"false","false");      // Grid Style 적용
			
            document.getElementById('txtCD_NM_SHR').focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_MOVEXPENS)|
    | 3. 사용되는 Table List(T_WL_MOVEXPENS)		 |
    +------------------------------------------------>
    <Object ID="dsT_WL_MOVEXPENS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_MOVEXPENS)	|
    | 3. 사용되는 Table List(T_WL_MOVEXPENS)	        |
    +--------------------------------------------------->
    <Object ID ="trT_WL_MOVEXPENS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_MOVEXPENS Event="OnLoadCompleted(iCount)">
		
        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_MOVEXPENS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_MOVEXPENS Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[구분코드/일련번호] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("구분코드/일련번호에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_MOVEXPENS event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_MOVEXPENS event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이사비용 참고</td>
					<td align="right" class="navigator">HOME/복리후생/이주비/<font color="#000000">이사비용 참고</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">구분코드</td>
					<td class="padding2423"><input id="txtGBN_CD" size="5" maxlength="2" style="text-align:center;ime-mode:disabled"></td>
					<td align="center" class="creamBold">일련번호</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="5" maxlength="2" style="text-align:center;ime-mode:disabled"></td>
					<td align="center" class="creamBold">품&nbsp;&nbsp;목</td>
					<td class="padding2423"><input id="txtCD_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">내&nbsp;&nbsp;역</td>
					<td class="padding2423"><input id="txtITEM_NM" size="12" maxlength="10" onKeyUp="fc_chk_byte(this,10)"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">1T 기준</td>
					<td class="padding2423"><input id="txtCOST1_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">2.5T 기준</td>
					<td class="padding2423"><input id="txtCOST2_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">5T 기준</td>
					<td class="padding2423"><input id="txtCOST3_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">1CBM 추가</td>
					<td class="padding2423"><input id="txtCBM_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
				</tr>
                <tr>
					<td align="center" class="creamBold">비&nbsp;&nbsp;고</td>
					<td class="padding2423" colspan="7"><input id="txtREMARK" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)"></td>
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
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">품목&nbsp;</td>
								<td class="padding2423">
									<input id="txtCD_NM_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"> 
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
						<object	id="grdT_WL_MOVEXPENS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_WL_MOVEXPENS">
							<param name="Format"					value="
								<C> id={currow}		width=35    name='NO'			align=center </C>
								<C> id='GBN_CD'		width=60	name='구분코드'		align=center </C>
								<C> id='SEQ_NO'		width=60	name='일련번호'		align=center </C>
								<C> id='CD_NM'		width=110	name='품목'			align=left </C>
								<C> id='ITEM_NM'	width=80	name='내역'			align=left </C>
								<C> id='COST1_AMT'	width=70	name='1T 기준'		align=right </C>
								<C> id='COST2_AMT'	width=70	name='2.5T 기준'	align=right </C>
								<C> id='COST3_AMT'	width=70	name='5T 기준'		align=right </C>
								<C> id='CBM_AMT'	width=70	name='1CBM 추가'	align=right </C>
								<C> id='REMARK'		width=140	name='비고'			align=left </C>
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
<object id="bndT_WL_MOVEXPENS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_MOVEXPENS">
	<Param Name="BindInfo", Value='
		<C>Col=GBN_CD		Ctrl=txtGBN_CD	    Param=value		Disable=disabled</C>
		<C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	    Param=value		Disable=disabled</C>
		<C>Col=CD_NM		Ctrl=txtCD_NM      	Param=value		Disable=disabled</C>
		<C>Col=ITEM_NM		Ctrl=txtITEM_NM	    Param=value		Disable=disabled</C>
		<C>Col=COST1_AMT	Ctrl=txtCOST1_AMT	Param=value		Disable=disabled</C>
		<C>Col=COST2_AMT	Ctrl=txtCOST2_AMT	Param=value		Disable=disabled</C>
		<C>Col=COST3_AMT	Ctrl=txtCOST3_AMT   Param=value		Disable=disabled</C>
		<C>Col=CBM_AMT		Ctrl=txtCBM_AMT		Param=value		Disable=disabled</C>
		<C>Col=REMARK		Ctrl=txtREMARK     	Param=value		Disable=disabled</C>
    '>
</object>