<!--
***********************************************************************
* @source      : saga100.jsp
* @description : 급여지급내역(전월대비표) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/27      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>급여지급내역(전월대비표)</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga100.cmd.SAGA100CMD&S_MODE=SHR&PIS_YM="+pis_ym;
    		dsT_CP_PAYMASTER.reset();

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

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;

			var url = "saga100_PV.jsp?pis_ym="+pis_ym;
			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("급여지급내역(전월대비표)", '', 225);

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

			//document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_PAYMASTER.ClearData();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_PAYMASTER.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var pis_ym = document.getElementById('txtPIS_YM_SHR');

            if(pis_ym.value == ""){
                alert("조회년월을 입력하셔야 합니다!");
                pis_ym.focus();
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

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");      // Grid Style 적용

            document.getElementById('txtPIS_YM_SHR').focus();

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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CP_PAYMASTER)   |
    | 3. 사용되는 Table List(T_CP_PAYMASTER)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
   <!-- <Param name="SubsumExpr"	  value="total">  -->
        <Param name="TimeOut"	      value="1800000">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">

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
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">급여지급내역(전월대비표)</td>
					<td align="right" class="navigator">HOME/보상관리/급여관리/<font color="#000000">급여지급내역(전월대비표)</font></td>
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
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="80"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td class="searchState" align="right">조회년월&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','50','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
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
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="Format"					value="
                                <C> id='SEQ'	        width=80	name='월구분'	align=center   BgColor={decode(SEQ,'1','#FFF8DC','2','#F0FFF0','#99FFCC')}  value={decode(SEQ,'1','전월','2','금월')} suppress =1</C>
                                <C> id='OCC_CD'	        width=90	name='근로구분'	align=center   BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                <C> id='AMT_SUM'	    width=95	name='급여총액'	align=right    BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                <X> name='증 감 내 역' HeadBgColor='#F7DCBB'
                                    <G> name='신규입사자' HeadBgColor='#F7DCBB'
                                        <C> id='IN_SUM'	 width=95	 name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='퇴사자' HeadBgColor='#F7DCBB'
                                        <C> id='OUT_SUM'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='기본수당변경자' HeadBgColor='#F7DCBB'
                                        <C> id='BAS_AMT'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='근속수당변경자' HeadBgColor='#F7DCBB'
                                        <C> id='LSEV_AMT'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='고정수당변경자' HeadBgColor='#F7DCBB'
                                        <C> id='SGF_AMT'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='학자금' HeadBgColor='#F7DCBB'
                                        <C> id='SCH_AMOUNT'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='소급금' HeadBgColor='#F7DCBB'
                                        <C> id='SOGUB'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                    <G> name='기타수당' HeadBgColor='#F7DCBB'
                                        <C> id='GITA'	width=95	name='금액'	    align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}</C>
                                    </G>
                                </X>
                                <C> id='SUM'	    width=100	name='합계'	        align=right  BgColor={decode(GUBUN,'1','#EEEEEE','2','#99FFCC')}  value={AMT_SUM+ IN_SUM+OUT_SUM+BAS_AMT+LSEV_AMT+SGF_AMT+SCH_AMOUNT+SOGUB+GITA}</C>
                                <C> id='REMARK'	    width=130	name='비고'	        align=left  </C>
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
<!--<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">※ 급여총괄상세내역서의 입사자/퇴사자 내역를 먼저 조회하고 해야 최신 데이터가 반영됩니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table> -->

</form>
<!-- form 끝 -->

</body>
</html>
