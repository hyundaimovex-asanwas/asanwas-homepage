<!--
***********************************************************************
* @source      : butb010.jsp
* @description : 해외출장품의결재 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2010/03/11      권혁수        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>해외출장품의결재(butc010)</title>
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

        var today = getToday();
        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            var f = document.form1;

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN_SHR").value;
            var app_status = document.getElementById("cmbAPP_STATUS_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;

            if(!fnc_SearchItemCheck()) return;//검색조건 유효성 검사

            //관리자는 모든 조회가 가능
			dsT_DI_DISPATCH.dataid = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb010.cmd.BUTB010CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&APP_YN="+app_yn+"&APP_STATUS="+app_status+"&PENO_NO="+eno_no+"&ENO_NO="+our_man;
			dsT_DI_DISPATCH.reset();

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

            if(dsT_DI_DISPATCH.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
		
            //처리상황이 요청이 아닌경우는 삭제 할 수 없음
            if(!(dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,'APP_STATUS') == '1')){
                alert("상신 이후의 데이터는 삭제할 수 없습니다!");
                return;
            }

			if(confirm("[품의번호:"+dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,'ORD_NO')+"]의 정보를 삭제하시겠습니까?")){
				dsT_DI_DISPATCH.DeleteRow(dsT_DI_DISPATCH.RowPosition);
				trT_DI_DISPATCH.KeyValue = "tr01(I:dsT_DI_DISPATCH=dsT_DI_DISPATCH)";
				trT_DI_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.but.b.butb010.cmd.BUTB010CMD&S_MODE=DEL";
				trT_DI_DISPATCH.post();
			}

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

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

			document.getElementById("cmbGBN1_SHR").value = "";
			document.getElementById("cmbGBN2_SHR").value = "";

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("txtOUR_MAN_SHR").value = "";
            document.getElementById("txtOUR_MAN_NM_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_DISPATCH.ClearData();

            document.getElementById("txtSTR_YMD_SHR").focus();
        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {
			if(dsTemp != "Modal"){
	            if (dsT_DI_DISPATCH.IsUpdated)  {
	                if (!fnc_ExitQuestion())  return;
	            }
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }else{
                window.close();
            }
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

 			//시작년월이 없으면 조회못함.
			if(str_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월을 입력하세요.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//시작년월이 잘못되었으면 조회못함.
			if(str_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("시작년월이 잘못되었습니다.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 없으면 조회못함.
			if(end_ymd.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월을 입력하세요.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//종료년월이 잘못되었으면 조회못함.
			if(end_ymd.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("종료년월이 잘못되었습니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//종료년월이 시작년월보다 크면 않된다.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
					alert("종료년월이 시작년월보다 빠릅니다.");
					document.getElementById("txtEND_YMD_SHR").focus();
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

            //document.getElementById("txtSTR_YMD_SHR").value = today.substring(0,8)+"01";
            document.getElementById("txtSTR_YMD_SHR").value = addDate("M", today, -1).substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid(form1.grdT_DI_DISPATCH,0,"false","false");      // Grid Style 적용

			//미결재 자동조회
			document.getElementById("cmbAPP_YN_SHR").value = "R";
			fnc_SearchList();

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

	<!----------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							        |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_DISPATCH)	|
    | 3. 사용되는 Table List(T_DI_DISPATCH) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------------------+
    | 1. 카피용 DataSet							                |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_STATE)	|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_DISPATCH_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!----------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			        |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_DISPATCH)	|
    | 3. 사용되는 Table List(T_DI_DISPATCH)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_DISPATCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DISPATCH Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

		<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsPROC Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=trT_DI_DISPATCH Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_DISPATCH event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_DISPATCH event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_DISPATCH event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {

			if(dsT_DI_DISPATCH.CountRow < 1) {
				alert("결재할 자료가 없습니다.");
				return;
			}

            //선택된 ROW를 dsT_DI_BUSINESSTRIP_STATE_CP 복사하여 넘겨준다.
			cfCopyDataSet(dsT_DI_DISPATCH, dsT_DI_DISPATCH_CP, "copyHeader=yes,rowFrom="+dsT_DI_DISPATCH.RowPosition+",rowCnt=1");

            var url = "/hr/but/butb020.jsp?ORD_NO=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"ORD_NO") + "&ENO_NO=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"PENO_NO") + "&APP_STATUS=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"APP_STATUS") + "&APP_CMT=" + dsT_DI_DISPATCH.NameValue(dsT_DI_DISPATCH.RowPosition,"APP_CMT");
			window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:710px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_SearchList();

		}
	</script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">해외출장품의결재</td>
					<td align="right" class="navigator">HOME/근태관리/해외출장/<font color="#000000">해외출장품의결재</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="60"></col>
					<col width="220"></col>
					<col width="80"></col>
					<col width="170"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">기&nbsp;&nbsp;간&nbsp;</td>
					<td>
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
					    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
					</td>
					<td class="searchState" align="right">결재구분&nbsp;</td>
					<td>
						<select id="cmbAPP_YN_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="" >전체</option>
							<option value="Y" >결재</option>
                            <option value="R" >미결재</option>
						</select>
					</td>
					<td class="searchState" align="right">상태구분&nbsp;</td>
					<td>
						<select id="cmbAPP_STATUS_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="" >전체</option>
							<option value="1" >저장</option>
                            <option value="2" >상신</option>
                            <option value="3" >결재미완료</option>
                            <option value="4" >결재완료</option>
                            <option value="5" >반송</option>
                            <option value="6" >부결</option>
                            <option value="7" >전표처리완료</option>
						</select>
					</td>
				</tr>
				<tr class="paddingTop5">
					<td class="searchState" align="right">상신자&nbsp;</td>
					<td >
						<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="9" onChange="fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');">
						<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
					</td>
					<td class="searchState" align="right">결재자&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9" onChange="fnc_GetEnoNm('txtOUR_MAN_SHR', 'txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="20">
						<td width="360" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td width="320">※결재를 원하시면 해당 출장품의서를 더블클릭 하세요.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_DISPATCH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
						<param name="DataID" value="dsT_DI_DISPATCH">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=30	name="NO"			align=center	value={String(Currow)}		</C>
                            <C> id="ORD_NO"		width=80	name="품의번호"		align=center     </C>
                            <C> id="PENO_NO"	width=100	name="상신자"		align=center    value={PJOB_NM&" "&PENO_NM}	</C>
							<C> id="ORD_DATE"	width=110	name="상신일-시간"	align=center     </C>
							<C> id="APP_ENO_NO"	width=100	name="現결재완료자" align=center    value={APP_JOB_NM&" "&APP_ENO_NM}</C>
                            <C> id="APP_DATE"	width=110	name="결재일/시간"	align=center     </C>
							<C> id="APP_CMT"	width=250	name="결재의견"	    align=left	     </C>
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