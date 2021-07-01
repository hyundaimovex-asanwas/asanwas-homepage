<!--
    ************************************************************************************
    * @Source         : loginPop.jsp 					                               *
    * @Description    : 사용자 비밀번호 변경                                           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/10  |  김경주   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>


<html>
<head>
<title>비밀번호 초기화(loginPop)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<link href="../../css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="../../common/common.js"></script>
<script language=javascript src="../../common/mdi_common.js"></script>
<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
<script language="javascript">

		var retObj = window.dialogArguments;




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

        if ( !fnc_SearchItemCheck() ) return;

			dsT_CM_PERSON.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;

			//트랜잭션 전송
			trT_CM_PERSON.KeyValue = "SAV(I:SAV=dsT_CM_PERSON)";
			trT_CM_PERSON.Action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_05";
			trT_CM_PERSON.Post();


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

	        if (dsT_CM_PERSON.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {



			if( document.getElementById("txtCET_NO").value == '') {
				alert("주민번호를 입력해주세요.");
				document.getElementById("txtCET_NO").focus();
				return false;
			}

			trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_05&ENO_NO="+document.getElementById("txtENO_NO").value+"&ENO_NM="+document.getElementById("txtENO_NM").value+"&CET_NO="+document.getElementById("txtCET_NO").value;
            trT_CM_PERSON.post();


            var Empty = dsT_CM_PERSON.CountRow;


			if( dsT_CM_PERSON.NameValue(1,"CET_NO") != document.getElementById("txtCET_NO").value) {
				alert("주민번호가 다릅니다. \n다시 입력해주세요.");
				document.getElementById("txtCET_NO").value='';
				document.getElementById("txtCET_NO").focus();
				return false;
			}


       if(Empty!= 0 && dsT_CM_PERSON.NameValue(1,"NAME") == document.getElementById("txtENO_NM").value && dsT_CM_PERSON.NameValue(1,"CET_NO") == document.getElementById("txtCET_NO").value && document.getElementById("txtEM_PHN_NO").value !='')
        {
              document.getElementById("layer_1").style.display='';
        }




			return true;

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

			//alert(retObj.ks_id);
            document.getElementById("txtENO_NO").innerText = retObj.ks_id;

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            
            //trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
 
            //trT_CM_PERSON.action = "/../../servlet/common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
            
			//gctr_code01.Action = "/servlet/pms.menu.ct.a010001_t1?";
            //trT_CM_PERSON.action = "../../servlets/common.ipcheck";			
            //trT_CM_PERSON.action = "../../servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;

           //trT_CM_PERSON.action = "../../servlets/common.groupware.GroupWareServlet?ENO_NO=hda1990098";

            //prompt(this, trT_CM_PERSON.action);   
            trT_CM_PERSON.action = "../../servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_06&ENO_NO="+document.getElementById("txtENO_NO").value;
            
            trT_CM_PERSON.post();
            //document.getElementById("txtENO_NM").innerText = dsT_CM_PERSON.NameValue(1,"CNT");
            document.getElementById("txtENO_NM").innerText = dsT_CM_PERSON.NameValue(1,"NAME");

			form1.txtCET_NO.focus();
        }


        /********************************************************
         * 기타함수                                             *
         *******************************************************/

         function fnc_Confirm(){

            trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
            trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=SHR_07&ENO_NO="+document.getElementById("txtENO_NO").value;
            trT_CM_PERSON.post();

			if( dsT_CM_PERSON.NameValue(1,"CET_NO") != document.getElementById("txtCET_NO").value) {
				alert("주민번호가 틀립니다.\n정확한 주민번호 13자리를 입력해주세요.");
				document.getElementById("txtCET_NO").value='';
				document.getElementById("txtCET_NO").focus();
			}else{
	    		 trT_CM_PERSON.KeyValue = "tr(O:dsT_CM_PERSON=dsT_CM_PERSON)";
	             trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=common.menu.login.cmd.LOGINCMD&S_MODE=UPT_06&ENO_NO="+document.getElementById("txtENO_NO").value;
	             trT_CM_PERSON.post();
	             alert("비밀번호가 주민번호 뒤 7자리로 초기화 되었습니다.");
	             window.close();
	    		 return false;

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

<!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>



<!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->

    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_CM_EMPLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


<!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->



<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
<Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

<Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

<!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
<Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

<Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

<!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
<script for=trT_CM_PERSON event="OnSuccess()">

        if(trT_CM_PERSON.KeyValue.substring(0,3) == "SHR_05"){
			alert('본인이 확인되었습니다.');
			window.close();
		}

    </script>

<!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
<script for=trT_CM_PERSON event="OnFail()">

        alert(trT_CM_PERSON.ErrorMsg);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15"
	marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"
	onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none"><iframe
	name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0"
	src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%"
	scrolling="no"></iframe></div>

<!-- form 시작 -->
<form name="form1">
<table width="300" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif"><!-- 타이틀 바 테이블 시작 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
				<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">비밀번호 초기화</td>
			</tr>
		</table>
		<!-- 타이틀 바 테이블 끝 --></td>
	</tr>
	<tr>
		<!-- 버튼 -->
		<td height="35" align="right" class="paddingTop5">
		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_ConfirmOver.gif',1)">
		<img src="../../images/button/btn_ConfirmOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>

		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExitOver.gif',1)">
		<img src="../../images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>

		</td>
	</tr>
	<tr>
		<td height="125"><!--개인정보테이블 끝 -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="400" align="center" valign="middle">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="hrWtable" style="padding:0 26 0 14">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="74" style="padding:0 19 0 0"><img
									src="../../images/specialHr/iconPc.gif"></td>
								<td>
                            	<table width="300" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> 사 &nbsp 번
										</td>
										<td>
										<input type="text"	 id=txtENO_NO value="" size="20" maxlength=10 style="ime-mode:disabled" class="divInput">
										</td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> 이 &nbsp 름
										</td>
										<td>
										<input type="text"	 id=txtENO_NM value="" size="20" maxlength=10 style="ime-mode:auto" class="divInput">
										</td>
									</tr>
									<tr>
										<td height="27" class="hrTextGreen" style="padding-top:5px;padding-bottom:10px;">
										<img src="../../images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle"> 주민번호
										</td>
										<td>
										    <input type="text"	id=txtCET_NO value="" size="20" maxlength=14
									          style="ime-mode:disabled" class="divInput" onKeyPress="JavaScript: cfCetNoHyphen(this);">
									    </td>
								    	</tr>
          						</table>
	    					</td>
		    			</tr>
			    	</table>
			   	</td>
			 </tr>
		 </table>


		<!--개인정보테이블 끝 -->
		</td>
	</tr>
</table>
</form>
</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->

<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=EM_PHN_NO           Ctrl=txtEM_PHN_NO              Param=value     </C>
        <C>Col=SMS_NUMBER          Ctrl=txtSMS_NUMBER             Param=value     </C>

    '>
</object>


