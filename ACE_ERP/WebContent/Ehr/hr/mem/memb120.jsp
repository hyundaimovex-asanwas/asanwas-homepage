<!--
    ************************************************************************************
    * @source         : memb120.jsp 				                                                                                     *
    * @description   : 사용사업관리대장 PAGE.                                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  한학현   | 최초작성                                                                                           *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>사용사업관리대장</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YMD_SHR = document.getElementById("txtPIS_YMD_SHR").value;

			//해당일자가 없으면 조회못함.
			if(PIS_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당일자를 입력하세요.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}
			//해당일자가 잘못되었으면 조회못함.
			if(PIS_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당일자가 잘못되었습니다.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}

            //데이터셋 전송
            dsT_ME_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb120.cmd.MEMB120CMD&S_MODE=SHR&PIS_YMD_SHR="+PIS_YMD_SHR;
            dsT_ME_PERSON.Reset();

        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

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


        	var PIS_YMD_SHR = document.getElementById("txtPIS_YMD_SHR").value;

			//해당일자가 없으면 조회못함.
			if(PIS_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당일자를 입력하세요.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}
			//해당일자가 잘못되었으면 조회못함.
			if(PIS_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("해당일자가 잘못되었습니다.");
					document.getElementById("txtPIS_YMD_SHR").focus();
					return false;
				}
			}

		    var hnwparm = "[:PIS_YMD_SHR]="+PIS_YMD_SHR;
			document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_ME_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ME_PERSON.GridToExcel("사용사업관리대장", '', 225);

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			dsT_ME_PERSON.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			//document.getElementById("txtPIS_YMD_SHR").value = getToday();
			document.form1.txtPIS_YMD_SHR.focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_ME_PERSON.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_ME_PERSON.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                                        두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_ME_PERSON,0,"false","false");

			document.getElementById("txtPIS_YMD_SHR").value = getToday();

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
	    cfErrorMsg(this);
    </Script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사용사업관리대장</td>
					<td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">사용사업관리대장</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="right" class="searchState">해당일자&nbsp;</td>
								<td>
									<input id="txtPIS_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPIS_YMD_SHR','','65','112');"></a>
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
						<object	id="grdT_ME_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_ME_PERSON">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=29			name='NO'				align=center			value={String(Currow)}	</C>
								<C> id='DPT_NM'				width=110			name='근무소속'			align=center			Suppress=1				</C>
								<G>name=파견사원		HeadBgColor=#F7DCBB
									<C> id='ENO_NM'			width=60			name='성명'				align=center			                        </C>
									<C> id='CET_NO'			width=100			name='주민등록번호'    	align=center			                        </C>
									<C> id='DISDPT_CD'		width=40			name='코드' 			align=center									</C>
									<C> id='DISDPT_NM'		width=120			name='담당업무'			align=center									</C>
								</G>
								<C> id='CONSE_YMD1'			width=150			name='1차계약기간'		align=center									</C>
								<C> id='CONSE_YMD2'			width=150			name='2차계약기간'		align=center									</C>
                                <G>name=파견사업체        HeadBgColor=#F7DCBB
								    <C> id='DISCOMP_NM'		width=120			name='파견업체'			align=center									</C>
								    <C> id='EXT_01'  		width=100			name='관리책임자'		align=center									</C>
								    <C> id='EXT_02'	    	width=100			name='소재지'			align=center									</C>
                                </G>
								<C> id='REMARK'	    		width=100			name='비고'				align=center									</C>

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
	<comment id="__HNWID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="memb120.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
	</comment><script> __ShowEmbedObject(__HNWID__); </script>
<!-- 내용 조회 그리드 데이블 끝-->
</form>
<!-- form 끝 -->

</body>
</html>