<!--
***********************************************************************
* @source      : etca010.jsp
* @description : 로그인정보 PAGE
***********************************************************************
*----------------------------------------------------------------------
* 2007/02/13      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>로그인정보(etca010)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var dpt_cd = document.getElementById('txtDPT_CD_SHR').value;

            if(!fnc_SearchItemCheck()) return;

			dsT_CM_ACCESSLOG.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.a.etca010.cmd.ETCA010CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd;

    		dsT_CM_ACCESSLOG.reset();


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

			//이곳에 해당 코딩을 입력 하세요

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

			//이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_ACCESSLOG.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_ACCESSLOG.GridToExcel("프로그램사용정보", '', 225)			

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

			//document.getElementById('txtSTR_YMD_SHR').value = '';
			//document.getElementById('txtEND_YMD_SHR').value = '';
            document.getElementById('txtDPT_CD_SHR').value = '';
            document.getElementById('txtDPT_NM_SHR').value = '';
            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_CM_ACCESSLOG.ClearData();

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

			var str_ymd = document.getElementById('txtSTR_YMD_SHR');
			var end_ymd = document.getElementById('txtEND_YMD_SHR');

            if(str_ymd.value=="" && end_ymd.value==""){
                alert("기간을 입력하세요!");
                str_ymd.focus();
                return false;
            }
            return true;

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

			cfStyleGrid(form1.grdT_CM_ACCESSLOG,15,"false","false");      // Grid Style 적용

            document.getElementById('txtSTR_YMD_SHR').focus();


<%
    if(!box.getString("SESSION_ROLE_CD").equals("1001")) {
%>

            document.getElementById("txtENO_NO_SHR").value  = "<%=box.getString("SESSION_ENONO") %>";
            document.getElementById("txtENO_NM_SHR").value  = "<%=box.getString("SESSION_ENONM") %>";
            document.getElementById("txtDPT_CD_SHR").value  = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value  = "<%=box.getString("SESSION_DPTNM") %>";

            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "ImgEnoNo");

            fnc_ChangeStateElement(false, "txtDPT_CD_SHR");
            fnc_ChangeStateElement(false, "ImgDptCd");
<%
    }
%>


            //날짜값들 바인딩
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1]+"-"+toDays[2];
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1]+"-"+toDays[2];

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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_ACCESSLOG)|
    | 3. 사용되는 Table List(T_CM_ACCESSLOG)		 |
    +------------------------------------------------>
    <Object ID="dsT_CM_ACCESSLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
		<param name=TimeOut           value=200000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_ACCESSLOG Event="OnLoadCompleted(iCount)">

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
    <Script For=dsT_CM_ACCESSLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_ACCESSLOG Event="OnDataError()">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">프로그램사용정보</td>
					<td align="right" class="navigator">HOME/기초정보/셀프서비스/<font color="#000000">프로그램사용정보</font></td>
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
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="60"></col>
                                    <col width="230"></col>
                                    <col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">기간&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','115');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','115');"></a>
								</td>
                                <td align="right" class="searchState">부서&nbsp;</td>
								<td class="padding2423">
									<input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="6" maxlength="3" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')"></a>
								</td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
									<input name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
						<object	id="grdT_CM_ACCESSLOG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
							<param name="DataID"					value="dsT_CM_ACCESSLOG">
							<param name="Format"					value="
								<FC> id={currow}	  width=40  name='순번'		    align=center value={String(Currow)} </FC>
								<FC> id='ACCESS_TIME' width=130	name='일자 시간'	align=center </FC>
								<FC> id='PROG_ID'	  width=70	name='프로그램ID'	align=center </FC>
								<FC> id='MENU_NM'	  width=240	name='메뉴명'	    align=left </FC>
								<FC> id='DPT_NM' 	  width=104	name='부서'	        align=left </FC>
                                <FC> id='JOB_NM' 	  width=60	name='직위'	        align=center </FC>
								<FC> id='ENO_NO'	  width=60	name='사번'			align=center </FC>
								<C> id='NAME'    	  width=60	name='성명'		    align=center </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>


					<!--	<object	id="grdT_CM_ACCESSLOG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
							<param name="DataID"					value="dsT_CM_ACCESSLOG">
							<param name="Format"					value="
								<C> id={currow}		 width=40   name='순번'		align=center </C>
								<C> id='PROG_ID'	 width=80	name='프로그램ID'	align=left </C>
								<C> id='ACCESS_TIME' width=130	name='일자 시간'	align=left </C>
								<C> id='IPADDRESS'	 width=80	name='IP주소'	    align=center </C>
								<C> id='ENO_NO'	     width=70	name='사번'			align=center </C>
								<C> id='ENO_NM' 	 width=70	name='성명'		    align=center </C>
								<C> id='DPT_NM' 	 width=90	name='부서'	        align=left </C>
								<C> id='USE_TIME'	 width=70	name='사용시간'		align=center </C>
								<C> id='CLOSE_TIME'	 width=130	name='CLOSE시간'	    align=center </C>
							">-->


						</object>

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