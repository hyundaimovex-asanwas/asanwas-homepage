<!--
    ************************************************************************************
    * @Source         : chgpwd.jsp 					                                 *
    * @Description    : 사용자 비밀번호 변경.           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/10  |  안준성   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>사용자 비밀번호 변경(chgpwd)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'F' + 'F' + 'T' + 'F' + 'F' + 'F' + 'F' + 'T';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //기존비밀번호 조회
            trT_CM_EMPLIST.KeyValue = "SHR(O:dsT_CM_EMPLIST=dsT_CM_EMPLIST)";
            trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=SHR&txtENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_EMPLIST.Post();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if( !fnc_SaveItemCheck() ) return;

            //
            if (confirm("비밀번호를 변경 하시겠습니까?") == false) return;

			dsT_CM_EMPLIST.NameValue(1,"PWD_NO") = document.getElementById("txtNEW_PWD_NO").value;

			//트랜잭션 전송
			trT_CM_EMPLIST.KeyValue = "SAV(I:SAV=dsT_CM_EMPLIST)";
			trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=SAV";
			trT_CM_EMPLIST.Post();

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
        function fnc_AddNew(p_gbn) {

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

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_CM_EMPLIST.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

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

			if( document.getElementById("txtPWD_NO").value == '') {
				alert("기존비밀번호를 입력해주세요.");
				document.getElementById("txtPWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value == '') {
				alert("신규비밀번호를 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value.length < 6) {
				alert("숫자,영문 6자 이상~10자 이하로 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			if( document.getElementById("txtNEW_PWD_NO").value.length > 15) {
				alert("숫자,영문 6자 이상~15자 이하로 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			var filterA = /[a-z]/i;
			var filter9 = /[0-9]/;
			var filterY = /[!@$%^*()_|<>?~]/;
			var filterN = /[#&+]/;

			var tagA = false;
			var tag9 = false;
			var tagY = false;
			var tagN = false;

			//alert(document.getElementById("txtNEW_PWD_NO").value);

			if (filterN.test(document.getElementById("txtNEW_PWD_NO").value) == true) {
				alert("기호중 #,&,+ 는 제외하여 주시기 바랍니다");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;	}


			if (filterA.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tagA = true;	}
			if (filter9.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tag9 = true;	}
			if (filterY.test(document.getElementById("txtNEW_PWD_NO").value) == true) {	 tagY = true;	}


			if (!(tagA && tag9 && tagY)) {
				alert("영문,숫자, 특수문자 조합하여 6자 이상~15자 이하로 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

			if( document.getElementById("txtCHECK_PWD_NO").value == '') {
				alert("비밀번호확인을 해주세요.");
				document.getElementById("txtCHECK_PWD_NO").focus();
				return false;
			}
			if( document.getElementById("txtNEW_PWD_NO").value != document.getElementById("txtCHECK_PWD_NO").value ) {
				alert("신규비밀번호와 확인비밀번호가 서로 다릅니다. \n다시 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}

            trT_CM_EMPLIST.KeyValue = "SHR(O:dsT_CM_EMPLIST_01=dsT_CM_EMPLIST_01)";
            trT_CM_EMPLIST.Action = "/servlet/GauceChannelSVL?cmd=common.popup.chgpwd.cmd.CHGPWDCMD&S_MODE=CHG&PWD_NO="+document.getElementById("txtPWD_NO").value+"&NEW_PWD_NO="+document.getElementById("txtNEW_PWD_NO").value;
            trT_CM_EMPLIST.Post();

            var PWD_NO = dsT_CM_EMPLIST_01.NameValue(1,"PWD_NO");
            var NEW_PWD_NO = dsT_CM_EMPLIST_01.NameValue(1,"NEW_PWD_NO");

			if( dsT_CM_EMPLIST.NameValue(1,"PWD_NO") != PWD_NO ) {
				
				alert("기존비밀번호가 다릅니다. \n다시 입력해주세요.");
				document.getElementById("txtPWD_NO").value='';
				document.getElementById("txtPWD_NO").focus();
				return false;
			}
			if( dsT_CM_EMPLIST.NameValue(1,"PWD_NO") == NEW_PWD_NO ) {
				alert("기존비밀번호와 같습니다. \n다시 입력해주세요.");
				document.getElementById("txtNEW_PWD_NO").value='';
				document.getElementById("txtCHECK_PWD_NO").value='';
				document.getElementById("txtNEW_PWD_NO").focus();
				return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			fnc_SearchItem();
			form1.txtPWD_NO.focus();

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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

    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("기존비밀번호가 없습니다.");

        } else {
            //alert(dsT_CM_EMPLIST.ExportData(1, dsT_CM_EMPLIST.CountRow, true));
        }

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

        } else {

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_CM_EMPLIST_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_EMPLIST event="OnSuccess()">

        if(trT_CM_EMPLIST.KeyValue.substring(0,3) == "SAV"){
			alert('비밀번호가 변경되었습니다.');
			window.close();
		}

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_EMPLIST event="OnFail()">

        alert(trT_CM_EMPLIST.ErrorMsg);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 켈린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
		<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

<!-- form 시작 -->
<form name="form1">
<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <!-- 타이틀 바 테이블 시작 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사용자 비밀번호 변경</td>
        </tr>
      </table>
      <!-- 타이틀 바 테이블 끝 -->
    </td>
  </tr>
  <tr>
    <!-- 버튼 -->
    <td height="35" align="right" class="paddingTop5">
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
	</td>
  </tr>
  <tr>
    <td height="125">
      <!--개인정보테이블 끝 -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="400" align="center" valign="middle">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="hrWtable" style="padding:0 26 0 14">
					<table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="74" style="padding:0 19 0 0"><img src="/images/specialHr/inputImg3.gif"></td>
                      <td>
                      <table width="400" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:10px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								사번 <font color="#525450"><%=box.get("SESSION_ENONO") %></font>
								<input type=hidden id=txtENO_NO value="<%=box.get("SESSION_ENONO") %>" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="inputDisabled" disabled>
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								성명 <font color="#525450"><%=box.get("SESSION_ENONM") %></font>
								<input type="hidden" id=txtENO_NM value="<%=box.get("SESSION_ENONM") %>" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="inputDisabled" disabled>
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								현재비밀번호
								<input type=password id=txtPWD_NO value="" size="20" maxlength=20 style="ime-mode:disabled" class="divInput">
                            </td>
                          </tr>
                          <tr>
                            <td height="1" background="/images/specialHr/dot.gif"></td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								신규비밀번호
								<input type=password id=txtNEW_PWD_NO valid="key=true;type=eng" value="" size="30" maxlength=20 style="ime-mode:disabled" class="divInput">

                            </td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextGreen" style="padding-top:5px;padding-bottom:10px;">
								<img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
								비밀번호확인
								<input type=password id=txtCHECK_PWD_NO valid="key=true;type=eng" value="" size="30" maxlength=20 style="ime-mode:disabled" class="divInput">
                            </td>
                          </tr>
                          <tr>
                            <td height="27" class="hrTextBLUE" style="padding-top:5px;padding-bottom:10px;">
                            <font color="blue">가능한 특수기호 ! @ $ % ^ * ( ) _ | ? ~</font><BR>
                            <font color="red">불가능한 특수기호 # & +</font>
                            </td>
                          </tr>
                        </table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
            </table> </td>
        </tr>
      </table>
      <!--개인정보테이블 끝 -->
    </td>
  </tr>
</table>
</form>
</body>
</html>