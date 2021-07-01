<!--
***********************************************************************
* @source      : buta050.jsp
* @description : 출장비신청내역 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>출장비신청내역(buta050)</title>
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

		var btnList = 'TFFTTTFT';

        var today = getToday();

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			//근태변경신청현황 정보 조회
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
			var cd_gbn  = document.getElementById("cmbCD_GBN_SHR").value;

			dsT_DI_BUSINESSTRIP.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.a.buta050.cmd.BUTA050CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CD_GBN="+cd_gbn;
			dsT_DI_BUSINESSTRIP.reset();
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {
           if(!fnc_SearchItemCheck()) return;

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
			var cd_gbn  = document.getElementById("cmbCD_GBN_SHR").value;

	        var url = "buta050_PV.jsp?STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CD_GBN="+cd_gbn;
   			window.open(url,"buta050_PV","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;
        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_BUSINESSTRIP.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_BUSINESSTRIP.GridToExcel("출장비신청내역", '', 225);

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//document.getElementById("txtSTR_YMD_SHR").value = "";
			//document.getElementById("txtEND_YMD_SHR").value = "";
			document.getElementById("cmbCD_GBN_SHR").value = "A4";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_BUSINESSTRIP.ClearData();

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var str_ymd = document.getElementById("txtSTR_YMD_SHR");
			var end_ymd = document.getElementById("txtEND_YMD_SHR");

            if(str_ymd.value == ""){
                alert("조회 시작일을 입력하세요!");
                str_ymd.focus();
                return false;
            }
            if(end_ymd.value == ""){
                alert("조회 종료일을 입력하세요!");
                end_ymd.focus();
                return false;
            }
            return true;

        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = today;

			cfStyleGrid(form1.grdT_DI_BUSINESSTRIP,0,"false","false");      // Grid Style 적용

            document.getElementById("txtSTR_YMD_SHR").focus();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP)	   |
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_BUSINESSTRIP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
        <Param Name="SubsumExpr" 	  Value="total">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount-1);

            if(dsT_DI_BUSINESSTRIP.NameValue(1,"CD_GBN") == "A4"){
                document.form1.grdT_DI_BUSINESSTRIP.ColumnProp('COMM_NM', 'Name') = "소속";
            }else if(dsT_DI_BUSINESSTRIP.NameValue(1,"CD_GBN") == "A2"){
                document.form1.grdT_DI_BUSINESSTRIP.ColumnProp('COMM_NM', 'Name') = "직위";
            }else {
                document.form1.grdT_DI_BUSINESSTRIP.ColumnProp('COMM_NM', 'Name') = "성명";
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">출장비신청내역</td>
					<td align="right" class="navigator">HOME/근태관리/출장관리/<font color="#000000">출장비신청내역</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="80"></col>
							<col width="300"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">기간&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','113');"></a> ~
							    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','113');"></a>
							</td>
							<td class="searchState" align="right">조회구분&nbsp;</td>
							<td class="padding2423" align="left">
								<select id="cmbCD_GBN_SHR"  style="width='30%';" onChange="fnc_SearchList()">
									<option value="A4">소속별</option>
									<option value="A2">직위별</option>
									<option value="A3">개인별</option>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_BUSINESSTRIP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_BUSINESSTRIP">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}					</C>
                            <C> id="COMM_NM"	width=200	name="소속"		align=left      SubSumText="합 계" LeftMargin="20"		</C>
                            <C> id="AMOUNT"		width=150	name="금액"		align=right     RightMargin="20"						</C>
                            <C> id="APP_CNT"    width=150	name="출장건수" align=right     RightMargin="20"						</C>
                            <C> id="REMARK"	    width=240	name="비고"	    align=left     											</C>
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