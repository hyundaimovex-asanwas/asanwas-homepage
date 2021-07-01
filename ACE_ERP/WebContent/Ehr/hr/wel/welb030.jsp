<!--
***********************************************************************
* @source      : welb030.jsp
* @description : 임원지원대상자 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/07      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%

    String ROLE_CD = box.getString("SESSION_ROLE_CD");


    //ROLE_CD가 IT인지 여부
    boolean itMaster = false;

    if(ROLE_CD.equals("1001")) {
    	itMaster = true;
    }

%>
<html>
<head>
<title>임원지원대상자(welb030)</title>
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

		var btnList = 'TTTTFFTT';
		var emp_Sbutton = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var eno_no = document.getElementById('txtENO_NO_SHR').value;
			var phn_no = document.getElementById('txtPHN_NO_SHR').value;
			var name_gbn = document.getElementById('cmbNAME_GBN_SHR').value;
			var chk_data;


            if(document.getElementById('chkCHK_DATA').checked) {
                chk_data = "1";
            } else {
                chk_data = "";
            }

			dsT_WL_HDPCLIST.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PHN_NO="+phn_no+"&NAME_GBN="+name_gbn+"&CHK_DATA="+chk_data;
    		dsT_WL_HDPCLIST.reset();

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

				if(!fnc_SaveItemCheck()) return;	//유효성 체크

				trT_WL_HDPCLIST.KeyValue = "tr01(I:dsT_WL_HDPCLIST=dsT_WL_HDPCLIST)";
				trT_WL_HDPCLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=SAV";
				trT_WL_HDPCLIST.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPCLIST.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[성명:"+dsT_WL_HDPCLIST.NameValue(dsT_WL_HDPCLIST.RowPosition,'ENO_NM')+"/휴대폰번호:"+dsT_WL_HDPCLIST.NameValue(dsT_WL_HDPCLIST.RowPosition,'PHN_NO')+"]의 정보를 삭제하시겠습니까?")){
				dsT_WL_HDPCLIST.DeleteRow(dsT_WL_HDPCLIST.RowPosition);

				trT_WL_HDPCLIST.KeyValue = "tr01(I:dsT_WL_HDPCLIST=dsT_WL_HDPCLIST)";
				trT_WL_HDPCLIST.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb030.cmd.WELB030CMD&S_MODE=DEL";
				trT_WL_HDPCLIST.post();
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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			//DataSet에 Header가 정의되어 있지 않는 경우
			if(dsT_WL_HDPCLIST.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_WL_HDPCLIST.setDataHeader("PHN_NO:STRING, NAME_GBN:STRING, ENO_NO:STRING, ENO_NM:STRING, JOB_CD:STRING, REMARK:STRING, STR_YMD:STRING, END_YMD:STRING");
			}

			dsT_WL_HDPCLIST.AddRow();

			document.getElementById('txtPHN_NO').focus();

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
			document.getElementById('txtPHN_NO_SHR').value = '';
        	document.getElementById('cmbNAME_GBN_SHR').value = '';

			dsT_WL_HDPCLIST.ClearData();

		}

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPCLIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_WL_HDPCLIST.IsUpdated ) {
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
            fnc_DisableElementAll(elementList);
			cfStyleGrid(form1.grdT_WL_HDPCLIST,15,"false","false");      // Grid Style 적용

            document.getElementById('txtPHN_NO_SHR').focus();
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*****************************
         * 16. 사원정보 조회용 팝업  *
         *****************************/
		function fnc_emplPopup_this(ctrl_01,ctrl_02,ctrl_03,ctrl_04,ctrl_05,ctrl_06) {

			var obj = new String();

			obj.eno_nm = "";

			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(ctrl_01 != undefined && ctrl_01 != "" && obj.eno_no.trim() != ""){
  				document.getElementById(ctrl_01).value = obj.eno_no;
 			}
			if(ctrl_02 != undefined && ctrl_02 != "" && obj.eno_nm.trim() != ""){
 				document.getElementById(ctrl_02).value = obj.eno_nm;
			}
			if(ctrl_03 != undefined && ctrl_03 != "" && obj.dpt_cd.trim() != ""){
 				document.getElementById(ctrl_03).value = obj.dpt_cd;
			}
			if(ctrl_04 != undefined && ctrl_04 != "" && obj.dpt_nm.trim() != ""){
  				document.getElementById(ctrl_04).value = obj.dpt_nm;
 			}
			if(ctrl_05 != undefined && ctrl_05 != "" && obj.job_cd.trim() != ""){
 				document.getElementById(ctrl_05).value = obj.job_cd;
			}
			if(ctrl_06 != undefined && ctrl_06 != "" && obj.job_nm.trim() != ""){
  				document.getElementById(ctrl_06).value = obj.job_nm;
 			}

		}

        /**********************************
         * 17. 사번으로 사원정보조회 처리 *
         *********************************/
        function fnc_UserGetEnoNm() {

            var obj = new String();

            obj = fnc_GetEnoNm("txtENO_NO");

            document.getElementById("txtENO_NM").value = obj.eno_nm;

            document.getElementById("cmbJOB_CD").value = obj.job_cd;

        }

        var elementList = new Array( "txtPHN_NO"
                                    ,"rdoNAME_GBN"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtREMARK"
                                    ,"txtSTR_YMD"
                                    ,"txtEND_YMD"
                                    ,"imgSTR_YMD"
                                    ,"imgEND_YMD"
                                    );

        var exceptionList = new Array(
                                     "txtPHN_NO"
                                    ,"rdoNAME_GBN"
                                    ,"txtENO_NO"
                                    ,"txtENO_NM"
                                    ,"ImgEnoNo"
                                    ,"txtSTR_YMD"
                                    ,"imgSTR_YMD"
                                      );

        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {
            fnc_emplPopup("txtENO_NO");

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
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');
            fnc_SearchEmpNo();
        }

        /**
         * 사원정보를 조회 한다.
         * 사번으로 검색
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // 정규직 전체
            obj = fnc_GetEnoNm("txtENO_NO");

            if(obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtJOB_CD").value      = obj.job_cd;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtJOB_CD").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_HDPCLIST) |
    | 3. 사용되는 Table List(T_WL_HDPCLIST)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPCLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_HDPCLIST)	|
    | 3. 사용되는 Table List(T_WL_HDPCLIST)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPCLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_HDPCLIST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPCLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPCLIST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[휴대폰번호, 사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
//	        alert("중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_HDPCLIST event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_HDPCLIST event="OnFail()">
        cfErrorMsg(this);
    </script>



    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_HDPCLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            if(dsT_WL_HDPCLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
                rdoNAME_GBN.Enable = true;
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
                rdoNAME_GBN.Enable = false;
            }
        }
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남, 유효성 검사
    +------------------------------------------------------>
      <script language=JavaScript for=dsT_WL_HDPCLIST event=CanRowPosChange(row)>

        if ( dsT_WL_HDPCLIST.NameValue(row,"ENO_NO") == "" ) {
            alert("[ 사번 ]은 필수 입력사항입니다");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"PHN_NO") == "" ) {
            alert("[ 휴대폰번호 ]는 필수 입력사항입니다");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"NAME_GBN") == "" ) {
            alert("[ 구 분 ]은 필수 입력사항입니다");
            return false;
        } else if ( dsT_WL_HDPCLIST.NameValue(row,"STR_YMD") == "" ) {
            alert("[ 지원일 ]는 필수 입력사항입니다");
            return false;
        }

        //개인 명의 일때는 반드시 사번이 들어가야 됨
        if(dsT_WL_HDPCLIST.NameValue(row,"NAME_GBN") == "2"
                && dsT_WL_HDPCLIST.NameValue(row,"ENO_NO") == "") {
            alert("[ 개인명의 ] 일때 [ 사 번 ]은 필수 입력사항입니다");
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">임원지원대상자</td>
					<td align="right" class="navigator">HOME/복리후생/휴대폰관리/<font color="#000000">임원지원대상자</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
<%
    if(itMaster){
%>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
<%
    }
%>
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
                                    <col width="90"></col>
                                    <col width="70"></col>
                                    <col width="60"></col>
                                    <col width="60"></col>
                                    <col width="60"></col>
                                    <col width="170"></col>
                                    <col width="150"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchState">휴대폰번호&nbsp;</td>
                                <td class="padding2423"><input id="txtPHN_NO_SHR" size="15" maxlength="15" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber();"  style="ime-mode:disabled"></td>
                                <td align="right" class="searchState">구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbNAME_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
                                        <option value=''>전 체</option>
                                        <option value='1'>법 인</option>
                                        <option value='2'>개 인</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">사 번&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
                                </td>

                                <td align="right" class="searchState">유효데이터(금일기준)&nbsp;</td>
                                <td class="padding2423">
                                    <input type="checkbox" name="chkCHK_DATA" value="1">
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
					<col width="60"></col>
					<col width="180"></col>
                    <col width="60"></col>
                    <col width="70"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">사 번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>

                    <td align="center" class="creamBold">직 위</td>
                    <td class="padding2423">
                        <input type=hidden id="txtJOB_CD">
                        <input id="txtJOB_NM" size="18" class="input_ReadOnly" readonly>
                    </td>

					<td align="center" class="creamBold">휴대폰번호</td>
					<td class="padding2423">
                        <input id="txtPHN_NO" size="15" maxlength="15" onkeypress="cfCheckNumber()"  style="ime-mode:disabled">
                    </td>
					<td align="center" class="creamBold">구 분</td>
					<td class="padding2423">
                        <comment id="__NSID__">
						<object id=rdoNAME_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:100">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_HDPCLIST">
							<param name=CodeColumn  value="NAME_GBN">
							<param name=Cols		value="2">
							<param name=Format	value="1^법인,2^개인">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">지원년월</td>
					<td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtSTR_YMD','','5','115');"></a>
                         ~
                        <input id="txtEND_YMD" size="7" maxlength="7" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD','txtSTR_YMD','txtEND_YMD'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtEND_YMD','','100','115');"></a>
                    </td>
					<td align="center" class="creamBold">비 고</td>
					<td class="padding2423" colspan="3">
                        <input id="txtREMARK" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)">
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

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_WL_HDPCLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_HDPCLIST">
							<param name="Format"					value="
								<C> id={currow}		width=50    name='NO'			align=center </C>
                                <C> id='JOB_NM'     width=100   name='직위'           align=left  </C>
                                <C> id='ENO_NO'     width=100   name='사번'           align=center </C>
                                <C> id='ENO_NM'     width=100   name='성명'           align=center </C>
                                <C> id='NM_GBN_VAL' width=90    name='구분'           align=center    Value={Decode(NAME_GBN,'1','법인명의','2','개인명의')}</C>
								<C> id='PHN_NO'		width=140	name='휴대폰번호'	align=left </C>
								<C> id='REMARK'		width=185	name='비고'			align=left </C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 법인 개인명의 전액지원 핸드폰 관리 테이블 -->
<object id="bndT_WL_HDPCLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_HDPCLIST">
	<Param Name="BindInfo", Value='
		<C>Col=PHN_NO		Ctrl=txtPHN_NO	     	Param=value		</C>
		<C>Col=NAME_GBN		Ctrl=rdoNAME_GBN     	Param=value		</C>
		<C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		</C>
		<C>Col=ENO_NM    	Ctrl=txtENO_NM	     	Param=value		</C>
		<C>Col=JOB_CD		Ctrl=txtJOB_CD	     	Param=value		</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM	     	Param=value		</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		</C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD         Param=value     </C>
        <C>Col=END_YMD      Ctrl=txtEND_YMD         Param=value     </C>
    '>
</object>