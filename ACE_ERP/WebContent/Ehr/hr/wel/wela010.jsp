<!--
***********************************************************************
* @source      : wela010.jsp
* @description : 이주비신청 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/05      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>이주비신청(wela010)</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			dsT_WL_MOVEAPPLY.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela010.cmd.WELA010CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd;
    		dsT_WL_MOVEAPPLY.reset();

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

			trT_WL_MOVEAPPLY.KeyValue = "tr01(I:dsT_WL_MOVEAPPLY=dsT_WL_MOVEAPPLY)";
			trT_WL_MOVEAPPLY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela010.cmd.WELA010CMD&S_MODE=SAV";
			trT_WL_MOVEAPPLY.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_MOVEAPPLY.CountRow < 1) {
				alert("삭제할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(dsT_WL_MOVEAPPLY.NameValue(dsT_WL_MOVEAPPLY.RowPosition,'APP_STS') != '0'){
				alert('신청 상태가 아니면 삭제 하실 수 없습니다.');
				document.getElementById("resultMessage").innerText = '* 삭제할 수 없습니다!';
				return;
			}
			if(confirm("이주일자:["+dsT_WL_MOVEAPPLY.NameValue(dsT_WL_MOVEAPPLY.RowPosition,'MOVE_YMD')+"]로 저장된 이주비신청정보를 삭제하시겠습니까?")){
				dsT_WL_MOVEAPPLY.DeleteRow(dsT_WL_MOVEAPPLY.RowPosition);
				trT_WL_MOVEAPPLY.KeyValue = "tr01(I:dsT_WL_MOVEAPPLY=dsT_WL_MOVEAPPLY)";
				trT_WL_MOVEAPPLY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela010.cmd.WELA010CMD&S_MODE=DEL";
				trT_WL_MOVEAPPLY.post();
			}

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요

           	var eno_no = dsT_WL_MOVEAPPLY.NameString(dsT_WL_MOVEAPPLY.RowPosition, "ENO_NO");
			var ord_no = dsT_WL_MOVEAPPLY.NameString(dsT_WL_MOVEAPPLY.RowPosition, "ORD_NO");

			if(eno_no.length != 6) {
                alert("출력 데이타를 선택해 주세요!");
                return;
            }



		    var hnwparm = "[:ENO_NO]="+eno_no+"[:ORD_NO]="+ord_no;
			document.form1.rptObject.SetValues(hnwparm);
            document.form1.rptObject.RunButton("Print");

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
			if(dsT_WL_MOVEAPPLY.CountColumn < 1){
				// 데이터셋의 헤더 정보 설정.
				dsT_WL_MOVEAPPLY.setDataHeader("ORD_NO:STRING, ENO_NO:STRING, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING, RADR:STRING, RADR_CT:STRING, RZI_NO:STRING, MADR:STRING, MADR_CT:STRING, MZI_NO:STRING, MOVE_YMD:STRING:NOTNULL, COM_PHN_NO:STRING, HOM_PHN_NO:STRING, EM_PHN_NO:STRING, APP_YMD:STRING, APP_CD:STRING, RAREA:STRING, MAREA:STRING, MOVE_AMT:INTEGER, RPLACE:STRING, MPLACE:STRING, REMARK:STRING");
			}

			dsT_WL_MOVEAPPLY.AddRow();


            document.getElementById('txtENO_NM').value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById('txtENO_NO').value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById('txtDPT_NM').value = '<%= box.get("SESSION_DPTNM")%>';
            document.getElementById('txtJOB_NM').value = '<%= box.get("SESSION_JOBNM")%>';

			document.getElementById('rdoAPP_CD').focus();

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

			document.getElementById("resultMessage").innerText = ' ';
			dsT_WL_MOVEAPPLY.ClearData();

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_MOVEAPPLY.IsUpdated)  {

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

			if (!dsT_WL_MOVEAPPLY.IsUpdated ) {
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

			cfStyleGrid(form1.grdT_WL_MOVEAPPLY,15,"false","false");      // Grid Style 적용

            document.getElementById('txtSTR_YMD_SHR').value = getStrDate();
            document.getElementById('txtEND_YMD_SHR').value = getToday();

            document.getElementById('txtSTR_YMD_SHR').focus();

            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/***********************************
         * 16. 우편번호, 주소 조회용 팝업  *
         **********************************/
		function fnc_postPopup_wel(ctrl_01,ctrl_02,ctrl_03) {

			if(dsT_WL_MOVEAPPLY.CountRow < 1) return;

			var obj = new String();

			window.showModalDialog("/common/popup/post.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.zipcode != '' && obj.address_org != ''){
				document.getElementById(ctrl_01).value = obj.zipcode.substr(0,3)+"-"+obj.zipcode.substr(3,3);
				document.getElementById(ctrl_02).value = obj.address_org;
			}
			if(obj.address_gu != ''){
				dsT_WL_MOVEAPPLY.NameValue(dsT_WL_MOVEAPPLY.RowPosition, ctrl_03) = obj.address_gu;
			}

		}

        var elementList = new Array(     "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo"
                                        ,"txtRADR_CT"
                                        ,"img_HelpOn1"
                                        ,"txtMADR_CT"
                                        ,"img_HelpOn2"
                                        ,"txtMOVE_YMD"
                                        ,"txtCOM_PHN_NO"
                                        ,"txtHOM_PHN_NO"
                                        ,"txtEM_PHN_NO"
                                        ,"txtAPP_YMD"
                                        ,"Image11"
                                        ,"Image12"
                                        ,"txtRAREA"
                                        ,"txtMAREA"
                                        ,"txtRAREA_NM"
                                        ,"txtMAREA_NM"
                                        ,"ImgDptCd1"
                                        ,"ImgDptCd2"
                                        ,"rdoAPP_CD"
                                        ,"txtREMARK" );

        var exceptionList = new Array (  "txtENO_NO"
                                        ,"txtENO_NM"
                                        ,"ImgEnoNo" );

        var keyList = new Array(         "txtENO_NO" );

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
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
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
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WL_MOVEAPPLY)|
    | 3. 사용되는 Table List(T_WL_MOVEAPPLY)		 |
    +------------------------------------------------>
    <Object ID="dsT_WL_MOVEAPPLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(trT_WL_MOVEAPPLY)	|
    | 3. 사용되는 Table List(T_WL_MOVEAPPLY)	        |
    +--------------------------------------------------->
    <Object ID ="trT_WL_MOVEAPPLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_MOVEAPPLY Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WL_MOVEAPPLY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_MOVEAPPLY Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {

	        alert("해당 필수입력항목[이주일자/발령구분/발령 전,후 근무지] 입력 후 다음 작업이 가능합니다.");
        }
