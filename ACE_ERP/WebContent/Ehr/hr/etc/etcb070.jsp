<!--
*****************************************************
* @source       : etcb070.jsp
* @description : 근태현황 결재처리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2009/10/20      권혁수        최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>근태현황 결재처리</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건(기간)
			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

            if(!fnc_SearchItemCheck()) return;

<%
    //관리자는 모든 조회 및 미상신도 볼수 있다.
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

    		dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb070.cmd.ETCB070CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd;
    		dsT_DI_APPROVAL.reset();
<%
	}else{
%>
            var dpt_cd  = document.getElementById("txtDPT_CD_SHR").value.trim();
            dpt_cd = (dpt_cd == '') ? "%" : dpt_cd;

            dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb070.cmd.ETCB070CMD&S_MODE=SHR&STR_YMD_SHR="+str_ymd+"&END_YMD_SHR="+end_ymd+"&DPT_CD_SHR="+dpt_cd;
            dsT_DI_APPROVAL.reset();
<%
	}
%>
            document.getElementById("txtSTR_YMD_SHR").focus();

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

	        //document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            //document.getElementById("txtEND_YMD_SHR").value = today;
            document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtSTR_YMD_SHR").focus();

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

            var str_ymd = document.getElementById("txtSTR_YMD_SHR");
            var end_ymd = document.getElementById("txtEND_YMD_SHR");

            if(str_ymd.value == "" && end_ymd.value == ""){
                alert("검색 기간을 입력하세요!");
                str_ymd.focus();
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

<%
    //관리자는 데이터양때문에 날짜 기본값 변경
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
			document.getElementById("txtSTR_YMD_SHR").value = today;
            document.getElementById("txtEND_YMD_SHR").value = today;
<%
	}else{
%>
			document.getElementById("txtSTR_YMD_SHR").value = getToday();
			document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);
<%
    }
%>

            fnc_SearchList();//자동조회
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
    | 1. 카피용 DataSet                             |
    | 2. 이름 : dsT_DI_APPROVAL_CP                  |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

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
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {
            //if(dsT_DI_APPROVAL.NameString(row, "ENO_NO") == "<%=box.getString("SESSION_ENONO") %>") {
                //선택된 ROW를 dsT_DI_CHANGE_CP 복사하여 guna061에 dsT_DI_CHANGE_CP 넘겨준다.
    			cfCopyDataSet(dsT_DI_APPROVAL, dsT_DI_APPROVAL_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

    			window.showModalDialog("/hr/etc/etcb071.jsp", dsT_DI_APPROVAL_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                fnc_SearchList();
            //} else {
            //    alert("결재자가 아니라 조회하실 수 없습니다.");
            //}
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">근태현황 결재처리</td>
					<td align="right" class="navigator">HOME/기초정보/통합결재/<font color="#000000">근태현황 결재처리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="imgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
								<td class="searchState" align="right">해당기간&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
                                </td>
<%
if(box.getString("SESSION_ROLE_CD").equals("1001") || box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

                                <td class="searchState" align="right">소 속</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onfocusout="fnc_GetCommNm('A4', 'txtDPT_CD_SHR', 'txtDPT_NM_SHR')" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')">
                                    </a>
                                </td>
<%
}
%>
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
		<td align="center" width="40%" valign="bottom">
        ※결재를 원하시면 해당 근태내역을 더블클릭 하세요.
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
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Format"				value="
                                <C> id='{CUROW}'    width=29    name='NO'           align=center    value={String(Currow)}</C>
								<C> id='REQ_NO'     width=80    name='등록번호'   align=center </C>
								<C> id='DPT_NM'		width=110	name='소속'		    align=center </C>
								<C> id='PENO_NM'	width=90	name='상신자'	    align=center </C>
								<C> id='PENO_NO'	width=70	name='상신자사번'   align=center show=false </C>
								<C> id='ENO_NM'	    width=90	name='결재자'	    align=center </C>
								<C> id='ENO_NO'	    width=70	name='결재자사번'   align=center show=false </C>
 								<C> id='APP_YN' 	width=60	name='결재현황'	    align=center Value={DECODE(APP_YN,'Y','결재','N','부결',DECODE(PENO_NO,NULL,'미상신','미결'))} </C>
								<C> id='APP_TIME'	width=100	name='결재시간'	    align=center </C>
                                <C> id='GUN_GBN_NM'	width=220	name='결재구분'	    align=center Value={DECODE(GUN_GBN,'C','일일근태','U','변경신청','R','대체근무','','일일근태')} </C>
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