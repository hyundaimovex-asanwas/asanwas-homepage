<!--
*****************************************************
* @source      : vluf050.jsp
* @description : 직무별조사현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/24      오대성        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<script>
//Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다.
var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}
</script>
<html>
<head>
<title>직무별조사현황(vluf015)</title>
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
		
		var btnList = 'FFFTFFFT';
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
			
			//이곳에 해당 코딩을 입력 하세요

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
			
			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

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

			dsT_EV_DUTYRSH.ClearData();
			document.form1.tvT_CM_DUTYMST.Reset();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();
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
            
			cfStyleGrid(form1.grdT_EV_DUTYRSH,0,"false","right")      // Grid Style 적용

			//form load시 무조건 직무코드 트리형태로 조회
            var f = document.form1;
			
			try {
				dsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf010.cmd.VLUF010CMD&S_MODE=SHR";
				dsT_CM_DUTYMST.Reset();
			} catch ( exception ) {
				fcWindowsXpSp2Notice(false);
				return;
			}
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

	</script>
</head>

    <!--***************************************************************************************
    *                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
    *                                                                                         *
    *****************************************************************************************-->

    <!----------------------------------------------+
    | 1. 트리구성용 DataSet                         |
    | 2. 이름 : dsT_CM_DUTYMST                      |
    | 3. Table List : T_CM_DUTYMST                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : ds01T_CM_DUTYMST                    |
    | 3. Table List : T_CM_DUTYMST                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_EV_DUTYRSH						|
    | 3. Table List : T_EV_DUTYRSH                  |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYRSH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------------------+
    | 1. 카피용 DataSet												   |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_DUTYRSH)					   |
    | 3. 사용되는 Table List(T_EV_DUTYRSH, T_CM_DUTYMST)			   |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_DUTYRSH_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        //직무정보가 하나도 없으면 회사정보를 넣는다.
	        dsT_CM_DUTYMST.AddRow();
			tr01T_CM_DUTYMST.KeyValue = "SVL(I:dsT_CM_DUTYMST=dsT_CM_DUTYMST)";
			tr01T_CM_DUTYMST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf010.cmd.VLUF010CMD&S_MODE=SAV";
			tr01T_CM_DUTYMST.post();
            dsT_CM_DUTYMST.Reset();//트리도 재구성한다.
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
	        
        }
		//조사회차를 가져오기 위해 VLUF020CMD를 사용
        ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
        ds01T_EV_DUTYBAS.Reset();
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            alert("직무 기초 정보에 설정된 회차가 없습니다.");
        } else {
	        //조회 자료가 1건 이상일 때 처리 할 내용 코딩
			var i;
			var oOption;

			//검색단의 콤보박스에 조사회차를 생성
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO_SHR").add(oOption);
			}

        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CM_DUTYMST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYRSH Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
	        fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_EV_DUTYRSH Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYRSH Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>


    <!------------------------------------+
    | treeview에서 item를 클릭했을때      |
    +------ ------------------------------>
	<script language=JavaScript for=tvT_CM_DUTYMST event=OnItemClick(index)>
 
		var overNm = tvT_CM_DUTYMST.ItemText;
		var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
		var duty_cd = dsT_CM_DUTYMST.NameValue(Row,'DUTY_CD');
//		alert("overNm=>"+overNm+",Row=>"+Row+",duty_cd=>"+duty_cd);
		try {
			dsT_EV_DUTYRSH.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf050.cmd.VLUF050CMD&S_MODE=SHR&DUTY_NO="+getElementById('cmbDUTY_NO_SHR').value+"&DUTY_CD="+duty_cd;
			dsT_EV_DUTYRSH.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}

	</script>

	<!--------------------------+
    | 그리드의 ROW를 클릭 할때  |
    +--------------------------->
	<script language=JavaScript for=grdT_EV_DUTYRSH event="OnClick(row,colid)">
		
		if(row < 1) {
			return;
		} else {
			var url = "/hr/vlu/vluf041.jsp?HEAD_NM="+ds01T_EV_DUTYBAS.NameValue(1,'HEAD_NM')+"&TITLE=직무별조사현황_상세&SHOW=ONLY";
			//선택된 ROW를 dsT_EV_DUTYRSH_CP에 복사하여 Modal창에 dsT_EV_DUTYRSH_CP를 넘겨준다.
			cfCopyDataSet(dsT_EV_DUTYRSH, dsT_EV_DUTYRSH_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog(url, dsT_EV_DUTYRSH_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무별조사현황</td>
					<td align="right" class="navigator">HOME/인사평가/직무관리/직무조사/<font color="#000000">직무별조사현황</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="100"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
							<tr>
								<td align="center" class="searchState">조사회차</td>
								<td width="50">
									<select id="cmbDUTY_NO_SHR" name="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
									</select>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td>
			<!-- 내용 조회 트리 시작-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
							<param name=DataID		value="dsT_CM_DUTYMST">
							<param name=TextColumn	value="DUTY_NM">
							<param name=LevelColumn	value="DUTY_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CM_DUTYMST">
							<param name=ImgCColumn	value="ImgC">
							<param name=ImgDColumn	value="ImgD">
							<param name=ImgOColumn	value="ImgO"> -->
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
        				<object	id="grdT_EV_DUTYRSH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500;height:375px;">
        					<param name="DataID"				value="dsT_EV_DUTYRSH">
        					<param name="EdiTABLE"				value="false">
        					<param name="DragDropEnable"		value="true">
        					<param name="SortView"				value="Left">
        					<param name="VIEWSUMMARY"			value=0>
        					<param name="Format"				value="
        								<C> id={currow}		width=50        name='순번'		align=center </C>
										<C> id='HEAD_NM'	width=90       name='본부'		align=left </C>
										<C> id='DPT_NM'		width=90       name='부서'		align=left </C>
										<C> id='JOB_NM'		width=55       name='직위'		align=left </C>
        								<C> id='ENO_NO'		width=60        name='사번'	    align=center </C>
        								<C> id='ENO_NM'		width=60        name='성명'	    align=center </C>
        								<C> id='DUTY_YMD'	width=75        name='작성일'	align=center </C>
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

</body>
</html>