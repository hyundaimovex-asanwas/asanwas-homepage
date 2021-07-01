<!--
***********************************************************************
* @source      : weld070.jsp
* @description : 성수기 신청자 목록 PAGE
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
<title>성수기 신청자 목록(weld070)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;

            if(ord_no == "") {
                document.getElementById("btnLOTTERY").style.visibility = "hidden";
            } else {
                document.getElementById("btnLOTTERY").style.visibility = "visible";
            }

			dsT_WL_CONDOLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld070.cmd.WELD070CMD&S_MODE=SHR&ORD_NO="+ord_no;
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

      		if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;

			var url = "weld070_PV.jsp?ORD_NO="+ord_no;
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

			document.getElementById("cmbORD_NO_SHR")[0].selected = true;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOLOT.ClearData();

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

			cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"false","false");      // Grid Style 적용

			//콘도 성수기 관리번호 (weld050 사용)
			dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
			dsT_WL_CONDOSSN.Reset();

            document.getElementById('cmbORD_NO_SHR').focus();


            if(document.getElementById("cmbORD_NO_SHR").value == "") {
                document.getElementById("btnLOTTERY").style.visibility = "hidden";
            }
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*************************
         * 16. 콘도 추첨 실시    *
         ************************/
		function fnc_lottery() {

			if(dsT_WL_CONDOLOT.CountRow<1){
				alert("추첨 대상자가 없습니다.");
				return;
			}

            var msg;
			if(dsT_WL_CONDOLOT.NameValue(1,'LOTTERY') > 0)
                msg = "성수기관리번호:["+dsT_WL_CONDOLOT.NameValue(1,'ORD_NO')+"]는 이미 추첨이 완료되었습니다!\n다시 초기화 후 추첨 하시겠습니까?";
			else
                msg = "성수기관리번호:["+dsT_WL_CONDOLOT.NameValue(1,'ORD_NO')+"]의 추첨을 하시겠습니까?";

            if(!confirm(msg))
                return;



            //무조건 insert
            dsT_WL_CONDOLOT.UseChangeInfo = false;

			trT_WL_CONDOLOT.KeyValue = "tr01(I:dsT_WL_CONDOLOT=dsT_WL_CONDOLOT)";
			trT_WL_CONDOLOT.action   = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld070.cmd.WELD070CMD&S_MODE=SAV";
			trT_WL_CONDOLOT.post();
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

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOSSN) |
    | 3. 사용되는 Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. 카피용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CONDOLOT) |
    | 3. 사용되는 Table List(T_WL_CONDOLOT)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOLOT_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CONDOLOT)	|
    | 3. 사용되는 Table List(T_WL_CONDOLOT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_CONDOLOT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {
			var oOption;
			for(var i=1 ; i<=iCount ; i++) {

				oOption         = document.createElement("OPTION");
				oOption.text    = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
				oOption.value   = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");

				document.getElementById("cmbORD_NO_SHR").add(oOption);
			}
			document.getElementById("cmbORD_NO_SHR").selectedIndex = 0;
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

    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

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

    <Script For=dsT_WL_CONDOSSN Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_CONDOLOT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_CONDOLOT event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_WL_CONDOLOT event="OnDblClick(row,colid)">

		if(row < 1) {

			return;

		} else {

			var cnt = dsT_WL_CONDOLOT.NameValue(row,"APP_CNT");

			if(cnt < 1){
				alert("현재 신청자가 없습니다.");
				return false;
			}

			url = "/hr/wel/weld071.jsp";

			//선택된 ROW를 dsT_WL_CONDOLOT_CP에 복사하여 Modal창에 dsT_WL_CONDOLOT_CP를 넘겨준다.
			cfCopyDataSet(dsT_WL_CONDOLOT, dsT_WL_CONDOLOT_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog(url, dsT_WL_CONDOLOT_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">성수기 신청자 목록</td>
					<td align="right" class="navigator">HOME/복리후생/콘도/<font color="#000000">성수기 신청자 목록</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="120"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">성수기관리번호</td>
								<td class="padding2423">
                                    <select id="cmbORD_NO_SHR" name="cmbORD_NO_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
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
					<td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnLOTTERY','','/images/button/btn_LotteryOver.gif',1)"><img src="/images/button/btn_LotteryOn.gif" name="btnLOTTERY" width="60" height="20" border="0" align="absmiddle" onClick="fnc_lottery()"></a>
                    </td>
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
						<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_CONDOLOT">
							<param name="Format"					value="
								<C> id={currow}	   width=39   name='NO'				align=center </C>
								<C> id='ORD_NO'	   width=90   name='성수기관리번호'	align=center </C>
								<C> id='STR_YMD'   width=90   name='이용시작일'		align=center </C>
								<C> id='CN_NM'	   width=90	  name='콘도'			align=left </C>
								<C> id='CO_NM'	   width=235  name='지역'			align=left </C>
								<C> id='ROOM_CNT'  width=70	  name='객실수'			align=right </C>
								<C> id='STAY_CNT'  width=70	  name='이용일수'		align=right </C>
								<C> id='APP_CNT'   width=80	  name='현재신청자수'	align=right </C>
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