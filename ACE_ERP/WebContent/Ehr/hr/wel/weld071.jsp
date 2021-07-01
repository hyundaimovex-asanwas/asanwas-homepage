<!--
***********************************************************************
* @source      : weld071.jsp
* @description : 성수기 세부 신청자 목록 PAGE
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
<title>성수기 세부 신청자 목록(weld071)</title>
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

		var btnList = 'FFFFFFFT';
		var dsCopy = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//추가 STAY_CNT 동일 콘도, 동일 시작일의 이용기간을 통한 구분을 위해
			dsT_WL_CONDOLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld071.cmd.WELD071CMD&S_MODE=SHR&ORD_NO="+dsCopy.NameValue(1,'ORD_NO')+"&CO_CD="+dsCopy.NameValue(1,'CO_CD')+"&STR_YMD="+dsCopy.NameValue(1,'STR_YMD')+"&STAY_CNT="+dsCopy.NameValue(1,'STAY_CNT');
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
//      		if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById('txtORD_NO').value;

			var url = "weld071_PV.jsp?ORD_NO="+dsCopy.NameValue(1,'ORD_NO')+"&CO_CD="+dsCopy.NameValue(1,'CO_CD')+"&STR_YMD="+dsCopy.NameValue(1,'STR_YMD');
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;


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

			document.getElementById('cmbRST_YN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOLOT.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			window.close();

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

			cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"false","false");      // Grid Style 적용

            document.getElementById('txtORD_NO').value = dsCopy.NameValue(1, 'ORD_NO');
			document.getElementById('txtSTR_YMD').value = dsCopy.NameValue(1, 'STR_YMD');
			document.getElementById('txtCN_NM').value = dsCopy.NameValue(1, 'CN_NM');
			document.getElementById('txtCO_NM').value = dsCopy.NameValue(1, 'CO_NM');
			document.getElementById('txtROOM_CNT').value = dsCopy.NameValue(1, 'ROOM_CNT');
			document.getElementById('txtSTAY_CNT').value = dsCopy.NameValue(1, 'STAY_CNT');

			fnc_SearchList();

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

            alert("검색하신 조건의 자료가 없습니다.");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">성수기 세부 신청자 목록</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">성수기 세부 신청자 목록</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
									<col width="70"></col>
									<col width="80"></col>
									<col width="60"></col>
									<col width="80"></col>
									<col width="60"></col>
									<col width="80"></col>
									<col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">성수기관리번호</td>
								<td class="padding2423">
									<input id=txtORD_NO name=txtORD_NO size="10" class="input_ReadOnly" readOnly>
                                </td>

								<td align="center" class="searchState">콘도</td>
								<td class="padding2423">
									<input id=txtCN_NM name=txtCN_NM size="10" class="input_ReadOnly" readOnly>
                                </td>
								<td align="center" class="searchState">지역</td>
								<td class="padding2423" colspan="3">
									<input id=txtCO_NM name=txtCO_NM size="26" class="input_ReadOnly" readOnly>
                                </td>
							</tr>
							<tr>
                                <td align="center" class="searchState">이용시작일</td>
                                <td class="padding2423">
                                    <input id=txtSTR_YMD name=txtSTR_YMD size="10" class="input_ReadOnly" readOnly>
                                </td>
								<td align="center" class="searchState">객실수</td>
								<td class="padding2423">
									<input id=txtROOM_CNT name=txtROOM_CNT size="4" class="input_ReadOnly" style="text-align:center" readOnly>
                                </td>
								<td align="center" class="searchState">이용일</td>
								<td class="padding2423">
									<input id=txtSTAY_CNT name=txtSTAY_CNT size="4" class="input_ReadOnly" style="text-align:center" readOnly>
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
						<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:400px;">
							<param name="DataID"					value="dsT_WL_CONDOLOT">
							<param name="Format"					value="
								<C> id={currow}	   width=60   name='NO'				align=center </C>
								<C> id='DPT_NM'	   width=130  name='소속'			align=left </C>
								<C> id='JOB_NM'	   width=110  name='직위'			align=left </C>
								<C> id='ENO_NO'	   width=110  name='사번'			align=center </C>
								<C> id='ENO_NM'	   width=110  name='성명'			align=center </C>
								<C> id='USE_CNT'   width=120  name='콘도이용실적'	align=center </C>
								<C> id='APP_YN'	   width=120  name='성수기이용여부'	align=center </C>
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