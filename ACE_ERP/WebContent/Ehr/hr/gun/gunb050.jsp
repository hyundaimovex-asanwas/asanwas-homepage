<!--
*****************************************************
* @source       : gunb050.jsp
* @description : Refresh휴가기준관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/02/06      한학현        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>Refresh휴가기준관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var basic_ymd = document.form1.txtBASIC_YMD_SHR.value;		//기준일자

			if(basic_ymd.trim().length != 0 && basic_ymd.trim().length != 10){
				alert("기준일자가 올바르지 않습니다.");
				document.getElementById("txtBASIC_YMD_SHR").focus();
				return false;
			}

			dsT_DI_REFRESH.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb050.cmd.GUNB050CMD&S_MODE=SHR&BASIC_YMD="+basic_ymd;
			dsT_DI_REFRESH.reset();

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

			trT_DI_REFRESH.KeyValue = "tr01(I:dsT_DI_REFRESH=dsT_DI_REFRESH)";
			trT_DI_REFRESH.action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb050.cmd.GUNB050CMD&S_MODE=SAV";
			trT_DI_REFRESH.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_DI_REFRESH.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_DI_REFRESH.ColumnString(dsT_DI_REFRESH.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_DI_REFRESH.DeleteRow(dsT_DI_REFRESH.RowPosition);

			trT_DI_REFRESH.KeyValue = "SVL(I:dsT_DI_REFRESH=dsT_DI_REFRESH)";
			trT_DI_REFRESH.Action = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb050.cmd.GUNB050CMD&S_MODE=DEL";
			trT_DI_REFRESH.post();

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

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_DI_REFRESH.CountColumn == 0) {
                dsT_DI_REFRESH.setDataHeader("BASIC_YMD:STRING:KEYVALUETYPE,LSE_YY:DECIMAL:KEYVALUETYPE,ATT_Z:DECIMAL,ATT_S:DECIMAL,SUM_DAY:DECIMAL");
            }

			enableInput();// 입력필드 활성화
            dsT_DI_REFRESH.AddRow();
            document.form1.txtBASIC_YMD.focus();

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

			disableInput();//입력필드 비활성화
			dsT_DI_REFRESH.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			document.form1.txtBASIC_YMD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_REFRESH.IsUpdated)  {

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

			if (!dsT_DI_REFRESH.IsUpdated) {
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

			cfStyleGrid(form1.grdT_DI_REFRESH,15,"false","false")      // Grid Style 적용

			disableInput();//입력필드 비활성화

            //최근 저장한 기준일자 조회
            ds01T_DI_REFRESH.DataID = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb050.cmd.GUNB050CMD&S_MODE=SHR_01";
            ds01T_DI_REFRESH.Reset();

            var basic_ymd = (document.getElementById("txtBASIC_YMD_SHR").value).replace("-", "").replace("-", "");
            if(basic_ymd.trim() == ""){
	            document.getElementById("txtBASIC_YMD_SHR").value = "";
            }

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
         ********************************************/
  		function enableInput(){
  			for(var i=1; i<6; i++){
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.getElementById("imgBASIC_YMD").disabled = false;
  			//document.getElementById("cmbCARD_GBN").disabled = false;
  		}

        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
         ********************************************/
  		function disableInput(){
  			for(var i=1; i<6; i++){
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.getElementById("imgBASIC_YMD").disabled = true;
  			//document.getElementById("cmbCARD_GBN").disabled = true;
  		}

		/********************
         * 합계 표시
         *******************/
		function fnc_SumDay() {

			document.getElementById("txtSUM_DAY").value = parseInt(document.getElementById("txtATT_Z").value) + parseInt(document.getElementById("txtATT_S").value);

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
    | 2. 이름 : dsT_DI_REFRESH                      |
    | 3. Table List : T_DI_REFRESH                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_REFRESH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_DI_REFRESH                          |
    | 3. Table List : T_DI_REFRESH                         |
    +----------------------------------------------->
    <Object ID="ds01T_DI_REFRESH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_REFRESH)		|
    | 3. 사용되는 Table List(T_DI_REFRESH)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_REFRESH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_REFRESH Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtBASIC_YMD_SHR.focus();
        } else {
	        enableInput();//입력필드 활성화
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <Script For=ds01T_DI_REFRESH Event="OnLoadCompleted(iCount)">

        if (iCount == 0) {
        } else {
			var oBASIC_YMD = ds01T_DI_REFRESH.NameValue(1,"BASIC_YMD").trim();
			document.getElementById("txtBASIC_YMD_SHR").value = oBASIC_YMD.substring(0,4)+"-"+oBASIC_YMD.substring(4,6)+"-"+oBASIC_YMD.substring(6,8);
			document.getElementById("txtBASIC_YMD_SHR").focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_REFRESH Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=ds01T_DI_REFRESH Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_REFRESH Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일자/근속년수] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일자/근속년수에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <Script For=ds01T_DI_REFRESH Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_REFRESH event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_REFRESH event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">Refresh휴가기준관리</td>
					<td align="right" class="navigator">HOME/근태관리/휴가계획관리/<font color="#000000">Refresh휴가기준관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">기준일자</td>
                                <td class="padding2423">
									<input id="txtBASIC_YMD_SHR" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBASIC_YMD_SHR','','70','106');"></a>
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="140"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">기준일자</td>
					<td class="padding2423">
						<input type="text" id="txtBASIC_YMD"  style="ime-mode:disabled" style="width:80%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBASIC_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgBASIC_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBASIC_YMD','','75','150');"></a>
					</td>
					<td align="center" class="creamBold">근속년수</td>
					<td class="padding2423">
						<input id="txtLSE_YY" style="width:100%" maxLength="2" style="ime-mode:disabled" onKeypress="cfNumberCheck()">
						<input type="hidden" id="txtSUM_DAY">
					</td>
					<td align="center" class="creamBold">REFRESH휴가</td>
					<td class="padding2423">
						<input id="txtATT_Z" style="width:100%" maxLength="2" style="ime-mode:disabled" onKeypress="cfNumberCheck();" onkeyup="fnc_SumDay();">
					</td>
					<td align="center" class="creamBold">유급휴가</td>
					<td class="padding2423">
						<input id="txtATT_S" style="width:100%" maxLength="2" style="ime-mode:disabled" onKeypress="cfNumberCheck();" onkeyup="fnc_SumDay();">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_REFRESH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_REFRESH">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=80			name='순번'					align=center			value={String(Currow)}	</C>
								<C> id='BASIC_YMD'		width=144			name='기준일자'				align=center									</C>
								<C> id='LSE_YY'			width=135			name='근속년수'				align=center									</C>
								<C> id='ATT_Z'			width=135			name='REFRESH휴가일수'		align=center									</C>
								<C> id='ATT_S'			width=135			name='유급휴가일수'			align=center									</C>
								<C> id='SUM_DAY'		width=135			name='합계'					align=center									</C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_DI_REFRESH" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_REFRESH">
	<Param Name="BindInfo", Value='
		<C>Col=BASIC_YMD      	Ctrl=txtBASIC_YMD      	Param=value 		</C>
		<C>Col=LSE_YY			Ctrl=txtLSE_YY			Param=value		</C>
		<C>Col=ATT_Z			Ctrl=txtATT_Z			Param=value		</C>
		<C>Col=ATT_S			Ctrl=txtATT_S    		Param=value		</C>
		<C>Col=SUM_DAY   		Ctrl=txtSUM_DAY    		Param=value		</C>
    '>
</object>