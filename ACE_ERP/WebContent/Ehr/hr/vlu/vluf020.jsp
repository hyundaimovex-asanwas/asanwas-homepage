<!--
    ************************************************************************************
    * @Source         : vluf020.jsp 					                                                                                 *
    * @Description    : 직무기초.                                                                                                      *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!                         *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/29  |  안준성   | 최초작성                                                                                           *
    * 2006/10/12  |  한학현   | 입력단 추가, 검색단 수정                                                                    *
    * 2006/11/06  |  한학현   | 유효성처리 추가                                                                                *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

	<head>
	<title>직무기초(vluf020)</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
            dsT_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR&cmbDUTY_NO_SHR="+document.getElementById("cmbDUTY_NO_SHR").value;
            dsT_EV_DUTYBAS.Reset();

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

			if( !fnc_SaveItemCheck() )	return;

			//트랜잭션 전송
			trT_EV_DUTYBAS.KeyValue = "SVL(I:dsT_EV_DUTYBAS=dsT_EV_DUTYBAS)";
			trT_EV_DUTYBAS.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SAV";
			trT_EV_DUTYBAS.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_DUTYBAS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_DUTYBAS.NameValue(dsT_EV_DUTYBAS.RowPosition,'DUTY_NO') + "] 자료를 제거하시겠습니까?") == false) return;
			dsT_EV_DUTYBAS.DeleteRow(dsT_EV_DUTYBAS.RowPosition);
			trT_EV_DUTYBAS.KeyValue = "SVL(I:dsT_EV_DUTYBAS=dsT_EV_DUTYBAS)";
			trT_EV_DUTYBAS.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=DEL";
			trT_EV_DUTYBAS.post();

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

            //해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_DUTYBAS.CountColumn == 0) {
                dsT_EV_DUTYBAS.setDataHeader("DUTY_NO:INT:KEYVALUETYPE, DUTY_STDT:STRING:NOTNULL, DUTY_ENDT:STRING:NOTNULL, DUTY_TITLE:STRING:NOTNULL");
            }

            //AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_DUTYBAS.AddRow();

            fnc_ColEnabled('E');

            //자동으로 차수 생성
            if (dsT_EV_DUTYBAS.CountRow == 1) {
            	document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition,"DUTY_NO") = 1;
            }else{
            	document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition,"DUTY_NO") = document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition-1,"DUTY_NO")+1;
            }

			//조사시작일로 포커스
            document.getElementById("txtDUTY_STDT").focus();
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

			dsT_EV_DUTYBAS.ClearData();

			fnc_ColEnabled('D');

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_EV_DUTYBAS.IsUpdated)  {

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

        	if (!dsT_EV_DUTYBAS.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 0;
			var oDUTY_NO, oDUTY_STDT, oDUTY_ENDT, oDUTY_TITLE;
			var RowCnt = dsT_EV_DUTYBAS.CountRow;

			for(i=1; i<=RowCnt; i++){

				oDUTY_NO = dsT_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				if(oDUTY_NO.toString().trim().length == 0 || oDUTY_NO.toString().trim() == "0") {
					alert("조사회차를 입력하세요.");
					dsT_EV_DUTYBAS.RowPosition = i;
					document.medDUTY_NO.Focus();
					return false;
				}

				oDUTY_STDT = dsT_EV_DUTYBAS.NameValue(i,"DUTY_STDT");
				if(!cfDateExpr(oDUTY_STDT) || oDUTY_STDT.trim().length == 0){//시작일이 반드시 들어가야한다.
					alert("시작일이  잘못되었습니다." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_STDT").focus();
					return false;
				}

				oDUTY_ENDT = dsT_EV_DUTYBAS.NameValue(i,"DUTY_ENDT");
				if(!cfDateExpr(oDUTY_ENDT) || oDUTY_ENDT.trim().length == 0){//종료일이 반드시 들어가야한다.
					alert("종료일이  잘못되었습니다." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_ENDT").focus();
					return false;
				}

				oDUTY_STDT = parseInt(oDUTY_STDT.replaceStr("-",""));
				oDUTY_ENDT = parseInt(oDUTY_ENDT.replaceStr("-",""));
				if(oDUTY_STDT > oDUTY_ENDT){
					alert("종료일이 시작일보다 빠릅니다." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_ENDT").focus();
					return false;
				}

				oDUTY_TITLE = dsT_EV_DUTYBAS.NameValue(i,"DUTY_TITLE");
				if(oDUTY_TITLE.trim() == ""){
					alert("조사제목(내용)을 입력하세요.");
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_TITLE").focus();
					return false;
				}

			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_DUTYBAS,15,"false","false");

            //시작시 조사회차를 가져온다.
            ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
            ds01T_EV_DUTYBAS.Reset();

            fnc_ColEnabled('D');

			//조회
            //fnc_SearchList();
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요                *
         *******************************************************/

        /***************************************
		 * 입력부의 컬럼의 Disabled 속성 바꿈  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// 해당 컬럼의 속성을 Enabled로 변경
			if (prop == 'E') {
				form1.medDUTY_NO.readonly    = false;
				form1.txtDUTY_STDT.disabled  = false;
				form1.txtDUTY_ENDT.disabled  = false;
				form1.txtDUTY_TITLE.disabled = false;
			}
			// 해당 컬럼의 속성을 Disabled로 변경
			else if (prop == 'D') {
				form1.medDUTY_NO.readonly    = true;
				form1.txtDUTY_STDT.disabled  = true;
				form1.txtDUTY_ENDT.disabled  = true;
				form1.txtDUTY_TITLE.disabled = true;
			}
		}



    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                 *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)         |
    | 3. 사용되는 Table List(T_EV_GRDRATE)                    |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)           |
    | 3. 사용되는 Table List(T_EV_GRDRATE)                     |
    +----------------------------------------------->
    <Object ID ="trT_EV_DUTYBAS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!----------------------------------------------+
    | 1. 조회용 DataSet                                                      |
    | 2. 이름 : ds01T_EV_DUTYBAS                                    |
    | 3. Table List : T_EV_DUTYBAS                                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');
        } else {
            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_DUTYBAS.CountRow);

            fnc_ColEnabled('E');
        }

  	 	grdT_EV_DUTYBAS.SetColumn("DUTY_NO");//set focus
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
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

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYBAS Event="OnLoadError()">
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
    <Script For=dsT_EV_DUTYBAS Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[회차/조사시작일/조사종료일/조사제목] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("회차/조사시작일/조사종료일/조사제목에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_DUTYBAS event="OnSuccess()">
	    fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_DUTYBAS event="OnFail()">
	    cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">직무기초</td>
					<td align="right" class="navigator">HOME/인사평가/직무관리/<font color="#000000">직무기초</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<tr>
								<td align="right" width="10"></td>
								<td align="center" class="searchState">조사회차</td>
								<td width="50">
									<select id="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option selected>전체</option>
									</select>
								</td>
							<td align="left" width="630"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<td>&nbsp;</td>

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width="180"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">조사회차</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medDUTY_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60px">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=4>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">조사시작일</td>
					<td class="padding2423">
						<input id="txtDUTY_STDT" style="width:84;padding-left:10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUTY_STDT','','300','99');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td align="center" class="creamBold">조사종료일</td>
					<td class="padding2423">
						<input id="txtDUTY_ENDT" style="width:84;padding-left:10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUTY_ENDT','','595','99');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">조사제목(내용)</td>
					<td class="padding2423" colspan="5"><input id="txtDUTY_TITLE" style="width:100%" maxlength="50"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
						<object	id="grdT_EV_DUTYBAS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
							<param name="DataID"					value="dsT_EV_DUTYBAS">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='DUTY_NO'		width=61		name='회차'						sort=true		align=center												</C>
								<C> id='DUTY_STDT'	width=110		name='조사시작일' 			sort=true		align=center												</C>
								<C> id='DUTY_ENDT'	width=110		name='조사종료일'			sort=true		align=center												</C>
								<C> id='DUTY_TITLE'	width=483		name='조사제목(내용)'							align=left													</C>
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
    | 2. 이름 : bndT_EV_DUTYBAS                                   |
    | 3. Table List : T_EV_DUTYBAS                                 |
    +----------------------------------------------->
	<object id="bndT_EV_DUTYBAS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYBAS">
		<Param Name="BindInfo", Value="
			<C>Col='DUTY_NO'			Ctrl='medDUTY_NO'		Param=text	</C>
			<C>Col='DUTY_STDT'		Ctrl='txtDUTY_STDT'		Param=value</C>
			<C>Col='DUTY_ENDT'		Ctrl='txtDUTY_ENDT'		Param=value</C>
			<C>Col='DUTY_TITLE'		Ctrl='txtDUTY_TITLE'		Param=value</C>
	    ">
	</object>
