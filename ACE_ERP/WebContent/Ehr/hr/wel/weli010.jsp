<!--
***********************************************************************
* @source      : pirc060.jsp
* @description : 동호회 관리 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/23      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>동호회 관리(pirc060)</title>
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

		var btnList = 'TTTTTFTT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var club_cd = document.getElementById('cmbCLUB_CD_SHR').value;
            var gbn1 = "";
            var gbn2 = "";
            if(document.getElementById('chkGBN_SHR1').checked){
                gbn1 = "Y";
            }
            if(document.getElementById('chkGBN_SHR2').checked){
                gbn2 = "Y";
            }

            if(!fnc_SearchItemCheck()) return;  //조회 유효성 검사

			dsT_WL_CLUBLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.i.weli010.cmd.WELI010CMD&S_MODE=SHR&ENO_NO="+eno_no+"&CLUB_CD="+club_cd+"&GBN1="+gbn1+"&GBN2="+gbn2;
    		dsT_WL_CLUBLIST.reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if(!fnc_SaveItemCheck()) return;	//유효성 체크

            trT_WL_CLUBLIST.KeyValue = "tr01(I:dsT_WL_CLUBLIST=dsT_WL_CLUBLIST)";
			trT_WL_CLUBLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.i.weli010.cmd.WELI010CMD&S_MODE=SAV";
			trT_WL_CLUBLIST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_CLUBLIST.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}

            if(dsT_WL_CLUBLIST.RowStatus(dsT_WL_CLUBLIST.RowPosition) == 1){
                dsT_WL_CLUBLIST.DeleteRow(dsT_WL_CLUBLIST.RowPosition);
                return;
            }

            if(dsT_WL_CLUBLIST.NameValue(dsT_WL_CLUBLIST.RowPosition,'IPT_YMD') != '<%=box.get("SESSION_TODAY")%>'){
                alert("등록당일만 삭제가 가능합니다!");
                return;
            }

			if(confirm("[사원번호:"+dsT_WL_CLUBLIST.NameValue(dsT_WL_CLUBLIST.RowPosition,'ENO_NO')+"]의 정보를 삭제하시겠습니까?")){
				dsT_WL_CLUBLIST.DeleteRow(dsT_WL_CLUBLIST.RowPosition);
				trT_WL_CLUBLIST.KeyValue = "tr01(I:dsT_WL_CLUBLIST=dsT_WL_CLUBLIST)";
				trT_WL_CLUBLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.i.weli010.cmd.WELI010CMD&S_MODE=SAV";
				trT_WL_CLUBLIST.post();
			}

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

			if (dsT_WL_CLUBLIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_WL_CLUBLIST.GridToExcel("동호회관리", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_WL_CLUBLIST.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_WL_CLUBLIST.setDataHeader(  "ENO_NO:STRING:KEYVALUE"
                                             + ",ENO_NM:STRING"
                                             + ",DPT_NM:STRING"
                                             + ",JOB_NM:STRING"
                                             + ",CLUB_CD:STRING:KEYVALUE"
                                             + ",CLUB_NM:STRING"
                                             + ",CLUB_AMT:INTEGER"
                                             + ",APP_AMT:INTEGER"
                                             + ",FEE_YN:STRING"
                                             + ",HIR_YMD:STRING"
                                             + ",RET_YMD:STRING"
                                             + ",STR_YMD:STRING:KEYVALUE"
                                             + ",END_YMD:STRING"
                                             + ",IPT_YMD:STRING"
                                             + ",DPT_SEQ:INTEGER"
                                             + ",JOB_SEQ:INTEGER"
                                             + ",HOB_SEQ:INTEGER" );
			}

            dsT_WL_CLUBLIST.AddRow();

            document.getElementById("cmbFEE_YN").value = "Y";

            document.getElementById("cmbCLUB_CD").focus();

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

            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
            document.getElementById('cmbCLUB_CD_SHR').value = '';
            document.getElementById('chkGBN_SHR1').checked = true;
            document.getElementById('chkGBN_SHR2').checked = false;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CLUBLIST.ClearData();

            document.getElementById('txtENO_NO_SHR').focus();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_WL_CLUBLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            var gbn1 = document.getElementById('chkGBN_SHR1');
            var gbn2 = document.getElementById('chkGBN_SHR2');

            if(gbn1.checked == false && gbn2.checked == false){
                alert("활동여부 하나 이상은 반드시 선택하셔야 합니다!");
                gbn1.checked = true;
                return false;
            }

            return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_WL_CLUBLIST.IsUpdated ) {
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

			cfStyleGrid(form1.grdT_WL_CLUBLIST,15,"false","false");      // Grid Style 적용

            form1.grdT_WL_CLUBLIST.ColSizing = "false";


            //동호회정보조회
            dsT_CM_COMMON.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.i.weli010.cmd.WELI010CMD&S_MODE=SHR_01";
            dsT_CM_COMMON.reset();


            fnc_DisableElementAll(elementList);

            document.getElementById('txtENO_NO_SHR').focus();

        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /*
         * 추가비 초기화
         */
        function clearAppAmt() {
            for(var i=1; i<=dsT_WL_CLUBLIST.CountRow; i++) {
                dsT_WL_CLUBLIST.NameString(i, "APP_AMT") = 0;
            }
            document.getElementById("lblSUB_SUM3").innerText = "0";
            document.getElementById("lblTOT_SUM").innerHTML = "총&nbsp;&nbsp;합 : "+formatNumber(dsT_WL_CLUBLIST.NameSum("CLUB_AMT",0,0));
        }


        var elementList = new Array( "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"cmbCLUB_CD"
                                    ,"txtSTR_YMD"
                                    ,"Image12"
                                    ,"txtEND_YMD"
                                    ,"Image13"
                                    ,"cmbFEE_YN"
                                    ,"txtAPP_AMT" );

        var exceptionList = new Array(
                                     "txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"cmbCLUB_CD"
                                    ,"txtSTR_YMD"
                                    ,"Image12" );

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;

                //클럽비를 조회함
                fnc_FindClubAmt();
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }


        /**
         * 클럽비를 조회해 온다.
         */
        function fnc_FindClubAmt() {
            var eno_no = document.getElementById("txtENO_NO").value;
            var club_cd = document.getElementById("cmbCLUB_CD").value;

            if(eno_no == "" || club_cd == "")
                return;

            dsT_CM_BASIS.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.i.weli010.cmd.WELI010CMD"
                                + "&S_MODE=SHR_CLUB_AMT"
                                + "&ENO_NO="+eno_no
                                + "&CLUB_CD="+club_cd;
            dsT_CM_BASIS.reset();
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_CLUBLIST) |
    | 3. 사용되는 Table List(T_WL_CLUBLIST)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CLUBLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_COMMON)   |
    | 3. 사용되는 Table List(T_CM_COMMON)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_CLUBLIST)	    |
    | 3. 사용되는 Table List(T_WL_CLUBLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CLUBLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_CLUBLIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>
    <Script For=dsT_CM_BASIS Event="OnLoadCompleted(iCount)">

        if(dsT_CM_BASIS.NameString(0, "CLUB_CNT") >= 6) {
            alert("해당 사원은 이미 동호회를 6개 이상 가입했습니다.\n더 이상 가입하실 수 없습니다. ");
            document.getElementById("txtENO_NO").value      = "";
            document.getElementById("txtENO_NM").value      = "";
            document.getElementById("txtDPT_NM").value      = "";
            document.getElementById("txtJOB_NM").value      = "";
        }

        if(iCount == 1) {
            document.getElementById("txtCLUB_AMT").Text = dsT_CM_BASIS.NameString(0, "CLUB_AMT");
        } else {
            document.getElementById("txtCLUB_AMT").Text = 0;
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CLUBLIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_CM_BASIS Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CLUBLIST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		//Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[사원번호/동호회/가입일] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[사원번호/동호회/가입일]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

			//동호회
            for( var i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON.NameValue(i,"COMM_CD");
                oOption.text  = dsT_CM_COMMON.NameValue(i,"COMM_NM");
                document.getElementById("cmbCLUB_CD_SHR").add(oOption);

            }

            for( var i = 1; i <= dsT_CM_COMMON.CountRow; i++ ) {
                if(dsT_CM_COMMON.NameValue(i,"IS_END") != 'Y') {
                    oOption       = document.createElement("OPTION");
                    oOption.value = dsT_CM_COMMON.NameValue(i,"COMM_CD");
                    oOption.text  = dsT_CM_COMMON.NameValue(i,"COMM_CD")+" "+dsT_CM_COMMON.NameValue(i,"COMM_NM");
                    document.getElementById("cmbCLUB_CD").add(oOption);
                }
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_CLUBLIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_CLUBLIST event="OnFail()">
        cfErrorMsg(this);
    </script>




    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CLUBLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //신규일 경우
            if(dsT_WL_CLUBLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }

            document.getElementById("lblSUB_SUM1").innerHTML = "<b>합&nbsp;&nbsp;계 ("+dsT_WL_CLUBLIST.CountRow+" 명)</b>";
            document.getElementById("lblSUB_SUM2").innerHTML = formatNumber(dsT_WL_CLUBLIST.NameSum("CLUB_AMT",0,0));
            document.getElementById("lblSUB_SUM3").innerHTML = formatNumber(dsT_WL_CLUBLIST.NameSum("APP_AMT",0,0));
            document.getElementById("lblTOT_SUM").innerHTML  = "총&nbsp;&nbsp;합 : "+formatNumber(dsT_WL_CLUBLIST.NameSum("CLUB_AMT",0,0)+dsT_WL_CLUBLIST.NameSum("APP_AMT",0,0));
        }
    </script>

    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_CLUBLIST event=CanRowPosChange(row)>

        if(dsT_WL_CLUBLIST.NameString(row, "ENO_NO") == "") {
            alert("사번을 입력해 주세요.!");
            document.getElementById("txtENO_NO").focus();
            return false;
        }
        if(dsT_WL_CLUBLIST.NameString(row, "CLUB_CD") == "") {
            alert("동호회를 선택해 주세요.!");
            document.getElementById("cmbENO_NO").focus();
            return false;
        }
        if(dsT_WL_CLUBLIST.NameString(row, "STR_YMD") == "") {
            alert("가입일을 입력해 주세요.!");
            document.getElementById("txtSTR_YMD").focus();
            return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">동호회 관리</td>
					<td align="right" class="navigator">HOME/복리후생/동호회/<font color="#000000">동호회 관리</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="60"></col>
									<col width="200"></col>
                                    <col width="60"></col>
                                    <col width="100"></col>
                                    <col width="60"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td align="right" class="searchState" width="70">사원번호&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td align="center" class="searchState">동호회&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbCLUB_CD_SHR" style="width:100%">
                                        <option value="">전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchBold">활동여부&nbsp;</td>
								<td class="padding2423">
                                    <input type="checkbox" id="chkGBN_SHR1" style="border:none" checked>활동
									<input type="checkbox" id="chkGBN_SHR2" style="border:none" >탈퇴
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

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="140"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>

                    <td align="center" class="creamBold">부 서</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                    </td>
                    <td align="center" class="creamBold">직 위</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" style="width:100%" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">동호회</td>
                    <td class="padding2423">
                        <select id="cmbCLUB_CD" style="width:100%" onChange="fnc_FindClubAmt()">
                            <option value=""></option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">회 비</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtCLUB_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px" enable="false" class="input_ReadOnly">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">가입일</td>
					<td class="padding2423">
                        <input id="txtSTR_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="if(txtSTR_YMD.disabled != true){ calendarBtn('datetype1','txtSTR_YMD','','440','180');}"></a>
                    </td>
                    <td align="center" class="creamBold">탈퇴일</td>
					<td class="padding2423">
                        <input id="txtEND_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="if(txtEND_YMD.disabled != true){calendarBtn('datetype1','txtEND_YMD','','630','180');}"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">회비납부</td>
                    <td class="padding2423">
                        <select id="cmbFEE_YN" style="width:100px">
                            <option value="Y">납 부</option>
                            <option value="N">제 외</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">추가비</td>
                    <td class="padding2423" colspan="5">
                        <comment id="__NSID__"><object id="txtAPP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px" enable="false" class="input_ReadOnly">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                        <!--     <param name=NumericRange            value=0~+:0>    -->
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
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
                    <td align="right">  <!--<input type="button" value="초기화" onclick="clearAppAmt()"></td> -->
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn_recalculation','','/images/button/btn_recalculationOver.gif',1)"><img src="/images/button/btn_recalculationOn.gif"  name="btn_recalculation" width="70" height="20" border="0" align="absmiddle" onClick="clearAppAmt()"></a>
                    </td>
                    <td width="10"></td>
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
						<object	id="grdT_WL_CLUBLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:298px;">
							<param name="DataID"					value="dsT_WL_CLUBLIST">
                            <param name="DragDropEnable"            value=false>
                            <param name="Format"					value="
								<C> id={currow}		width=30    name='순번'		align=center </C>
                                <C> id='DPT_NM' 	width=80	name='부서'	    align=left </C>
								<C> id='JOB_NM'	    width=65	name='직위'	    align=center </C>
								<C> id='ENO_NO'	    width=55	name='사번'		align=center </C>
								<C> id='ENO_NM' 	width=50	name='성명'		align=center </C>
                                <C> id='CLUB_CD'	width=120	name='동호회'	    align=left Editstyle=lookup	Data='dsT_CM_COMMON:COMM_CD:COMM_NM'  soft='true'</C>
								<C> id='CLUB_AMT'	width=60	name='회비'	    align=right </C>
								<C> id='APP_AMT'	width=60	name='추가비'	    align=right </C>
                                <C> id='STR_YMD'	width=70	name='가입일'	align=center </C>
                                <C> id='END_YMD'	width=70	name='탈퇴일'	align=center </C>
                                <C> id='FEE_YN'	    width=35	name='회비;납부'	align=center Editstyle=combo Data='Y:납부,N:제외' </C>
                                <C> id='RET_YMD'    width=70    name='퇴사일'  align=center </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
    <tr>
        <td>
           <br>
        </td>
   </tr>
	<tr>
		<td>
			<table width="100%" height="25" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="395"></col>

                    <col width="58"	></col>
                    <col width="58"	></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td style="padding-left:20px;" id="lblSUB_SUM1"></td>

                    <td id="lblSUB_SUM2" align="right" style="padding-right:1px"></td>
                    <td id="lblSUB_SUM3" align="right" style="padding-right:1px"></td>

                    <td id="lblTOT_SUM" align="right" style="padding-right:25px"></td>
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

<!-- 개인정보 수정요청 테이블 -->
<object id="bndT_WL_CLUBLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WL_CLUBLIST">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO       Ctrl=txtENO_NO       Param=value</C>
        <C> Col=ENO_NM       Ctrl=txtENO_NM       Param=value</C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value</C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value</C>
        <C> Col=CLUB_CD      Ctrl=cmbCLUB_CD      Param=value</C>
        <C> Col=CLUB_AMT     Ctrl=txtCLUB_AMT     Param=Text</C>
        <C> Col=APP_AMT      Ctrl=txtAPP_AMT      Param=Text</C>
        <C> Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value</C>
        <C> Col=END_YMD      Ctrl=txtEND_YMD      Param=value</C>
        <C> Col=FEE_YN       Ctrl=cmbFEE_YN       Param=value</C>
    '>
</object>