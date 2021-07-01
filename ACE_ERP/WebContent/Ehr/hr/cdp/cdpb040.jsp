<!--
    ************************************************************************************
    * @Source              : cdpb040.jsp                                               *
    * @Description        : 직책기술서현황                                             *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/01  |  한학현   | 최초작성                                               *
    * 2006/09/29  |  한학현   | 개발완료                                               *
    * 2006/11/06  |  한학현   | 유효성처리 추가                                        *
    * 2007/03/24  |  김학수   | 직무코드등록을 직책기술서현황으로 변환                 *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직책기술서현황</title>
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

//		var btnList = 'FTTTFFTT';
		var btnList = 'FFFFFFFT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

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
			dsT_CD_RESPCODE.ClearData();
			ds01T_CD_RESPCODE.ClearData();
			dsT_CD_RESPCODE.Reset();

		//	fnc_ColEnabled('D');
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {
	        //이곳에 해당 코딩을 입력 하세요
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

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grd01T_CD_RESPCODE,15,"false","false");

//            fnc_ColEnabled('D');

			//form load시 무조건 직책코드 트리형태로 조회
//            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행

            try {
                dsT_CD_RESPCODE.ClearData();
				dsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb040.cmd.CDPB040CMD&S_MODE=SHR";
				dsT_CD_RESPCODE.Reset();
            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 트리구성용 DataSet                                               |
    | 2. 이름 : dsT_CD_RESPCODE                                            |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="dsT_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_CD_RESPCODE                                        |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------+
    | treeview에서 item를 클릭했을때 |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CD_RESPCODE event=OnItemClick()>
		var overId1 = "RESP_CD";
		var overId2 = "RESP_LBL";
		var overNm = tvT_CD_RESPCODE.ItemText;
		var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
		var overValue1 = dsT_CD_RESPCODE.NameValue(Row,overId1);
		var overValue2 = dsT_CD_RESPCODE.NameValue(Row,overId2);
//		alert("overNm : "+overNm+", Row : "+Row+", overValue2 : "+overValue2);

        // 직책레벨이 3이상인 경우 직책기술서 등록을 조회해온다.
        if (overValue2 < "3") {
            return;
        }

		try {
		    ds01T_CD_RESPCODE.ClearData();
			ds01T_CD_RESPCODE.DataID = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb040.cmd.CDPB040CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CD_RESPCODE.Reset();
		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->

    <Script For=ds01T_CD_RESPCODE Event="OnLoadCompleted(iCount)">

        if (iCount < 1) {

            //alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=ds01T_CD_RESPMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

//            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CD_RESPMST.CountRow );

//            fnc_ColEnabled('E');

//            document.getElementById("txtDUTY_CD").disabled  = true;
//            document.getElementById("ImgDutyCd").disabled   = true;
//            document.getElementById("txtSDUTY_CD").disabled = true;
//            document.getElementById("ImgSDutyCd").disabled  = true;

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=ds01T_CD_RESPMST Event="OnLoadError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

	<!--------------------------+
    | 그리드의 ROW를 클릭 할때  |
    +--------------------------->

    <Script For=grd01T_CD_RESPCODE Event="OnDblClick(row, col)">

        resp_cd  = ds01T_CD_RESPCODE.NameValue(row, "RESP_CD");
        var url = "/hr/cdp/cdpb021.jsp?RESP_CD="+resp_cd+"&TITLE=직책기술서_조회";
        work = "2";

        window.showModalDialog(url, self, "dialogHeight=700px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직책기술서현황</td>
					<td align="right" class="navigator">HOME/교육관리/CDP/직책관리/<font color="#000000">직책기술서현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


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

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- 내용 조회 트리 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CD_RESPCODE" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
							<param name=DataID		value="dsT_CD_RESPCODE">
							<param name=TextColumn	value="RESP_NM">
							<param name=LevelColumn	value="RESP_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 트리 끝-->
		</td>
		<td>
			<!-- 내용 조회 그리드 테이블 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grd01T_CD_RESPCODE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:375px">
                            <param name="DataID"             value="ds01T_CD_RESPCODE">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
								<C> id='RESP_CD'			width=100	    name='코드'			sort=true		align=center	</C>
								<C> id='RESP_NM'		width=184		name='직책명'		sort=true		align=left		</C>
								<C> id='UPT_YMD'			width=90		name='최종등록일'	sort=true		align=center 	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- 내용 조회 그리드 데이블 끝-->
		</td>
	</tr>
</table>

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
<!-- 직책기술서등록 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="ds01T_CD_RESPCODE">
    <Param Name="BindInfo", Value='
        <C> Col=RESP_CD    		Ctrl=txtRESP_CD			Param=value </C>
        <C> Col=RESP_NM         Ctrl=txtRESP_NM	        Param=value </C>
        <C> Col=UPT_YMD     	Ctrl=txtUPT_YMD			Param=value </C>
    '>
</object>