<!--
    ************************************************************************************
    * @Source         : stoa010.jsp 					                               *
    * @Description    :  주주등록.                                                     *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/27  |  한학현   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>주주현황</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

		//버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
		var btnList = 'TFTTFTTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var BASIC_YMD = document.getElementById("txtBASIC_YMD_SHR").value;
            var EMP_GBN_SHR = document.getElementById("cmbEMP_GBN_SHR").value;

            dsT_SH_STOCKHOLDER.UseChangeInfo = true;    //false 무조건 입력

            //데이터셋 전송
            dsT_SH_STOCKHOLDER.DataID = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SHR&BASIC_YMD_SHR="+BASIC_YMD+"&EMP_GBN_SHR="+EMP_GBN_SHR;
            dsT_SH_STOCKHOLDER.Reset();
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
			trT_SH_STOCKHOLDER.KeyValue = "SVL(I:SAV=dsT_SH_STOCKHOLDER, O:dsRESULT=dsRESULT)";
			trT_SH_STOCKHOLDER.Action = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SAV";
			trT_SH_STOCKHOLDER.Post();

        }

		/******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_SH_STOCKHOLDER.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_SH_STOCKHOLDER.ColumnString(dsT_SH_STOCKHOLDER.RowPosition,3) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_SH_STOCKHOLDER.DeleteRow(dsT_SH_STOCKHOLDER.RowPosition);
			trT_SH_STOCKHOLDER.KeyValue = "SVL(I:SAV=dsT_SH_STOCKHOLDER)";
			trT_SH_STOCKHOLDER.Action = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=DEL";
			trT_SH_STOCKHOLDER.post();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

			var BASIC_YMD_SHR = document.getElementById("txtBASIC_YMD_SHR").value; // 조회기준일
			var cmbEMP_GBN_SHR = document.getElementById("cmbEMP_GBN_SHR").value; // 사원구분


		    var url = "stoa010_PV.jsp?BASIC_YMD_SHR="+BASIC_YMD_SHR+"&cmbEMP_GBN_SHR="+cmbEMP_GBN_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_SH_STOCKHOLDER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SH_STOCKHOLDER.GridToExcel("주주현황", '', 225);

        }

         /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_SH_STOCKHOLDER.CountColumn == 0) {
                dsT_SH_STOCKHOLDER.setDataHeader("BASIC_YMD:STRING:KEYVALUETYPE,SH_NO:STRING:KEYVALUETYPE,SEQ_NO:STRING:KEYVALUETYPE,ENO_NM:STRING,EMP_GBN:STRING,HIR_YMD:STRING,RET_YMD:STRING,COM_STK:DECIMAL,PRE_STK:DECIMAL,NEW_STK1:DECIMAL,NEW_STK2:DECIMAL,POST_NO:STRING,ADDRESS:STRING");
            }

            dsT_SH_STOCKHOLDER.AddRow();
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

			dsT_SH_STOCKHOLDER.ClearData();
            document.getElementById("cmbEMP_GBN_SHR").selectedIndex = 0;
			document.getElementById("resultMessage").innerText = ' ';


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_SH_STOCKHOLDER.IsUpdated)  {

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
        	if (!dsT_SH_STOCKHOLDER.isUpdated && dsT_SH_STOCKHOLDER.UseChangeInfo) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 0;
			var oBASIC_YMD, oSH_NO, oENO_NM;
			var RowCnt = dsT_SH_STOCKHOLDER.CountRow;

			for(i=1; i<=RowCnt; i++){

				oBASIC_YMD = dsT_SH_STOCKHOLDER.NameValue(i,"BASIC_YMD");
				if(oBASIC_YMD.trim().length == 0){
					alert("기준일이 잘못되었습니다.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
					return false;
				}

				oSH_NO = dsT_SH_STOCKHOLDER.NameValue(i,"SH_NO");
				if(oSH_NO.trim().length == 0){
					alert("주주번호가 잘못되었습니다.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
					return false;
				}

				oENO_NM = dsT_SH_STOCKHOLDER.NameValue(i,"ENO_NM");
				if(oENO_NM.trim().length == 0){
					alert("주주명이 잘못되었습니다.");
					dsT_SH_STOCKHOLDER.RowPosition = i;
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
            cfStyleGrid(form1.grdT_SH_STOCKHOLDER,15,"false","false");

            document.getElementById("txtBASIC_YMD_SHR").value = getTodayArray()[0];
        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /*****************************
         * 17. 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD,O:dsT_SH_STOCKHOLDER=dsT_SH_STOCKHOLDER)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.sto.a.stoa010.cmd.STOA010CMD&S_MODE=SHR_02";
                trFILE_UPLOAD.post();

            }

            dsT_SH_STOCKHOLDER.UseChangeInfo = false;    //false 무조건 입력
        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_SH_STOCKHOLDER                             |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID="dsT_SH_STOCKHOLDER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_SH_STOCKHOLDER                          |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID="ds01T_SH_STOCKHOLDER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>


    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!----------------------------------------------+
    | 1. 자료 업로드용 Data Transacton              |
    | 2. 이름 : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_SH_STOCKHOLDER                                |
    | 3. Table List : T_SH_STOCKHOLDER                         |
    +----------------------------------------------->
    <Object ID ="trT_SH_STOCKHOLDER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_SH_STOCKHOLDER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
        } else {
			var oBASIC_YMD = ds01T_SH_STOCKHOLDER.NameValue(1,"BASIC_YMD").trim();
			document.getElementById("txtBASIC_YMD_SHR").value = oBASIC_YMD.substring(0,4)+"-"+oBASIC_YMD.substring(4,6)+"-"+oBASIC_YMD.substring(6,8);
        }
    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_SH_STOCKHOLDER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!---------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +---------------------------------------------------------->
    <Script For=dsT_SH_STOCKHOLDER Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[기준일/주주번호/주주명] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("기준일/주주번호/주주명에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds01T_SH_STOCKHOLDER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_SH_STOCKHOLDER event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_SH_STOCKHOLDER event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">주주현황</td>
					<td align="right" class="navigator">HOME/업무관리/주주관리/<font color="#000000">주주현황</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
											<col width="10"></col>
											<col width="80"></col>
											<col width="100"></col>
											<col width="80"></col>
											<col width="150"></col>
											<col width="*"></col>
										</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">기준년도</td>
								<td>
                                    <input type="text" id="txtBASIC_YMD_SHR" name="txtBASIC_YMD_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="img_HelpOn1" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtBASIC_YMD_SHR','','340','108');"></a>
								</td>
								<td align="center" class="searchState">사원구분</td>
								<td>
	                                <select id="cmbEMP_GBN_SHR" style="width:70%">
										<option value="" >전체</option>
										<option value="1" >미재직</option>
	                                    <option value="2" >재직</option>
	                                    <option value="3" >퇴사</option>
	                                </select>
								</td>
								<td align="center">&nbsp;</td>
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
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td class="searchState" align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" width="80" height="20" border="0" align="absmiddle" onclick="cfDownload('stoa010.xls', '<%=FILEURL %>/stoa010.xls');"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
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
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SH_STOCKHOLDER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_SH_STOCKHOLDER">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='{CUROW}'		width=47		name='NO'				align=center		BgColor='#EEEEEE'		value={String(Currow)}	</C>
								<C> id='BASIC_YMD'		width=70		name='기준일'			align=center												</C>
								<C> id='SH_NO'			width=110		name='주주번호' 		align=center												</C>
								<C> id='ENO_NM'			width=150		name='주주명'			align=center												</C>
								<C> id='EMP_GBN'		width=70		name='사원구분'	    	align=center		BgColor='#EEEEEE' 			</C>
								<C> id='HIR_YMD'		width=70		name='입사일'			align=center		BgColor='#EEEEEE' 			</C>
								<C> id='RET_YMD'		width=70		name='퇴사일'			align=center		BgColor='#EEEEEE' 			</C>
								<C> id='COM_STK'		width=88		name='보통주'			align=right			RightMargin='10'					</C>
								<C> id='PRE_STK'		width=88		name='우선주'			align=right			RightMargin='10'					</C>
								<C> id='NEW_STK1'		width=88		name='신주1'			align=right			RightMargin='10'					</C>
								<C> id='NEW_STK2'		width=88		name='신주2'			align=right			RightMargin='10'					</C>
								<C> id='POST_NO'		width=70		name='우편번호'		    align=center												</C>
								<C> id='ADDRESS'		width=350		name='주소'				align=left													</C>
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