	<!--*************************************************************************
	* @source      : taxa170.jsp												*
	* @description : 퇴직소득원천징수영수증
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/04/11          방석호             	최초작성										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>퇴직소득원천징수영수증 (taxa170)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
        var year = getToday().substring(0,7);
        var bal_date = getToday().substring(0,10);

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {


        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
			var PIS_YM   = document.getElementById("txtPIS_YY_SHR").value;
			var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var SEQ      = document.getElementById("cmbSEQ").value;
            var STP_GBN  = fnc_GetCheckedValue("rdoSTP_GBN");
            var PRT_GBN  = fnc_GetCheckedValue("rdoPRT_GBN");

			if(!fnc_SearchItemCheck()) return;//필수 조회조건 체크

			var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+PIS_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&SEQ="+SEQ
                    + "&STP_GBN="+STP_GBN
                    + "&PRT_GBN="+PRT_GBN;

			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;


        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
			document.getElementById("txtPIS_YY_SHR").value      = year;
			document.getElementById("txtENO_NO_SHR").value      = "";
            document.getElementById("txtENO_NM_SHR").value      = "";
            document.getElementById("txtSTR_YMD_SHR").value     = bal_date;
       		document.getElementById("cmbSEQ").value = "0";//일련번호

            document.getElementsByName("rdoSTP_GBN")[0].checked = true;
            document.getElementsByName("rdoPRT_GBN")[0].checked = true;

        	document.getElementById("resultMessage").innerText = ' ';
       }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
       		if( document.form1.txtPIS_YY_SHR.value=="" ){
       			alert("기준년도를 입력하십시오.");
       			document.form1.txtPIS_YY_SHR.focus();
        		return false;
        	}
       		if( document.form1.txtENO_NO_SHR.value=="" ){
       			alert("사원번호를 입력하십시오.");
       			document.form1.txtENO_NO_SHR.focus();
        		return false;
        	}
        	return true;
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//이곳에 해당 코딩을 입력 하세요
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	document.form1.txtPIS_YY_SHR.value = year;
		    document.form1.txtSTR_YMD_SHR.value = bal_date;
	     }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}

    /********************************************
    * 날짜 형식 유효성 체크                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        function fnc_RetState() {
  			var pro_ym = document.getElementById('txtPIS_YY_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;

			dsT_CM_RETSTATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa170.cmd.TAXA170CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PRO_YM="+pro_ym.replace("-","");
    		dsT_CM_RETSTATE.reset();
         }


    </script>
</head>

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_CM_UPRQST)   |
    | 3. 사용되는 Table List(T_CM_UPRQST)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_RETSTATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->
   <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_RETSTATE Event="OnLoadCompleted(iCount)">
       document.getElementById("cmbSEQ").value = dsT_CM_RETSTATE.NameValue(1,'SEQ');

    </Script>

   <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_RETSTATE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=For=dsT_CM_RETSTATE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		//Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>




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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">퇴직소득원천징수영수증 </td>
					<td align="right" class="navigator">HOME/정산세무/정산세무/<font color="#000000">소득증명원출력 - 퇴직소득원천징수영수증
</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td class="searchState" align="right">정산년월&nbsp;</td>
                    <td class="padding2423" align="left" colspan="0">
                        <table height="19" cellspacing="0" cellpadding="0" width="30%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfNumberCheck();">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyymm', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyymm', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="searchState">구 분</td>
					<td>
						<select id="cmbSEQ" style="width:100">
							<option value="0" >퇴직</option>
							<option value="1" >중간정산1차</option>
	                        <option value="2" >중간정산2차</option>
	                        <option value="3" >중간정산3차</option>
				    	</select>
					</td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">사원번호&nbsp;</td>
                    <td class="padding2423" align="left" colspan="3">
                        <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) {fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();}" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">발급일자&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '시작일');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','100','185');"></a>
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">발행구분&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="1" checked>&nbsp;소득자보관용
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="2">&nbsp;발행자보고용
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="3">&nbsp;발행자보관용
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">직인여부&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="1" checked>&nbsp;직인출력
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="2">&nbsp;직인생략
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



	</form>
	<!-- form 끝 -->

</body>
</html>

<!-- 개인정보 수정요청 테이블 -->
<object id="bndT_CM_RETSTATET" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_RETSTATE">
    <Param Name="BindInfo", Value='
        <C> Col=SEQ       Ctrl=txtSEQ       Param=value   Disable=disabled </C>
    '>
</object>