//        else if (this.ErrorCode == 50019) {
//	        alert("이주일자에 대한 중복값이 존재합니다. 확인바랍니다.");
//        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_WL_MOVEAPPLY event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_WL_MOVEAPPLY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_MOVEAPPLY event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //신규일 경우
            if(dsT_WL_MOVEAPPLY.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);

<%
    //마스터가 아니면 다른 사번으로 검색 못함
    if(!box.getString("SESSION_ROLE_CD").equals("1001")
            && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
                fnc_ChangeStateElement(false, "txtENO_NO");
                fnc_ChangeStateElement(false, "txtENO_NM");
                fnc_ChangeStateElement(false, "ImgEnoNo");
<%
    }
%>
            }
            //신청상태일때만 수정이 가능하다.
            else if(dsT_WL_MOVEAPPLY.NameValue(row, 'APP_STS') == '0'){
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>



    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_WL_MOVEAPPLY event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_WL_MOVEAPPLY.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_WL_MOVEAPPLY.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }

        if(dsT_WL_MOVEAPPLY.NameString(row, "RZI_NO") == "") {
            alert("현주소를 입력해 주세요.!");
            return false;
        }
        if(dsT_WL_MOVEAPPLY.NameString(row, "MZI_NO") == "") {
            alert("이주주소를 입력해 주세요.!");
            return false;
        }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이주비신청</td>
					<td align="right" class="navigator">HOME/복리후생/이주비/<font color="#000000">이주비신청</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="ImgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">등록일자&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','45','243');"></a> ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','165','243');"></a>
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
					<col width="110"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="10" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                    </td>

					<td align="center" class="creamBold">소 속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직 위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">현주소</td>
					<td class="padding2423" colspan="7">
						<input id="txtRZI_NO" size="10" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup_wel('txtRZI_NO','txtRADR','RPLACE')"></a>
						<input id="txtRADR" style="width:280" class="input_ReadOnly" readonly>
						<input id="txtRADR_CT" style="width:330" maxlength="60" onKeyUp="fc_chk_byte(this,60)">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">이주주소</td>
					<td class="padding2423" colspan="7">
						<input id="txtMZI_NO" size="10" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup_wel('txtMZI_NO','txtMADR','MPLACE')"></a>
						<input id="txtMADR" style="width:280" class="input_ReadOnly" readonly>
						<input id="txtMADR_CT" style="width:330" maxlength="60" onKeyUp="fc_chk_byte(this,60)">
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">이주일자</td>
					<td class="padding2423"><input id="txtMOVE_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtMOVE_YMD.disabled){return;} calendarBtn('datetype1','txtMOVE_YMD','','13','175');"></a></td>
					<td align="center" class="creamBold">사무실☎</td>
					<td class="padding2423"><input id="txtCOM_PHN_NO" size="23" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">자택☎</td>
					<td class="padding2423"><input id="txtHOM_PHN_NO" size="18" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">휴대폰</td>
					<td class="padding2423"><input id="txtEM_PHN_NO" size="18" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">인사발령일</td>
					<td class="padding2423"><input id="txtAPP_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtAPP_YMD.disabled){return;} calendarBtn('datetype1','txtAPP_YMD','','13','198');"></a></td>
					<td align="center" class="creamBold">발령구분</td>
					<td class="padding2423">
						<comment id="__NSID__">
						<object id=rdoAPP_CD classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:150">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_MOVEAPPLY">
							<param name=CodeColumn  value="APP_CD">
							<param name=Cols		value="3">
							<param name=Format	value="1^전임,2^파견,3^승진">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">발령前<br>근무지</td>
					<td class="padding2423">
                        <input id="txtRAREA" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtRAREA','txtRAREA_NM')">
                        <input id="txtRAREA_NM" size="7" maxlength="10" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd1" name="ImgDptCd1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtRAREA','txtRAREA_NM','부서','DEPT')"></a>
                    </td>
					<td align="center" class="creamBold">발령後<br>근무지</td>
					<td class="padding2423">
                        <input id="txtMAREA" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtMAREA','txtMAREA_NM')">
                        <input id="txtMAREA_NM" size="7" maxlength="10" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd2" name="ImgDptCd2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtMAREA','txtMAREA_NM','부서','DEPT')"></a>
                    </td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">비고</td>
                    <td class="padding2423" colspan="7">
                        <input id="txtREMARK" style="width:100%" maxlength="20">
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
						<object	id="grdT_WL_MOVEAPPLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
							<param name="DataID"					value="dsT_WL_MOVEAPPLY">
							<param name="Format"					value="
								<C> id={currow}		width=35    name='NO'			align=center </C>
								<C> id='ENO_NO'	    width=70	name='사번'		align=center Show=false</C>
								<C> id='MOVE_YMD'	width=70	name='이주일자'		align=center </C>
								<C> id='APP_YMD'	width=70	name='인사발령일'	align=center </C>
								<C> id='APP_CD'		width=60	name='발령구분'		align=center Show=false </C>
								<C> id='APP_NM'		width=60	name='발령구분'		align=center Value={Decode(APP_CD,'1','전임','2','파견','3','승진')} </C>
								<C> id='RAREA_NM'	width=80	name='발령前근무지'	align=left </C>
								<C> id='MAREA_NM'	width=80	name='발령後근무지'	align=left </C>
								<C> id='RPLACE'	    width=90	name='출발지'		align=left </C>
								<C> id='MPLACE'	    width=90	name='도착지'		align=left </C>
								<C> id='MOVE_AMT'	width=70	name='지원금액'		align=right </C>
								<C> id='REMARK'		width=300	name='비고'			align=left </C>
								<C> id='APP_STS_NM'	width=70	name='신청현황'			align=center </C>
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
	<comment id="__HNWID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="wela010.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
	</comment><script> __ShowEmbedObject(__HNWID__); </script>
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
<!-- KPI Pool 설정 테이블 -->
<object id="bndT_WL_MOVEAPPLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_MOVEAPPLY">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NO		Ctrl=txtENO_NO      	Param=value		</C>
		<C>Col=ENO_NM		Ctrl=txtENO_NM      	Param=value		</C>
		<C>Col=DPT_NM		Ctrl=txtDPT_NM      	Param=value		</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM      	Param=value		</C>
		<C>Col=RADR			Ctrl=txtRADR	      	Param=value		</C>
		<C>Col=RADR_CT    	Ctrl=txtRADR_CT	     	Param=value		</C>
		<C>Col=RZI_NO		Ctrl=txtRZI_NO      	Param=value		</C>
		<C>Col=MADR			Ctrl=txtMADR	      	Param=value		</C>
		<C>Col=MADR_CT		Ctrl=txtMADR_CT	     	Param=value		</C>
		<C>Col=MZI_NO		Ctrl=txtMZI_NO	     	Param=value		</C>
		<C>Col=MOVE_YMD		Ctrl=txtMOVE_YMD     	Param=value		</C>
		<C>Col=COM_PHN_NO	Ctrl=txtCOM_PHN_NO     	Param=value		</C>
		<C>Col=HOM_PHN_NO	Ctrl=txtHOM_PHN_NO     	Param=value		</C>
		<C>Col=EM_PHN_NO	Ctrl=txtEM_PHN_NO   	Param=value		</C>
		<C>Col=APP_YMD		Ctrl=txtAPP_YMD	     	Param=value		</C>
		<C>Col=RAREA		Ctrl=txtRAREA	     	Param=value		</C>
		<C>Col=MAREA		Ctrl=txtMAREA	     	Param=value		</C>
		<C>Col=RAREA_NM		Ctrl=txtRAREA_NM     	Param=value		</C>
		<C>Col=MAREA_NM		Ctrl=txtMAREA_NM     	Param=value		</C>
		<C>Col=REMARK	    Ctrl=txtREMARK     	    Param=value		</C>
    '>
</object>