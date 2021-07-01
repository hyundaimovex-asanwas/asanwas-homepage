<!--
*****************************************************
* @source       : gunc020.jsp
* @description : 휴일근무결재처리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      오대성        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>휴일근무결재처리(gunc020)</title>
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
		var btnList = 'TFFTFFFT';

        var today = getToday();

        var dsTemp = window.dialogArguments;
        var curRowPosition = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value;
			var HOL_YME_SHR = document.getElementById("txtHOL_YME_SHR").value;
			var GUN_GBN_SHR = document.getElementById("cmbGUN_GBN_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;


            if(!fnc_SearchItemCheck()) return;


            //조회 해당년월을 저장한다.
            document.getElementById("hidTAG_YM").value = HOL_YMD_SHR;

			dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc020.cmd.GUNC020CMD"
                                   + "&S_MODE=SHR"
                                   + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                   + "&HOL_YME_SHR="+HOL_YME_SHR
                                   + "&GUN_GBN_SHR="+GUN_GBN_SHR
                                   + "&APP_YN_SHR="+app_yn+"&DPT_CD="+DPT_CD+"&OUR_MAN="+our_man;
			dsT_DI_APPROVAL.reset();
			dsT_DI_APPROVAL.RowPosition = curRowPosition;

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

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

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

            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("cmbAPP_YN").value ='';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("txtOUR_MAN_SHR").value = '';
            document.getElementById("txtOUR_MAN_NM_SHR").value = '';
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtHOL_YMD_SHR").focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
				if (dsT_DI_APPROVAL.IsUpdated)  {
					if (!fnc_ExitQuestion()) return;
				}

				frame = window.external.GetFrame(window);
				frame.CloseFrame();

            }else{
                window.close();
            }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value; // 시작년월

            if(HOL_YMD_SHR == ""){
                alert("검색 기간을 입력하세요!");
                document.getElementById("txtHOL_YMD_SHR").focus();
                return false;
            }

            return true;
        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_APPROVAL.IsUpdated) {
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


			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style 적용

            //CHECK_DATE!!!
            //창이 열릴때 현재날짜를 비교해 15일 전 / 후을 가지고 온다.
            var todayList   = getTodayArray();
            var hol_ymd     = getToday();

            hol_ymd     = addDate("D", getToday(), -15);
            document.getElementById("txtHOL_YMD_SHR").value = hol_ymd; // 해당년월 From
            hol_ymd     = addDate("D", getToday(), 15);
            document.getElementById("txtHOL_YME_SHR").value = hol_ymd; // 해당년월 To

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

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dataSet" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_APPROVAL)		   |
    | 3. 사용되는 Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>



    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">
        var param = new String();
		curRowPosition = dsT_DI_APPROVAL.RowPosition;
        if(row < 1) {
            return;
        } else {
			//휴일근무 param 값 Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //변수들 정의
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");
          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");
          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            }

            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6"){
                window.showModalDialog("/hr/gun/gunc071.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //휴일근무 사전신청
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7"){
                window.showModalDialog("/hr/gun/gunc091.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //휴일근무 결과보고
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                window.showModalDialog("/hr/gun/gunc012.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            }
			fnc_SearchList();
        }


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">휴일근무결재처리</td>
					<td align="right" class="navigator">HOME/근태관리/휴일근무/<font color="#000000">휴일근무결재처리</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
       <td height="35" class="paddingTop5">
           &nbsp;&nbsp;※ 해당 결재정보를 더블클릭하면 세부내역을 조회할 수 있습니다.
       </td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                                <col width="230"></col>
                                <col width="80"></col>
                                <col width="200"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">신청년월&nbsp;</td>
                                <td class="padding2423">
									<input id="txtHOL_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHOL_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHOL_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YMD_SHR','','70','110');"></a> ~
									<input id="txtHOL_YME_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHOL_YME_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHOL_YME_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YME_SHR','','70','110');"></a>
                                    <input type="hidden" id="hidTAG_YM">
								</td>
								<td class="searchState" align="right">결재종류&nbsp;</td>
						    	<td class="padding2423" align="left">
								<select id="cmbGUN_GBN_SHR" style="WIDTH: 100px" onChange="fnc_SearchList()">
									<option value="A">모두</option>
									<option value="R">사전승인</option>
									<option value="H">결과보고</option>
									<option value="J">수당정산</option>
								</select>
								</td>
								<td class="searchState" align="right">결재상태</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >전체</option>
			                            <option value="Y" >결재</option>
			                            <option value="N" >부결</option>
			                            <option value="A" >미결</option>
			                        </select>
                                </td>
                            </tr>
				<tr class="paddingTop5" >
					<td align="right" class="searchState">소&nbsp;&nbsp;속&nbsp;</td>
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" class="input_ReadOnly"  readonly maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                    </td>
					<td class="searchState" align="right">결재자&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                value="dsT_DI_APPROVAL">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    width=39    name='NO'           align=center    value={String(Currow)}</C>
                                <FC> id='APP_GBN_NM' width=100   name='결재구분'     align=center </FC>
                                <FC> id='APP_TITLE'  width=440   name='제목'         align=left   </FC>
                                <FC> id='APP_YMD'    width=110   name='상신일자'     align=center </FC>
                                <C> id='PENO_NM'    width=90    name='상신자'       align=center  </C>
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