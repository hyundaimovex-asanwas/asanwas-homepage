<!--
    ************************************************************************************
    * @Source              : cdpb010.jsp                                               *
    * @Description        : 직책기술서코드등록                                         *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/01  |  한학현   | 최초작성                                               *
    * 2006/09/29  |  한학현   | 개발완료                                               *
    * 2006/11/06  |  한학현   | 유효성처리 추가                                        *
    * 2007/03/20  |  김학수   | 직무코드등록을 직책기술서코드등록으로 변환             *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>직책기술서코드등록</title>
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

		var btnList = 'FTTTFFTT';

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
			if(fnc_SaveItemCheck()) {
				tr01T_CD_RESPCODE.KeyValue = "SVL(I:ds01T_CD_RESPCODE=ds01T_CD_RESPCODE)";
				tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SAV_01";
				tr01T_CD_RESPCODE.post();
	            dsT_CD_RESPCODE.Reset();//트리도 재구성한다.
			} else {
				return;
			}
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (ds01T_CD_RESPCODE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

			//하위직책가 있으면 삭제 않된다
			var oDOWNRESP_CD = ds01T_CD_RESPCODE.NameValue(ds01T_CD_RESPCODE.RowPosition,"DOWNRESP_CD");
			//alert("row:"+ds01T_CD_RESPCODE.RowPosition+", down:"+oDOWNRESP_CD);
			if(oDOWNRESP_CD == "2"){
				alert("하위직책가 존재합니다.");
				return false;
			}

			// 폐기일이 있으면 삭제할 수 없다.
			var oEND_YMD = ds01T_CD_RESPCODE.NameValue(ds01T_CD_RESPCODE.RowPosition,"END_YMD");
			if(oEND_YMD != "") {
				alert("폐기일이 존재하면 삭제할 수 없습니다.");
				return false;
			}

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + ds01T_CD_RESPCODE.ColumnString(ds01T_CD_RESPCODE.RowPosition,2) + "] 자료를 제거하시겠습니까?") == false) return;
            ds01T_CD_RESPCODE.DeleteRow(ds01T_CD_RESPCODE.RowPosition);
			tr01T_CD_RESPCODE.KeyValue = "SVL(I:ds01T_CD_RESPCODE=ds01T_CD_RESPCODE)";
			tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=DEL_01";
			tr01T_CD_RESPCODE.post();
            dsT_CD_RESPCODE.Reset();//트리도 재구성한다.

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

            if(document.tvT_CD_RESPCODE.ItemText.trim() == ""){
            	alert("트리 아이템을 먼저 선택해주세요.");
	            return false;
            }

			//AddNew
            ds01T_CD_RESPCODE.AddRow();

            fnc_ColEnabled('E');

            //현재 선택된 트리의 정보를 가져온다.
			var overNm = document.tvT_CD_RESPCODE.ItemText;
			var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
			var oUPRESP_CD = dsT_CD_RESPCODE.NameValue(Row,"RESP_CD");
			var oUPRESP_NM = dsT_CD_RESPCODE.NameValue(Row,"RESP_NM");

			var oRESP_LBL=	dsT_CD_RESPCODE.NameValue(Row,"RESP_LBL");
			var oCOUNT_REM=dsT_CD_RESPCODE.NameValue(Row,"COUNT_REM");
			var dsCnt = ds01T_CD_RESPCODE.CountRow

			//하위트리로 하기위해 레벨을 올린다.
			oRESP_LBL = parseInt(oRESP_LBL)+1;
			//하위트리의 마지막 seq를 계산하여 뒤에 붙인다.
			oCOUNT_REM = oCOUNT_REM+lpad(parseInt(dsCnt)-1, 3, "0");
			//alert("oRESP_LBL:"+oRESP_LBL+", oCOUNT_REM:"+oCOUNT_REM);

            document.getElementById("txtUPRESP_CD").value = oUPRESP_CD;
            document.getElementById("txtUPRESP_NM").value = oUPRESP_NM;
            document.getElementById("txtRESP_LBL").value = oRESP_LBL;
            document.getElementById("txtCOUNT_REM").value = oCOUNT_REM;

			//현재일을 가져온다.
            document.getElementById("txtSTR_YMD").value = getToday();

			//입력 테이블로 포커스
			document.getElementById("txtRESP_CD").focus();
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
	        if (ds01T_CD_RESPCODE.IsUpdated)  {
	            if (!fnc_ExitQuestion()) return;
	        }

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
   			var f = document.form1;

			//DataSet의 변경 여부 확인
			if (!ds01T_CD_RESPCODE.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			var oRESP_CD, oRESP_NM, oSTR_YMD, oEND_YMD;
			var RowCnt = ds01T_CD_RESPCODE.CountRow;
			for(i=1; i<=RowCnt; i++){

				oRESP_CD = ds01T_CD_RESPCODE.NameValue(i,"RESP_CD");
				if(oRESP_CD.trim().length != 6){
					alert(i+"번째의 직책코드는 반드시 6자리여야 합니다.");
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtRESP_CD").focus();
					return false;
				}

				oRESP_NM = ds01T_CD_RESPCODE.NameValue(i,"RESP_NM");
				if(oRESP_NM.trim() == ""){
					alert(i+"번째의 직책명이 잘못되었습니다." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtRESP_NM").focus();
					return false;
				}

				oSTR_YMD = ds01T_CD_RESPCODE.NameValue(i,"STR_YMD");
				if(!cfDateExpr(oSTR_YMD) || oSTR_YMD.trim().length == 0){//등록일이 반드시 들어가야한다.
					alert(i+"번째의 등록일이  잘못되었습니다." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtSTR_YMD").focus();
					return false;
				}

				oEND_YMD = ds01T_CD_RESPCODE.NameValue(i,"END_YMD");
				if(!cfDateExpr(oEND_YMD) && oEND_YMD.trim().length != 0){//폐기일은 안들어가도 된다.
					alert(i+"번째의 폐기일이  잘못되었습니다." );
					ds01T_CD_RESPCODE.RowPosition = i;
					document.getElementById("txtEND_YMD").focus();
					return false;
				}

				if(oEND_YMD.trim().length != 0){//폐기일이 있다면 반드시 등록일보다 나중이어야 한다.
					oSTR_YMD = parseInt(oSTR_YMD.replaceStr("-",""));
					oEND_YMD = parseInt(oEND_YMD.replaceStr("-",""));
					if(oSTR_YMD > oEND_YMD){
						alert(i+"번째의 폐기일이 등록일보다 빠릅니다." );
						ds01T_CD_RESPCODE.RowPosition = i;
						document.getElementById("txtEND_YMD").focus();
						return false;
					}
				}

			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grd01T_CD_RESPCODE,15,"false","right");

            fnc_ColEnabled('D');

			//form load시 무조건 직책코드 트리형태로 조회
            var f = document.form1;
			//if (!valid(form1)) return;//Validation 수행


				dsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SHR";
				dsT_CD_RESPCODE.Reset();

				//idsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=template.hhh.pilot.cmd.RetrieveTreeImageListCMD";
				//idsT_CD_RESPCODE.Reset();

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

		/***************************************
		 * 입력부의 컬럼의 Disabled 속성 바꿈  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// 해당 컬럼의 속성을 Enabled로 변경
			if (prop == 'E') {
				form1.txtRESP_CD.disabled  = false;
				form1.txtRESP_NM.disabled  = false;
				form1.txtSTR_YMD.disabled  = false;
				form1.txtEND_YMD.disabled  = false;

				document.getElementById("img_HelpOn1").disabled = false;
				document.getElementById("img_HelpOn2").disabled = false;
			}
			// 해당 컬럼의 속성을 Disabled로 변경
			else if (prop == 'D') {
				form1.txtRESP_CD.disabled  = true;
				form1.txtRESP_NM.disabled  = true;
				form1.txtSTR_YMD.disabled  = true;
				form1.txtEND_YMD.disabled  = true;

				document.getElementById("img_HelpOn1").disabled = true;
				document.getElementById("img_HelpOn2").disabled = true;
			}
		}


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
    | 1. 트리 이미지 DataSet                                              |
    | 2. 이름 : idsT_CD_RESPCODE                                           |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <!--
	<object id=idsT_CD_RESPCODE classid=CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
			<param name=SyncLoad	value="true">
	</object>
	 -->

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

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : tr01T_CD_RESPCODE                                    |
    | 3. Table List : T_CD_RESPCODE                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_CD_RESPCODE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
	        //직책정보가 하나도 없으면 회사정보를 넣는다.
	        dsT_CD_RESPCODE.AddRow();
			tr01T_CD_RESPCODE.KeyValue = "SVL(I:dsT_CD_RESPCODE=dsT_CD_RESPCODE)";
			tr01T_CD_RESPCODE.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SAV";
			tr01T_CD_RESPCODE.post();
            dsT_CD_RESPCODE.Reset();//트리도 재구성한다.
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CD_RESPCODE.CountRow);
        }
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

			fnc_ColEnabled('D');
        } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CD_RESPCODE.CountRow);

	        fnc_ColEnabled('E');
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_CD_RESPCODE Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[직책코드] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("직책코드에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=tr01T_CD_RESPCODE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=tr01T_CD_RESPCODE event="OnFail()">
	    cfErrorMsg(this);
    </script>

    <!-------------------------------+
    | treeview에서 item를 클릭했을때      |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CD_RESPCODE event=OnItemClick()>
		var overId1 = "RESP_CD";
		var overId2 = "COUNT_REM";
		var overNm = tvT_CD_RESPCODE.ItemText;
		var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
		var overValue1 = dsT_CD_RESPCODE.NameValue(Row,overId1);
		var overValue2 = dsT_CD_RESPCODE.NameValue(Row,overId2);
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1);
		try {
			ds01T_CD_RESPCODE.DataID = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb010.cmd.CDPB010CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CD_RESPCODE.Reset();

		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
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
<!-- 바인딩을 위한 임시데이터 저장 -->
<input type="hidden" id="txtRESP_LBL">
<input type="hidden" id="txtCOUNT_REM">
<input type="hidden" id="txtDOWNRESP_CD">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직책기술서코드등록</td>
					<td align="right" class="navigator">HOME/교육관리/CDP/직책관리/<font color="#000000">직책기술서코드등록</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="311"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">상위코드</td>
					<td class="padding2423"><input id="txtUPRESP_CD" style="width:100%" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">상위직책명</td>
					<td class="padding2423"><input id="txtUPRESP_NM" style="width:100%" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
				<colgroup>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width="111"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">직책코드</td>
					<td class="padding2423"><input id="txtRESP_CD" style="width:100%" maxlength="6"></td>
					<td align="center" class="creamBold">직책명</td>
					<td class="padding2423"><input id="txtRESP_NM" style="width:100%" maxlength="25"></td>
					<td align="center" class="creamBold">등록일</td>
					<td class="padding2423">
						<input id="txtSTR_YMD" style="width:84" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn1" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"onclick="calendarBtn('datetype1','txtSTR_YMD','','450','134');"></a>
					</td>
					<td align="center" class="creamBold">폐기일</td>
					<td class="padding2423">
						<input id="txtEND_YMD" style="width:83" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn2" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','650','134');"></a>
					</td>
				</tr>

			</table>
		</td>
	</tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="above">
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object id="tvT_CD_RESPCODE" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:340px">
							<param name=DataID		value="dsT_CD_RESPCODE">
							<param name=TextColumn	value="RESP_NM">
							<param name=LevelColumn	value="RESP_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">

							<!-- <param name=UseImage		value="true">
							<param name=ImgDataID		value="idsT_CD_RESPCODE">
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
						<object	id="grd01T_CD_RESPCODE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:340px">
							<param name="DataID"							value="ds01T_CD_RESPCODE">
                            <param name="EdiTABLE"				value="false">
                            <param name="DragDropEnable"		value="true">
                            <param name="SortView"					value="Left">
                            <param name="VIEWSUMMARY"		value=0>
                            <param name="Format"						value="
								<C> id='RESP_CD'		width=100	    name='코드'			sort=true		align=center									</C>
								<C> id='RESP_NM'		width=184		name='직책명'		sort=true		align=left		 								</C>
								<C> id='STR_YMD'		width=90		name='등록일'		sort=true		align=center 								</C>
								<C> id='END_YMD'		width=90		name='폐기일'		sort=true		align=center									</C>
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

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_CD_RESPCODE                                   |
    | 3. Table List : T_CD_RESPCODE                                 |
    +----------------------------------------------->
	<object id="bndT_CD_RESPCODE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="ds01T_CD_RESPCODE">
		<Param Name="BindInfo", Value="
			<C>Col='UPRESP_CD'				Ctrl='txtUPRESP_CD'				    Param=value</C>
			<C>Col='UPRESP_NM'			    Ctrl='txtUPRESP_NM'				    Param=value</C>
			<C>Col='RESP_CD'				Ctrl='txtRESP_CD'					Param=value</C>
			<C>Col='RESP_NM'				Ctrl='txtRESP_NM'					Param=value</C>
			<C>Col='STR_YMD'				Ctrl='txtSTR_YMD'					Param=value</C>
			<C>Col='END_YMD'				Ctrl='txtEND_YMD'					Param=value</C>
			<C>Col='RESP_LBL'				Ctrl='txtRESP_LBL'					Param=value</C>
			<C>Col='COUNT_REM'			    Ctrl='txtCOUNT_REM'			        Param=value</C>
			<C>Col='DOWNRESP_CD'            Ctrl='txtDOWNRESP_CD'			    Param=value</C>
	    ">
	</object>
