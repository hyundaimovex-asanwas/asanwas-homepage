<!--
***********************************************************************
* @source      : wela020.jsp
* @description : 이주비 신청처리 PAGE
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
<title>이주비 신청처리(wela020)</title>
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

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
            var app_sts = document.getElementById("cmbAPP_STS_SHR").value;

			dsT_WL_MOVEAPPLY.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela020.cmd.WELA020CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&APP_STS="+app_sts;
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
				trT_WL_MOVEAPPLY.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela020.cmd.WELA020CMD&S_MODE=SAV";
				trT_WL_MOVEAPPLY.post();

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

			//이곳에 해당 코딩을 입력 하세요

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

        //Dataset관련 Error 처리
        cfErrorMsg(this);

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">이주비 신청처리</td>
					<td align="right" class="navigator">HOME/복리후생/이주비/<font color="#000000">이주비 신청처리</font></td>
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
			<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
                                    <col width="220"></col>
                                    <col width="100"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">등록일자&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','45','243');"></a> ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','165','243');"></a>
                                </td>
                                <td align="right" class="searchState">신청상태&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbAPP_STS_SHR" name="cmbAPP_STS">
                                        <option value="">전체</option>
                                        <option value="0">신청</option>
                                        <option value="1">접수</option>
                                        <option value="2">반송</option>
                                        <option value="3">결재</option>
                                    </select>
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
					<col width="100"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">소 속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직 위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="23" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">사 번</td>
					<td class="padding2423"><input id="txtENO_NO" size="18" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">성 명</td>
					<td class="padding2423"><input id="txtENO_NM" size="18" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">현주소</td>
					<td class="padding2423" colspan="7">
						<input id="txtRZI_NO" size="10" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup_wel('txtRZI_NO','txtRADR','RPLACE')"></a>
						<input id="txtRADR" style="width:281" class="input_ReadOnly" readonly>
						<input id="txtRADR_CT" style="width:330" maxlength="60" onKeyUp="fc_chk_byte(this,60)">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">이주주소</td>
					<td class="padding2423" colspan="7">
						<input id="txtMZI_NO" size="10" class="input_ReadOnly" readonly maxlength="7">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_postPopup_wel('txtMZI_NO','txtMADR','MPLACE')"></a>
						<input id="txtMADR" style="width:281" class="input_ReadOnly" readonly>
						<input id="txtMADR_CT" style="width:330" maxlength="60" onKeyUp="fc_chk_byte(this,60)">
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">이주일자</td>
					<td class="padding2423"><input id="txtMOVE_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMOVE_YMD','','13','175');"></a></td>
					<td align="center" class="creamBold">사무실</td>
					<td class="padding2423"><input id="txtCOM_PHN_NO" size="23" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">자택</td>
					<td class="padding2423"><input id="txtHOM_PHN_NO" size="18" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">휴대폰</td>
					<td class="padding2423"><input id="txtEM_PHN_NO" size="18" maxlength="13" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">인사발령일</td>
					<td class="padding2423"><input id="txtAPP_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_YMD','','13','198');"></a></td>
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
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtRAREA','txtRAREA_NM','부서','DEPT')"></a>
                    </td>
					<td align="center" class="creamBold">발령後<br>근무지</td>
					<td class="padding2423">
                        <input id="txtMAREA" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtMAREA','txtMAREA_NM')">
                        <input id="txtMAREA_NM" size="7" maxlength="10" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtMAREA','txtMAREA_NM','부서','DEPT')"></a>
                    </td>
				</tr>
				<tr>
					<td align="center" class="creamBold">소요비용</td>
					<td class="padding2423">
                        <comment id="__NSID__">
                        <object id="medMOVE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object>
                        </comment>
                        <script> __ShowEmbedObject(__NSID__); </script>
                    </td>
					<td align="center" class="creamBold">신청단계</td>
					<td class="padding2423" colspan="5">
                        <select id="cmbAPP_STS" name="cmbAPP_STS">
                            <option value="0">신청</option>
                            <option value="1">접수</option>
                            <option value="2">반송</option>
                            <option value="3">결재</option>
                        </select>
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
						<object	id="grdT_WL_MOVEAPPLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
							<param name="DataID"					value="dsT_WL_MOVEAPPLY">
							<param name="Format"					value="
								<C> id={currow}		width=35    name='NO'			align=center </C>
								<C> id='DPT_NM'		width=80	name='소속'			align=left </C>
								<C> id='JOB_NM'		width=70	name='직위'			align=left </C>
								<C> id='ENO_NM'		width=60	name='성명'			align=center </C>
								<C> id='ENO_NO'		width=60	name='사번'			align=center </C>
								<C> id='MOVE_YMD'	width=70	name='이주일자'		align=center </C>
								<C> id='APP_YMD'	width=70	name='인사발령일'	align=center </C>
								<C> id='RPLACE'		width=95	name='출발지'		align=left </C>
								<C> id='MPLACE'		width=95	name='도착지'		align=left </C>
								<C> id='MOVE_AMT'	width=70	name='지원금액'		align=right </C>
								<C> id='REMARK'		width=300	name='비고'			align=left </C>
                                <C> id='APP_STS_NM' width=70    name='신청현황'         align=center </C>
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
		<C>Col=ENO_NM		Ctrl=txtENO_NM	      	Param=value		</C>
		<C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		</C>
		<C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM	      	Param=value		</C>
		<C>Col=RADR			Ctrl=txtRADR	      	Param=value		</C>
		<C>Col=RADR_CT    	Ctrl=txtRADR_CT	     	Param=value		Disable=disabled</C>
		<C>Col=RZI_NO		Ctrl=txtRZI_NO      	Param=value		</C>
		<C>Col=MADR			Ctrl=txtMADR	      	Param=value		</C>
		<C>Col=MADR_CT		Ctrl=txtMADR_CT	     	Param=value		Disable=disabled</C>
		<C>Col=MZI_NO		Ctrl=txtMZI_NO	     	Param=value		</C>
		<C>Col=MOVE_YMD		Ctrl=txtMOVE_YMD     	Param=value		Disable=disabled</C>
		<C>Col=COM_PHN_NO	Ctrl=txtCOM_PHN_NO     	Param=value		Disable=disabled</C>
		<C>Col=HOM_PHN_NO	Ctrl=txtHOM_PHN_NO     	Param=value		Disable=disabled</C>
		<C>Col=EM_PHN_NO	Ctrl=txtEM_PHN_NO   	Param=value		Disable=disabled</C>
		<C>Col=APP_YMD		Ctrl=txtAPP_YMD	     	Param=value		Disable=disabled</C>
		<C>Col=RAREA		Ctrl=txtRAREA	     	Param=value		Disable=disabled</C>
		<C>Col=MAREA		Ctrl=txtMAREA	     	Param=value		Disable=disabled</C>
		<C>Col=RAREA_NM	    Ctrl=txtRAREA_NM     	Param=value		Disable=disabled</C>
		<C>Col=MAREA_NM	    Ctrl=txtMAREA_NM     	Param=value		Disable=disabled</C>
		<C>Col=MOVE_AMT		Ctrl=medMOVE_AMT     	Param=Text		Disable=disabled</C>
		<C>Col=APP_STS		Ctrl=cmbAPP_STS     	Param=value		Disable=disabled</C>
    '>
</object>